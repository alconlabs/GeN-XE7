unit ImprimirDM;

interface

uses
  SysUtils, Classes, DataModule, Dialogs, frxClass, frxCrypt, frxGZip,
  frxGradient, frxChBox, frxRich, frxOLE, frxChart, frxExportCSV, frxExportHTML,
  frxExportPDF, frxDMPExport, frxBarcode, frxDBSet, Data.DB,
  IBX.IBCustomDataSet, IBX.IBQuery, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  ComObj, Windows, System.Variants;

type
  TImprimirDataModule = class(TDataModule)
    Query: TIBQuery;
    frxDBDataset1: TfrxDBDataset;
    frxReport1: TfrxReport;
    frxBarCodeObject1: TfrxBarCodeObject;
    frxDotMatrixExport1: TfrxDotMatrixExport;
    frxPDFExport1: TfrxPDFExport;
    frxHTMLExport1: TfrxHTMLExport;
    frxCSVExport1: TfrxCSVExport;
    frxChartObject1: TfrxChartObject;
    frxOLEObject1: TfrxOLEObject;
    frxRichObject1: TfrxRichObject;
    frxCheckBoxObject1: TfrxCheckBoxObject;
    frxGradientObject1: TfrxGradientObject;
    frxDotMatrixExport2: TfrxDotMatrixExport;
    frxGZipCompressor1: TfrxGZipCompressor;
    frxCrypt1: TfrxCrypt;
    VentasFDQuery1: TFDQuery;
    FDQuery1: TFDQuery;
    FirebirdConnection: TFDConnection;
    Function VTA(nro, let: string): string;
    Function OPER(nro, let: string): string;
    Function PRE(nro, let: string): string;
    Function PlanillaCobrador(nro, let: string): string;
    Function Contrato(nro, let: string): string;
    Function EAN(nro: string): string;
    Procedure Impr(vsql, reporte: string);
    Procedure CSV(sql, n: string);
    Procedure SImpr(vsql, reporte: string);
    procedure DataModuleCreate(Sender: TObject);
    procedure frxReport1BeforePrint(Sender: TfrxReportComponent);
    Procedure AfipWsaa(path, Certificado, ClavePrivada: string);
    Procedure AfipWsfev1(
    tipo_cbte, punto_vta, tipo_doc, presta_serv, id,
    cbt_desde, cbt_hasta : Integer;
    fecha, nro_doc, imp_total, imp_tot_conc, imp_neto, impto_liq,
    impto_liq_rni, imp_op_ex, fecha_cbte, fecha_venc_pago,
    fecha_serv_desde, fecha_serv_hasta, venc : String;
    moneda_id , moneda_ctz : String ;
    bi21, i21, bi105, i105: String
//      fecha, nro_doc, imp_total, imp_tot_conc, imp_neto,
//      impto_liq, impto_liq_rni, imp_op_ex, fecha_cbte, fecha_venc_pago,
//      fecha_serv_desde, fecha_serv_hasta, venc, moneda_id, moneda_ctz

//      tipo_cbte, punto_vta, tipo_doc, presta_serv, id, cbt_desde, cbt_hasta
//      : Double
      );
    Procedure AfipWsfev11;
  private
    { Private declarations }
  public
    { Public declarations }
    clienteSql, articuloSql, ventaItemSql, ivaVtaSql, presupuestoSql: string;
    WSAA: Variant;
  end;

var
  ImprimirDataModule: TImprimirDataModule;

implementation

{$R *.dfm}

uses OperacionDM;

Procedure TImprimirDataModule.AfipWsfev11;
var
WSFEv1: Variant;//,WSAA
tra, Certificado, ClavePrivada, cms, ta: String;//, path
qty, LastId, LastCBTE, cae, ok , OkUlt: Variant;
tipo_cbte, punto_vta, tipo_doc, presta_serv, id,
cbt_desde, cbt_hasta : Integer;
fecha, nro_doc, imp_total, imp_tot_conc, imp_neto, impto_liq,
impto_liq_rni, imp_op_ex, fecha_cbte, fecha_venc_pago,
fecha_serv_desde, fecha_serv_hasta, venc : String;
cache ,url_wsdl ,proxy : String ;
moneda_id , moneda_ctz : String ;
base_imp, importe : String ;
begin
////CoInitialize(nil);
//// Crear objeto interface Web Service Autenticación y Autorización
//WSAA := CreateOleObject('WSAA') ;
//// Generar un Ticket de Requerimiento de Acceso (TRA)
//tra := WSAA.CreateTRA;
//OutputDebugString(PChar(VarToStr(tra)));
//// Especificar la ubicacion de los archivos certificado y clave privada
//path := GetCurrentDir + '';
//// Certificado: certificado es el firmado por la AFIP
//// ClavePrivada: la clave privada usada para crear el certificado
//Certificado := 'C:\Civeloo\GeN\crt\certificado.crt'; // certificado de prueba
//ClavePrivada := 'C:\Civeloo\GeN\crt\privada.key'; // clave privada de prueba' +
//// Generar el mensaje firmado (CMS)
////cms := WSAA.SignTRA(tra, Path + Certificado, Path + ClavePrivada);
//cms := WSAA.SignTRA(tra, Certificado, ClavePrivada);
//OutputDebugString(PChar(VarToStr((cms))));
//// Llamar al web service para autenticar:
//ta := WSAA.CallWSAA(cms, 'https://wsaahomo.afip.gov.ar/ws/services/LoginCms'); // Hologación
////ta = WSAA.CallWSAA(cms, 'https://wsaa.afip.gov.ar/ws/services/LoginCms'); // Producción
//// Imprimir el ticket de acceso, ToKen y Sign de autorización
//OutputDebugString(PChar(VarToStr((ta))));
//showmessage(ta);
//OutputDebugString(PChar(VarToStr(('Token:' + WSAA.Token))));
//OutputDebugString(PChar(VarToStr(('Sign:' + WSAA.Sign))));
//// Una vez obtenido, se puede usar el mismo token y sign por 6 horas
//// (este período se puede cambiar)
AfipWsaa(path, 'crt\certificado.crt', 'crt\privada.key');

