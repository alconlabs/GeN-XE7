unit ZonaEnvioFormUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.DBCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, Vcl.Mask, Vcl.Buttons, Vcl.ExtCtrls, DataModule,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TZonaEnvioForm = class(TForm)
    DerechoPanel: TPanel;
    ZonaCodigoLabel: TLabel;
    GrabarBitBtn: TBitBtn;
    NoBitBtn: TBitBtn;
    ZonaCodigoDBEdit: TDBEdit;
    PageControl1: TPageControl;
    ZonaTabSheet: TTabSheet;
    ZonaDescripcionLabel: TLabel;
    ZonaDBGrid: TDBGrid;
    ZonaDBNavigator: TDBNavigator;
    ZonaDescripcionDBEdit: TDBEdit;
    TabSheet2: TTabSheet;
    OrdenLabel: TLabel;
    ZonaOrdenDBComboBox: TDBComboBox;
    TabSheet3: TTabSheet;
    RegionDBGrid: TDBGrid;
    MetodoDBNavigator: TDBNavigator;
    DBNavigator3: TDBNavigator;
    MetodoDBGrid: TDBGrid;
    MetodoCostoLabel: TLabel;
    MetodoDescripcionDBEdit: TDBEdit;
    MetodoImpuestoLabel: TLabel;
    MetodoOrdenDBComboBox: TDBComboBox;
    MetodoDescripcionLabel: TLabel;
    MetodoCostoDBEdit: TDBEdit;
    MetodoOrdenLabel: TLabel;
    MetodoImpuestoDBComboBox: TDBComboBox;
    RegionTipoDBComboBox: TDBComboBox;
    RegionTipoLabel: TLabel;
    RegionDescripcionLabel: TLabel;
    RegionDescripcionDBEdit: TDBEdit;
    ZonaEnvioDataSource: TDataSource;
    ZonaEnvioFDTable: TFDTable;
    ZERegionDataSource: TDataSource;
    ZERegionFDTable: TFDTable;
    ZEMetodoDataSource: TDataSource;
    ZEMetodoFDTable: TFDTable;
    RegionCodigoDBEdit: TDBEdit;
    MetodoCodigoDBEdit: TDBEdit;
    RegionZonaEnvioDBEdit: TDBEdit;
    MetodoZonaEnvioDBEdit: TDBEdit;
    procedure FormShow(Sender: TObject);
    procedure ZonaDBNavigatorClick(Sender: TObject; Button: TNavigateBtn);
  private
    procedure Cargar;
    procedure Nuevo;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ZonaEnvioForm: TZonaEnvioForm;

implementation

{$R *.dfm}

procedure TZonaEnvioForm.Cargar;
begin
  with ZonaEnvioFDTable do
    if not Active then Active:= True;
  with ZERegionFDTable do
    if not Active then Active:= True;
  with ZEMetodoFDTable do
    if not Active then Active:= True;
  PageControl1.TabIndex:=0;
end;

procedure TZonaEnvioForm.FormShow(Sender: TObject);
begin
  Cargar;
end;

Procedure TZonaEnvioForm.Nuevo;
begin
  ZonaCodigoDBEdit.Text := IntToStr(DM.SiguienteCodigo('ZonaEnvio'));
  ZERegionFDTable.Insert;
  RegionZonaEnvioDBEdit.Text := ZonaCodigoDBEdit.Text;
  ZERegionFDTable.FieldByName('CODIGO').Text := IntToStr(DM.SiguienteCodigo('ZERegion'));
  ZEMetodoFDTable.Insert;
  //MetodoRegionDBEdit.Text := ZERegionFDTable.FieldByName('CODIGO').Text;
  MetodoCodigoDBEdit.Text := IntToStr(DM.SiguienteCodigo('ZERegion'));
end;

procedure TZonaEnvioForm.ZonaDBNavigatorClick(Sender: TObject;
  Button: TNavigateBtn);
begin
  case Button of
//    nbFirst : Obtener;
//    nbPrior : Obtener;
//    nbNext : Obtener;
//    nbLast : Obtener;
    nbInsert : Nuevo;
//    nbDelete : nuevo;
//    nbEdit : Edit;
//    nbPost : Grabar;
//    nbCancel : Cancel;
//    nbRefresh: Obtener;
  end;
//  DescripcionDBEdit.SetFocus;
end;

end.
