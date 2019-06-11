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
    FacturarBitBtn: TBitBtn;
    Image1: TImage;
    TipoRadioGroup: TRadioGroup;
    todoBitBtn: TBitBtn;
    EnviarEmailCheckBox: TCheckBox;
    Label11: TLabel;
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
    procedure FormShow(Sender: TObject);
    procedure FacturarBitBtnClick(Sender: TObject);
    procedure TipoRadioGroupClick(Sender: TObject);
    procedure EnviarEmailCheckBoxClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Codigo, CodProve, Tipo: String;
    Cancela, anular: boolean;
  end;

var
  BuscaFacturaForm: TBuscaFacturaForm;

implementation

{$R *.dfm}

uses OperacionF;

procedure TBuscaFacturaForm.ActualizarGrilla;
var sql, where,anulada,buscar:string;
begin
  anulada := '(ANULADA IS NULL)';

  if ((nro <> '') or (letra <> '')) then
    buscar := '(CODIGO like ' + QuotedStr(nro + '%') + '  ) '
    + ' AND (LETRA like ' + QuotedStr(letra + '%') + ' )';

//  if (anular and (buscar<>'')) then
//    where:='WHERE '+buscar+' AND '+anulada
//    else if anular then
//      where:='WHERE '+anulada
//      else if buscar<>'' then where:='WHERE '+buscar;
  if (buscar <> '') then
    where:='WHERE '+buscar+' AND '+anulada
  else
    where:='WHERE '+anulada;

  ImprimirDataModule := TImprimirDataModule.Create(self);

  case TipoRadioGroup.ItemIndex of
    0 : sql := 'SELECT ' + ImprimirDataModule.ventaTSql;
    1 : sql := 'SELECT ' + ImprimirDataModule.OperacionSql;
    2 : sql := 'SELECT ' + ImprimirDataModule.presupuestoTSql;
  end;

  ImprimirDataModule.Free;
  Tabla.SQL.Text := sql + where;
  Tabla.Open;
  Tabla.Last;
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

procedure TBuscaFacturaForm.FormShow(Sender: TObject);
begin
  if anular then
  begin
    SiBitBtn.Caption := 'Seleccionar';
    Image1.Visible := False;
  end;
  todoBitBtn.Click;
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
  Codigo := Tabla.FieldByName('CODIGO').AsString;
  // IMPRIMIR
  if not ( anular and ((dm.ConfigQuery.FieldByName('Imprimir').AsString ) <> 'SI')) then
  begin
    nro := Tabla.FieldByName('CODIGO').AsString;
    letra := Tabla.FieldByName('LETRA').AsString;
    ImprimirDataModule := TImprimirDataModule.Create(self);
    with ImprimirDataModule do
      case TipoRadioGroup.ItemIndex of
        0 : Impr(ImprimirDataModule.VTA(nro, letra), letra);
        1 : Impr(oper(nro, 'PED', letra), 'CTicket');
        2 : Impr(ImprimirDataModule.PRE(nro, letra), 'Presupuesto');
      end;
    ImprimirDataModule.Free;
  end;
  envEmail:=False;
  Close;
end;

procedure TBuscaFacturaForm.TipoRadioGroupClick(Sender: TObject);
begin
  FacturarBitBtn.Visible := (TipoRadioGroup.ItemIndex=1);
  todoBitBtn.Click;
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

procedure TBuscaFacturaForm.EnviarEmailCheckBoxClick(Sender: TObject);
begin
  envEmail:=EnviarEmailCheckBox.Checked;
end;

procedure TBuscaFacturaForm.FacturarBitBtnClick(Sender: TObject);
var codRem : string;
begin
  if (TipoRadioGroup.ItemIndex=1) and (Tabla.RecordCount>0) then
  begin
    codRem := Tabla.FieldByName('CODIGO').AsString;
    Tabla.SQL.Text:='SELECT "Venta".REMITO FROM "Venta" WHERE "Venta".REMITO='+QuotedStr(codRem);
    Tabla.Open;
    If Tabla.RecordCount > 0 then
    begin
      ShowMessage('¡Remito ya facturado!');
      todoBitBtn.Click;
    end
    else
    begin
      OperacionForm := TOperacionForm.Create(self);
      OperacionForm.codRem := codRem;
      try
        OperacionForm.ShowModal;
      finally
        OperacionForm.Free;
      end;
    end;
  end;
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