// Crear objeto interface Web Service de Factura Electrónica
cache := ''; // directorio temporal (usar predeterminado)
url_wsdl := 'https://wswhomo.afip.gov.ar/wsfev1/service.asmx?WSDL ';// usar servicios1 para producción
proxy:= '';

WSFEv1 := CreateOleObject('WSFEv1');

// Setear tocken y sing de autorización (pasos previos)
WSFEv1.Token := WSAA.Token;
WSFEv1.Sign := WSAA.Sign;
// CUIT del emisor (debe estar registrado en la AFIP)
WSFEv1.Cuit := '20314661967';
WSFEv1.LanzarExcepciones := False;
// Conectar al Servicio Web de Facturación
ok := WSFEv1.Conectar(cache, url_wsdl, proxy); // homologación
//ok := WSFE.Conectar('https://wsw.afip.gov.ar/wsfe/service.asmx'); // producción
// Llamo a un servicio nulo, para obtener el estado del servidor (opcional)
WSFEv1.Dummy;
OutputDebugString(PChar(VarToStr(('appserver status ' + WSFEv1.AppServerStatus))));
OutputDebugString(PChar(VarToStr(('dbserver status ' + WSFEv1.DbServerStatus))));
OutputDebugString(PChar(VarToStr(('authserver status ' + WSFEv1.AuthServerStatus))));
// Recupera cantidad máxima de registros (opcional)
//qty := WSFE.RecuperarQty;
// Recupera último número de secuencia ID
//LastId := WSFEv1.RecuperaLastCMP();
// Recupero último número de comprobante para un punto de venta y tipo (opcional)

tipo_cbte := 1; punto_vta := 1;
LastCBTE := WSFEv1.CompUltimoAutorizado(punto_vta, tipo_cbte) + 1; //+ 1

//WriteLn(WSFEv1.FECompUltimoAutorizado) ;

// Establezco los valores de la factura o lote a autorizar:
DateTimeToString(Fecha, 'yyyymmdd', Date);
id := LastId + 1; presta_serv := 3;
tipo_doc := 80; nro_doc := '27341273329';
cbt_desde := LastCBTE ;
cbt_hasta := LastCBTE ;
imp_total := '121.00'; imp_tot_conc := '0.00'; imp_neto := '100.00';
impto_liq := '21.00'; impto_liq_rni := '0.00'; imp_op_ex := '0.00';
fecha_cbte := Fecha; fecha_venc_pago := Fecha;
moneda_id := 'PES';
moneda_ctz := '1.000';

// Fechas del período del servicio facturado (solo si presta_serv = 1)
fecha_serv_desde := Fecha; fecha_serv_hasta := Fecha;

// Llamo al WebService de Autorización para obtener el CAE
ok := WSFEv1.CrearFactura ( presta_serv,
tipo_doc, nro_doc, tipo_cbte, punto_vta,
cbt_desde, cbt_hasta, imp_total, imp_tot_conc, imp_neto,
impto_liq, impto_liq_rni, imp_op_ex, fecha_cbte, fecha_venc_pago,
fecha_serv_desde, fecha_serv_hasta,moneda_id,moneda_ctz ); // si presta_serv = 0 no pasar estas fechas

//Agrego tasas de IVA
id := 5 ; // 21%
base_imp := '100.00';
importe := '21.00';
ok := WSFEv1.AgregarIva(id, base_imp, importe) ;
{If tipo_cbte = 1 Then // solo para facturas A
begin
ok := WSFEv1.AgregarOpcional(5, '02'); // IVA Excepciones (01: Locador/Prestador, 02: Conferencias, 03: RG 74, 04: Bienes de cambio, 05: Ropa de trabajo, 06: Intermediario).
ok := WSFEv1.AgregarOpcional(61, '80'); // Firmante Doc Tipo (80: CUIT, 96: DNI, etc.)
ok := WSFEv1.AgregarOpcional(62, '20267565393'); // Firmante Doc Nro
ok := WSFEv1.AgregarOpcional(7, '01'); // Car?er del Firmante (01: Titular, 02: Director/Presidente, 03: Apoderado, 04: Empleado)
End;}

