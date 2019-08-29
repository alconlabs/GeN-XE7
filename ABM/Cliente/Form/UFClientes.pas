unit UFClientes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DataModule, ExtCtrls, StdCtrls, Mask, DBCtrls, ComCtrls, DB, ADODB,
  Buttons, ImprimirDM, OleCtrls, SHDocVw, IBX.IBCustomDataSet, IBX.IBTable, OperacionDM;

type
  TFClientes = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    DBMemo1: TDBMemo;
    Label2: TLabel;
    Label3: TLabel;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    VendedorLabel: TLabel;
    TabSheet3: TTabSheet;
    Label15: TLabel;
    Label24: TLabel;
    DBEdit20: TDBEdit;
    TabSheet4: TTabSheet;
    Label19: TLabel;
    DBEdit16: TDBEdit;
    DBEdit23: TDBEdit;
    Label28: TLabel;
    DBEdit21: TDBEdit;
    Label26: TLabel;
    Label5: TLabel;
    DBEdit5: TDBEdit;
    Label22: TLabel;
    Label10: TLabel;
    DBEdit11: TDBEdit;
    DBEdit18: TDBEdit;
    TabSheet5: TTabSheet;
    Label13: TLabel;
    Label14: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    DBEdit14: TDBEdit;
    DBEdit15: TDBEdit;
    DBComboBox1: TDBComboBox;
    DBEdit1: TDBEdit;
    DBCheckBox1: TDBCheckBox;
    DBEdit25: TDBEdit;
    DBEdit26: TDBEdit;
    VendedorDBEdit: TDBEdit;
    VendedorBitBtn: TBitBtn;
    Label25: TLabel;
    DBEdit22: TDBEdit;
    Label38: TLabel;
    IVADBComboBox: TDBComboBox;
    CuentaDBLookupComboBox: TDBLookupComboBox;
    Label54: TLabel;
    DBLookupComboBox3: TDBLookupComboBox;
    DBLookupComboBox1: TDBLookupComboBox;
    Label52: TLabel;
    Label51: TLabel;
    Label9: TLabel;
    DBEdit10: TDBEdit;
    Label6: TLabel;
    DBEdit6: TDBEdit;
    Panel1: TPanel;
    Label34: TLabel;
    SiBitBtn: TBitBtn;
    NoBitBtn: TBitBtn;
    DBNavigator1: TDBNavigator;
    ImprimirBitBtn: TBitBtn;
    BuscarBitBtn: TBitBtn;
    DBEdit13: TDBEdit;
    Label12: TLabel;
    Label20: TLabel;
    DBEdit4: TDBEdit;
    Label11: TLabel;
    DBEdit12: TDBEdit;
    Label4: TLabel;
    DBEdit9: TDBEdit;
    Label7: TLabel;
    DBEdit7: TDBEdit;
    Label27: TLabel;
    DBEdit24: TDBEdit;
    Label32: TLabel;
    DBEdit27: TDBEdit;
    Label33: TLabel;
    GaranteDBEdit: TDBEdit;
    BuscarGaranteBitBtn: TBitBtn;
    GaranteLabel: TLabel;
    DBEdit8: TDBEdit;
    Label8: TLabel;
    Label23: TLabel;
    DBEdit19: TDBEdit;
    Label21: TLabel;
    DBEdit17: TDBEdit;
    Label1: TLabel;
    CodigoDBEdit: TDBEdit;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure tClienteAfterInsert(DataSet: TDataSet);
    procedure VendedorBitBtnClick(Sender: TObject);
    procedure IVADBComboBoxChange(Sender: TObject);
    procedure BuscarGaranteBitBtnClick(Sender: TObject);
    procedure BuscarBitBtnClick(Sender: TObject);
    procedure SiBitBtnClick(Sender: TObject);
    procedure NoBitBtnClick(Sender: TObject);
    procedure ImprimirBitBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tClienteAfterCancel(DataSet: TDataSet);
    procedure tClienteAfterDelete(DataSet: TDataSet);
    procedure tClienteAfterPost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    desc: string;
    { Public declarations }
  end;

var
  FClientes: TFClientes;

implementation

uses UFBuscaCliente, BuscarVendedor;

{$R *.dfm}

procedure TFClientes.SiBitBtnClick(Sender: TObject);
begin
  desc := CodigoDBEdit.text;
  If (dm.tCliente.State = dsEdit) or (dm.tCliente.State = dsInsert) then
    dm.tCliente.Post;
  Close;
end;

