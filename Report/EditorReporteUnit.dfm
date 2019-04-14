object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 665
  ClientWidth = 720
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 0
    Top = 241
    Width = 720
    Height = 424
    Align = alBottom
    DataSource = DataSource1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object frxBarCodeObject1: TfrxBarCodeObject
    Left = 24
    Top = 112
  end
  object frxPDFExport1: TfrxPDFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    OpenAfterExport = False
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
    Left = 24
    Top = 160
  end
  object frxDBDataset1: TfrxDBDataset
    UserName = 'frxDBDataset1'
    CloseDataSource = False
    FieldAliases.Strings = (
      'PTOVTA=PTOVTA'
      'EMPRESA=EMPRESA'
      'ETITULAR=ETITULAR'
      'EIVA=EIVA'
      'ECODIGOAREA=ECODIGOAREA'
      'ETELEFONO=ETELEFONO'
      'EDIRECCIONCOMERCIAL=EDIRECCIONCOMERCIAL'
      'ECP=ECP'
      'ECIUDAD=ECIUDAD'
      'EDEPARTAMENTO=EDEPARTAMENTO'
      'EPROVINCIA=EPROVINCIA'
      'ECUIT=ECUIT'
      'EIIBB=EIIBB'
      'EFECHA=EFECHA'
      'NOMBRE=NOMBRE'
      'TITULAR=TITULAR'
      'DIRECCION=DIRECCION'
      'DIRECCIONCOMERCIAL=DIRECCIONCOMERCIAL'
      'CIVA=CIVA'
      'CCUIT=CCUIT'
      'DESCRIPCION=DESCRIPCION'
      'UNIDAD=UNIDAD'
      'AIVA=AIVA'
      'ARTICULO=ARTICULO'
      'CANTIDAD=CANTIDAD'
      'VIDESCUENTO=VIDESCUENTO'
      'PRECIO=PRECIO'
      'OPERACION=OPERACION'
      'PREXCANT=PREXCANT'
      'SERVICIO=SERVICIO'
      'DESCR=DESCR'
      'VIIMPUESTO=VIIMPUESTO'
      'CODIGO=CODIGO'
      'LETRA=LETRA'
      'VDESC=VDESC'
      'FECHA=FECHA'
      'COMPROBANTE=COMPROBANTE'
      'TERMINOS=TERMINOS'
      'IVA3=IVA3'
      'TOTAL=TOTAL'
      'CONTADO=CONTADO'
      'CLIENTE=CLIENTE'
      'SUBTOTAL=SUBTOTAL'
      'DESCUENTO=DESCUENTO'
      'IMPUESTO=IMPUESTO'
      'IVA2=IVA2'
      'IVA1=IVA1'
      'EXCENTO=EXCENTO'
      'SALDO=SALDO'
      'PAGADO=PAGADO'
      'CB=CB')
    DataSet = IBQuery1
    BCDToCurrency = False
    Left = 24
    Top = 16
  end
  object frxCSVExport1: TfrxCSVExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = True
    Separator = ','
    OEMCodepage = False
    UTF8 = True
    OpenAfterExport = False
    NoSysSymbols = True
    ForcedQuotes = False
    Left = 24
    Top = 208
  end
  object frxReport1: TfrxReport
    Version = '6.2.1'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick, pbCopy, pbSelection]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39416.849051458300000000
    ReportOptions.LastChange = 43429.791094664400000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 24
    Top = 64
    Datasets = <
      item
        DataSet = frxDBDataset1
        DataSetName = 'frxDBDataset1'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 90.000000000000000000
      PaperHeight = 120.000000000000000000
      PaperSize = 256
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      Frame.Typ = []
      PrintOnPreviousPage = True
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Frame.Typ = []
        Top = 18.897650000000000000
        Width = 302.362400000000000000
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Frame.Typ = []
        Top = 445.984540000000000000
        Width = 302.362400000000000000
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Frame.Typ = []
        Height = 15.118120000000000000
        Top = 188.976500000000000000
        Width = 302.362400000000000000
        DataSet = frxDBDataset1
        DataSetName = 'frxDBDataset1'
        RowCount = 1
      end
      object DetailData1: TfrxDetailData
        FillType = ftBrush
        Frame.Typ = []
        Height = 41.574830000000000000
        Top = 226.771800000000000000
        Width = 302.362400000000000000
        DataSet = frxDBDataset1
        DataSetName = 'frxDBDataset1'
        RowCount = 0
        object Memo16: TfrxMemoView
          AllowVectorExport = True
          Width = 337.937230000000000000
          Height = 18.897650000000000000
          DataSetName = 'FacturafrxDBDataset'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBDataset1."CANTIDAD"] X [frxDBDataset1."PRECIO"]')
          ParentFont = False
        end
        object frxDBDataset1ARTICULO: TfrxMemoView
          AllowVectorExport = True
          Top = 18.897650000000000000
          Width = 188.976500000000000000
          Height = 18.897650000000000000
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBDataset1."ARTICULO"] [frxDBDataset1."DESCR"]')
          ParentFont = False
        end
        object frxDBDataset1PREXCANT: TfrxMemoView
          AllowVectorExport = True
          Left = 188.976500000000000000
          Top = 18.897649999999900000
          Width = 113.385900000000000000
          Height = 18.897650000000000000
          DataField = 'PREXCANT'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset1."PREXCANT"]')
          ParentFont = False
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 94.488250000000000000
        Top = 291.023810000000000000
        Width = 302.362400000000000000
        object Memo13: TfrxMemoView
          AllowVectorExport = True
          Left = 77.590600000000000000
          Top = 33.677180000000000000
          Width = 222.992270000000000000
          Height = 18.897650000000000000
          DataSetName = 'FacturafrxDBDataset'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset1."TOTAL"]')
          ParentFont = False
        end
        object frxDBDataset1PAGADO: TfrxMemoView
          AllowVectorExport = True
          Left = 77.590600000000000000
          Top = 52.913420000000000000
          Width = 222.992270000000000000
          Height = 18.897650000000000000
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset1."PAGADO"]')
          ParentFont = False
        end
        object frxDBDataset1SALDO: TfrxMemoView
          AllowVectorExport = True
          Left = 77.590600000000000000
          Top = 71.811070000000000000
          Width = 222.992270000000000000
          Height = 18.897650000000000000
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset1."SALDO"]')
          ParentFont = False
        end
        object Memo1: TfrxMemoView
          AllowVectorExport = True
          Left = 2.000000000000000000
          Top = 33.897649999999900000
          Width = 52.913420000000000000
          Height = 18.897650000000000000
          DataSetName = 'FacturafrxDBDataset'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'TOTAL')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          AllowVectorExport = True
          Left = 2.000000000000000000
          Top = 53.133890000000000000
          Width = 64.252010000000000000
          Height = 18.897650000000000000
          DataSetName = 'FacturafrxDBDataset'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'PAGADO')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          AllowVectorExport = True
          Left = 2.000000000000000000
          Top = 72.031540000000000000
          Width = 64.252010000000000000
          Height = 18.897650000000000000
          DataSetName = 'FacturafrxDBDataset'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'SALDO')
          ParentFont = False
        end
        object frxDBDataset1DESCUENTO: TfrxMemoView
          AllowVectorExport = True
          Left = 77.590600000000000000
          Top = 15.118120000000000000
          Width = 222.992270000000000000
          Height = 18.897650000000000000
          DataField = 'DESCUENTO'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset1."DESCUENTO"]')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          AllowVectorExport = True
          Left = 2.000000000000000000
          Top = 15.118120000000000000
          Width = 64.252010000000000000
          Height = 18.897650000000000000
          DataSetName = 'FacturafrxDBDataset'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'DESC')
          ParentFont = False
        end
      end
      object GroupHeader2: TfrxGroupHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 86.929190000000000000
        Top = 79.370130000000000000
        Width = 302.362400000000000000
        Condition = 'frxDBDataset1."CODIGO"'
        object frxDBDataset1CODIGO: TfrxMemoView
          AllowVectorExport = True
          Top = 49.133890000000000000
          Width = 109.606370000000000000
          Height = 18.897650000000000000
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'nro.[frxDBDataset1."CODIGO"]')
          ParentFont = False
        end
        object frxDBDataset1FECHA: TfrxMemoView
          AllowVectorExport = True
          Top = 30.236240000000000000
          Width = 302.362400000000000000
          Height = 18.897650000000000000
          DataField = 'FECHA'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBDataset1."FECHA"]')
          ParentFont = False
        end
        object frxDBDataset1EMPRESA: TfrxMemoView
          AllowVectorExport = True
          Width = 302.362400000000000000
          Height = 18.897650000000000000
          DataField = 'EMPRESA'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBDataset1."EMPRESA"]')
          ParentFont = False
        end
        object frxDBDataset1NOMBRE: TfrxMemoView
          AllowVectorExport = True
          Top = 68.031540000000000000
          Width = 340.157700000000000000
          Height = 18.897650000000000000
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBDataset1."NOMBRE"], [frxDBDataset1."DIRECCION"]')
          ParentFont = False
        end
        object frxDBDataset1EWEB: TfrxMemoView
          AllowVectorExport = True
          Top = 15.118120000000000000
          Width = 302.362400000000000000
          Height = 18.897650000000000000
          DataField = 'EWEB'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBDataset1."EWEB"]')
          ParentFont = False
        end
      end
    end
  end
  object VentasFDQuery1: TFDQuery
    Connection = FirebirdConnection
    SQL.Strings = (
      'SELECT '
      
        '      '#39'1'#39' as PtoVta, '#39'CIVELOO'#39' as Empresa, '#39'Diego E. Guillen'#39' as' +
        ' ETITULAR, '#39'Monotributo'#39' as EIVA, '#39'2804'#39' as ECODIGOAREA, '#39'029814' +
        #39' as ETELEFONO, '#39'V.Autiero 1255'#39' as EDIRECCIONCOMERCIAL, '#39'9120'#39' ' +
        'as ECP, '#39'Puerto Maryn'#39' as ECIUDAD, '#39'Biedma'#39' as EDEPARTAMENTO, '#39'C' +
        'hubut'#39' as EPROVINCIA, '#39'20314661967'#39' as ECUIT, '#39'45789827'#39' as EIIB' +
        'B, '#39'27/03/1985'#39' as EFECHA,'
      
        '      "Cliente".NOMBRE,  "Cliente".TITULAR, "Cliente".DIRECCION,' +
        ' "Cliente".DIRECCIONCOMERCIAL, "Cliente".IVA as CIVA, "Cliente".' +
        'CUIT as CCUIT,'
      '      '
      
        '      "Articulo".DESCRIPCION, "Articulo".UNIDAD, "Articulo".IVA ' +
        'as AIVA,'
      '      '
      
        '      "VentaItem".ARTICULO, "VentaItem".CANTIDAD, "VentaItem".CO' +
        'STO AS VIDESCUENTO,'
      
        '      "VentaItem".PRECIO, "VentaItem".OPERACION, ("VentaItem".PR' +
        'ECIO * "VentaItem".CANTIDAD ) as PREXCANT, '
      
        '      "VentaItem".SERVICIO, "VentaItem".DESCRIPCION AS DESCR, "V' +
        'entaItem".IMPUESTO as VIIMPUESTO,'
      '      '
      '      "Venta".CODIGO,   "Venta".LETRA,   "Venta".FECHA,'
      
        '      "Venta".COMPROBANTE, "Venta".TERMINOS ,   "Venta".IVA3,   ' +
        '"Venta".TOTAL,'
      '      "Venta".CONTADO,   "Venta".CLIENTE,   "Venta".SUBTOTAL,'
      '      "Venta".DESCUENTO,   "Venta".IMPUESTO,   "Venta".IVA2,'
      '      "Venta".IVA1, "Venta".EXCENTO,   "Venta".SALDO,'
      '      "Venta".PAGADO, '#39'20121231237'#39'as CB'
      '  '
      'FROM   '
      #9'"Venta"'
      
        '      INNER JOIN "VentaItem" ON ("Venta".CODIGO = "VentaItem".OP' +
        'ERACION)'
      
        '      INNER JOIN "Articulo" ON ("VentaItem".ARTICULO = "Articulo' +
        '".CODIGO)'
      
        '      INNER JOIN "Cliente" ON ("Venta".CLIENTE = "Cliente".CODIG' +
        'O)')
    Left = 591
  end
  object FDQuery1: TFDQuery
    Connection = FirebirdConnection
    SQL.Strings = (
      'SELECT * from "Venta"')
    Left = 591
    Top = 64
  end
  object FirebirdConnection: TFDConnection
    Params.Strings = (
      'ConnectionDef=GeN')
    LoginPrompt = False
    Left = 591
    Top = 117
  end
  object IBDatabase1: TIBDatabase
    Connected = True
    DatabaseName = 'C:\Users\DeGsoft\Documents\GitHub\GeN-XE7\Bin\GeN\db\GeN.FDB'
    Params.Strings = (
      'user_name=SYSDBA'
      'password=masterkey'
      'sql_role_name=3'
      'lc_ctype=WIN1252')
    LoginPrompt = False
    ServerType = 'IBServer'
    AllowStreamedConnected = False
    Left = 304
    Top = 24
  end
  object IBQuery1: TIBQuery
    Database = IBDatabase1
    Transaction = db
    AutoCalcFields = False
    Active = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT '
      
        '      '#39'1'#39' as PtoVta, '#39'CIVELOO'#39' as Empresa, '#39'Diego E. Guillen'#39' as' +
        ' ETITULAR, '#39'Monotributo'#39' as EIVA, '#39'2804'#39' as ECODIGOAREA, '#39'029814' +
        #39' as ETELEFONO, '#39'V.Autiero 1255'#39' as EDIRECCIONCOMERCIAL, '#39'9120'#39' ' +
        'as ECP, '#39'Puerto Maryn'#39' as ECIUDAD, '#39'Biedma'#39' as EDEPARTAMENTO, '#39'C' +
        'hubut'#39' as EPROVINCIA, '#39'20314661967'#39' as ECUIT, '#39'45789827'#39' as EIIB' +
        'B, '#39'27/03/1985'#39' as EFECHA,'
      
        '      "Cliente".NOMBRE,  "Cliente".TITULAR, "Cliente".DIRECCION,' +
        ' "Cliente".DIRECCIONCOMERCIAL, "Cliente".IVA as CIVA, "Cliente".' +
        'CUIT as CCUIT,'
      '      '
      
        '      "Articulo".DESCRIPCION, "Articulo".UNIDAD, "Articulo".IVA ' +
        'as AIVA,'
      '      '
      
        '      "VentaItem".ARTICULO, "VentaItem".CANTIDAD, "VentaItem".CO' +
        'STO AS VIDESCUENTO,'
      
        '      "VentaItem".PRECIO, "VentaItem".OPERACION, ("VentaItem".PR' +
        'ECIO * "VentaItem".CANTIDAD ) as PREXCANT, '
      
        '      "VentaItem".SERVICIO, "VentaItem".DESCRIPCION AS DESCR, "V' +
        'entaItem".IMPUESTO as VIIMPUESTO,'
      '      '
      
        '      "Venta".CODIGO, "Venta".LETRA, "Venta".DESCRIPCION as VDES' +
        'C, "Venta".FECHA,'
      
        '      "Venta".COMPROBANTE, "Venta".TERMINOS ,   "Venta".IVA3,   ' +
        '"Venta".TOTAL,'
      '      "Venta".CONTADO,   "Venta".CLIENTE,   "Venta".SUBTOTAL,'
      '      "Venta".DESCUENTO,   "Venta".IMPUESTO,   "Venta".IVA2,'
      '      "Venta".IVA1, "Venta".EXCENTO,   "Venta".SALDO,'
      '      "Venta".PAGADO, '#39'20121231237'#39'as CB'
      '  '
      'FROM   '
      #9'"Venta"'
      
        '      INNER JOIN "VentaItem" ON ("Venta".CODIGO = "VentaItem".OP' +
        'ERACION)'
      
        '      INNER JOIN "Articulo" ON ("VentaItem".ARTICULO = "Articulo' +
        '".CODIGO)'
      
        '      INNER JOIN "Cliente" ON ("Venta".CLIENTE = "Cliente".CODIG' +
        'O)'
      'WHERE "Venta".CODIGO = 2'
      '')
    Left = 304
    Top = 88
  end
  object db: TIBTransaction
    Active = True
    DefaultDatabase = IBDatabase1
    Left = 304
    Top = 152
  end
  object DataSource1: TDataSource
    DataSet = IBQuery1
    Left = 304
    Top = 200
  end
end
