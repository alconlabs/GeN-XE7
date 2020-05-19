unit UFCategorias;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DataModule, StdCtrls, Buttons, ExtCtrls, DBCtrls, Grids, DBGrids, DB,
  Mask, OleCtrls, SHDocVw, IBX.IBCustomDataSet, IBX.IBTable, Vcl.Imaging.jpeg,
  Vcl.ExtDlgs, Vcl.ComCtrls, System.StrUtils, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TFCategorias = class(TForm)
    DescripcionLabel: TLabel;
    DescripcionDBEdit: TDBEdit;
    DBNavigator1: TDBNavigator;
    DerechoPanel: TPanel;
    Label2: TLabel;
    SaveBitBtn: TBitBtn;
    NoBitBtn: TBitBtn;
    CodigoDBEdit: TDBEdit;
    PadreDBLookupComboBox: TDBLookupComboBox;
    DBGrid1: TDBGrid;
    PadreLabel: TLabel;
    Image1: TImage;
    ImagenLabel: TLabel;
    VisualizarDBComboBox: TDBComboBox;
    OrdenDBComboBox: TDBComboBox;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    HtmlDBMemo: TDBMemo;
    HtmlLabel: TLabel;
    VisualizarLabel: TLabel;
    OrdenLabel: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SaveBitBtnClick(Sender: TObject);
    procedure PadreDBLookupComboBoxEnter(Sender: TObject);
    procedure NoBitBtnClick(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure DBNavigator1Click(Sender: TObject; Button: TNavigateBtn);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    _imagen :string;
    procedure Obtener;
    procedure Nuevo;
    procedure Grabar;
    procedure Cargar;
  public
    { Public declarations }
    tabla,desc :string;
  end;

var
  FCategorias: TFCategorias;

implementation

{$R *.dfm}

procedure TFCategorias.FormShow(Sender: TObject);
begin
  if (tabla='') then tabla:='Categoria';
  Cargar;
end;

procedure TFCategorias.Cargar;
begin
  FCategorias.Caption := tabla;
  with dm do
  begin
    if tablaFDTable.Active then tablaFDTable.Active := False;
    if tabla1FDTable.Active then tabla1FDTable.Active := False;
    tablaFDTable.TableName := '"'+tabla+'"';
    tablaFDTable.Active := True;
    case IndexStr(tabla, ['Categoria', 'Subcategoria']) of
    0 : tabla1FDTable.TableName := '"Rubro"';
    1 : tabla1FDTable.TableName := '"Categoria"';
    else
      begin
        PadreDBLookupComboBox.Visible:=False;
        PadreLabel.Visible:=False;
      end;
    end;
    if (tabla1FDTable.TableName<>'') then tabla1FDTable.Active := True;
  end;
  PageControl1.TabIndex:=0;
  Obtener;
end;

procedure TFCategorias.DBGrid1CellClick(Column: TColumn);
begin
  Obtener;
end;

procedure TFCategorias.DBNavigator1Click(Sender: TObject; Button: TNavigateBtn);
begin
  case Button of
    nbFirst : Obtener;
    nbPrior : Obtener;
    nbNext : Obtener;
    nbLast : Obtener;
    nbInsert : Nuevo;
//    nbDelete : nuevo;
//    nbEdit : Edit;
//    nbPost : Grabar;
//    nbCancel : Cancel;
//    nbRefresh: Obtener;
  end;
  DescripcionDBEdit.SetFocus;
end;

procedure TFCategorias.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  with dm do
  begin
    tablaFDTable.Active := False;
    with tabla1FDTable do if Active then Active := False;
  end;
end;

procedure TFCategorias.Grabar;
begin
  desc := DescripcionDBEdit.Text;
  if (desc <> '') then
  with DM do
  with tablaFDTable do
    if (State = dsEdit) or (State = dsInsert) then
    begin
      // guardar imagen
      if ((_imagen<>'') and (Image1.Picture.Graphic <> nil)) then Image1.Picture.SaveToFile(_imagen);
      //
      Post;
      if (wpSync) then WooCommerceGeN('Categoria', desc);
      if Dialogs.MessageDlg('Grabado con éxito.  Salir?', mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrYes then
        FCategorias.Close
      else
        Cargar;
    end
  else
    ShowMessage('COMPLETE TODOS LOS CAMPOS');
end;

procedure TFCategorias.Image1Click(Sender: TObject);
begin
  Image1.Picture.LoadFromFile(dm.AbrirImagen)
end;

procedure TFCategorias.NoBitBtnClick(Sender: TObject);
begin
  dm.tablaFDTable.Cancel;
  Close;
end;

procedure TFCategorias.PadreDBLookupComboBoxEnter(Sender: TObject);
begin
  dm.RefrescarTabla1;
end;

procedure TFCategorias.SaveBitBtnClick(Sender: TObject);
begin
  Grabar;
end;

procedure TFCategorias.Obtener;
begin
  //imagen
  _imagen := '';
  Image1.Picture := nil;
  _imagen := DM.ObtenerImagenDirectorio(tabla,CodigoDBEdit.Text);
  if (FileExists(_imagen)) then Image1.Picture.LoadFromFile(_imagen);
end;

Procedure TFCategorias.Nuevo;
begin
  CodigoDBEdit.Text := IntToStr(DM.SiguienteCodigo(tabla));
  Obtener;
end;

end.
