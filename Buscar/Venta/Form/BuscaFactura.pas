unit BuscaFactura;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, StdCtrls, Buttons, Grids, DBGrids, DataModule, ExtCtrls,
  jpeg, ImprimirDM, IBX.IBCustomDataSet, IBX.IBQuery;

type
  TBuscaFacturaForm = class(TForm)
    DS: TDataSource;
    Panel1: TPanel;
    Label2: TLabel;
    ventaEdit: TEdit;
    Panel2: TPanel;
    SiBitBtn: TBitBtn;
    Tabla: TIBQuery;
    LetraEdit: TEdit;
    Label1: TLabel;
    DBGrid1: TDBGrid;
    todoBitBtn: TBitBtn;
    Image1: TImage;
    Presupuesto: TCheckBox;
    Label4: TLabel;
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure NoBitBtnClick(Sender: TObject);
    procedure SiBitBtnClick(Sender: TObject);
    procedure todoBitBtnClick(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ActualizarGrilla(nro,letra:string);
  private
    { Private declarations }
  public
    { Public declarations }
    Codigo, CodProve, Tipo: String;
    Cancela: boolean;
  end;

var
  BuscaFacturaForm: TBuscaFacturaForm;

implementation

{$R *.dfm}

procedure TBuscaFacturaForm.ActualizarGrilla;
var sql, where:string;
begin
  if ((nro <> '') or (letra <> '')) then
    where := ' WHERE' + '  (CODIGO like ' + QuotedStr(nro + '%') + '  ) AND'
    + ' (LETRA like ' + QuotedStr(letra + '%') + ' )';
  ImprimirDataModule := TImprimirDataModule.Create(self);
  if Presupuesto.Checked then
    sql := 'SELECT ' + ImprimirDataModule.presupuestoTSql
    else
      sql := 'SELECT ' + ImprimirDataModule.ventaTSql;
  ImprimirDataModule.Free;
  Tabla.SQL.Text := sql + where;
  Tabla.Open;
end;

procedure TBuscaFacturaForm.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if not DBGrid1.Focused = True then
  begin
    ActualizarGrilla(ventaEdit.Text,LetraEdit.Text);
  end;
  if Key = VK_Escape then
    Close;
end;

procedure TBuscaFacturaForm.Image1Click(Sender: TObject);
begin
  ImprimirDataModule := TImprimirDataModule.Create(self);
  ImprimirDataModule.CSV(Tabla.SQL.Text, 'VENTAS');
  ImprimirDataModule.Free;
end;

procedure TBuscaFacturaForm.NoBitBtnClick(Sender: TObject);
begin
  Cancela := True;
  Codigo := '';
  Close;
end;

procedure TBuscaFacturaForm.SiBitBtnClick(Sender: TObject);
var
  nro, letra: string;
begin
  // IMPRIMIR
  if (dm.ConfigQuery.FieldByName('Imprimir').AsString) <> 'NO' then
  begin
    nro := Tabla.FieldByName('CODIGO').AsString;
    letra := Tabla.FieldByName('LETRA').AsString;
    ImprimirDataModule := TImprimirDataModule.Create(self);
    if Presupuesto.Checked then
      with ImprimirDataModule do
        Impr(ImprimirDataModule.PRE(nro, letra), 'Presupuesto')
    else
      with ImprimirDataModule do
        Impr(ImprimirDataModule.VTA(nro, letra), '');
    ImprimirDataModule.Free;
  end;
  Close;
end;

procedure TBuscaFacturaForm.todoBitBtnClick(Sender: TObject);
var sql:string;
begin
  ActualizarGrilla('','');
end;


procedure TBuscaFacturaForm.DBGrid1DblClick(Sender: TObject);
begin
  SiBitBtnClick(DBGrid1);
end;

procedure TBuscaFacturaForm.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  IF Key = VK_DOWN then
    DBGrid1.SetFocus;
end;

procedure TBuscaFacturaForm.FormCreate(Sender: TObject);
begin
  dm.ConfigQuery.Open;
end;

procedure TBuscaFacturaForm.FormDestroy(Sender: TObject);
begin
  Tabla.Close;
end;

end.
