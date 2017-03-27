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
  object frxDBDataset1: TfrxDBDataset
    UserName = 'frxDBDataset1'
    CloseDataSource = False
    DataSet = Query
    BCDToCurrency = False
    Left = 40
    Top = 120
  end
  object frxReport1: TfrxReport
    Version = '5.3.14'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39416.849051458300000000
    ReportOptions.LastChange = 42820.833085173600000000
    ReportOptions.Picture.Data = {
      0954474946496D61676547494638396150003200F70000FDFDFDFCFCFCFBFBFB
      F9F9F9030303FAFAFA010101F8F8F8020202040404F7F7F70606060505050707
      07080808F6F6F6090909F5F5F50A0A0A8585854141410D0D0DD0D0D0B9B9B9F3
      F3F30C0C0CF2F2F27B7B7BD7D7D7F0F0F0BFBFBFD4D4D4BABABAB5B5B5DEDEDE
      8282823F3F3F888888F4F4F4323232363636C9C9C95F5F5FA2A2A2B8B8B8C6C6
      C66262626969694C4C4CBEBEBE8C8C8CA5A5A5919191F1F1F16E6E6E8D8D8D24
      2424DCDCDCAEAEAE8A8A8AE4E4E49292927070707D7D7D8787872A2A2ACBCBCB
      2222228F8F8F5555554A4A4A3131317575757A7A7A3737371E1E1E8B8B8B1919
      199494941B1B1B1F1F1F434343C4C4C4D5D5D57C7C7C1A1A1AEDEDED90909012
      1212CDCDCD818181E2E2E25656568E8E8E939393C3C3C32C2C2C767676727272
      141414ACACACADADADB1B1B1CFCFCFB2B2B2E7E7E7DADADA6868689F9F9F4444
      444B4B4B585858161616717171D9D9D9404040525252A3A3A3E0E0E00E0E0E59
      5959B6B6B62121212020203434346D6D6D8383836464648989894F4F4F787878
      3C3C3CEBEBEBA8A8A80B0B0B1C1C1CECECEC656565EEEEEE3B3B3B4242429595
      95494949CECECEFEFEFE000000FEFAFAFFFFFF00000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000021FF0B584D50204461
      7461584D503C3F787061636B657420626567696E3D22EFBBBF222069643D2257
      354D304D7043656869487A7265537A4E54637A6B633964223F3E203C783A786D
      706D65746120786D6C6E733A783D2261646F62653A6E733A6D6574612F222078
      3A786D70746B3D2241646F626520584D5020436F726520352E302D6330363020
      36312E3133343737372C20323031302F30322F31322D31373A33323A30302020
      202020202020223E203C7264663A52444620786D6C6E733A7264663D22687474
      703A2F2F7777772E77332E6F72672F313939392F30322F32322D7264662D7379
      6E7461782D6E7323223E203C7264663A4465736372697074696F6E207264663A
      61626F75743D222220786D6C6E733A786D703D22687474703A2F2F6E732E6164
      6F62652E636F6D2F7861702F312E302F2220786D6C6E733A786D704D4D3D2268
      7474703A2F2F6E732E61646F62652E636F6D2F7861702F312E302F6D6D2F2220
      786D6C6E733A73745265663D22687474703A2F2F6E732E61646F62652E636F6D
      2F7861702F312E302F73547970652F5265736F75726365526566232220786D70
      3A43726561746F72546F6F6C3D2241646F62652050686F746F73686F70204353
      352057696E646F77732220786D704D4D3A496E7374616E636549443D22786D70
      2E6969643A333037333134413332453239313145304241443846414239423037
      41414243352220786D704D4D3A446F63756D656E7449443D22786D702E646964
      3A33303733313441343245323931314530424144384641423942303741414243
      35223E203C786D704D4D3A4465726976656446726F6D2073745265663A696E73
      74616E636549443D22786D702E6969643A333037333134413132453239313145
      3042414438464142394230374141424335222073745265663A646F63756D656E
      7449443D22786D702E6469643A33303733313441323245323931314530424144
      38464142394230374141424335222F3E203C2F7264663A446573637269707469
      6F6E3E203C2F7264663A5244463E203C2F783A786D706D6574613E203C3F7870
      61636B657420656E643D2272223F3E01FFFEFDFCFBFAF9F8F7F6F5F4F3F2F1F0
      EFEEEDECEBEAE9E8E7E6E5E4E3E2E1E0DFDEDDDCDBDAD9D8D7D6D5D4D3D2D1D0
      CFCECDCCCBCAC9C8C7C6C5C4C3C2C1C0BFBEBDBCBBBAB9B8B7B6B5B4B3B2B1B0
      AFAEADACABAAA9A8A7A6A5A4A3A2A1A09F9E9D9C9B9A99989796959493929190
      8F8E8D8C8B8A898887868584838281807F7E7D7C7B7A79787776757473727170
      6F6E6D6C6B6A696867666564636261605F5E5D5C5B5A59585756555453525150
      4F4E4D4C4B4A494847464544434241403F3E3D3C3B3A39383736353433323130
      2F2E2D2C2B2A292827262524232221201F1E1D1C1B1A19181716151413121110
      0F0E0D0C0B0A090807060504030201000021F90400000000002C000000005000
      320087FDFDFDFCFCFCFBFBFBF9F9F9030303FAFAFA010101F8F8F80202020404
      04F7F7F7060606050505070707080808F6F6F6090909F5F5F50A0A0A85858541
      41410D0D0DD0D0D0B9B9B9F3F3F30C0C0CF2F2F27B7B7BD7D7D7F0F0F0BFBFBF
      D4D4D4BABABAB5B5B5DEDEDE8282823F3F3F888888F4F4F4323232363636C9C9
      C95F5F5FA2A2A2B8B8B8C6C6C66262626969694C4C4CBEBEBE8C8C8CA5A5A591
      9191F1F1F16E6E6E8D8D8D242424DCDCDCAEAEAE8A8A8AE4E4E4929292707070
      7D7D7D8787872A2A2ACBCBCB2222228F8F8F5555554A4A4A3131317575757A7A
      7A3737371E1E1E8B8B8B1919199494941B1B1B1F1F1F434343C4C4C4D5D5D57C
      7C7C1A1A1AEDEDED909090121212CDCDCD818181E2E2E25656568E8E8E939393
      C3C3C32C2C2C767676727272141414ACACACADADADB1B1B1CFCFCFB2B2B2E7E7
      E7DADADA6868689F9F9F4444444B4B4B585858161616717171D9D9D940404052
      5252A3A3A3E0E0E00E0E0E595959B6B6B62121212020203434346D6D6D838383
      6464648989894F4F4F7878783C3C3CEBEBEBA8A8A80B0B0B1C1C1CECECEC6565
      65EEEEEE3B3B3B424242959595494949CECECEFEFEFE000000FEFAFAFFFFFF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000008FF0027091C48B0A0C18308132A5CC8B0A1C38710234A9C48B1A2C58B
      18336ADCC8B1A3C78F20438A1C49B2A4C9932853AA5CC9B2A5CB973031069824
      6012A499902001B0C97367809C05670ADCB973120005037722B5294028D14905
      6C1285343080D0A193ACEED42970668449030616A01A00C001B050BBD6CCBAB6
      C0CE02070EAC057B552055A36767AE157A372755484D01DCB51B74A087092818
      2488E420D2A1128DA81EA82150C0DD0E54C33A1D3B508164B403D60ED83AD868
      E901912211205074E903AA5F217120B1C040EAD40616A71E026260D89A7E6084
      B05B736E01CE46273D986482E7A4D859E97605BC5300EE48359F0A3C2B778EED
      062F5A6CFFCF11267502027226619874C0472404915880F589B52B5AA3570320
      D50B3A2CD69D9130404024DB09A4C0593C6D919A2191082594152A64A09A0F84
      5190DA026844C71F2403F85719553545459340050410566995FD741B8176F115
      D5008A0C1160242E5C2018244B35E79C0B033AB05863197C30501A315011047C
      A949A0C50C00CCD4C1570728D0C506B6DD3688136A60B5E27393B0A1476A0C50
      50064D342C108904AAA506880C135485562203AE089F083349C1C87BE6A5C940
      2441E4B19602203C91E662662E56010D3C9947C0003C44011F0170F440134E17
      1831207CF03530E3047660F5802317C650D34C5954D018016B886013211BA486
      80014250FF95027C8B5D21E20550D8E6000835A5098117915449072236DD35D3
      0190AC3002120668EAEAAB37D867616A1E6C15001E55463B222407CC70E11102
      09626624236890D6400270F680A6032A669B0153A02500006121B894721CC840
      816E6350A6410130A429DF4027A4E9415904E5C0586A54B5116C249256471369
      5181A95B240D1850410A3F09C44724663211DBBD05A89600021644A7049017B0
      3753119A66608369804D4204049124E0C67271B8DAC7244835090000F30A3440
      9C9104F2C10EB7E120425402905125013FC4CA56216F2C001F0568296043CE91
      009116248F800D810A3C34D58118155CF8854D1CE0CCD80B3C5980426A0D9490
      5524383BF0B0D40608BCBAC4004815504715B711B0E79917466244CA36154004
      029ABEBA800E467DB048CEABC5D958242488774054663401669A8C4792C47193
      D8B627BA45547982B9353DB0C20F382409DF025C0071867634957047C67CEB40
      9560214CB0C79E0B3080C50821ACB7954018ECF0C7AB981E318105CBA9579B6A
      68450586A61090F017419955C72D71EC1166AF9B1CB63FEFF19509F4955404F1
      85957FD317B553739208A0000748C0021AF080084CA00217C8C0063AF081108C
      A0042748C10A5AF08218CCA00637C8C10E7AF083200CA1084748C2129AF08428
      4CA10A57C8C216BAF085308CA10C6748C31A8A3020003B}
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    OnBeforePrint = frxReport1BeforePrint
    Left = 40
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
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      PrintOnPreviousPage = True
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Top = 18.897650000000000000
        Width = 718.110700000000000000
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Top = 423.307360000000000000
        Width = 718.110700000000000000
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 211.653680000000000000
        Width = 718.110700000000000000
        DataSet = frxDBDataset1
        DataSetName = 'frxDBDataset1'
        RowCount = 1
        object Memo10: TfrxMemoView
          Left = 113.385900000000000000
          Top = 0.000000000000008479
          Width = 302.362400000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'DESCRIPCION')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 567.709030000000000000
          Top = 0.000000000000008479
          Width = 75.370130000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'CANT.')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 642.520100000000000000
          Top = 0.000000000000008479
          Width = 75.370130000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'PRECIO')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Top = 0.000000000000008479
          Width = 113.165430000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'CODIGO')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 491.338900000000000000
          Top = 0.000000000000008479
          Width = 75.370130000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'P.UNIT.')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 415.748300000000000000
          Top = 0.000000000000008479
          Width = 75.370130000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'UNIDAD')
          ParentFont = False
        end
      end
      object DetailData1: TfrxDetailData
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 253.228510000000000000
        Width = 718.110700000000000000
        DataSet = frxDBDataset1
        DataSetName = 'frxDBDataset1'
        RowCount = 0
        object Memo15: TfrxMemoView
          Left = 113.385900000000000000
          Top = -0.000000000000000014
          Width = 302.362400000000000000
          Height = 18.897650000000000000
          DataSetName = 'FacturafrxDBDataset'
          Memo.UTF8W = (
            '[frxDBDataset1."DESCRIPCION"]')
        end
        object Memo16: TfrxMemoView
          Left = 567.709030000000000000
          Top = -0.000000000000000014
          Width = 75.370130000000000000
          Height = 18.897650000000000000
          DataSetName = 'FacturafrxDBDataset'
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBDataset1."CANTIDAD"]')
        end
        object Memo8: TfrxMemoView
          Left = 642.520100000000000000
          Top = -0.000000000000000014
          Width = 75.370130000000000000
          Height = 18.897650000000000000
          DataSetName = 'FacturafrxDBDataset'
          HAlign = haCenter
          Memo.UTF8W = (
            '[(<frxDBDataset1."CANTIDAD">*<frxDBDataset1."PRECIO">)]')
        end
        object Memo12: TfrxMemoView
          Left = 3.000000000000000000
          Top = -0.000000000000000014
          Width = 111.165430000000000000
          Height = 18.897650000000000000
          DataSetName = 'FacturafrxDBDataset'
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBDataset1."ARTICULO"]')
        end
        object Memo1: TfrxMemoView
          Left = 491.338900000000000000
          Top = -0.000000000000000014
          Width = 75.370130000000000000
          Height = 18.897650000000000000
          DataSetName = 'FacturafrxDBDataset'
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBDataset1."PRECIO"]')
        end
        object Memo18: TfrxMemoView
          Left = 415.748300000000000000
          Top = -0.000000000000000014
          Width = 75.370130000000000000
          Height = 18.897650000000000000
          DataSetName = 'FacturafrxDBDataset'
          HAlign = haCenter
          Memo.UTF8W = (
            '[(<frxDBDataset1."UNIDAD">)]')
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 68.031540000000000000
        Top = 294.803340000000000000
        Width = 718.110700000000000000
        object Shape3: TfrxShapeView
          Top = -0.000000000000008493
          Width = 716.890230000000000000
          Height = 52.913420000000000000
        end
        object Memo13: TfrxMemoView
          Left = 455.543600000000000000
          Top = 11.338590000000000000
          Width = 260.787570000000000000
          Height = 30.236240000000000000
          DataSetName = 'FacturafrxDBDataset'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '$[frxDBDataset1."TOTAL"]')
          ParentFont = False
        end
        object frxDBDataset1PAGADO: TfrxMemoView
          Top = -0.000000000000008493
          Width = 188.976500000000000000
          Height = 18.897650000000000000
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'PAGADO: [frxDBDataset1."PAGADO"]')
          ParentFont = False
        end
        object frxDBDataset1SALDO: TfrxMemoView
          Top = 34.015769999999970000
          Width = 188.976500000000000000
          Height = 18.897650000000000000
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'SALDO: [frxDBDataset1."SALDO"]')
          ParentFont = False
        end
        object frxDBDataset1IVA1: TfrxMemoView
          Left = 188.976500000000000000
          Top = -0.000000000000008493
          Width = 151.181200000000000000
          Height = 18.897650000000000000
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'IVA10,5%: [frxDBDataset1."IVA1"]')
          ParentFont = False
        end
        object frxDBDataset1IVA2: TfrxMemoView
          Left = 188.976500000000000000
          Top = 34.015769999999970000
          Width = 151.181200000000000000
          Height = 18.897650000000000000
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'IVA21%: [frxDBDataset1."IVA2"]')
          ParentFont = False
        end
      end
      object GroupHeader2: TfrxGroupHeader
        FillType = ftBrush
        Height = 109.606370000000000000
        Top = 79.370130000000000000
        Width = 718.110700000000000000
        Condition = 'frxDBDataset1."OPERACION"'
        object Shape1: TfrxShapeView
          Top = 0.000000000000003178
          Width = 718.110700000000000000
          Height = 109.606370000000000000
        end
        object Memo4: TfrxMemoView
          Left = 302.362400000000000000
          Top = 0.000000000000003178
          Width = 75.590600000000000000
          Height = 56.692950000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -48
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBDataset1."LETRA"]')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 531.268090000000000000
          Top = 30.118120000000010000
          Width = 184.622140000000000000
          Height = 25.574830000000000000
          DataSetName = 'FacturafrxDBDataset'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'nro.[frxDBDataset1."CODIGO"]')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 421.661720000000000000
          Top = 56.692950000000010000
          Width = 294.228510000000000000
          Height = 24.015770000000000000
          DataSetName = 'FacturafrxDBDataset'
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset1."FECHA"]')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Left = 298.582870000000000000
          Top = 56.692950000000010000
          Width = 83.149660000000000000
          Height = 37.795300000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 14211288
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'DOCUMENTO NO VALIDO COMO FACTURA')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 68.031540000000000000
          Top = 90.708720000000010000
          Width = 524.231293330000000000
          Height = 14.236240000000000000
          DataSetName = 'FacturafrxDBDataset'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDataset1."NOMBRE"], [frxDBDataset1."DIRECCION"]')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo6: TfrxMemoView
          Left = 2.897650000000000000
          Top = 90.708720000000010000
          Width = 65.133890000000000000
          Height = 14.236240000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CLIENTE:')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo43: TfrxMemoView
          Left = 530.693260000000000000
          Top = 1.000000000000003000
          Width = 185.196970000000000000
          Height = 26.456710000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clSilver
          Font.Height = -21
          Font.Name = 'Bauhaus 93'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'ORIGINAL')
          ParentFont = False
        end
        object Picture1: TfrxPictureView
          Left = 2.779530000000000000
          Top = 2.779529999999997000
          Width = 260.787570000000000000
          Height = 68.031540000000000000
          HightQuality = False
          Transparent = False
          TransparentColor = clWhite
        end
      end
    end
  end
  object frxBarCodeObject1: TfrxBarCodeObject
    Left = 184
    Top = 88
  end
  object frxDotMatrixExport1: TfrxDotMatrixExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    EscModel = 0
    GraphicFrames = False
    SaveToFile = False
    UseIniSettings = True
    Left = 176
    Top = 8
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
    Left = 272
    Top = 88
  end
  object frxHTMLExport1: TfrxHTMLExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    FixedWidth = True
    Background = False
    Centered = False
    EmptyLines = True
    Print = False
    PictureType = gpPNG
    Left = 184
    Top = 160
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
    Left = 272
    Top = 160
  end
  object frxChartObject1: TfrxChartObject
    Left = 360
    Top = 8
  end
  object frxOLEObject1: TfrxOLEObject
    Left = 352
    Top = 88
  end
  object frxRichObject1: TfrxRichObject
    Left = 352
    Top = 160
  end
  object frxCheckBoxObject1: TfrxCheckBoxObject
    Left = 440
    Top = 8
  end
  object frxGradientObject1: TfrxGradientObject
    Left = 440
    Top = 88
  end
  object frxDotMatrixExport2: TfrxDotMatrixExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    EscModel = 0
    GraphicFrames = False
    SaveToFile = False
    UseIniSettings = True
    Left = 440
    Top = 160
  end
  object frxGZipCompressor1: TfrxGZipCompressor
    Left = 520
    Top = 160
  end
  object frxCrypt1: TfrxCrypt
    Left = 272
    Top = 8
  end
  object FirebirdConnection: TFDConnection
    Params.Strings = (
      'ConnectionDef=Firebird')
    LoginPrompt = False
    Left = 823
    Top = 403
  end
  object VentasFDQuery1: TFDQuery
    Connection = FirebirdConnection
    SQL.Strings = (
      
        '     SELECT '#39'CIVELOO'#39' as Empresa, "Cliente".NOMBRE,  "Cliente".T' +
        'ITULAR,'
      '      "Cliente".DIRECCION,   "Cliente".DIRECCIONCOMERCIAL,'
      '      "Articulo".DESCRIPCION, "Articulo".UNIDAD,'
      '      "VentaItem".ARTICULO,   "VentaItem".CANTIDAD,'
      '      "VentaItem".PRECIO,    "VentaItem".OPERACION,'
      '      ("VentaItem".PRECIO * "VentaItem".CANTIDAD ) as PREXCANT,'
      '      "VentaItem".SERVICIO,   "VentaItem".DESCRIPCION AS DESCR,'
      '      "Venta".CODIGO,   "Venta".LETRA,   "Venta".FECHA,'
      '      "Venta".COMPROBANTE,   "Venta".IVA3,   "Venta".TOTAL,'
      '      "Venta".CONTADO,   "Venta".CLIENTE,   "Venta".SUBTOTAL,'
      '      "Venta".DESCUENTO,   "Venta".IMPUESTO,   "Venta".IVA2,'
      '      "Venta".IVA1,   "Venta".EXCENTO,   "Venta".SALDO,'
      '      "Venta".PAGADO  FROM   "Venta"'
      
        '      INNER JOIN "VentaItem" ON ("Venta".CODIGO = "VentaItem".OP' +
        'ERACION)'
      
        '      INNER JOIN "Articulo" ON ("VentaItem".ARTICULO = "Articulo' +
        '".CODIGO)'
      
        '      INNER JOIN "Cliente" ON ("Venta".CLIENTE = "Cliente".CODIG' +
        'O)'
      'WHERE'
      '    ("Venta".CODIGO = 2 ) ')
    Left = 824
    Top = 8
  end
  object FDQuery1: TFDQuery
    Connection = FirebirdConnection
    SQL.Strings = (
      'SELECT '
      '  CODIGO,'
      '  DESCRIPCION,'
      '  CODIGOBARRA,'
      '  5 AS Cantidad  '
      'FROM '
      '  "Articulo" '
      'WHERE'
      '  Codigo = 1;')
    Left = 824
    Top = 64
  end
end
