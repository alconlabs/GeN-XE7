unit MigrarF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Buttons, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope, REST.Authenticator.Basic, Datasnap.DBClient,
  REST.Response.Adapter, Vcl.Grids, Vcl.DBGrids, Data.DB, IPPeerClient,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, REST.Types, IBX.IBCustomDataSet, IBX.IBTable,
  FireDAC.Stan.Async, FireDAC.DApt, IBX.IBQuery, FireDAC.UI.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, System.JSON ,DataModule ,OperacionDM,
  Vcl.ExtCtrls, Vcl.ExtDlgs, System.Ansistrings, RestDM;

type
  TMigrarForm = class(TForm)
    ImportarButton: TButton;
    ProgressBar1: TProgressBar;
    EditUrl: TEdit;
    EditResource: TEdit;
    EditUser: TEdit;
    EditPassword: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    BorrarArticulosCheckBox: TCheckBox;
    DesdeRadioGroup: TRadioGroup;
    OpenTextFileDialog1: TOpenTextFileDialog;
    StringGrid1: TStringGrid;
    Timer1: TTimer;
    ActualizarCB: TCheckBox;
    ExportarButton: TButton;
    SaveTextFileDialog1: TSaveTextFileDialog;
    procedure ImportarButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure ExportarButtonClick(Sender: TObject);
//    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
    RubroId, CategoriaId, SubCategoriaId : string;
    procedure Procesar;
    procedure Importar;
  public
    { Public declarations }
  end;

var
  MigrarForm: TMigrarForm;

implementation

{$R *.dfm}

uses ImprimirDM;

// implentación de la clase THilo


procedure TMigrarForm.ExportarButtonClick(Sender: TObject);
var
  Stream: TFileStream;
  i: Integer;
  OutLine: string;
  sTemp: string;
begin
  with OperacionDataModule do begin
    Q.SQL.Text:='Select * from "Articulo"';
    Q.Open;
    SaveTextFileDialog1.Execute();
    DataSetToCsv( SaveTextFileDialog1.FileName );
  end;
  ShowMessage('Exportación finalizada con éxito!!!');
  close;
end;

procedure TMigrarForm.FormCreate(Sender: TObject);
begin
//  with FormatSettings do
//  begin
//    DecimalSeparator := '.';
//    ThousandSeparator := '';
//    ShortDateFormat := 'mm/dd/yyyy';
//  end;
  with dm do begin
    LeerINI;
    EditUrl.Text := webUrl;
    EditResource.Text := webRes;
    EditUser.Text := webUsr;
    EditPassword.Text := webPsw;
    if (webUpd <> '') then ActualizarCB.checked := StrToBool(webUpd);
  end;
  OperacionDataModule := TOperacionDataModule.Create(self);
  RestDataModule := TRestDataModule.Create(self);
end;

procedure TMigrarForm.ImportarButtonClick(Sender: TObject);
begin
  Timer1.Enabled:=True;
  if BorrarArticulosCheckBox.Checked then OperacionDataModule.BorrarArticulos;
  if DesdeRadioGroup.ItemIndex = 0 then Importar else Procesar;
end;

procedure TMigrarForm.Timer1Timer(Sender: TObject);
begin
  ProgressBar1.Position := ProgressBar1.Position+1;
end;

procedure TMigrarForm.Procesar;
var
  i,p : integer;
  mar, col, cat, subcat, rub, s, disponible, costo, fecha : string;
  categories: TJSONArray;
  precio, iva, ganancia: Double;
  function ConvertToDateTimeStr(DateStr: String): String;
  var
    s: string;
    fmt: TFormatSettings;
  begin
    fmt := TFormatSettings.Create;
    fmt.ShortDateFormat := 'YYYY-MM-DD';
    //      fmt.ShortTimeFormat := 'hh:mm:ss';
    //      fmt.TimeSeparator := ':';
    fmt.DateSeparator := '-';
    Result := formatdatetime('mm/dd/yyyy hh:mm:ss',StrToDateTime(DateStr, fmt));
  end;

begin
//  with OperacionDataModule do
with RestDataModule do
  begin
    ProgressBar1.Position := ProgressBar1.Position+1;
//    with dm do begin
      webUrl := EditUrl.Text;
      webRes := EditResource.Text;
      webUsr := EditUser.Text;
      webPsw := EditPassword.Text;
      webUpd := BoolToStr(ActualizarCB.checked);
      DM.EscribirINI;
