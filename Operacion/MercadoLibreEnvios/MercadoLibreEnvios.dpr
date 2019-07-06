program MercadoLibreEnvios;

uses
  System.StartUpCopy,
  FMX.Forms,
  uMercadoLibreEnvios in 'uMercadoLibreEnvios.pas' {Form1},
  udmMercadoLibre in '..\..\DataModule\udmMercadoLibre.pas' {dmML: TDataModule},
  RestDM in '..\..\DataModule\RestDM.pas' {DMR: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TdmML, dmML);
  Application.CreateForm(TDMR, DMR);
  Application.Run;
end.
