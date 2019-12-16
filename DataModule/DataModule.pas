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
  ShellApi, System.Variants, ShlObj, System.IOUtils, IBX.IBTable,
  FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.FMXUI.Wait, FireDAC.Comp.UI, FireDAC.Comp.BatchMove.DataSet,
  FireDAC.Comp.BatchMove, FireDAC.Comp.BatchMove.Text, FireDAC.Comp.BatchMove.SQL,
  FireDAC.Comp.ScriptCommands, FireDAC.Stan.Util, FireDAC.Comp.Script, System.Math;

type
  TDM = class(TDataModule)
    Consulta1: TIBScript;
    OpenDialog1: TOpenDialog;
    FDTable1: TFDTable;
    FDQuery1: TFDQuery;
    sdb: TFDConnection;
    tCbteTipo: TFDQuery;
    tSdb: TFDQuery;
    mtIVA: TFDMemTable;
    qSdb: TFDQuery;
    SaveDialog1: TSaveDialog;
    FDBatchMoveSQLWriter1: TFDBatchMoveSQLWriter;
    FDBatchMoveTextReader1: TFDBatchMoveTextReader;
    FDBatchMove1: TFDBatchMove;
    BaseDatosFB: TFDConnection;
    ConfigQuery: TFDQuery;
    dstArticulo: TDataSource;
    dsqMaterial: TDataSource;
    dsqUsuario: TDataSource;
    dstMarca: TDataSource;
    dsqCuenta: TDataSource;
    dstProveedor: TDataSource;
    dstIVA: TDataSource;
    dstCategoria: TDataSource;
    dstSubCategoria: TDataSource;
    dstRubro: TDataSource;
    qODM: TFDQuery;
    dsqArticulo: TDataSource;
    dsqCliente: TDataSource;
    dsqVendedor: TDataSource;
    dstVendedor: TDataSource;
    dstCuenta: TDataSource;
    dstUsuario: TDataSource;
    dstCliente: TDataSource;
    dstEmpresa: TDataSource;
    dsqIIBB: TDataSource;
    dsqProveedor: TDataSource;
    dsqCompra: TDataSource;
    dsqOperacion: TDataSource;
    dstConfiguracion: TDataSource;
    dsqImprimir: TDataSource;
    dsqCaja: TDataSource;
    dsqGanancia: TDataSource;
    dsqLibroDiario: TDataSource;
    dsqLibro: TDataSource;
    dsqTarjeta: TDataSource;
    Query: TFDQuery;
    qArticulo: TFDQuery;
    qCaja: TFDQuery;
    qCompra: TFDQuery;
    qCliente: TFDQuery;
    qCuenta: TFDQuery;
    qEmpresa: TFDQuery;
    qGanancia: TFDQuery;
    qIIBB: TFDQuery;
    qImprimir: TFDQuery;
    qLibroDiario: TFDQuery;
    qLibro: TFDQuery;
    qProveedor: TFDQuery;
    qOperacion: TFDQuery;
    qVendedor: TFDQuery;
    qUsuario: TFDQuery;
    qTarjeta: TFDQuery;
    tArticulo: TFDTable;
    tCategoria: TFDTable;
    tCliente: TFDTable;
    tConfiguracion: TFDTable;
    tCuenta: TFDTable;
    tIVA: TFDTable;
    tLibroIVAventa: TFDTable;
    tMaterial: TFDTable;
    tMarca: TFDTable;
    tProveedor: TFDTable;
    tEmpresa: TFDTable;
    tRubro: TFDTable;
    tSubCategoria: TFDTable;
    tUsuario: TFDTable;
    tVendedor: TFDTable;
    qQ: TFDQuery;
    qTemp: TFDQuery;
    qT: TFDQuery;
    qD: TFDQuery;
    Consulta: TFDScript;
    qSdbReporte: TFDQuery;
    dsQuery: TDataSource;
    TransactionFB: TFDTransaction;
    FDBatchMoveTextWriter1: TFDBatchMoveTextWriter;
    FDBatchMoveDataSetReader1: TFDBatchMoveDataSetReader;
    FDBatchMoveDataSetWriter1: TFDBatchMoveDataSetWriter;
    qRemito: TFDQuery;

    procedure DataModuleCreate(Sender: TObject);
    function ObtenerConfig(campo:string):Variant;
    procedure LeerINI;
    procedure EscribirINI;
    procedure tClienteAfterInsert(DataSet: TDataSet);
    procedure tArticuloAfterInsert(DataSet: TDataSet);
    procedure tProveedorAfterInsert(DataSet: TDataSet);
    procedure tVendedorAfterInsert(DataSet: TDataSet);
    procedure tProveedorAfterPost(DataSet: TDataSet);
    procedure tArticuloAfterPost(DataSet: TDataSet);
    procedure tProveedorBeforeInsert(DataSet: TDataSet);
    procedure tProveedorBeforeEdit(DataSet: TDataSet);
    procedure tArticuloBeforeEdit(DataSet: TDataSet);
    procedure tArticuloBeforeInsert(DataSet: TDataSet);
    procedure tCategoriaAfterPost(DataSet: TDataSet);
    procedure tCategoriaBeforeEdit(DataSet: TDataSet);
    procedure tCategoriaBeforeInsert(DataSet: TDataSet);
    procedure tClienteBeforeInsert(DataSet: TDataSet);
    procedure tClienteBeforeEdit(DataSet: TDataSet);
    procedure tClienteAfterPost(DataSet: TDataSet);
    procedure tConfiguracionAfterPost(DataSet: TDataSet);
    procedure tConfiguracionBeforeEdit(DataSet: TDataSet);
    procedure tConfiguracionBeforeInsert(DataSet: TDataSet);
    procedure tCuentaBeforeEdit(DataSet: TDataSet);
    procedure tCuentaBeforeInsert(DataSet: TDataSet);
    procedure tCuentaAfterPost(DataSet: TDataSet);
    procedure tIVAAfterPost(DataSet: TDataSet);
    procedure tIVABeforeInsert(DataSet: TDataSet);
    procedure tIVABeforeEdit(DataSet: TDataSet);
    procedure tLibroIVAventaAfterPost(DataSet: TDataSet);
    procedure tLibroIVAventaBeforeEdit(DataSet: TDataSet);
    procedure tLibroIVAventaBeforeInsert(DataSet: TDataSet);
    procedure tMaterialAfterPost(DataSet: TDataSet);
    procedure tMaterialBeforeInsert(DataSet: TDataSet);
    procedure tMaterialBeforeEdit(DataSet: TDataSet);
    procedure tMarcaBeforeEdit(DataSet: TDataSet);
    procedure tMarcaBeforeInsert(DataSet: TDataSet);
    procedure tMarcaAfterPost(DataSet: TDataSet);
    procedure tEmpresaAfterPost(DataSet: TDataSet);
    procedure tEmpresaBeforeEdit(DataSet: TDataSet);
    procedure tEmpresaBeforeInsert(DataSet: TDataSet);
    procedure tRubroBeforeInsert(DataSet: TDataSet);
    procedure tRubroBeforeEdit(DataSet: TDataSet);
    procedure tRubroAfterPost(DataSet: TDataSet);
    procedure tSubCategoriaBeforeInsert(DataSet: TDataSet);
    procedure tSubCategoriaBeforeEdit(DataSet: TDataSet);
    procedure tSubCategoriaAfterPost(DataSet: TDataSet);
    procedure tUsuarioAfterPost(DataSet: TDataSet);
    procedure tUsuarioBeforeEdit(DataSet: TDataSet);
    procedure tUsuarioBeforeInsert(DataSet: TDataSet);
    procedure tVendedorBeforeInsert(DataSet: TDataSet);
    procedure tVendedorBeforeEdit(DataSet: TDataSet);
    procedure tVendedorAfterPost(DataSet: TDataSet);
    procedure FDTable1AfterPost(DataSet: TDataSet);
    procedure FDTable1BeforeEdit(DataSet: TDataSet);
    procedure FDTable1BeforeInsert(DataSet: TDataSet);
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
    procedure CrearTablasSiap;
    procedure ConectarSDB;
    procedure CrearMtIva;
    procedure CrearTablaRetPer;
    procedure ActualizarTrigger(name,active,body:string);
    procedure ActualizarTriggerFecha;
    procedure CrearTablasIva;
    procedure CrearTablaCbteAsoc;
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
    function UltimoRegistroSdb(T, c: String): integer;
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
    function ObtenerValor(tabla, campo, codigo, valor: string):string;
    procedure AgregarMtIva(tasa,neto,imp:Double);
    procedure LlenarMtIva(codigo :string);
    procedure VaciarMtIva;
    function CalcularIVA(monto,porcentaje:Double):Double;
    function SacarIVA(monto,porcentaje:Double):Double;
    function TraerAlicuota(tasa:string):string;
    function TraerTasaAlicuota(codigo:string):string;
    function TraerValorX(tabla, campo, codigo, valor: string):string;
    function CantidadAlicIva(codigo:string):string;
    function TraerCodLetra(letra:string):string;
    function ObtenerNroComp(tipo:string):string;
    procedure ActualizarNroComp(tipo,comp: string);
    procedure AgregarRetPer(tipo:string;codigo:Integer;noGra,pagCueIva,pagCueOtr,perIIBB,perImpMun,impInt,otrTrib:double);
    procedure AgregarSiapCmpCompAlicuota(codigo:Integer;ivaId,ivaBaseImp,ivaAlic:String);
    procedure AgregarSiapVtaCompAlicuota(codigo:Integer;ivaId,ivaBaseImp,ivaAlic:String);
    procedure ExportarTabla(tabla:string);
    procedure ImportarTabla(tabla:string);
    function HayBase:Boolean;
    function CalculaGanancia(c,f,p : double):double;
    procedure AgregarSiapCompAlicuota(tipo:string;codigo:Integer;ivaId,ivaBaseImp,ivaAlic:String);
    procedure ImportarProveedor;
  end;

