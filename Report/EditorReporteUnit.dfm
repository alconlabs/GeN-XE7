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
      'CODIGO=CODIGO'
      'FECHA=FECHA'
      'FACTURA=FACTURA'
      'CLIENTE=CLIENTE'
      'CUIT=CUIT'
      'CONDICION=CONDICION'
      'NG1=NG1'
      'NG2=NG2'
      'NG3=NG3'
      'IVA1=IVA1'
      'IVA2=IVA2'
      'IVA3=IVA3'
      'OEIIBB=OEIIBB'
      'IDERPYPAC=IDERPYPAC'
      'ITF=ITF'
      'CBTETIPO=CBTETIPO'
      'PTOVTA=PTOVTA'
      'CBTEDESDE=CBTEDESDE'
      'CBTEHASTA=CBTEHASTA'
      'DOCTIPO=DOCTIPO'
      'NOMCLI=NOMCLI'
      'MONID=MONID'
      'MONCOTIZ=MONCOTIZ'
      'CANTIVA=CANTIVA'
      'OPCION=OPCION'
      'FCHVTOPAGO=FCHVTOPAGO'
      'ALICIVA=ALICIVA'
      'IMPNETO=IMPNETO'
      'NOGRABADO=NOGRABADO'
      'IMPOPEX=IMPOPEX'
      'IMPIVA=IMPIVA'
      'GENERALES=GENERALES'
      'NOCAT=NOCAT'
      'IMPTRIB=IMPTRIB')
    DataSet = tLibroIVAventa
    BCDToCurrency = False
    Left = 24
    Top = 16
  end
  object frxCSVExport1: TfrxCSVExport
    FileName = '.csv'
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    CreationTime = 43670.876897210650000000
    DataOnly = True
    Separator = ','
    OEMCodepage = False
    UTF8 = True
    OpenAfterExport = True
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
    ReportOptions.CreateDate = 43670.750645671300000000
    ReportOptions.LastChange = 43670.877400601900000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      ''
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
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      Frame.Typ = []
      object ReportTitle1: TfrxReportTitle
        FillType = ftBrush
        Frame.Typ = []
        Top = 18.897650000000000000
        Width = 1046.929810000000000000
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Frame.Typ = []
        Top = 79.370130000000000000
        Width = 1046.929810000000000000
        DataSet = frxDBDataset1
        DataSetName = 'frxDBDataset1'
        RowCount = 0
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Frame.Typ = []
        Top = 173.858380000000000000
        Width = 1046.929810000000000000
      end
      object DetailData1: TfrxDetailData
        FillType = ftBrush
        Frame.Typ = []
        Height = 11.338590000000000000
        Top = 102.047310000000000000
        Width = 1046.929810000000000000
        DataSet = frxDBDataset1
        DataSetName = 'frxDBDataset1'
        RowCount = 0
        object frxDBDataset1FECHA: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Width = 1046.929810000000000000
          Height = 11.338590000000000000
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            
              '[FormatDateTime('#39'yymmdd'#39',<frxDBDataset1."FECHA">)][FormatFloat('#39 +
              '000'#39',<frxDBDataset1."PTOVTA">)][FormatFloat('#39'0000000000000000000' +
              '0'#39',<frxDBDataset1."CBTEDESDE">)][FormatFloat('#39'000000000000000000' +
              '00'#39',<frxDBDataset1."CBTEHASTA">)][FormatFloat('#39'00'#39',<frxDBDataset' +
              '1."DOCTIPO">)][FormatMaskText('#39'00000000000000000000'#39',<frxDBDatas' +
              'et1."CUIT">)][FormatMaskText('#39'000000000000000000000000000000'#39',<f' +
              'rxDBDataset1."NOMCLI">)][FormatFloat('#39'00000000000'#39',<frxDBDataset' +
              '1."DOCTIPO">)][FormatFloat('#39'000000000000000'#39',<frxDBDataset1."ITF' +
              '">)][FormatFloat('#39'000000000000000'#39',<frxDBDataset1."NOGRABADO">)]' +
              '[FormatFloat('#39'000000000000000'#39',<frxDBDataset1."IMPOPEX">)][Forma' +
              'tFloat('#39'000000000000000'#39',<frxDBDataset1."IMPIVA">)][FormatFloat(' +
              #39'000000000000000'#39',<frxDBDataset1."GENERALES">)][FormatFloat('#39'000' +
              '000000000000'#39',<frxDBDataset1."NOCAT">)][FormatFloat('#39'00000000000' +
              '0000'#39',<frxDBDataset1."OEIIBB">)][FormatFloat('#39'000000000000000'#39',<' +
              'frxDBDataset1."IMPTRIB">)][FormatFloat('#39'000000000000000'#39',<frxDBD' +
              'ataset1."IDERPYPAC">)][frxDBDataset1."MONID"][FormatFloat('#39'0000'#39 +
              ',<frxDBDataset1."MONCOTIZ">)]000000[FormatFloat('#39'000000000000000' +
              #39',<frxDBDataset1."OPCION">)][FormatFloat('#39'00000000'#39',<frxDBDatase' +
              't1."FCHVTOPAGO">)]')
          ParentFont = False
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
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
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
  object tLibroIVAventa: TFDQuery
    Active = True
    Connection = FirebirdConnection
    SQL.Strings = (
      'SELECT * from "LibroIVAventa"')
    Left = 447
    Top = 48
  end
end
