unit MigrarF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Buttons,
  REST.Client, Data.Bind.Components, Data.Bind.ObjectScope,
  REST.Authenticator.Basic, Datasnap.DBClient, REST.Response.Adapter, Vcl.Grids,
  Vcl.DBGrids, Data.DB, IPPeerClient, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client
  ,REST.Types, IBX.IBCustomDataSet, IBX.IBTable, FireDAC.Stan.Async,
  FireDAC.DApt, IBX.IBQuery, FireDAC.UI.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef,
  FireDAC.VCLUI.Wait
  ,System.JSON
  ;

type
  TMigrarForm = class(TForm)
    ProcesarButton: TButton;
    ProgressBar1: TProgressBar;
    Edit1: TEdit;
    BitBtn1: TBitBtn;
    EditUrl: TEdit;
    EditResource: TEdit;
    EditUser: TEdit;
    EditPassword: TEdit;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter;
    O: TFDMemTable;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    FDConnection1: TFDConnection;
    T: TFDQuery;
    D: TFDQuery;
    Button1: TButton;
    Q: TFDQuery;
    FDMemTable1: TFDMemTable;
    Memo1: TMemo;
    RESTClientCategories: TRESTClient;
    RESTRequestCategories: TRESTRequest;
    RESTResponseCategories: TRESTResponse;
    FDMemTableCategories: TFDMemTable;
    RESTResponseDataSetAdapterCategories: TRESTResponseDataSetAdapter;
    procedure ProcesarButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure RESTResponseDataSetAdapter1BeforeOpenDataSet(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    RubroId, CategoriaId, SubCategoriaId : string;
    procedure ResetRESTComponentsToDefaults;
    procedure GetREST(url, resource, ck, cs: string);
    procedure GetRESTCategories(url, resource, ck, cs: string);
    function existeEnTJSONArray(tabla: string ; streams: TJSONArray): string;
    function existeEnTabla(tabla,codigo: string): Boolean;
    procedure importCategories;
  public
    { Public declarations }
  end;

var
  MigrarForm: TMigrarForm;

implementation

{$R *.dfm}

procedure TMigrarForm.BitBtn1Click(Sender: TObject);
begin
  { OpenDialog1.Execute();
    Edit1.Text := OpenDialog1.FileName; }
end;

procedure TMigrarForm.Button1Click(Sender: TObject);
var
  LJsonArr    : TJSONArray;
  LJsonValue  : TJSONValue;
  LItem       : TJSONValue;
  StrJson     : String;
begin

StrJson :=
  '['+
  '{"EventType":49,"Code":"234","EventDate":"20050202", "Result":1},'+
  '{"EventType":48,"Code":"0120","EventDate":"20130201", "Group":"g1"}'+
  ']';


StrJson := '[{"id":110,"name":"Gabinetes de Pc","slug":"gabinetes-de-pc"},{"id":25,"name":"Pc","slug":"pc"}]';

   LJsonArr    := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(StrJson),0) as TJSONArray;
//   categories := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(StrJson),0) as TJSONArray;
//   LItem:=1;
//   showmessage( [TJSONPair(LItem).JsonString.Value, TJSONPair(LItem+1).JsonValue.Value] );

ShowMessage(LJsonArr.ToString);



end;

procedure TMigrarForm.FormShow(Sender: TObject);
begin
  // DM := TDM.Create(self);
  { OperacionDataModule := TOperacionDataModule.Create(self); }
end;

procedure TMigrarForm.ProcesarButtonClick(Sender: TObject);
var
  i,p: integer;
  mar, col, cat, subcat, rub, s, disponible: string;
  categories: TJSONArray;
    function ConvertToDateTimeStr(DateStr: String): String;
    var
      s: string;
      fmt: TFormatSettings;
    begin
      fmt := TFormatSettings.Create;
      fmt.ShortDateFormat := 'YYYY-MM-DD';
      //      fmt.ShortTimeFormat := 'hh:mm:ss';
      //      fmt.TimeSeparator := ':';
      fmt.DateSeparator := '-';
      Result := formatdatetime('mm/dd/yyyy hh:mm:ss',StrToDateTime(DateStr, fmt));
    end;