const
  version='201912161027';
  v: array [0 .. 22] of string = ('MenuExpress', 'MenuStock', 'Articulos',
    'VaciarBase', 'Vender', 'Comprar', 'AnularVenta', 'RetiroCaja', 'Rubro',
    'Categoria', 'SubCategoria', 'Stock', 'CajaL', 'GananciaXvta', 'PreciosL',
    'ClientesL', 'CompraL', 'VentaL', 'Empresa', 'Configuracion', 'Backup',
    'Migrar', 'Licencia');
  clienteSql =
    ' "Cliente".NOMBRE,  "Cliente".TITULAR, "Cliente".DIRECCION, "Cliente".DIRECCIONCOMERCIAL, "Cliente".IVA as CIVA, "Cliente".CUIT as CCUIT, "Cliente".EMAIL';
  articuloSql =
    ' "Articulo".DESCRIPCION, "Articulo".UNIDAD, "Articulo".IVA as AIVA';
  ventaItemSql =
    ' "VentaItem".ARTICULO, "VentaItem".CANTIDAD, "VentaItem".COSTO AS VIDESCUENTO,'
    +' "VentaItem".PRECIO, "VentaItem".OPERACION,'
    +' ("VentaItem".PRECIO * "VentaItem".CANTIDAD ) as PREXCANT,'
    +' "VentaItem".SERVICIO, "VentaItem".DESCRIPCION AS DESCR,'
    +' "VentaItem".IMPUESTO as VIIMPUESTO';
  ivaVtaSql = ' "LibroIVAventa".NG1, "LibroIVAventa".IVA1, "LibroIVAventa".NG2, "LibroIVAventa".IVA2, "LibroIVAventa".NG3';
  presupuestoTSql = ' "Presupuesto".CODIGO, "Presupuesto".LETRA, "Presupuesto".DESCRIPCION as VDESC,'
    +' "Presupuesto".FECHA, "Presupuesto".COMPROBANTE, "Presupuesto".COMPROBANTE AS CB,'
    + ' "Presupuesto".IVA3, "Presupuesto".TOTAL, "Presupuesto".CONTADO, "Presupuesto".CLIENTE,'
    + ' "Presupuesto".SUBTOTAL, "Presupuesto".DESCUENTO, "Presupuesto".IMPUESTO, "Presupuesto".TERMINOS,'
    + ' "Presupuesto".IVA2, "Presupuesto".IVA1, "Presupuesto".EXCENTO, "Presupuesto".SALDO,'
    + ' "Presupuesto".PAGADO, "Presupuesto".ANULADA' + ' FROM "Presupuesto"';
  presupuestoSql = clienteSql + ',' + articuloSql + ',' +
    ' "PresupuestoItem".ARTICULO, "PresupuestoItem".CANTIDAD,'
    +' "PresupuestoItem".PRECIO, "PresupuestoItem".COSTO AS VIDESCUENTO,'
    + ' "PresupuestoItem".OPERACION,'
    +' ("PresupuestoItem".PRECIO * "PresupuestoItem".CANTIDAD ) as PREXCANT,'
    + ' "PresupuestoItem".SERVICIO, "PresupuestoItem".IMPUESTO as VIIMPUESTO,'
    +' "PresupuestoItem".DESCRIPCION AS DESCR,'
    + presupuestoTSql +
    ' INNER JOIN "PresupuestoItem" ON ("Presupuesto".CODIGO = "PresupuestoItem".OPERACION)'
    + ' INNER JOIN "Articulo" ON ("PresupuestoItem".ARTICULO = "Articulo".CODIGO)'
    + ' INNER JOIN "Cliente" ON ("Presupuesto".CLIENTE = "Cliente".CODIGO)';
  OperacionItemSql =
    '  "OperacionItem".ARTICULO,  "OperacionItem".CANTIDAD, "OperacionItem".COSTO AS VIDESCUENTO,' +
    '  "OperacionItem".PRECIO,' + '  "OperacionItem".OPERACION,' +
    '  ("OperacionItem".PRECIO * "OperacionItem".CANTIDAD ) as PREXCANT, "OperacionItem".IMPUESTO as VIIMPUESTO,' +
    '  "OperacionItem".SERVICIO,' + '  "OperacionItem".DESCRIPCION AS DESCR';
  OperacionSql =
    ' "Operacion".CODIGO,' + '  "Operacion".LETRA,' + '  "Operacion".FECHA, "Operacion".COMPROBANTE AS CB,' +
    ' "Operacion".COMPROBANTE, "Operacion".TERMINOS, "Operacion".DESCRIPCION as VDESC,' +
    ' "Operacion".TOTAL,' + '  "Operacion".CONTADO,' + '  "Operacion".CLIENTE,'+
    ' "Operacion".SUBTOTAL,' + ' "Operacion".DESCUENTO,' +
    ' "Operacion".IMPUESTO,' + ' "Operacion".IVA1, "Operacion".IVA2, "Operacion".IVA3,' +
    ' "Operacion".EXCENTO,' + ' "Operacion".SALDO,' + ' "Operacion".PAGADO, "Operacion".ANULADA' +
    ' FROM  "Operacion"';
  OperSql =
    clienteSql
    +','+ articuloSql
    +','+ OperacionItemSql
    +','+ OperacionSql
    +'  INNER JOIN "OperacionItem" ON ("Operacion".CODIGO = "OperacionItem".OPERACION)'
    +'  INNER JOIN "Articulo" ON ("OperacionItem".ARTICULO = "Articulo".CODIGO)'
    +'  INNER JOIN "Cliente" ON ("Operacion".CLIENTE = "Cliente".CODIGO)';
  ventaTSql =' "Venta".CODIGO,' + '  "Venta".LETRA,' + '  "Venta".DESCRIPCION as VDESC,' +
    '  "Venta".FECHA,' + '  "Venta".COMPROBANTE,' + '  "Venta".TERMINOS,'+
    '  "Venta".TOTAL,' + '  "Venta".CONTADO,' + '  "Venta".CLIENTE,' +
    '  "Venta".SUBTOTAL,' + '  "Venta".DESCUENTO,' + '  "Venta".IMPUESTO,' +
    '  "Venta".IVA1, "Venta".IVA2, "Venta".IVA3,' +
    '  "Venta".EXCENTO,' + '  "Venta".SALDO,' + '  "Venta".PAGADO, "Venta".ANULADA'
    + ' FROM'
    + ' "Venta"';
  vtaSql =
    clienteSql
    +','+ articuloSql
    +','+ ventaItemSql
    +','+ ventaTSql
    + ' INNER JOIN "VentaItem" ON ("Venta".CODIGO = "VentaItem".OPERACION)'
    + ' INNER JOIN "Articulo" ON ("VentaItem".ARTICULO = "Articulo".CODIGO)'
    + ' INNER JOIN "Cliente" ON ("Venta".CLIENTE = "Cliente".CODIGO)' ;
  vtaLibroIvaSql =
    ivaVtaSql
    +','+ vtaSql
    + ' LEFT JOIN "LibroIVAventa" ON ("Venta".CODIGO = "LibroIVAventa".FACTURA)';
  compraTSql =' "Compra".CODIGO, "Compra".LETRA, "Compra".DESCRIPCION as VDESC,' +
    ' "Compra".FECHA, "Compra".COMPROBANTE, "Compra".TERMINOS,'+
    ' "Compra".TOTAL, "Compra".CONTADO, "Compra".PROVEEDOR,' +
    ' "Compra".SUBTOTAL, "Compra".DESCUENTO, "Compra".IMPUESTO,' +
    ' "Compra".IVA1, "Compra".IVA2, "Compra".IVA3,' +
    ' "Compra".EXCENTO, "Compra".SALDO, "Compra".PAGADO, "Compra".ANULADA' +
    ' FROM "Compra"';
  proveedorSql =
    ' "Proveedor".NOMBRE,  "Proveedor".TITULAR, "Proveedor".DIRECCION, "Proveedor".DIRECCIONCOMERCIAL, "Proveedor".IVA as CIVA, "Proveedor".CUIT as CCUIT, "Proveedor".EMAIL';
  empresaSql =
    ' "Empresa".NOMBRE,  "Proveedor".TITULAR, "Proveedor".DIRECCION, "Proveedor".DIRECCIONCOMERCIAL, "Proveedor".IVA as CIVA, "Proveedor".CUIT as CCUIT, "Proveedor".EMAIL';
  compraItemSql =
    ' "CompraItem".ARTICULO, "CompraItem".CANTIDAD, "CompraItem".COSTO AS VIDESCUENTO,'
    +' "CompraItem".PRECIO, "CompraItem".OPERACION,'
    +' ("CompraItem".PRECIO * "CompraItem".CANTIDAD ) as PREXCANT,'
    +' "CompraItem".SERVICIO, "CompraItem".DESCRIPCION AS DESCR,'
    +' "CompraItem".IMPUESTO as VIIMPUESTO';
  compSql =
    proveedorSql
    +','+ articuloSql
    +','+ compraItemSql
    +','+ compraTSql
    + ' INNER JOIN "CompraItem" ON ("Compra".CODIGO = "CompraItem".OPERACION)'
    + ' INNER JOIN "Articulo" ON ("CompraItem".ARTICULO = "Articulo".CODIGO)'
    + ' INNER JOIN "Proveedor" ON ("Compra".PROVEEDOR = "Proveedor".CODIGO)' ;
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
  begin
    TraerUsuario;
    if Control <> '' then
    begin
      BaseDatosFB.ExecSQL(
        'update "Control" set MAQUINA=' + QuotedStr(Maquina) +
        ' where CODIGO=' + Control
      );
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

