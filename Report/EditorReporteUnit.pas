unit EditorReporteUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.UI.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Comp.DataSet, frxClass, frxExportCSV, frxDBSet, frxExportBaseDialog,
  frxExportPDF, frxBarcode, IBX.IBCustomDataSet, IBX.IBQuery, IBX.IBDatabase;

type
  TForm1 = class(TForm)
    frxBarCodeObject1: TfrxBarCodeObject;
    frxPDFExport1: TfrxPDFExport;
    frxDBDataset1: TfrxDBDataset;
    frxCSVExport1: TfrxCSVExport;
    frxReport1: TfrxReport;
    VentasFDQuery1: TFDQuery;
    FDQuery1: TFDQuery;
    FirebirdConnection: TFDConnection;
    IBDatabase1: TIBDatabase;
    IBQuery1: TIBQuery;
    IBTransaction1: TIBTransaction;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

end.
