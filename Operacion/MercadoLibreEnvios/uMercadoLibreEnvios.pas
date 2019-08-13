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
    lTituloDespacharDemoradas: TLabel;
    lVentasDespacharDemoradas: TLabel;
    pDespacharMensajes: TPanel;
    lTituloDespacharMensajes: TLabel;
    lVentasDespacharMensajes: TLabel;
    pDespacharFlex: TPanel;
    lTituloDespacharFlex: TLabel;
    lVentasDespacharFlex: TLabel;
    pDespacharColecta: TPanel;
    lTituloDespacharColecta: TLabel;
    lVentasDespacharColecta: TLabel;
    pTituloDespachar: TPanel;
    lDespachar: TLabel;
    lVentasDespachar: TLabel;
    Panel1: TPanel;
    pTransitoCamino: TPanel;
    lTituloTransitoCamino: TLabel;
    lVentasTransitoCamino: TLabel;
    pTransitoMensajes: TPanel;
    lTituloTransitoMensajes: TLabel;
    lVentasTransitoMensajes: TLabel;
    pTransitoEsperandoRetiro: TPanel;
    lTituloTransitoEsperandoRetiro: TLabel;
    lVentasTransitoEsperandoRetiro: TLabel;
    Panel6: TPanel;
    lTransito: TLabel;
    lVentasTransito: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure tProgressBarTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure pPrepararEnviosClick(Sender: TObject);
    procedure pPrepararFlexClick(Sender: TObject);
    procedure pPrepararAcordarClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure pDespacharColectaClick(Sender: TObject);
    procedure pDespacharFlexClick(Sender: TObject);
    procedure pPrepararMensajesClick(Sender: TObject);
    procedure pDespacharMensajesClick(Sender: TObject);
    procedure pTransitoMensajesClick(Sender: TObject);
    procedure pDespacharDemoradasClick(Sender: TObject);
    procedure pTransitoEsperandoRetiroClick(Sender: TObject);
    procedure pTransitoCaminoClick(Sender: TObject);
    procedure Preparar;
  private
    { Private declarations }
    procedure actualizarEtiquetas;
    procedure AbrirfOrders(sql,sql1:string);
    procedure AbrirfOrder_items(sql:string);
  public
    { Public declarations }
  end;

var
  fMercadoLibreEnvios: TfMercadoLibreEnvios;

implementation

{$R *.dfm}

uses RestDM, udmMercadoLibre, uOrders, uOrder_items;

procedure TfMercadoLibreEnvios.FormCreate(Sender: TObject);
begin
  dmML := TdmML.Create(Self);
  DMR := TDMR.Create(Self);
end;

procedure TfMercadoLibreEnvios.FormShow(Sender: TObject);
begin
//  actualizarEtiquetas;
  Timer1.Enabled:=True;
end;

procedure TfMercadoLibreEnvios.pPrepararAcordarClick(Sender: TObject);
begin
  AbrirfOrders(sqlPrepararAcordar,'');
end;

procedure TfMercadoLibreEnvios.pDespacharFlexClick(Sender: TObject);
begin
  AbrirfOrders(sqlDespacharFlex,'');
end;

procedure TfMercadoLibreEnvios.pDespacharMensajesClick(Sender: TObject);
begin
  AbrirfOrder_items(sqlDespacharMensajes);
end;

procedure TfMercadoLibreEnvios.pPrepararEnviosClick(Sender: TObject);
begin
  AbrirfOrders(sqlPrepararEnvios,sqlPrepararEnviosItems);
end;

procedure TfMercadoLibreEnvios.pDespacharColectaClick(Sender: TObject);
begin
    AbrirfOrders(sqlDespacharEnvios,'');
end;

procedure TfMercadoLibreEnvios.pDespacharDemoradasClick(Sender: TObject);
begin
  AbrirfOrders(sqlDespacharDemoradas,'');
end;

procedure TfMercadoLibreEnvios.pPrepararFlexClick(Sender: TObject);
begin
  AbrirfOrders(sqlPrepararFlex,'');
