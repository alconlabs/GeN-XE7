unit VaciarBaseF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, IniFiles, IBX.IBScript, DataModule;

type
  TVaciarBaseForm = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ListBox1: TListBox;
    Label4: TLabel;
    Borrar: TIBScript;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  VaciarBaseForm: TVaciarBaseForm;

implementation

{$R *.dfm}

procedure TVaciarBaseForm.BitBtn1Click(Sender: TObject);
Var
  IniFile: TIniFile;
  // Path, BaseDeDatos: string;
begin
  IniFile := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'DeG');
  FormatSettings.ShortDateFormat := 'mm/dd/yyyy';
  // Obtiene la ruta y el nombre de la base de datos
  if Path = '' then
  begin
    Path := IniFile.ReadString('BD', 'Path', '');
  end;
  if Path = '' then
    Path := ExtractFilePath(Application.ExeName);
  if BaseDeDatos = '' then
    BaseDeDatos := IniFile.ReadString('BD', 'DBase', '');
  if BaseDeDatos = '' then
    BaseDeDatos := Path + 'GeN.FDB';
  if BaseDeDatos = '' then
    ShowMessage('Error al cargar Base de Datos')
  else
  begin
    Borrar.Script.Text := 'SET NAMES WIN1252; CONNECT ' + quotedstr(BaseDeDatos)
      + ' USER ''SYSDBA'' PASSWORD ''masterkey''; ' + Borrar.Script.Text;
    Borrar.ExecuteScript;
    ShowMessage('Base de Datos Restaurada con éxito!!!');
  end;
  IniFile.WriteString('WEB', 'URL', '');
  IniFile.WriteString('WEB', 'RES', '');
  IniFile.WriteString('WEB', 'USR', '');
  IniFile.WriteString('WEB', 'PSW', '');
  // IniFile.WriteString('Licencia', 'Dia', inttostr(1));
  // IniFile.WriteString('Licencia', 'Fecha', datetostr(date));
  IniFile.Destroy;
end;

procedure TVaciarBaseForm.FormCreate(Sender: TObject);
begin
  // DM := TDM.Create(self);
end;

end.
