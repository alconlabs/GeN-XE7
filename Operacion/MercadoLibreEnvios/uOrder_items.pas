unit uOrder_items;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.Bind.EngExt,
  Vcl.Bind.DBEngExt, Vcl.Bind.Grid, System.Rtti, System.Bindings.Outputs,
  Vcl.Bind.Editors, Data.Bind.Components, Data.Bind.Grid, Data.Bind.DBScope,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.ExtCtrls,
  Vcl.StdCtrls;

type
  TfOrder_items = class(TForm)
    StringGridBindSourceDB1: TStringGrid;
    qOrder_items: TFDQuery;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    Panel1: TPanel;
    Memo1: TMemo;
    bImprimir: TButton;
    sgMessage: TStringGrid;
    BindSourceDB2: TBindSourceDB;
    LinkGridToDataSourceBindSourceDB2: TLinkGridToDataSource;
    LinkPropertyToFieldtext_plain: TLinkPropertyToField;
    procedure StringGridBindSourceDB1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure bImprimirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fOrder_items: TfOrder_items;

implementation

{$R *.dfm}

uses udmMercadoLibre, RestDM;

procedure TfOrder_items.bImprimirClick(Sender: TObject);
begin
  DMR.ImprimirEtiqueta(qOrder_items.FieldByName('shipping').AsString);
  dmML.AgregarDespachados(qOrder_items.FieldByName('order_id').AsString,'S');
  Close;
end;

procedure TfOrder_items.FormShow(Sender: TObject);
begin
  dmML.tMessages.Open('SELECT * FROM messages INNER JOIN orders ON messages.order_id = orders.id WHERE buyer='+qOrder_items.FieldByName('buyer').AsString);
end;

procedure TfOrder_items.StringGridBindSourceDB1Click(Sender: TObject);
begin
  dmML.tMessages.Open('SELECT * FROM messages WHERE order_id='+qOrder_items.FieldByName('order_id').AsString);
end;

end.
