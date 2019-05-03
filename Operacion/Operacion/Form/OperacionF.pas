unit OperacionF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, DB, ADODB, DataModule, Grids,
  DBGrids, ValEdit, DateUtils, ComCtrls, Printers, ImprimirDM, OperacionDM,
  IBX.IBCustomDataSet, IBX.IBQuery,Math;

type
  TOperacionForm = class(TForm)
    Panel4: TPanel;
    Panel1: TPanel;
    Label1: TLabel;
    ClienteLabel: TLabel;
    Label9: TLabel;
    ClienteEdit: TEdit;
    VendedorEdit: TEdit;
    Label16: TLabel;
    VendedorLabel: TLabel;
    FechaDateTimePicker: TDateTimePicker;
    SGFact: TStringGrid;
    TipoRadioGroup: TRadioGroup;
    Label40: TLabel;
    ComboBox1: TComboBox;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    NroChequeEdit: TEdit;
    NroTarjetaEdit: TEdit;
    DetChequeEdit: TEdit;
    DetTarjetaEdit: TEdit;
    FECheque: TEdit;
    FETarjeta: TEdit;
    DiaChequeDateTimePicker: TDateTimePicker;
    FEContado: TEdit;
    Tabla: TIBQuery;
    Q: TIBQuery;
    Panel3: TPanel;
    ProcesarBitBtn: TBitBtn;
    ClienteBitBtn: TBitBtn;
    VendedorBitBtn: TBitBtn;
    AgregarBitBtn: TBitBtn;
    NuevoBitBtn: TBitBtn;
    QuitarBitBtn: TBitBtn;
    CantidadBitBtn: TBitBtn;
    Label3: TLabel;
    PrecioLabel: TLabel;
    Panel2: TPanel;
    SGTotal: TStringGrid;
    GroupBox5: TGroupBox;
    LbSaldo: TLabel;
    GroupBox4: TGroupBox;
    cbTipo: TComboBox;
    Label31: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    FEOtro: TEdit;
    PagareCheckBox: TCheckBox;
    Presupuesto: TCheckBox;
    CUITLabel: TLabel;
    ComprobanteEdit: TEdit;
    Label5: TLabel;
    PercEdit: TEdit;
    Label6: TLabel;
    DescuentoBitBtn: TBitBtn;
    Label7: TLabel;
    PedidoCheckBox: TCheckBox;
    TotalLabel: TLabel;
    procedure ClienteBitBtnClick(Sender: TObject);
    procedure RJustifyEdit(var ThisEdit: TEdit);
    procedure TraeNombreCliente;
    procedure AgregarBitBtnClick(Sender: TObject);
    procedure CalculaTotales;
    procedure QuitarBitBtnClick(Sender: TObject);
    procedure ProcesarBitBtnClick(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FEContadoChange(Sender: TObject);
    procedure FEChequeChange(Sender: TObject);
    procedure FETarjetaChange(Sender: TObject);
    procedure FEOtroChange(Sender: TObject);
    procedure FEContadoExit(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure CantidadBitBtnClick(Sender: TObject);
    procedure VendedorBitBtnClick(Sender: TObject);
    procedure cbTipoChange(Sender: TObject);
    procedure NuevoBitBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TraerArticulo(codigoArticulo:string; PR,CAN:Double);
    function NetoGravado(costo,ganancia,flete:double):double;
    procedure PercEditExit(Sender: TObject);
    procedure DescuentoBitBtnClick(Sender: TObject);
    procedure Nuevo;
  private
    { Private declarations }
  public
  { Public declarations }
    OK, Proveedor, FPagoOK, Compra, Pedido: Boolean;
    Cuenta, DiasCalculo, CuotasTotal, d, numfact, OrdTrans: Integer;
    CMV, UltCosto, subtotal, Impuesto, NG21, IVA21, NG105, IVA105, NGO, IVAO,
      desc, perc, costo, reparaciones, Total, IIBB, NGIIBB, Exento,
      ComisionVendedor: Double;
    CtaNombre, CtaTipo, CtaAnticipo, CtaIIBB, code, Dia, Mes, Ano, TDocumento,
      Tiempo, T2, Precio, ChequeCodCheque, ChequeNumero, ChequeDetalle,
      ChequeCodFactura, ChequeMntCheque, ChequeFecha, ChequeDias, Fecha,
      FechaVence, iv, DetalleFactura: string;
    BalanceAnterior, Interes, BalanceTotal, Deuda, Saldo, Pagado,
      Comision: Double;
    Tipo: Char;
    FechaVencimiento: TDate;
    procedure TraerImpresora;
    procedure QuitarArticulos;

  end;

type
  TCompartido = record
    Numero: Integer;
    Cadena: String[20];
  end;

  PCompartido = ^TCompartido;

var
  OperacionForm: TOperacionForm;
  Compartido: PCompartido;
  FicheroM: THandle;

implementation

uses UFBuscaCliente, BuscarCheques, UFBuscaArticulos,
  AgregarCantidad, BuscarVendedor, servicio, UFBuscaProve, UFSelProdFact, DescuentoF;
{$R *.dfm}

procedure TOperacionForm.QuitarArticulos;
begin
  while Cuenta > 1 do
    QuitarBitBtn.Click; // vaciar articulos
//  Nuevo;
end;

procedure TOperacionForm.TraerArticulo;
var
  TASA : String;
begin
  If Cuenta > 1 then SGFact.RowCount := SGFact.RowCount + 1;
  Tabla.Close;
  Tabla.SQL.Text := 'SELECT * FROM "Articulo" ' + 'WHERE CODIGO = ' + codigoArticulo;
  Tabla.Open;
  {codigo}SGFact.Cells[0, Cuenta] := Tabla.FieldByName('CODIGO').AsString;
  {nombre}SGFact.Cells[1, Cuenta] := Tabla.FieldByName('DESCRIPCION').AsString;
  {cantidad}SGFact.Cells[3, Cuenta] := FloatToStr(CAN);
  if PR=0 then PR := Tabla.FieldByName('PRECIO' + PrecioLabel.Caption).AsFloat;
  {precio}SGFact.Cells[4, Cuenta] := FloatToStr(PR);
  TASA := Tabla.FieldByName('TASA').AsString;
  if TASA='105' then TASA := '10.5';
  {iva}SGFact.Cells[6, Cuenta] := TASA;
  Cuenta := Cuenta + 1;
  FEContado.Text:='0';
  CalculaTotales;
end;

procedure TOperacionForm.Nuevo;
begin
  QuitarArticulos;
  SGFact.Cells[0, 0] := 'Codigo';
  SGFact.Cells[1, 0] := 'Descripcion';
  SGFact.Cells[2, 0] := '# Pieza';
  SGFact.Cells[3, 0] := 'Cantidad';
  SGFact.Cells[4, 0] := 'Precio';
  SGFact.Cells[5, 0] := 'Total';
  SGFact.Cells[6, 0] := 'Tasa';
  SGFact.Cells[7, 0] := 'Descuento';
  SGFact.Cells[8, 0] := 'NG';
  SGFact.Cells[9, 0] := 'IIBB';
  SGFact.Cells[10,0] := 'IVA';
  SGFact.Cells[3, 1] := '0';
  SGFact.Cells[4, 1] := '0.00';
  SGFact.Cells[5, 1] := '0.00';
  SGTotal.Cells[0, 0] := 'Sub Total';
  SGTotal.Cells[0, 1] := 'Descuento';
  SGTotal.Cells[0, 2] := 'Impuesto';
  SGTotal.Cells[0, 3] := 'Interes';
  SGTotal.Cells[0, 4] := 'TOTAL';
  SGTotal.Cells[0, 5] := 'Saldo';
  SGTotal.Cells[1, 0] := '0.00';
  SGTotal.Cells[1, 1] := '0.00';
  SGTotal.Cells[1, 2] := '0.00';
  SGTotal.Cells[1, 3] := '0.00';
  SGTotal.Cells[1, 4] := '0.00';
  SGTotal.Cells[1, 5] := '0.00';
//  FormatSettings.ShortDateFormat := 'dd/mm/yyyy';
  FechaDateTimePicker.DateTime := Date;
  subtotal := 0;
  Impuesto := 0;
  desc := 0;
  perc := 0;
  Total := 0;
  NG21 := 0;
  IVA21 := 0;
  NG105 := 0;
  IVA105 := 0;
  PercEdit.Text := '0';
  costo := 0;
  reparaciones := 0;
  ClienteEdit.Text := '0';
  ClienteLabel.Caption := 'Consumidor Final';
  CUITLabel.Caption:='';
  ComprobanteEdit.Text:='';
  FEContado.Text := '0';
  FECheque.Text := '0';
  FETarjeta.Text := '0';
  FEOtro.Text := '0';
  Cuenta := 1;
  LbSaldo.Caption:='0.00';
  PedidoCheckBox.Checked:=False;
end;

procedure TOperacionForm.NuevoBitBtnClick(Sender: TObject);
begin
  ServForm := TServForm.Create(self);
  try
    ServForm.ShowModal;
  finally
    If ServForm.DescripcionEdit.Text <> '' then
    begin
      if Cuenta > 1 then
        SGFact.RowCount := SGFact.RowCount + 1;
      SGFact.Cells[0, Cuenta] := ServForm.cod;
      SGFact.Cells[1, Cuenta] := ServForm.DescripcionEdit.Text;
      SGFact.Cells[2, Cuenta] := '0';
      SGFact.Cells[3, Cuenta] := '1'; // cantidad
      SGFact.Cells[4, Cuenta] := ServForm.PrecioEdit.Text;
      SGFact.Cells[5, Cuenta] := FloatToStr(StrToFloat(SGFact.Cells[4, Cuenta])
        * StrToFloat(SGFact.Cells[3, Cuenta])); // total
      SGFact.Cells[6, Cuenta] := '0';
      SGFact.Cells[7, Cuenta] := '0';
      SGFact.Cells[8, Cuenta] := '0'; // PRECIO DE COSTO
      SGFact.Cells[9, Cuenta] := '0';
      SGFact.Cells[10, Cuenta] := '0';
      SGFact.Cells[11, Cuenta] := '0'; // PRECIO DE COSTO
      Cuenta := Cuenta + 1;
    end;
    ServForm.Free;
  end;
  FEContado.Text:='0';
  CalculaTotales;
  FEContado.SetFocus;
end;

procedure TOperacionForm.CalculaTotales;
var
  i: Integer;
  NG,DSC,NGD,IVA,CONT,PR,PRD,TOT,CAN,TIVA : Double;
  des : string;
  esA, esB, esC : Boolean;
begin
  // Calcula los totales de la factura
  //  subtotal := 0;
  //  Impuesto := 0;
  desc := 0;
  perc := 0;
  Total := 0;
  costo := 0;
  reparaciones := 0;
  IVA21 := 0;
  IVA105 := 0;
  IVAO := 0;
  UltCosto := 0;
  NG21 := 0;
  NG105 := 0;
  NGO := 0;
  NG := 0;
//  DSC := 0;
  NGD :=0;
  IVA :=0;
  CONT:=StrToFloat( FEContado.Text );
  PR:=0;
  if (cbTipo.ItemIndex<6) then esA:=true;
  if (cbTipo.ItemIndex>5) and (cbTipo.ItemIndex<11) then esB:=true;
//  if (cbTipo.ItemIndex>10) and (cbTipo.ItemIndex<15) then esC:=true;
  For i := 1 to SGFact.RowCount - 1 do
  begin
    //CANTIDAD
    if (SGFact.Cells[3, i] = '') then SGFact.Cells[3, i] := '1';
    CAN := StrToFloat(SGFact.Cells[3, i]);
    // TASA
    if (SGFact.Cells[6, i] = '') then TIVA := 0
    else TIVA := StrToFloat(SGFact.Cells[6, i]);
    //PRECIO
    if (SGFact.Cells[4, i] = '') then SGFact.Cells[4, i] := '0';
    PR := StrToFloat(SGFact.Cells[4, i]);
//    if not((cbTipo.ItemIndex = 29) or (cbTipo.ItemIndex = 11)) then PR := OperacionDataModule.CalcularIVA((PR),TIVA);
    if esB then PR := OperacionDataModule.CalcularIVA((PR),TIVA);//es B
    //DESCUENTO
    if (SGFact.Cells[7, i] = '') then SGFact.Cells[7, i] := '0';
    des := (SGFact.Cells[7, i]);
      if Pos( '%', des ) >0 then
        begin
          DSC := StrToFloat( StringReplace(des, '%', '', [rfReplaceAll, rfIgnoreCase]) )/100;
          PRD := PR-(PR*DSC);
          DSC := PR-PRD;
        end
      else DSC := StrToFloat(des);
    //TOTAL
    TOT := (PR*CAN)-DSC;
    SGFact.Cells[5, i] := FloatToStr(TOT);
    //IVA
    if esA then IVA := OperacionDataModule.CalcularIVA((TOT),TIVA)-TOT
    else if esB then IVA := OperacionDataModule.SacarIVA((TOT),TIVA);
    SGFact.Cells[10, i] := FloatToStr(IVA);
    // NG
    if esB then NG := TOT - IVA
    else NG := TOT;
    SGFact.Cells[8, i] := FloatToStr(NG);
    //
    if (SGFact.Cells[9, i] = '') then SGFact.Cells[9, i] := '0';
    // Calcula el Ultimo Costo
//    if (SGFact.Cells[11, i] = '') then SGFact.Cells[11, i] := '0';
//    if SGFact.Cells[11, i] <> '0' then UltCosto := UltCosto + StrToFloat(SGFact.Cells[11, i]);
    //
    if SGFact.Cells[9, i] <> '0' then reparaciones := reparaciones + StrToFloat(SGFact.Cells[9, i]);

  // Calcula el monto para cobrar el impuesto de ventas
    if ((cbTipo.ItemIndex = 29) or (cbTipo.ItemIndex = 11)) then
    begin
      NGO:= NGO + NG;
    end
    else
    begin
      If TIVA = 21 then
      begin
        NG21 := NG21 + NG;
        IVA21 := IVA21 + IVA;
      end
      else
      if TIVA = 10.5 then
        begin
          NG105 := NG105 + NG;
          IVA105 := IVA105 + IVA;
        end
        else
         begin
          NGO := NGO + NG;
          IVAO := IVAO + IVA;
        end;
    end;
      desc:= desc + DSC;
    end;

  NG21 := RoundTo(NG21,-2);
  NG105 := RoundTo(NG105,-2);
  NGO := RoundTo(NGO,-2);
  IVA21 := RoundTo(IVA21,-2);
  IVA105 := RoundTo(IVA105,-2);
  IVAO := RoundTo(IVAO,-2);
  perc := RoundTo(perc,-2);
  desc:=  RoundTo((desc),-2);

  subtotal:= RoundTo((NG21 + NG105 + NGO),-2);

  perc := (subtotal * StrToFloat(PercEdit.Text) / 100);

  Impuesto := RoundTo((IVA21 + IVA105 + IVAO + perc),-2);

  Total := RoundTo((subtotal + Impuesto + Interes),-2);

  // escribe los valores en las celdas
  SGTotal.Cells[1, 0] := Format('%8.2n', [subtotal]);
  SGTotal.Cells[1, 1] := Format('%8.2n', [desc]);
  SGTotal.Cells[1, 2] := Format('%8.2n', [Impuesto]);
  SGTotal.Cells[1, 3] := Format('%8.2n', [Interes]);
  SGTotal.Cells[1, 4] := Format('%8.2n', [Total]);

  if FEContado.Text = '' then FEContado.Text := '0';
  if FECheque.Text = '' then FECheque.Text := '0';
  if FETarjeta.Text = '' then FETarjeta.Text := '0';
  if FEOtro.Text = '' then FEOtro.Text := '0';

  if ((CONT = 0) or (CONT > Total)) then FEContado.Text := FloatToStr(Total);

  Pagado := StrToFloat(FEContado.Text) + StrToFloat(FECheque.Text) +
    StrToFloat(FETarjeta.Text) + StrToFloat(FEOtro.Text);
  Saldo := Total - Pagado;
  TotalLabel.Caption := FloatToStr(Total);
  LbSaldo.Caption := FloatToStr(Saldo);
end;

procedure TOperacionForm.cbTipoChange(Sender: TObject);
begin
  CalculaTotales;
end;

procedure TOperacionForm.RJustifyEdit(var ThisEdit: TEdit);
var
  Left, Width: Integer;
  GString: String;
  Rgn: TRect;
  TheCanvas: TControlCanvas;
begin
  TheCanvas := TControlCanvas.Create;
  try
    TheCanvas.Control := ThisEdit;
    GString := ThisEdit.Text;
    Rgn := ThisEdit.ClientRect;
    TheCanvas.FillRect(Rgn);
    Width := TheCanvas.TextWidth(GString);
    Left := Rgn.Right - Width - 1;
    TheCanvas.TextRect(Rgn, Left, 0, GString);
  finally
    TheCanvas.Free;
  end;
end;

Procedure GridRemoveRow(StrGrid: TStringGrid; DelRow: Integer);
Var
  Row: Integer;
begin
  If DelRow <= StrGrid.RowCount then
  Begin
    If (DelRow = StrGrid.RowCount - 1) AND (DelRow = 1) then
    begin
      StrGrid.Rows[DelRow].Clear;
      StrGrid.Cells[3, 1] := '0';
      StrGrid.Cells[4, 1] := '0.00';
      StrGrid.Cells[5, 1] := '0.00';
    end
    else if DelRow = StrGrid.RowCount - 1 then
      StrGrid.RowCount := StrGrid.RowCount - 1
    else
    begin
      For Row := DelRow To StrGrid.RowCount - 2 do
        StrGrid.Rows[Row].Assign(StrGrid.Rows[Row + 1]);
      StrGrid.RowCount := StrGrid.RowCount - 1;
    end;
  end;
end;

procedure TOperacionForm.TraeNombreCliente;
begin
  If ClienteEdit.Text <> '' then
  begin
    Tabla.SQL.Text := 'Select * from "Cliente" where CODIGO = ' +
      ClienteEdit.Text;
    Tabla.Active := True;
    If Tabla.RecordCount < 1 then
    begin
      MessageDlg('�C�digo de cliente no existe!', mtError, [mbOK], 0);
      ClienteEdit.SetFocus;
    end;
  end;
end;

procedure TOperacionForm.ClienteBitBtnClick(Sender: TObject);
var cliIVA : string;
begin
  QuitarArticulos;
  Deuda := 0;
  if Compra then
  begin
    FBuscaProve := TFBuscaProve.Create(self);
    try
      FBuscaProve.ShowModal;
    finally
      ClienteEdit.Text := FBuscaProve.Tabla.FieldByName('CODIGO').AsString;
      with FBuscaProve do
      begin
        ClienteLabel.Caption := Tabla.FieldByName('Nombre').AsString;
        Label3.Caption := Tabla.FieldByName('Direccion').AsString;
        CUITLabel.Caption := Tabla.FieldByName('CUIT').AsString;
        CtaNombre := Tabla.FieldByName('CtaNombre').AsString;
        CtaTipo := Tabla.FieldByName('CtaTipo').AsString;
        CtaAnticipo := Tabla.FieldByName('CtaAnticipo').AsString;
        PagareCheckBox.Checked := Tabla.FieldByName('PAGARE').AsBoolean;
        if (dm.ConfigQuery.FieldByName('IVA').AsString = 'Responsable Inscripto') and
          (Tabla.FieldByName('IVA').AsString = 'RI') then cbTipo.ItemIndex := 0
        else
        if (Tabla.FieldByName('IVA').AsString = 'RI') then
          cbTipo.ItemIndex := 6
        else
          cbTipo.ItemIndex := 11;
      end;
      FBuscaProve.Free;
    end;
  end
  else
  begin
    FBuscaCliente := TFBuscaCliente.Create(self);
    try
      FBuscaCliente.ShowModal;
    finally
      ClienteEdit.Text := FBuscaCliente.Tabla.FieldByName('CODIGO').AsString;
      with FBuscaCliente do
      begin
        ClienteLabel.Caption := Tabla.FieldByName('NOMBRE').AsString;
        Label3.Caption := Tabla.FieldByName('DIRECCION').AsString;
        // DireccionLabel.Caption := Tabla.FieldByName('DIRECCIONCOMERCIAL').AsString;
        // Label13.Caption := Tabla.FieldByName('TELEFONO').AsString;
        // Label14.Caption := Tabla.FieldByName('CELULAR').AsString;
        PrecioLabel.Caption := Tabla.FieldByName('PRECIO').AsString;
//        if PrecioLabel.Caption = '' then PrecioLabel.Caption := '0';
        // Label19.Caption := Tabla.FieldByName('TERMINOS').AsString;
        // Label23.Caption := DateToStr(IncDay(now,Tabla.FieldByName('DIASCREDITO').AsInteger));
        VendedorEdit.Text := Tabla.FieldByName('VENDEDOR').AsString;
        CUITLabel.Caption := Tabla.FieldByName('DOCUMENTO').AsString;
        CUITLabel.Caption := Tabla.FieldByName('CUIT').AsString;
        // DocumentoLabel.Caption := Tabla.FieldByName('DOCUMENTO').AsString;
        // CUENTA CLIENTE
        CtaNombre := Tabla.FieldByName('CTANOMBRE').AsString;
        CtaTipo := Tabla.FieldByName('CTATIPO').AsString;
        CtaAnticipo := Tabla.FieldByName('CTAANTICIPO').AsString;
        IF Tabla.FieldByName('PAGARE').AsString = 'SI' THEN
          PagareCheckBox.Checked := True;
        // IVA
        cliIVA := Tabla.FieldByName('IVA').AsString;
        if catIVA='Responsable Monotributo' then cbTipo.ItemIndex := 11
        else
          if catIVA='Responsable Inscripto' then
            if cliIVA='Responsable Inscripto' then cbTipo.ItemIndex := 0
            else cbTipo.ItemIndex := 6;
//        else if (dm.ConfigQuery.FieldByName('IVA').AsString = 'RI') and
//        (Tabla.FieldByName('IVA').AsString <> 'RI') then
//        cbTipo.ItemIndex := 1
//        else if (dm.ConfigQuery.FieldByName('IVA').AsString = 'NR') then
//        cbTipo.ItemIndex := 4
//        else
//        cbTipo.ItemIndex := 2;
//        if ((Tabla.FieldByName('IVA').AsString = 'Responsable Inscripto') or (Tabla.FieldByName('IVA').AsString = 'S.R.L.') or (Tabla.FieldByName('IVA').AsString = 'S.A.') or (Tabla.FieldByName('IVA').AsString = 'Cooperativa')) and (cbTipo.ItemIndex = 1) then cbTipo.ItemIndex := 1;
//
//        if (((Tabla.FieldByName('IVA').AsString = 'Responsable Monotributo') or
//          (Tabla.FieldByName('IVA').AsString = 'Exento') or
//          (Tabla.FieldByName('IVA').AsString = 'S.A.') or
//          (Tabla.FieldByName('IVA').AsString = 'No Responsable')) and
//          (cbTipo.ItemIndex = 1)) then
//          cbTipo.ItemIndex := 6;
        if TipoRadioGroup.ItemIndex = 0 then
        begin
          DM.Query.Close;
          DM.Query.SQL.Text := 'SELECT * FROM "CtaCte" WHERE CLIENTE=' +
            ClienteEdit.Text;
          DM.Query.Open;
          if Abs(DM.Query.FieldByName('SALDO').AsFloat) > 0.4 then
          begin
            If Cuenta > 1 then
              SGFact.RowCount := SGFact.RowCount + 1;
            SGFact.Cells[0, Cuenta] := '0'; // código
            Deuda := DM.Query.FieldByName('SALDO').AsFloat;
            if Deuda > 0 then
              SGFact.Cells[1, Cuenta] := 'Deuda CtaCte'
            else
              SGFact.Cells[1, Cuenta] := 'Saldo a Favor'; // descripción
            SGFact.Cells[2, Cuenta] := '0'; // serie
            SGFact.Cells[3, Cuenta] := '1'; // cantidad
            SGFact.Cells[4, Cuenta] := Format('%8.2f', [Deuda]); // precio
            SGFact.Cells[5, Cuenta] :=
              Format('%8.2f', [StrToFloat(SGFact.Cells[4, Cuenta]) *
              StrToFloat(SGFact.Cells[3, Cuenta])]); // total
            SGFact.Cells[6, Cuenta] := '0'; // IVA
            SGFact.Cells[9, Cuenta] := '0'; // ACTIVIDAD DE MONOTRIBUTO
            SGFact.Cells[10, Cuenta] := '0'; // PORCENTAJE DE INGRESOS BRUTOS
            Cuenta := Cuenta + 1;
            DM.Query.Close;
            FEContado.Text := FloatToStr(Total);
          end;
          Tabla.Active := False;
        end;
        FBuscaCliente.Free;
      end;
      TraeNombreCliente;
  end;
    FEContado.Text:='0';
    CalculaTotales;
  end;
  AgregarBitBtn.Click;
end;

procedure TOperacionForm.DescuentoBitBtnClick(Sender: TObject);
var
 PR,CAN,DSC : Double;
begin
DescuentoForm := TDescuentoForm.Create(self);
  try
    DescuentoForm.ShowModal;
  finally
    if DescuentoForm.DescuentoEdit.Text <> '0'  then
    begin
//      desc:=DescuentoForm.DescuentoEdit.Text;
//      if Pos( '%', desc ) >0 then
//      begin
//        DSC := StrToFloat( StringReplace(desc, '%', '', [rfReplaceAll, rfIgnoreCase]) )/100;
//        TOT := StrToFloat(SGFact.Cells[5, SGFact.Row]);
//        TOTD := TOT-(TOT*DSC);
//        DSC := TOT-TOTD;
//      end
//      else DSC := StrToFloat(desc);
//      SGFact.Cells[7, SGFact.Row] := Format('%8.2f', [DSC]);
      SGFact.Cells[7, SGFact.Row] := DescuentoForm.DescuentoEdit.Text;
      if cbTipo.ItemIndex<>1 then
      begin
        PR:=StrToFloat(SGFact.Cells[4, SGFact.Row]);
        CAN:=StrToFloat(SGFact.Cells[3, SGFact.Row]);
        DSC:=StrToFloat(SGFact.Cells[7, SGFact.Row]);
        {total}SGFact.Cells[5, SGFact.Row] := FloatToStr((PR*CAN)-DSC);
      end;
      FEContado.Text:='0';
      CalculaTotales;
    end;
    DescuentoForm.Free;
  end;
end;

function TOperacionForm.NetoGravado;
begin
  Result := costo + (costo * (flete/100)) + (costo * (ganancia/100));
end;

procedure TOperacionForm.AgregarBitBtnClick(Sender: TObject);
var i : Integer;
begin
  if Compra then
  begin
    FSelProdFact := TFSelProdFact.Create(self);
    FSelProdFact.Precio := 'Costo';
    FSelProdFact.Proveedor := ClienteLabel.Caption;
    // Filtra las series que ya estan en la factura
    If (SGFact.RowCount = 2) AND (SGFact.Cells[2, 1] = '') then
      FSelProdFact.Filtro := ''
    else
    begin
      FSelProdFact.Filtro := 'NumSerie <> ' + SGFact.Cells[2, 1];
      i := 2;
      While i < SGFact.RowCount do
      begin
        FSelProdFact.Filtro := FSelProdFact.Filtro + ' AND NumSerie <> ' +
          SGFact.Cells[2, i];
        i := i + 1;
      end;
    end;
    try
      FSelProdFact.ShowModal;
    finally
      If FSelProdFact.Cancela = False then
      TraerArticulo(FSelProdFact.Edit1.Text,StrToFloat(FSelProdFact.FloatEdit1.Text),StrToFloat(FSelProdFact.CantidadEdit.Text));
    end;
  end
  else
  begin
    FBuscaArticulo := TFBuscaArticulo.Create(self);
    FBuscaArticulo.Precio := Precio;
    if (TipoRadioGroup.ItemIndex = 0) and
      (dm.ConfigQuery.FieldByName('CodigoBarra').AsString = 'SI') then
      FBuscaArticulo.cb := 'si';
    try
      FBuscaArticulo.ShowModal;
    finally
      If FBuscaArticulo.Tabla.Active = True then
      begin
        TraerArticulo(FBuscaArticulo.Tabla.FieldByName('CODIGO').AsString,0,1);
      end;
      FBuscaArticulo.Free;
      Tabla.Close;
      FEContado.SetFocus;
    end;
  end;

  //bajar el foco
  PostMessage(SGFact.Handle,WM_KEYDOWN,VK_END,0);
end;

procedure TOperacionForm.QuitarBitBtnClick(Sender: TObject);
begin
  SGFact.SetFocus;
  GridRemoveRow(SGFact, SGFact.Row);
  If Cuenta > 1 then
    Cuenta := Cuenta - 1;
  FEContado.Text:='0';
  CalculaTotales;
end;

procedure TOperacionForm.PercEditExit(Sender: TObject);
begin
  FEContado.Text:='0';
  CalculaTotales;
  FEContado.SetFocus;
end;

procedure TOperacionForm.ProcesarBitBtnClick(Sender: TObject);
var
  r, c: Integer;
  ok, impr : Boolean;
begin
  if Total >0 then
  begin
    screen.Cursor := crHourGlass;
    c := 0; // columna i
    r := 0; // row j
    if dm.ConfigQuery.FieldByName('Imprimir').AsString<>'NO' then impr := True;
    OperacionDataModule := TOperacionDataModule.Create(self);
    with OperacionDataModule do
    begin
      SetLength(mat, SGFact.ColCount, SGFact.RowCount);
      for r := 0 to SGFact.RowCount - 1 do
        for c := 0 to SGFact.ColCount - 1 do
        begin
          mat[c, r] := SGFact.Cells[c, r];
        end;
      if Compra then
      OperacionDataModule.ProcCompra(cbTipo.Text, ClienteEdit.Text,
        FormatDateTime('mm/dd/yyyy hh:mm:ss', FechaDateTimePicker.DateTime),
        VendedorEdit.Text, ComprobanteEdit.Text, CtaNombre, CUITLabel.Caption, PagareCheckBox.Checked,
        costo, Impuesto, StrToFloat(FECheque.Text),
        StrToFloat(FECheque.Text), StrToFloat(FEContado.Text), Total,
        subtotal, desc, StrToFloat(FETarjeta.Text), StrToFloat(FEOtro.Text),
        Saldo, Pagado, NG105, NG21, IVA105, IVA21, perc, Total - Saldo)
      else
      if PedidoCheckBox.Checked then
      ProcOPER('PED', 'X', ClienteEdit.Text,
        FormatDateTime('mm/dd/yyyy hh:mm:ss', FechaDateTimePicker.DateTime),
        VendedorEdit.Text, '', CtaNombre, False, PagareCheckBox.Checked, impr, costo,
        Comision, Impuesto, StrToFloat(FECheque.Text), 0,
        StrToFloat(FEContado.Text), Total, subtotal, desc,
        StrToFloat(FETarjeta.Text), StrToFloat(FEOtro.Text), Saldo, Pagado,
        Interes, NG105, NG21, IVA105, IVA21, Deuda, UltCosto)
      else
      if Presupuesto.Checked then
        ProcPresup(cbTipo.Text, ClienteEdit.Text,
          FormatDateTime('mm/dd/yyyy hh:mm:ss', FechaDateTimePicker.DateTime),
          VendedorEdit.Text, CUITLabel.Caption, CtaNombre, Presupuesto.Checked,
          PagareCheckBox.Checked, costo, Comision, Impuesto,
          StrToFloat(FECheque.Text), 0, StrToFloat(FEContado.Text), Total,
          subtotal, desc, StrToFloat(FETarjeta.Text), StrToFloat(FEOtro.Text),
          Saldo, Pagado, Interes, NG105, NG21, IVA105, IVA21, Deuda, UltCosto)
      else
        ok := ProcVTA(cbTipo.Text, ClienteEdit.Text,
          FormatDateTime('mm/dd/yyyy hh:mm:ss', FechaDateTimePicker.DateTime),
          VendedorEdit.Text, CUITLabel.Caption, CtaNombre, Presupuesto.Checked,
          PagareCheckBox.Checked, impr, costo, Comision, Impuesto,
          StrToFloat(FECheque.Text), 0, StrToFloat(FEContado.Text), Total,
          subtotal, desc, StrToFloat(FETarjeta.Text), StrToFloat(FEOtro.Text),
          Saldo, Pagado, Interes, NG105, NG21, IVA105, IVA21, Deuda, UltCosto);
    end;
    OperacionDataModule.Free;
    screen.Cursor := crDefault;
//    if ok then ClienteBitBtn.Click;
  end;
  Nuevo;
  ClienteBitBtn.Click;
end;

procedure TOperacionForm.CheckBox1Click(Sender: TObject);
begin
  CalculaTotales;
end;

procedure TOperacionForm.FormShow(Sender: TObject);
begin
  Nuevo;

  // si es venta
//  if TipoRadioGroup.ItemIndex = 0 then
//    AgregarBitBtn.Click
//  else
//    // si es Presupuesto
//    if TipoRadioGroup.ItemIndex = 1 then
//    begin
//      ClienteBitBtn.Click;
//      AgregarBitBtn.Click;
//    end
//    else
//      // si es Financiaci�n
//      if TipoRadioGroup.ItemIndex = 2 then
//      begin
//        ClienteBitBtn.Click;
//        VendedorBitBtn.Click;
//        AgregarBitBtn.Click;
//      end;
//  if Proveedor = True then
//  begin
//    // Label13.Visible := True;
//    // Label14.Visible := True;
//    // Cuenta := 1;
//  end;
  if Compra then
    begin
      OperacionForm.Caption := 'COMPRA';
      ClienteBitBtn.Caption := 'Proveedor';
      Label1.Caption := ClienteBitBtn.Caption+':';
      PedidoCheckBox.Enabled := False;
//      ClienteBitBtn.Click;
    end
  else
  if PedidoCheckBox.Checked then
    begin
      OperacionForm.Caption := 'PEDIDO';
      cbTipo.ItemIndex := 29;
    end
  else
    ClienteBitBtn.Click;
end;

procedure TOperacionForm.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F1 then
    ClienteBitBtn.Click
  else
    // IF Key = VK_F2 then PlanBitBtn.Click
    // else
    if Key = VK_F3 then
      VendedorBitBtn.Click
    else
      // IF Key = VK_F4 then CobradorBitBtn.Click
      // else
      if Key = VK_F5 then
        AgregarBitBtn.Click
      else if Key = VK_F6 then
        QuitarBitBtn.Click
      else if Key = VK_F7 then
        CantidadBitBtn.Click
      else if Key = VK_F8 then
        NuevoBitBtn.Click
      else if Key = VK_F12 then
        ProcesarBitBtn.Click
//      else if Key = VK_Escape then
//        Close
        ;
end;

procedure TOperacionForm.FEContadoChange(Sender: TObject);
begin
//  if FEContado.Text <> '' then
//    CalculaTotales;
end;

procedure TOperacionForm.FEChequeChange(Sender: TObject);
begin
  if FECheque.Text <> '' then
    CalculaTotales;
end;

procedure TOperacionForm.FETarjetaChange(Sender: TObject);
begin
  if FETarjeta.Text <> '' then
    CalculaTotales;
end;

procedure TOperacionForm.FEOtroChange(Sender: TObject);
begin
  if FEOtro.Text <> '' then
    CalculaTotales;
end;

procedure TOperacionForm.FEContadoExit(Sender: TObject);
begin
  if FEContado.Text <> '' then CalculaTotales;
  ProcesarBitBtn.SetFocus;
end;

procedure TOperacionForm.FormCreate(Sender: TObject);
begin
  cbTipo.Items.Add('A'); // 1	Factura A	20100917	NULL
  cbTipo.Items.Add('A'); // 2	Nota de Débito A	20100917	NULL
  cbTipo.Items.Add('A'); // 3	Nota de Crédito A	20100917	NULL
  cbTipo.Items.Add('A'); // 4	Recibos A	20100917	NULL
  cbTipo.Items.Add('A'); // 5	Notas de Venta al contado A	20100917	NULL
  cbTipo.Items.Add('B'); // 6	Factura B	20100917	NULL
  cbTipo.Items.Add('B'); // 7	Nota de Débito B	20100917	NULL
  cbTipo.Items.Add('B'); // 8	Nota de Crédito B	20100917	NULL
  cbTipo.Items.Add('B'); // 9	Recibos B	20100917	NULL
  cbTipo.Items.Add('B'); // 10	Notas de Venta al contado B	20100917	NULL
  cbTipo.Items.Add('C'); // 11	Factura C	20110330	NULL
  cbTipo.Items.Add('C'); // 12	Nota de Débito C	20110330	NULL
  cbTipo.Items.Add('C'); // 13	Nota de Crédito C	20110330	NULL
  cbTipo.Items.Add('X'); // 14	REMITO
  cbTipo.Items.Add('P'); // 14	PRESUPUESTO
  cbTipo.Items.Add('A'); // 63	Liquidacion A	20100917	NULL
  cbTipo.Items.Add('B'); // 64	Liquidacion B	20100917	NULL
  cbTipo.Items.Add('A');
  // 34	Cbtes. A del Anexo I, Apartado A,inc.f),R.G.Nro. 1415	20100917	NULL
  cbTipo.Items.Add('B');
  // 35	Cbtes. B del Anexo I,Apartado A,inc. f),R.G. Nro. 1415	20100917	NULL
  cbTipo.Items.Add('A');
  // 39	Otros comprobantes A que cumplan con R.G.Nro. 1415	20100917	NULL
  cbTipo.Items.Add('B');
  // 40	Otros comprobantes B que cumplan con R.G.Nro. 1415	20100917	NULL
  cbTipo.Items.Add('A'); // 60	Cta de Vta y Liquido prod. A	20100917	NULL
  cbTipo.Items.Add('B'); // 61	Cta de Vta y Liquido prod. B	20100917	NULL
  cbTipo.Items.Add('C'); // 15	Recibo C	20110330	NULL
  cbTipo.Items.Add('C');
  // 49	Comprobante de Compra de Bienes Usados a Consumidor Final	20130904	NULL
  cbTipo.Items.Add('M'); // 51	Factura M	20150522	NULL
  cbTipo.Items.Add('M'); // 52	Nota de Débito M	20150522	NULL
  cbTipo.Items.Add('M'); // 53	Nota de Crédito M	20150522	NULL
  cbTipo.Items.Add('M'); // 54	Recibo M
  cbTipo.Items.Add('X'); //29
  dm.ConfigQuery.Open;
end;

procedure TOperacionForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then { if it's an enter key }
  begin
    Key := #0; { eat enter key }
    Perform(WM_NEXTDLGCTL, 0, 0); { move to next control }
  end;
end;

procedure TOperacionForm.CantidadBitBtnClick(Sender: TObject);
begin
  AgregarCantidadForm := TAgregarCantidadForm.Create(self);
  try
    AgregarCantidadForm.ShowModal;
  finally
    if AgregarCantidadForm.CantidadEdit.Text <> '' then
    begin

      // cantidad
      SGFact.Cells[3, SGFact.Row] := AgregarCantidadForm.CantidadEdit.Text;

      // total
      SGFact.Cells[5, SGFact.Row] :=
      Format('%8.2f', [StrToFloat(SGFact.Cells[4, SGFact.Row]) * StrToFloat(SGFact.Cells[3, SGFact.Row])]);

      // PRECIO DE COSTO
      SGFact.Cells[8, SGFact.Row] :=
        FloatToStr(StrToFloat(SGFact.Cells[8, SGFact.Row]) *
        StrToFloat(SGFact.Cells[3, SGFact.Row]));
      FEContado.Text:='0';
      CalculaTotales;
    end;
    AgregarCantidadForm.Free;
  end;
end;

procedure TOperacionForm.VendedorBitBtnClick(Sender: TObject);
begin
  BuscarVendedorForm := TBuscarVendedorForm.Create(self);
  try
    BuscarVendedorForm.ShowModal;
  finally
    VendedorEdit.Text := BuscarVendedorForm.Tabla.FieldByName('CODIGO')
      .AsString;
    VendedorLabel.Caption := BuscarVendedorForm.Tabla.FieldByName
      ('NOMBRE').AsString;
    Comision := BuscarVendedorForm.Tabla.FieldByName('COMISION').AsFloat;
    BuscarVendedorForm.Free;
  end;
end;

procedure TOperacionForm.TraerImpresora;
var
  i: Integer;
begin
  for i := 0 to Printer.Printers.Count - 1 do
    ComboBox1.Items.Add(Printer.Printers[i]);
end;

end.
