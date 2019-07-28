unit uMercadoLibreEnvios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Vcl.Bind.Grid, System.Rtti, System.Bindings.Outputs,
  Vcl.Bind.Editors, Data.Bind.EngExt, Vcl.Bind.DBEngExt, Data.Bind.Components,
  Data.Bind.Grid, Data.Bind.DBScope, Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TfMercadoLibreEnvios = class(TForm)
    ProgressBar1: TProgressBar;
    tProgressBar: TTimer;
    Timer1: TTimer;
    pPreparar: TPanel;
    pPrepararMensajes: TPanel;
    lTituloPrepararMensajes: TLabel;
    lVentasPrepararMensajes: TLabel;
    pPrepararEnvios: TPanel;
    lTituloPrepararEnvios: TLabel;
    lVentasPrepararEnvios: TLabel;
    pPrepararFlex: TPanel;
    lTituloPrepararFlex: TLabel;
    lVentasPrepararFlex: TLabel;
    pPrepararAcordar: TPanel;
    lTituloPrepararAcordar: TLabel;
    lVentasPrepararAcordar: TLabel;
    pTituloPreparar: TPanel;
    lPreparar: TLabel;
    lVentasPreparar: TLabel;
    pDespachar: TPanel;
    pDespacharDemoradas: TPanel;
    lDespacharDemoradas: TLabel;
    lVentasDespacharDemoradas: TLabel;
    pDespacharMensajes: TPanel;
    lDespacharMensajes: TLabel;
    lVentasDespacharMensajes: TLabel;
    pDespacharFlex: TPanel;
    lDespacharFlex: TLabel;
    lVentasDespacharFlex: TLabel;
    pDespacharColecta: TPanel;
    lDespacharColecta: TLabel;
    lVentasDespacharColecta: TLabel;
    pTituloDespachar: TPanel;
    lDespachar: TLabel;
    lVentasDespachar: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure StringGridBindSourceDB1Click(Sender: TObject);
    procedure tProgressBarTimer(Sender: TObject);
    procedure sgMessagesClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure pPrepararEnviosClick(Sender: TObject);
    procedure lVentasPrepararEnviosClick(Sender: TObject);
    procedure lTituloPrepararEnviosClick(Sender: TObject);
    procedure lPrepararClick(Sender: TObject);
    procedure pPrepararFlexClick(Sender: TObject);
    procedure pPrepararAcordarClick(Sender: TObject);
    procedure lTituloPrepararFlexClick(Sender: TObject);
    procedure lVentasPrepararFlexClick(Sender: TObject);
    procedure lTituloPrepararAcordarClick(Sender: TObject);
    procedure lVentasPrepararAcordarClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure pDespacharColectaClick(Sender: TObject);
    procedure lVentasDespacharColectaClick(Sender: TObject);
    procedure pDespacharFlexClick(Sender: TObject);
  private
    { Private declarations }
    procedure actualizarEtiquetas;
  public
    { Public declarations }
  end;

var
  fMercadoLibreEnvios: TfMercadoLibreEnvios;

implementation

{$R *.dfm}

uses RestDM, udmMercadoLibre, uOrders;

procedure TfMercadoLibreEnvios.FormCreate(Sender: TObject);
begin
  dmML := TdmML.Create(Self);
  DMR := TDMR.Create(Self);
end;

procedure TfMercadoLibreEnvios.FormShow(Sender: TObject);
begin
  actualizarEtiquetas;
//  Timer1.Enabled:=True;
end;

procedure TfMercadoLibreEnvios.lPrepararClick(Sender: TObject);
begin
  Timer1.Interval:=((1000*60)*10);
  with dmr do
    with dmML do
  begin
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

procedure TfMercadoLibreEnvios.lTituloPrepararAcordarClick(Sender: TObject);
begin
  pDespacharColectaClick(Sender);
end;

procedure TfMercadoLibreEnvios.lTituloPrepararEnviosClick(Sender: TObject);
begin
  pPrepararEnviosClick(Sender);
end;

procedure TfMercadoLibreEnvios.lTituloPrepararFlexClick(Sender: TObject);
begin
  pPrepararFlexClick(Sender);
end;

procedure TfMercadoLibreEnvios.lVentasPrepararAcordarClick(Sender: TObject);
begin
  pPrepararAcordarClick(Sender);
end;

procedure TfMercadoLibreEnvios.lVentasDespacharColectaClick(Sender: TObject);
begin
  pDespacharColectaClick(Sender);
end;

procedure TfMercadoLibreEnvios.lVentasPrepararFlexClick(Sender: TObject);
begin
  pPrepararFlexClick(Sender);
