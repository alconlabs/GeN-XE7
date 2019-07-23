unit uOrders;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Bind.Grid, System.Rtti,
  System.Bindings.Outputs, Vcl.Bind.Editors, Data.Bind.EngExt,
  Vcl.Bind.DBEngExt, Data.Bind.Components, Data.Bind.Grid, Vcl.Grids,
  Data.Bind.DBScope;

type
  TfOrders = class(TForm)
    FDQuery1: TFDQuery;
    BindSourceDB1: TBindSourceDB;
    StringGridBindSourceDB1: TStringGrid;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    BindingsList1: TBindingsList;
    procedure StringGridBindSourceDB1Click(Sender: TObject);
  private
    { Private declarations }
    procedure ImprimirEtiqueta;
  public
    { Public declarations }
  end;

var
  fOrders: TfOrders;

implementation

{$R *.dfm}

uses udmMercadoLibre, RestDM;

procedure TfOrders.ImprimirEtiqueta;
var
  buyer_id:string;
begin
  with dmml do
  begin
    DMR.ImprimirEtiqueta(FDQuery1.FieldByName('shipping').AsString);
    buyer_id := FDQuery1.FieldByName('buyer').AsString;
    while buyer_id=FDQuery1.FieldByName('buyer').AsString do
    begin
      AgregarDespachados(FDQuery1.FieldByName('order_id').AsString,'SI');
      FDQuery1.Next;
    end;
    tOrders.Close;
    tOrders.Open;
  end;
end;

procedure TfOrders.StringGridBindSourceDB1Click(Sender: TObject);
begin
  ShowMessage(
  'Ordenes relacionadas con el cliente:'+
  IntToStr(dmml.dbMain.ExecSQLScalar(
  'SELECT COUNT(*) FROM orders'
  +' INNER JOIN shipping ON orders.id = shipping.order_id'
  +' WHERE buyer=:B',[FDQuery1.FieldByName('buyer').AsString]))
  );
end;

end.