WSFEv1.Reprocesar := True ;
//cae :=

cae := WSFEv1.CAESolicitar;
If WSFEv1.Excepcion <> '' Then
begin
  showmessage(WSFEv1.Excepcion) ;
  showmessage(WSFEv1.Traceback) ;
  showmessage(WSFEv1.XmlRequest) ;
  showmessage(WSFEv1.XmlResponse) ;
end;
showmessage( 'Resultado ' + WSFEv1.Resultado);
showmessage( 'CAE' + WSFEv1.CAE);

//' Imprimo pedido y respuesta XML para depuración (errores de formato)
OutputDebugString(PChar(VarToStr((WSFEv1.XmlRequest ))));
OutputDebugString(PChar(VarToStr(( WSFEv1.XmlResponse ))));
Showmessage( WSFEv1.XmlResponse );
If WSFEv1.errmsg <> '' Then
OutputDebugString(PChar(VarToStr((WSFEv1.errmsg))));

OutputDebugString(PChar(VarToStr(('Obs ' + WSFEv1.obs))));
OutputDebugString(PChar(VarToStr(('Resultado: ' + WSFEv1.Resultado))));
OutputDebugString(PChar(VarToStr(('cae: ' + WSFEv1.CAE))));

//cae := WSFEv1.CAE() ;
ShowMessage('CAE: ' + cae );
//showmessage('Presione Enter para terminar');
//ReadLn;
//CoUninitialize;
end;


Procedure TImprimirDataModule.AfipWsaa;
{ Ejemplo de Uso de Interface COM con Web Services AFIP (PyAfipWs)
  2009 (C) Mariano Reingart <mariano@nsis.com.ar> }
// program Project1;
// {$APPTYPE CONSOLE}
// uses
// ActiveX,
// ComObj,
// FMX.Dialogs,
// SysUtils;
var
  tra, cms, ta: String;
begin
  // CoInitialize(nil);
  // Crear objeto interface Web Service Autenticaci�n y Autorizaci�n
  WSAA := CreateOleObject('WSAA');
  // Generar un Ticket de Requerimiento de Acceso (TRA)
  tra := WSAA.CreateTRA;
OutputDebugString(PChar(VarToStr(tra)));// WriteLn(tra);
  // Especificar la ubicacion de los archivos certificado y clave privada
  // path := GetCurrentDir + '';
  // Certificado: certificado es el firmado por la AFIP
  // ClavePrivada: la clave privada usada para crear el certificado
  // Certificado := '\ghf.crt'; // certificado de prueba
  // ClavePrivada := '\ghf.key'; // clave privada de prueba' +
  // Generar el mensaje firmado (CMS)
  cms := WSAA.SignTRA(tra, path + Certificado, path + ClavePrivada);
OutputDebugString(PChar(VarToStr(cms)));// WriteLn(cms);
  // Llamar al web service para autenticar:
  ta := WSAA.CallWSAA(cms, 'https://wsaahomo.afip.gov.ar/ws/services/LoginCms');
  // Homologaci�n
  // ta = WSAA.CallWSAA(cms, 'https://wsaa.afip.gov.ar/ws/services/LoginCms'); // Producci�n
  // Imprimir el ticket de acceso, ToKen y Sign de autorizaci�n
OutputDebugString(PChar(VarToStr(ta)));// WriteLn(ta);
OutputDebugString(PChar(VarToStr('Token:' + WSAA.Token)));// WriteLn
OutputDebugString(PChar(VarToStr('Sign:' + WSAA.Sign)));// WriteLn
  // Una vez obtenido, se puede usar el mismo token y sign por 6 horas
  // (este per�odo se puede cambiar)
end;

Procedure TImprimirDataModule.AfipWsfev1;
var
  WSFEv1: Variant;//,WSAA
  tra, Certificado, ClavePrivada, cms, ta: String;//, path
  qty, LastId, LastCBTE, cae, ok , OkUlt: Variant;
  cache, url_wsdl, proxy: String;
begin
  AfipWsaa(path, 'crt\certificado.crt', 'crt\privada.key');
  cache := ''; // directorio temporal (usar predeterminado)
  url_wsdl := 'https://wswhomo.afip.gov.ar/wsfev1/service.asmx?WSDL ';// usar servicios1 para producción
  proxy:= '';
    // Crear objeto interface Web Service de Factura Electr�nica
  WSFEv1 := CreateOleObject('WSFEv1');
  // Setear tocken y sing de autorizaci�n (pasos previos)
  WSFEv1.Token := WSAA.Token;
  WSFEv1.Sign := WSAA.Sign;
  // CUIT del emisor (debe estar registrado en la AFIP)