begin
  importCategories;
  p:=0;
  repeat
    Inc(p);
    GetREST(EditUrl.text, EditResource.text+'status=publish&per_page=100&page='+IntToStr(p)+'&', EditUser.text, EditPassword.text);
    ProgressBar1.Max := O.RecordCount;
    if (O.RecordCount>0) and (not existeEnTabla('Articulo',O.FieldByName('id').AsString)) then
      for i := 0 to O.RecordCount - 1 do
      begin
        categories := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(O.FieldByName('categories').AsString),0) as TJSONArray;
        rub := existeEnTJSONArray('Rubro',categories);
        cat := existeEnTJSONArray('Categoria',categories);
        subcat := existeEnTJSONArray('SubCategoria',categories);
        disponible:=O.FieldByName('stock_quantity').AsString;
        if disponible='' then disponible:='0';
        D.SQL.Text := 'INSERT INTO "Articulo" ( CODIGO, DESCRIPCION, PRECIO '
        + ', PRECIO1, PRECIO2, DISPONIBLE'
        + ', FECHA, CODIGOBARRA'
        + ', CATEGORIA, COLOR, MARCA, PROVEEDOR, RUBRO, SUBCATEGORIA'
        //    ', COSTO, ULTCOSTO, PRECIO1, PRECIO2, ' + ' PRECIO3, PRECIO4, PRECIO5, ' +
        //    ' PRECIO6, ' + ' ULTPRECIO, ' +
        //    '  UBICACION, ' +
        //    ' UNIDAD, ENPRODUCCION, ' + ' NOTAS, IVA, TASA, ' +
        //    ' IMPOTROS, IIBB, STOCKMINIMO, ' +
        //    ' STOCKMAXIMO, STOCKVENDIDO, FECHACOMPULT, ' +
        //    ' LISTA, PROCEDENCIA, ' + ' GARANTIA, ' +
        //    '  PEDIDO, STOCK' + ' EXISTENTE, ACTUAL, MARCADOCONTADO, ' +
        //    ' MARCADOLISTA, MARCADOFINAL, PREPARADO, ' +
        //    ' CTANOMBRE, CTATIPO, CTAANTICIPO, ' + ' CTAIIBB, ESTADO, VENCE, VENCIMIENTO' +
        + ' ) VALUES ( '
        + IntToStr(O.FieldByName('id').AsInteger) + ', ' + QuotedStr(O.FieldByName('name').AsString) + ', ' + O.FieldByName('price').AsString+'0'
        + ', ' + O.FieldByName('regular_price').AsString+'0' + ', ' + O.FieldByName('sale_price').AsString+'0' + ', ' + disponible
        + ', ' + QuotedStr(ConvertToDateTimeStr(O.FieldByName('date_modified').AsString)) + ', ' + QuotedStr(O.FieldByName('sku').AsString)
        //    ', ' + ' ' + O.FieldByName('Costo').AsString + ', ' + O.FieldByName('Precio1').AsString
        //    + ', ' + O.FieldByName('Precio2').AsString + ', ' + ' ' +
        //    O.FieldByName('Precio3').AsString + ', ' + O.FieldByName('Precio4')
        //    .AsString + ', ' + O.FieldByName('Precio5').AsString + ', ' + ' ' +
        //    O.FieldByName('Precio6').AsString + ', ' + O.FieldByName('PrecioCtaCte')
        //    .AsString + ', ' + ' ' + O.FieldByName('UltPrecioCtaCte').AsString + ', '
        //    + mar + ', ' + col + ', ' + ' ' + cat + ', ' + subcat + ', NULL, ' +
        //    ' ''c/u'', ' + O.FieldByName('Disponible').AsString + ', NULL, ' +
        //    ' NULL, ' + O.FieldByName('IVA').AsString + ', ' + O.FieldByName('Tasa')
        //    .AsString + ', ' + ' ' + O.FieldByName('ImpOtros').AsString + ', ' +
        //    O.FieldByName('ImpOtros').AsString + ', ' + O.FieldByName('StockMinimo')
        //    .AsString + ', ' + ' ' + O.FieldByName('StockMaximo').AsString +
        //    ', 0, ''07/07/2010'', ' + ' NULL, NULL, ''11000259'', ' + ' ' + rub +
        //    ', 1, NULL, ' + ' ''07/22/2010 11:46:07'', NULL, NULL, ' +
        //    ' NULL, NULL, NULL, ' + ' NULL, NULL, NULL, ' + ' 13, 13, 13, ' +
        //    ' 66, NULL, NULL, ' + ' NULL
        + ', '+cat+', 0, 0, 1, '+rub+', '+subcat+' )';
        D.ExecSQL;
        ProgressBar1.Position := i;
        O.Next;
      end;
  until ((O.RecordCount=0) or (O.RecordCount=1));
  //    D.Transaction.CommitRetaining;
  ShowMessage('llora pepelui');
end;

procedure TMigrarForm.ResetRESTComponentsToDefaults;
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

procedure TMigrarForm.RESTResponseDataSetAdapter1BeforeOpenDataSet
  (Sender: TObject);
begin
//  if ClientDataSet1.FieldCount = 0 then
//    ClientDataSet1.CreateDataSet;
end;

procedure TMigrarForm.GetREST;
begin
  ResetRESTComponentsToDefaults;
RESTClient1.BaseURL := url;
  RESTRequest1.Resource := resource;
  RESTRequest1.Params.AddItem('consumer_key', ck, TRESTRequestParameterKind.pkGETorPOST);
  RESTRequest1.Params.AddItem('consumer_secret', cs, TRESTRequestParameterKind.pkGETorPOST);
  RESTRequest1.Execute;
  if RESTResponse1.Content<>'[]' then O.Open;