ConfigQuery.Open('SELECT '
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
+' INNER JOIN "Empresa" ON ("Config"."Empresa" = "Empresa".CODIGO) ');
  Empresa := ConfigQuery.FieldByName('NOMBRE').AsString;
  PuntoVenta := ConfigQuery.FieldByName('PtoVta').AsString;
  Titular := ConfigQuery.FieldByName('TITULAR').AsString;
  Fecha := FormatDateTime('mm/dd/yyyy hh:mm:ss', now);
  CUIT := ConfigQuery.FieldByName('CUIT').AsString;
  reporte := ConfigQuery.FieldByName('Reporte').AsString;
  IngresosBrutos := ConfigQuery.FieldByName('IIBB').AsString;
  if IngresosBrutos='' then IngresosBrutos:='0';
  catIVA := ConfigQuery.FieldByName('IVA').AsString;
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
  if not HayBase then Exit;
  ActualizarBase;
  TraerConfig;
  CrearMtIva;
end;

procedure TDM.connection;
//var
//  origen, destino: string;
begin
  FormatearFecha;
  if BaseDatosFB.Connected = True then BaseDatosFB.Close;
//  if BaseDatosIB.Connected = True then BaseDatosIB.Close;
  // Obtiene la ruta y el nombre de la base de datos
  Path := TPath.GetDocumentsPath()+'\Civeloo\GeN\';
  ejecutable := ExtractFilePath(Application.ExeName);
  ejecutable := StringReplace(ejecutable, 'bin', '', [rfReplaceAll]);
//  ejecutable := StringReplace(ejecutable, 'GeN', '', [rfReplaceAll]);
  if  not HayBase then
    CopyDir(ejecutable+'', Path+'');
  if  not HayBase then Exit;
  LeerINI;
  U := ExtractFileDrive(Application.ExeName);
  if bd <> '' then Path := bd;
  if BasedeDatos = '' then BasedeDatos := Path + 'db\GeN.FDB';
  If BasedeDatos = '' then ShowMessage('Error al cargar Base de Datos');
  BaseDatosFB.Params.Database:=BasedeDatos;
  BaseDatosFB.Connected:=True;
//  BaseDatosIB.DatabaseName:=BasedeDatos;
//  BaseDatosIB.Open;
  ConectarSDB;
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

procedure TDM.LlenarMtIva;
begin
  VaciarMtIVA;
  qQ.Open('select * from "AlicIva" where CODIGO=:C',[codigo]);
  with qQ do
    if RecordCount>0 then
    begin
      First;
      while not Eof do
      begin
        AgregarMtIva(
          StrToFloat(TraerTasaAlicuota(FieldByName('ID').AsString)),
          FieldByName('BASEIMP').AsFloat,
          FieldByName('IMPORTE').AsFloat
        );
        Next;
      end;
    end;
  qQ.Close;
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
//  BaseDatosIB.Close;
  BaseDatosFB.Close;
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

procedure TDM.tIVAAfterPost(DataSet: TDataSet);
begin
  tIVA.Transaction.CommitRetaining;
end;

procedure TDM.tIVABeforeEdit(DataSet: TDataSet);
begin
  tIVA.Transaction.StartTransaction;
end;

procedure TDM.tIVABeforeInsert(DataSet: TDataSet);
begin
  tIVA.Transaction.StartTransaction;
end;

procedure TDM.tLibroIVAventaAfterPost(DataSet: TDataSet);
begin
  tLibroIVAventa.Transaction.CommitRetaining;
end;

procedure TDM.tLibroIVAventaBeforeEdit(DataSet: TDataSet);
begin
  tLibroIVAventa.Transaction.StartTransaction;
end;

procedure TDM.tLibroIVAventaBeforeInsert(DataSet: TDataSet);
begin
  tLibroIVAventa.Transaction.StartTransaction;
end;

procedure TDM.tMarcaAfterPost(DataSet: TDataSet);
begin
  tMarca.Transaction.CommitRetaining;
end;

procedure TDM.tMarcaBeforeEdit(DataSet: TDataSet);
begin
  tMarca.Transaction.StartTransaction;
end;

procedure TDM.tMarcaBeforeInsert(DataSet: TDataSet);
begin
  tMarca.Transaction.StartTransaction;
end;

procedure TDM.tMaterialAfterPost(DataSet: TDataSet);
begin
  tMaterial.Transaction.CommitRetaining;
end;

procedure TDM.tMaterialBeforeEdit(DataSet: TDataSet);
begin
  tMaterial.Transaction.StartTransaction;
end;

procedure TDM.tMaterialBeforeInsert(DataSet: TDataSet);
begin
  tMaterial.Transaction.StartTransaction;
end;

procedure TDM.tProveedorAfterInsert(DataSet: TDataSet);
begin
  with tProveedor do begin
    FieldByName('CtaNombre').AsString := '76';
    FieldByName('CtaTipo').AsString := '13';
    FieldByName('CtaAnticipo').AsString := '36';
  end;
end;

procedure TDM.tProveedorAfterPost(DataSet: TDataSet);
begin
  tProveedor.Transaction.CommitRetaining;
end;

procedure TDM.tProveedorBeforeEdit(DataSet: TDataSet);
begin
  tProveedor.Transaction.StartTransaction;
end;

procedure TDM.tProveedorBeforeInsert(DataSet: TDataSet);
begin
  tProveedor.Transaction.StartTransaction;
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
    c:=IntToStr(UltimoRegistro('Imprimir', 'CODIGO'));
//    Query.SQL.Text :=
    BaseDatosFB.ExecSQL(
      'INSERT INTO "Imprimir" (CODIGO, DESCRIPCION, REPORTE) VALUES ('+c+', '+QuotedStr(reporte)+', '+QuotedStr(reporte)+')'
    );
