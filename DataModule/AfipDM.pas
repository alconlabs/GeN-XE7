unit AfipDM;

interface

uses
  System.SysUtils, System.Classes, DataModule, Windows, System.Variants, FMX.Dialogs, ComObj,
  IPPeerClient, REST.Client, Data.Bind.Components, Data.Bind.ObjectScope
  ,JSON,REST.Types, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, REST.Response.Adapter;

type
  TAfipDataModule = class(TDataModule)
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
  Procedure AfipWsaa(path, Certificado, ClavePrivada: string);
    Procedure AfipWsfev1(
    tipo_cbte, punto_vta, tipo_doc, presta_serv, id,
    cbt_desde, cbt_hasta : Integer;
    fecha, nro_doc, imp_total, imp_tot_conc, imp_neto, impto_liq,
    impto_liq_rni, imp_op_ex, fecha_cbte, fecha_venc_pago,
    fecha_serv_desde, fecha_serv_hasta, venc : String;
    moneda_id , moneda_ctz : String ;
    bi21, i21, bi105, i105: String
    );
    Procedure AfipWsfev11;

  private
    { Private declarations }
    WSAA: Variant;
  public
    { Public declarations }
    function FacturaAfip( CbteFch, tipocbte, concepto, DocTipo, DocNro, Cbte, ImpNeto, ImpTotal,
    ImpTotConc, ImpIVA, ImpTrib, ImpOpEx, MonCotiz,
    regfeasocTipo, regfeasocNro,
    regfetribId, regfetribBaseImp, regfetribAlic, regfetribImporte, regfeivaId,
    regfeivaBaseImp, regfeivaImporte, MonId, regfetribDesc, FchServDesde,
    FchServHasta, FchVtoPago, razon, nombre, direccion, articulo : string) : TJSONValue;
  end;

var
  AfipDataModule: TAfipDataModule;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

Procedure TAfipDataModule.AfipWsfev11;
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
WSFEv1.Cuit := '23000000000';
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
tipo_doc := 80; nro_doc := '23000000000';
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

Procedure TAfipDataModule.AfipWsaa;
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

Procedure TAfipDataModule.AfipWsfev1;
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
//  WSFEv1.Cuit := '23000000000';//
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
//   LastId := WSFEv1.RecuperaLastCMP();
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

function TAfipDataModule.FacturaAfip;
var
  jsRequest, J: TJSONObject;
  cuit, pass, ptovta : string;
begin
with dm do
  begin
  try
    LeerINI;
    jsRequest := TJSONObject.Create();
    if cuit='' then cuit := afipUsr;

    if DocNro='' then
      if StrToFloat( ImpTotal )<1000 then begin
        DocTipo:='99';
        DocNro:='0';
      end
      else
      begin
        DocTipo:='80';
        DocNro:='20222222223';//https://www.afip.gob.ar/genericos/guiavirtual/consultas_detalle.aspx?id=4359106
        //      DocNro:='23000000000';
      end
    else
      if DocNro.Length < 11  then DocTipo := '96' else DocTipo := '80';
    ptovta:=IntToStr(dm.ObtenerConfig('Empresa'));
    jsRequest.AddPair('ptovta', ptovta);
    jsRequest.AddPair('tipocbte', tipocbte);
    jsRequest.AddPair('cuit', cuit);
    jsRequest.AddPair('pass', afipPsw);
    jsRequest.AddPair('concepto', concepto);
    jsRequest.AddPair('razon', razon);
    jsRequest.AddPair('nombre', nombre);
    jsRequest.AddPair('direccion', direccion);
    jsRequest.AddPair('DocTipo', DocTipo);
    jsRequest.AddPair('DocNro', DocNro);
    jsRequest.AddPair('CbteFch', formatdatetime('yyyymmdd', StrToDateTime(CbteFch)) );
    jsRequest.AddPair('Cbte', Cbte);//'1');
    jsRequest.AddPair('articulo', articulo);
    jsRequest.AddPair('ImpNeto', ImpNeto);
    jsRequest.AddPair('ImpTotConc', ImpTotConc);
    jsRequest.AddPair('ImpIVA', ImpIVA);
    jsRequest.AddPair('ImpTrib', ImpTrib);
    jsRequest.AddPair('ImpOpEx', ImpOpEx);
    jsRequest.AddPair('ImpTotal', ImpTotal);
    jsRequest.AddPair('FchServDesde', FchServDesde);
    jsRequest.AddPair('FchServHasta', FchServHasta);
    jsRequest.AddPair('FchVtoPago', FchVtoPago);
    jsRequest.AddPair('MonId', MonId);
    jsRequest.AddPair('MonCotiz', MonCotiz);

    jsRequest.AddPair('regfeasocTipo', regfeasocTipo);
    jsRequest.AddPair('regfeasocPtoVta', ptovta);
    jsRequest.AddPair('regfeasocNro', regfeasocNro);

    jsRequest.AddPair('regfetribId', regfetribId);
    jsRequest.AddPair('regfetribDesc', regfetribDesc);
    jsRequest.AddPair('regfetribBaseImp', regfetribBaseImp);
    jsRequest.AddPair('regfetribAlic', regfetribAlic);
    jsRequest.AddPair('regfetribImporte', regfetribImporte);
    jsRequest.AddPair('regfeivaId', regfeivaId);
    jsRequest.AddPair('regfeivaBaseImp', regfeivaBaseImp);
    jsRequest.AddPair('regfeivaImporte', regfeivaImporte);
    RESTRequest1.ResetToDefaults;
    RESTClient1.ResetToDefaults;
    RESTClient1.BaseURL := afipURL;
    RESTRequest1.Resource := afipRes;
    RESTRequest1.Method:=rmPOST;
    RESTRequest1.Params.AddItem('body',jsRequest.ToString, TRESTRequestParameterKind.pkREQUESTBODY, [poDoNotEncode], TRESTContentType.ctAPPLICATION_JSON);
    RESTRequest1.Execute();
    except
      on e : exception do
      begin
        ShowMessage ('Clase de error: ' + e.ClassName + chr(13) + chr(13) +
            'Mensaje del error: ' + e.Message);
            result:=nil;
        exit
      end;
    end;
    jsRequest.Free();
  end;
  result := RESTRequest1.Response.JSONValue;
end;

end.
