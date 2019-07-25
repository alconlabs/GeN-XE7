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
    lPreparar: TLabel;
    lVentas: TLabel;
    Panel1: TPanel;
    Label3: TLabel;
    lMensajes: TLabel;
    pColecta: TPanel;
    Label5: TLabel;
    lMEnvios: TLabel;
    pFlex: TPanel;
    Label7: TLabel;
    lMEFlex: TLabel;
    pAcordar: TPanel;
    Label11: TLabel;
    lAcordar: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure StringGridBindSourceDB1Click(Sender: TObject);
    procedure tProgressBarTimer(Sender: TObject);
    procedure sgMessagesClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure pColectaClick(Sender: TObject);
    procedure lMEnviosClick(Sender: TObject);
    procedure Label5Click(Sender: TObject);
    procedure lPrepararClick(Sender: TObject);
    procedure pFlexClick(Sender: TObject);
    procedure pAcordarClick(Sender: TObject);
    procedure Label7Click(Sender: TObject);
    procedure lMEFlexClick(Sender: TObject);
    procedure Label11Click(Sender: TObject);
    procedure lAcordarClick(Sender: TObject);
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
//  bActualizar.Click;
  actualizarEtiquetas;
end;

procedure TfMercadoLibreEnvios.lPrepararClick(Sender: TObject);
begin
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

procedure TfMercadoLibreEnvios.Label11Click(Sender: TObject);
begin
  pAcordarClick(Sender);
end;

procedure TfMercadoLibreEnvios.Label5Click(Sender: TObject);
begin
  pColectaClick(Sender);
end;

procedure TfMercadoLibreEnvios.Label7Click(Sender: TObject);
begin
  pFlexClick(Sender);
end;

procedure TfMercadoLibreEnvios.lAcordarClick(Sender: TObject);
begin
  pAcordarClick(Sender);
end;

procedure TfMercadoLibreEnvios.lMEFlexClick(Sender: TObject);
begin
  pFlexClick(Sender);
end;

procedure TfMercadoLibreEnvios.lMEnviosClick(Sender: TObject);
begin
  pColectaClick(Sender);
end;

procedure TfMercadoLibreEnvios.pAcordarClick(Sender: TObject);
begin
  fOrders := TfOrders.Create(Self);
    with fOrders do
    begin
      qOrders.Open(dmml.sqlOrder_items
        +' AND shipping_mode='+QuotedStr('custom')
        +' GROUP BY orders.buyer'
      );
      try
        ShowModal;
      finally
        Free;
      end;
    end;
end;

procedure TfMercadoLibreEnvios.pColectaClick(Sender: TObject);
begin
  fOrders := TfOrders.Create(Self);
  with fOrders do
  begin
    qOrders.Open(dmml.sqlOrder_items
      +' AND shipping_mode='+QuotedStr('me2')
      +' GROUP BY orders.buyer'
    );
    try
      ShowModal;
    finally
      Free;
    end;
  end;
end;

procedure TfMercadoLibreEnvios.pFlexClick(Sender: TObject);
begin
  fOrders := TfOrders.Create(Self);
    with fOrders do
    begin
      qOrders.Open(dmml.sqlOrder_items
        +' AND shipping_mode='+QuotedStr('me1')
        +' GROUP BY orders.buyer'
      );
      try
        ShowModal;
      finally
        Free;
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

procedure TfMercadoLibreEnvios.tProgressBarTimer(Sender: TObject);
begin
  ProgressBar1.StepIt
end;

procedure TfMercadoLibreEnvios.actualizarEtiquetas;
var
  v:string;
begin
  with dmml do
  begin
    v:=' ventas';
    lVentas.Caption := IntToStr(dbMain.ExecSQLScalar(sqlCountShipping))+' ventas';
    lMEnvios.Caption := IntToStr(dbMain.ExecSQLScalar(
      sqlCountShipping +' AND shipping_mode=:M',['me2']))+v;
    lMEFlex.Caption := IntToStr(dbMain.ExecSQLScalar(
      sqlCountShipping +' AND shipping_mode=:M',['me1']))+v;
    lAcordar.Caption := IntToStr(dbMain.ExecSQLScalar(
      sqlCountShipping +' AND shipping_mode=:M',['custom']))+v;
    FDQuery1.Open(sqlCountMessages);
    lMensajes.Caption := IntToStr(FDQuery1.RowsAffected)+v;
  end;
end;

end.
