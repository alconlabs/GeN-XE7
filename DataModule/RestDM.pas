unit RestDM;

interface

uses
  System.SysUtils, System.Classes, IPPeerClient, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, REST.Response.Adapter, REST.Client, Data.DB,
  IBX.IBCustomDataSet, IBX.IBQuery, Data.Bind.Components, Data.Bind.ObjectScope,
  System.JSON, REST.Types, DataModule;

type
  TRestDataModule = class(TDataModule)
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
  public
    { Public declarations }
    procedure GetREST(resource: string);
    function existeEnTJSONArray(tabla: string ; streams: TJSONArray): string;
    procedure importCategories(borrar : Boolean);
    procedure PostREST(resource, datos: string);
    procedure PutREST(resource, datos: string);
    var JAline_items : TJSONArray;
    function Jline_items( codigo, cantidad : String ): TJSONObject;
    procedure CrearOrden;
  end;

var
  RestDataModule: TRestDataModule;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses OperacionDM;

{$R *.dfm}

procedure TRestDataModule.GetREST;
begin
  IniciarREST;
  RESTRequest1.Resource := resource;
  RESTRequest1.Execute;
  if not ( ( RESTResponse1.Content = #$FEFF'[]' ) or ( RESTResponse1.Content  =  '[]' ) ) then
  O.Open;
end;

procedure TRestDataModule.ResetRESTComponentsToDefaults;
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

procedure TRestDataModule.GetRESTCategories;
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

procedure TRestDataModule.DataModuleCreate(Sender: TObject);
begin
  JAline_items := TJSONArray.Create();
end;

function TRestDataModule.existeEnTJSONArray;
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

procedure TRestDataModule.importCategories;
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

procedure TRestDataModule.PostREST;
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

procedure TRestDataModule.PutREST;
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

procedure TRestDataModule.IniciarREST;
begin
  ResetRESTComponentsToDefaults;
  RESTClient1.BaseURL := webUrl;
  RESTRequest1.Resource := WebRes;
  RESTRequest1.Params.AddItem('consumer_key', webUsr, TRESTRequestParameterKind.pkGETorPOST);
  RESTRequest1.Params.AddItem('consumer_secret', webPsw, TRESTRequestParameterKind.pkGETorPOST);
end;

procedure TRestDataModule.CrearOrden;
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

function TRestDataModule.Jline_items;
begin
  Result := TJSONObject.Create();
  Result.AddPair(TJSONPair.Create('product_id', codigo) );
  Result.AddPair(TJSONPair.Create('quantity', cantidad) );
end;

end.
