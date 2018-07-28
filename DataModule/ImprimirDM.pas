unit ImprimirDM;

interface

uses
  SysUtils, Classes, DataModule, Dialogs, Data.DB,
  IBX.IBCustomDataSet, IBX.IBQuery, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  frxExportCSV, frxClass, frxExportPDF, frxBarcode, frxDBSet
 ;
type
  TImprimirDataModule = class(TDataModule)
    Query: TIBQuery;
    VentasFDQuery1: TFDQuery;
    FDQuery1: TFDQuery;
    FirebirdConnection: TFDConnection;
    frxBarCodeObject1: TfrxBarCodeObject;
    frxPDFExport1: TfrxPDFExport;
    frxCSVExport1: TfrxCSVExport;
    frxDBDataset1: TfrxDBDataset;
    frxReport1: TfrxReport;
    Function VTA(nro, let: string): string;
    Function OPER(nro, let: string): string;
    Function PRE(nro, let: string): string;
    Function PlanillaCobrador(nro, let: string): string;
    Function Contrato(nro, let: string): string;
    Function EAN(nro: string): string;
    Procedure Impr(vsql, reporte: string);
    Procedure CSV(sql, n: string);
    Procedure SImpr(vsql, reporte: string);
    procedure DataModuleCreate(Sender: TObject);
    
  private
    { Private declarations }
  public
    { Public declarations }
    clienteSql, articuloSql, ventaItemSql, ivaVtaSql, presupuestoSql, presupuestoTSql, vtaSql, ventaTSql: string;
  end;

var
  ImprimirDataModule: TImprimirDataModule;

implementation

{$R *.dfm}

uses OperacionDM;

