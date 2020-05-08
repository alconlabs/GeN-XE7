unit UFProductos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DataModule, Grids, DBGrids, DB, ExtCtrls, StdCtrls, Mask,
  DBCtrls, Buttons, ComCtrls, OleCtrls, SHDocVw, IBX.IBQuery,
  IBX.IBCustomDataSet, IBX.IBTable, Vcl.Imaging.jpeg, OperacionDM
  ,Math, Vcl.ExtDlgs;

const
  EAN_izqA: array [0 .. 9] of PChar = ('0001101', '0011001', '0010011',
    '0111101', '0100011', '0110001', '0101111', '0111011', '0110111',
    '0001011');
  EAN_izqB: array [0 .. 9] of PChar = ('0100111', '0110011', '0011011',
    '0100001', '0011101', '0111001', '0000101', '0010001', '0001001',
    '0010111');
  EAN_dcha: array [0 .. 9] of PChar = ('1110010', '1100110', '1101100',
    '1000010', '1011100', '1001110', '1010000', '1000100', '1001000',
    '1110100');
  CodificaIzq: array [0 .. 9] of PChar = ('AAAAA', 'ABABB', 'ABBAB', 'ABBBA',
    'BAABB', 'BBAAB', 'BBBAA', 'BABAB', 'BABBA', 'BBABA');

