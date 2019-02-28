object FProductos: TFProductos
  Left = 259
  Top = 164
  BorderIcons = [biSystemMenu, biMinimize, biMaximize, biHelp]
  BorderStyle = bsSingle
  Caption = 'Altas, Bajas y Modificaciones de Articulos'
  ClientHeight = 468
  ClientWidth = 794
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  OnKeyUp = FormKeyUp
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 656
    Height = 468
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    TabStop = False
    object TabSheet1: TTabSheet
      Caption = 'Detalles'
      object Label2: TLabel
        Left = 14
        Top = 82
        Width = 68
        Height = 13
        Alignment = taRightJustify
        Caption = 'Descripci'#243'n'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label14: TLabel
        Left = 41
        Top = 176
        Width = 42
        Height = 13
        Caption = 'Cantidad'
      end
      object Label23: TLabel
        Left = 34
        Top = 140
        Width = 49
        Height = 13
        Caption = 'Proveedor'
      end
      object Label8: TLabel
        Left = 454
        Top = 85
        Width = 59
        Height = 13
        Caption = 'Tasa de IVA'
      end
      object Label19: TLabel
        Left = 490
        Top = 61
        Width = 23
        Height = 13
        Caption = 'Flete'
      end
      object Label30: TLabel
        Left = 590
        Top = 85
        Width = 8
        Height = 13
        Caption = '%'
      end
      object Label10: TLabel
        Left = 56
        Top = 208
        Width = 27
        Height = 13
        Caption = 'Costo'
        FocusControl = CostoDBEdit
      end
      object Label5: TLabel
        Left = 448
        Top = 155
        Width = 65
        Height = 13
        Caption = 'Costo + Flete:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object DBText1: TDBText
        Left = 519
        Top = 155
        Width = 106
        Height = 17
        DataSource = DataSource
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label16: TLabel
        Left = 468
        Top = 195
        Width = 29
        Height = 16
        Caption = 'IVA:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label28: TLabel
        Left = 590
        Top = 61
        Width = 8
        Height = 13
        Caption = '%'
      end
      object Label21: TLabel
        Left = 687
        Top = 64
        Width = 3
        Height = 13
      end
      object Label4: TLabel
        Left = 485
        Top = 242
        Width = 28
        Height = 13
        Caption = 'Neto'
        FocusControl = PrecioCtaCteDBEdit
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label33: TLabel
        Left = 467
        Top = 114
        Width = 46
        Height = 13
        Caption = 'Ganancia'
        FocusControl = GanaciaDBEdit
      end
      object Label34: TLabel
        Left = 590
        Top = 112
        Width = 8
        Height = 13
        Caption = '%'
      end
      object DBText2: TDBText
        Left = 519
        Top = 189
        Width = 144
        Height = 29
        DataSource = DataSource
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -19
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label24: TLabel
        Left = 14
        Top = 61
        Width = 76
        Height = 13
        Caption = 'Codigo de Barra'
      end
      object PaintBox1: TImage
        Left = 228
        Top = 11
        Width = 120
        Height = 69
        AutoSize = True
        Center = True
        ParentShowHint = False
        Picture.Data = {
          0A544A504547496D616765BE0D0000FFD8FFE000104A46494600010101006000
          600000FFDB004300020101020101020202020202020203050303030303060404
          0305070607070706070708090B0908080A0807070A0D0A0A0B0C0C0C0C07090E
          0F0D0C0E0B0C0C0CFFDB004301020202030303060303060C0807080C0C0C0C0C
          0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C
          0C0C0C0C0C0C0C0C0C0C0C0C0CFFC00011080045007803012200021101031101
          FFC4001F0000010501010101010100000000000000000102030405060708090A
          0BFFC400B5100002010303020403050504040000017D01020300041105122131
          410613516107227114328191A1082342B1C11552D1F02433627282090A161718
          191A25262728292A3435363738393A434445464748494A535455565758595A63
          6465666768696A737475767778797A838485868788898A92939495969798999A
          A2A3A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6
          D7D8D9DAE1E2E3E4E5E6E7E8E9EAF1F2F3F4F5F6F7F8F9FAFFC4001F01000301
          01010101010101010000000000000102030405060708090A0BFFC400B5110002
          0102040403040705040400010277000102031104052131061241510761711322
          328108144291A1B1C109233352F0156272D10A162434E125F11718191A262728
          292A35363738393A434445464748494A535455565758595A636465666768696A
          737475767778797A82838485868788898A92939495969798999AA2A3A4A5A6A7
          A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6D7D8D9DAE2E3
          E4E5E6E7E8E9EAF2F3F4F5F6F7F8F9FAFFDA000C03010002110311003F00FDFC
          AE7F50F8B1E15D27C776BE16BBF13787ED7C4F7A2236FA44BA8C297F3F9B1DDC
          B16C80B798DBE3D3EFDD703E65B2B92322190AF415F007ED0FFF0029D1F865FF
          00729FFEA3DF176803EC0B6FDAC7E165EFFC243E4FC4BF87F37FC225FDA9FDB9
          B3C4366DFD8DFD99E47F697DA7127EE7EC7F69B6FB4799B7C9FB445E66DDEB9B
          FA27ED0DE00F12DFE8969A6F8E7C1DA85D789AD6D6FB4786DB59B6964D56DEEA
          0BAB9B59ADD55C99639A0B1BD96364C878ECEE1D49589CAFE197C32E9FF0505F
          FBB9CFFDD2ABDFBF620FF9389FD877FEC95FC2AFFD423E29D007E98E8BFB6D7C
          18F127C1FD5BE21E9DF177E186A1E00D02E858EA7E26B6F14D8CBA3E9D704C40
          4335DACA618E4FDFC1F2B303FBE8F8F99737BC49FB58FC2BF06F8775FD6358F8
          97F0FF004AD27C29B3FB6EF6F3C436705B68FBEFAE34F5FB4C8D2058775EDADD
          5A8DE4667B69A2FBF1B28FE713F63BFF009537FF006B0FFB2A9A7FFE94F852BD
          F7FE0A35FF0028ECFDBEBFEE17FF00ABBFC7B401FB5FE26FDB73E0BF82FE1FC7
          E2DD67E2EFC30D27C2B35D5B58A6B37BE29B1B7D3DEE2E6C92FEDE113BCA2332
          4B672C7728BBB2F0C8922828C189E3BFDB77E0BFC2DB0B9BBF13FC5EF85FE1CB
          5B3BAFB0CF36A9E2AB1B38E0B8FB45E5B792CD24A02C9E7E9DA845B4F3E658DC
          A63743205FE747FE0A59FF002AF97867FECA9FC38FFD537A251FF05E4FF9374F
          891FF65523FF00D4E3E32D007F47DE2DFDAC7E167807C73A7785F5DF897F0FF4
          5F136B1AA8D0AC349BFF0010D9DB5F5EEA063B69059C50BC81DEE3CBBDB37F29
          417DB7701C62542C597ED61F0B352F8A5A7781ADBE25FC3FB8F1B6B1F6AFB078
          7E3F10D9BEAB7BF6596E61B9F2AD849E6BF932D9DE4726D53B1ED2756C18DC0F
          C40FF82B77FCA74FF677FF00B3A9B4FF00D47BE1852FC1BFF95A5FF674FA7C54
          FF00D4BFE23D007ED7691FB6E7C17F106A1AB5A69FF177E185F5DE83A08F156A
          70DBF8A6C65934ED1CC115C0D4A6559498ED0C17104BE7B623F2E68DB76D7527
          AFF09FC5BF0A78F758D474ED0BC4DE1ED6B50D233F6EB6B0D461B99ACB175756
          67CD446253FD2ACAF20F980FDEDA4E9F7A270BFCD17EC6FF00F2713FB587FD98
          0D8FFEA11E14AFD7DFF8247FFC9E17ED0FFF006F7FFAB3BE27D007D63E19FDB7
          3E0BF8D3E1FC9E2DD1BE2EFC30D5BC2B0DD5CD8BEB365E29B1B8D3D2E2DAC9EF
          EE2133A4A6312456714972EBBB290C6F23008A5877FE19F16E95E34D364BCD1B
          53D3F56B386EEE6C249ECAE12E224B8B69E4B7B884B21204914F14B13A1E5248
          DD58065207F325FF0004D3FF00957CBC4DFF00654FE23FFEA9BD6EBF7F7FE09A
          5FF26EDE24FF00B2ABF11FFF00537D72803E80A28A2800AF803F687FF94E8FC3
          2FFB94FF00F51EF8BB5F7FD7C01FB43FFCA747E197FDCA7FFA8F7C5DA00F807E
          1974FF008282FF00DDCE7FEE955EFDFB107FC9C4FEC3BFF64AFE157FEA11F14E
          BC07E1974FF8282FFDDCE7FEE955EFDFB107FC9C4FEC3BFF0064AFE157FEA11F
          14E803E03FD8EFFE54DFFDAC3FECAA69FF00FA53E14AF7DFF828D7FCA3B3F6FA
          FF00B85FFEAEFF001ED7817EC77FF2A6FF00ED61FF0065534FFF00D29F0A57BE
          FF00C146BFE51D9FB7D7FDC2FF00F577F8F6803C03FE0A59FF002AF97867FECA
          9FC38FFD537A251FF05E4FF9374F891FF65523FF00D4E3E32D1FF052CFF957CB
          C33FF654FE1C7FEA9BD128FF0082F27FC9BA7C48FF00B2A91FFEA71F196803DF
          FF00E0ADDFF29D3FD9DFFECEA6D3FF0051EF8614BF06FF00E5697FD9D3E9F153
          FF0052FF0088F49FF056EFF94E9FECEFFF00675369FF00A8F7C30A5F837FF2B4
          BFECE9F4F8A9FF00A97FC47A00F9FF00F637FF009389FDAC3FECC06C7FF508F0
          A57EBEFF00C123FF00E4F0BF687FFB7BFF00D59DF13EBF20BF637FF9389FDAC3
          FECC06C7FF00508F0A57EBEFFC123FFE4F0BF687FF00B7BFFD59DF13E803F20B
          FE09A7FF002AF9789BFECA9FC47FFD537ADD7EFEFF00C134BFE4DDBC49FF0065
          57E23FFEA6FAE57E017FC134FF00E55F2F137FD953F88FFF00AA6F5BAFDFDFF8
          2697FC9BB7893FECAAFC47FF00D4DF5CA00FA028A28A002BE00FDA1FFE53A3F0
          CBFEE53FFD47BE2ED7DFF5F007ED0FFF0029D1F865FF00729FFEA3DF176803E0
          1F865D3FE0A0BFF7739FFBA557BF7EC41FF2713FB0EFFD92BF855FFA847C53AF
          3EF027ECA5F14ECC7EDC05FE1AF8FADFFE12C3FB42FF0062F99E1FBCFF0089DF
          F6A7FC221FD9FF0066FDDFEFFEDBF679FECFE5E7CDFB34BB37F96F5ED3FB1E7E
          CFBE3DF0C7C73FD902EF52F0478CB4FB2F0D7C39F86F63AC4D77A45C451E9335
          9F847E235BDC453929FBA9229EFECA39124C18E4BCB743CCA9401F9B7FB1DFFC
          A9BFFB587FD954D3FF00F4A7C295EFBFF051AFF94767EDF5FF0070BFFD5DFE3D
          AE43F657FD89BE327867FE0D53FDA6BE1E6A7F08FE27D8FC41D7FE2459DEE9BE
          18B9F0C5E47ABDFDB8BAF0E132DBD998FCD923C413FEF1131FBA93FE799AF6DF
          DBB7F655F8A7E2EFD84FF6D4D1F47F86BE3FD5B59F167F67FF0062D95A787EF2
          7BAD6427C5DF19EA0FF67448F33FFA15DDBDC9F2F3FE8F7314BF72442403E42F
          F82967FCABE5E19FFB2A7F0E3FF54DE8947FC1793FE4DD3E247FD9548FFF0053
          8F8CB5EA5FB7CFEC49F19BC61FF0444D03C25A57C22F899ABF8A6DFE23F812F6
          5D1ACFC2F7D737F1C16DF09F46D3E794DBA4664F2A3BC8E5B6924C62396378CF
          CE08AE7BFE0AD9FB3DF8EBF692F849F14344F877E09F1878EF5BB4F88E97F716
          3E1ED1AE756BA8ADC78E3E31466578A0477118792343274CC8838245007A77FC
          15BBFE53A7FB3BFF00D9D4DA7FEA3DF0C297E0DFFCAD2FFB3A7D3E2A7FEA5FF1
          1EBBCFF829A7ECABF14BE217FC1647E0578ABC3DF0DBC7DADF86B44FDA42DB5C
          BFD5AC3C3F77716165A7FF0061FC3B8CDECB3A46634B7F32CEF10CA4ECCD9CFD
          E2930BF0B3F657F8A7A77FC1C6FF0001FC7137C35F1F5B781F453F120DF78824
          F0FDE47A658FDB3C4DE3CB8B7325C18FCA4F362BBB4923C9FDE25D5B91C4A990
          0F90BF637FF9389FDAC3FECC06C7FF00508F0A57EBEFFC123FFE4F0BF687FF00
          B7BFFD59DF13EBF353F658FD8A3E33F873E3B7ED2D77A87C24F89B6369AE7EC4
          D69E14D3279FC2F79147A86AFF00F088F872DCE9B0131E24BC13DBCF1FD9D332
          0922913198CD7EA37FC1317E14F89FE1FF00ED4FF1D751D77C33E20D0F4ED5CD
          CFD82EAFF4F96DA1BDFF008B87F112F0794F20024CDB5E59DC704FEEEF2093EE
          4B19201F8CFF00F04D3FF957CBC4DFF654FE23FF00EA9BD6EBF7F7FE09A5FF00
          26EDE24FFB2ABF11FF00F537D72BF117F634FD94FE287C0EFF008208F8BF4DF1
          AFC37F1EF842FB4BF1F7C41D76F2DB59F0F5DE9D3DA69F27C27D6AD23BD96396
          306381EE648EDC48711F9B208C1DF5FB75FF0004D2FF009376F127FD955F88FF
          00FA9BEB9401F405145140057CFDF113F6187F1DFEDD9E18F8D4BE285B55F0EF
          F6467463A6EF371F60D3FC5D67FEBFCD1B7CCFF84AB7FF00AB3B7EC3B79F3B31
          7D03450046B6CBF2961961927048524F538CFF003E94A2DD32495C938EA49E87
          23AFBD3E8A006B42ADB720E14E40C903A639F51CF43FD291EDA3756054FCC08C
          824119EB83D4741D29F4500417164B2C655098C9C1041C63073C0E9D7FFAF9E9
          5E07FB237EC243F65AF8C3F107C5ADE271AE9F1E79C7ECA34EFB28D3FCCF1378
          9B5EC07F35FCC00F88FC8FBABFF1E424FF0096BB22FA0E8A008BEC71E0F0FF00
          375F9CE7AE7D7FC8E3A53DA156DB9070A7206481D31CFA8E7A1FE94EA28019F6
          68F7642853CF4E3AF5E947D9D37EEC1048DBC1238FF3F973EA69F450079CFED6
          5F0047ED3FFB307C49F86EBAA7F619F887E16D4FC3475136E2E869FF006CB49A
          DFCFF28B2F9BB0CBBF66F4DDB00DCBD6A5FD99FE059FD9DFE1DEA7A01D546B1F
          DA3E2AF11F89BCFF00B37D9C47FDADADDF6ABE46DDEF9F2BED9E56FCFCFE5EFD
          A9BB62FA0D140051451400514514005145140051451400514514005145140051
          4514005145140051451401FFD9}
        Proportional = True
        ShowHint = False
        Visible = False
        OnClick = PaintBox1Click
      end
      object DescripcionDBEdit: TDBEdit
        Left = 15
        Top = 101
        Width = 332
        Height = 21
        DataField = 'Descripcion'
        DataSource = DataSource
        TabOrder = 0
      end
      object DBEdit1: TDBEdit
        Left = 90
        Top = 175
        Width = 73
        Height = 21
        DataField = 'Disponible'
        DataSource = DataSource
        TabOrder = 2
      end
      object DBLookupComboBox4: TDBLookupComboBox
        Left = 90
        Top = 140
        Width = 231
        Height = 21
        DataField = 'Proveedor'
        DataSource = DataSource
        KeyField = 'CODIGO'
        ListField = 'NOMBRE'
        ListSource = DSQProve
        TabOrder = 1
        OnEnter = DBLookupComboBox4Enter
      end
      object BitBtn13: TBitBtn
        Left = 320
        Top = 140
        Width = 27
        Height = 21
        Hint = ' F4 AGREGAR PROVEEDOR'
        Caption = '+'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 8
        OnClick = BitBtn13Click
      end
      object FleteDBEdit: TDBEdit
        Left = 519
        Top = 59
        Width = 65
        Height = 21
        DataField = 'ImpOtros'
        DataSource = DataSource
        TabOrder = 4
      end
      object CostoDBEdit: TDBEdit
        Left = 90
        Top = 208
        Width = 113
        Height = 21
        DataField = 'Costo'
        DataSource = DataSource
        TabOrder = 3
      end
      object PrecioCtaCteDBEdit: TDBEdit
        Left = 519
        Top = 239
        Width = 97
        Height = 21
        DataField = 'PRECIO'
        DataSource = DataSource
        TabOrder = 7
      end
      object GanaciaDBEdit: TDBEdit
        Left = 519
        Top = 112
        Width = 65
        Height = 21
        DataField = 'PORCENTAJE'
        DataSource = DataSource
        TabOrder = 6
        OnExit = GanaciaDBEditExit
      end
      object CodigoBarraEdit: TDBEdit
        Left = 96
        Top = 58
        Width = 100
        Height = 21
        DataField = 'CodigoBarra'
        DataSource = DataSource
        TabOrder = 9
      end
      object CodigoBarraBitBtn: TBitBtn
        Left = 195
        Top = 58
        Width = 27
        Height = 21
        Caption = '+'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 10
        OnClick = CodigoBarraBitBtnClick
      end
      object IVADBComboBox: TDBComboBox
        Left = 519
        Top = 85
        Width = 67
        Height = 21
        DataField = 'Tasa'
        DataSource = DataSource
        Items.Strings = (
          '21'
          '105'
          '0')
        TabOrder = 5
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Notas'
      ImageIndex = 2
      object DBMemo1: TDBMemo
        Left = 0
        Top = 0
        Width = 648
        Height = 440
        Align = alClient
        DataField = 'Notas'
        DataSource = DataSource
        TabOrder = 0
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Informaci'#243'n Adicional'
      ImageIndex = 2
      object Label6: TLabel
        Left = 351
        Top = 116
        Width = 48
        Height = 13
        Alignment = taRightJustify
        Caption = 'Ubicaci'#243'n'
        FocusControl = DBEdit6
      end
      object Label15: TLabel
        Left = 333
        Top = 177
        Width = 66
        Height = 13
        Caption = 'Stock M'#237'nimo'
        Visible = False
      end
      object Label17: TLabel
        Left = 332
        Top = 207
        Width = 67
        Height = 13
        Caption = 'Stock M'#225'ximo'
        FocusControl = DBEdit7
        Visible = False
      end
      object Label18: TLabel
        Left = 329
        Top = 237
        Width = 70
        Height = 13
        Caption = 'Stock Vendido'
        FocusControl = DBEdit8
        Visible = False
      end
      object Label20: TLabel
        Left = 298
        Top = 268
        Width = 101
        Height = 13
        Caption = 'Fecha Compra Ultimo'
        FocusControl = DBEdit17
      end
      object Label9: TLabel
        Left = 365
        Top = 88
        Width = 34
        Height = 13
        Alignment = taRightJustify
        Caption = 'Unidad'
        FocusControl = DBEdit9
      end
      object Label32: TLabel
        Left = 339
        Top = 145
        Width = 60
        Height = 13
        Alignment = taRightJustify
        Caption = 'Procedencia'
        FocusControl = DBEdit21
      end
      object Label25: TLabel
        Left = 30
        Top = 88
        Width = 29
        Height = 13
        Caption = 'Rubro'
      end
      object Label26: TLabel
        Left = 29
        Top = 120
        Width = 30
        Height = 13
        Caption = 'Marca'
      end
      object Label27: TLabel
        Left = 11
        Top = 57
        Width = 47
        Height = 13
        Caption = 'Categor'#237'a'
      end
      object Label35: TLabel
        Left = 12
        Top = 145
        Width = 47
        Height = 13
        Alignment = taRightJustify
        Caption = 'Cod.Prov.'
        FocusControl = DBEdit2
      end
      object DBEdit6: TDBEdit
        Left = 406
        Top = 115
        Width = 145
        Height = 21
        DataField = 'Ubicacion'
        DataSource = DataSource
        TabOrder = 5
      end
      object DBEdit5: TDBEdit
        Left = 406
        Top = 176
        Width = 96
        Height = 21
        DataField = 'StockMinimo'
        DataSource = DataSource
        TabOrder = 7
        Visible = False
      end
      object DBEdit7: TDBEdit
        Left = 406
        Top = 207
        Width = 96
        Height = 21
        DataField = 'StockMaximo'
        DataSource = DataSource
        TabOrder = 8
        Visible = False
      end
      object DBEdit8: TDBEdit
        Left = 406
        Top = 237
        Width = 97
        Height = 21
        DataField = 'StockVendido'
        DataSource = DataSource
        TabOrder = 9
        Visible = False
      end
      object DBEdit17: TDBEdit
        Left = 406
        Top = 268
        Width = 145
        Height = 21
        DataField = 'FechaCompUlt'
        DataSource = DataSource
        TabOrder = 10
      end
      object DBEdit9: TDBEdit
        Left = 406
        Top = 87
        Width = 73
        Height = 21
        DataField = 'Unidad'
        DataSource = DataSource
        TabOrder = 4
      end
      object DBEdit21: TDBEdit
        Left = 406
        Top = 144
        Width = 97
        Height = 21
        DataField = 'Procedencia'
        DataSource = DataSource
        TabOrder = 6
      end
      object RubroDBLookupComboBox: TDBLookupComboBox
        Left = 66
        Top = 84
        Width = 170
        Height = 21
        DataField = 'Rubro'
        DataSource = DataSource
        KeyField = 'CODIGO'
        ListField = 'DESCRIPCION'
        ListSource = DSRubro
        TabOrder = 1
        OnEnter = RubroDBLookupComboBoxEnter
      end
      object RubroBitBtn: TBitBtn
        Left = 235
        Top = 84
        Width = 28
        Height = 21
        Caption = '+'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 11
        OnClick = RubroBitBtnClick
      end
      object MarcaDBLookupComboBox: TDBLookupComboBox
        Left = 66
        Top = 116
        Width = 170
        Height = 21
        DataField = 'Marca'
        DataSource = DataSource
        KeyField = 'CODIGO'
        ListField = 'DESCRIPCION'
        ListSource = MarcaDataSource
        TabOrder = 2
        OnEnter = MarcaDBLookupComboBoxEnter
        OnKeyUp = MarcaDBLookupComboBoxKeyUp
      end
      object MarcaBitBtn: TBitBtn
        Left = 235
        Top = 115
        Width = 28
        Height = 22
        Caption = '+'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 12
        OnClick = MarcaBitBtnClick
      end
      object CategoriaDBLookupComboBox: TDBLookupComboBox
        Left = 66
        Top = 53
        Width = 170
        Height = 21
        DataField = 'Categoria'
        DataSource = DataSource
        KeyField = 'CODIGO'
        ListField = 'DESCRIPCION'
        ListSource = DSTCat
        TabOrder = 0
        OnEnter = CategoriaDBLookupComboBoxEnter
      end
      object CategoriaBitBtn: TBitBtn
        Left = 235
        Top = 53
        Width = 28
        Height = 21
        Caption = '+'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 13
        OnClick = CategoriaBitBtnClick
      end
      object DBEdit2: TDBEdit
        Left = 65
        Top = 143
        Width = 197
        Height = 21
        DataField = 'STOCK'
        DataSource = DataSource
        TabOrder = 3
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Precios'
      ImageIndex = 3
      object Label11: TLabel
        Left = 185
        Top = 221
        Width = 39
        Height = 13
        Caption = 'Precio 5'
        FocusControl = Precio1DBEdit
      end
      object Label12: TLabel
        Left = 185
        Top = 96
        Width = 39
        Height = 13
        Caption = 'Precio 1'
        FocusControl = Precio2DBEdit
      end
      object Label13: TLabel
        Left = 185
        Top = 128
        Width = 39
        Height = 13
        Caption = 'Precio 2'
        FocusControl = Precio3DBEdit
      end
      object Label7: TLabel
        Left = 185
        Top = 251
        Width = 39
        Height = 13
        Caption = 'Precio 6'
        FocusControl = Precio6DBEdit
      end
      object Label31: TLabel
        Left = 185
        Top = 157
        Width = 39
        Height = 13
        Caption = 'Precio 3'
        FocusControl = Precio4DBEdit
      end
      object Label3: TLabel
        Left = 185
        Top = 189
        Width = 39
        Height = 13
        Caption = 'Precio 4'
        FocusControl = Precio5DBEdit
      end
      object Label22: TLabel
        Left = 231
        Top = 73
        Width = 46
        Height = 16
        Caption = 'Listas:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Precio1DBEdit: TDBEdit
        Left = 232
        Top = 95
        Width = 96
        Height = 21
        DataField = 'Precio1'
        DataSource = DataSource
        TabOrder = 0
      end
      object Precio2DBEdit: TDBEdit
        Left = 232
        Top = 125
        Width = 96
        Height = 21
        DataField = 'Precio2'
        DataSource = DataSource
        TabOrder = 1
      end
      object Precio3DBEdit: TDBEdit
        Left = 232
        Top = 155
        Width = 97
        Height = 21
        DataField = 'Precio3'
        DataSource = DataSource
        TabOrder = 2
      end
      object Precio6DBEdit: TDBEdit
        Left = 231
        Top = 249
        Width = 97
        Height = 21
        DataField = 'Precio6'
        DataSource = DataSource
        TabOrder = 5
        OnExit = Precio6DBEditExit
      end
      object Precio4DBEdit: TDBEdit
        Left = 231
        Top = 186
        Width = 97
        Height = 21
        DataField = 'Precio4'
        DataSource = DataSource
        TabOrder = 3
      end
      object Precio5DBEdit: TDBEdit
        Left = 231
        Top = 219
        Width = 97
        Height = 21
        DataField = 'Precio5'
        DataSource = DataSource
        TabOrder = 4
      end
    end
    object TabSheet5: TTabSheet
      Caption = 'Contabilidad'
      ImageIndex = 4
      object Label50: TLabel
        Left = 185
        Top = 51
        Width = 162
        Height = 13
        Caption = 'Cuenta Contable Asociada a'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label54: TLabel
        Left = 145
        Top = 203
        Width = 35
        Height = 13
        Caption = 'Orden'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label53: TLabel
        Left = 91
        Top = 163
        Width = 89
        Height = 13
        Caption = 'Ingresos Brutos'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label51: TLabel
        Left = 154
        Top = 123
        Width = 26
        Height = 13
        Caption = 'Tipo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label52: TLabel
        Left = 136
        Top = 83
        Width = 44
        Height = 13
        Caption = 'Nombre'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object CuentaDBLookupComboBox: TDBLookupComboBox
        Left = 185
        Top = 83
        Width = 351
        Height = 21
        DataField = 'CtaNombre'
        DataSource = DataSource
        KeyField = 'CODIGO'
        ListField = 'DESCRIPCION'
        ListSource = CuentaDataSource
        TabOrder = 0
      end
      object DBLookupComboBox1: TDBLookupComboBox
        Left = 185
        Top = 123
        Width = 351
        Height = 21
        DataField = 'CtaTipo'
        DataSource = DataSource
        KeyField = 'CODIGO'
        ListField = 'DESCRIPCION'
        ListSource = CuentaDataSource
        TabOrder = 1
      end
      object DBLookupComboBox2: TDBLookupComboBox
        Left = 185
        Top = 163
        Width = 351
        Height = 21
        DataField = 'CtaIIBB'
        DataSource = DataSource
        KeyField = 'CODIGO'
        ListField = 'DESCRIPCION'
        ListSource = CuentaDataSource
        TabOrder = 2
      end
      object DBLookupComboBox7: TDBLookupComboBox
        Left = 185
        Top = 203
        Width = 351
        Height = 21
        DataField = 'CtaAnticipo'
        DataSource = DataSource
        KeyField = 'CODIGO'
        ListField = 'DESCRIPCION'
        ListSource = CuentaDataSource
        TabOrder = 3
      end
    end
  end
  object Panel3: TPanel
    Left = 656
    Top = 0
    Width = 138
    Height = 468
    Align = alRight
    Color = clBlack
    ParentBackground = False
    TabOrder = 1
    object Label29: TLabel
      Left = 45
      Top = 206
      Width = 46
      Height = 13
      Caption = 'Grabar?'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label1: TLabel
      Left = 48
      Top = 22
      Width = 40
      Height = 13
      Caption = 'C'#243'digo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object BitBtn1: TBitBtn
      Left = 28
      Top = 145
      Width = 80
      Height = 50
      Caption = 'Si'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      ModalResult = 6
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 28
      Top = 225
      Width = 80
      Height = 50
      Caption = 'No'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      Kind = bkNo
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 1
      OnClick = BitBtn2Click
    end
    object CodigoDBEdit: TDBEdit
      Left = 25
      Top = 41
      Width = 86
      Height = 32
      DataField = 'CODIGO'
      DataSource = DataSource
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object BitBtn4: TBitBtn
      Left = 28
      Top = 352
      Width = 80
      Height = 50
      Caption = 'Buscar F5'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      OnClick = BitBtn4Click
    end
    object DBNavigator1: TDBNavigator
      Left = 10
      Top = 427
      Width = 120
      Height = 36
      DataSource = DataSource
      VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbInsert, nbDelete]
      Hints.Strings = (
        'Primer registro'
        'Registro anterior'
        'Registro siguiente'
        #218'ltimo registro'
        'Insertar registro'
        'Eliminar registro'
        'Editar registro'
        'Guardar cambios'
        'Cancelar edici'#243'n'
        'Refrescar datos')
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
    end
  end
  object DataSource: TDataSource
    AutoEdit = False
    DataSet = Tabla
    Left = 75
    Top = 265
  end
  object DSTCat: TDataSource
    DataSet = CategoriaT
    Left = 392
    Top = 425
  end
  object DSTSubCat: TDataSource
    DataSet = SubCategoriaT
    Left = 544
    Top = 425
  end
  object DSMateriales: TDataSource
    DataSet = MaterialT
    Left = 41
    Top = 368
  end
  object DSRubro: TDataSource
    DataSet = RubroT
    Left = 616
    Top = 425
  end
  object DSQProve: TDataSource
    DataSet = ProveedorT
    Left = 256
    Top = 368
  end
  object MarcaDataSource: TDataSource
    DataSet = MarcaT
    Left = 120
    Top = 368
  end
  object CuentaDataSource: TDataSource
    DataSet = CuentaQuery
    Left = 190
    Top = 425
  end
  object Tabla: TIBTable
    Database = DM.BaseDatos
    Transaction = DM.Transaccion
    AfterCancel = TablaAfterCancel
    AfterDelete = TablaAfterDelete
    AfterInsert = TablaAfterInsert
    AfterPost = TablaAfterPost
    BufferChunks = 1000
    CachedUpdates = False
    FieldDefs = <
      item
        Name = 'CODIGO'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'DESCRIPCION'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'COSTO'
        DataType = ftFloat
      end
      item
        Name = 'ULTCOSTO'
        DataType = ftFloat
      end
      item
        Name = 'PRECIO1'
        DataType = ftFloat
      end
      item
        Name = 'PRECIO2'
        DataType = ftFloat
      end
      item
        Name = 'PRECIO3'
        DataType = ftFloat
      end
      item
        Name = 'PRECIO4'
        DataType = ftFloat
      end
      item
        Name = 'PRECIO5'
        DataType = ftFloat
      end
      item
        Name = 'PRECIO6'
        DataType = ftFloat
      end
      item
        Name = 'PRECIO'
        DataType = ftFloat
      end
      item
        Name = 'PORCENTAJE'
        DataType = ftFloat
      end
      item
        Name = 'ULTPRECIO'
        DataType = ftFloat
      end
      item
        Name = 'MARCA'
        DataType = ftInteger
      end
      item
        Name = 'COLOR'
        DataType = ftInteger
      end
      item
        Name = 'CATEGORIA'
        DataType = ftInteger
      end
      item
        Name = 'SUBCATEGORIA'
        DataType = ftInteger
      end
      item
        Name = 'UBICACION'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'UNIDAD'
        DataType = ftWideString
        Size = 50
      end
      item
        Name = 'DISPONIBLE'
        DataType = ftInteger
      end
      item
        Name = 'ENPRODUCCION'
        DataType = ftInteger
      end
      item
        Name = 'NOTAS'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'IVA'
        DataType = ftInteger
      end
      item
        Name = 'TASA'
        DataType = ftInteger
      end
      item
        Name = 'IMPOTROS'
        DataType = ftInteger
      end
      item
        Name = 'IIBB'
        DataType = ftInteger
      end
      item
        Name = 'STOCKMINIMO'
        DataType = ftInteger
      end
      item
        Name = 'STOCKMAXIMO'
        DataType = ftInteger
      end
      item
        Name = 'STOCKVENDIDO'
        DataType = ftInteger
      end
      item
        Name = 'FECHACOMPULT'
        DataType = ftDateTime
      end
      item
        Name = 'LISTA'
        DataType = ftInteger
      end
      item
        Name = 'PROCEDENCIA'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'CODIGOBARRA'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'RUBRO'
        DataType = ftInteger
      end
      item
        Name = 'PROVEEDOR'
        DataType = ftInteger
      end
      item
        Name = 'GARANTIA'
        DataType = ftInteger
      end
      item
        Name = 'FECHA'
        DataType = ftDateTime
      end
      item
        Name = 'PEDIDO'
        DataType = ftInteger
      end
      item
        Name = 'STOCK'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'EXISTENTE'
        DataType = ftInteger
      end
      item
        Name = 'ACTUAL'
        DataType = ftInteger
      end
      item
        Name = 'MARCADOCONTADO'
        DataType = ftInteger
      end
      item
        Name = 'MARCADOLISTA'
        DataType = ftInteger
      end
      item
        Name = 'MARCADOFINAL'
        DataType = ftInteger
      end
      item
        Name = 'PREPARADO'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'CTANOMBRE'
        DataType = ftInteger
      end
      item
        Name = 'CTATIPO'
        DataType = ftInteger
      end
      item
        Name = 'CTAANTICIPO'
        DataType = ftInteger
      end
      item
        Name = 'CTAIIBB'
        DataType = ftInteger
      end
      item
        Name = 'ESTADO'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'VENCE'
        DataType = ftDateTime
      end
      item
        Name = 'VENCIMIENTO'
        DataType = ftInteger
      end>
    IndexDefs = <
      item
        Name = 'PK_Articulo'
        Fields = 'CODIGO'
        Options = [ixUnique]
      end>
    StoreDefs = True
    TableName = 'Articulo'
    UniDirectional = False
    Left = 27
    Top = 264
  end
  object CategoriaT: TIBTable
    Database = DM.BaseDatos
    Transaction = DM.Transaccion
    BufferChunks = 1000
    CachedUpdates = False
    TableName = 'Categoria'
    UniDirectional = False
    Left = 352
    Top = 425
  end
  object SubCategoriaT: TIBTable
    Database = DM.BaseDatos
    Transaction = DM.Transaccion
    BufferChunks = 1000
    CachedUpdates = False
    TableName = 'SubCategoria'
    UniDirectional = False
    Left = 512
    Top = 425
  end
  object RubroT: TIBTable
    Database = DM.BaseDatos
    Transaction = DM.Transaccion
    BufferChunks = 1000
    CachedUpdates = False
    TableName = 'Rubro'
    UniDirectional = False
    Left = 584
    Top = 425
  end
  object MaterialT: TIBTable
    Database = DM.BaseDatos
    Transaction = DM.Transaccion
    BufferChunks = 1000
    CachedUpdates = False
    TableName = 'Material'
    UniDirectional = False
    Left = 11
    Top = 368
  end
  object QTemp: TIBQuery
    Database = DM.BaseDatos
    Transaction = DM.Transaccion
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 240
    Top = 425
  end
  object Usuario: TIBQuery
    Database = DM.BaseDatos
    Transaction = DM.Transaccion
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select * from "Usuario"')
    Left = 8
    Top = 425
  end
  object DSUsuarios: TDataSource
    DataSet = Usuario
    Left = 38
    Top = 425
  end
  object CuentaQuery: TIBQuery
    Database = DM.BaseDatos
    Transaction = DM.Transaccion
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select * from "Cuenta"'
      'order by DESCRIPCION')
    Left = 160
    Top = 425
  end
  object MarcaT: TIBTable
    Database = DM.BaseDatos
    Transaction = DM.Transaccion
    BufferChunks = 1000
    CachedUpdates = False
    TableName = 'Marca'
    UniDirectional = False
    Left = 88
    Top = 368
  end
  object ProveedorT: TIBTable
    Database = DM.BaseDatos
    Transaction = DM.Transaccion
    BufferChunks = 1000
    CachedUpdates = False
    TableName = 'Proveedor'
    UniDirectional = False
    Left = 200
    Top = 368
  end
  object ConfigQuery: TIBQuery
    Database = DM.BaseDatos
    Transaction = DM.Transaccion
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select * from "Config"')
    Left = 96
    Top = 425
  end
end
