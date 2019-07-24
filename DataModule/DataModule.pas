unit DataModule;

interface

uses
  SysUtils, Classes, DB, IniFiles, Windows, Controls, Forms, Dialogs,
  IBX.IBCustomDataSet, IBX.IBQuery, IBX.IBDatabase, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, IBX.IBScript, System.Net.HTTPClient, System.StrUtils,
  ShellApi, System.Variants, ShlObj, System.IOUtils, IBX.IBTable;

type

  TDM = class(TDataModule)
    BaseDatos: TIBDatabase;
    Transaccion: TIBTransaction;
    ConfigQuery: TIBQuery;
    Query: TIBQuery;
    Consulta: TIBScript;
    FDConnection1: TFDConnection;
    OpenDialog1: TOpenDialog;
    IBScript1: TIBScript;
    FDTable1: TFDTable;
    FDQuery1: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
    function ObtenerConfig(campo:string):Variant;
    procedure LeerINI;
    procedure EscribirINI;
  private
    { Private declarations }
    bd, ejecutable : string;
    procedure ActualizarImprimir(reporte:string);
    procedure ActualizarBase;
    function ExisteEnTabla(TB_NAME, FLD_NAME: string):Boolean;
    procedure ActualizarTabla(TB_NAME, FLD_NAME, TYP_NAME: string);
    procedure CrearTabla(TB_NAME, FLD_NAME, TYP_NAME: string);
    procedure ActualizarIVA(CODIGO, TASA: string);
    procedure GetBuildInfo;//(V1, V2, V3, V4: Word);
    procedure CrearTable(nombre: string);
    procedure IniciarModificacionTabla(nombreTabla:string);
    procedure AgregarCampoModificacionTabla(nombreCampo: string;tipo: TFieldType;tamaño: Integer);
    procedure TerminarModificacionTabla;
    procedure ObtenerSO;
    procedure ActualizarVersion;
    function EsMismaVersion:Boolean;
    procedure CrearCbtetipo;
  public
  const
    NumThreads: Integer = 4;
  public
    { Public declarations }
    Unidad: string;
    // Gratis:boolean;
    IniFile: TIniFile;
    V1,       // Major Version
    V2,       // Minor Version
    V3,       // Release
    V4: Word; // Build Number
    procedure connection;
    procedure chequeo;
    procedure TraerUsuario;
    procedure TraerConfig;
    procedure DejarUsuario;
    procedure VaciarBase;
    procedure Ejecutar(dir:string);
    function ExecuteProcess(ProcessName, Path: String): Cardinal;
    function Descargar(FURL,FFileName:string):string;
    function TextoAfecha(StrDate : string):TDateTime;
    function ReadTextFile(FileName : String):string;
    function UltimoRegistro(T, c: String): integer;
    { function Gratis(arch: String): boolean; }
    procedure FormatearFecha;
    function existeOpenSSL():boolean;
    function TraerTipoCbte(tipo:string):string;
    function TraerValor(tabla, campo, codigo: string):string;
    function TraerValor2(tabla, campo, codigo, cam2, cod2: string):Double;
    procedure AgregarValor(tabla, campo, valor: string);
    procedure ActualizarValor(tabla, campo, codigo, valor: string);
    procedure EnviarEmail(email,asunto,cuerpo,adjunto: String);
    function ExisteThunderbird():boolean;
    function CopyDir(const Source, Target: string): Boolean;
    function Actualizar:Boolean;
  end;

const
  v: array [0 .. 22] of string = ('MenuExpress', 'MenuStock', 'Articulos',
    'VaciarBase', 'Vender', 'Comprar', 'AnularVenta', 'RetiroCaja', 'Rubro',
    'Categoria', 'SubCategoria', 'Stock', 'CajaL', 'GananciaXvta', 'PreciosL',
    'ClientesL', 'CompraL', 'VentaL', 'Empresa', 'Configuracion', 'Backup',
    'Migrar', 'Licencia');
  version='201907131358';

type
  TCompartido = record
    Numero: Integer;
    Cadena: String[20];
  end;

  PCompartido = ^TCompartido;

var
  DM: TDM;
  Compartido: PCompartido;
  FicheroM: THandle;
  Usuario, Licencia, U, Path, Oculto, Control, Maquina, Fecha, Empresa,
  PuntoVenta, Titular, CUIT, IngresosBrutos, reporte, catIVA: string;
  Permiso: Integer;
  LoginOK, Cancelar, envEmail, microsoftStore: boolean;
  detalle, memo, BasedeDatos, mode: string; // revisar
  webUrl, webRes, webUsr, webPsw, webUpd,
  afipUrl, afipRes, afipUsr, afipPsw,
  operNC, openSSl,
  NroA, NroNCA, NroB, NroNCB, NroC, NroNCC,
  thunderbird : string;
  Precio1, Precio2, Precio3, Precio4, Precio5, Precio6, PrecioCtaCte: Double;

implementation

{$R *.dfm}
{ function TDM.Gratis;
  var
  i: Integer;
  a: string;
  begin
  for i := 0 to High(v) do
  begin
  a := v[i] + '.exe';
  if arch = a then
  begin
  Result := True;
  Exit;
  end;
  end;
  Result := False; // ?
  end; }

function TDM.ExecuteProcess;
var
  StartInfo: TStartupInfo;
  ProcInfo: TProcessInformation;

begin
  Result := 0;

  FillChar(StartInfo, SizeOf(StartInfo), 0);
  StartInfo.cb := SizeOf(StartInfo);

  if CreateProcess(PChar(ProcessName), nil, nil, nil, False, 0, nil,
    PChar(Path), StartInfo, ProcInfo) then
    Result := ProcInfo.hProcess;
end;

function GetVolumeID(DriveChar: string): String;
var
  MaxFileNameLength, VolFlags, SerNum: DWord;