end;

procedure TfMercadoLibreEnvios.lVentasPrepararEnviosClick(Sender: TObject);
begin
  pPrepararEnviosClick(Sender);
end;

procedure TfMercadoLibreEnvios.pPrepararAcordarClick(Sender: TObject);
begin
  fOrders := TfOrders.Create(Self);
    with fOrders do
    with dmML do
    begin
      qOrders.Open(sqlOrder_items
        +sqlNoEmbalado
        +' AND shipping_mode='+QuotedStr('custom')
        +' GROUP BY orders.buyer');
      try
        ShowModal;
      finally
        Free;
      end;
    end;
end;

procedure TfMercadoLibreEnvios.pDespacharFlexClick(Sender: TObject);
begin
    fOrders := TfOrders.Create(Self);
    with fOrders do
    with dmML do
    begin
      qOrders.Open(sqlOrder_items
        +sqlEmbalado
        +' AND shipping_mode='+QuotedStr('me1')
        +' GROUP BY orders.buyer');
      try
        ShowModal;
      finally
        Free;
        actualizarEtiquetas;
      end;
    end;
end;

procedure TfMercadoLibreEnvios.pPrepararEnviosClick(Sender: TObject);
begin
  fOrders := TfOrders.Create(Self);
  with fOrders do
  with dmML do
  begin
    qOrders.Open(sqlOrder_items
      +sqlNoEmbalado
      +' AND shipping_mode='+QuotedStr('me2')
      +' GROUP BY orders.buyer');
    try
      ShowModal;
    finally
      Free;
      actualizarEtiquetas;
    end;
  end;
end;

procedure TfMercadoLibreEnvios.pDespacharColectaClick(Sender: TObject);
begin
  fOrders := TfOrders.Create(Self);
  with dmML do
    with fOrders do
    begin
      qOrders.Open(sqlOrder_items+sqlEmbalado
        +' AND shipping_mode='+QuotedStr('me2')
        +' GROUP BY orders.buyer');
      try
        ShowModal;
      finally
        Free;
        actualizarEtiquetas;
      end;
    end;
end;

procedure TfMercadoLibreEnvios.pPrepararFlexClick(Sender: TObject);
begin
  fOrders := TfOrders.Create(Self);
    with fOrders do
    with dmML do
    begin
      qOrders.Open(sqlOrder_items
        +sqlNoEmbalado
        +' AND shipping_mode='+QuotedStr('me1')
        +' GROUP BY orders.buyer');
      try
        ShowModal;
      finally
        Free;
        actualizarEtiquetas;
      end;
    end;
end;

procedure TfMercadoLibreEnvios.sgMessagesClick(Sender: TObject);
begin
//  Memo1.Text := dmML.tMessages.FieldByName('message_text').AsString;
end;

procedure TfMercadoLibreEnvios.StringGridBindSourceDB1Click(Sender: TObject);
begin
  with dmml do
  begin
    tOrder_items.Open('SELECT item_title FROM order_items WHERE order_id='+dmML.tOrders.FieldByName('order_id').AsString);
  end;
end;

procedure TfMercadoLibreEnvios.Timer1Timer(Sender: TObject);
begin
  lPrepararClick(Sender);
end;

procedure TfMercadoLibreEnvios.tProgressBarTimer(Sender: TObject);
begin
  ProgressBar1.StepIt
end;

procedure TfMercadoLibreEnvios.actualizarEtiquetas;
var
  v:string;
begin
  with dmML do
  begin
    v:=' ventas';
    lVentasPreparar.Caption := IntToStr(dbMain.ExecSQLScalar(sqlCountShipping))+v;
    lVentasPrepararEnvios.Caption := IntToStr(dbMain.ExecSQLScalar(
      sqlCountShipping+sqlNoEmbalado+' AND shipping_mode=:M',['me2']))+v;
    lVentasPrepararFlex.Caption := IntToStr(dbMain.ExecSQLScalar(
      sqlCountShipping+sqlNoEmbalado+' AND shipping_mode=:M',['me1']))+v;
    lVentasPrepararAcordar.Caption := IntToStr(dbMain.ExecSQLScalar(
      sqlCountShipping+sqlNoEmbalado+' AND shipping_mode=:M',['custom']))+v;
    FDQuery1.Open(sqlCountMessages);
    lVentasPrepararMensajes.Caption := IntToStr(FDQuery1.RowsAffected)+v;
    lDespacharColecta.Caption := IntToStr(dbMain.ExecSQLScalar(
      sqlCountShipping+sqlEmbalado+' AND shipping_mode=:M',['me2']))+v;
  end;
end;

end.