end;

procedure TMigrarForm.GetRESTCategories;
begin
  FDMemTableCategories.Close;
  RESTClientCategories.ResetToDefaults;
  RESTClientCategories.ResetToDefaults;
  RESTResponseCategories.ResetToDefaults;
  RESTClientCategories.BaseURL := url;
  RESTRequestCategories.Resource := resource;
  RESTRequestCategories.Params.AddItem('consumer_key', ck, TRESTRequestParameterKind.pkGETorPOST);
  RESTRequestCategories.Params.AddItem('consumer_secret', cs, TRESTRequestParameterKind.pkGETorPOST);
  RESTRequestCategories.Execute;
  if RESTResponseCategories.Content<>'[]' then FDMemTableCategories.Open;
end;

procedure TMigrarForm.importCategories;
var
  id,name,parent: string;
  i,p: integer;
begin
  GetRESTCategories(EditUrl.text, 'products/categories/?per_page=100&page=1&parent=0&', EditUser.text, EditPassword.text);

  ProgressBar1.Max := FDMemTableCategories.RecordCount;
  for i := 0 to FDMemTableCategories.RecordCount - 1 do
  begin
    id := FDMemTableCategories.FieldByName('id').AsString;
    name := FDMemTableCategories.FieldByName('name').AsString;
    parent := FDMemTableCategories.FieldByName('parent').AsString;

//    T.SQL.Text := 'SELECT * FROM "Rubro" WHERE CODIGO = ' + id;
//    T.Open;
    if not existeEnTabla('Rubro',id) then //    if T.RecordCount = 0 then
    begin
      D.SQL.Text := 'INSERT INTO "Rubro" (CODIGO,DESCRIPCION) VALUES ('
      + id + ',' + QuotedStr(name) + ')';
      D.ExecSQL;
    end;
    FDMemTableCategories.Next;
  end;
  p:=0;
  repeat
    Inc(p);
    FDMemTableCategories.Close;
    GetRESTCategories(EditUrl.text, 'products/categories/?per_page=100&page='+IntToStr(p)+'&', EditUser.text, EditPassword.text);

    FDMemTableCategories.Filtered := False;
    FDMemTableCategories.Filter := 'parent <> 0';//  O.Filter := 'parent LIKE ' + QuotedStr('%' + IntToStr( category ) + '%');
    FDMemTableCategories.Filtered := True;

    ProgressBar1.Max := FDMemTableCategories.RecordCount;
    for i := 0 to FDMemTableCategories.RecordCount - 1 do
    begin
      id := FDMemTableCategories.FieldByName('id').AsString;
      name := FDMemTableCategories.FieldByName('name').AsString;
      parent := FDMemTableCategories.FieldByName('parent').AsString;
//      T.SQL.Text := 'SELECT * FROM "Rubro" WHERE CODIGO = ' + parent;
//      T.Open;
        if not existeEnTabla('Rubro',id) then//      if T.RecordCount = 0 then
        begin
//          T.SQL.Text := 'SELECT * FROM "SubCategoria" WHERE CODIGO = ' + id;
//          T.Open;
          if not existeEnTabla('SubCategoria',id) then//          if T.RecordCount = 0 then
          begin
            D.SQL.Text := 'INSERT INTO "SubCategoria" (CODIGO,DESCRIPCION) VALUES ('
            + id + ',' + QuotedStr(name) + ')';
            D.ExecSQL;
          end;
        end
      else
        begin
//          T.SQL.Text := 'SELECT * FROM "Categoria" WHERE CODIGO = ' + id;
//          T.Open;
          if not existeEnTabla('Categoria',id) then//          if T.RecordCount = 0 then
          begin
            D.SQL.Text := 'INSERT INTO "Categoria" (CODIGO,DESCRIPCION) VALUES ('
            + id + ',' + QuotedStr(name) + ')';
            D.ExecSQL;
          end;
        end;
    FDMemTableCategories.Next;
    end;

  until FDMemTableCategories.RecordCount=0;

end;

function TMigrarForm.existeEnTJSONArray;
var
  stream: TJSONObject;
  id: TJSONString;
  i: integer;
begin
//  i:=0;
//  repeat
  for i := 0 to streams.Size - 1 do
  begin
    stream := streams.Get(i) as TJSONObject;
    id := stream.Get('id').JsonValue as TJSONString;
    if existeEnTabla(tabla,id.Value) then
    begin
      result := id.Value;
      exit;
    end;
  end;
  result :='0';
end;

  function TMigrarForm.existeEnTabla;
  begin
    T.SQL.Text := 'SELECT * FROM "' + tabla + '" WHERE CODIGO=' + codigo;
    T.Open;
    result := (T.RecordCount<>0);
  end;

end.