//  WSFEv1.Cuit := '20314661967';//
  WSFEv1.Cuit := CUIT;
  WSFEv1.LanzarExcepciones := False;
  // Conectar al Servicio Web de Facturaci�n
  ok := WSFEv1.Conectar(cache, url_wsdl, proxy); // homologaci�n
  // ok := WSFE.Conectar('https://wsw.afip.gov.ar/wsfe/service.asmx'); // producci�n
  // Llamo a un servicio nulo, para obtener el estado del servidor (opcional)
  WSFEv1.Dummy;
OutputDebugString(PChar(VarToStr('appserver status ' + WSFEv1.AppServerStatus)));
OutputDebugString(PChar(VarToStr('dbserver status ' + WSFEv1.DbServerStatus)));//WriteLn
OutputDebugString(PChar(VarToStr('authserver status ' + WSFEv1.AuthServerStatus)));
  // Recupera cantidad m�xima de registros (opcional)
  // qty := WSFE.RecuperarQty;
  // Recupera �ltimo n�mero de secuencia ID
  // LastId := WSFEv1.RecuperaLastCMP();
  // Recupero �ltimo n�mero de comprobante para un punto de venta y tipo (opcional)
//tipo_cbte := 1;
//punto_vta := 1;
LastCBTE := WSFEv1.CompUltimoAutorizado(punto_vta, tipo_cbte); //+ 1
  if VarIsNull(LastCBTE) then  //?unassigned
    LastCBTE := 1
  else
    LastCBTE := LastCBTE + 1;// LastCBTE := WSFEv1.CompUltimoAutorizado(punto_vta, tipo_cbte) + 1;
//OutputDebugString(PChar(VarToStr(WSFEv1.FECompUltimoAutorizado)));
  // Establezco los valores de la factura o lote a autorizar:
DateTimeToString(Fecha, 'yyyymmdd', StrToDateTime(Fecha));
id := LastId + 1; presta_serv := 3;
cbt_desde := LastCBTE ;
cbt_hasta := LastCBTE ;
fecha_cbte := Fecha; fecha_venc_pago := Fecha;
  // Fechas del per�odo del servicio facturado (solo si presta_serv = 1)
fecha_serv_desde := Fecha; fecha_serv_hasta := Fecha;
  // Llamo al WebService de Autorizaci�n para obtener el CAE
ok := WSFEv1.CrearFactura ( presta_serv,
tipo_doc, nro_doc, tipo_cbte, punto_vta,
cbt_desde, cbt_hasta, imp_total, imp_tot_conc, imp_neto,
impto_liq, impto_liq_rni, imp_op_ex, fecha_cbte, fecha_venc_pago,
fecha_serv_desde, fecha_serv_hasta,moneda_id,moneda_ctz ); // si presta_serv = 0 no pasar estas fechas
//Agrego tasas de IVA
//id := 5 ; // 21%
//bi21 := '100.00';
//i21 := '21.00';
//ok := WSFEv1.AgregarIva(id, bi21, i21) ;
  if ((StrToFloat(i21) <> 0) or (StrToFloat(i105) <> 0)) then
  begin
    if (StrToFloat(i21) > 0) then
      ok := WSFEv1.AgregarIva(5, bi21, i21);
    if (StrToFloat(i105) > 0) then
      ok := WSFEv1.AgregarIva(6, bi105, i105);
  end;
  { If tipo_cbte = 1 Then // solo para facturas A
    begin
    ok := WSFEv1.AgregarOpcional(5, '02'); // IVA Excepciones (01: Locador/Prestador, 02: Conferencias, 03: RG 74, 04: Bienes de cambio, 05: Ropa de trabajo, 06: Intermediario).
    ok := WSFEv1.AgregarOpcional(61, '80'); // Firmante Doc Tipo (80: CUIT, 96: DNI, etc.)
    ok := WSFEv1.AgregarOpcional(62, '20267565393'); // Firmante Doc Nro
    ok := WSFEv1.AgregarOpcional(7, '01'); // Car?er del Firmante (01: Titular, 02: Director/Presidente, 03: Apoderado, 04: Empleado)
    End; }
  WSFEv1.Reprocesar := True;
  // cae :=
  cae := WSFEv1.CAESolicitar;
  If WSFEv1.Excepcion <> '' Then
  begin
    showmessage(WSFEv1.Excepcion);
  OutputDebugString(PChar(VarToStr(WSFEv1.Excepcion)));
    showmessage(WSFEv1.Traceback);
  OutputDebugString(PChar(VarToStr(WSFEv1.Traceback)));
    showmessage(WSFEv1.XmlRequest);
  OutputDebugString(PChar(VarToStr(WSFEv1.XmlRequest)));
    showmessage(WSFEv1.XmlResponse);
  OutputDebugString(PChar(VarToStr(WSFEv1.XmlResponse)));
  end;
  OutputDebugString(PChar(VarToStr('Resultado ' + WSFEv1.Resultado)));
  OutputDebugString(PChar(VarToStr('CAE' + WSFEv1.cae)));
  // ' Imprimo pedido y respuesta XML para depuraci�n (errores de formato)
  OutputDebugString(PChar(VarToStr(WSFEv1.XmlRequest)));
  OutputDebugString(PChar(VarToStr(WSFEv1.XmlResponse)));
  OutputDebugString(PChar(VarToStr(WSFEv1.XmlResponse)));