//    Query.ExecSQL;
//    Query.Transaction.Commit;
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

function TDM.UltimoRegistroSdb(T, c: String): integer;
var v : Variant;
begin
    v := sdb.ExecSQLScalar('Select Max ( '+c+' ) From "'+T+'"');
    if v=null then v:=0;
    result := v+1;
end;

procedure TDM.FDTable1AfterPost(DataSet: TDataSet);
begin
  FDTable1.Transaction.CommitRetaining;
end;

procedure TDM.FDTable1BeforeEdit(DataSet: TDataSet);
begin
  FDTable1.Transaction.StartTransaction;
end;

procedure TDM.FDTable1BeforeInsert(DataSet: TDataSet);
begin
  FDTable1.Transaction.StartTransaction;
end;

procedure TDM.FormatearFecha;
begin
  with FormatSettings do
  begin
    DecimalSeparator := '.';
    ThousandSeparator := ',';
    ListSeparator := ';';
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
    else result:='0';
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
      CrearCbtetipo;
      CrearTablasSiap;
      CrearTablaRetPer;
      CrearTablasIva;
      CrearTablaCbteAsoc;
      ActualizarTriggerFecha;
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
    BaseDatosFB.ExecSQL(
//    IBScript1.Script.Text := 'SET NAMES WIN1252; CONNECT ' + quotedstr(BaseDeDatos)
//        +' USER ''SYSDBA'' PASSWORD ''masterkey''; '
        ' ALTER TABLE "'+(TB_NAME)+'" ADD '+(FLD_NAME)+' '+(TYP_NAME)+';'
      );
//    IBScript1.ExecuteScript;
//    IBScript1.Transaction.CommitRetaining;
  end;
end;

procedure TDM.CrearTabla;
begin
  if not ExisteEnTabla(TB_NAME, '') then
  begin
    BaseDatosFB.ExecSQL(
//    IBScript1.Script.Text := 'SET NAMES WIN1252; CONNECT '+QuotedStr(BaseDeDatos)
//      +' USER ''SYSDBA'' PASSWORD ''masterkey''; '
      ' CREATE TABLE "'+(TB_NAME)+'" ( '+(FLD_NAME)+' '+TYP_NAME+' )'
      );
//    IBScript1.ExecuteScript;
  end;
end;

procedure TDM.ActualizarIVA;
begin
//  Query.SQL.Text :=
    BaseDatosFB.ExecSQL(
     'INSERT INTO "Iva" (CODIGO, TASA) VALUES ('+CODIGO+', '+TASA+')'
    );
//  Query.ExecSQL;
//  Query.Transaction.Commit;
end;

function TDM.TraerValor;
begin
  Query.SQL.Text :=
    'SELECT '+campo+' FROM "'+tabla+'"';
    if codigo<>'' then
      Query.SQL.Text := Query.SQL.Text + ' WHERE CODIGO='+codigo;
  Query.Open;
  result := Query.Fields.Fields[0].AsString;
  if result='' then result:='0';
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

function TDM.TraerValorX;
begin
  Query.SQL.Text :=
    'SELECT '+campo+' FROM "'+tabla+'"';
    if codigo<>'' then
      Query.SQL.Text := Query.SQL.Text + ' WHERE '+codigo+'='+valor;
  Query.Open;
  result := Query.Fields.Fields[0].AsString;
end;

procedure TDM.tRubroAfterPost(DataSet: TDataSet);
begin
  tRubro.Transaction.CommitRetaining;
end;

procedure TDM.tRubroBeforeEdit(DataSet: TDataSet);
begin
  tRubro.Transaction.StartTransaction;
end;

procedure TDM.tRubroBeforeInsert(DataSet: TDataSet);
begin
  tRubro.Transaction.StartTransaction;
end;

procedure TDM.tSubCategoriaAfterPost(DataSet: TDataSet);
begin
  tSubCategoria.Transaction.CommitRetaining;
end;

procedure TDM.tSubCategoriaBeforeEdit(DataSet: TDataSet);
begin
  tSubCategoria.Transaction.StartTransaction;
end;

procedure TDM.tSubCategoriaBeforeInsert(DataSet: TDataSet);
begin
  tSubCategoria.Transaction.StartTransaction;
end;

procedure TDM.tUsuarioAfterPost(DataSet: TDataSet);
begin
  tUsuario.Transaction.CommitRetaining;
end;

procedure TDM.tUsuarioBeforeEdit(DataSet: TDataSet);
begin
  tUsuario.Transaction.StartTransaction;
end;

procedure TDM.tUsuarioBeforeInsert(DataSet: TDataSet);
begin
  tUsuario.Transaction.StartTransaction;
end;

procedure TDM.tVendedorAfterInsert(DataSet: TDataSet);
begin
  with tVendedor do begin
    FieldByName('CtaTipo').AsString := '50';
    FieldByName('CtaNombre').AsString := '50';
    FieldByName('CtaAnticipo').AsString := '25';
  end;
end;

procedure TDM.tVendedorAfterPost(DataSet: TDataSet);
begin
  tVendedor.Transaction.CommitRetaining;
end;

procedure TDM.tVendedorBeforeEdit(DataSet: TDataSet);
begin
  tVendedor.Transaction.StartTransaction;
end;

procedure TDM.tVendedorBeforeInsert(DataSet: TDataSet);
begin
  tVendedor.Transaction.StartTransaction;
end;

procedure TDM.AgregarValor;
begin
//  Query.SQL.Text :=
    BaseDatosFB.ExecSQL(
      'INSERT INTO "'+tabla+'" ('+campo+') VALUES ('+valor+')'
    );
//  Query.ExecSQL;
//  Query.Transaction.Commit;
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
//  Query.SQL.Text :=
//    'update "'+tabla+'" set '+campo+'='+valor;
//  if codigo<>'' then Query.SQL.Text := Query.SQL.Text+' where CODIGO='+codigo;
//  Query.ExecSQL;
//  Query.Transaction.Commit;
//  with IBScript1 do
//  begin
      if codigo<>'' then codigo := ' where CODIGO='+codigo;
//      Script.Text := 'SET NAMES WIN1252; CONNECT ' + quotedstr(BaseDeDatos)
//        +' USER ''SYSDBA'' PASSWORD ''masterkey''; '
        BaseDatosFB.ExecSQL(
          ' update "'+(tabla)+'" set '+(campo)+'='+(valor)+codigo+';'
        );
//      ExecuteScript;
//      with Transaction do
//      begin
//        if not Active then StartTransaction;
//        CommitRetaining;
//      end;
//  end;
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
       Connection := BaseDatosFB;
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
  sdb.ExecSQL('CREATE TABLE IF NOT EXISTS CbteTipo ('//Siap Comprobantes de Ventas
    +'Codigo INTEGER PRIMARY KEY,'
    +'Letra TEXT,'
    +'Desc TEXT'
   +');');
//   with TFDTable.Create(nil) do // create a temporary TTable component
//   begin
//     try
//       { set properties of the temporary TTable component }
//       Active := False;
//       DatabaseName := ;
//       Connection := sdb;
//       TableName := 'CbteTipo';
//       TableType := ttDefault;
//       { define fields for the new table }
//       FieldDefs.Clear;
//       FieldDefs.Add('Codigo', ftInteger);
//       FieldDefs.Add('Letra', ftString, 10, False);
//       FieldDefs.Add('Desc', ftString, 255, False);
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
//       TableFound := Exists; // check whether the table already exists
//       if TableFound then
//         if MessageDlg('Overwrite existing table ' + nombre + '?',
//              mtConfirmation, mbYesNoCancel, 0) = mrYes then
//           TableFound := False;
//        if not TableFound then
//        begin
//          CreateTable(False); // create the table
//          Open;
//          Insert;
//          Fields.Fields[0].Value := FloatToStr(v1);
  with tCbteTipo do
  begin
    Open('Select * from CbteTipo');
    if RowsAffected=0 then
    begin
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
  //        end;
  //     finally
  //       Free; // destroy the temporary TTable when done
     end;
   end;
end;

 procedure TDM.CrearTablasSiap;
 begin
