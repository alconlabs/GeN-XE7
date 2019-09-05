unit RestDM;

interface

uses
  System.SysUtils, System.Classes, IPPeerClient, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, REST.Response.Adapter, REST.Client, Data.DB,
  IBX.IBCustomDataSet, IBX.IBQuery, Data.Bind.Components, Data.Bind.ObjectScope,
  System.JSON, REST.Types, Winapi.ShellAPI, REST.Utils, Winapi.Windows,
  Vcl.DdeMan, Dialogs, DataModule, Vcl.Forms, FireDAC.Stan.Async, FireDAC.DApt;

type
  TTRest = class(TThread)
    vClient: TRESTClient;
    vRequest: TRESTRequest;
//    vResponse: TRESTResponse;
    vJSONValue: TJsonValue;
    vJSONArray1: TJSONArray;
    max, min, pprom: Double;
    i: byte;
    precios: array[1..5] of Double;
    j,c: integer;
    r: string;
    url,res,
    item, sku, id, e: string;
    termino : boolean;
public
    constructor Create(
      vUrl, vResource, vAccept//, vClientId, vClientSecret, vAccessToken, vSeller_id, vQ, vLimit
      : string;
      vMethod : TRESTRequestMethod
    );
    procedure Execute; override;
    procedure GetResponse;
  end;

type
  TDMR = class(TDataModule)
    RESTResponseCategories: TRESTResponse;
    RESTResponse1: TRESTResponse;
    RESTClientCategories: TRESTClient;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTRequestCategories: TRESTRequest;
    RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter;
    RESTResponseDataSetAdapterCategories: TRESTResponseDataSetAdapter;
    FDMemTableCategories: TFDMemTable;
    O: TFDMemTable;
    FDQuery1: TFDQuery;
    FDQuery2: TFDQuery;
    T: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    procedure ResetRESTComponentsToDefaults;
    procedure GetRESTCategories(resource: string);
    procedure IniciarREST;


    procedure ObtenerOrder_items(order_id:string;j:TJSONValue);
    procedure ObtenerShipping(id:string);
    function ObtenerBuyer(j:TJSONValue):string;
  public
    { Public declarations }
    JSONValue1 : TJSONValue;
    authCode, accessToken :string;
    procedure ObtenerOrderRecent;
    procedure GetREST(resource: string);
    function existeEnTJSONArray(tabla: string ; streams: TJSONArray): string;
    procedure importCategories(borrar : Boolean);
    procedure PostREST(resource, datos: string);
    procedure PutREST(resource, datos: string);
    var JAline_items : TJSONArray;
    function Jline_items( codigo, cantidad : String ): TJSONObject;
    procedure CrearOrden;

    procedure ObtenerConsultaRest(r,q:string);
    procedure IniciarObtenerRest(u,r:string;m:TRESTRequestMethod);
    procedure ObtenerSeller;
    procedure ImprimirEtiqueta(i:string);
    procedure ObtenerPack(order_id:string);
    procedure ObtenerMessages(order_id,user_id:string);
    procedure IniciarObtenerToken;
    procedure EjecutarObtenerToken;
    function GetURL(service: string): string;
    procedure ObtenerAuthCode;
    procedure ObtenerAccessToken;
    procedure ObtenerRefreshToken;
    procedure AbrirEnBrowser(LURL:string);
    function Obtener(resource:string):TJSONValue;
    procedure ObtenerOrder;
  end;

const
  clientId = '5480711421985209';
  clientSecret = 'jXCjaf3TmYxUaA84GRVFEMDBgvTPLLFZ';
  url = 'https://api.mercadolibre.com/';
  redirectUri = 'https://www.mercadolibre.com';

var

  tI: Integer;
  DMR: TDMR;
  tRest: array [0 .. 9999 - 1] of TTRest;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses udmMercadoLibre, OperacionDM;

{$R *.dfm}

{ THilo }
constructor TTRest.Create;//(//CreateSuspended : boolean;
// vUrl, vClientId, vClientSecret, vResource, vAccessToken, vAccept, vSeller_id, vQ, vLimit : string);
begin
//  FreeOnTerminate := True;
  inherited Create(False); // llamamos al constructor del padre (TThread)
  vClient := TRESTClient.Create(nil);
  vRequest := TRESTRequest.Create(nil);
//  vResponse := TRESTResponse.Create(nil);
//  vMemo1 := TMemo.Create(nil);
  vJSONValue := TJSONValue.Create;
  vClient.BaseURL := vUrl;//'https://api.mercadolibre.com/sites/MLA/'; //Supongamos que RUTA_URI es una constante con la ruta
  with vRequest do
  begin
    Client := vClient;
    Resource := vResource;//'search?';
    Method := vMethod;// rmPOST;
    if vAccept<>'' then Params.AddItem('accept', vAccept, TRESTRequestParameterKind.pkHTTPHEADER, [TRESTRequestParameterOption.poDoNotEncode]);//orders/recent
//    if vQ<>'' then Params.AddItem('q', vQ, TRESTRequestParameterKind.pkGETorPOST);
//    if vSeller_id<>'' then Params.AddItem('seller_id', vSeller_id, TRESTRequestParameterKind.pkGETorPOST);
//    if vLimit<>'' then Params.AddItem('limit', vLimit, TRESTRequestParameterKind.pkGETorPOST);
//    if vAccessToken<>'' then Params.AddItem('access_token', vAccessToken, TRESTRequestParameterKind.pkGETorPOST);
//    if vClientId<>'' then Params.AddItem('client_id', vClientId, TRESTRequestParameterKind.pkGETorPOST);
//    if vClientSecret<>'' then Params.AddItem('client_secret', vClientSecret, TRESTRequestParameterKind.pkGETorPOST);
//    Params.AddItem('site_id', 'MLA', TRESTRequestParameterKind.pkGETorPOST);
//    Params.AddItem('redirect_uri', redirectUri, TRESTRequestParameterKind.pkGETorPOST);
  //  RESTRequest1.Params.AddItem('price', preMinE.Text+'-'+preMaxE.Text, TRESTRequestParameterKind.pkGETorPOST);
  //  RESTRequest1.Params.AddItem('sort', 'price_desc', TRESTRequestParameterKind.pkGETorPOST);
  //  RESTRequest1.Params.AddItem('consumer_key', webUsr, TRESTRequestParameterKind.pkGETorPOST);
  //  RESTRequest1.Params.AddItem('consumer_secret', webPsw, TRESTRequestParameterKind.pkGETorPOST);
//    Response := vResponse;
  end;
end;

procedure TTRest.Execute;
begin
  inherited;
//  FreeOnTerminate := True;
  while not Terminated do
    Synchronize(GetResponse);
//  Synchronize(ObtenerConsultaRest);
end;

