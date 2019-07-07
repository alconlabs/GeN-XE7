unit uMercadoLibreEnvios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons;

type
  TForm1 = class(TForm)
    BitBtn1: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses RestDM;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
  with dmr do
  begin
//    ObtenerConsultaRest('users/me?','');
    ObtenerOrderRecent;
//    AuthCodeEdit.Text := authCode;
//    AccessTokenEdit.Text := accessToken;
//    RefreshTokenEdit.Text := refreshToken;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  DMR := TDMR.Create(self);
end;

end.