//  ActualizarTabla('LibroIVAventa', 'CBTETIPO', 'VARCHAR(255)');
//  ActualizarTabla('LibroIVAventa', 'PTOVTA', 'VARCHAR(255)');
//  ActualizarTabla('LibroIVAventa', 'CBTEDESDE', 'VARCHAR(255)');
//  ActualizarTabla('LibroIVAventa', 'CBTEHASTA', 'VARCHAR(255)');
//  ActualizarTabla('LibroIVAventa', 'DOCTIPO', 'VARCHAR(255)');
//  ActualizarTabla('LibroIVAventa', 'NOMCLI', 'VARCHAR(255)');
//  ActualizarTabla('LibroIVAventa', 'MONID', 'VARCHAR(255)');
//  ActualizarTabla('LibroIVAventa', 'MONCOTIZ', 'VARCHAR(255)');
//  ActualizarTabla('LibroIVAventa', 'CANTIVA', 'VARCHAR(255)');
//  ActualizarTabla('LibroIVAventa', 'OPCION', 'VARCHAR(255)');
//  ActualizarTabla('LibroIVAventa', 'FCHVTOPAGO', 'VARCHAR(255)');
//  ActualizarTabla('LibroIVAventa', 'ALICIVA', 'VARCHAR(255)');
//  ActualizarTabla('LibroIVAventa', 'IMPNETO', 'VARCHAR(255)');
//  ActualizarTabla('LibroIVAventa', 'NOGRABADO', 'VARCHAR(255)');
//  ActualizarTabla('LibroIVAventa', 'IMPOPEX', 'VARCHAR(255)');
//  ActualizarTabla('LibroIVAventa', 'IMPIVA', 'VARCHAR(255)');
//  ActualizarTabla('LibroIVAventa', 'GENERALES', 'VARCHAR(255)');
//  ActualizarTabla('LibroIVAventa', 'NOCAT', 'VARCHAR(255)');
//  ActualizarTabla('LibroIVAventa', 'IMPTRIB', 'VARCHAR(255)');
sdb.ExecSQL('CREATE TABLE IF NOT EXISTS SiapVtaComp ('//Siap Comprobantes de Ventas
  +'Codigo INTEGER,'
  +'CbteFch TEXT,'//FECHA Formato dd/mm/aaaa
  +'CbteTipo TEXT,'//COMPROBANTES Tipo
  +'PtoVta TEXT,'//COMPROBANTES PV
  +'CbteDesde TEXT,'//COMPROBANTES Número Desde
  +'CbteHasta TEXT,'//COMPROBANTES Número Hasta
  +'DocTipo TEXT,'//CLIENTE	"Código de Documento del Comprador"
  +'DocNro TEXT,'//CLIENTE CUIT
  +'DocNomb TEXT,'//CLIENTE Apellido y Nombre del Cliente
  +'MonId TEXT,'//Moneda
  +'MonCotiz TEXT,'//Tipo de cambio
  +'IvaCant TEXT,'//Cantidad alícuotas I.V.A.
  +'CodOper TEXT,'//Código de operación
  +'FchVtoPago TEXT,'//Fecha vto. pago (formato aaaa/mm/dd)
  +'IvaId TEXT,'//Código alícuota IVA
  +'ImpNeto TEXT,'//Neto Gravado
  +'ImpNoGra TEXT,'//Monto que no integra el precio neto gravado
  +'ImpOpEx TEXT,'//Operaciones Exentas
  +'ImpIva TEXT,'//I.V.A.
  +'ImpPercGral TEXT,'//PERCEPCIONES Generales
  +'ImpPercNoCat TEXT,'//PERCEPCIONES No Cat.
  +'ImpPercIIBB TEXT,'//PERCEPCIONES IIBB
  +'ImpPercMuni TEXT,'//PERCEPCIONES Municipales
  +'ImpImpInt TEXT,'//Impuestos Internos
  +'ImpOtrTrib TEXT,'//Otros Tributos
  +'ImpTotal TEXT'//Totales (cálculo automático)
+')');

sdb.ExecSQL('CREATE TABLE IF NOT EXISTS SiapVtaCompAlicuota ('//Siap Comprobantes de Compras
  +'Codigo INTEGER,'
  +'IvaId TEXT,'//Código alícuota IVA
  +'IvaBaseImp TEXT,'//Neto Gravado alícuota
  +'IvaAlic TEXT'//IVA alícuota
+')');

sdb.ExecSQL('CREATE TABLE IF NOT EXISTS SiapCmpComp ('//Siap Comprobantes de Compras
  +'Codigo INTEGER,'
  +'CbteFch TEXT,'//FECHA Formato dd/mm/aaaa	L8
  +'CbteTipo TEXT,'//COMPROBANTES Tipo	L3
  +'PtoVta TEXT,'//COMPROBANTES PV	L5
  +'CbteNro TEXT,'//COMPROBANTES Número		L20
  +'DespNro TEXT,'//COMPROBANTES Número Despacho  de Importación	L16
  +'DocTipo TEXT,'//PROVEEDOR Código de Documento del vendedor	L2
  +'DocNro TEXT,'//PROVEEDOR Número de identificaión del vendedor	L20
  +'DocNomb TEXT,'//PROVEEDOR Apellido y Nombre del vendedor	L30
  +'ImpTotal TEXT,'//Totales (cálculo automático)	L15
  +'ImpNoGra TEXT,'//Monto que no integra el precio neto gravado	L15
  +'ImpOpEx TEXT,'//Operaciones Exentas	L15
  +'ImpPercIva TEXT,'//PERCEPCIONES Percepc y retenc. IVA	L15
  +'ImpPercNac TEXT,'//PERCEPCIONES Perc. otros imp. Nac.	L15
  +'ImpPercIIBB TEXT,'//PERCEPCIONES IIBB	L15
  +'ImpPercMuni TEXT,'//PERCEPCIONES Municipales	L15
  +'ImpImpInt TEXT,'//Impuestos Internos	L15
  +'MonId TEXT,'//Código de Moneda	L3
  +'MonCotiz TEXT,'//Tipo de cambio	L10
  +'IvaCant TEXT,'//Cantidad alícuotas I.V.A.	L1
  +'CodOper TEXT,'//Código de operación	L1
  +'ImpCredFisc TEXT,'//Credito Fiscal Computable	L15
  +'ImpOtrTrib TEXT,'//Otros Tributos	L15
  +'CUIT TEXT,'//CUIT emisor/corredor	L11
  +'Denom TEXT,'//Denominación emisor/corredor	L30
  +'ImpIvaCom TEXT'//IVA comisión	L15
//  +'IvaId1 TEXT,'//Código alícuota IVA 1
//  +'IvaBaseImp1 TEXT,'//Neto Gravado alícuota 1 Importe Total
//  +'IvaAlic1 TEXT,'//IVA alícuota 1
//  +'IvaId2 TEXT,'//Código alícuota IVA 2
//  +'IvaBaseImp2 TEXT,'//Neto Gravado alícuota 2 Importe Total
//  +'IvaAlic2 TEXT,'//IVA alícuota 2
//  +'IvaId3 TEXT,'//Código alícuota IVA 3
//  +'IvaBaseImp3 TEXT,'//Neto Gravado alícuota 3 Importe Total
//  +'IvaAlic3 TEXT'//IVA alícuota 3
+')');

sdb.ExecSQL('CREATE TABLE IF NOT EXISTS SiapCmpCompAlicuota ('//Siap Comprobantes de Compras
  +'Codigo INTEGER,'
  +'IvaId TEXT,'//Código alícuota IVA
  +'IvaBaseImp TEXT,'//Neto Gravado alícuota
  +'IvaAlic TEXT'//IVA alícuota
+')');

 end;

 procedure TDM.ConectarSDB;
 var
  sdbNombre : string;
 begin
  with sdb do
  begin
//    path := TPath.GetDocumentsPath()+'\Civeloo\GeN\db';
    sdbNombre := Path+'db\db.sdb';
//    if not FileExists(sdbNombre) then
//      ForceDirectories(path);
    Params.Values['database'] := sdbNombre;
    Connected:= True;
  end;
 end;

function TDM.ObtenerValor;
var
  vQuery : TFDQuery;
begin
  if codigo<>'' then  codigo := ' WHERE '+codigo+'='+valor;
  vQuery := TFDQuery.Create(nil);
  with vQuery do
  begin
    Connection:=sdb;
    try
      Open('SELECT '+campo+' FROM ' + tabla + codigo);
      result := Fields.Fields[0].AsString;
      if result='' then result:='0';
    finally
      vQuery.Free;
    end;
  end;
end;

procedure TDM.CrearMtIva;
begin
  with mtIVA do
  begin
//   with TFDTable.Create(nil) do // create a temporary TTable component
//   begin
     try
//       { set properties of the temporary TTable component }
       Active := False;
