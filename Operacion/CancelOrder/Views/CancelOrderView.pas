unit CancelOrderView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, CancelOrderViewModel;

type
  TFCancelOrderView = class(TForm)
    RightPanel: TPanel;
    TopPanel: TPanel;
    yesBitBtn: TBitBtn;
    NoBitBtn: TBitBtn;
    findBitBtn: TBitBtn;
    ClientPanel: TPanel;
    nroEdit: TEdit;
    LetterLabel: TLabel;
    TitleLabel: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure findBitBtnClick(Sender: TObject);
    procedure yesBitBtnClick(Sender: TObject);
    procedure NoBitBtnClick(Sender: TObject);
  private
    { Private declarations }
    FCancelOrderViewModel: TCancelOrderViewModel;
  public
    { Public declarations }
    tipo : string;
  end;

var
  FCancelOrderView: TFCancelOrderView;

implementation

{$R *.dfm}

procedure TFCancelOrderView.findBitBtnClick(Sender: TObject);
begin
  with FCancelOrderViewModel do
  begin
    Tipo := Self.tipo;
    FindButton;
    nroEdit.Text := Codigo;
  end;
end;

procedure TFCancelOrderView.FormCreate(Sender: TObject);
begin
  FCancelOrderViewModel := TCancelOrderViewModel.Create;
end;

procedure TFCancelOrderView.FormDestroy(Sender: TObject);
begin
  FCancelOrderViewModel.Free;
end;

procedure TFCancelOrderView.NoBitBtnClick(Sender: TObject);
begin
  Close;
end;

procedure TFCancelOrderView.yesBitBtnClick(Sender: TObject);
begin
  FCancelOrderViewModel.YesButton(nroEdit.Text,tipo);
  Close;
end;

end.
