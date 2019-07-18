unit uMercadoLibreEnvios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Vcl.Bind.Grid, System.Rtti, System.Bindings.Outputs,
  Vcl.Bind.Editors, Data.Bind.EngExt, Vcl.Bind.DBEngExt, Data.Bind.Components,
  Data.Bind.Grid, Data.Bind.DBScope, Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TForm1 = class(TForm)
    bActualizar: TBitBtn;
    bImprimirEtiqueta: TButton;
    ProgressBar1: TProgressBar;
    tProgressBar: TTimer;
    Label1: TLabel;
    lVentas: TLabel;
    Panel1: TPanel;
    Label3: TLabel;
    lMensajes: TLabel;
    Panel2: TPanel;
    Label5: TLabel;
    lMEnvios: TLabel;
    Panel3: TPanel;
    Label7: TLabel;
    lMEFlex: TLabel;
    Panel4: TPanel;
    Label11: TLabel;
    lAcordar: TLabel;
    procedure bActualizarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure bImprimirEtiquetaClick(Sender: TObject);
    procedure StringGridBindSourceDB1Click(Sender: TObject);
    procedure tProgressBarTimer(Sender: TObject);
    procedure sgMessagesClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure actualizarEtiquetas;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses RestDM, udmMercadoLibre;

procedure TForm1.bImprimirEtiquetaClick(Sender: TObject);
var
  buyer_id:string;
begin
  with dmml do
  begin
    DMR.ImprimirEtiqueta(tOrders.FieldByName('shipping_id').AsString);
    buyer_id := tOrders.FieldByName('comprador').AsString;
    while buyer_id=tOrders.FieldByName('comprador').AsString do
    begin
      AgregarDespachados(tOrders.FieldByName('order_id').AsString,'SI');
      tOrders.Next;
    end;
    tOrders.Close;
    tOrders.Open;
  end;
end;

procedure TForm1.bActualizarClick(Sender: TObject);
begin
  with dmr do
    with dmML do
  begin
//    ObtenerConsultaRest('users/me?','');
ProgressBar1.Visible:=True;
tProgressBar.Enabled:=True;
    FDQuery1.Close;
    ObtenerOrderRecent;
tProgressBar.Enabled:=False;
ProgressBar1.StepBy(100);
sleep(100);
ProgressBar1.Visible:=False;
  end;
    actualizarEtiquetas;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  dmML := TdmML.Create(Self);
  DMR := TDMR.Create(Self);
end;

procedure TForm1.FormShow(Sender: TObject);
begin
//  bActualizar.Click;
  actualizarEtiquetas;
end;

procedure TForm1.sgMessagesClick(Sender: TObject);
begin
//  Memo1.Text := dmML.tMessages.FieldByName('message_text').AsString;
end;

procedure TForm1.StringGridBindSourceDB1Click(Sender: TObject);
begin
  with dmml do
  begin
    tOrder_items.Open('SELECT item_title FROM order_items WHERE order_id='+dmML.tOrders.FieldByName('order_id').AsString);
    tMessages.Open('SELECT message_text FROM messages WHERE order_id='+dmML.tOrders.FieldByName('order_id').AsString);
//    Memo1.Text:='';
  end;
end;

procedure TForm1.tProgressBarTimer(Sender: TObject);
begin
  ProgressBar1.StepIt
end;

procedure TForm1.actualizarEtiquetas;
var
  v, sql, s, g :string;
begin
  with dmml do
  begin
    sql:='SELECT COUNT(*) FROM orders';
    s:=' INNER JOIN shipping ON orders.id = shipping.order_id';
    g:=' GROUP BY order_id';
    v:=' ventas';
    lVentas.Caption := IntToStr(dbMain.ExecSQLScalar(sql))+' ventas';
    lMEnvios.Caption := IntToStr(dbMain.ExecSQLScalar(
    sql+s+' WHERE shipping_mode=:M',['"me2"']))+v;
    lMEFlex.Caption := IntToStr(dbMain.ExecSQLScalar(
    sql+s+' WHERE shipping_mode=:M',['"me1"']))+v;
    lAcordar.Caption := IntToStr(dbMain.ExecSQLScalar(
    sql+s+' WHERE shipping_mode=:M',['"custom"']))+v;
    FDQuery1.Open(sql
    +' INNER JOIN messages ON orders.id = messages.order_id'
    +g);
    lMensajes.Caption := IntToStr(FDQuery1.RowsAffected)+v;
  end;
end;

end.