//       DatabaseName := ;
//       Connection := sdb;
//       Table := 'IVA';
//       TableType := ttDefault;
//       { define fields for the new table }
       FieldDefs.Clear;
       FieldDefs.Add('Tasa', ftCurrency);
       FieldDefs.Add('Neto', ftCurrency);
       FieldDefs.Add('Imp', ftCurrency);
       { define indexes for the new table }
//       IndexDefs.Clear;
//       with IndexDefs.AddIndexDef do begin
//         Name := '';
//         Fields := 'First';
//         Options := [ixPrimary];
//       end;
//       TableFound := Exists; // check whether the table already exists
//       if TableFound then
//         if MessageDlg('Overwrite existing table ' + nombre + '?',
//              mtConfirmation, mbYesNoCancel, 0) = mrYes then
//           TableFound := False;
//        if not TableFound then
//        begin
          CreateDataSet; // create the table
          Open;
//          Insert;
//          Fields.Fields[0].Value := FloatToStr(v1);
//        end;
     finally

     end;
  end;
end;

procedure TDM.AgregarMtIva;
begin
  with mtIVA do
    begin
      if Locate('Tasa',tasa,[]) then
        Edit
      else
      begin
        Insert;
        FieldByName('Tasa').AsFloat := tasa;
      end;
      FieldByName('Neto').AsFloat := FieldByName('Neto').AsFloat + neto;
      FieldByName('Imp').AsFloat := FieldByName('Imp').AsFloat + imp;
      Post;
    end;
end;

procedure TDM.VaciarMtIva;
var i :Integer;
begin
  i:= mtIVA.RecordCount;
  with mtIVA do
  begin
    First;
    while RecordCount>0 do
    begin
      Delete;
      Next;
    end;
  end;
end;

function  TDM.CalcularIVA;
begin
//  if porcentaje = 105 then porcentaje := 10.5;
  if porcentaje<100 then porcentaje:=(porcentaje*10);
  Result := monto*(porcentaje/1000+1);
end;

function  TDM.SacarIVA;
begin
//  if porcentaje = 105 then porcentaje := 10.5;
  if porcentaje<100 then porcentaje:=(porcentaje*10);
  Result := monto-monto/(porcentaje/1000+1);
end;

procedure TDM.tArticuloAfterInsert(DataSet: TDataSet);
begin
  with tArticulo do begin
    FieldByName('CtaNombre').AsString := '13';
    FieldByName('CtaTipo').AsString := '13';
    FieldByName('CtaAnticipo').AsString := '13';
    FieldByName('CtaIIBB').AsString := '66';
//    FieldByName('CODIGOBARRA').AsString := '0';
    FieldByName('Color').AsString := '0';
    FieldByName('Categoria').AsString := '0';
    FieldByName('SubCategoria').AsString := '0';
    FieldByName('Rubro').AsString := '0';
    FieldByName('Marca').AsString := '0';
    FieldByName('Proveedor').Value := 1;
    FieldByName('Unidad').AsString := 'c/u';
    FieldByName('FechaCompUlt').AsDateTime := Date;
    FieldByName('Costo').AsFloat := 0;
    FieldByName('Disponible').AsInteger := 0;
    FieldByName('PORCENTAJE').AsFloat := 0;
    FieldByName('ImpOtros').AsInteger := 0;
    FieldByName('Tasa').AsInteger := 21;
    FieldByName('PRECIO').AsInteger := 0;
    FieldByName('IIBB').AsInteger := 0;
    FieldByName('CODIGO').AsInteger:=UltimoRegistro('Articulo', 'CODIGO');
  end;
end;

procedure TDM.tArticuloAfterPost(DataSet: TDataSet);
begin
  tArticulo.Transaction.CommitRetaining;
end;

procedure TDM.tArticuloBeforeEdit(DataSet: TDataSet);
begin
  tArticulo.Transaction.StartTransaction;
end;

procedure TDM.tArticuloBeforeInsert(DataSet: TDataSet);
begin
  tArticulo.Transaction.StartTransaction;
end;

procedure TDM.tCategoriaAfterPost(DataSet: TDataSet);
begin
  tCategoria.Transaction.CommitRetaining;
end;

procedure TDM.tCategoriaBeforeEdit(DataSet: TDataSet);
begin
  tCategoria.Transaction.StartTransaction;
end;

procedure TDM.tCategoriaBeforeInsert(DataSet: TDataSet);
begin
  tCategoria.Transaction.StartTransaction;
end;

procedure TDM.tClienteAfterInsert(DataSet: TDataSet);
begin
  with tCliente do begin
    FieldByName('CtaNombre').AsString := '9';
    FieldByName('CtaTipo').AsString := '9';
    FieldByName('CtaAnticipo').AsString := '9';
    FieldByName('Vendedor').AsString := '0';
  end;
end;

procedure TDM.tClienteAfterPost(DataSet: TDataSet);
begin
  tCliente.Transaction.CommitRetaining;
end;

procedure TDM.tClienteBeforeEdit(DataSet: TDataSet);
begin
  tCliente.Transaction.StartTransaction;
end;

procedure TDM.tClienteBeforeInsert(DataSet: TDataSet);
begin
  tCliente.Transaction.StartTransaction;
end;

procedure TDM.tConfiguracionAfterPost(DataSet: TDataSet);
begin
  tConfiguracion.Transaction.CommitRetaining;
end;

procedure TDM.tConfiguracionBeforeEdit(DataSet: TDataSet);
begin
  tConfiguracion.Transaction.StartTransaction;
end;

procedure TDM.tConfiguracionBeforeInsert(DataSet: TDataSet);
begin
  tConfiguracion.Transaction.StartTransaction;
end;

procedure TDM.tCuentaAfterPost(DataSet: TDataSet);
begin
  tCuenta.Transaction.CommitRetaining;
end;

procedure TDM.tCuentaBeforeEdit(DataSet: TDataSet);
begin
  tCuenta.Transaction.StartTransaction;
end;

procedure TDM.tCuentaBeforeInsert(DataSet: TDataSet);
begin
  tCuenta.Transaction.StartTransaction;
end;

procedure TDM.tEmpresaAfterPost(DataSet: TDataSet);
begin
  tEmpresa.Transaction.CommitRetaining;
end;

procedure TDM.tEmpresaBeforeEdit(DataSet: TDataSet);
begin
  tEmpresa.Transaction.StartTransaction;
end;

procedure TDM.tEmpresaBeforeInsert(DataSet: TDataSet);
begin
  tEmpresa.Transaction.StartTransaction;
end;

function TDM.TraerAlicuota;
begin
  result := TraerValorX('Iva','CODIGO','Tasa',tasa);
end;

function TDM.TraerTasaAlicuota;
begin
  result := TraerValorX('Iva','Tasa','CODIGO',codigo);
end;

function TDM.CantidadAlicIva;
begin
  result := TraerValorX('AlicIVA','Count(CODIGO)','CODIGO',codigo);
end;

function TDM.TraerCodLetra;
begin
  result := ObtenerValor('CbteTipo', 'Codigo', 'Letra',letra);
end;

function TDM.ObtenerNroComp;
begin
  case IndexStr(tipo, ['A', 'NCA', 'B', 'NCB', 'C','NCC' ]) of
    0 : result := NroA;
    1 : result := NroNCA;
    2 : result := NroB;
    3 : result := NroNCB;
    4 : result := NroC;
    5 : result := NroNCC;
    else result := IntToStr( ObtenerConfig('NroFactura') );
  end;
 if result='' then result:='0';
 result := IntToStr(StrToInt(result)+1);
end;

procedure TDM.ActualizarNroComp;
begin
  case IndexStr(tipo, ['A', 'NCA', 'B', 'NCB', 'C','NCC' ]) of
    0 : NroA := comp;
    1 : NroNCA := comp;
    2 : NroB := comp;
    3 : NroNCB := comp;
    4 : NroC := comp;
    5 : NroNCC := comp;
    else begin
      with Query do begin
        SQL.Text := 'Update "Config" Set NroFactura ='+comp;
        ExecSQL;
      end;
    end;
  end;
  EscribirINI;
end;

procedure TDM.CrearTablaRetPer;
begin
  sdb.ExecSQL('CREATE TABLE IF NOT EXISTS RetPer ('
    +' Codigo INTEGER'
    +', Tipo  TEXT'
    +', NoGra REAL'
    +', PagCueIva REAL'
    +', PagCueOtr REAL'
    +', PerIIBB REAL'
    +', PerImpMun REAL'
    +', ImpInt REAL'
    +', OtrTrib REAL'
  +')');
