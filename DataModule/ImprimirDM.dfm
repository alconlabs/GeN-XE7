object ImprimirDataModule: TImprimirDataModule
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 473
  Width = 897
  object Query: TIBQuery
    Database = DM.BaseDatos
    Transaction = DM.Transaccion
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      '')
    Left = 40
    Top = 8
  end
  object VentasFDQuery1: TFDQuery
    Connection = FirebirdConnection
    SQL.Strings = (
      'SELECT '
      
        '  '#9'  '#39'1'#39' as PtoVta, '#39'CIVELOO'#39' as Empresa, '#39'Diego E. Guillen'#39' as ' +
        'ETITULAR, '#39'Monotributo'#39' as EIVA, '#39'2804'#39' as ECODIGOAREA, '#39'029814'#39 +
        ' as ETELEFONO, '#39'V.Autiero 1255'#39' as EDIRECCIONCOMERCIAL, '#39'9120'#39' a' +
        's ECP, '#39'Puerto Maryn'#39' as ECIUDAD, '#39'Biedma'#39' as EDEPARTAMENTO, '#39'Ch' +
        'ubut'#39' as EPROVINCIA, '#39'20314661967'#39' as ECUIT, '#39'45789827'#39' as EIIBB' +
        ', '#39'27/03/1985'#39' as EFECHA,'
      
        '      "Cliente".NOMBRE,  "Cliente".TITULAR, "Cliente".DIRECCION,' +
        ' "Cliente".DIRECCIONCOMERCIAL, "Cliente".IVA as CIVA, "Cliente".' +
        'CUIT as CCUIT,'
      '      '
      
        '      "Articulo".DESCRIPCION, "Articulo".UNIDAD, "Articulo".IVA ' +
        'as AIVA,'
      '      '
      
        '      "VentaItem".ARTICULO, "VentaItem".CANTIDAD, "VentaItem".PR' +
        'ECIO,    "VentaItem".OPERACION, ("VentaItem".PRECIO * "VentaItem' +
        '".CANTIDAD ) as PREXCANT, "VentaItem".SERVICIO, "VentaItem".DESC' +
        'RIPCION AS DESCR, "VentaItem".IMPUESTO as VIIMPUESTO,'
      '      '
      '      "Venta".CODIGO,   "Venta".LETRA,   "Venta".FECHA,'
      
        '      "Venta".COMPROBANTE, "Venta".TERMINOS ,   "Venta".IVA3,   ' +
        '"Venta".TOTAL,'
      '      "Venta".CONTADO,   "Venta".CLIENTE,   "Venta".SUBTOTAL,'
      '      "Venta".DESCUENTO,   "Venta".IMPUESTO,   "Venta".IVA2,'
      '      "Venta".IVA1,   "Venta".EXCENTO,   "Venta".SALDO,'
      '      "Venta".PAGADO  '
      'FROM   '
      #9'"Venta"'
      
        '      INNER JOIN "VentaItem" ON ("Venta".CODIGO = "VentaItem".OP' +
        'ERACION)'
      
        '      INNER JOIN "Articulo" ON ("VentaItem".ARTICULO = "Articulo' +
        '".CODIGO)'
      
        '      INNER JOIN "Cliente" ON ("Venta".CLIENTE = "Cliente".CODIG' +
        'O)'
      'WHERE'
      '    ("Venta".CODIGO = 2 )')
    Left = 744
    Top = 8
  end
  object FDQuery1: TFDQuery
    SQL.Strings = (
      'SELECT '#39'1234567890123'#39' as CODIGOBARRA FROM "Empresa"')
    Left = 744
    Top = 72
  end
  object FirebirdConnection: TFDConnection
    Params.Strings = (
      'ConnectionDef=GeN')
    LoginPrompt = False
    Left = 743
    Top = 387
  end
  object frxBarCodeObject1: TfrxBarCodeObject
    Left = 56
    Top = 352
  end
  object frxPDFExport1: TfrxPDFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    PrintOptimized = False
    Outline = False
    Background = False
    HTMLTags = True
    Quality = 95
    Transparency = False
    Author = 'FastReport'
    Subject = 'FastReport PDF export'
    ProtectionFlags = [ePrint, eModify, eCopy, eAnnot]
    HideToolbar = False
    HideMenubar = False
    HideWindowUI = False
    FitWindow = False
    CenterWindow = False
    PrintScaling = False
    PdfA = False
    Left = 120
    Top = 352
  end
  object frxCSVExport1: TfrxCSVExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    Separator = ';'
    OEMCodepage = False
    UTF8 = False
    NoSysSymbols = True
    ForcedQuotes = False
    Left = 184
    Top = 352
  end
  object frxDBDataset1: TfrxDBDataset
    UserName = 'frxDBDataset1'
    CloseDataSource = False
    DataSet = Query
    BCDToCurrency = False
    Left = 40
    Top = 56
  end
  object frxReport1: TfrxReport
    Version = '5.3.14'
    DataSet = frxDBDataset1
    DataSetName = 'frxDBDataset1'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 43309.844803217590000000
    ReportOptions.LastChange = 43309.844803217590000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 40
    Top = 104
    Datasets = <>
    Variables = <>
    Style = <>
  end
end