procedure TFClientes.BuscarBitBtnClick(Sender: TObject);
begin
  TabSheet1.PageControl.ActivePageIndex := 0;
  dm.tCliente.Cancel;
  FBuscaCliente := TFBuscaCliente.Create(self);
  try
    FBuscaCliente.ShowModal;
  finally
    dm.tCliente.Locate('CODIGO', (dm.qCliente.FieldByName('CODIGO')
      .AsString), []);
    FBuscaCliente.Free;
  end;
  dm.tCliente.Edit;
  DBEdit2.SetFocus;
end;

procedure TFClientes.FormCreate(Sender: TObject);
var i : Integer;
begin
  // DM := TDM.Create(self);
  dm.tUsuario.Open;
  dm.tCuenta.Open;
  dm.tCliente.Open;
  dm.tCliente.Insert;
  dm.tCliente.FieldByName('CODIGO').AsInteger := dm.UltimoRegistro('Cliente', 'CODIGO');
  for i := 1 to 3 do IVADBComboBox.Items.Add(OperacionDM.tipoIVA[i]);
end;

procedure TFClientes.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then { if it's an enter key }
  begin
    Key := #0; { eat enter key }
    Perform(WM_NEXTDLGCTL, 0, 0); { move to next control }
  end;
end;

procedure TFClientes.FormShow(Sender: TObject);
begin
  TabSheet1.PageControl.ActivePageIndex := 0;
  DBEdit2.SetFocus;
end;

procedure TFClientes.ImprimirBitBtnClick(Sender: TObject);
begin
  ImprimirDataModule := TImprimirDataModule.Create(self);
  ImprimirDataModule.SImpr('Select * From "Cliente" WHERE CODIGO=' +
    CodigoDBEdit.text, 'Clientes');
  ImprimirDataModule.Free;
end;

procedure TFClientes.IVADBComboBoxChange(Sender: TObject);
begin
//  if IVADBComboBox.ItemIndex = 0 then
//    IVALabel.Caption := 'Consumidor Final'
//  else if IVADBComboBox.ItemIndex = 1 then
//    IVALabel.Caption := 'Responsable Monotributo'
//  else if IVADBComboBox.ItemIndex = 2 then
//    IVALabel.Caption := 'Responsable Inscripto'
//  else if IVADBComboBox.ItemIndex = 3 then
//    IVALabel.Caption := 'Exento'
//  else
//    IVALabel.Caption := 'No Responsable';
end;

procedure TFClientes.NoBitBtnClick(Sender: TObject);
begin
  Close;
end;

procedure TFClientes.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  IF Key = VK_F3 then
    VendedorBitBtn.Click;
  IF Key = VK_F5 then
    BuscarBitBtn.Click;
end;

procedure TFClientes.BuscarGaranteBitBtnClick(Sender: TObject);
begin
  FBuscaCliente := TFBuscaCliente.Create(self);
  try
    FBuscaCliente.ShowModal;
  finally
    GaranteDBEdit.text := dm.qCliente.FieldByName('CODIGO').AsString;
    GaranteLabel.Caption := dm.qCliente.FieldByName('NOMBRE').AsString;
    FBuscaCliente.Free;
  end;
  SiBitBtn.SetFocus;
end;

procedure TFClientes.tClienteAfterCancel(DataSet: TDataSet);
begin
  dm.tCliente.Transaction.RollbackRetaining;
end;

procedure TFClientes.tClienteAfterDelete(DataSet: TDataSet);
begin
  dm.tCliente.Transaction.CommitRetaining;
end;

procedure TFClientes.tClienteAfterInsert(DataSet: TDataSet);
begin
  dm.tCliente.FieldByName('CtaNombre').AsString := '9';
  dm.tCliente.FieldByName('CtaTipo').AsString := '9';
  dm.tCliente.FieldByName('CtaAnticipo').AsString := '9';
  VendedorDBEdit.text := '0';
end;

procedure TFClientes.tClienteAfterPost(DataSet: TDataSet);
begin
  dm.tCliente.Transaction.CommitRetaining;
end;

procedure TFClientes.VendedorBitBtnClick(Sender: TObject);
begin
  BuscarVendedorForm := TBuscarVendedorForm.Create(self);
  try
    BuscarVendedorForm.ShowModal;
  finally
    VendedorDBEdit.text := dm.qVendedor.FieldByName
      ('Codigo').AsString;
    VendedorLabel.Caption := dm.qVendedor.FieldByName
      ('Nombre').AsString;
    BuscarVendedorForm.Free;
  end;
end;

end.