end;

procedure TDM.AgregarRetPer;
begin
  with qSdb do
    begin
      Open('Select * from RetPer where Codigo=:C and Tipo=:T',[codigo,tipo]);
      if RecordCount>0 then //Locate('Codigo',codigo,[]) then
        Edit
      else
      begin
        Insert;
        FieldByName('Codigo').asinteger := codigo;
      end;
      FieldByName('Tipo').AsString := tipo;
      FieldByName('NoGra').AsFloat := noGra;
      FieldByName('PagCueIva').AsFloat := pagCueIva;
      FieldByName('PagCueOtr').AsFloat := pagCueOtr;
      FieldByName('PerIIBB').AsFloat := perIIBB;
      FieldByName('PerImpMun').AsFloat := perImpMun;
      FieldByName('ImpInt').AsFloat := impInt;
      FieldByName('OtrTrib').AsFloat := otrTrib;
      Post;
    end;
end;

procedure TDM.AgregarSiapCmpCompAlicuota;
begin
  with qSdb do
    begin
      Open('Select * from SiapCmpCompAlicuota where Codigo=:C and IvaId=:I',[codigo,ivaId]);
      if RecordCount>0 then
        Edit
      else
      begin
        Insert;
        FieldByName('Codigo').AsInteger := codigo;
      end;
      FieldByName('IvaId').AsString := ivaId;
      FieldByName('IvaBaseImp').AsString := ivaBaseImp;
      FieldByName('IvaAlic').AsString := ivaAlic;
      Post;
    end;
end;

procedure TDM.AgregarSiapCompAlicuota(tipo: string; codigo: Integer; ivaId,
  ivaBaseImp, ivaAlic: String);
begin
  with qSdb do
    begin
      Open('Select * from Siap'+tipo+'CompAlicuota where Codigo=:C and IvaId=:I',[codigo,ivaId]);
      if RecordCount>0 then
        Edit
      else
      begin
        Insert;
        FieldByName('Codigo').AsInteger := codigo;
      end;
      FieldByName('IvaId').AsString := ivaId;
      FieldByName('IvaBaseImp').AsString := ivaBaseImp;
      FieldByName('IvaAlic').AsString := ivaAlic;
      Post;
    end;
end;

procedure TDM.AgregarSiapVtaCompAlicuota;
begin
  with qSdb do
    begin
      Open('Select * from SiapVtaCompAlicuota where Codigo=:C and IvaId=:I',[codigo,ivaId]);
      if RecordCount>0 then
        Edit
      else
      begin
        Insert;
        FieldByName('Codigo').AsInteger := codigo;
      end;
      FieldByName('IvaId').AsString := ivaId;
      FieldByName('IvaBaseImp').AsString := ivaBaseImp;
      FieldByName('IvaAlic').AsString := ivaAlic;
      Post;
    end;
end;

procedure TDM.ActualizarTrigger;
begin
//    IBScript1.Script.Text := 'SET NAMES WIN1252; CONNECT ' + quotedstr(BaseDeDatos)
//      +' USER ''SYSDBA'' PASSWORD ''masterkey''; '
      BaseDatosFB.ExecSQL(
        ' ALTER TRIGGER "'+name+'"'
        +active
        +' POSITION 0'
        +' AS'
        +' BEGIN'
        +'   /* Trigger body */'
        +body
        +' END;'
      );
//    IBScript1.ExecuteScript;
//    IBScript1.Transaction.CommitRetaining;
end;

procedure TDM.ActualizarTriggerFecha;
var a,b:string;
begin
  a:=' ACTIVE BEFORE INSERT';
  b:=' IF (new."FECHA" IS NULL) THEN new."FECHA" = cast( ''now'' as timestamp);';
  ActualizarTrigger('CompraFecha_BI',a,b);
  ActualizarTrigger('ContratoFECHA_BI',a,b);
  ActualizarTrigger('CtaCteFECHAupdate',a,b);
  ActualizarTrigger('CtaCteFecha_BI',a,b);
  ActualizarTrigger('CtaCteItemFECHA_BI',a,b);
  ActualizarTrigger('FormaPagoFECHA_BI1',a,b);
  ActualizarTrigger('LibroDiarioFecha_BI',a,b);
  ActualizarTrigger('LibroIVAcompraFecha_BI',a,b);
  ActualizarTrigger('LibroIVAventaFecha_BI',a,b);
  ActualizarTrigger('MovCaja_FECHA',a,b);
  ActualizarTrigger('OperacionFECHA_BI',a,b);
  ActualizarTrigger('PresupuestoFecha_BI',a,b);
  ActualizarTrigger('RendidoVendedorFecha_BI',a,b);
  ActualizarTrigger('VentaFecha_BI',a,b);
end;

procedure TDM.ExportarTabla;
begin
    SaveDialog1.FileName := tabla+'.csv';
    SaveDialog1.Execute;
      try
        with FDTable1 do begin
          if Active then Active := False;
          TableName := '"'+tabla+'"';
          Active := True;
          DisableControls;
        end;
        //with TFDBatchMoveDataSetReader.Create(FDBatchMove1) do begin
        with FDBatchMoveDataSetReader1 do
        begin
          DataSet := FDTable1;
          Optimise := False;
        end;
        //with TFDBatchMoveTextWriter.Create(FDBatchMove1) do begin
        with FDBatchMoveTextWriter1 do
        begin
          // Set text data file name
          FileName := SaveDialog1.FileName;
          // Setup file format
          DataDef.Separator := ';';
          DataDef.WithFieldNames := True;
        end;
        with FDBatchMove1 do begin
          Reader := FDBatchMoveDataSetReader1;
          Writer := FDBatchMoveTextWriter1;
          // Use "always insert record" mode
          Mode := dmAlwaysInsert;
          // Erase destination dataset before moving data
          Options := [poClearDest];
          Execute;
        end;
      finally
        FDTable1.EnableControls;
        FDTable1.Active := False;
      end;
end;

procedure TDM.ImportarProveedor;
var
  i,id: integer;
  fDMemTable: TFDMemTable;
  fDBatchMove: TFDBatchMove;
begin
  OpenDialog1.Filter := 'Csv files (*.csv)|*.CSV';
//  opendialog1.InitialDir := GetCurrentDir;
  if OpenDialog1.Execute
    then
      begin
         fDMemTable := TFDMemTable.create(Self); // creamos
        fDBatchMove := TFDBatchMove.Create(Self);
