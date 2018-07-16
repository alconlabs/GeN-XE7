unit PagoF;

interface

uses Data.DB, IBX.IBCustomDataSet, IBX.IBQuery, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.Buttons, Vcl.Controls, System.Classes, Vcl.ExtCtrls,
  Windows, Messages, SysUtils, Variants, Graphics, Forms,
  Dialogs, DataModule, OleCtrls, SHDocVw;

type
  TPagoForm = class(TForm)
    Panel1: TPanel;
    Panel3: TPanel;
    Panel2: TPanel;
    AceptarBitBtn: TBitBtn;
    SalirBitBtn: TBitBtn;
    CalcularBitBtn: TBitBtn;
    DesdeDateTimePicker: TDateTimePicker;
    HastaDateTimePicker: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    SaldoEdit: TEdit;
    Label6: TLabel;
    QTemp: TIBQuery;
    Q: TIBQuery;
    TotalEdit: TEdit;
    Label4: TLabel;
    procedure AceptarBitBtnClick(Sender: TObject);
    procedure CalcularBitBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    fecha: string;
    { Public declarations }
  end;

var
  PagoForm: TPagoForm;

implementation

{$R *.dfm}

procedure TPagoForm.AceptarBitBtnClick(Sender: TObject);
var
  i, c: integer;
begin
  fecha := (FormatDateTime('mm/dd/yyyy hh:mm:ss', now));

  // Iniciar la Transaccion

  // CONTABILIDAD++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  // Insertar en la tabla LibroDiario
  // obtener el numero de asiento
  Q.SQL.Text := 'Select Max(ASIENTO) From "LibroDiario"';
  Q.Open;
  i := Q.Fields[0].AsInteger + 1;
  Q.Close;

  // LIQUIDACION DE

  if StrToFloat(SaldoEdit.Text) > 0 then
  begin
    // PAGO DE IIBB
    // renglon  -  A PAGAR
    Q.SQL.Text := 'select * from "Cuenta" where "Cuenta".CODIGO=' +
      dm.ConfigQuery.FieldByName('CtaIIBB').AsString;
    Q.Open;
    c := c + 1;
    QTemp.SQL.Text :=
      'Insert Into "LibroDiario" (ASIENTO, FECHA, LEYENDA, JERARQUIA, CUENTA, DEBE, HABER, OCULTO)'
      + ' Values ' + '( ' + IntToStr(i) + ', ' + QuotedStr(fecha) +
      ', ''PAGO DE IIBB'', ' + QuotedStr(Q.FieldByName('Jerarquia').AsString) +
      ', ' + QuotedStr(Q.FieldByName('DESCRIPCION').AsString) + ', ' +
      SaldoEdit.Text + ', 0, ' + QuotedStr(Oculto) + ' )';
    QTemp.ExecSQL;

    // renglon  - CAJA
    Q.SQL.Text := 'select * from "Cuenta" where "Cuenta".CODIGO=' +
      dm.ConfigQuery.FieldByName('CtaCaja').AsString;
    Q.Open;
    c := c + 1;
    QTemp.SQL.Text :=
      'Insert Into "LibroDiario" (ASIENTO, FECHA, LEYENDA, JERARQUIA, CUENTA, DEBE, HABER, OCULTO)'
      + ' Values ' + '( ' + IntToStr(i) + ', ' + QuotedStr(fecha) +
      ', ''PAGO DE IIBB'', ' + QuotedStr(Q.FieldByName('Jerarquia').AsString) +
      ', ' + QuotedStr(Q.FieldByName('DESCRIPCION').AsString) + ', 0, ' +
      SaldoEdit.Text + ', ' + QuotedStr(Oculto) + ' )';
    QTemp.ExecSQL;
  end;

  // CONTABILIDAD------------------------------------------------------------------------------

  // Completa la Transaccion
  QTemp.Transaction.CommitRetaining;
  Close;
end;

procedure TPagoForm.CalcularBitBtnClick(Sender: TObject);
var iibb, tot : Double;
begin
  iibb:=0;
  tot:=0;
  QTemp.SQL.Text := 'SELECT IIBB, TOTAL FROM "Venta" WHERE ("Venta".FECHA >= ' +
    QuotedStr(DateToStr(DesdeDateTimePicker.Date)) + ' ) AND' +
    '  ("Venta".FECHA <= ' +
    QuotedStr(DateToStr(HastaDateTimePicker.Date)) + ' )' + '';
  QTemp.Open;
  while QTemp.Eof = False do
  begin
    iibb := iibb + QTemp.FieldByName('IIBB').AsFloat;
    tot := tot + QTemp.FieldByName('TOTAL').AsFloat;
    QTemp.Next;
  end;
  SaldoEdit.Text := FloatToStr(iibb);
  TotalEdit.Text := FloatToStr(tot);
end;

procedure TPagoForm.FormCreate(Sender: TObject);
begin
  // dm := TDM.Create(Self);
  dm.ConfigQuery.Open;
end;

procedure TPagoForm.FormShow(Sender: TObject);
begin
  DesdeDateTimePicker.DateTime:=(now-30);
  HastaDateTimePicker.DateTime:=now;
end;

end.
