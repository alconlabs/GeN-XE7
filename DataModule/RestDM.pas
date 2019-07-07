unit RestDM;

interface

uses
  System.SysUtils, System.Classes, IPPeerClient, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, REST.Response.Adapter, REST.Client, Data.DB,
  IBX.IBCustomDataSet, IBX.IBQuery, Data.Bind.Components, Data.Bind.ObjectScope,
  System.JSON, REST.Types, Winapi.ShellAPI, REST.Utils, Winapi.Windows,
  Vcl.DdeMan, Dialogs, DataModule;

type
  TDMR = class(TDataModule)
    RESTResponseCategories: TRESTResponse;
    RESTResponse1: TRESTResponse;
    RESTClientCategories: TRESTClient;
    RESTClient1: TRESTClient;
    Q: TIBQuery;
    T: TIBQuery;
    RESTRequest1: TRESTRequest;
    RESTRequestCategories: TRESTRequest;
    RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter;
    RESTResponseDataSetAdapterCategories: TRESTResponseDataSetAdapter;
    FDMemTableCategories: TFDMemTable;
    O: TFDMemTable;
    D: TIBQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    procedure ResetRESTComponentsToDefaults;
    procedure GetRESTCategories(resource: string);
    procedure IniciarREST;

    procedure IniciarObtenerToken;
    procedure EjecutarObtenerToken;
    procedure IniciarObtenerRest(u,r:string;m:TRESTRequestMethod);
    function GetURL(service: string): string;
    procedure AbrirEnBrowser(LURL:string);
    procedure ObtenerAuthCode;
    procedure ObtenerAccessToken;
    procedure ObtenerRefreshToken;
    procedure ObtenerConsultaRest(r,q:string);

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
  end;

const
  clientId = '5480711421985209';
  clientSecret = 'jXCjaf3TmYxUaA84GRVFEMDBgvTPLLFZ';
  url = 'https://api.mercadolibre.com/';
  redirectUri = 'https://www.mercadolibre.com';

var
  DMR: TDMR;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses udmMercadoLibre, OperacionDM;

{$R *.dfm}

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
  dmML := TdmML.Create(self);
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
  end;
end;

procedure TDMR.ObtenerOrderRecent;
var
  order_items, buyer, item, shipping : TJSONValue;
  i : string;
begin
  with dmML do
  begin
    try
      i:='0';
      ObtenerConsultaRest('orders/search/recent?seller=242069506','');
      JSONValue1 := TJSONObject.ParseJSONValue(RESTRequest1.Response.Content);
      if JSONVAlue1 is TJSONObject then
      begin
        order_id := JSONValue1.GetValue<Integer>('results['+i+'].id');
        order_status := JSONValue1.GetValue<String>('results['+i+'].status');
        order_items := JSONValue1.GetValue<TJSONValue>('results['+i+'].order_items[0]');
    //      ShowMessage( JSONValue1.GetValue<TJSONValue>('results['+i+'].order_items').ToString );
    //      order_items := JSONValue1.GetValue<TJSONValue>('results['+i+'].order_items[0]');
        item := order_items.GetValue<TJSONValue>('item');
        item_id := item.GetValue<string>('id');
        item_title := item.GetValue<string>('title');
        order_items_quantity := order_items.GetValue<Integer>('quantity');
        buyer := JSONValue1.GetValue<TJSONValue>('results['+i+'].buyer');
        buyer_id := buyer.GetValue<Integer>('id');
        shipping := JSONValue1.GetValue<TJSONValue>('results['+i+'].shipping');
//ShowMessage( JSONValue1.GetValue<TJSONValue>('results['+i+'].shipping').ToString );
        if shipping.GetValue<TJSONValue>('id').ToString<>'null' then
          shipping_id := shipping.GetValue<Integer>('id');
      end;
    finally
      AgregarOrder;
    end;
    if shipping_id>0 then
      AbrirEnBrowser(
        'https://api.mercadolibre.com/shipment_labels?shipment_ids='+IntToStr(shipping_id)+'&response_type=pdf&access_token='+accessToken
      );
  end;
end;

procedure TDMR.AbrirEnBrowser;
begin
  ShellExecute(0,'open',pchar(LURL),nil,nil,SW_SHOWNORMAL);
end;

end.