type
  TFProductos = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet3: TTabSheet;
    Panel3: TPanel;
    SaveBitBtn: TBitBtn;
    NoBitBtn: TBitBtn;
    DescripcionLabel: TLabel;
    CantidadLabel: TLabel;
    ProveedorLabel: TLabel;
    DescripcionDBEdit: TDBEdit;
    CantidadDBEdit: TDBEdit;
    ProveedorDBLookupComboBox: TDBLookupComboBox;
    IVADBCBLabel: TLabel;
    FleteLabel: TLabel;
    CostoLabel: TLabel;
    FleteDBEdit: TDBEdit;
    CostoDBEdit: TDBEdit;
    NetoLabel: TLabel;
    NetoDBEdit: TDBEdit;
    DesLargaDBMemo: TDBMemo;
    TabSheet2: TTabSheet;
    GanaciaLabel: TLabel;
    GanaciaDBEdit: TDBEdit;
    TabSheet4: TTabSheet;
    Precio5Label: TLabel;
    Precio1Label: TLabel;
    Precio2Label: TLabel;
    Precio6Label: TLabel;
    Precio3Label: TLabel;
    Precio4Label: TLabel;
    Precio1DBEdit: TDBEdit;
    Precio2DBEdit: TDBEdit;
    Precio3DBEdit: TDBEdit;
    Precio6DBEdit: TDBEdit;
    Precio4DBEdit: TDBEdit;
    Precio5DBEdit: TDBEdit;
    TabSheet5: TTabSheet;
    CuentaLabel: TLabel;
    CuentaDBLookupComboBox: TDBLookupComboBox;
    TipoDBLookupComboBox: TDBLookupComboBox;
    IIBBDBLookupComboBox: TDBLookupComboBox;
    AnticipoDBLookupComboBox: TDBLookupComboBox;
    AnticipoLabel: TLabel;
    IIBBLabel: TLabel;
    TipoLabel: TLabel;
    Label1: TLabel;
    CodigoDBEdit: TDBEdit;
    BitBtn4: TBitBtn;
    IVADBComboBox: TDBLookupComboBox;
    ButtonPanel: TPanel;
    DBNavigator1: TDBNavigator;
    bImportar: TButton;
    bExportar: TButton;
    OpenPictureDialog1: TOpenPictureDialog;
    NotasDBEdit: TDBEdit;
    CodigoBarraPaintBox: TImage;
    CostoFleteDBText: TDBText;
    CostoFleteLabel: TLabel;
    IVADBTLabel: TLabel;
    IVADBText: TDBText;
    OtrosDerechoPanel: TPanel;
    OtrosIzquierdoPanel: TPanel;
    ReservaDBComboBox: TDBComboBox;
    ReservaLabel: TLabel;
    FechaCompUltDBEdit: TDBEdit;
    Label20: TLabel;
    StockVendidoDBEdit: TDBEdit;
    StockVendidoLabel: TLabel;
    DBEditStockMaximo: TDBEdit;
    StockMaximoLabel: TLabel;
    StockMinimoDBEdit: TDBEdit;
    StockMinimoLabel: TLabel;
    ProcedenciaDBEdit: TDBEdit;
    Label32: TLabel;
    UbicacionDBEdit: TDBEdit;
    UbicacionLabel: TLabel;
    UnidadDBEdit: TDBEdit;
    Label9: TLabel;
    RubroLabel: TLabel;
    MarcaLabel: TLabel;
    CategoriaLabel: TLabel;
    StockLabel: TLabel;
    Image1: TImage;
    ImagenLabel: TLabel;
    CodigoBarraLabel: TLabel;
    RubroDBLookupComboBox: TDBLookupComboBox;
    MarcaDBLookupComboBox: TDBLookupComboBox;
    CategoriaDBLookupComboBox: TDBLookupComboBox;
    StockDBEdit: TDBEdit;
    CodigoBarraEdit: TDBEdit;
    IndividualCheckBox: TCheckBox;
    procedure SaveBitBtnClick(Sender: TObject);
    procedure NoBitBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure CodigoBarraBitBtnClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Precio6DBEditExit(Sender: TObject);
    procedure DBEdit14Exit(Sender: TObject);
    procedure MarcaDBLookupComboBoxKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ProveedorDBLookupComboBoxEnter(Sender: TObject);
    procedure CategoriaDBLookupComboBoxEnter(Sender: TObject);
    procedure RubroDBLookupComboBoxEnter(Sender: TObject);
    procedure MarcaDBLookupComboBoxEnter(Sender: TObject);
    procedure CodigoBarraPaintBoxClick(Sender: TObject);
    procedure NetoDBEditExit(Sender: TObject);
    procedure IVADBComboBoxExit(Sender: TObject);
    procedure GanaciaDBEditExit(Sender: TObject);
    procedure IVADBComboBoxEnter(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure bImportarClick(Sender: TObject);
    procedure bExportarClick(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure DBNavigator1Click(Sender: TObject; Button: TNavigateBtn);
    procedure CodigoBarraLabelClick(Sender: TObject);
  private
    { Private declarations }
    iip:string;
    tasa: Double;
    procedure Calcular;
    procedure Save;
    procedure GetImage;
    procedure GetIndividual;
    procedure GetArticulo;
    procedure Load;
  public
    desc: string;
    { Public declarations }
    // procedimiento que codifica el número en un nº binario
    procedure Codifica(num: string);
    // procedimiento para dibujar el cód. de barras a partir del nº binario
    procedure Dibujar(matrix: string);
    // procedimiento para validar-corregir los códigos
    procedure EANCorrecto(var num: string);
    Procedure nuevo;
  end;

var
  FProductos: TFProductos;

implementation

uses UFBuscaArticulos;

{$R *.dfm}

procedure TFProductos.EANCorrecto(var num: string);
var
  i, N: byte;
  sum: integer;
  flag: byte;
begin
  sum := 0;
  N := Length(num) - 1; // 13-1=12
  for i := 1 to N do // desde 1 hasta 12
  begin
    if (i mod 2) = 0 then // x mod y = x – (x div y) * y = 1-(0.5)*2
    begin
      if N = 12 then
        sum := sum + StrToInt(num[i]) * 3
      else
        sum := sum + StrToInt(num[i]);
    end
    else
    begin
      if N = 12 then
        sum := sum + StrToInt(num[i])
      else
        sum := sum + StrToInt(num[i]) * 3;
    end;
  end;
  if sum > 99 then
    flag := 10 - (sum mod 100)
  else
    flag := 10 - (sum mod 10);
  if flag = 10 then
    flag := 0;
  if not(StrToInt(num[N + 1]) = flag) then
    num := copy(num, 1, Length(num) - 1) + IntToStr(flag);
end;

procedure TFProductos.Codifica(num: string);
var
  matrix: string;
  i: integer;
begin
  num := CodigoBarraEdit.Text; // numero
  matrix := '';
  case Length(num) of // mientras sean 13 caracteres
    13:
      begin
        EANCorrecto(num); //
        CodigoBarraEdit.Text := num;
        matrix := matrix + 'x0x'; // barra inicio
        matrix := matrix + EAN_izqA[StrToInt(num[2])];
        for i := 3 to 7 do
          if CodificaIzq[StrToInt(num[1])][i - 3] = 'A' then
            matrix := matrix + EAN_izqA[StrToInt(num[i])]
          else
            matrix := matrix + EAN_izqB[StrToInt(num[i])];
        matrix := matrix + '0x0x0'; // barra central
        matrix := matrix + EAN_dcha[StrToInt(num[8])];
        matrix := matrix + EAN_dcha[StrToInt(num[9])];
        matrix := matrix + EAN_dcha[StrToInt(num[10])];
        matrix := matrix + EAN_dcha[StrToInt(num[11])];
        matrix := matrix + EAN_dcha[StrToInt(num[12])];
        matrix := matrix + EAN_dcha[StrToInt(num[13])];
        matrix := matrix + 'x0x'; // barra final
//        Dibujar(matrix);
        CodigoBarraPaintBox.Visible:=True;
      end;
    8:
      begin
        EANCorrecto(num);
        CodigoBarraEdit.Text := num;
        matrix := matrix + 'x0x';
        matrix := matrix + EAN_izqA[StrToInt(num[1])];
        matrix := matrix + EAN_izqA[StrToInt(num[2])];
        matrix := matrix + EAN_izqA[StrToInt(num[3])];
        matrix := matrix + EAN_izqA[StrToInt(num[4])];
        matrix := matrix + '0x0x0';
        matrix := matrix + EAN_dcha[StrToInt(num[5])];
        matrix := matrix + EAN_dcha[StrToInt(num[6])];
        matrix := matrix + EAN_dcha[StrToInt(num[7])];
        matrix := matrix + EAN_dcha[StrToInt(num[8])];
        matrix := matrix + 'x0x';
//        Dibujar(matrix);
        CodigoBarraPaintBox.Visible:=True;
      end
  else
//    ShowMessage('LONGITUD DE CODIGO NO VALIDA');
    CodigoBarraPaintBox.Visible:=False;
  end;
end;

procedure TFProductos.Dibujar(matrix: string);
var
  i: integer;
begin
  with CodigoBarraPaintBox do
  begin
    Canvas.Brush.Color := clWhite;
    Canvas.FillRect(Rect(0, 0, CodigoBarraPaintBox.Width, CodigoBarraPaintBox.Height));
    Canvas.Pen.Color := clBlack;
  end;
  for i := 1 to Length(matrix) do
    if matrix[i] = '1' then
      CodigoBarraPaintBox.Canvas.PolyLine([Point(10 + i, 10), Point(10 + i, 50)])
    else if matrix[i] = 'x' then
      CodigoBarraPaintBox.Canvas.PolyLine([Point(10 + i, 10), Point(10 + i, 55)]);
  if Length(CodigoBarraEdit.Text) = 13 then
  begin
    CodigoBarraPaintBox.Canvas.TextOut(3, 50, CodigoBarraEdit.Text[1]);
    CodigoBarraPaintBox.Canvas.TextOut(17, 50, copy(CodigoBarraEdit.Text, 2, 6));
    CodigoBarraPaintBox.Canvas.TextOut(63, 50, copy(CodigoBarraEdit.Text, 8, 6));
  end
  else if Length(CodigoBarraEdit.Text) = 8 then
  begin
    CodigoBarraPaintBox.Canvas.TextOut(16, 50, copy(CodigoBarraEdit.Text, 1, 4));
    CodigoBarraPaintBox.Canvas.TextOut(48, 50, copy(CodigoBarraEdit.Text, 5, 4));
  end;
end;

procedure TFProductos.SaveBitBtnClick(Sender: TObject);
begin
  Save;
end;

procedure TFProductos.NoBitBtnClick(Sender: TObject);
begin
  dm.tArticulo.Cancel;
  Close;
end;

procedure TFProductos.Load;
begin
  with dm do
  begin
    // DM := TDM.Create(Self);
    tArticulo.Active := True;
    tSubCategoria.Active := True;
    tProveedor.Active := True;
    tRubro.Active := True;
    tMarca.Active := True;
    tCategoria.Active := True;
    tIVA.Active := True;
    tCuenta.Active := True;
  //    ConfigQuery.Open;
  //    TraerConfig;
  //    Precio1 := ConfigQuery.FieldByName('PP1').AsFloat / 100 + 1;
  //    Precio2 := ConfigQuery.FieldByName('PP2').AsFloat / 100 + 1;
  //    Precio3 := ConfigQuery.FieldByName('PP3').AsFloat / 100 + 1;
  //    Precio4 := ConfigQuery.FieldByName('PP4').AsFloat / 100 + 1;
  //    Precio5 := ConfigQuery.FieldByName('PP5').AsFloat / 100 + 1;
  //    Precio6 := ConfigQuery.FieldByName('PP6').AsFloat / 100 + 1;
  //    PrecioCtaCte := ConfigQuery.FieldByName('PP').AsFloat / 100 + 1;
//      QTemp.Close;
  end;
    if catIVA = 'Responsable Inscripto' then
    begin
      IVADBCBLabel.Visible:=True;
      IVADBComboBox.Visible:=True;
      IVADBText.Visible:=True;
      IVADBTLabel.Visible:=True;
    end;
    //tArticulo.Insert;
//    nuevo;
  PageControl1.ActivePageIndex := 0;
end;

procedure TFProductos.FormCreate(Sender: TObject);
begin
  Load;
end;

procedure TFProductos.FormDestroy(Sender: TObject);
begin
  with dm do begin
    tArticulo.Active := False;
    tSubCategoria.Active := False;
    tProveedor.Active := False;
    tRubro.Active := False;
    tMarca.Active := False;
    tCategoria.Active := False;
    tIVA.Active := False;
    QTemp.Active := False;
    tCuenta.Active := False;
  end;
end;

procedure TFProductos.BitBtn4Click(Sender: TObject);
begin
  with dm do
  begin
    TabSheet1.PageControl.ActivePageIndex := 0;
    dm.tArticulo.Cancel;
    FBuscaArticulo := TFBuscaArticulo.Create(Self);
    try
      FBuscaArticulo.ShowModal;
    finally
      If dm.qArticulo.Active = True then
        dm.tArticulo.Locate('CODIGO', dm.qArticulo.FieldByName('CODIGO').AsInteger, []);
      FBuscaArticulo.Free;
    end;
    dm.tArticulo.Edit;
    GetArticulo;
  end;
end;

procedure TFProductos.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then { if it's an enter key }
  begin
    Key := #0; { eat enter key }
    Perform(WM_NEXTDLGCTL, 0, 0); { move to next control }
  end;
end;

procedure TFProductos.Image1Click(Sender: TObject);
begin
  OpenPictureDialog1.Execute();
  if OpenPictureDialog1.FileName<>'' then Image1.Picture.LoadFromFile(OpenPictureDialog1.FileName);
end;

procedure TFProductos.IVADBComboBoxEnter(Sender: TObject);
begin
with dm do begin
  with tIVA do
  begin
    Close;
    Open;
    Last;
  end;
end;
end;

procedure TFProductos.IVADBComboBoxExit(Sender: TObject);
var
  t:string;
begin
  with dm do begin
  //if IVADBComboBox.Text = '105' then tasa:=StrToFloat(IVADBComboBox.Text)/10
  //  else
    if IVADBComboBox.Text='' then tasa:=21
    else tasa:=StrToFloat(IVADBComboBox.Text);
//    if tasa=10.5 then t:='105' else t:=FloatToStr(tasa);
    if tasa<100 then t:=FloatToStr(tasa*10) else t:=FloatToStr(tasa);
    tArticulo.FieldByName('IVA').AsInteger := StrToInt(t);
  end;
end;

Procedure TFProductos.nuevo;
begin
  iip := '';
  Image1.Picture := nil;
//  IVADBEdit.Field.AsFloat := 0;
//  CodigoDBEdit.Text:=IntToStr(DM.UltimoRegistro('Articulo', 'CODIGO'));
//  CostoDBEdit.Field.AsFloat := 0;
//  FleteDBEdit.Field.AsFloat := 0;
//  PrecioCtaCteDBEdit.Field.AsFloat := 0;
end;

procedure TFProductos.RubroDBLookupComboBoxEnter(Sender: TObject);
begin
  dm.tRubro.Close;
  dm.tRubro.Open;
  dm.tRubro.Last;
end;

procedure TFProductos.Save;
begin
  with dm do
  begin
    desc := CodigoDBEdit.Text;
    // guardar imagen
    if (Image1.Picture.Graphic <> nil) then Image1.Picture.SaveToFile(iip);
    if (tArticulo.State = dsEdit) or (tArticulo.State = dsInsert) then
    if ((DescripcionDBEdit.Text<>'') and (CantidadDBEdit.Text<>'') and (CostoDBEdit.Text<>'') and (NetoDBEdit.Text<>'')) then
     begin
      if (ReservaDBComboBox.Text = '') then tArticulo.FieldByName('RESERVA').AsString := 'no';
      tArticulo.FieldByName('INDIVIDUAL').AsInteger := IndividualCheckBox.Checked.ToInteger;
      tArticulo.Post;
      if (wpSync) then WooCommerceGeN(desc);
      if Dialogs.MessageDlg('Articulo grabado con éxito.  Salir?', mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrYes then
        Close
      else
        Load;
      end
     else
      ShowMessage('COMPLETE TODOS LOS CAMPOS');
  end;
end;

procedure TFProductos.CodigoBarraBitBtnClick(Sender: TObject);
var
  i: integer;
begin
with dm do begin
  if dm.tArticulo.State = dsInsert then
  begin
    QTemp.Close;
    QTemp.SQL.Text := 'SELECT max(CODIGO) FROM "Articulo"';
    QTemp.Open;
    i := 1000000000 + (QTemp.Fields.Fields[0].AsInteger + 1);
    // agrego el codigo
  end
  else
  begin
    i := 1000000000 + StrToInt(CodigoDBEdit.Text);
    IF (dm.tArticulo.State <> dsEdit) then
      dm.tArticulo.Edit;
  end;
  // codigo de barras
  CodigoBarraEdit.Text := '10' + IntToStr(i) + '2';
  // lo incluyo en el codigo de barra
  Codifica(CodigoBarraEdit.Text);
  CodigoBarraEdit.SelStart := 0;
  CodigoBarraEdit.SelLength := Length(CodigoBarraEdit.Text);
  dm.tArticulo.FieldByName('CodigoBarra').AsString := CodigoBarraEdit.Text;
end;
end;

procedure TFProductos.CodigoBarraLabelClick(Sender: TObject);
var
  i: integer;
begin
with dm do begin
  if dm.tArticulo.State = dsInsert then
  begin
    QTemp.Close;
    QTemp.SQL.Text := 'SELECT max(CODIGO) FROM "Articulo"';
    QTemp.Open;
    i := 1000000000 + (QTemp.Fields.Fields[0].AsInteger + 1);
    // agrego el codigo
  end
  else
  begin
    i := 1000000000 + StrToInt(CodigoDBEdit.Text);
    IF (dm.tArticulo.State <> dsEdit) then
      dm.tArticulo.Edit;
  end;
  // codigo de barras
  CodigoBarraEdit.Text := '10' + IntToStr(i) + '2';
  // lo incluyo en el codigo de barra
  Codifica(CodigoBarraEdit.Text);
  CodigoBarraEdit.SelStart := 0;
  CodigoBarraEdit.SelLength := Length(CodigoBarraEdit.Text);
  dm.tArticulo.FieldByName('CodigoBarra').AsString := CodigoBarraEdit.Text;
end;
end;

procedure TFProductos.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  IF Key = VK_F2 then
    //RubroBitBtn.Click;
  IF Key = VK_F3 then
    //MarcaBitBtn.Click;
  IF Key = VK_F4 then
    //ProveedorLabel.Click;
  IF Key = VK_F5 then
    BitBtn4.Click;
  IF Key = VK_F6 then
    CodigoBarraLabelClick(Sender);
end;

procedure TFProductos.GanaciaDBEditExit(Sender: TObject);
begin
  Calcular;
  SaveBitBtn.SetFocus;
end;

procedure TFProductos.GetArticulo;
begin
  GetImage;
  GetIndividual;
  Codifica(CodigoBarraEdit.Text);
end;

procedure TFProductos.GetImage;
begin
  iip := '';
  Image1.Picture := nil;
  iip := DM.GetImgItemPath(CodigoDBEdit.Text);
  if (FileExists(iip)) then Image1.Picture.LoadFromFile(iip);
end;

procedure TFProductos.GetIndividual;
begin
  IndividualCheckBox.Checked := (dm.tArticulo.FieldByName('INDIVIDUAL').AsInteger > 0);
end;

procedure TFProductos.CodigoBarraPaintBoxClick(Sender: TObject);
begin
  OperacionDataModule := TOperacionDataModule.Create(Self);
  with OperacionDataModule do
  begin
    CodigoBarra(CodigoBarraEdit.Text);
  end;
  OperacionDataModule.Free;
end;

procedure TFProductos.Precio6DBEditExit(Sender: TObject);
begin
//  IVADBEdit.SetFocus;
end;

procedure TFProductos.NetoDBEditExit(Sender: TObject);
begin
//  c := StrToFloat(CostoDBEdit.Text);
//  f := (c * (StrToFloat(FleteDBEdit.Text) / 100));
//  c := c+f;
//  p := StrToFloat(PrecioCtaCteDBEdit.Text);
//  g := RoundTo(((p*100)/c)-100,-2);
  GanaciaDBEdit.Text:=FloatToStr(DM.CalculaGanancia(StrToFloat(CostoDBEdit.Text),StrToFloat(FleteDBEdit.Text),StrToFloat(NetoDBEdit.Text)));
  Calcular;
  SaveBitBtn.SetFocus;
end;



procedure TFProductos.CategoriaDBLookupComboBoxEnter(Sender: TObject);
begin
  with dm do
  begin
    tCategoria.Close;
    tCategoria.Open;
    tCategoria.Last;
  end;
end;

procedure TFProductos.MarcaDBLookupComboBoxEnter(Sender: TObject);
begin
  dm.tMarca.Close;
  dm.tMarca.Open;
  dm.tMarca.Last;
end;

procedure TFProductos.MarcaDBLookupComboBoxKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  dm.tMarca.Close;
  dm.tMarca.Open;
  dm.tMarca.Last;
end;

procedure TFProductos.DBEdit14Exit(Sender: TObject);
begin
  SaveBitBtn.SetFocus;
end;

procedure TFProductos.ProveedorDBLookupComboBoxEnter(Sender: TObject);
begin
  dm.tProveedor.Close;
  dm.tProveedor.Open;
  dm.tProveedor.Last;
end;

procedure TFProductos.DBNavigator1Click(Sender: TObject; Button: TNavigateBtn);
begin
  case Button of
    nbFirst : GetArticulo;
    nbPrior : GetArticulo;
    nbNext : GetArticulo;
    nbLast : GetArticulo;
    nbInsert : nuevo;
//    nbDelete : nuevo;
//    nbEdit : BtnName := 'nbEdit';
//    nbPost : Save;
    nbCancel : GetArticulo;
//    nbRefresh: GetImage;
  end;
end;

procedure TFProductos.bExportarClick(Sender: TObject);
begin
  with dm do
  begin
    tProveedor.Cancel;
    ExportarTabla('Articulo');
  end;
  ShowMessage('Exportación Finalizada!');
  Close;
end;

procedure TFProductos.bImportarClick(Sender: TObject);
begin
  with dm do
  begin
    tArticulo.Cancel;
    tArticulo.Active := False;
    tSubCategoria.Active := False;
    tProveedor.Active := False;
    tRubro.Active := False;
    tMarca.Active := False;
    tCategoria.Active := False;
    tIVA.Active := False;
    tCuenta.Active:=False;
    ImportarCsv('Articulo');//ImportarTabla('Articulo');
  end;
  ShowMessage('Importación Finalizada!');
  Close;
end;

procedure TFProductos.Calcular;
var
  costo, neto, flete: Double;
begin
  if CostoDBEdit.Text = '' then CostoDBEdit.Text := '0';
  if FleteDBEdit.Text = '' then FleteDBEdit.Text := '0';
  if GanaciaDBEdit.Text = '' then GanaciaDBEdit.Text := '0';
  costo := StrToFloat(CostoDBEdit.Text);
  flete := costo * (StrToFloat(FleteDBEdit.Text) / 100);
  costo := costo + flete;
  with DM do
  begin
   if GanaciaDBEdit.Text = '0' then
     NetoDBEdit.Text := FloatToStr(RoundTo((costo * PrecioCtaCte),-2))
   else
    NetoDBEdit.Text := FloatToStr( RoundTo((costo * (StrToFloat(GanaciaDBEdit.Text) / 100 + 1)),-2));
   Precio1DBEdit.Text := FloatToStr(RoundTo((costo * Precio1),-2));
   Precio2DBEdit.Text := FloatToStr(RoundTo((costo * Precio2),-2));
   Precio3DBEdit.Text := FloatToStr(RoundTo((costo * Precio3),-2));
   Precio4DBEdit.Text := FloatToStr(RoundTo((costo * Precio4),-2));
   Precio5DBEdit.Text := FloatToStr(RoundTo((costo * Precio5),-2));
   Precio6DBEdit.Text := FloatToStr(RoundTo((costo * Precio6),-2));
   CostoFleteDBText.Caption := FloatToStr(RoundTo(( costo ),-2));
   neto:=RoundTo((StrToFloat(NetoDBEdit.Text)),-2);
   tasa:=RoundTo((StrToFloat(dm.TraerValor('Iva', 'TASA', VarToStr(IVADBComboBox.KeyValue)))),-2);
   IVADBText.Caption := FloatToStr(RoundTo((CalcularIVA(neto,tasa)),-2));
  end;
end;

end.
