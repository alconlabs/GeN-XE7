unit ConfiguracionF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Mask, DBCtrls, DB, ADODB, ComCtrls, DataModule,
  ExtCtrls, OleCtrls, SHDocVw, IBX.IBTable, IBX.IBCustomDataSet, IBX.IBQuery;

type
  TConfiguracionForm = class(TForm)
    DataSource: TDataSource;
    CuentaDataSource: TDataSource;
    ImprimirDataSource: TDataSource;
    ImprimirQuery: TIBQuery;
    CuentaQuery: TIBQuery;
    Tabla: TIBTable;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    Label38: TLabel;
    BitBtn2: TBitBtn;
    PageControl1: TPageControl;
    TabSheet3: TTabSheet;
    Label43: TLabel;
    Label44: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Label45: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label34: TLabel;
    CuentaDBLookupComboBox: TDBLookupComboBox;
    DBLookupComboBox1: TDBLookupComboBox;
    DBLookupComboBox3: TDBLookupComboBox;
    DBLookupComboBox4: TDBLookupComboBox;
    DBLookupComboBox2: TDBLookupComboBox;
    DBLookupComboBox5: TDBLookupComboBox;
    DBLookupComboBox6: TDBLookupComboBox;
    DBLookupComboBox7: TDBLookupComboBox;
    DBLookupComboBox8: TDBLookupComboBox;
    DBLookupComboBox9: TDBLookupComboBox;
    DBLookupComboBox10: TDBLookupComboBox;
    DBLookupComboBox11: TDBLookupComboBox;
    DBLookupComboBox12: TDBLookupComboBox;
    DBLookupComboBox13: TDBLookupComboBox;
    DBLookupComboBox14: TDBLookupComboBox;
    DBLookupComboBox15: TDBLookupComboBox;
    DBLookupComboBox16: TDBLookupComboBox;
    DBLookupComboBox17: TDBLookupComboBox;
    DBLookupComboBox18: TDBLookupComboBox;
    DBLookupComboBox19: TDBLookupComboBox;
    DBLookupComboBox21: TDBLookupComboBox;
    DBLookupComboBox22: TDBLookupComboBox;
    DBLookupComboBox23: TDBLookupComboBox;
    DBLookupComboBox25: TDBLookupComboBox;
    DBLookupComboBox26: TDBLookupComboBox;
    DBLookupComboBox27: TDBLookupComboBox;
    DBLookupComboBox24: TDBLookupComboBox;
    DBLookupComboBox20: TDBLookupComboBox;
    TabSheet1: TTabSheet;
    Label1: TLabel;
    Label17: TLabel;
    Label49: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    DBEdit1: TDBEdit;
    ReporteDBLookupComboBox: TDBLookupComboBox;
    DBComboBox1: TDBComboBox;
    DBComboBox2: TDBComboBox;
    DBComboBox3: TDBComboBox;
    TabSheet2: TTabSheet;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    DBEdit8: TDBEdit;
    ConfigurarFEButton: TButton;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure CuentasBitBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TablaAfterCancel(DataSet: TDataSet);
    procedure TablaAfterDelete(DataSet: TDataSet);
    procedure TablaAfterPost(DataSet: TDataSet);
    procedure ConfigurarFEButtonClick(Sender: TObject);
    procedure ReporteDBLookupComboBoxClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    path: string;
    procedure EsElectronica;
  public
    { Public declarations }
  end;

var
  ConfiguracionForm: TConfiguracionForm;

implementation

{$R *.dfm}

uses AfipUnit;

procedure TConfiguracionForm.BitBtn1Click(Sender: TObject);
begin
  if (reporte = 'FElectronica') or (reporte = 'TElectronica') then
    if not dm.existeOpenSSL() then
      tabla.FieldByName('ImprimirTipo').AsInteger:=1;
  Tabla.Post;
  DM.TraerConfig;
  Close;
end;

procedure TConfiguracionForm.BitBtn2Click(Sender: TObject);
begin
  Tabla.Cancel;
  Close;
end;

procedure TConfiguracionForm.ConfigurarFEButtonClick(Sender: TObject);
begin
  AfipForm := TAfipForm.Create(self);
  try
    AfipForm.ShowModal;
  finally
    AfipForm.Free;
  end;
end;

procedure TConfiguracionForm.CuentasBitBtnClick(Sender: TObject);
begin
  WinExec(PAnsiChar(AnsiString(path + 'CuentaContableGeN.exe')), SW_SHOWNORMAL);
end;

procedure TConfiguracionForm.ReporteDBLookupComboBoxClick(Sender: TObject);
begin
  reporte := ImprimirQuery.FieldByName('REPORTE').AsString;
//  if (reporte = 'FElectronica') or (reporte = 'TElectronica') then ConfigurarFEButton.Visible := True
//  else ConfigurarFEButton.Visible := False;
  EsElectronica;
end;

procedure TConfiguracionForm.TablaAfterCancel(DataSet: TDataSet);
begin
  Tabla.Transaction.RollbackRetaining;
end;

procedure TConfiguracionForm.TablaAfterDelete(DataSet: TDataSet);
begin
  Tabla.Transaction.CommitRetaining;
end;

procedure TConfiguracionForm.TablaAfterPost(DataSet: TDataSet);
begin
  Tabla.Transaction.CommitRetaining;
end;

procedure TConfiguracionForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Tabla.Close;
end;

procedure TConfiguracionForm.FormCreate(Sender: TObject);
begin
  // DM := TDM.Create(Self);
  CuentaQuery.Open;
  CuentaQuery.Last;
//  ImprimirQuery.SQL.Text :=
//    'Select * from "Imprimir" where "Imprimir".REPORTE = ''FElectronica''';
//  ImprimirQuery.Open;
//  if ImprimirQuery.RecordCount = 0 then
//  begin
//    ImprimirQuery.SQL.Text :=
//      'INSERT INTO "Imprimir" (CODIGO, DESCRIPCION, REPORTE) VALUES (11, ''Factura Electronica'', ''FElectronica'')';
//    ImprimirQuery.ExecSQL;
//    ImprimirQuery.Transaction.Commit;
//  end;
  ImprimirQuery.SQL.Text := 'Select * from "Imprimir"';
  ImprimirQuery.Open;
  ImprimirQuery.Last;
  Tabla.Open;
  Tabla.Edit;
end;

procedure TConfiguracionForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then { if it's an enter key }
  begin
    Key := #0; { eat enter key }
    Perform(WM_NEXTDLGCTL, 0, 0); { move to next control }
  end;
end;

procedure TConfiguracionForm.FormShow(Sender: TObject);
begin
  EsElectronica;
end;

procedure TConfiguracionForm.EsElectronica;
begin
  if (reporte = 'FElectronica') or (reporte = 'TElectronica') then ConfigurarFEButton.Visible := True
    else ConfigurarFEButton.Visible := False;
end;

end.