//    end;
    ProgressBar1.Position := ProgressBar1.Position+1;
    importCategories(BorrarArticulosCheckBox.Checked);
    p:=0;
    ProgressBar1.Position := ProgressBar1.Position+1;
    repeat
      Inc(p);
      GetREST(WebRes+'status=publish&per_page=100&page='+IntToStr(p)+'&');
      if (O<>nil) then
        if  (O.RecordCount>0) then
          for i := 0 to O.RecordCount - 1 do
          begin
            ProgressBar1.Max := O.RecordCount;
            categories := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(O.FieldByName('categories').AsString),0) as TJSONArray;
            rub := existeEnTJSONArray('Rubro',categories);
  //          if rub = '' then
  //          begin
  //            insertarTabla2('Rubro','0','Sin Rubro');
  //            rub := '0';
  //          end;
            cat := existeEnTJSONArray('Categoria',categories);
  //          if cat = '' then
  //          begin
  //            insertarTabla2('Categoria','0','Sin Categoría');
  //            cat := '0';
  //          end;
            subcat := existeEnTJSONArray('SubCategoria',categories);
  //          if subcat = '' then
  //          begin
  //            insertarTabla2('SubCategoria','0','Sin SubCategoría');
  //            subcat := '0';
  //          end;
            disponible:=O.FieldByName('stock_quantity').AsString;
            if O.FieldByName('price').AsString='' then precio:=0 else precio:=O.FieldByName('price').AsFloat;
            if (O.FieldByName('tax_class').AsString = 'tasa-reducida') then
              iva := 10.5
              else
                iva := 21;
            ganancia := precio/(iva/100+1);
            costo := FloatToStrF( ( ganancia/(50/100+1) ), ffFixed, 16, 2 );
            fecha := ConvertToDateTimeStr(O.FieldByName('date_modified').AsString);
            if disponible='' then disponible:='0';
            if not (OperacionDataModule.existeEnTabla('Articulo','CODIGO='+O.FieldByName('id').AsString)) then
            begin
              D.SQL.Text := 'INSERT INTO "Articulo" ( CODIGO, DESCRIPCION '
              + ', ULTCOSTO, COSTO, PRECIO, PRECIO1, PRECIO2, DISPONIBLE'
              + ', PORCENTAJE, IMPOTROS, UNIDAD, TASA, IIBB, CTANOMBRE, CTATIPO, CTAANTICIPO, CTAIIBB '
              + ', FECHA, FECHACOMPULT, CODIGOBARRA'
              + ', CATEGORIA, COLOR, MARCA, PROVEEDOR, RUBRO, SUBCATEGORIA'
              + ' ) VALUES ( '
              + IntToStr(O.FieldByName('id').AsInteger) + ', ' + QuotedStr(O.FieldByName('name').AsString)
              + ', ' + costo + ', ' + costo + ', ' + FloatToStr(precio) + ', ' + O.FieldByName('regular_price').AsString+'0' + ', ' + O.FieldByName('sale_price').AsString+'0' + ', ' + disponible
              + ', 30, 5, ''c/u'', '+FloatToStr(iva)+', 1, 13, 13, 13, 66'
              + ', ' + QuotedStr(fecha) + ', ' + QuotedStr(fecha) + ', ' + QuotedStr(O.FieldByName('sku').AsString)
              + ', '+cat+', 0, 0, 1, '+rub+', '+subcat+' )';
  //            D.ExecSQL;
            end
              else
                D.SQL.Text := 'UPDATE "Articulo" SET'
                +' DESCRIPCION = ' + QuotedStr(O.FieldByName('name').AsString)
    //            +', ULTCOSTO = ' + costo
  //              +', COSTO = ' + costo
                +', PRECIO = ' + FloatToStr(precio)
                +', PRECIO1 = ' + O.FieldByName('regular_price').AsString+'0'
                +', PRECIO2 = ' + O.FieldByName('sale_price').AsString+'0'
                +', DISPONIBLE = ' + disponible
  //              +', PORCENTAJE = 30' +
  //              +', IMPOTROS = 5' +
  //              +', UNIDAD = ''c/u''' +
  //              +', TASA = ' + FloatToStr(iva)
  //              +', IIBB = 1' +
  //              +', CTANOMBRE = 13' +
  //              +', CTATIPO = 13' +
  //              +', CTAANTICIPO = 13' +
  //              +', CTAIIBB = 66' +
  //              +', FECHA = ' + QuotedStr(fecha)
  //              +', FECHACOMPULT = ' + QuotedStr(fecha)
                +', CODIGOBARRA = ' + QuotedStr(O.FieldByName('sku').AsString)
                +', CATEGORIA = ' + cat
  //              +', COLOR = 0' +
  //              +', MARCA = 0' +
  //              +', PROVEEDOR = 1' +
                +', RUBRO = ' + rub
                +', SUBCATEGORIA = ' + subcat
                +' WHERE CODIGO ='+ IntToStr(O.FieldByName('id').AsInteger);
            D.ExecSQL;
            ProgressBar1.Position := i;
            O.Next;
          end;
    until (O.RecordCount<2); //  until ((O.RecordCount=0) or (O.RecordCount=1));
    D.Transaction.CommitRetaining;
    ShowMessage('IMPORTACION DE PRODUCTOS FINALIZADA');
    Close;
    end;
