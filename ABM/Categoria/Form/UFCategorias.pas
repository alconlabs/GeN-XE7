unit UFCategorias;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DataModule, StdCtrls, Buttons, ExtCtrls, DBCtrls, Grids, DBGrids, DB,
  Mask, OleCtrls, SHDocVw, IBX.IBCustomDataSet, IBX.IBTable;

type
  TFCategorias = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    BitBtn1: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tCategoriaAfterCancel(DataSet: TDataSet);
    procedure tCategoriaAfterDelete(DataSet: TDataSet);
    procedure tCategoriaAfterPost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    desc: string;
    { Public declarations }
  end;

var
  FCategorias: TFCategorias;

implementation

{$R *.dfm}

procedure TFCategorias.FormCreate(Sender: TObject);
begin
  // DM := TDM.Create(Self);
  dm.tCategoria.Active := true;
end;

procedure TFCategorias.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  dm.tCategoria.Active := false;
end;

procedure TFCategorias.BitBtn1Click(Sender: TObject);
begin
  desc := DBEdit1.Text;
  If (dm.tCategoria.State = dsEdit) or (dm.tCategoria.State = dsInsert) then
    If DBEdit1.Text <> '' then
    begin
      dm.tCategoria.Post;
    end;
  Close;
end;

procedure TFCategorias.FormShow(Sender: TObject);
begin
  dm.tCategoria.Insert;
end;

procedure TFCategorias.tCategoriaAfterCancel(DataSet: TDataSet);
begin
  dm.tCategoria.Transaction.RollbackRetaining;
end;

procedure TFCategorias.tCategoriaAfterDelete(DataSet: TDataSet);
begin
  dm.tCategoria.Transaction.CommitRetaining;
end;

procedure TFCategorias.tCategoriaAfterPost(DataSet: TDataSet);
begin
  dm.tCategoria.Transaction.CommitRetaining;
end;

end.