//          dataSource1.DataSet := fdmemtable1;   // vinculamos la tabla al datasource
      //Create text reader and set FDBatchMode as owner. Then
  // FDBatchMove will automatically manage the reader instance.
  with TFDBatchMoveTextReader.Create(fDBatchMove)
  do begin
    // Set text data file name
    FileName := OpenDialog1.FileName;
    // Setup file format
    DataDef.Separator := ',';//edsepara.Text[1]; // ** indicamos separador de campos en este caso ';'
    DataDef.Delimiter := #0;//** opcional, para campos sin QUOTED VALUES "valor" que es la opción default del componente
    Datadef.RecordFormat := rfCustom; //**
     for i := 0 to Datadef.Fields.Count-1         //  ** para evitar problemas con campos FLOAT paso todos los campos a String.
            do  Datadef.Fields[i].DataType := atString;    // ** De no hacerlo he tenido errores [FireDAC][Comp][DM]-607. Bad text value [17,5] format for mapping item [->B]. '10,24' is not a valid integer value.
    for i := 0 to Datadef.Fields.Count-1         //  debemos antes agregar los campos el FDMentable sino obtenemos un error de que no puede crear el dataset.
            do  fDMemTable.FieldDefs.Add(Datadef.Fields[i].FieldName,ftString, 50, False);
    DataDef.WithFieldNames := True; // setear si tiene los nombres de campo en primera linea
  end;

  // Create dataset writer and set FDBatchMode as owner. Then
  // FDBatchMove will automatically manage the writer instance.
  with TFDBatchMoveDataSetWriter.Create(fDBatchMove) do begin
    // Set destination dataset
    DataSet := fDMemTable;
    // Do not set Optimise to True, if dataset is attached to UI
    Optimise := False;
  end;
  // Analyze source text file structure
  fDBatchMove.GuessFormat;
  fDBatchMove.Analyze := ([ taDelimSep,taHeader,taFields]); // este comando crea la estructura de datos según adivina leyendo los primeros registros
  fDBatchMove.AnalyzeSample := 50;  // El default es 10, con esto profundizamos el analisis para adivinar estructura de tabla y campos
      fDBatchMove.Execute;   // y Eureka!   Tenemos los datos en la tabla y visibles en el Dbgrid
    end;

  fDMemTable.first;

  while not fDMemTable.Eof do
  begin
    with qProveedor do
    begin
      id := fdmemtable.Fields.Fields[0].AsInteger;
      Open('SELECT * FROM "Proveedor" WHERE CODIGO=:I',[id]);
      if RecordCount>0 then
        Edit
      else
      begin
        Insert;
        Fields.Fields[0].AsInteger := id;
      end;
      Fields.Fields[1].AsString := fDMemTable.Fields.Fields[1].AsString;
      Fields.Fields[2].AsString := fDMemTable.Fields.Fields[2].AsString;
      Fields.Fields[3].AsString := fDMemTable.Fields.Fields[3].AsString;
      Fields.Fields[4].AsString := fDMemTable.Fields.Fields[4].AsString;
      Fields.Fields[5].AsString := fDMemTable.Fields.Fields[5].AsString;
      Fields.Fields[6].AsString := fDMemTable.Fields.Fields[6].AsString;
      Fields.Fields[7].AsString := fDMemTable.Fields.Fields[7].AsString;
      Fields.Fields[8].AsString := fDMemTable.Fields.Fields[8].AsString;
      Fields.Fields[9].AsString := fDMemTable.Fields.Fields[9].AsString;
      Fields.Fields[10].AsString := fDMemTable.Fields.Fields[10].AsString;
      Fields.Fields[11].AsString := fDMemTable.Fields.Fields[11].AsString;
      Fields.Fields[12].AsString := fDMemTable.Fields.Fields[12].AsString;
      Fields.Fields[13].AsString := fDMemTable.Fields.Fields[13].AsString;
      Fields.Fields[14].AsString := fDMemTable.Fields.Fields[14].AsString;
      Fields.Fields[15].AsString := fDMemTable.Fields.Fields[15].AsString;
      Fields.Fields[16].AsString := fDMemTable.Fields.Fields[16].AsString;
      Fields.Fields[17].AsString := fDMemTable.Fields.Fields[17].AsString;
      Fields.Fields[18].AsString := fDMemTable.Fields.Fields[18].AsString;
      Fields.Fields[19].AsString := fDMemTable.Fields.Fields[19].AsString;
      Fields.Fields[20].AsString := fDMemTable.Fields.Fields[20].AsString;
      Fields.Fields[21].AsString := fDMemTable.Fields.Fields[21].AsString;
      Fields.Fields[22].AsString := fDMemTable.Fields.Fields[22].AsString;
      Fields.Fields[23].AsString := fDMemTable.Fields.Fields[23].AsString;
      Fields.Fields[24].AsString := fDMemTable.Fields.Fields[24].AsString;
      Fields.Fields[25].AsString := fDMemTable.Fields.Fields[25].AsString;
      Fields.Fields[26].AsString := fDMemTable.Fields.Fields[26].AsString;
      Fields.Fields[27].AsString := fDMemTable.Fields.Fields[27].AsString;
      Fields.Fields[28].AsString := fDMemTable.Fields.Fields[28].AsString;
      Fields.Fields[29].AsString := fDMemTable.Fields.Fields[29].AsString;
      Fields.Fields[30].AsString := fDMemTable.Fields.Fields[30].AsString;
      Fields.Fields[31].AsString := fDMemTable.Fields.Fields[31].AsString;
      Fields.Fields[32].AsString := fDMemTable.Fields.Fields[32].AsString;
      Fields.Fields[33].AsString := fDMemTable.Fields.Fields[33].AsString;
      Fields.Fields[34].AsString := fDMemTable.Fields.Fields[34].AsString;
      Fields.Fields[35].AsString := fDMemTable.Fields.Fields[35].AsString;
      Fields.Fields[36].AsString := fDMemTable.Fields.Fields[36].AsString;
      Fields.Fields[37].AsString := fDMemTable.Fields.Fields[37].AsString;
      Fields.Fields[38].AsString := fDMemTable.Fields.Fields[38].AsString;
      Fields.Fields[39].AsString := fDMemTable.Fields.Fields[39].AsString;
      Fields.Fields[40].AsString := fDMemTable.Fields.Fields[40].AsString;
      Fields.Fields[41].AsString := fDMemTable.Fields.Fields[41].AsString;
      Fields.Fields[42].AsString := fDMemTable.Fields.Fields[42].AsString;
      Post;
    end;
    fDMemTable.Next
  end;
  fDMemTable.free;    //  destruimos componentes para eliminar datos default y cargados anteriormente
  fDBatchMove.Free;    //   idem anterior
  qProveedor.Close;
end;

procedure TDM.ImportarTabla;
var i:integer;
begin
  OpenDialog1.Filter := 'Csv files (*.csv)|*.CSV';
  OpenDialog1.Execute();
  try
    BaseDatosFB.StartTransaction;
    with FDBatchMoveTextReader1 do
    begin
      FileName := OpenDialog1.FileName;
      DataDef.Separator := ',';
      DataDef.FormatSettings.DecimalSeparator:=',';
      DataDef.FormatSettings.ThousandSeparator:=#0;
      DataDef.Delimiter := #0;  //** opcional, para campos sin QUOTED VALUES "valor" que es la opci�n default del componente
      Datadef.RecordFormat := rfCustom; //**
      for i := 0 to Datadef.Fields.Count-1         //  ** para evitar problemas con campos FLOAT paso todos los campos a String.
          do  Datadef.Fields[i].DataType := atString;    // ** De no hacerlo he tenido errores [FireDAC][Comp][DM]-607. Bad text value [17,5] format for mapping item [->B]. '10,24' is not a valid integer value.
//  for i := 0 to Datadef.Fields.Count-1         //  debemos antes agregar los campos el FDMentable sino obtenemos un error de que no puede crear el dataset.
//            do  fdmemtable1.FieldDefs.Add(Datadef.Fields[i].FieldName,ftString, 20, False);
      DataDef.WithFieldNames := True; // setear si tiene los nombres de campo en primera linea
    end;
    with FDBatchMoveSQLWriter1 do
    begin
      TableName := '"'+tabla+'"';
    end;
//    with FDBatchMoveDataSetWriter1 do
//    begin
//      DataSet:= tArticulo;
//      // Do not set Optimise to True, if dataset is attached to UI
//      Optimise := False;
//    end;
    with FDBatchMove1 do
    begin
      Reader := FDBatchMoveTextReader1;
      Writer := FDBatchMoveSQLWriter1;
//      Writer := FDBatchMoveDataSetWriter1;
      Mode := dmAppendUpdate;
      GuessFormat;
//Analyze := ([ taDelimSep,taHeader,taFields]); // este comando crea la estructura de datos seg�n adivina leyendo los primeros registros
//AnalyzeSample := 50;  // El default es 10, con esto profundizamos el analisis para adivinar estructura de tabla y campos
      Execute;
    end;
    BaseDatosFB.CommitRetaining;
  finally
//
  end;
end;

procedure TDM.CrearTablasIva;
begin
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
  end;
  if not ExisteEnTabla('AlicIva', '') then begin
    CrearTabla('AlicIva', 'CODIGO', 'INTEGER');
    ActualizarTabla('AlicIva', 'ID', 'INTEGER');
    ActualizarTabla('AlicIva', 'BASEIMP', 'DOUBLE PRECISION');
    ActualizarTabla('AlicIva', 'IMPORTE', 'DOUBLE PRECISION');
    ActualizarTabla('Operacion', 'ALICIVA', 'INTEGER');
    ActualizarTabla('Venta', 'ALICIVA', 'INTEGER');
    ActualizarTabla('CtaCte', 'ALICIVA', 'INTEGER');
    ActualizarTabla('Presupuesto', 'ALICIVA', 'INTEGER');
    ActualizarTabla('Compra', 'ALICIVA', 'INTEGER');
  end;
end;

procedure TDM.CrearTablaCbteAsoc;
begin
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
end;

function TDM.HayBase;
begin
  result := FileExists(Path+'db\GeN.FDB');
end;

function TDM.CalculaGanancia(c,f,p : double):double;
begin
  c := c+(c*(f)/100);
  result := RoundTo(((p*100)/c)-100,-2);
end;

end.
