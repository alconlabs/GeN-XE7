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
    qOrders: TFDQuery;
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

uses udmMercadoLibre, RestDM, uOrder_items;

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
  fOrder_items := TfOrder_items.Create(Self);
  with fOrder_items do
  begin
    qOrder_items.Open('SELECT order_items.title AS TITULO, order_items.full_unit_price AS PRECIO, order_items.quantity AS CANTIDAD, order_items.seller_sku AS SKU, buyer.first_name AS NOMBRE, buyer.last_name AS APELLIDO, buyer.nickname AS NIK, "imprimir" AS ETIQUETA'
  +', shipping, buyer, order_items.order_id'
  +' FROM orders'
  +' INNER JOIN order_items ON orders.id = order_items.order_id'
  +' INNER JOIN shipping ON orders.id = shipping.order_id'
  +' INNER JOIN buyer ON orders.buyer = buyer.id'
  //+' WHERE shipping_mode='+QuotedStr('me2')
  +' WHERE buyer=:B',[qOrders.FieldByName('buyer').AsString]
  //+' GROUP BY orders.buyer'
  );
    Panel1.Caption:=qOrder_items.FieldByName('NOMBRE').AsString+' '+qOrder_items.FieldByName('APELLIDO').AsString+' ['+qOrder_items.FieldByName('NIK').AsString+'] ';
    try
      ShowModal;
    finally
      Free;
    end;
  end;
end;

end.
