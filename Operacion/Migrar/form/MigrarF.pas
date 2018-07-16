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
  ,DataModule;

type
  TMigrarForm = class(TForm)
    ProcesarButton: TButton;
    ProgressBar1: TProgressBar;
    EditUrl: TEdit;
    EditResource: TEdit;
    EditUser: TEdit;
    EditPassword: TEdit;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter;
    O: TFDMemTable;
    RESTClientCategories: TRESTClient;
    RESTRequestCategories: TRESTRequest;
    RESTResponseCategories: TRESTResponse;
    FDMemTableCategories: TFDMemTable;
    RESTResponseDataSetAdapterCategories: TRESTResponseDataSetAdapter;
    Q: TIBQuery;
    T: TIBQuery;
    D: TIBQuery;
    procedure ProcesarButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
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

procedure TMigrarForm.FormCreate(Sender: TObject);
begin
with FormatSettings do
  begin
    DecimalSeparator := '.';
    ThousandSeparator := '.';
    ShortDateFormat := 'mm/dd/yyyy';
  end;
end;

procedure TMigrarForm.ProcesarButtonClick(Sender: TObject);
var
  i,p : integer;
  mar, col, cat, subcat, rub, s, disponible, costo, fecha : string;
  categories: TJSONArray;
  precio, iva, ganancia: Double;
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
  ProgressBar1.Position := 1;
  importCategories;
  ShowMessage('IMPORTACION DE CATEGORIAS FINALIZADA');
  p:=0;
  ProgressBar1.Position := 2;
  repeat
    Inc(p);
    GetREST(EditUrl.text, EditResource.text+'status=publish&per_page=100&page='+IntToStr(p)+'&', EditUser.text, EditPassword.text);
    if (O<>nil) then
    begin
      ProgressBar1.Max := O.RecordCount;
      if  (O.RecordCount>0) then
        for i := 0 to O.RecordCount - 1 do
        begin
          categories := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(O.FieldByName('categories').AsString),0) as TJSONArray;
          rub := existeEnTJSONArray('Rubro',categories);
          cat := existeEnTJSONArray('Categoria',categories);
          subcat := existeEnTJSONArray('SubCategoria',categories);
          disponible:=O.FieldByName('stock_quantity').AsString;
          if O.FieldByName('regular_price').AsString='' then precio:=0 else precio:=O.FieldByName('regular_price').AsFloat;
          if (O.FieldByName('tax_class').AsString = 'tasa-reducida') then
            iva := 10.5
            else
              iva := 21;
          ganancia := precio/(iva/100+1);
          costo := FloatToStrF( ( ganancia/(35/100+1) ), ffFixed, 16, 2 );
          fecha := ConvertToDateTimeStr(O.FieldByName('date_modified').AsString);
          if disponible='' then disponible:='0';
          if not existeEnTabla('Articulo',O.FieldByName('id').AsString) then
          begin
            D.SQL.Text := 'INSERT INTO "Articulo" ( CODIGO, DESCRIPCION '
            + ', ULTCOSTO, COSTO, PRECIO, PRECIO1, PRECIO2, DISPONIBLE'
            + ', PORCENTAJE, IMPOTROS, UNIDAD, TASA, IIBB, CTANOMBRE, CTATIPO, CTAANTICIPO, CTAIIBB '
            + ', FECHA, FECHACOMPULT, CODIGOBARRA'
            + ', CATEGORIA, COLOR, MARCA, PROVEEDOR, RUBRO, SUBCATEGORIA'
            + ' ) VALUES ( '
            + IntToStr(O.FieldByName('id').AsInteger) + ', ' + QuotedStr(O.FieldByName('name').AsString)
            + ', ' + costo + ', ' + costo + ', ' + FloatToStr(precio) + ', ' + O.FieldByName('regular_price').AsString+'0' + ', ' + O.FieldByName('sale_price').AsString+'0' + ', ' + disponible
            + ', 30, 5, ''c/u'', '+FloatToStr(iva)+', 1, 13, 13, 13, 66'
            + ', ' + QuotedStr(fecha) + ', ' + QuotedStr(fecha) + ', ' + QuotedStr(O.FieldByName('sku').AsString)
            + ', '+cat+', 0, 0, 1, '+rub+', '+subcat+' )';
//            D.ExecSQL;
          end
            else
              D.SQL.Text := 'UPDATE "Articulo" SET'
              +' DESCRIPCION = ' + QuotedStr(O.FieldByName('name').AsString)
  //            +', ULTCOSTO = ' + costo
//              +', COSTO = ' + costo
              +', PRECIO = ' + FloatToStr(precio)
              +', PRECIO1 = ' + O.FieldByName('regular_price').AsString+'0'
              +', PRECIO2 = ' + O.FieldByName('sale_price').AsString+'0'
              +', DISPONIBLE = ' + disponible
//              +', PORCENTAJE = 30' +
//              +', IMPOTROS = 5' +
//              +', UNIDAD = ''c/u''' +
//              +', TASA = ' + FloatToStr(iva)
//              +', IIBB = 1' +
//              +', CTANOMBRE = 13' +
//              +', CTATIPO = 13' +
//              +', CTAANTICIPO = 13' +
//              +', CTAIIBB = 66' +
//              +', FECHA = ' + QuotedStr(fecha)
//              +', FECHACOMPULT = ' + QuotedStr(fecha)
              +', CODIGOBARRA = ' + QuotedStr(O.FieldByName('sku').AsString)
              +', CATEGORIA = ' + cat
//              +', COLOR = 0' +
//              +', MARCA = 0' +
//              +', PROVEEDOR = 1' +
              +', RUBRO = ' + rub
              +', SUBCATEGORIA = ' + subcat
              +' WHERE CODIGO ='+ IntToStr(O.FieldByName('id').AsInteger);
          D.ExecSQL;
          ProgressBar1.Position := i;
          O.Next;
        end;
    end;
  until (O.RecordCount<2); //  until ((O.RecordCount=0) or (O.RecordCount=1));
  D.Transaction.CommitRetaining;
  ShowMessage('IMPORTACION DE PRODUCTOS FINALIZADA');
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
    ProgressBar1.Position := i;
  end;
  p:=0;
  repeat
    Inc(p);
    FDMemTableCategories.Close;
    GetRESTCategories(EditUrl.text, 'products/categories/?per_page=100&page='+IntToStr(p)+'&', EditUser.text, EditPassword.text);
    ProgressBar1.Max := FDMemTableCategories.RecordCount;
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
    ProgressBar1.Position := i;
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
  if streams<>nil then
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