OutputDebugString(PChar(VarToStr( WSFEv1.XmlResponse )));
  If WSFEv1.errmsg <> '' Then
  OutputDebugString(PChar(VarToStr(WSFEv1.errmsg)));
  OutputDebugString(PChar(VarToStr('Obs ' + WSFEv1.obs)));
OutputDebugString(PChar(VarToStr( 'Resultado ' + WSFEv1.Resultado)));
  OutputDebugString(PChar(VarToStr('Resultado: ' + WSFEv1.Resultado)));
OutputDebugString(PChar(VarToStr( 'CAE' + WSFEv1.CAE)));
  OutputDebugString(PChar(VarToStr('cae: ' + WSFEv1.cae)));
  // cae := WSFEv1.CAE() ;
//  OutputDebugString(PChar(VarToStr('CAE: ' + cae)));
//  showmessage('Presione Enter para terminar');
  // ReadLn;
  // CoUninitialize;
end;

Procedure TImprimirDataModule.SImpr;
begin
  Query.sql.Text := vsql;
  Query.Open;
  with frxReport1 do
  begin
    LoadFromFile(path + 'rpt\' + reporte + '.fr3');
    try
      ShowReport(True);
    finally
      Free;
    end;
  end;
end;

Procedure TImprimirDataModule.CSV; // exporta consulta a excel
var
  m: TStringList;
  g: TSaveDialog;
  CSV: TextFile;
  col: string;
  // ? f,c :integer;
  c: Integer;
begin
  Query.sql.Text := sql;
  Query.Open;
  try
    m := TStringList.Create;
    g := TSaveDialog.Create(Self);
  finally
    g.Filter := 'Ficheros Excel (*.csv)|*.csv|Todos los ficheros|*.*';
    g.Title := n;
    g.DefaultExt := 'csv';
    g.FileName := n;
    // ingresa los campos
    for c := 0 to Query.FieldCount - 1 do // columnas
    begin
      col := col + '"' + Query.Fields.Fields[c].DisplayName + '",';
    end;
    m.Append(col);
    // ingresa el contenido
    while not Query.Eof do // filas
    begin
      col := '';
      for c := 0 to Query.FieldCount - 1 do // columnas
      begin
        col := col + '"' + Query.Fields.Fields[c].AsString + '",';
      end;
      m.Append(col);
      Query.Next;
    end;
    if g.Execute then
    begin
      assignFile(CSV, g.FileName);
      rewrite(CSV);
      write(CSV, m.Text);
      closeFile(CSV);
    end;
  end;
  m.Free;
  g.Free;
end;

procedure TImprimirDataModule.DataModuleCreate(Sender: TObject);
begin
  dm.ConfigQuery.Open;
  clienteSql :=
    ' "Cliente".NOMBRE,  "Cliente".TITULAR, "Cliente".DIRECCION, "Cliente".DIRECCIONCOMERCIAL, "Cliente".IVA as CIVA, "Cliente".CUIT as CCUIT';
  articuloSql :=
    ' "Articulo".DESCRIPCION, "Articulo".UNIDAD, "Articulo".IVA as AIVA';
  ventaItemSql :=
    ' "VentaItem".ARTICULO, "VentaItem".CANTIDAD, "VentaItem".PRECIO, "VentaItem".OPERACION, ("VentaItem".PRECIO * "VentaItem".CANTIDAD ) as PREXCANT, "VentaItem".SERVICIO, "VentaItem".DESCRIPCION AS DESCR, "VentaItem".IMPUESTO as VIIMPUESTO';
  ivaVtaSql := ' "LibroIVAventa".NG1, "LibroIVAventa".IVA1, "LibroIVAventa".NG2, "LibroIVAventa".IVA2, "LibroIVAventa".NG3';
  presupuestoSql := clienteSql + ',' + articuloSql + ',' +
    ' "PresupuestoItem".ARTICULO, "PresupuestoItem".CANTIDAD, "PresupuestoItem".PRECIO,'
    + ' "PresupuestoItem".OPERACION, ("PresupuestoItem".PRECIO * "PresupuestoItem".CANTIDAD ) as PREXCANT,'
    + ' "PresupuestoItem".SERVICIO, "PresupuestoItem".IMPUESTO as VIIMPUESTO, "PresupuestoItem".DESCRIPCION AS DESCR,'
    + ' "Presupuesto".CODIGO, "Presupuesto".LETRA, "Presupuesto".FECHA, "Presupuesto".COMPROBANTE,'
    + ' "Presupuesto".IVA3, "Presupuesto".TOTAL, "Presupuesto".CONTADO, "Presupuesto".CLIENTE,'
    + ' "Presupuesto".SUBTOTAL, "Presupuesto".DESCUENTO, "Presupuesto".IMPUESTO,'
    + ' "Presupuesto".IVA2, "Presupuesto".IVA1, "Presupuesto".EXCENTO, "Presupuesto".SALDO,'
    + ' "Presupuesto".PAGADO' + ' FROM "Presupuesto"' +
    ' INNER JOIN "PresupuestoItem" ON ("Presupuesto".CODIGO = "PresupuestoItem".OPERACION)'
    + ' INNER JOIN "Articulo" ON ("PresupuestoItem".ARTICULO = "Articulo".CODIGO)'
    + ' INNER JOIN "Cliente" ON ("Presupuesto".CLIENTE = "Cliente".CODIGO)';
end;

procedure TImprimirDataModule.frxReport1BeforePrint
  (Sender: TfrxReportComponent);
begin
  // if Sender.Name = 'LOGO' then
  // begin
  // TfrxPictureView(Sender).Visible := True;
  // TfrxPictureView(Sender).Picture.LoadFromFile(path + 'img\empresa.BMP');
  // end;
end;

procedure TImprimirDataModule.Impr;
var
  Pict, Pict2, Pict3, Pict4: TfrxPictureView;
  tipo_cbte: Integer;
begin
  if reporte = '' then
    reporte := dm.ConfigQuery.FieldByName('Reporte').AsString;
  Query.sql.Text := 'SELECT ' + QuotedStr(dm.ConfigQuery.FieldByName('CODIGO')
    .AsString) + ' As PtoVta,' + QuotedStr(dm.ConfigQuery.FieldByName('NOMBRE')
    .AsString) + ' As Empresa,' +
    QuotedStr(dm.ConfigQuery.FieldByName('TITULAR').AsString) + ' As ETITULAR,'
    + QuotedStr(dm.ConfigQuery.FieldByName('IVA').AsString) + ' As EIVA,' +
    QuotedStr(dm.ConfigQuery.FieldByName('CODIGOAREA').AsString) +
    ' As ECODIGOAREA,' + QuotedStr(dm.ConfigQuery.FieldByName('TELEFONO')
    .AsString) + ' As ETELEFONO,' +
    QuotedStr(dm.ConfigQuery.FieldByName('DIRECCIONCOMERCIAL').AsString) +
    ' As EDIRECCIONCOMERCIAL,' + QuotedStr(dm.ConfigQuery.FieldByName('CP')
    .AsString) + ' As ECP,' + QuotedStr(dm.ConfigQuery.FieldByName('CIUDAD')
    .AsString) + ' As ECIUDAD,' +
    QuotedStr(dm.ConfigQuery.FieldByName('DEPARTAMENTO').AsString) +
    ' As EDEPARTAMENTO,' + QuotedStr(dm.ConfigQuery.FieldByName('PROVINCIA')
    .AsString) + ' As EPROVINCIA,' +
    QuotedStr(dm.ConfigQuery.FieldByName('CUIT').AsString) + ' As ECUIT,' +
    QuotedStr(FormatDateTime('dd/mm/yyyy', dm.ConfigQuery.FieldByName('FECHA')
    .AsDateTime)) + ' As EFECHA,' + QuotedStr(dm.ConfigQuery.FieldByName('IIBB')
    .AsString) + ' As EIIBB,' + vsql;
  Query.Open;
  with frxReport1 do
  begin
    LoadFromFile(path + 'rpt\' + reporte + '.fr3');
    if (reporte = 'COriginal') or (reporte = 'Presupuesto') or
      (reporte = 'FElectronica') then
    begin
      // Pict:= frReport1.FindObject('MyImage') as TfrxPictureView;
      Pict := TfrxPictureView(frxReport1.FindObject('Picture1'));
      if Assigned(Pict) then
        Pict.Picture.LoadFromFile(path + 'img\empresa.BMP');
      if (reporte = 'FElectronica') then // wsfev1
      begin

        if (Query.FieldByName('COMPROBANTE').AsString = 'A') then
          tipo_cbte := 1
        else
          tipo_cbte := 0;

//        AfipWsfev1(Query.FieldByName('FECHA').AsString
//          // DateTimeToString(fecha, 'yyyymmdd', Date), //fecha
//          ,Query.FieldByName('CCUIT').AsString // nro_doc
//          ,Query.FieldByName('TOTAL').AsString // imp_total
//          ,'0'//'0.00', // imp_tot_conc,
//          ,Query.FieldByName('SUBTOTAL').AsString // imp_neto
//          ,Query.FieldByName('IMPUESTO').AsString // impto_liq
//          ,'0'//'0.00', // impto_liq_rni
//          ,'0'//'0.00', // imp_op_ex
//          ,Query.FieldByName('FECHA').AsString // fecha_cbte
//          ,Query.FieldByName('FECHA').AsString // fecha_venc_pago
//          ,Query.FieldByName('FECHA').AsString // fecha_serv_desde
//          ,Query.FieldByName('FECHA').AsString // fecha_serv_hasta
//          ,Query.FieldByName('FECHA').AsString // venc
//          ,'PES' // moneda_id
//          ,'1.000' // moneda_ctz
//          ,Query.FieldByName('NG2').AsString // bi21
//          ,Query.FieldByName('IVA2').AsString // i21
//          ,Query.FieldByName('NG1').AsString // bi105
//          ,Query.FieldByName('IVA1').AsString // i105
//          ,tipo_cbte // tipo_cbte
//          ,Query.FieldByName('PtoVta').AsInteger // punto_vta
//          ,80 // tipo_doc
//          ,3 // ?presta_serv
//          ,Query.FieldByName('CODIGO').AsInteger // id
//          ,0 // cbt_desde
//          ,0 // cbt_hasta
//          );
          AfipWsfev1(
          tipo_cbte// tipo_cbte
          ,Query.FieldByName('PtoVta').AsInteger// punto_vta
          ,80// tipo_doc
          ,0// presta_serv
          ,0// id
          ,0// cbt_desde
          ,0// cbt_hasta : Integer;
          ,Query.FieldByName('FECHA').AsString// fecha
          ,Query.FieldByName('CCUIT').AsString// nro_doc
          ,Query.FieldByName('TOTAL').AsString// imp_total
          ,'0.00'// imp_tot_conc
          ,Query.FieldByName('SUBTOTAL').AsString// imp_neto
          ,Query.FieldByName('IMPUESTO').AsString// impto_liq
          ,'0.00'// impto_liq_rni
          ,'0.00'// imp_op_ex
          ,'20170425'// fecha_cbte
          ,'20170425'// fecha_venc_pago
          ,'20170425'// fecha_serv_desde
          ,'20170425'// fecha_serv_hasta
          ,'20170425'// venc : String;
          ,'PES'// moneda_id
          ,'1.000'// moneda_ctz : String ;
          ,Query.FieldByName('NG2').AsString// bi21
          ,Query.FieldByName('IVA2').AsString// i21
          ,Query.FieldByName('NG1').AsString// bi105
          ,Query.FieldByName('IVA1').AsString// i105: String;
          );
      end
    end
    else if reporte = 'CDuplicado' then
    begin
      Pict := TfrxPictureView(frxReport1.FindObject('Picture1'));
      if Assigned(Pict) then
        Pict.Picture.LoadFromFile(path + 'img\empresa.BMP');
      Pict2 := TfrxPictureView(frxReport1.FindObject('Picture2'));
      if Assigned(Pict2) then
        Pict2.Picture.LoadFromFile(path + 'img\empresa.BMP');
    end
    else if reporte = 'CTriplicado' then
    begin
      Pict := TfrxPictureView(frxReport1.FindObject('Picture1'));
      if Assigned(Pict) then
        Pict.Picture.LoadFromFile(path + 'img\empresa.BMP');
      Pict2 := TfrxPictureView(frxReport1.FindObject('Picture2'));
      if Assigned(Pict2) then
        Pict2.Picture.LoadFromFile(path + 'img\empresa.BMP');
      Pict3 := TfrxPictureView(frxReport1.FindObject('Picture3'));
      if Assigned(Pict3) then
        Pict3.Picture.LoadFromFile(path + 'img\empresa.BMP');
    end
    else if reporte = 'CCuadriplicado' then
    begin
      Pict := TfrxPictureView(frxReport1.FindObject('Picture1'));
      if Assigned(Pict) then
        Pict.Picture.LoadFromFile(path + 'img\empresa.BMP');
      Pict2 := TfrxPictureView(frxReport1.FindObject('Picture2'));
      if Assigned(Pict2) then
        Pict2.Picture.LoadFromFile(path + 'img\empresa.BMP');
      Pict3 := TfrxPictureView(frxReport1.FindObject('Picture3'));
      if Assigned(Pict3) then
        Pict3.Picture.LoadFromFile(path + 'img\empresa.BMP');
      Pict4 := TfrxPictureView(frxReport1.FindObject('Picture4'));
      if Assigned(Pict4) then
        Pict4.Picture.LoadFromFile(path + 'img\empresa.BMP');
    end;
    try
      ShowReport(True);
    finally
      Free;
      // FreeAndNil(pict);
    end;
  end;
end;

Function TImprimirDataModule.PRE;
begin
  Result := presupuestoSql + '  WHERE' + '  ("Presupuesto".CODIGO = ' + nro +
    '  ) AND' + '  ("Presupuesto".LETRA = ' + QuotedStr(let) + '  )' + '';
end;

Function TImprimirDataModule.VTA;
begin
  Result := clienteSql + ',' + articuloSql + ',' + ventaItemSql + ',' +
    ivaVtaSql + ',' + '  "Venta".CODIGO,' + '  "Venta".LETRA,' +
    '  "Venta".FECHA,' + '  "Venta".COMPROBANTE,' +
    '  "Venta".TOTAL,' + '  "Venta".CONTADO,' + '  "Venta".CLIENTE,' +
    '  "Venta".SUBTOTAL,' + '  "Venta".DESCUENTO,' + '  "Venta".IMPUESTO,' +
    '  "Venta".EXCENTO,' + '  "Venta".SALDO,' + '  "Venta".PAGADO' + ' FROM' +
    '  "Venta"' +
    '  INNER JOIN "LibroIVAventa" ON ("Venta".CODIGO = "LibroIVAventa".FACTURA)'
    + '  INNER JOIN "VentaItem" ON ("LibroIVAventa".FACTURA = "VentaItem".OPERACION)'
    + '  INNER JOIN "Articulo" ON ("VentaItem".ARTICULO = "Articulo".CODIGO)' +
    '  INNER JOIN "Cliente" ON ("Venta".CLIENTE = "Cliente".CODIGO)' + ' WHERE'
    + '  ("Venta".CODIGO = ' + nro + ' ) AND' + '  ("Venta".LETRA = ' +
    QuotedStr(let) + ' )' + '';
end;

Function TImprimirDataModule.OPER;
begin
  Result := '  "Cliente".NOMBRE,' + '  "Cliente".TITULAR,' +
    '  "Cliente".DIRECCION,' + '  "Cliente".DIRECCIONCOMERCIAL,' +
    '  "Articulo".DESCRIPCION,' + '  "Articulo".UNIDAD,' +
    '  "OperacionItem".ARTICULO,' + '  "OperacionItem".CANTIDAD,' +
    '  "OperacionItem".PRECIO,' + '  "OperacionItem".OPERACION,' +
    '  ("OperacionItem".PRECIO * "OperacionItem".CANTIDAD ) as PREXCANT,' +
    '  "OperacionItem".SERVICIO,' + '  "OperacionItem".DESCRIPCION AS DESCR,' +
    '  "Operacion".CODIGO,' + '  "Operacion".LETRA,' + '  "Operacion".FECHA,' +
    '  "Operacion".COMPROBANTE,' + '  "Operacion".IVA3,' +
    '  "Operacion".TOTAL,' + '  "Operacion".CONTADO,' + '  "Operacion".CLIENTE,'
    + '  "Operacion".SUBTOTAL,' + '  "Operacion".DESCUENTO,' +
    '  "Operacion".IMPUESTO,' + '  "Operacion".IVA2,' + '  "Operacion".IVA1,' +
    '  "Operacion".EXCENTO,' + '  "Operacion".SALDO,' + '  "Operacion".PAGADO' +
    ' FROM' + '  "Operacion"' +
    '  INNER JOIN "OperacionItem" ON ("Operacion".CODIGO = "OperacionItem".OPERACION)'
    + '  INNER JOIN "Articulo" ON ("OperacionItem".ARTICULO = "Articulo".CODIGO)'
    + '  INNER JOIN "Cliente" ON ("Operacion".CLIENTE = "Cliente".CODIGO)' +
    ' WHERE' + '  ("Operacion".CODIGO = ' + nro + ' ) AND' +
    '  ("Operacion".LETRA = ' + QuotedStr(let) + ' )' + '';
end;

Function TImprimirDataModule.PlanillaCobrador;
begin
  Result := '"Cobrador".NOMBRE AS COBRADOR, "Cliente".ZONA,' +
    ' "CtaCte".FECHA, "CtaCte".SALDO, "Cliente".NOMBRE AS CLIENTE,' +
    ' "CtaCteItem".IMPORTE, "CtaCte".ARTICULO as CB, "CtaCteItem".VENCE,' +
    ' "CtaCteItem".CUOTA, "CtaCte".OPERACION' + ' FROM "CtaCte"' +
    ' INNER JOIN "CtaCteItem" ON ("CtaCte".CLIENTE = "CtaCteItem".CLIENTE) AND ("CtaCte".OPERACION = "CtaCteItem".OPERACION)'
    + ' INNER JOIN "Cliente" ON ("CtaCteItem".CLIENTE = "Cliente".CODIGO)' +
    ' INNER JOIN "Cobrador" ON ("CtaCte".COBRADOR = "Cobrador".CODIGO)' +
    ' WHERE ("CtaCte".OPERACION = ' + nro + ')' +
    ' ORDER BY "CtaCteItem".CUOTA';
end;

Function TImprimirDataModule.Contrato;
begin
  Result := 'CODIGO, NUMERO, FECHA, TIPO, DIA, DESCRITO, MES, MESCRITO, ANO, AESCRITO, '
    + 'CANONES, CIMPORTE, CIESCRITO, IMPORTETOTAL, ITESCRITO, TIEMPO, T2, BIEN, '
    + 'DADOR, DTIPO, DNOMBRE, DAPELLIDO, DDOCUMENTO, DDTIPO, DDOMICILIO, DDNUMERO, '
    + 'DCIUDAD, DPROVINCIA, DPAIS, TOMADOR, TTIPO, TNOMBRE, TAPELLIDO, TDOCUMENTO, '
    + 'TDTIPO, TDOMICILIO, TDTRABAJO, TCIUDAD, TPROVINCIA, TPAIS ' +
    'FROM "Contrato" WHERE NUMERO=' + nro;
end;

Function TImprimirDataModule.EAN;
begin
  Result := nro + 'as CODIGOBARRA FROM "Empresa"';
end;

end.