Procedure TImprimirDataModule.SImpr;
begin
  Query.sql.Text := vsql;
  Query.Open;
  with frxReport1 do
  begin
    LoadFromFile(path + 'rpt\' + reporte + '.fr3');
    try
      ShowReport(True);
    finally
      Free;
    end;
  end;
end;

Procedure TImprimirDataModule.CSV; // exporta consulta a excel
var
  m: TStringList;
  g: TSaveDialog;
  CSV: TextFile;
  col: string;
  // ? f,c :integer;
  c: Integer;
begin
  Query.sql.Text := sql;
  Query.Open;
  try
    m := TStringList.Create;
    g := TSaveDialog.Create(Self);
  finally
    g.Filter := 'Ficheros Excel (*.csv)|*.csv|Todos los ficheros|*.*';
    g.Title := n;
    g.DefaultExt := 'csv';
    g.FileName := n;
    // ingresa los campos
    for c := 0 to Query.FieldCount - 1 do // columnas
    begin
      col := col + '"' + Query.Fields.Fields[c].DisplayName + '",';
    end;
    m.Append(col);
    // ingresa el contenido
    while not Query.Eof do // filas
    begin
      col := '';
      for c := 0 to Query.FieldCount - 1 do // columnas
      begin
        col := col + '"' + Query.Fields.Fields[c].AsString + '",';
      end;
      m.Append(col);
      Query.Next;
    end;
    if g.Execute then
    begin
      assignFile(CSV, g.FileName);
      rewrite(CSV);
      write(CSV, m.Text);
      closeFile(CSV);
    end;
  end;
  m.Free;
  g.Free;
end;

procedure TImprimirDataModule.DataModuleCreate(Sender: TObject);
begin
  dm.ConfigQuery.Open;
  clienteSql :=
    ' "Cliente".NOMBRE,  "Cliente".TITULAR, "Cliente".DIRECCION, "Cliente".DIRECCIONCOMERCIAL, "Cliente".IVA as CIVA, "Cliente".CUIT as CCUIT';
  articuloSql :=
    ' "Articulo".DESCRIPCION, "Articulo".UNIDAD, "Articulo".IVA as AIVA';
  ventaItemSql :=
    ' "VentaItem".ARTICULO, "VentaItem".CANTIDAD, "VentaItem".PRECIO, "VentaItem".OPERACION, ("VentaItem".PRECIO * "VentaItem".CANTIDAD ) as PREXCANT, "VentaItem".SERVICIO, "VentaItem".DESCRIPCION AS DESCR, "VentaItem".IMPUESTO as VIIMPUESTO';
  ivaVtaSql := ' "LibroIVAventa".NG1, "LibroIVAventa".IVA1, "LibroIVAventa".NG2, "LibroIVAventa".IVA2, "LibroIVAventa".NG3';
  presupuestoTSql:= ' "Presupuesto".CODIGO, "Presupuesto".LETRA, "Presupuesto".FECHA, "Presupuesto".COMPROBANTE,'
    + ' "Presupuesto".IVA3, "Presupuesto".TOTAL, "Presupuesto".CONTADO, "Presupuesto".CLIENTE,'
    + ' "Presupuesto".SUBTOTAL, "Presupuesto".DESCUENTO, "Presupuesto".IMPUESTO,'
    + ' "Presupuesto".IVA2, "Presupuesto".IVA1, "Presupuesto".EXCENTO, "Presupuesto".SALDO,'
    + ' "Presupuesto".PAGADO' + ' FROM "Presupuesto"';
  presupuestoSql := clienteSql + ',' + articuloSql + ',' +
    ' "PresupuestoItem".ARTICULO, "PresupuestoItem".CANTIDAD, "PresupuestoItem".PRECIO,'
    + ' "PresupuestoItem".OPERACION, ("PresupuestoItem".PRECIO * "PresupuestoItem".CANTIDAD ) as PREXCANT,'
    + ' "PresupuestoItem".SERVICIO, "PresupuestoItem".IMPUESTO as VIIMPUESTO, "PresupuestoItem".DESCRIPCION AS DESCR,'
    + presupuestoTSql +
    ' INNER JOIN "PresupuestoItem" ON ("Presupuesto".CODIGO = "PresupuestoItem".OPERACION)'
    + ' INNER JOIN "Articulo" ON ("PresupuestoItem".ARTICULO = "Articulo".CODIGO)'
    + ' INNER JOIN "Cliente" ON ("Presupuesto".CLIENTE = "Cliente".CODIGO)';
  ventaTSql:=' "Venta".CODIGO,' + '  "Venta".LETRA,' +
    '  "Venta".FECHA,' + '  "Venta".COMPROBANTE,' + '  "Venta".TERMINOS,'+
    '  "Venta".TOTAL,' + '  "Venta".CONTADO,' + '  "Venta".CLIENTE,' +
    '  "Venta".SUBTOTAL,' + '  "Venta".DESCUENTO,' + '  "Venta".IMPUESTO,' +
    '  "Venta".EXCENTO,' + '  "Venta".SALDO,' + '  "Venta".PAGADO'
    + ' FROM'
    + ' "Venta"';
    vtaSql:=
    clienteSql
    +','+ articuloSql
    +','+ ventaItemSql
    +','+ ivaVtaSql
    +','+ ventaTSql
    + ' LEFT JOIN "LibroIVAventa" ON ("Venta".CODIGO = "LibroIVAventa".FACTURA)'
    //+ ' INNER JOIN "VentaItem" ON ("LibroIVAventa".FACTURA = "VentaItem".OPERACION)'
    + ' INNER JOIN "VentaItem" ON ("Venta".CODIGO = "VentaItem".OPERACION)'
    + ' INNER JOIN "Articulo" ON ("VentaItem".ARTICULO = "Articulo".CODIGO)'
    + ' INNER JOIN "Cliente" ON ("Venta".CLIENTE = "Cliente".CODIGO)' ;
end;

procedure TImprimirDataModule.Impr;
var
  Pict, Pict2, Pict3, Pict4: TfrxPictureView;
  tipo_cbte: Integer;
begin
  if reporte = '' then
    reporte := dm.ConfigQuery.FieldByName('Reporte').AsString;
  Query.sql.Text := 'SELECT ' + QuotedStr(dm.ConfigQuery.FieldByName('CODIGO')
    .AsString) + ' As PtoVta,' + QuotedStr(dm.ConfigQuery.FieldByName('NOMBRE')
    .AsString) + ' As Empresa,' +
    QuotedStr(dm.ConfigQuery.FieldByName('TITULAR').AsString) + ' As ETITULAR,'
    + QuotedStr(dm.ConfigQuery.FieldByName('IVA').AsString) + ' As EIVA,' +
    QuotedStr(dm.ConfigQuery.FieldByName('CODIGOAREA').AsString) +
    ' As ECODIGOAREA,' + QuotedStr(dm.ConfigQuery.FieldByName('TELEFONO')
    .AsString) + ' As ETELEFONO,' +
    QuotedStr(dm.ConfigQuery.FieldByName('DIRECCIONCOMERCIAL').AsString) +
    ' As EDIRECCIONCOMERCIAL,' + QuotedStr(dm.ConfigQuery.FieldByName('CP')
    .AsString) + ' As ECP,' + QuotedStr(dm.ConfigQuery.FieldByName('CIUDAD')
    .AsString) + ' As ECIUDAD,' +
    QuotedStr(dm.ConfigQuery.FieldByName('DEPARTAMENTO').AsString) +
    ' As EDEPARTAMENTO,' + QuotedStr(dm.ConfigQuery.FieldByName('PROVINCIA')
    .AsString) + ' As EPROVINCIA,' +
    QuotedStr(dm.ConfigQuery.FieldByName('CUIT').AsString) + ' As ECUIT,' +
    QuotedStr(FormatDateTime('dd/mm/yyyy', dm.ConfigQuery.FieldByName('FECHA')
    .AsDateTime)) + ' As EFECHA,' + QuotedStr(dm.ConfigQuery.FieldByName('IIBB')
    .AsString) + ' As EIIBB,' + vsql;
  Query.Open;
  with frxReport1 do
  begin
    LoadFromFile(path + 'rpt\' + reporte + '.fr3');
    if (reporte = 'COriginal') or (reporte = 'Presupuesto')
//    or (reporte = 'FElectronica')
    then
    begin
      Pict := TfrxPictureView(frxReport1.FindObject('Picture1'));
      if Assigned(Pict) then
        Pict.Picture.LoadFromFile(path + 'img\empresa.BMP');
//      if (reporte = 'FElectronica') then // wsfev1
//      begin
//         {
//         Campo CbteTipo sea:
//          - 01, 02, 03, 04, 05,34,39,60, 63 para los clase A
//          - 06, 07, 08, 09, 10, 35, 40,64, 61 para los clase B.
//          - 11, 12, 13, 15 para los clase C.
//          - 51, 52, 53, 54 para los clase M.
//          - 49 para los Bienes Usados
//          Consultar método FEParamGetTiposCbte.
//         }
//         Case IndexStr(Query.FieldByName('LETRA').AsString, ['A', 'B', 'C']) of
//          0: tipo_cbte := 1;//A
//          1: tipo_cbte := 6;//B
//          2: tipo_cbte := 11;//C
//          end;
//
//          AfipWsfev1(
//          tipo_cbte// tipo_cbte
//          ,Query.FieldByName('PtoVta').AsInteger// punto_vta
//          ,80// tipo_doc
//          ,0// presta_serv
//          ,0// id
//          ,0// cbt_desde
//          ,0// cbt_hasta : Integer;
//          ,Query.FieldByName('FECHA').AsString// fecha
//          ,Query.FieldByName('CCUIT').AsString// nro_doc
//          ,Query.FieldByName('TOTAL').AsString// imp_total
//          ,'0.00'// imp_tot_conc
//          ,Query.FieldByName('SUBTOTAL').AsString// imp_neto
//          ,Query.FieldByName('IMPUESTO').AsString// impto_liq
//          ,'0.00'// impto_liq_rni
//          ,'0.00'// imp_op_ex
//          ,'20170425'// fecha_cbte
//          ,'20170425'// fecha_venc_pago
//          ,'20170425'// fecha_serv_desde
//          ,'20170425'// fecha_serv_hasta
//          ,'20170425'// venc : String;
//          ,'PES'// moneda_id
//          ,'1.000'// moneda_ctz : String ;
//          ,Query.FieldByName('NG2').AsString// bi21
//          ,Query.FieldByName('IVA2').AsString// i21
//          ,Query.FieldByName('NG1').AsString// bi105
//          ,Query.FieldByName('IVA1').AsString// i105: String;
//          );
//      end
    end
    else
      if reporte = 'CDuplicado' then
    begin
      Pict := TfrxPictureView(frxReport1.FindObject('Picture1'));
      if Assigned(Pict) then
        Pict.Picture.LoadFromFile(path + 'img\empresa.BMP');
      Pict2 := TfrxPictureView(frxReport1.FindObject('Picture2'));
      if Assigned(Pict2) then
        Pict2.Picture.LoadFromFile(path + 'img\empresa.BMP');
    end
    else if reporte = 'CTriplicado' then
    begin
      Pict := TfrxPictureView(frxReport1.FindObject('Picture1'));
      if Assigned(Pict) then
        Pict.Picture.LoadFromFile(path + 'img\empresa.BMP');
      Pict2 := TfrxPictureView(frxReport1.FindObject('Picture2'));
      if Assigned(Pict2) then
        Pict2.Picture.LoadFromFile(path + 'img\empresa.BMP');
      Pict3 := TfrxPictureView(frxReport1.FindObject('Picture3'));
      if Assigned(Pict3) then
        Pict3.Picture.LoadFromFile(path + 'img\empresa.BMP');
    end
    else if reporte = 'CCuadriplicado' then
    begin
      Pict := TfrxPictureView(frxReport1.FindObject('Picture1'));
      if Assigned(Pict) then
        Pict.Picture.LoadFromFile(path + 'img\empresa.BMP');
      Pict2 := TfrxPictureView(frxReport1.FindObject('Picture2'));
      if Assigned(Pict2) then
        Pict2.Picture.LoadFromFile(path + 'img\empresa.BMP');
      Pict3 := TfrxPictureView(frxReport1.FindObject('Picture3'));
      if Assigned(Pict3) then
        Pict3.Picture.LoadFromFile(path + 'img\empresa.BMP');
      Pict4 := TfrxPictureView(frxReport1.FindObject('Picture4'));
      if Assigned(Pict4) then
        Pict4.Picture.LoadFromFile(path + 'img\empresa.BMP');
    end;
    try
      ShowReport(True);
    finally
      Free;
      // FreeAndNil(pict);
    end;
  end;
end;

Function TImprimirDataModule.PRE;
begin
  Result := presupuestoSql + '  WHERE' + '  ("Presupuesto".CODIGO = ' + nro +
    '  ) AND' + '  ("Presupuesto".LETRA = ' + QuotedStr(let) + '  )' + '';
end;

Function TImprimirDataModule.VTA;
begin
  Result := vtaSql
    + ' WHERE'
    + '  ("Venta".CODIGO = ' + nro + ' ) AND' + '  ("Venta".LETRA = ' +
    QuotedStr(let) + ' )' + '';
end;

Function TImprimirDataModule.OPER;
begin
  Result := '  "Cliente".NOMBRE,' + '  "Cliente".TITULAR,' +
    '  "Cliente".DIRECCION,' + '  "Cliente".DIRECCIONCOMERCIAL,' +
    '  "Articulo".DESCRIPCION,' + '  "Articulo".UNIDAD,' +
    '  "OperacionItem".ARTICULO,' + '  "OperacionItem".CANTIDAD,' +
    '  "OperacionItem".PRECIO,' + '  "OperacionItem".OPERACION,' +
    '  ("OperacionItem".PRECIO * "OperacionItem".CANTIDAD ) as PREXCANT,' +
    '  "OperacionItem".SERVICIO,' + '  "OperacionItem".DESCRIPCION AS DESCR,' +
    '  "Operacion".CODIGO,' + '  "Operacion".LETRA,' + '  "Operacion".FECHA,' +
    '  "Operacion".COMPROBANTE,' + '  "Operacion".IVA3,' +
    '  "Operacion".TOTAL,' + '  "Operacion".CONTADO,' + '  "Operacion".CLIENTE,'
    + '  "Operacion".SUBTOTAL,' + '  "Operacion".DESCUENTO,' +
    '  "Operacion".IMPUESTO,' + '  "Operacion".IVA2,' + '  "Operacion".IVA1,' +
    '  "Operacion".EXCENTO,' + '  "Operacion".SALDO,' + '  "Operacion".PAGADO' +
    ' FROM' + '  "Operacion"' +
    '  INNER JOIN "OperacionItem" ON ("Operacion".CODIGO = "OperacionItem".OPERACION)'
    + '  INNER JOIN "Articulo" ON ("OperacionItem".ARTICULO = "Articulo".CODIGO)'
    + '  INNER JOIN "Cliente" ON ("Operacion".CLIENTE = "Cliente".CODIGO)' +
    ' WHERE' + '  ("Operacion".CODIGO = ' + nro + ' ) AND' +
    '  ("Operacion".LETRA = ' + QuotedStr(let) + ' )' + '';
end;

Function TImprimirDataModule.PlanillaCobrador;
begin
  Result := '"Cobrador".NOMBRE AS COBRADOR, "Cliente".ZONA,' +
    ' "CtaCte".FECHA, "CtaCte".SALDO, "Cliente".NOMBRE AS CLIENTE,' +
    ' "CtaCteItem".IMPORTE, "CtaCte".ARTICULO as CB, "CtaCteItem".VENCE,' +
    ' "CtaCteItem".CUOTA, "CtaCte".OPERACION' + ' FROM "CtaCte"' +
    ' INNER JOIN "CtaCteItem" ON ("CtaCte".CLIENTE = "CtaCteItem".CLIENTE) AND ("CtaCte".OPERACION = "CtaCteItem".OPERACION)'
    + ' INNER JOIN "Cliente" ON ("CtaCteItem".CLIENTE = "Cliente".CODIGO)' +
    ' INNER JOIN "Cobrador" ON ("CtaCte".COBRADOR = "Cobrador".CODIGO)' +
    ' WHERE ("CtaCte".OPERACION = ' + nro + ')' +
    ' ORDER BY "CtaCteItem".CUOTA';
end;

Function TImprimirDataModule.Contrato;
begin
  Result := 'CODIGO, NUMERO, FECHA, TIPO, DIA, DESCRITO, MES, MESCRITO, ANO, AESCRITO, '
    + 'CANONES, CIMPORTE, CIESCRITO, IMPORTETOTAL, ITESCRITO, TIEMPO, T2, BIEN, '
    + 'DADOR, DTIPO, DNOMBRE, DAPELLIDO, DDOCUMENTO, DDTIPO, DDOMICILIO, DDNUMERO, '
    + 'DCIUDAD, DPROVINCIA, DPAIS, TOMADOR, TTIPO, TNOMBRE, TAPELLIDO, TDOCUMENTO, '
    + 'TDTIPO, TDOMICILIO, TDTRABAJO, TCIUDAD, TPROVINCIA, TPAIS ' +
    'FROM "Contrato" WHERE NUMERO=' + nro;
end;

Function TImprimirDataModule.EAN;
begin
  Result := nro + 'as CODIGOBARRA FROM "Empresa"';
end;

end.
