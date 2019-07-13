object fEditorReporte: TfEditorReporte
  Left = 0
  Top = 0
  Caption = 'Editor Reporte'
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
      'CTIPO=CTIPO'
      'NCTIPO=NCTIPO'
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
    DataSet = VentasFDQuery1
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
    DataSet = frxDBDataset1
    DataSetName = 'frxDBDataset1'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick, pbCopy, pbSelection]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39416.849051458300000000
    ReportOptions.LastChange = 43659.576212430600000000
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
      PaperWidth = 58.000000000000000000
      PaperHeight = 210.000000000000000000
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
        Height = 45.354360000000000000
        Top = 18.897650000000000000
        Width = 181.417440000000000000
        object frxDBDataset1EMPRESA: TfrxMemoView
          AllowVectorExport = True
          Width = 177.637768430000000000
          Height = 45.354360000000000000
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBDataset1."EMPRESA"]'
            '[frxDBDataset1."EWEB"]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Frame.Typ = []
        Top = 468.661720000000000000
        Width = 181.417440000000000000
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Frame.Typ = []
        Height = 7.559060000000000000
        Top = 188.976500000000000000
        Width = 181.417440000000000000
        RowCount = 1
      end
      object DetailData1: TfrxDetailData
        FillType = ftBrush
        Frame.Typ = []
        Height = 41.574830000000000000
        Top = 219.212740000000000000
        Width = 181.417440000000000000
        DataSet = frxDBDataset1
        DataSetName = 'frxDBDataset1'
        RowCount = 0
        object Memo16: TfrxMemoView
          AllowVectorExport = True
          Left = 3.118120000000000000
          Top = 1.000000000000000000
          Width = 173.858184720000000000
          Height = 37.795300000000000000
          DataSetName = 'FacturafrxDBDataset'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Calibri'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBDataset1."CANTIDAD"] X [frxDBDataset1."PRECIO"]'
            
              '[frxDBDataset1."ARTICULO"]-[frxDBDataset1."DESCR"]-[frxDBDataset' +
              '1."PREXCANT"]')
          ParentFont = False
          VAlign = vaCenter
          Formats = <
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end>
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 124.724490000000000000
        Top = 283.464750000000000000
        Width = 181.417440000000000000
        object frxDBDataset1DESCUENTO: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Width = 173.858233540000000000
          Height = 94.488250000000000000
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'DESC. [frxDBDataset1."DESCUENTO"]'
            'TOTAL [frxDBDataset1."TOTAL"]'
            'PAGADO [frxDBDataset1."PAGADO"]'
            'SALDO [frxDBDataset1."SALDO"]'
            ''
            'Vto.: [frxDBDataset1."TERMINOS"] CAE: [frxDBDataset1."VDESC"]')
          ParentFont = False
          VAlign = vaCenter
          Formats = <
            item
            end
            item
            end
            item
            end
            item
            end>
        end
        object BarCode1: TfrxBarCodeView
          Align = baCenter
          AllowVectorExport = True
          Left = 58.708720000000000000
          Top = 86.929190000000000000
          Width = 64.000000000000000000
          Height = 34.015770000000000000
          BarType = bcCode_2_5_interleaved
          Expression = '<frxDBDataset1."CB">'
          Frame.Typ = []
          Rotation = 0
          TestLine = False
          Text = '12345678'
          WideBarRatio = 2.000000000000000000
          Zoom = 1.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
        end
      end
      object GroupHeader2: TfrxGroupHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 41.574830000000000000
        Top = 124.724490000000000000
        Width = 181.417440000000000000
        Condition = 'frxDBDataset1."OPERACION"'
        object frxDBDataset1ECUIT: TfrxMemoView
          AllowVectorExport = True
          Left = 3.118120000000000000
          Top = 1.000000000000000000
          Width = 173.858380000000000000
          Height = 37.795300000000000000
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBDataset1."CTIPO"]'
            'CUIT: [frxDBDataset1."ECUIT"]'
            
              '[frxDBDataset1."FECHA"] - [frxDBDataset1."LETRA"] - nro.[frxDBDa' +
              'taset1."COMPROBANTE"]')
          ParentFont = False
          VAlign = vaCenter
          Formats = <
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end>
        end
      end
    end
  end
  object VentasFDQuery1: TFDQuery
    Active = True
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
      ''
      #39'FACTURA'#39' as CTIPO, '#39'COD.6'#39' as NCTIPO,'
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
        'O)'
      ''
      'WHERE'
      ' "Venta".CODIGO = 1')
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
    Connected = True
    LoginPrompt = False
    Left = 591
    Top = 117
  end
  object IBDatabase1: TIBDatabase
    DatabaseName = 'C:\Users\DeGsoft\Documents\Civeloo\GeN\db\GeN.FDB'
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
      #39'FACTURA'#39' AS CTIPO,'
      ''
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
    DefaultDatabase = IBDatabase1
    Left = 304
    Top = 152
  end
  object DataSource1: TDataSource
    DataSet = IBQuery1
    Left = 304
    Top = 200
  end
  object OperacionFDQuery: TFDQuery
    Active = True
    Connection = FirebirdConnection
    SQL.Strings = (
      'SELECT '
      
        #39'1'#39' as PtoVta, '#39'CIVELOO'#39' as Empresa, '#39'Diego E. Guillen'#39' as ETITU' +
        'LAR,'
      
        #39'Monotributo'#39' as EIVA, '#39'2804'#39' as ECODIGOAREA, '#39'029814'#39' as ETELEF' +
        'ONO,'
      #39'V.Autiero 1255'#39' as EDIRECCIONCOMERCIAL, '#39'9120'#39' as ECP,'
      
        #39'Puerto Maryn'#39' as ECIUDAD, '#39'Biedma'#39' as EDEPARTAMENTO, '#39'Chubut'#39' a' +
        's EPROVINCIA,'
      
        #39'20314661967'#39' as ECUIT, '#39'45789827'#39' as EIIBB, '#39'27/03/1985'#39' as EFE' +
        'CHA,'
      ''
      #39'FACTURA'#39' as CTIPO, '#39'COD.6'#39' as NCTIPO,'
      ''
      '"Cliente".NOMBRE,  "Cliente".TITULAR, "Cliente".DIRECCION,'
      
        '"Cliente".DIRECCIONCOMERCIAL, "Cliente".IVA as CIVA, "Cliente".C' +
        'UIT as CCUIT,'
      ''
      
        '"Articulo".DESCRIPCION, "Articulo".UNIDAD, "Articulo".IVA as AIV' +
        'A,'
      ''
      
        '"OperacionItem".ARTICULO, "OperacionItem".CANTIDAD, "OperacionIt' +
        'em".COSTO AS VIDESCUENTO,'
      '"OperacionItem".PRECIO, "OperacionItem".OPERACION,'
      
        '("OperacionItem".PRECIO * "OperacionItem".CANTIDAD ) as PREXCANT' +
        ','
      '"OperacionItem".SERVICIO, "OperacionItem".DESCRIPCION AS DESCR,'
      
        '"OperacionItem".IMPUESTO as VIIMPUESTO, "Operacion".CODIGO, "Ope' +
        'racion".LETRA,'
      
        '"Operacion".FECHA, "Operacion".COMPROBANTE, "Operacion".TERMINOS' +
        ','
      
        '"Operacion".IVA3, "Operacion".TOTAL, "Operacion".CONTADO, "Opera' +
        'cion".CLIENTE,'
      
        '"Operacion".SUBTOTAL, "Operacion".DESCUENTO, "Operacion".IMPUEST' +
        'O,'
      
        '"Operacion".IVA2, "Operacion".IVA1, "Operacion".EXCENTO, "Operac' +
        'ion".SALDO,'
      '"Operacion".PAGADO, '#39'20121231237'#39'as CB'
      'FROM "Operacion"'
      
        '  INNER JOIN "OperacionItem" ON ("Operacion".CODIGO = "Operacion' +
        'Item".OPERACION)'
      
        '  INNER JOIN "Articulo" ON ("OperacionItem".ARTICULO = "Articulo' +
        '".CODIGO)'
      
        '  INNER JOIN "Cliente" ON ("Operacion".CLIENTE = "Cliente".CODIG' +
        'O)')
    Left = 447
  end
end