end;

procedure TMigrarForm.Importar;
var
  csv : TStringList;
  fila : TStringList;
  i, j, cb
  , codigo
  , descripcion
  , ultcosto
  , costo
  , precio
  , precio1
  , precio2
  , disponible
  , porcentaje
  , impotros
  , unidad
  , tasa
  , iibb
  , ctanombre
  , ctatipo
  , ctaanticipo
  , ctaiibb
  , fecha
  , fechacompult
  , codigobarra
  , categoria
  , color
  , marca
  , proveedor
  , rubro
  , subcategoria
  : Integer;
  campo : string;
begin
  cb:=0;
  costo:=0;

	try
		csv := TStringList.Create;
		// cargar a partir del fichero csv
//		csv.LoadFromFile(FolderDialog.Directory + 'datos.csv');
    OpenTextFileDialog1.Execute();
		csv.LoadFromFile( OpenTextFileDialog1.FileName );

		fila := TStringList.Create;
    fila.StrictDelimiter := True;
    fila.Delimiter := ',';

//		ProgressBar1.Max := csv.Count -1;

    StringGrid1.Cells[0,0]:='code';
   // fila.CommaText := csv.Strings[0];

    fila.DelimitedText:= csv.Strings[0];
    StringGrid1.ColCount := fila.Count;
    	// recorrer la columna
			for j := 0 to fila.Count -1 do
			begin
//				lista.Items.Add(fila[j]);
        campo:=Trim(fila[j]);
//        if campo='CODIGOBARRA' then cb:=j else if campo='COSTO' then costo:=j;

        Case IndexStr(campo, ['CODIGO', 'DESCRIPCION', 'ULTCOSTO','COSTO'
        ,'PRECIO','PRECIO1','PRECIO2','DISPONIBLE','PORCENTAJE','IMPOTROS'
        ,'UNIDAD','TASA','IIBB','CTANOMBRE','CTATIPO','CTAANTICIPO','CTAIIBB'
        ,'FECHA','FECHACOMPULT','CODIGOBARRA','CATEGORIA','COLOR','MARCA'
        ,'PROVEEDOR','RUBRO','SUBCATEGORIA']) of
        0 : codigo:=j;
        1 : descripcion:=j;
        2 : ultcosto:=j;
        3 : costo:=j;
        4 : precio:=j;
        5 : precio1:=j;
        6 : precio2:=j;
        7 : disponible:=j;
        8 : porcentaje:=j;
        9 : impotros:=j;
        10 : unidad:=j;
        11 : tasa:=j;
        12 : iibb:=j;
        13 : ctanombre:=j;
        14 : ctatipo:=j;
        15 : ctaanticipo:=j;
        16 : ctaiibb:=j;
        17 : fecha:=j;
        18 : fechacompult:=j;
        19 : codigobarra:=j;
        20 : categoria:=j;
        21 : color:=j;
        22 : marca:=j;
        23 : proveedor:=j;
        24 : rubro:=j;
        25 : subcategoria:=j;
//        else ShowMessage('Unknown!');
        end;

        StringGrid1.Cells[j,0]:=campo;
			end;

    StringGrid1.RowCount := csv.Count;
		// recorrer las filas
		for i := 1 to csv.Count -1 do
		begin
//			ProgressBar1.Position := i;

//			fila.CommaText := csv.Strings[i];

      fila.DelimitedText:= csv.Strings[i];
      OperacionDataModule.
        ModificarArticulos(
          fila[codigo]
          , fila[descripcion]
          , fila[ultcosto]
          , fila[costo]
          , fila[precio]
          , fila[precio1]
          , fila[precio2]
          , fila[disponible]
          , fila[porcentaje]
          , fila[impotros]
          , fila[unidad]
          , fila[tasa]
          , fila[iibb]
          , fila[ctanombre]
          , fila[ctatipo]
          , fila[ctaanticipo]
          , fila[ctaiibb]
          , fila[fecha]
          , fila[fechacompult]
          , fila[codigobarra]
          , fila[categoria]
          , fila[color]
          , fila[marca]
          , fila[proveedor]
          , fila[rubro]
          , fila[subcategoria]
        );

			// recorrer las columnas
			for j := 0 to fila.Count -1 do
			begin
//				lista.Items.Add(fila[j]);
        campo:=fila[j];
        StringGrid1.Cells[j,i]:=campo;
			end;
		end;
		MessageDlg('Lectura Exitosa..', mtInformation, [mbOK], 0);
  OperacionDataModule.Q.Transaction.CommitRetaining;
	Except
	    on E : Exception do
	    begin
			MessageDlg('Ocurrio un Error: ' + E.Message, mtInformation, [mbOK], 0);
	    end;
	end;
	// liberar la memoria
	csv.Free;
Close;
end;


end.