end;

procedure TfMercadoLibreEnvios.pPrepararMensajesClick(Sender: TObject);
begin
  AbrirfOrder_items(sqlPrepararMensajes);
end;

procedure TfMercadoLibreEnvios.pTransitoCaminoClick(Sender: TObject);
begin
  AbrirfOrders(sqlTransitoCamino,'');
end;

procedure TfMercadoLibreEnvios.pTransitoEsperandoRetiroClick(Sender: TObject);
begin
    AbrirfOrders(sqlTransitoEsperandoRetiro,'');
end;

procedure TfMercadoLibreEnvios.pTransitoMensajesClick(Sender: TObject);
begin
  AbrirfOrder_items(sqlTransitoMensajes);
end;

procedure TfMercadoLibreEnvios.Timer1Timer(Sender: TObject);
begin
  Preparar;
end;

procedure TfMercadoLibreEnvios.tProgressBarTimer(Sender: TObject);
begin
  ProgressBar1.StepIt;
end;

procedure TfMercadoLibreEnvios.actualizarEtiquetas;
begin
  with dmML do
  begin
    lVentasPreparar.Caption := CantidadVentas(sqlPreparar);
    lVentasPrepararEnvios.Caption:=CantidadVentas(sqlPrepararEnvios);
    lVentasPrepararFlex.Caption := CantidadVentas(sqlPrepararFlex);
    lVentasPrepararAcordar.Caption := CantidadVentas(sqlPrepararAcordar);
    lVentasPrepararMensajes.Caption := CantidadVentas(sqlPrepararMensajes);
    lVentasDespachar.Caption := CantidadVentas(sqlDespachar);
    lVentasDespacharDemoradas.Caption := CantidadVentas(sqlDespacharDemoradas);
    lVentasDespacharColecta.Caption := CantidadVentas(sqlDespacharEnvios);
    lVentasDespacharFlex.Caption := CantidadVentas(sqlDespacharFlex);
    lVentasDespacharMensajes.Caption := CantidadVentas(sqlDespacharMensajes);
    lVentasTransito.Caption := CantidadVentas(sqlTransito);
    lVentasTransitoCamino.Caption := CantidadVentas(sqlTransitoCamino);
    lVentasTransitoEsperandoRetiro.Caption := CantidadVentas(sqlTransitoEsperandoRetiro);
    lVentasTransitoMensajes.Caption := CantidadVentas(sqlTransitoMensajes);
  end;
end;

procedure TfMercadoLibreEnvios.AbrirfOrders;
begin
  fOrders := TfOrders.Create(Self);
  with dmML do
    with fOrders do
    begin
      vsqlOrder_items:=sql1;
      if vsqlOrder_items='' then vsqlOrder_items:=sql;
      qOrders.Open(sql + groupBuyer);
      try
        ShowModal;
      finally
        Free;
        actualizarEtiquetas;
      end;
    end;
end;

procedure TfMercadoLibreEnvios.AbrirfOrder_items;
begin
  fOrder_items := TfOrder_items.Create(Self);
  with dmML do
    with fOrder_items do
    begin
      bImprimir.Visible:=False;
      qOrder_items.Open(sql);
      tMessages.Open(sql + groupText_plain);
      try
        ShowModal;
      finally
        Free;
      end;
    end;
end;

procedure TfMercadoLibreEnvios.Preparar;
begin
  Timer1.Interval:=((1000*60)*10);
  with dmr do
//    with dmML do
//      begin
//        ProgressBar1.Visible:=True;
//        tProgressBar.Enabled:=True;
//        FDQuery1.Close;
//        ObtenerOrderRecent;
ObtenerMessages('2110960953','30341176');
//        tProgressBar.Enabled:=False;
//        ProgressBar1.StepBy(100);
//        sleep(100);
//        ProgressBar1.Visible:=False;
//      end;
//  actualizarEtiquetas;
end;

end.