begin
  if GetVolumeInformation(PChar(DriveChar + '\'), nil, 0, // ':\'), nil, 0,
    @SerNum, MaxFileNameLength, VolFlags, nil, 0) then
  begin
    Result := IntToHex(SerNum, 8);
    Insert('-', Result, 5);
  end
  else
    Result := '';
end;

procedure TDM.DejarUsuario;
begin
  if (Transaccion.Params.Text <> 'read') and (Transaccion.Params.Text <> '')
  then
  begin
    TraerUsuario;
    if Control <> '' then
    begin
      Query.SQL.Text := 'update "Control" set MAQUINA=' + QuotedStr(Maquina) +
        ' where CODIGO=' + Control;
      Query.ExecSQL;
      Query.Transaction.Commit;
    end;
  end;
end;

procedure TDM.TraerUsuario;
begin
  Query.SQL.Text := 'select max(CODIGO) from "Control" where Maquina=' +
    QuotedStr(Maquina);
  Query.Open;
  Control := Query.Fields[0].AsString;
  if Control <> '' then
  begin
    Query.SQL.Text := 'select * from "Control" where CODIGO=' + Control;
    Query.Open;
    Usuario := Query.FieldByName('USUARIO').AsString;
    Query.SQL.Text := 'select PERMISO from "Usuario" where Codigo=' + Usuario;
    Query.Open;
    Permiso := Query.FieldByName('PERMISO').AsInteger;;
  end;
end;

procedure TDM.TraerConfig;
begin
  if (ConfigQuery.Active) then ConfigQuery.Close;
{
SELECT
	"Config".CODIGO, "Config".NROFACTURA, "Config"."FechaInicio", "Config".PP1, "Config".PP2, "Config".PP3, "Config".PP4, "Config".PP5, "Config".PP6, "Config".PP7, "Config".PP8, "Config".PP9, "Config".PP, "Config"."CtaCompra", "Config"."CtaMercaderia", "Config"."CtaIIBB", "Config"."CtaImpuesto", "Config"."CtaDeudor", "Config"."CtaVenta", "Config"."CtaCaja", "Config"."CtaAnticipoAProveedor", "Config"."CtaBanco", "Config"."CtaCMV", "Config"."CtaComisionVendedor", "Config"."CtaComisionVendedorAPagar", "Config"."CtaDeudorEnGestionJudicial", "Config"."CtaDeudorIncobrable", "Config"."CtaDeudorMoroso", "Config"."CtaDeudorPorVenta", "Config"."CtaDocumentoACobrar", "Config"."CtaHonorarioLegal", "Config"."CtaHonorarioLegalApagar", "Config"."CtaIVARemanente", "Config"."CtaIVAAPagar", "Config"."CtaIVACreditoFiscal", "Config"."CtaIVADebitoFiscal", "Config"."CtaLiquidacionDeIVA", "Config"."CtaMerRecJudicialmente", "Config"."CtaMercaderiaDeReventa", "Config"."CtaObligacionAPagar", "Config"."CtaPagoDeHonorario", "Config"."CtaTarjetaDeCredito", "Config"."CtaProveedor", "Config"."CtaRecuperoJudicial", "Config"."CtaServicioAPAgar", "Config"."CtaServicio", "Config"."CtaValorAlCobro", "Config"."CtaValorADepositar", "Config"."Cuenta", "Config"."Precio", "Config"."Comprobante", "Config"."Empresa", "Config"."ImprimirTipo", "Config"."Imprimir", "Config"."ImprimirFiscal", "Config"."ImprimirMostrar", "Config"."CodigoBarra", "Config"."GesCobTemprana", "Config"."GesCobExtraJudicial", "Config"."GesCobJudicial", "Config".CMV, "Config".CTACAPITALSOC,
  	"Empresa".CODIGO AS PtoVta, "Empresa".NOMBRE, "Empresa".TITULAR, "Empresa".DIRECCION, "Empresa".DIRECCIONCOMERCIAL, "Empresa".PAIS, "Empresa".PROVINCIA, "Empresa".DEPARTAMENTO, "Empresa".CIUDAD, "Empresa".CP, "Empresa".CODIGOAREA, "Empresa".CELULAR, "Empresa".TELEFONO, "Empresa".FAX, "Empresa".EMAIL, "Empresa".SUSPENDIDO, "Empresa".EXCENTO, "Empresa".FECHA, "Empresa".LIMITECREDITO, "Empresa".DIASCREDITO, "Empresa".DOCUMENTO, "Empresa".RAZONSOCIAL, "Empresa".CUIT, "Empresa".IIBB, "Empresa".RUBRO, "Empresa".IVA, "Empresa".MSN, "Empresa".WEB, "Empresa".ZONA, "Empresa".CTA, "Empresa".CTANOMBRE, "Empresa".CTATIPO, "Empresa".CTAANTICIPO, "Empresa".PAGARE,
  	"Imprimir".DESCRIPCION, "Imprimir".REPORTE
FROM "Config"
 INNER JOIN "Imprimir" ON ("Config"."ImprimirTipo" = "Imprimir".CODIGO)
 INNER JOIN "Empresa" ON ("Config"."Empresa" = "Empresa".CODIGO)
}
//  ConfigQuery.SQL.Text := 'SELECT * FROM "Config"' +
//    ' INNER JOIN "Imprimir" ON ("Config"."ImprimirTipo" = "Imprimir".CODIGO)' +
//    ' INNER JOIN "Empresa" ON ("Config"."Empresa" = "Empresa".CODIGO)';

ConfigQuery.SQL.Text := 'SELECT '
+'"Config".CODIGO, "Config".NROFACTURA, "Config"."FechaInicio", "Config".PP1, '
+'"Config".PP2, "Config".PP3, "Config".PP4, "Config".PP5, "Config".PP6, '
+'"Config".PP7, "Config".PP8, "Config".PP9, "Config".PP, "Config"."CtaCompra", '
+'"Config"."CtaMercaderia", "Config"."CtaIIBB", "Config"."CtaImpuesto", '
+'"Config"."CtaDeudor", "Config"."CtaVenta", "Config"."CtaCaja", '
+'"Config"."CtaAnticipoAProveedor", "Config"."CtaBanco", "Config"."CtaCMV", '
+'"Config"."CtaComisionVendedor", "Config"."CtaComisionVendedorAPagar", '
+'"Config"."CtaDeudorEnGestionJudicial", "Config"."CtaDeudorIncobrable", '
+'"Config"."CtaDeudorMoroso", "Config"."CtaDeudorPorVenta", '
+'"Config"."CtaDocumentoACobrar", "Config"."CtaHonorarioLegal", '
+'"Config"."CtaHonorarioLegalApagar", "Config"."CtaIVARemanente", '
+'"Config"."CtaIVAAPagar", "Config"."CtaIVACreditoFiscal", '
+'"Config"."CtaIVADebitoFiscal", "Config"."CtaLiquidacionDeIVA", '
+'"Config"."CtaMerRecJudicialmente", "Config"."CtaMercaderiaDeReventa", '
+'"Config"."CtaObligacionAPagar", "Config"."CtaPagoDeHonorario", '
+'"Config"."CtaTarjetaDeCredito", "Config"."CtaProveedor", '
+'"Config"."CtaRecuperoJudicial", "Config"."CtaServicioAPAgar", '
+'"Config"."CtaServicio", "Config"."CtaValorAlCobro", '
+'"Config"."CtaValorADepositar", "Config"."Cuenta", "Config"."Precio", '
+'"Config"."Comprobante", "Config"."Empresa", "Config"."ImprimirTipo", '
+'"Config"."Imprimir", "Config"."ImprimirFiscal", "Config"."ImprimirMostrar", '
+'"Config"."CodigoBarra", "Config"."GesCobTemprana", '
+'"Config"."GesCobExtraJudicial", "Config"."GesCobJudicial", "Config".CMV, '
+'"Config".CTACAPITALSOC, '
+'"Empresa".CODIGO AS PtoVta, "Empresa".NOMBRE, "Empresa".TITULAR, '
+'"Empresa".DIRECCION, "Empresa".DIRECCIONCOMERCIAL, "Empresa".PAIS, '
+'"Empresa".PROVINCIA, "Empresa".DEPARTAMENTO, "Empresa".CIUDAD, "Empresa".CP, '
+'"Empresa".CODIGOAREA, "Empresa".CELULAR, "Empresa".TELEFONO, "Empresa".FAX, '
+'"Empresa".EMAIL, "Empresa".SUSPENDIDO, "Empresa".EXCENTO, "Empresa".FECHA, '
+'"Empresa".LIMITECREDITO, "Empresa".DIASCREDITO, "Empresa".DOCUMENTO, '
+'"Empresa".RAZONSOCIAL, "Empresa".CUIT, "Empresa".IIBB, "Empresa".RUBRO, '
+'"Empresa".IVA, "Empresa".MSN, "Empresa".WEB, "Empresa".ZONA, "Empresa".CTA, '
+'"Empresa".CTANOMBRE, "Empresa".CTATIPO, "Empresa".CTAANTICIPO, "Empresa".PAGARE, '
+'"Imprimir".DESCRIPCION, "Imprimir".REPORTE '
+'FROM "Config" '
+' INNER JOIN "Imprimir" ON ("Config"."ImprimirTipo" = "Imprimir".CODIGO) '
+' INNER JOIN "Empresa" ON ("Config"."Empresa" = "Empresa".CODIGO) ';
  ConfigQuery.Open;
  Empresa := ConfigQuery.FieldByName('NOMBRE').AsString;
  PuntoVenta := ConfigQuery.FieldByName('PtoVta').AsString;
  Titular := ConfigQuery.FieldByName('TITULAR').AsString;
  Fecha := FormatDateTime('mm/dd/yyyy hh:mm:ss', now);
  CUIT := ConfigQuery.FieldByName('CUIT').AsString;
  reporte := ConfigQuery.FieldByName('Reporte').AsString;
  IngresosBrutos := ConfigQuery.FieldByName('IIBB').AsString;
  if IngresosBrutos='' then IngresosBrutos:='0';
  catIVA := dm.ConfigQuery.FieldByName('IVA').AsString;
  Precio1 := ConfigQuery.FieldByName('PP1').AsFloat / 100 + 1;
  Precio2 := ConfigQuery.FieldByName('PP2').AsFloat / 100 + 1;
  Precio3 := ConfigQuery.FieldByName('PP3').AsFloat / 100 + 1;
  Precio4 := ConfigQuery.FieldByName('PP4').AsFloat / 100 + 1;
  Precio5 := ConfigQuery.FieldByName('PP5').AsFloat / 100 + 1;
  Precio6 := ConfigQuery.FieldByName('PP6').AsFloat / 100 + 1;
  PrecioCtaCte := ConfigQuery.FieldByName('PP').AsFloat / 100 + 1;
end;

procedure TDM.chequeo;
// var
// L: ShortString;
begin
  {
    //++CHEQUEO
    //Miramos si existe el fichero
    FicheroM:=OpenFileMapping(FILE_MAP_READ,False,'DeG');
    //Si no existe, Error
    if (FicheroM=0) then FicheroM:=OpenFileMapping(FILE_MAP_READ,False,'StO') else
    if (FicheroM=0) then FicheroM:=OpenFileMapping(FILE_MAP_READ,False,'DeG') else
    if (FicheroM=0) then FicheroM:=OpenFileMapping(FILE_MAP_READ,False,'CrE') else
    if (FicheroM=0) then FicheroM:=OpenFileMapping(FILE_MAP_READ,False,'GeS') else
    if (FicheroM=0) then FicheroM:=OpenFileMapping(FILE_MAP_READ,False,'CoN') else
    L := 'Not';
    if (FicheroM<>0) then
    begin
    Compartido:=MapViewOfFile(FicheroM,FILE_MAP_READ,0,0,0);
    L:=Compartido^.Cadena;
    end;
    if (L = 'Try') and ( Usuario = '') then
    begin
    connection;
    TraerUsuario;
    if BaseDatos.Connected = True then BaseDatos.Close;
    end;
    if (L = 'Try') and (Usuario <> '') then connection else
    if (L = 'Rea') and (Usuario <> '') then
    begin
    Licencia:=('HA EXPIRADO EL PERIODO DE PRUEBA '+#13+' PARA MAYOR INFORMACION DIRIJASE A '+#13+'http://www.degsoft.com.ar');
    if Transaccion.Active=True then Transaccion.Active:=False;
    Transaccion.Params.Text:='read consistency';
    connection;
    Transaccion.Active:=True;
    end
    else
    begin
    if BaseDatos.Connected = True then BaseDatos.Close;
    BaseDatos.DatabaseName:='';
    ShowMessage('USTED NO TIENE PERMISO PARA OPERAR EL SISTEMA');
    end; }
end;

procedure TDM.DataModuleCreate(Sender: TObject);
begin
  ObtenerSO;
  GetBuildInfo;//(v1,v2,v3,v4);
  Usuario := '0';
  Oculto := '0';
  if U = '' then
    U := ExtractFileDrive(Application.ExeName);
  Maquina := GetVolumeID(U);
  connection;
//  if not microsoftStore then
//  Descargar('https://raw.githubusercontent.com/DeGsoft/GeN-XE7/master/Instalador/Update.iss'
//  , Path+'Update.iss');
  ActualizarBase;
  TraerConfig;
end;

procedure TDM.connection;
//var
//  origen, destino: string;
begin
  FormatearFecha;
  if BaseDatos.Connected = True then BaseDatos.Close;
  // Obtiene la ruta y el nombre de la base de datos
  Path := TPath.GetDocumentsPath()+'\Civeloo\GeN\';
  ejecutable := ExtractFilePath(Application.ExeName);
  ejecutable := StringReplace(ejecutable, 'bin\', '', [rfReplaceAll]);
  if  not FileExists(Path+'db\GeN.FDB') then
    CopyDir(ejecutable, Path);
  LeerINI;
  U := ExtractFileDrive(Application.ExeName);
  if bd <> '' then Path := bd;
  if BasedeDatos = '' then BasedeDatos := Path + 'db\GeN.FDB';
  If BasedeDatos = '' then ShowMessage('Error al cargar Base de Datos');
  BaseDatos.DatabaseName := BasedeDatos;
  BaseDatos.Open;
end;

function TDM.ObtenerConfig;
begin
  ConfigQuery.Close;
  ConfigQuery.Open;
  result := ConfigQuery.FieldByName(campo).Value;
end;

procedure TDM.LeerINI;
Var
  IniFile: TIniFile;
begin
  IniFile := TIniFile.Create(Path + 'db\' + 'DeG');
  bd := IniFile.ReadString('BD', 'Path', '');
  BasedeDatos := IniFile.ReadString('BD', 'DBase', '');
  webUrl := IniFile.ReadString('WEB', 'URL', '');
  webRes := IniFile.ReadString('WEB', 'RES', '');
  webUsr := IniFile.ReadString('WEB', 'USR', '');
  webPsw := IniFile.ReadString('WEB', 'PSW', '');
  webUpd := IniFile.ReadString('WEB', 'UPD', '');
  afipUrl := IniFile.ReadString('AFIP', 'URL', '');
  afipRes := IniFile.ReadString('AFIP', 'RES', '');
  afipUsr := IniFile.ReadString('AFIP', 'USR', '');
  afipPsw := IniFile.ReadString('AFIP', 'PSW', '');
//  operNCC := IniFile.ReadString('OPER', 'NCC', '');
  openSSL := IniFile.ReadString('OSSL', 'EXE', '');
  NroA := IniFile.ReadString('NRO', 'A', '');
  NroNCA := IniFile.ReadString('NRO', 'NCA', '');
  NroB := IniFile.ReadString('NRO', 'B', '');
  NroNCB := IniFile.ReadString('NRO', 'NCB', '');
  NroC := IniFile.ReadString('NRO', 'C', '');
  NroNCC := IniFile.ReadString('NRO', 'NCC', '');
  thunderbird := IniFile.ReadString('EMAIL', 'EXE', '');
  IniFile.Destroy;
end;

procedure TDM.EscribirINI;
Var
  IniFile: TIniFile;
begin
  IniFile := TIniFile.Create(Path + 'db\' + 'DeG');
  IniFile.WriteString('WEB', 'URL', webUrl);
  IniFile.WriteString('WEB', 'RES', webRes);
  IniFile.WriteString('WEB', 'USR', webUsr);
  IniFile.WriteString('WEB', 'PSW', webPsw);
  IniFile.WriteString('WEB', 'UPD', webUpd);
  IniFile.WriteString('AFIP', 'URL', afipUrl);
  IniFile.WriteString('AFIP', 'RES', afipRes);
  IniFile.WriteString('AFIP', 'USR', afipUsr);
  IniFile.WriteString('AFIP', 'PSW', afipPsw);
//  IniFile.WriteString('OPER', 'NCC', operNCC);
  IniFile.WriteString('OSSL', 'EXE', openSSL);
  IniFile.WriteString('NRO', 'A', NroA);
  IniFile.WriteString('NRO', 'NCA', NroNCA);
  IniFile.WriteString('NRO', 'B', NroB);
  IniFile.WriteString('NRO', 'NCB', NroNCB);
  IniFile.WriteString('NRO', 'C', NroC);
  IniFile.WriteString('NRO', 'NCC', NroNCC);
  IniFile.WriteString('EMAIL', 'EXE', thunderbird);
  IniFile.Destroy;
  LeerINI;
end;

procedure TDM.VaciarBase;
begin
  BaseDatos.Close;
  TDirectory.Delete(Path, True);
//  Consulta.Script.Text := 'SET NAMES WIN1252; CONNECT ' + quotedstr(BaseDeDatos)
//    + ' USER ''SYSDBA'' PASSWORD ''masterkey''; ' + Consulta.Script.Text;
//  Consulta.ExecuteScript;
//  ShowMessage('Base de Datos Restaurada con éxito!!!');
//  webUrl := '';
//  webRes := '';
//  webUsr := '';
//  webPsw := '';
//  webUpd := '';
//  afipUrl := '';
//  afipRes := '';
//  afipUsr := '';
//  afipPsw := '';
//  openSSL := '';
//  NroA := '0';
//  NroNCA := '0';
//  NroB := '0';
//  NroNCB := '0';
//  NroC := '0';
//  NroNCC := '0';
//  thunderbird := '';
//  EscribirINI;
//  TraerConfig;
end;

function TDM.TextoAfecha;
var
  Fmt: TFormatSettings;
begin
  fmt.ShortDateFormat:='yyyy/mm/dd';
  fmt.DateSeparator  :='/';
  fmt.ShortTimeFormat :='hh:nn';
  fmt.TimeSeparator  :=':';
  result := StrToDateTime((
    (Copy(StrDate, 1, 4))+'/'+
    (Copy(StrDate, 5, 2))+'/'+
    (Copy(StrDate, 7, 2))+' '+
    (Copy(StrDate, 9, 2))+':'+
    (Copy(StrDate, 11, 2))
  ),Fmt);
end;

function TDM.Descargar;
var
  LResponse: IHTTPResponse;
  LStream: TFileStream;
  LHttpClient: THTTPClient;
begin
//  inherited;
  LHttpClient := THTTPClient.Create;
  try
    // if a "partial" download already exists
    if FileExists(FFileName) then
    begin
      // re-utilize the same file stream, with position on the end of the stream
      LStream := TFileStream.Create(FFileName, fmOpenWrite or fmShareDenyNone);
    end else begin
      // create a new file stream, with the position on the beginning of the stream
      LStream := TFileStream.Create(FFileName, fmCreate);
    end;
    try
      LResponse := LHttpClient.Get(FURL, LStream);
      result:= FFileName;
      LStream.Free;
    except
//      MessageDlg('Error Get', mtInformation, [mbOK], 0);
   end;
  finally
    LHttpClient.Free;
  end;
end;

// Lee un archivo de texto y lo devuelve como un arreglo.
function TDM.ReadTextFile;
var
   F : TextFile;
   i : Integer;
//   Buffer, version, b1,b2,b3,b4 : String;
begin
   try
    FileMode := fmOpenRead;
    AssignFile(F, FileName);
    Reset(F);
    i := 0;
    REPEAT
      Readln(F, Result);
      Inc(i);
    UNTIL i = 5;
      CloseFile(F);
   except
//      MessageDlg('Error de I/O', mtInformation, [mbOK], 0);
   end;
end;

procedure TDM.ActualizarImprimir;
var c:string;
begin
  Query.SQL.Text :=
    'Select * from "Imprimir" WHERE "Imprimir".REPORTE = '+QuotedStr(reporte);
  Query.Open;
  if Query.RecordCount = 0 then
  begin
    Query.Close;
    c:=IntToStr(DM.UltimoRegistro('Imprimir', 'CODIGO'));
    Query.SQL.Text :=
      'INSERT INTO "Imprimir" (CODIGO, DESCRIPCION, REPORTE) VALUES ('+c+', '+QuotedStr(reporte)+', '+QuotedStr(reporte)+')';
    Query.ExecSQL;
    Query.Transaction.Commit;
  end;
end;

procedure TDM.Ejecutar;
begin
//  ShellExecute(0, 'open', PChar(VarToStr( dir )), 'param1 param2', nil,  SW_HIDE);
  WinExec(PAnsiChar(AnsiString(dir)), SW_SHOWNORMAL);
end;

function TDM.UltimoRegistro; // OBTENER EL NUMERO DE INDICE
begin
  Query.sql.Text := 'Select Max ( '+c+' ) From "'+T+'"';
  Query.Open;
  result := Query.Fields[0].AsInteger + 1;
  Query.Close;
end;

procedure TDM.FormatearFecha;
begin
  with FormatSettings do
  begin
    DecimalSeparator := '.';
    ThousandSeparator := ',';
    ShortDateFormat := 'mm/dd/yyyy';
  end;
end;

function TDM.ExisteOpenSSL;
begin
  if FileExists(openSSl) then
    result:=true
  else
  begin
    openSSl := 'C:\OpenSSL-Win32\bin\openssl.exe';
    if not FileExists(openSSl) then
      begin
        ShowMessage('Seleccione el ejectutable de OpenSSL para continuar...');
        OpenDialog1.FileName:='openssl.exe';
        OpenDialog1.Execute();
        openSSl := OpenDialog1.FileName;
      end;
    if FileExists(openSSl) then
    begin
      EscribirINI;
      result:=true;
    end
    else
    begin
      ShowMessage('Por favor descargar e instalar OpenSSL!!!');
      result:=false;
    end;
  end;
end;

function TDM.TraerTipoCbte(tipo:string):string;
begin
  case IndexStr(tipo, ['0', 'A', 'NCA', 'B', 'NCB', 'C','NCC' ]) of
    0 : result:='0';
    1 : result:='1';
    2 : result:='3';
    3 : result:='6';
    4 : result:='8';
    5 : result:='11';
    6 : result:='13';
  end;
end;

procedure TDM.ActualizarBase;
begin
  if ExisteEnTabla('Version', '') then
  begin
//    GetBuildInfo;
    if not EsMismaVersion then
    begin
      CopyDir(ejecutable+'hlp', Path);
      CopyDir(ejecutable+'rpt', Path);
      crearcbtetipo;
      ActualizarVersion;
    end;
  end
  else
  begin
    CrearTabla('Version', 'V1', 'VARCHAR(255)');
    ActualizarTabla('Version', 'V2', 'VARCHAR(255)');
    ActualizarTabla('Version', 'V3', 'VARCHAR(255)');
    ActualizarTabla('Version', 'V4', 'VARCHAR(255)');
    AgregarValor('Version','V1', FloatToStr(v1));
    ActualizarValor('Version', 'V2', '', FloatToStr(v2));
    ActualizarValor('Version', 'V3', '', FloatToStr(v3));
    ActualizarValor('Version', 'V4', '', FloatToStr(v4));
    if not ExisteEnTabla('CbtesAsoc', '') then
    begin
  {
  <ar:CbtesAsoc>
    <ar:CbteAsoc>
    <ar:Tipo>short</ar:Tipo>
    <ar:PtoVta>int</ar:PtoVta>
    <ar:Nro>long</ar:Nro>
    <ar:Cuit>String</ar:Cuit>
    <ar:CbteFch>String</ar:CbteFch>
  </ar:CbteAsoc>
  }
      CrearTabla('CbtesAsoc', 'CODIGO', 'INTEGER');
      ActualizarTabla('CbtesAsoc', 'TIPO', 'INTEGER');
      ActualizarTabla('CbtesAsoc', 'PTOVTA', 'INTEGER');
      ActualizarTabla('CbtesAsoc', 'NRO', 'VARCHAR(255)');
      ActualizarTabla('CbtesAsoc', 'CUIT', 'VARCHAR(255)');
      ActualizarTabla('CbtesAsoc', 'CBTEFCH', 'VARCHAR(255)');
      ActualizarTabla('Operacion', 'CBTESASOC', 'INTEGER');
      ActualizarTabla('Venta', 'CBTESASOC', 'INTEGER');
      ActualizarTabla('CtaCte', 'CBTESASOC', 'INTEGER');
      ActualizarTabla('Presupuesto', 'CBTESASOC', 'INTEGER');
      ActualizarTabla('Compra', 'CBTESASOC', 'INTEGER');
    end;
  {
  <ar:Iva>
    <ar:AlicIva>
      <ar:Id>5</ar:Id>  21%
      <ar:BaseImp>100</ar:BaseImp>
      <ar:Importe>21</ar:Importe>
    </ar:AlicIva>
    <ar:AlicIva>
      <ar:Id>4</ar:Id>  10.5%
      <ar:BaseImp>50</ar:BaseImp>
      <ar:Importe>5.25</ar:Importe>
    </ar:AlicIva>
  </ar:Iva>
  }
    if not ExisteEnTabla('Iva', '') then
    begin
      CrearTabla('Iva', 'CODIGO', 'INTEGER');
       ActualizarTabla('Iva', 'TASA', 'DOUBLE PRECISION');
       ActualizarTabla('Iva', 'DESCRIPCION', 'VARCHAR(255)');
       ActualizarIVA('3', '0');
       ActualizarIVA('4', '10.5');
       ActualizarIVA('5', '21');
       ActualizarIVA('6', '27');
       ActualizarIVA('8', '5');
       ActualizarIVA('9', '2.5');
      CrearTabla('AlicIva', 'CODIGO', 'INTEGER');
       ActualizarTabla('AlicIva', 'ID', 'INTEGER');
       ActualizarTabla('AlicIva', 'BASEIMP', 'DOUBLE PRECISION');
       ActualizarTabla('AlicIva', 'IMPORTE', 'DOUBLE PRECISION');
      ActualizarTabla('Operacion', 'ALICIVA', 'INTEGER');
      ActualizarTabla('Venta', 'ALICIVA', 'INTEGER');
      ActualizarTabla('CtaCte', 'ALICIVA', 'INTEGER');
      ActualizarTabla('Presupuesto', 'ALICIVA', 'INTEGER');
    end;
    ActualizarTabla('Compra', 'ALICIVA', 'INTEGER');
    ActualizarImprimir('FElectronica');
    ActualizarImprimir('TElectronica');
  end;
end;

function TDM.ExisteEnTabla;
begin
  Query.SQL.Text :=
    'SELECT RDB$FIELD_ID'
    +' FROM RDB$RELATION_FIELDS'
    +' WHERE RDB$RELATION_NAME = '+QuotedStr(TB_NAME)
    +' AND RDB$SYSTEM_FLAG = 0';
  if FLD_NAME<>'' then
    Query.SQL.Text := Query.SQL.Text+' AND RDB$FIELD_NAME = '+QuotedStr(FLD_NAME);
  Query.Open;
  result := Query.RecordCount>0;
end;

procedure TDM.ActualizarTabla;
begin
  if not ExisteEnTabla(TB_NAME, FLD_NAME) then
  begin
    IBScript1.Script.Text := 'SET NAMES WIN1252; CONNECT ' + quotedstr(BaseDeDatos)
      +' USER ''SYSDBA'' PASSWORD ''masterkey''; '
      +' ALTER TABLE "'+(TB_NAME)+'" ADD '+(FLD_NAME)+' '+(TYP_NAME)+';';
    IBScript1.ExecuteScript;
    IBScript1.Transaction.CommitRetaining;
  end;
end;

procedure TDM.CrearTabla;
begin
  if not ExisteEnTabla(TB_NAME, '') then
  begin
    IBScript1.Script.Text := 'SET NAMES WIN1252; CONNECT '+QuotedStr(BaseDeDatos)
      +' USER ''SYSDBA'' PASSWORD ''masterkey''; '
      +' CREATE TABLE "'+(TB_NAME)+'" ( '+(FLD_NAME)+' '+TYP_NAME+' )';
    IBScript1.ExecuteScript;
  end;
end;

procedure TDM.ActualizarIVA;
begin
  Query.SQL.Text :=
    'INSERT INTO "Iva" (CODIGO, TASA) VALUES ('+CODIGO+', '+TASA+')';
  Query.ExecSQL;
  Query.Transaction.Commit;
end;

function TDM.TraerValor;
begin
  Query.SQL.Text :=
    'SELECT '+campo+' FROM "'+tabla+'"';
    if codigo<>'' then
      Query.SQL.Text := Query.SQL.Text + ' WHERE CODIGO='+codigo;
  Query.Open;
  result := Query.Fields.Fields[0].AsString;
end;

function TDM.TraerValor2;
begin
  Query.SQL.Text :=
    'SELECT '+campo
    +' FROM "'+tabla+'"'
    +' WHERE CODIGO='+codigo
    +' AND '+cam2+'='+cod2;
  Query.Open;
  if query.RecordCount>0 then
    result := Query.Fields.Fields[0].AsFloat
  else
    result := 0;
end;

procedure TDM.AgregarValor;
begin
  Query.SQL.Text :=
    'INSERT INTO "'+tabla+'" ('+campo+') VALUES ('+valor+')';
  Query.ExecSQL;
  Query.Transaction.Commit;
end;

procedure TDM.GetBuildInfo;
var
   VerInfoSize, VerValueSize, Dummy : DWORD;
   VerInfo : Pointer;
   VerValue : PVSFixedFileInfo;
begin
  VerInfoSize := GetFileVersionInfoSize(PChar(ParamStr(0)), Dummy);
  GetMem(VerInfo, VerInfoSize);
  GetFileVersionInfo(PChar(ParamStr(0)), 0, VerInfoSize, VerInfo);
  VerQueryValue(VerInfo, '\', Pointer(VerValue), VerValueSize);
  With VerValue^ do
  begin
    V1 := dwFileVersionMS shr 16;
    V2 := dwFileVersionMS and $FFFF;
    V3 := dwFileVersionLS shr 16;
    V4 := dwFileVersionLS and $FFFF;
  end;
  FreeMem(VerInfo, VerInfoSize);
end;

procedure TDM.ActualizarValor;
begin
  Query.SQL.Text :=
    'update  "'+tabla+'" set '+campo+'='+valor;
  if codigo<>'' then Query.SQL.Text := Query.SQL.Text+' where CODIGO='+codigo;
  Query.ExecSQL;
  Query.Transaction.Commit;
end;

procedure TDM.CrearTable;
 var
   TableFound: Boolean;
 begin
   with TFDTable.Create(nil) do // create a temporary TTable component
   begin
     try
       { set properties of the temporary TTable component }
       Active := False;
//       DatabaseName := ;
       Connection := FDConnection1;
       TableName := nombre;
//       TableType := ttDefault;
       { define fields for the new table }
       FieldDefs.Clear;
       FieldDefs.Add('V1', ftString, 255, False);
       FieldDefs.Add('V2', ftString, 255, False);
       FieldDefs.Add('V3', ftString, 255, False);
//       FieldDefs.Add('V4', ftString, 255, False);
//       with FieldDefs.AddFieldDef do begin
//         Name := 'V1';
//         DataType := ftString;
//         Size := 255;
//         Required := False;
//       end;
       { define indexes for the new table }
//       IndexDefs.Clear;
//       with IndexDefs.AddIndexDef do begin
//         Name := '';
//         Fields := 'First';
//         Options := [ixPrimary];
//       end;
       TableFound := Exists; // check whether the table already exists
//       if TableFound then
//         if MessageDlg('Overwrite existing table ' + nombre + '?',
//              mtConfirmation, mbYesNoCancel, 0) = mrYes then
//           TableFound := False;
        if not TableFound then
        begin
          CreateTable(False); // create the table
          Open;
          Insert;
          Fields.Fields[0].Value := FloatToStr(v1);
          Fields.Fields[1].Value := FloatToStr(v2);
          Fields.Fields[2].Value := FloatToStr(v3);
//          Fields.Fields[3].Value := FloatToStr(v4);
          Post;
        end;

     finally
       Free; // destroy the temporary TTable when done

//     AgregarValor('Version','V1', FloatToStr(v1));
//     ActualizarValor('Version', 'V2', '', FloatToStr(v2));
//     ActualizarValor('Version', 'V3', '', FloatToStr(v3));
//     ActualizarValor('Version', 'V4', '', FloatToStr(v4));
     end;
   end;
 end;

procedure TDM.IniciarModificacionTabla;
begin
//    try
    with FDQuery1 do
    begin
//        Connection := FDConnection1;
      SQL.Text:= 'select * from "'+nombreTabla+'"';
      Open;
    end;
    with FDTable1 do
    begin
      Active := False;
//        Connection := FDConnection1;
      TableName := '"'+nombreTabla+'"';
      FieldDefs := FDQuery1.FieldDefs;
//      FieldDefs.Add('V4', ftString, 255, False);
//      CreateDataSet;//or just Open that sets Active to true;
//      CopyDataSet(FDQuery1);
      //      First;
//        end;
//    except
    //    on E: Exception do
    //      Error := E.Message;
//    end;
 end;
end;

procedure TDM.AgregarCampoModificacionTabla;
begin
  FDTable1.FieldDefs.Add(nombreCampo, tipo, tamaño, False);
end;

procedure TDM.TerminarModificacionTabla;
begin
  with FDTable1 do
    begin
      CreateDataSet;//or just Open that sets Active to true;
      CopyDataSet(FDQuery1);
    end;
end;

procedure TDM.EnviarEmail;
begin
  if ExisteThunderbird then
    ShellExecute(
      0,
      'open',
      pchar(thunderbird),
      pchar('-compose "to='+email+',subject='+asunto+',body="'+cuerpo+'",attachment='''+adjunto+'''"'),
      nil,
      SW_NORMAL
    );
end;

function TDM.ExisteThunderbird;
begin
  if FileExists(thunderbird) then
    result:=true
  else
  begin
    thunderbird := 'C:\Program Files\Mozilla Thunderbird\thunderbird.exe';
    if not FileExists(thunderbird) then
      thunderbird := 'C:\Program Files (x86)\Mozilla Thunderbird\thunderbird.exe';
      if not FileExists(thunderbird) then
      begin
        ShowMessage('Seleccione el ejectutable de Thunderbird para continuar...');
        OpenDialog1.FileName:='thunderbird.exe';
        OpenDialog1.Execute();
        thunderbird := OpenDialog1.FileName;
      end;
    if FileExists(thunderbird) then
    begin
      EscribirINI;
      result:=true;
    end
    else
    begin
      ShowMessage('Por favor instalar Thunderbird para enviar emails!!!');
      ShellExecute(0,'open','https://www.thunderbird.net/es-ES/',nil,nil,SW_NORMAL);
      result:=false;
    end;
  end;
end;

function TDM.CopyDir;
var
  SHFileOpStruct: TSHFileOpStruct;
begin
  ZeroMemory(@SHFileOpStruct, SizeOf(SHFileOpStruct));
  with SHFileOpStruct do
  begin
    wFunc  := FO_COPY;
    fFlags := FOF_NO_UI;
//    fFlags := FOF_NOCOPYSECURITYATTRIBS;
    pFrom  := PChar(Source + #0);
    pTo    := PChar(Target)
  end;
  Result := (0 = ShFileOperation(SHFileOpStruct));
end;

procedure TDM.ObtenerSO;
begin
  microsoftStore := (AnsiPos(trim('WindowsApps'),trim(ExtractFilePath(Application.ExeName)))<>0);
end;

function TDM.Actualizar;
var
  actualiza :string;
begin
  result := False;
    if not microsoftStore then
    begin
      actualiza := Copy(ReadTextFile(
          Descargar('https://raw.githubusercontent.com/DeGsoft/GeN-XE7/master/Instalador/Update.iss'
          , path+'Update.iss')
          ), 23, 12);
      if actualiza <>'' then
        if TextoAfecha(actualiza) > TextoAfecha(version) then
          if MessageDlg('Nueva actualización disponible, descargar?',
            mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrYes then
          begin
            ShellExecute(0,'open',
            'https://sourceforge.net/projects/gen-xe7/files/ActualizarGeN.exe/download'
            ,nil,nil,SW_NORMAL);
            result := True;
          end
    end;
end;

procedure TDM.ActualizarVersion;
begin
  ActualizarValor('Version', 'V1', '', FloatToStr(v1));
  ActualizarValor('Version', 'V2', '', FloatToStr(v2));
  ActualizarValor('Version', 'V3', '', FloatToStr(v3));
  ActualizarValor('Version', 'V4', '', FloatToStr(v4));
end;

function TDM.EsMismaVersion;
var
  vv1,       // Major Version
  vv2,       // Minor Version
  vv3,       // Release
  vv4: Word; // Build Number
begin
  vv1 := StrToInt(TraerValor('Version','V1',''));
  vv2 := StrToInt(TraerValor('Version','V2',''));
  vv3 := StrToInt(TraerValor('Version','V3',''));
  vv4 := StrToInt(TraerValor('Version','V4',''));
  result := ( (V1=vv1) and (V2=vv2) and (V3=vv3) and (V4=vv4) );
end;

procedure TDM.CrearCbtetipo;
 var
   TableFound: Boolean;
 begin
   with TFDTable.Create(nil) do // create a temporary TTable component
   begin
     try
       { set properties of the temporary TTable component }
       Active := False;
//       DatabaseName := ;
       Connection := FDConnection1;
       TableName := '"CbteTipo"';
//       TableType := ttDefault;
       { define fields for the new table }
       FieldDefs.Clear;
       FieldDefs.Add('CODIGO', ftInteger);
       FieldDefs.Add('LETRA', ftString, 10, False);
       FieldDefs.Add('DESCRIPCION', ftString, 255, False);
//       FieldDefs.Add('V4', ftString, 255, False);
//       with FieldDefs.AddFieldDef do begin
//         Name := 'V1';
//         DataType := ftString;
//         Size := 255;
//         Required := False;
//       end;
       { define indexes for the new table }
//       IndexDefs.Clear;
//       with IndexDefs.AddIndexDef do begin
//         Name := '';
//         Fields := 'First';
//         Options := [ixPrimary];
//       end;
       TableFound := Exists; // check whether the table already exists
//       if TableFound then
//         if MessageDlg('Overwrite existing table ' + nombre + '?',
//              mtConfirmation, mbYesNoCancel, 0) = mrYes then
//           TableFound := False;
        if not TableFound then
        begin
          CreateTable(False); // create the table
          Open;
//          Insert;
//          Fields.Fields[0].Value := FloatToStr(v1);
        InsertRecord([1,'A','FACTURAS A']);
        InsertRecord([2,'NDA','NOTAS DE DEBITO A']);
        InsertRecord([3,'NCA','NOTAS DE CREDITO A']);
        InsertRecord([4,'RA','RECIBOS A']);
        InsertRecord([5,'NVA','NOTAS DE VENTA AL CONTADO A']);
        InsertRecord([6,'B','FACTURAS B']);
        InsertRecord([7,'NDB','NOTAS DE DEBITO B']);
        InsertRecord([8,'NCB','NOTAS DE CREDITO B']);
        InsertRecord([9,'RB','RECIBOS B']);
        InsertRecord([10,'NVB','NOTAS DE VENTA AL CONTADO B']);
        InsertRecord([11,'C',' Factura C ']);
        InsertRecord([12,'NDC','Nota de Débito C ']);
        InsertRecord([13,'NCC',' Nota de Crédito C ']);
        InsertRecord([15,'RC','Recibo C ']);
        InsertRecord([17,'','LIQUIDACION DE SERVICIOS PUBLICOS CLASE A']);
        InsertRecord([18,'','LIQUIDACION DE SERVICIOS PUBLICOS CLASE B']);
        InsertRecord([19,'','FACTURAS DE EXPORTACION']);
        InsertRecord([20,'','NOTAS DE DEBITO POR OPERACIONES CON EL EXTERIOR']);
        InsertRecord([21,'','NOTAS DE CREDITO POR OPERACIONES CON EL EXTERIOR']);
        InsertRecord([22,'','FACTURAS - PERMISO EXPORTACION SIMPLIFICADO - DTO. 855/97']);
        InsertRecord([23,'','CPTES "A" DE COMPRA PRIMARIA PARA EL SECTOR PESQUERO MARITIMO']);
        InsertRecord([24,'','CPTES "A" DE COSIGNACION PRIMARIA PARA EL SECTOR PESQUERO MARITIMO']);
        InsertRecord([27,'','LIQUIDACION UNICA COMERCIAL IMPOSITIVA CLASE A']);
        InsertRecord([28,'','LIQUIDACION UNICA COMERCIAL IMPOSITIVA CLASE B']);
        InsertRecord([29,'','LIQUIDACION UNICA COMERCIAL IMPOSITIVA CLASE C']);
        InsertRecord([33,'','LIQUIDACION PRIMARIA DE GRANOS']);
        InsertRecord([34,'','COMPROBANTES A DEL APARTADO A INCISO F R G N 1415']);
        InsertRecord([35,'','COMPROBANTES B DEL ANEXO I, APARTADO A, INC. F), RG N° 1415']);
        InsertRecord([37,'','NOTAS DE DEBITO O DOCUMENTO EQUIVALENTE QUE CUMPLAN CON LA R.G. N° 1415']);
        InsertRecord([38,'','NOTAS DE CREDITO O DOCUMENTO EQUIVALENTE QUE CUMPLAN CON LA R.G. N° 1415']);
        InsertRecord([39,'','OTROS COMPROBANTES A QUE CUMPLEN CON LA R G 1415']);
        InsertRecord([40,'','OTROS COMPROBANTES B QUE CUMPLAN CON LA R.G. 1415']);
        InsertRecord([43,'','NOTA DE CREDITO LIQUIDACION UNICA COMERCIAL IMPOSITIVA CLASE B']);
        InsertRecord([44,'','NOTA DE CREDITO LIQUIDACION UNICA COMERCIAL IMPOSITIVA CLASE C']);
        InsertRecord([45,'','NOTA DE DEBITO LIQUIDACION UNICA COMERCIAL IMPOSITIVA CLASE A']);
        InsertRecord([46,'','NOTA DE DEBITO LIQUIDACION UNICA COMERCIAL IMPOSITIVA CLASE B']);
        InsertRecord([47,'','NOTA DE DEBITO LIQUIDACION UNICA COMERCIAL IMPOSITIVA CLASE C']);
        InsertRecord([48,'','NOTA DE CREDITO LIQUIDACION UNICA COMERCIAL IMPOSITIVA CLASE A']);
        InsertRecord([51,'M','FACTURAS M']);
        InsertRecord([52,'NDM','NOTAS DE DEBITO M']);
        InsertRecord([53,'NCM','NOTAS DE CREDITO M']);
        InsertRecord([54,'RM','RECIBOS M']);
        InsertRecord([55,'','NOTAS DE VENTA AL CONTADO M']);
        InsertRecord([56,'','COMPROBANTES M DEL ANEXO I APARTADO A INC F R G N 1415']);
        InsertRecord([57,'','OTROS COMPROBANTES M QUE CUMPLAN CON LA R G N 1415']);
        InsertRecord([58,'','CUENTAS DE VENTA Y LIQUIDO PRODUCTO M']);
        InsertRecord([59,'','LIQUIDACIONES M']);
        InsertRecord([60,'','CUENTAS DE VENTA Y LIQUIDO PRODUCTO A']);
        InsertRecord([61,'','CUENTAS DE VENTA Y LIQUIDO PRODUCTO B']);
        InsertRecord([63,'','LIQUIDACIONES A']);
        InsertRecord([64,'','LIQUIDACIONES B']);
        InsertRecord([68,'','LIQUIDACION C']);
        InsertRecord([81,'','TIQUE FACTURA A CONTROLADORES FISCALES']);
        InsertRecord([82,'','TIQUE - FACTURA B']);
        InsertRecord([83,'','TIQUE']);
        InsertRecord([90,'','NOTA DE CREDITO OTROS COMP QUE NO CUMPLEN CON LA R G 1415 Y SUS MODIF']);
        InsertRecord([99,'','OTROS COMP QUE NO CUMPLEN CON LA R G 1415 Y SUS MODIF']);
        InsertRecord([110,'','TIQUE NOTA DE CREDITO']);
        InsertRecord([112,'','TIQUE NOTA DE CREDITO A']);
        InsertRecord([113,'','TIQUE NOTA DE CREDITO B']);
        InsertRecord([115,'','TIQUE NOTA DE DEBITO A']);
        InsertRecord([116,'','TIQUE NOTA DE DEBITO B']);
        InsertRecord([118,'','TIQUE FACTURA M']);
        InsertRecord([119,'','TIQUE NOTA DE CREDITO M']);
        InsertRecord([120,'','TIQUE NOTA DE DEBITO M']);
        InsertRecord([331,'','LIQUIDACION SECUNDARIA DE GRANOS']);
        InsertRecord([332,'','CERTIFICADO DE DEPOSITO DE GRANOS EN PLANTA']);
//          Post;
        end;

     finally
       Free; // destroy the temporary TTable when done
     end;
   end;
 end;

end.