procedure TTRest.GetResponse;
begin
  try
  vJSONValue:=nil;
    with vRequest do
    begin
      Execute;
      if not ( ( vRequest.Response.Content = #$FEFF'[]' ) or ( vRequest.Response.Content  =  '[]' ) ) then
        begin
          max:= 0; min:= 0; pprom:= 0;
          if vRequest.Response.Content <> '' then
          begin
            try
//              vMemo1.Text := vResponse.Content;
//e:=vRequest.Response.Content;
              vJSONValue := TJSONObject.ParseJSONValue(vRequest.Response.Content);
            except
              on E:Exception do begin
                ShowMessage('Ha ocurrido un Error!'+#13+E.Message);
              end;
            end;
          end;
        end;
    end;
  finally
     vClient.Free;
//     vResponse.Free;
     vRequest.Free;
     termino:=True;
     Terminate;
//     Application.ProcessMessages;
   end;
end;

procedure TDMR.GetREST;
begin
  IniciarREST;
  RESTRequest1.Resource := resource;
  RESTRequest1.Execute;
  if not ( ( RESTResponse1.Content = #$FEFF'[]' ) or ( RESTResponse1.Content  =  '[]' ) ) then
  O.Open;
end;

procedure TDMR.ResetRESTComponentsToDefaults;
begin
  /// reset all of the rest-components for a complete
  /// new request
  ///
  /// --> we do not clear the private data from the
  /// individual authenticators.
  ///
  O.Close;
  RESTRequest1.ResetToDefaults;
  RESTClient1.ResetToDefaults;
  RESTResponse1.ResetToDefaults;
  RESTResponseDataSetAdapter1.ResetToDefaults;
end;

procedure TDMR.GetRESTCategories;
begin
  FDMemTableCategories.Close;
  RESTClientCategories.ResetToDefaults;
  RESTResponseCategories.ResetToDefaults;
  RESTClientCategories.BaseURL := webUrl;
  RESTRequestCategories.Resource := resource;
  RESTRequestCategories.Params.AddItem('consumer_key', webUsr, TRESTRequestParameterKind.pkGETorPOST);
  RESTRequestCategories.Params.AddItem('consumer_secret', webPsw, TRESTRequestParameterKind.pkGETorPOST);
  RESTRequestCategories.Execute;
  if not ( ( RESTResponseCategories.Content = #$FEFF'[]' ) or ( RESTResponseCategories.Content  =  '[]' ) ) then
    FDMemTableCategories.Open;
end;

procedure TDMR.DataModuleCreate(Sender: TObject);
begin
  JAline_items := TJSONArray.Create();
end;

function TDMR.existeEnTJSONArray;
var
  stream: TJSONObject;
  id: TJSONString;
  i: integer;
begin
//  i:=0;
//  repeat
  if streams<>nil then
  for i := 0 to streams.Size - 1 do
  begin
    stream := streams.Get(i) as TJSONObject;
    id := stream.Get('id').JsonValue as TJSONString;
    if OperacionDataModule.existeEnTabla(tabla,'CODIGO='+id.Value) then
    begin
      result := id.Value;
      exit;
    end;
  end;
  result :='0';
end;

procedure TDMR.importCategories;
var
  id,name,parent: string;
  i,p: integer;
begin
//  with OperacionDataModule do
    begin
    GetRESTCategories('products/categories/?per_page=100&page=1&parent=0&');
//    ProgressBar1.Max := FDMemTableCategories.RecordCount;
    if (FDMemTableCategories<>nil) then
    begin
//     if borrar then OperacionDataModule.BorrarArticulos;
      for i := 0 to FDMemTableCategories.RecordCount - 1 do
      begin
        id := FDMemTableCategories.FieldByName('id').AsString;
        name := FDMemTableCategories.FieldByName('name').AsString;
        parent := FDMemTableCategories.FieldByName('parent').AsString;
    //    T.SQL.Text := 'SELECT * FROM "Rubro" WHERE CODIGO = ' + id;
    //    T.Open;
        if not OperacionDataModule.existeEnTabla('Categoria','CODIGO='+id) then //    if T.RecordCount = 0 then
        begin
          OperacionDataModule.insertarTabla2('Categoria',id,name);
  //        D.SQL.Text := 'INSERT INTO "Categoria" (CODIGO,DESCRIPCION) VALUES ('
  //        + id + ',' + QuotedStr(name) + ')';
  //        D.ExecSQL;
  //        D.Transaction.CommitRetaining;
        end;
        FDMemTableCategories.Next;
//        ProgressBar1.Position := i;
      end;
      p:=0;
      repeat
        Inc(p);
        GetRESTCategories('products/categories/?per_page=100&page='+IntToStr(p)+'&');
//        ProgressBar1.Max := FDMemTableCategories.RecordCount;
        FDMemTableCategories.Filtered := False;
        FDMemTableCategories.Filter := 'parent <> 0';//  O.Filter := 'parent LIKE ' + QuotedStr('%' + IntToStr( category ) + '%');
        FDMemTableCategories.Filtered := True;

//        ProgressBar1.Max := FDMemTableCategories.RecordCount;
        for i := 0 to FDMemTableCategories.RecordCount - 1 do
        begin
          id := FDMemTableCategories.FieldByName('id').AsString;
          name := FDMemTableCategories.FieldByName('name').AsString;
          parent := FDMemTableCategories.FieldByName('parent').AsString;
          if OperacionDataModule.existeEnTabla('Categoria','CODIGO='+parent) then
          begin
            if not OperacionDataModule.existeEnTabla('SubCategoria','CODIGO='+id) then
            begin
              OperacionDataModule.insertarTabla2('SubCategoria',id,name);
  //              D.SQL.Text := 'INSERT INTO "SubCategoria" (CODIGO,DESCRIPCION) VALUES ('
  //              + id + ',' + QuotedStr(name) + ')';
  //              D.ExecSQL;
            end;
          end
          else
          if not OperacionDataModule.existeEnTabla('Rubro','CODIGO='+id) then
          begin
            OperacionDataModule.insertarTabla2('Rubro',id,name);
  //           D.SQL.Text := 'INSERT INTO "Rubro" (CODIGO,DESCRIPCION) VALUES ('
  //           + id + ',' + QuotedStr(name) + ')';
  //           D.ExecSQL;
          end;
          FDMemTableCategories.Next;
//          ProgressBar1.Position := i;
  //        D.Transaction.CommitRetaining;
        end;

      until FDMemTableCategories.RecordCount=0;
    end;
  end;
end;

procedure TDMR.PostREST;
begin
  IniciarREST;
  RESTRequest1.Resource := resource;
  RESTRequest1.Method := rmPost;
  RESTRequest1.Params.AddItem; //Adds a new Parameter Item
  RESTRequest1.Params.Items[0].name := 'data'; //sets the name of the parameter. In this case, since i need to use 'data=' on the request, the parameter name is data.
  RESTRequest1.Params.Items[0].Value := datos; //Adds the value of the parameter, in this case, the XML data.
  RESTRequest1.Params.Items[0].ContentType := ctAPPLICATION_X_WWW_FORM_URLENCODED;//sets the content type.
  RESTRequest1.Params.Items[0].Kind := pkGETorPOST; //sets the kind of request that will be executed.
  RESTRequest1.Execute;
end;

procedure TDMR.PutREST;
begin
  ResetRESTComponentsToDefaults;
  RESTClient1.BaseURL := webUrl;
  resource:= resource +'consumer_key='+webUsr+'&consumer_secret='+webPsw;
  RESTRequest1.Resource := resource;
  RESTRequest1.Method := rmPUT;
  RESTRequest1.Params.AddItem; //Adds a new Parameter Item
  RESTRequest1.Params.Items[0].name := 'body'; //sets the name of the parameter. In this case, since i need to use 'data=' on the request, the parameter name is data.
  RESTRequest1.Params.Items[0].Value := datos; //Adds the value of the parameter, in this case, the XML data.
  RESTRequest1.Params.Items[0].ContentType := ctAPPLICATION_JSON;// ctAPPLICATION_X_WWW_FORM_URLENCODED;//sets the content type.
  RESTRequest1.Params.Items[0].Kind := pkREQUESTBODY; //sets the kind of request that will be executed.
  RESTRequest1.Execute;
end;

procedure TDMR.IniciarREST;
begin
  ResetRESTComponentsToDefaults;
  RESTClient1.BaseURL := webUrl;
  RESTRequest1.Resource := WebRes;
  RESTRequest1.Params.AddItem('consumer_key', webUsr, TRESTRequestParameterKind.pkGETorPOST);
  RESTRequest1.Params.AddItem('consumer_secret', webPsw, TRESTRequestParameterKind.pkGETorPOST);
end;

procedure TDMR.CrearOrden;
var
  Jbilling, Jshipping, Jshipping_lines, Jorder : TJSONObject;
  JAbilling, JAshipping, JAshipping_lines : TJSONArray;
  i : Integer;
begin
  Jbilling := TJSONObject.Create;
  Jbilling.AddPair('first_name', 'John');
  Jbilling.AddPair('last_name', 'Doe');
  Jbilling.AddPair('address_1', '969 Market');
  Jbilling.AddPair('address_2', '');
  Jbilling.AddPair('city', 'San Francisco');
  Jbilling.AddPair('state', 'CA');
  Jbilling.AddPair('postcode', '94103');
  Jbilling.AddPair('country', 'US');
  Jbilling.AddPair('email', 'john.doe@example.com');
  Jbilling.AddPair('phone', '(555) 555-5555');
  JAbilling := TJSONArray.Create;
  JAbilling.Add(Jbilling);

  Jshipping := TJSONObject.Create;
  Jshipping.AddPair('first_name', 'John');
  Jshipping.AddPair('last_name', 'Doe');
  Jshipping.AddPair('address_1', '969 Market');
  Jshipping.AddPair('address_2', '');
  Jshipping.AddPair('city', 'San Francisco');
  Jshipping.AddPair('state', 'CA');
  Jshipping.AddPair('postcode', '94103');
  Jshipping.AddPair('country', 'US');
  JAshipping := TJSONArray.Create;
  JAshipping.Add(Jshipping);

//  for i := 0 to High(mat[0]) - 1 do
//  begin
//    Jline_items := TJSONObject.Create();
//    Jline_items.AddPair(TJSONPair.Create('product_id', mat[0, i]) );
//    Jline_items.AddPair(TJSONPair.Create('quantity', mat[3, i]) );
//    JAline_items.AddElement(Jline_items);
//  end;

  Jshipping_lines := TJSONObject.Create;
  Jshipping_lines.AddPair('method_id', 'flat_rate');
  Jshipping_lines.AddPair('method_title', 'Flat Rate');
  Jshipping_lines.AddPair('total', '10');
  JAshipping_lines := TJSONArray.Create;
  JAshipping_lines.Add(Jshipping_lines);

  Jorder := TJSONObject.Create;
  Jorder.AddPair('payment_method', 'bacs');
  Jorder.AddPair('payment_method_title', 'Direct Bank Transfer');
  Jorder.AddPair('set_paid', 'true');
  Jorder.AddPair('billing', JAbilling);
  Jorder.AddPair('shipping', JAshipping);
  Jorder.AddPair( TJSONPair.Create('Jline_items', JAline_items) );
  Jorder.AddPair('shipping_lines', JAshipping_lines);

//datos :=
//'{'
//+'  "payment_method": "bacs",'
//+'  "payment_method_title": "Direct Bank Transfer",'
//+'  "set_paid": true,'
//+'  "billing": {'
//+'    "first_name": "John",'
//+'    "last_name": "Doe",'
//+'    "address_1": "969 Market",'
//+'    "address_2": "",'
//+'    "city": "San Francisco",'
//+'    "state": "CA",'
//+'    "postcode": "94103",'
//+'    "country": "US",'
//+'    "email": "john.doe@example.com",'
//+'    "phone": "(555) 555-5555"'
//+'  },'
//+'  "shipping": {'
//+'    "first_name": "John",'
//+'    "last_name": "Doe",'
//+'    "address_1": "969 Market",'
//+'    "address_2": "",'
//+'    "city": "San Francisco",'
//+'    "state": "CA",'
//+'    "postcode": "94103",'
//+'    "country": "US"'
//+'  },'
//+'  "line_items": ['
//+'    {'
//+'      "product_id": 93,'
//+'      "quantity": 2'
//+'    },'
//+'    {'
//+'      "product_id": 22,'
//+'      "variation_id": 23,'
//+'      "quantity": 1'
//+'    }'
//+'  ],'
//+'  "shipping_lines": ['
//+'    {'
//+'      "method_id": "flat_rate",'
//+'      "method_title": "Flat Rate",'
//+'      "total": 10'
//+'    }'
//+'  ]'
//+'}';

end;

function TDMR.Jline_items;
begin
  Result := TJSONObject.Create();
  Result.AddPair(TJSONPair.Create('product_id', codigo) );
  Result.AddPair(TJSONPair.Create('quantity', cantidad) );
end;


function TDMR.GetURL;
var
  DDEClient: TDDEClientConv;
  s, URL, Title : string;
 begin
   s := '';
   try
     DDEClient := TDDEClientConv.Create(nil);
     with DDEClient do
     begin
       if SetLink('IExplore','WWW_GetWindowInfo') then
//         s := RequestData('0xFFFFFFFF,sURL,sTitle')
         s := RequestData('0xFFFFFFFF')
     end;
  if s <> '' then
     begin
       delete(s,1,1);
       URL := copy(s,1,pos('","',s)-1);
       delete(s,1,pos('","',s)+2);
       Title := copy(s,1,pos('"',s) - 1);
       result:=URL;
//       result:=s;
     end;
     exit;
   except
//     MessageDlg('URL attempt failed!',mtError,[mbOK],0);
   end;
end;

//procedure TDMR.ResetRESTComponentsToDefaults;
//begin
//  /// reset all of the rest-components for a complete
//  /// new request
//  ///
//  /// --> we do not clear the private data from the
//  /// individual authenticators.
//  ///
//  RESTRequest1.ResetToDefaults;
//  RESTClient1.ResetToDefaults;
////  RESTResponse1.ResetToDefaults;
////  RESTResponseDataSetAdapter1.ResetToDefaults;
//end;

procedure TDMR.ObtenerAuthCode;
var
  LURL: string;
begin
//https://auth.mercadolibre.com.ar/authorization?response_type=code&client_id=5480711421985209
  LURL := 'https://auth.mercadolibre.com.ar/authorization';
  LURL := LURL + '?response_type=' + URIEncode('code');
  LURL := LURL + '&client_id=' + URIEncode(clientId);
  ShellExecute(0,'open',pchar(LURL),nil,nil,SW_SHOWNORMAL);
  authCode := Trim(InputBox('Por favor copiar y pegar de la barra de direcciones', 'https://www.mercadolibre.com/?code=', ''));
end;

procedure TDMR.IniciarObtenerToken;
begin
  IniciarObtenerRest(url,'oauth/token?',rmPOST);
//  ResetRESTComponentsToDefaults;
//  RESTClient1.BaseURL := url;
//  with RESTRequest1 do
//  begin
//    Method := rmPOST;
//    Resource := 'oauth/token?';
//    Params.AddItem('client_id', clientId, TRESTRequestParameterKind.pkGETorPOST);
//    Params.AddItem('client_secret', clientSecret, TRESTRequestParameterKind.pkGETorPOST);
//    Params.AddItem('redirect_uri', redirectUri, TRESTRequestParameterKind.pkGETorPOST);
//  end;
end;

//procedure TDMR.DataModuleCreate(Sender: TObject);
//begin
////  with DM do
////  begin
//    refreshToken := DM.dbMain.ExecSQLScalar('SELECT refresh FROM token');
////  end;
//end;

procedure TDMR.EjecutarObtenerToken;
var
  LToken: string;
begin
  with RESTRequest1 do
  begin
    Execute;
    if Response.GetSimpleValue('access_token', LToken) then
      accessToken := LToken;
    if Response.GetSimpleValue('refresh_token', LToken) then
      dmML.refreshToken := LToken;
    dmML.ActualizarRefreshToken;
  end;
end;

procedure TDMR.ObtenerAccessToken;
//var
//  LToken: string;
begin
  if authCode='' then ObtenerAuthCode;
  IniciarObtenerToken;
//  ResetRESTComponentsToDefaults;
//  RESTClient1.BaseURL := url;
  with RESTRequest1 do
  begin
//  Method := rmPOST;
//  Resource := 'oauth/token?';
    Params.AddItem('grant_type', 'authorization_code', TRESTRequestParameterKind.pkGETorPOST);
//  Params.AddItem('client_id', clientId, TRESTRequestParameterKind.pkGETorPOST);
//  Params.AddItem('client_secret', clientSecret, TRESTRequestParameterKind.pkGETorPOST);
    Params.AddItem('code', authCode, TRESTRequestParameterKind.pkGETorPOST);
    Params.AddItem('redirect_uri', redirectUri, TRESTRequestParameterKind.pkGETorPOST);
//  Execute;
//  if Response.GetSimpleValue('access_token', LToken) then
//    AccessToken := LToken;
//  if Response.GetSimpleValue('refresh_token', LToken) then
//    RefreshToken := LToken;
  end;
  EjecutarObtenerToken;
end;

procedure TDMR.ObtenerRefreshToken;
//var
//  LToken: string;
begin
  with dmML do
  begin
  //https://api.mercadolibre.com/oauth/token?grant_type=refresh_token&client_id=APP_ID&client_secret=SECRET_KEY&refresh_token=REFRESH_TOKEN
    if refreshToken='' then ObtenerAccessToken;
    IniciarObtenerToken;
  //  ResetRESTComponentsToDefaults;
  //  RESTClient1.BaseURL := url;
    with RESTRequest1 do
    begin
  //  Method := rmPOST;
  //  Resource := 'oauth/token?';
      Params.AddItem('grant_type', 'refresh_token', TRESTRequestParameterKind.pkGETorPOST);
  //  Params.AddItem('client_id', clientId, TRESTRequestParameterKind.pkGETorPOST);
  //  Params.AddItem('client_secret', clientSecret, TRESTRequestParameterKind.pkGETorPOST);
      Params.AddItem('refresh_token', refreshToken, TRESTRequestParameterKind.pkGETorPOST);
  //  Params.AddItem('redirect_uri', redirectUri, TRESTRequestParameterKind.pkGETorPOST);
  //  Execute;
  //  if Response.GetSimpleValue('access_token', LToken) then
  //    AccessToken := LToken;
  //  if Response.GetSimpleValue('refresh_token', LToken) then
  //    RefreshToken := LToken;
    end;
      EjecutarObtenerToken;
  end;
end;

procedure TDMR.IniciarObtenerRest;
begin
  ResetRESTComponentsToDefaults;
  RESTClient1.BaseURL := u;
  with RESTRequest1 do
  begin
//    Method := rmPOST;
    Method := m;
    Resource := r;
    Params.AddItem('client_id', clientId, TRESTRequestParameterKind.pkGETorPOST);
//    Params.AddItem('site_id', 'MLA', TRESTRequestParameterKind.pkGETorPOST);
    Params.AddItem('client_secret', clientSecret, TRESTRequestParameterKind.pkGETorPOST);
//    Params.AddItem('redirect_uri', redirectUri, TRESTRequestParameterKind.pkGETorPOST);
  end;
end;

procedure TDMR.ObtenerConsultaRest;
begin
  if  accessToken='' then ObtenerRefreshToken;
//  r:='users/me?';
  IniciarObtenerRest(url,r,rmGET);
////$ curl https://api.mercadolibre.com/users/me?access_token=$ACCESS_TOKEN
//  ResetRESTComponentsToDefaults;
//  with RESTClient1 do
//  begin
//    BaseURL := 'https://api.mercadolibre.com/';
//  end;
  with RESTRequest1 do
  begin
//  Method := rmGET;
//  Resource := 'users/me?';
//  Params.AddItem('accept', 'json', TRESTRequestParameterKind.pkHTTPHEADER);
  Params.AddItem('accept', 'application/json', TRESTRequestParameterKind.pkHTTPHEADER, [TRESTRequestParameterOption.poDoNotEncode]);//orders/recent
  Params.AddItem('access_token', accessToken, TRESTRequestParameterKind.pkGETorPOST);
  if q<>''then Params.AddItem('q', q, TRESTRequestParameterKind.pkGETorPOST);
////  OAuth2Authenticator1.AccessToken := 'APP_USR-5480711421985209-061218-6833fd7ab8853a5234718fc204b7d270-242069506';
////  OAuth2Authenticator1.AccessTokenParamName := 'access_token';
  Execute;
//  Application.ProcessMessages;
  end;
end;

procedure TDMR.ObtenerOrderRecent;
var
  jOrderRecent, order_items, buyer, item, shipping : TJSONValue;
  i, io, order_id,order_status,buyer_id,item_id,item_title,seller_sku,
  order_items_quantity, last_updated,sj, hoy : string;
  n, r, l, ro, no, p, t, paging_total: Integer;
begin
  hoy := formatdatetime('yyyy-mm-dd', now);
  with dmML do
    with tOrders do
    begin
      try
        i:='0';
        if seller_id='' then ObtenerSeller;
        repeat
          Inc(p);
//          ObtenerConsultaRest('orders/search/recent?seller='+seller_id,'');
          ObtenerConsultaRest('orders/search/recent?seller='+seller_id
//          jOrderRecent:=Obtener('orders/search/recent?seller='+seller_id
//          +'&order.date_created.from=2019-08-13T00:00:00.000-00:00'
          +'&order.date_last_updated.from='+hoy+'T00:00:00.000-00:00'
          +'&offset='+IntToStr(p)
//          +'&'
          ,'');
//          );
          jOrderRecent := TJSONObject.ParseJSONValue(RESTRequest1.Response.Content);
          if jOrderRecent is TJSONObject then
          begin
            sj:=jOrderRecent.ToString;
            paging_total := jOrderRecent.GetValue<Integer>('paging.total');
            if paging_total>0 then
              t := paging_total;
            r:=TJSONArray(jOrderRecent.GetValue<TJSONValue>('results')).Size;
            if r>0 then
              for n := 0 to r-1 do
              begin
                i:=IntToStr(n);
                order_id := jOrderRecent.GetValue<string>('results['+i+'].id');
                Open(sqlOrders+' WHERE id=:I',[order_id]);
                if RecordCount>0 then
                  Edit
                else
                begin
                  Insert;
                  tOrdersid.AsString := order_id;
                  //                tOrdersid.AsString := jOrderRecent.GetValue<TJSONValue>('results['+i+'].id').ToString;//2054151756,
                  tOrderscomments.AsString := jOrderRecent.GetValue<string>('results['+i+'].comments');//null,
                  tOrdersstatus.AsString := jOrderRecent.GetValue<string>('results['+i+'].status');//"paid",
                  tOrdersstatus_detail.AsString := jOrderRecent.GetValue<TJSONValue>('results['+i+'].status_detail').ToString;//{},
                  tOrdersdate_created.AsString := jOrderRecent.GetValue<string>('results['+i+'].date_created');//"2019-06-13T18:12:24.000-04:00",
                  tOrdersdate_closed.AsString := jOrderRecent.GetValue<string>('results['+i+'].date_closed');//"2019-06-13T18:12:27.000-04:00",
                  tOrdersexpiration_date.AsString := jOrderRecent.GetValue<string>('results['+i+'].expiration_date');//"2019-07-11T18:12:27.000-04:00",
//                  tOrdersdate_last_updated.AsString := jOrderRecent.GetValue<string>('results['+i+'].date_last_updated');//"2019-06-24T12:11:26.353Z",
                  tOrdershidden_for_seller.AsString := jOrderRecent.GetValue<string>('results['+i+'].hidden_for_seller');//false,
                  tOrderscurrency_id.AsString := jOrderRecent.GetValue<string>('results['+i+'].currency_id');//"ARS",
  //                tOrdersorder_items.AsString := jOrderRecent.GetValue<string>('results['+i+'].order_items');//[],
                  ObtenerOrder_items(order_id, jOrderRecent.GetValue<TJSONValue>('results['+i+'].order_items'));
                  tOrderstotal_amount.AsString := jOrderRecent.GetValue<string>('results['+i+'].total_amount');//456.87,
                  tOrdersmediations.AsString := jOrderRecent.GetValue<TJSONValue>('results['+i+'].mediations').ToString;//[],
                  tOrderspayments.AsString := jOrderRecent.GetValue<TJSONValue>('results['+i+'].payments').ToString;//[],
  //                tOrdersshipping.AsString := jOrderRecent.GetValue<string>('results['+i+'].shipping');//{},
  //                shipping := jOrderRecent.GetValue<TJSONValue>('results['+i+'].shipping');
  //                id := shipping.GetValue<string>('id');
                  tOrdersshipping.AsString:=(jOrderRecent.GetValue<TJSONValue>('results['+i+'].shipping')).GetValue<string>('id');
  //                tOrdersshipping.AsString := ObtenerShipping(order_id, jOrderRecent.GetValue<TJSONValue>('results['+i+'].shipping'));
//                  if tOrdersshipping.AsString ='' then tOrdersshipping.AsString:='0';
//                  ObtenerShipping(tOrdersshipping.AsString);
                  tOrdersorder_request.AsString := jOrderRecent.GetValue<TJSONValue>('results['+i+'].order_request').ToString;//{},
                  tOrderspickup_id.AsString := jOrderRecent.GetValue<string>('results['+i+'].pickup_id');//null,
  //                tOrdersbuyer.AsString := jOrderRecent.GetValue<TJSONValue>('results['+i+'].buyer');//{},
                  tOrdersbuyer.AsString := ObtenerBuyer(jOrderRecent.GetValue<TJSONValue>('results['+i+'].buyer'));
                  tOrdersseller.AsString := jOrderRecent.GetValue<TJSONValue>('results['+i+'].seller').ToString;//{},
                  tOrdersfeedback.AsString := jOrderRecent.GetValue<TJSONValue>('results['+i+'].feedback').ToString;//{},
                  tOrderstags.AsString := jOrderRecent.GetValue<TJSONValue>('results['+i+'].tags').ToString;//[]
//                  ObtenerMessages(order_id,seller_id);
                  tOrdersshipping.AsString:=(jOrderRecent.GetValue<TJSONValue>('results['+i+'].shipping')).GetValue<string>('id');
                  if tOrdersshipping.AsString ='' then tOrdersshipping.AsString:='0';
                  ObtenerDespachados(order_id);
                end;
//              ObtenerShipping(tOrdersshipping.AsString);
//              ObtenerMessages(order_id,seller_id);
                last_updated:=jOrderRecent.GetValue<string>('results['+i+'].date_last_updated');
                if tOrdersdate_last_updated.AsString <> last_updated then
                  begin
                    tOrdersdate_last_updated.AsString := last_updated;
                    ObtenerShipping(tOrdersshipping.AsString);
                    ObtenerMessages(order_id,seller_id);
                  end;
                tOrders.Post;
              end;
          end;
          Application.ProcessMessages;
        until ((p=t) or (p>t));
      finally
      //
      end;
    end;
end;

procedure TDMR.ObtenerOrder;
var
  jOrderRecent, order_items, buyer, item, shipping : TJSONValue;
  i, io, order_id,order_status,buyer_id,item_id,item_title,seller_sku,
  order_items_quantity, last_updated,sj, hoy, ayer : string;
  n, r, l, ro, no, p, t, paging_total: Integer;
begin
  hoy := formatdatetime('yyyy-mm-dd', now);
  ayer := formatdatetime('yyyy-mm-dd', now-4);
  with dmML do
    with tOrders do
    begin
      try
        i:='0';
        if seller_id='' then ObtenerSeller;
        repeat
          Inc(p);
          ObtenerConsultaRest('orders/search?seller='+seller_id
          +'&order.status=paid'
          +'&tags=not_delivered'//+'&shipping.status=not_delivered'//&shipping.status=to_be_agreed
          +'&order.date_created.from='+ayer+'T00:00:00.000-00:00'
//          +'&order.date_last_updated.from='+hoy+'T00:00:00.000-00:00'
          +'&offset='+IntToStr(p)
//          +'&'
          ,'');
//          );
          jOrderRecent := TJSONObject.ParseJSONValue(RESTRequest1.Response.Content);
          if jOrderRecent is TJSONObject then
          begin
            sj:=jOrderRecent.ToString;
            paging_total := jOrderRecent.GetValue<Integer>('paging.total');
            if paging_total>0 then
              t := paging_total;
            r:=TJSONArray(jOrderRecent.GetValue<TJSONValue>('results')).Size;
            if r>0 then
              for n := 0 to r-1 do
              begin
                i:=IntToStr(n);
                order_id := jOrderRecent.GetValue<string>('results['+i+'].id');
                Open(sqlOrders+' WHERE id=:I',[order_id]);
                dmML.dbMain.StartTransaction;
                if RecordCount>0 then
                  Edit
                else
                begin
                  Insert;
                  tOrdersid.AsString := order_id;
                  //                tOrdersid.AsString := jOrderRecent.GetValue<TJSONValue>('results['+i+'].id').ToString;//2054151756,
                  tOrderscomments.AsString := jOrderRecent.GetValue<string>('results['+i+'].comments');//null,
                  tOrdersstatus_detail.AsString := jOrderRecent.GetValue<TJSONValue>('results['+i+'].status_detail').ToString;//{},
                  tOrdersdate_created.AsString := jOrderRecent.GetValue<string>('results['+i+'].date_created');//"2019-06-13T18:12:24.000-04:00",
                  tOrdersdate_closed.AsString := jOrderRecent.GetValue<string>('results['+i+'].date_closed');//"2019-06-13T18:12:27.000-04:00",
                  tOrdersexpiration_date.AsString := jOrderRecent.GetValue<string>('results['+i+'].expiration_date');//"2019-07-11T18:12:27.000-04:00",
//                  tOrdersdate_last_updated.AsString := jOrderRecent.GetValue<string>('results['+i+'].date_last_updated');//"2019-06-24T12:11:26.353Z",
                  tOrdershidden_for_seller.AsString := jOrderRecent.GetValue<string>('results['+i+'].hidden_for_seller');//false,
                  tOrderscurrency_id.AsString := jOrderRecent.GetValue<string>('results['+i+'].currency_id');//"ARS",
  //                tOrdersorder_items.AsString := jOrderRecent.GetValue<string>('results['+i+'].order_items');//[],
                  ObtenerOrder_items(order_id, jOrderRecent.GetValue<TJSONValue>('results['+i+'].order_items'));
                  tOrderstotal_amount.AsString := jOrderRecent.GetValue<string>('results['+i+'].total_amount');//456.87,
                  tOrdersmediations.AsString := jOrderRecent.GetValue<TJSONValue>('results['+i+'].mediations').ToString;//[],
                  tOrderspayments.AsString := jOrderRecent.GetValue<TJSONValue>('results['+i+'].payments').ToString;//[],
  //                tOrdersshipping.AsString := jOrderRecent.GetValue<string>('results['+i+'].shipping');//{},
  //                shipping := jOrderRecent.GetValue<TJSONValue>('results['+i+'].shipping');
  //                id := shipping.GetValue<string>('id');
                  tOrdersshipping.AsString:=(jOrderRecent.GetValue<TJSONValue>('results['+i+'].shipping')).GetValue<string>('id');
  //                tOrdersshipping.AsString := ObtenerShipping(order_id, jOrderRecent.GetValue<TJSONValue>('results['+i+'].shipping'));
//                  if tOrdersshipping.AsString ='' then tOrdersshipping.AsString:='0';
//                  ObtenerShipping(tOrdersshipping.AsString);
                  tOrdersorder_request.AsString := jOrderRecent.GetValue<TJSONValue>('results['+i+'].order_request').ToString;//{},
                  tOrderspickup_id.AsString := jOrderRecent.GetValue<string>('results['+i+'].pickup_id');//null,
  //                tOrdersbuyer.AsString := jOrderRecent.GetValue<TJSONValue>('results['+i+'].buyer');//{},
                  tOrdersbuyer.AsString := ObtenerBuyer(jOrderRecent.GetValue<TJSONValue>('results['+i+'].buyer'));
                  tOrdersseller.AsString := jOrderRecent.GetValue<TJSONValue>('results['+i+'].seller').ToString;//{},
                  tOrdersfeedback.AsString := jOrderRecent.GetValue<TJSONValue>('results['+i+'].feedback').ToString;//{},
                  tOrderstags.AsString := jOrderRecent.GetValue<TJSONValue>('results['+i+'].tags').ToString;//[]
//                  ObtenerMessages(order_id,seller_id);
                  ObtenerDespachados(order_id);
                end;
//                tOrdersstatus.AsString := jOrderRecent.GetValue<string>('results['+i+'].status');//"paid",
//                tOrderstags.AsString := jOrderRecent.GetValue<TJSONValue>('results['+i+'].tags').ToString;//[]
//                tOrdersshipping.AsString:=(jOrderRecent.GetValue<TJSONValue>('results['+i+'].shipping')).GetValue<string>('id');
//                if tOrdersshipping.AsString ='' then tOrdersshipping.AsString:='0';
//              ObtenerShipping(tOrdersshipping.AsString);
//              ObtenerMessages(order_id,seller_id);
                last_updated:=jOrderRecent.GetValue<string>('results['+i+'].date_last_updated');
                if not (tOrdersdate_last_updated.AsString = last_updated) then
                  begin
                    tOrdersdate_last_updated.AsString := last_updated;
                    tOrdersstatus.AsString := jOrderRecent.GetValue<string>('results['+i+'].status');//"paid",
                    tOrderstags.AsString := jOrderRecent.GetValue<TJSONValue>('results['+i+'].tags').ToString;//[]
                    tOrdersshipping.AsString:=(jOrderRecent.GetValue<TJSONValue>('results['+i+'].shipping')).GetValue<string>('id');
                    if tOrdersshipping.AsString ='' then tOrdersshipping.AsString:='0';
                    ObtenerShipping(tOrdersshipping.AsString);
                    ObtenerMessages(order_id,seller_id);
                  end;
                tOrders.Post;
                dmML.dbMain.CommitRetaining;
                Application.ProcessMessages;
              end;
          end;
        until ((p=t) or (p>t));
      finally
      //
      end;
    end;
end;

procedure TDMR.AbrirEnBrowser;
begin
  ShellExecute(0,'open',pchar(LURL),nil,nil,SW_SHOWNORMAL);
end;

procedure TDMR.ObtenerSeller;
begin
  with dmML do
  begin
    try
      ObtenerConsultaRest('users/me?','');
      JSONValue1 := TJSONObject.ParseJSONValue(RESTRequest1.Response.Content);
      if JSONVAlue1 is TJSONObject then
      begin
        seller_id := JSONValue1.GetValue<string>('id');
      end;
    finally
      AgregarSeller(seller_id);
    end;
  end;
end;

procedure TDMR.ImprimirEtiqueta;
begin
  if  accessToken='' then ObtenerRefreshToken;
  if i<>'' then
    AbrirEnBrowser(
      'https://api.mercadolibre.com/shipment_labels?shipment_ids='+i+'&response_type=pdf&access_token='+accessToken
    );
end;

function TDMR.Obtener;//(resource:string):TJSONValue;
//var
//  tRest: array [0 .. 9999 - 1] of TTRest;
begin
//Para conocer el pack_id, deberás obtener el campo “pack_id” en la respuesta de /orders/<order_id>
//  with dmML do
//  begin
    try
      result:=nil;
      if  accessToken='' then ObtenerRefreshToken;
  //curl -X GET “https://api.mercadolibre.com/messages/packs/$pack_id/sellers/$user_id?access_token=$ACCESS_TOKEN”
  //      tRest := TTRest.Create(
      Inc(tI);
      tRest[tI] := TTRest.Create(
        url,
        resource+''+'client_id='+clientId+
        '&client_secret='+clientSecret+'&access_token='+accessToken,
        'application/json',
        rmGET
      );
      with tRest[tI] do
      begin
        tRest[tI].vJSONValue := result;
//        tRest[tI].FreeOnTerminate := True;
//        tRest[tI].Start;
      end;
////      result := tRest[tI].vJSONValue;
////      if Assigned(tRest[tI]) then
//      while (Assigned(tRest[tI]) and (not tRest[tI].termino) and (not tRest[tI].Terminated)) do
////        while (not tRest[tI].Terminated) do
//        begin
//          Application.ProcessMessages;
////          result := tRest[tI].vJSONValue;
//        end;

//      tRest[tI].WaitFor;
//      while not tRest[tI].termino do
//        Application.ProcessMessages;
    if not tRest[tI].Terminated then
      tRest[tI].WaitFor;

    finally
      result := tRest[tI].vJSONValue;
//      tRest[tI].vRequest.Free;
//      tRest[tI].vClient.Free;
//     vResponse.Free;
//      tRest[tI].Terminate;
    end;
//  end;
end;

procedure TDMR.ObtenerPack;
var
  j : TJSONValue;
  pack_id : string;
begin
//Para conocer el pack_id, deberás obtener el campo “pack_id” en la respuesta de /orders/<order_id>
//    try
//      ObtenerConsultaRest('/orders/'+order_id,'');
//      tRest := TTRest.Create(
//        url, '/orders/'+order_id
//        +'?'+'client_id='+clientId+'&client_secret='+clientSecret+
//        '&access_token='+accessToken, 'application/json',
//        rmGET
//      );
//      with tRest do
//    begin
//      vJSONValue := JSONValue;
//      FreeOnTerminate := True;
//      Start;//Resume;
//    end;
//
//    while not tRest.Terminated do
//    begin
//      Application.ProcessMessages;
//      JSONValue := tRest.vJSONValue;
//    end;
//      if JSONValue is TJSONArray then
//        pack_id := JSONValue.GetValue<string>('pack_id');
      j := Obtener('/orders/'+order_id+'?');
      if j is TJSONObject then
          pack_id := j.GetValue<string>('pack_id');
      if pack_id<>'' then
        with dmML do
        begin
          AgregarPack(order_id,pack_id);
        end;
end;

procedure TDMR.ObtenerMessages;//(order_id,pack_id, user_id:string);
var
  tObtenerMensajes: TTObtenerMensajes;
//  j, results, texto :TJSONValue;
//  id, message_id, message_text, i, s :string;
//  r,n :Integer;
begin
//curl -X GET “https://api.mercadolibre.com/messages/packs/$pack_id/sellers/$user_id?access_token=$ACCESS_TOKEN”
//  if pack_id<>'' then
//    id := pack_id;
//  else
//    id := order_id;
//  j := Obtener('/messages/packs/'+id+'/sellers/'+user_id);
//  j := Obtener('/messages/orders/'+id);
with dmML do
begin
  try
    tObtenerMensajes := TTObtenerMensajes.Create(order_id);
    with tObtenerMensajes do
    begin
      FreeOnTerminate := True;
      Start;
    end;
  finally
//    tObtenerMensajes.Terminate;
  end;
end;
//  if j is TJSONObject then
//  begin
//    results := j.GetValue<TJSONValue>('results');
//    r:=TJSONArray(results).Size;
//    if r>0 then
//      with dmml do
//      with tMessages do
////        with tMessages do
//          for n := 0 to r-1 do
//          begin
//            i:=IntToStr(n);
//            message_id := j.GetValue<string>('results['+i+'].message_id');
//            id := order_id+'_'+message_id;
////            if CantidadRegistros('messages','id='+QuotedStr(id))>0 then
//            Open(sqlMessages+' WHERE id=:I',[id]);
//            if RecordCount>0 then
////              Edit
//            else
//            begin
//              tMessages.Insert;
//              tMessagesid.AsString := id;
////              tMessagesorder_id.AsString := order_id;
//              tMessagesmessage_id.AsString := message_id;
//              texto := j.GetValue<TJSONValue>('results['+i+'].text');
//              tMessagestext_plain.AsString := texto.GetValue<string>('plain');
//  //            tMessagesid.AsString := j.GetValue<string>('results['+i+'].id');
//  //            tMessagesorder_id.AsString := j.GetValue<string>('results['+i+'].order_id');
//  //            tMessagespack_id.AsString := j.GetValue<string>('results['+i+'].pack_id');
//  //            tMessagesmessage_id.AsString := j.GetValue<string>('results['+i+'].message_id');
//              tMessagesdate_received.AsString := j.GetValue<string>('results['+i+'].date_received');
//              tMessagesdate.AsString := j.GetValue<string>('results['+i+'].date');
//              tMessagesdate_available.AsString := j.GetValue<string>('results['+i+'].date_available');
//              tMessagesdate_notified.AsString := j.GetValue<string>('results['+i+'].date_notified');
//              tMessagesdate_read.AsString := j.GetValue<string>('results['+i+'].date_read');
//  //            tMessagesfrom_user_id.AsString := j.GetValue<string>('results['+i+'].from_user_id');
//  //            tMessagesfrom_email.AsString := j.GetValue<string>('results['+i+'].from_email');
//  //            tMessagesfrom_name.AsString := j.GetValue<string>('results['+i+'].from_name');
//  //            tMessagesto_user_id.AsString := j.GetValue<string>('results['+i+'].to_user_id');
//  //            tMessagesto_email.AsString := j.GetValue<string>('results['+i+'].to_email');
//              tMessagessubject.AsString := j.GetValue<string>('results['+i+'].subject');
//  //            tMessagestext_plain.AsString := j.GetValue<string>('results['+i+'].text_plain');
//  //            tMessagesattachments.AsString := j.GetValue<string>('results['+i+'].attachments');
//  //            tMessagesattachments_validations_invalid_size.AsString := j.GetValue<string>('results['+i+'].attachments_validations_invalid_size');
//  //            tMessagesattachments_validations_invalid_extension.AsString := j.GetValue<string>('results['+i+'].attachments_validations_invalid_extension');
//  //            tMessagesattachments_validations_forbidden.AsString := j.GetValue<string>('results['+i+'].attachments_validations_forbidden');
//  //            tMessagesattachments_validations_internal_error.AsString := j.GetValue<string>('results['+i+'].attachments_validations_internal_error');
//              tMessagessite_id.AsString := j.GetValue<string>('results['+i+'].site_id');
//              tMessagesresource.AsString := j.GetValue<string>('results['+i+'].resource');
//              tMessagesresource_id.AsString := j.GetValue<string>('results['+i+'].resource_id');
//              tMessagesstatus.AsString := j.GetValue<string>('results['+i+'].status');
//  //            tMessagesmoderation_status.AsString := j.GetValue<string>('results['+i+'].moderation_status');
//  //            tMessagesmoderation_date_moderated.AsString := j.GetValue<string>('results['+i+'].moderation_date_moderated');
//  //            tMessagesmoderation_source.AsString := j.GetValue<string>('results['+i+'].moderation_source');
//              tMessagesconversation_first_message.AsString := j.GetValue<string>('results['+i+'].conversation_first_message');
//  //            tMessagesconversation_status.AsString := j.GetValue<TJSONValue>('results['+i+'].conversation_status').ToString;
//  //            tMessagesconversation_status_date.AsString := j.GetValue<string>('results['+i+'].conversation_status_date');
//  //            tMessagesconversation_substatus.AsString := j.GetValue<string>('results['+i+'].conversation_substatus');
//  //            tMessagesconversation_is_blocking_allowed.AsString := j.GetValue<string>('results['+i+'].conversation_is_blocking_allowed');
//              tMessages.Post;
//            end;
//          end;
//  end;
end;

procedure TDMR.ObtenerOrder_items;
var
  item, order_items : TJSONValue;
  io, id, item_id : string;
  ro, no : Integer;
begin
  ro := TJSONArray(j).Size;
  with dmML do
    with tOrder_items do
      if ro>0 then
        for no := 0 to ro-1 do
        begin
          io:=IntToStr(no);
          order_items := j.GetValue<TJSONValue>('['+io+']');
          item := order_items.GetValue<TJSONValue>('item');
          item_id := item.GetValue<string>('id');
          id := order_id+'_'+item_id;
          Open(sqlOrder_items+' WHERE id=:I',[id]);
          if RecordCount>0 then
            Edit
          else
          begin
            Insert;
            tOrder_itemsid.AsString := id;
          end;
          tOrder_itemsorder_id.AsString := order_id;
          tOrder_itemsitem_id.AsString := item_id;
          tOrder_itemstitle.AsString := item.GetValue<string>('title');
          tOrder_itemsseller_custom_field.AsString := item.GetValue<string>('seller_custom_field');
          tOrder_itemscondition.AsString := item.GetValue<string>('condition');
          tOrder_itemscategory_id.AsString := item.GetValue<string>('category_id');
          tOrder_itemsvariation_id.AsString := item.GetValue<string>('variation_id');
//          tOrder_itemsvariation_attributes.AsString := item.GetValue<TJSONValue>('variation_attributes');// [],
          tOrder_itemsseller_sku.AsString := item.GetValue<string>('seller_sku');
          if tOrder_itemsseller_sku.AsString='' then tOrder_itemsseller_sku.AsString:=tOrder_itemsseller_custom_field.AsString;
          tOrder_itemswarranty.AsString := item.GetValue<string>('warranty');
          tOrder_itemsquantity.AsString := order_items.GetValue<string>('quantity');// 1,
//          tOrder_itemsdifferential_pricing_id.AsString := order_items.GetValue<TJSONValue>('differential_pricing_id');
          tOrder_itemssale_fee.AsString := order_items.GetValue<string>('sale_fee');
          tOrder_itemslisting_type_id.AsString := order_items.GetValue<string>('listing_type_id');
          tOrder_itemsbase_currency_id.AsString := order_items.GetValue<string>('base_currency_id');
          tOrder_itemsunit_price.AsString := order_items.GetValue<string>('unit_price');
          tOrder_itemsfull_unit_price.AsString := order_items.GetValue<string>('full_unit_price');
          tOrder_itemsbase_exchange_rate.AsString := order_items.GetValue<string>('base_exchange_rate');
          tOrder_itemscurrency_id.AsString := order_items.GetValue<string>('currency_id');
          tOrder_itemsmanufacturing_days.AsString := order_items.GetValue<string>('manufacturing_days');
          Post;
        end;
end;

procedure TDMR.ObtenerShipping;
var
//  tObtenerEnvio: TTObtenerEnvio;
  j, shipping : TJSONValue;
  r : Integer;
  s:string;
begin
  with dmML do
  begin
    if id='0' then
    begin
      with tShipments do
      begin
        Open('SELECT * FROM shipments WHERE id=:I',['0']);
        if RecordCount>0 then
//          Edit
        else
        begin
          Insert;
          tShipmentsid.AsString:='0';
          //        tShipmentsorder_id.AsString:='0';
          tShipmentsstatus.AsString:='';
          tShipmentsmode.AsString:='';
          tShipmentsshipping_option.AsString:='0';
          Post;
        end;
      end;
      with tShipping_option do
      begin
        Open(sqlShipping_option+' WHERE id=:I',['0']);
        if RecordCount>0 then
//          Edit
        else
        begin
          Insert;
          tShipping_optionid.AsString := '0';
          tShipping_optionshipping_method_id.AsString:='';
          Post;
        end;
      end;
    end
    else
    begin
//      j := Obtener('/shipments/'+id);
        try
//          tObtenerEnvio := TTObtenerEnvio.Create(id);
          Inc(teI);
          tObtenerEnvio[teI] := TTObtenerEnvio.Create(id);
//          with tObtenerEnvio do
//          begin
//            FreeOnTerminate := True;
//            Start;
//          end;
        finally
//          tObtenerEnvio.Terminate;
        end;
//      if j is TJSONObject then
//      begin
//        shipping := j.GetValue<TJSONValue>();//('Results');
//        with tShipments do
//        begin
//          id := shipping.GetValue<string>('id');
//          Open(sqlShipments+' WHERE id=:I',[id]);
//          if RecordCount>0 then
//            Edit
//          else
//          begin
//            Insert;
//            tShipmentsid.AsString := id;
//            tShipmentsmode.AsString := shipping.GetValue<string>('mode');
//            tShipmentscreated_by.AsString := shipping.GetValue<string>('created_by');
//            tShipmentsorder_id.AsString := shipping.GetValue<string>('order_id');
//            tShipmentsorder_cost.AsString := shipping.GetValue<string>('order_cost');
//            tShipmentsbase_cost.AsString := shipping.GetValue<string>('base_cost');
//            tShipmentssite_id.AsString := shipping.GetValue<string>('site_id');
//            tShipmentsstatus.AsString := shipping.GetValue<string>('status');
//            tShipmentssubstatus.AsString := shipping.GetValue<string>('substatus');
//            tShipmentsstatus_history.AsString := shipping.GetValue<TJSONValue>('status_history').ToString;
//            if tShipmentssubstatus.AsString<>'' then
//              tShipmentssubstatus_history.AsString := shipping.GetValue<TJSONValue>('substatus_history').ToString;
//            tShipmentsdate_created.AsString := shipping.GetValue<string>('date_created');
//            tShipmentslast_updated.AsString := shipping.GetValue<string>('last_updated');
//            tShipmentstracking_number.AsString := shipping.GetValue<string>('tracking_number');
//            tShipmentstracking_method.AsString := shipping.GetValue<string>('tracking_method');
//            tShipmentsservice_id.AsString := shipping.GetValue<string>('service_id');
//            tShipmentscarrier_info.AsString := shipping.GetValue<TJSONValue>('carrier_info').ToString;
//            tShipmentssender_id.AsString := shipping.GetValue<string>('sender_id');
//            tShipmentssender_address.AsString := shipping.GetValue<TJSONValue>('sender_address').ToString;
//            tShipmentsreceiver_id.AsString := shipping.GetValue<string>('receiver_id');
//            tShipmentsreceiver_address.AsString := shipping.GetValue<TJSONValue>('receiver_address').ToString;
//            tShipmentsshipping_items.AsString := shipping.GetValue<TJSONValue>('shipping_items').ToString;
//  //          tShipmentsshipping_option.AsString := shipping.GetValue<TJSONValue>('shipping_option').ToString
//            tShipmentsshipping_option.AsString := ObtenerShipping_option(shipping.GetValue<TJSONValue>('shipping_option'));
//            tShipmentscomments.AsString := shipping.GetValue<string>('comments');
//            tShipmentsdate_first_printed.AsString := shipping.GetValue<string>('date_first_printed');
//            tShipmentsmarket_place.AsString := shipping.GetValue<string>('market_place');
//            tShipmentsreturn_details.AsString := shipping.GetValue<string>('return_details');
//            tShipmentstags.AsString := shipping.GetValue<TJSONValue>('tags').ToString;
//            if tShipmentstags.AsString<>'[]' then
//            begin
//              tShipmentsdelay.AsString := shipping.GetValue<TJSONValue>('delay').ToString;
//              tShipmentstype.AsString := shipping.GetValue<TJSONValue>('type').ToString;
//              tShipmentslogistic_type.AsString := shipping.GetValue<string>('logistic_type');
//              tShipmentsapplication_id.AsString := shipping.GetValue<string>('application_id');
//            end;
//            tShipmentsreturn_tracking_number.AsString := shipping.GetValue<string>('return_tracking_number');
//            tShipmentscost_components.AsString := shipping.GetValue<TJSONValue>('cost_components').ToString;
//          end;
//          tShipmentsstatus.AsString := shipping.GetValue<string>('status');
//          if tShipmentssubstatus.AsString<>'' then
//            tShipmentssubstatus_history.AsString := shipping.GetValue<TJSONValue>('substatus_history').ToString;
//          Post;
//        end;
//      end;
    end;
  end;
//      Application.ProcessMessages;
end;

function TDMR.ObtenerBuyer;
var
  buyer : TJSONValue;
  id : string;
begin
  with dmML do
    with tBuyer do
    begin
      buyer := j.GetValue<TJSONValue>();//('['+io+']');
      id := buyer.GetValue<string>('id');
      Open(sqlBuyer+' WHERE id=:I',[id]);
      if RecordCount>0 then
//        Edit
      else
      begin
        Insert;
        tBuyerid.AsString := id;
//        tBuyerid.AsString := buyer.GetValue<string>('id');
        tBuyernickname.AsString := buyer.GetValue<string>('nickname');
        tBuyeremail.AsString := buyer.GetValue<string>('email');
        tBuyerphone.AsString := buyer.GetValue<TJSONValue>('phone').ToString;
        tBuyeralternative_phone.AsString := buyer.GetValue<TJSONValue>('alternative_phone').ToString;
        tBuyerfirst_name.AsString := buyer.GetValue<string>('first_name');
        tBuyerlast_name.AsString := buyer.GetValue<string>('last_name');
        tBuyerbilling_info.AsString := buyer.GetValue<TJSONValue>('billing_info').ToString;
        Post;
      end;
      result := id;
    end;
//    Application.ProcessMessages;
end;

end.
