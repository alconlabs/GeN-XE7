program MercadoLibreEnvios;

uses
  Vcl.Forms,
  uMercadoLibreEnvios in 'uMercadoLibreEnvios.pas' {Form1},
  RestDM in '..\..\DataModule\RestDM.pas' {DMR: TDataModule},
  udmMercadoLibre in '..\..\DataModule\udmMercadoLibre.pas' {dmML: TDataModule},
  OperacionDM in '..\..\DataModule\OperacionDM.pas' {OperacionDataModule: TDataModule},
  DataModule in '..\..\DataModule\DataModule.pas' {DM: TDataModule},
  ImprimirDM in '..\..\DataModule\ImprimirDM.pas' {ImprimirDataModule: TDataModule},
  AfipDM in '..\..\DataModule\AfipDM.pas' {AfipDataModule: TDataModule},
  service in '..\..\DataModule\service.pas',
  LoginCms1 in '..\..\DataModule\LoginCms1.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
