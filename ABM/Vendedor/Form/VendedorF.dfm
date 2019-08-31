object VendedorForm: TVendedorForm
  Left = 182
  Top = 90
  Caption = 'Altas, Bajas y Modificaciones de Vendedores'
  ClientHeight = 488
  ClientWidth = 792
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
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel5: TPanel
    Left = 717
    Top = 0
    Width = 75
    Height = 488
    Align = alRight
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 0
    object Label1: TLabel
      Left = 1
      Top = 51
      Width = 73
      Height = 16
      Align = alTop
      Caption = 'Nro. Cta'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitTop = 25
      ExplicitWidth = 57
    end
    object AceptarBitBtn: TBitBtn
      Left = 1
      Top = 437
      Width = 73
      Height = 50
      Align = alBottom
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
      OnClick = AceptarBitBtnClick
      ExplicitLeft = 31
      ExplicitTop = 106
      ExplicitWidth = 80
    end
    object BitBtn2: TBitBtn
      Left = 1
      Top = 387
      Width = 73
      Height = 50
      Align = alBottom
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
      ExplicitLeft = 31
      ExplicitTop = 185
      ExplicitWidth = 80
    end
    object BitBtn4: TBitBtn
      Left = 1
      Top = 26
      Width = 73
      Height = 25
      Align = alTop
      Caption = 'Imprimir'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clPurple
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = BitBtn4Click
      ExplicitTop = 51
    end
    object DBNavigator1: TDBNavigator
      Left = 1
      Top = 91
      Width = 120
      Height = 32
      VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbInsert, nbDelete]
      Align = alTop
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
      TabOrder = 3
      ExplicitLeft = -15
      ExplicitTop = 179
    end
    object BitBtn3: TBitBtn
      Left = 1
      Top = 1
      Width = 73
      Height = 25
      Align = alTop
      Caption = 'Buscar F5'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      OnClick = BitBtn3Click
    end
    object CodigoDBEdit: TDBEdit
      Left = 1
      Top = 67
      Width = 73
      Height = 24
      Align = alTop
      DataField = 'Codigo'
      DataSource = DM.dstVendedor
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      ExplicitLeft = 2
      ExplicitTop = 86
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 717
    Height = 488
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 1
    ExplicitWidth = 648
    ExplicitHeight = 466
    object TabSheet1: TTabSheet
      Caption = 'Informaci'#243'n General'
      ExplicitLeft = 76
      ExplicitTop = -49
      ExplicitWidth = 640
      ExplicitHeight = 438
      object Label2: TLabel
        Left = 0
        Top = 0
        Width = 709
        Height = 16
        Align = alTop
        Caption = 'Nombre'
        FocusControl = DBEdit2
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitLeft = -2
        ExplicitTop = -8
        ExplicitWidth = 640
      end
      object Label3: TLabel
        Left = 0
        Top = 40
        Width = 709
        Height = 16
        Align = alTop
        Caption = 'Direcci'#243'n'
        FocusControl = DBEdit3
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitLeft = -2
        ExplicitTop = 34
        ExplicitWidth = 640
      end
      object Label4: TLabel
        Left = 0
        Top = 160
        Width = 709
        Height = 16
        Align = alTop
        Caption = 'Celular'
        FocusControl = DBEdit9
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitTop = 71
        ExplicitWidth = 50
      end
      object Label20: TLabel
        Left = 0
        Top = 80
        Width = 709
        Height = 16
        Align = alTop
        Alignment = taRightJustify
        Caption = 'Trabajo'
        FocusControl = DBEdit3
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitTop = 37
        ExplicitWidth = 56
      end
      object Label9: TLabel
        Left = 0
        Top = 120
        Width = 709
        Height = 16
        Align = alTop
        Caption = 'Tel'#233'fono'
        FocusControl = DBEdit10
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitLeft = -2
        ExplicitTop = 114
        ExplicitWidth = 640
      end
      object Label11: TLabel
        Left = 0
        Top = 200
        Width = 709
        Height = 16
        Align = alTop
        Caption = 'Fax'
        FocusControl = DBEdit12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitLeft = 3
        ExplicitTop = 194
        ExplicitWidth = 640
      end
      object Label6: TLabel
        Left = 0
        Top = 240
        Width = 709
        Height = 16
        Align = alTop
        Caption = 'Provincia'
        FocusControl = DBEdit6
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitTop = 374
        ExplicitWidth = 66
      end
      object Label7: TLabel
        Left = 0
        Top = 320
        Width = 709
        Height = 16
        Align = alTop
        Caption = 'Departamento'
        FocusControl = DBEdit7
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitLeft = -2
        ExplicitTop = 422
        ExplicitWidth = 640
      end
      object Label27: TLabel
        Left = 0
        Top = 360
        Width = 709
        Height = 16
        Align = alTop
        Caption = 'Comisi'#243'n'
        FocusControl = DBEdit24
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitLeft = -1
        ExplicitTop = 344
      end
      object Label14: TLabel
        Left = 0
        Top = 280
        Width = 709
        Height = 16
        Align = alTop
        Caption = 'Ciudad'
        FocusControl = DBEdit27
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitLeft = -2
        ExplicitTop = 262
      end
      object Label32: TLabel
        Left = 0
        Top = 400
        Width = 709
        Height = 16
        Align = alTop
        Alignment = taRightJustify
        Caption = '%'
        FocusControl = DBEdit24
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitLeft = -1
        ExplicitTop = 403
      end
      object DBEdit2: TDBEdit
        Left = 0
        Top = 16
        Width = 709
        Height = 24
        Align = alTop
        DataField = 'Nombre'
        DataSource = DM.dstVendedor
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        ExplicitLeft = -2
        ExplicitTop = 10
        ExplicitWidth = 640
      end
      object DBEdit3: TDBEdit
        Left = 0
        Top = 56
        Width = 709
        Height = 24
        Align = alTop
        DataField = 'Direccion'
        DataSource = DM.dstVendedor
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        ExplicitLeft = -3
        ExplicitTop = 66
        ExplicitWidth = 640
      end
      object DBEdit9: TDBEdit
        Left = 0
        Top = 176
        Width = 709
        Height = 24
        Align = alTop
        DataField = 'Celular'
        DataSource = DM.dstVendedor
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        ExplicitTop = 93
        ExplicitWidth = 640
      end
      object DBEdit4: TDBEdit
        Left = 0
        Top = 96
        Width = 709
        Height = 24
        Align = alTop
        DataField = 'DIRECCIONCOMERCIAL'
        DataSource = DM.dstVendedor
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        ExplicitTop = 56
        ExplicitWidth = 640
      end
      object DBEdit10: TDBEdit
        Left = 0
        Top = 136
        Width = 709
        Height = 24
        Align = alTop
        DataField = 'Telefono'
        DataSource = DM.dstVendedor
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        ExplicitLeft = -2
        ExplicitTop = 106
        ExplicitWidth = 640
      end
      object DBEdit12: TDBEdit
        Left = 0
        Top = 216
        Width = 709
        Height = 24
        Align = alTop
        DataField = 'Fax'
        DataSource = DM.dstVendedor
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        ExplicitLeft = 3
        ExplicitTop = 186
        ExplicitWidth = 640
      end
      object DBEdit6: TDBEdit
        Left = 0
        Top = 256
        Width = 709
        Height = 24
        Align = alTop
        DataField = 'Provincia'
        DataSource = DM.dstVendedor
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        ExplicitTop = 423
        ExplicitWidth = 640
      end
      object DBEdit7: TDBEdit
        Left = 0
        Top = 336
        Width = 709
        Height = 24
        Align = alTop
        DataField = 'Departamento'
        DataSource = DM.dstVendedor
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
        ExplicitLeft = -2
        ExplicitTop = 438
        ExplicitWidth = 640
      end
      object DBEdit24: TDBEdit
        Left = 0
        Top = 376
        Width = 709
        Height = 24
        Align = alTop
        DataField = 'COMISION'
        DataSource = DM.dstVendedor
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 9
        OnExit = DBEdit24Exit
        ExplicitLeft = -1
        ExplicitTop = 419
      end
      object DBEdit27: TDBEdit
        Left = 0
        Top = 296
        Width = 709
        Height = 24
        Align = alTop
        DataField = 'CIUDAD'
        DataSource = DM.dstVendedor
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 8
        ExplicitLeft = 16
        ExplicitTop = 317
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Notas'
      ImageIndex = 1
      ExplicitWidth = 640
      ExplicitHeight = 438
      object DBMemo1: TDBMemo
        Left = 0
        Top = 0
        Width = 709
        Height = 460
        Align = alClient
        DataField = 'Notas'
        TabOrder = 0
        ExplicitWidth = 640
        ExplicitHeight = 438
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Contabilidad'
      ImageIndex = 2
      ExplicitWidth = 640
      ExplicitHeight = 438
      object Label15: TLabel
        Left = 185
        Top = 163
        Width = 162
        Height = 13
        Caption = 'Cuenta Contable Asociada a'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label24: TLabel
        Left = 90
        Top = 85
        Width = 89
        Height = 13
        Caption = 'Ingresos Brutos'
        FocusControl = DBEdit20
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label25: TLabel
        Left = 149
        Top = 47
        Width = 30
        Height = 13
        Caption = 'CUIT'
        FocusControl = DBEdit22
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label38: TLabel
        Left = 80
        Top = 124
        Width = 99
        Height = 13
        Caption = 'Categor'#237'a de IVA'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object IVALabel: TLabel
        Left = 258
        Top = 124
        Width = 9
        Height = 13
        Caption = '...'
      end
      object Label54: TLabel
        Left = 132
        Top = 264
        Width = 47
        Height = 13
        Caption = 'Anticipo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label52: TLabel
        Left = 135
        Top = 190
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
      object Label51: TLabel
        Left = 153
        Top = 227
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
      object DBEdit20: TDBEdit
        Left = 185
        Top = 85
        Width = 201
        Height = 21
        DataField = 'IIBB'
        TabOrder = 1
      end
      object DBEdit22: TDBEdit
        Left = 185
        Top = 47
        Width = 201
        Height = 21
        DataField = 'CUIT'
        TabOrder = 0
      end
      object IVADBComboBox: TDBComboBox
        Left = 185
        Top = 121
        Width = 67
        Height = 21
        DataField = 'IVA'
        Items.Strings = (
          'CF'
          'MT'
          'RI'
          'EX'
          'NR')
        TabOrder = 2
        OnChange = IVADBComboBoxChange
      end
      object CtaNombreDBLookupComboBox: TDBLookupComboBox
        Left = 185
        Top = 182
        Width = 351
        Height = 21
        DataField = 'CtaNombre'
        KeyField = 'CODIGO'
        ListField = 'DESCRIPCION'
        TabOrder = 3
      end
      object CtaAnticipoDBLookupComboBox: TDBLookupComboBox
        Left = 185
        Top = 264
        Width = 351
        Height = 21
        DataField = 'CtaAnticipo'
        KeyField = 'CODIGO'
        ListField = 'DESCRIPCION'
        TabOrder = 4
      end
      object CtaTipoDBLookupComboBox: TDBLookupComboBox
        Left = 185
        Top = 227
        Width = 351
        Height = 21
        DataField = 'CtaTipo'
        KeyField = 'CODIGO'
        ListField = 'DESCRIPCION'
        TabOrder = 5
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Datos Secundarios'
      ImageIndex = 3
      ExplicitWidth = 640
      ExplicitHeight = 438
      object Label19: TLabel
        Left = 166
        Top = 42
        Width = 102
        Height = 13
        Caption = 'Nombre de Titular'
        FocusControl = DBEdit16
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label12: TLabel
        Left = 237
        Top = 221
        Width = 31
        Height = 13
        Caption = 'Email'
        FocusControl = DBEdit13
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label28: TLabel
        Left = 206
        Top = 248
        Width = 62
        Height = 13
        Caption = 'Messenger'
        FocusControl = DBEdit23
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label23: TLabel
        Left = 245
        Top = 75
        Width = 23
        Height = 13
        Caption = 'DNI'
        FocusControl = DBEdit19
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label26: TLabel
        Left = 233
        Top = 109
        Width = 35
        Height = 13
        Caption = 'Rubro'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label5: TLabel
        Left = 243
        Top = 282
        Width = 25
        Height = 13
        Caption = 'Pais'
        FocusControl = DBEdit5
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label21: TLabel
        Left = 189
        Top = 140
        Width = 79
        Height = 13
        Caption = 'Codigo Postal'
        FocusControl = DBEdit17
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label22: TLabel
        Left = 180
        Top = 169
        Width = 88
        Height = 13
        Caption = 'Codigo de Area'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label10: TLabel
        Left = 211
        Top = 194
        Width = 57
        Height = 13
        Caption = 'Extenci'#243'n'
        FocusControl = DBEdit11
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label8: TLabel
        Left = 228
        Top = 325
        Width = 40
        Height = 13
        Caption = 'Ciudad'
        FocusControl = DBEdit8
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object DBEdit16: TDBEdit
        Left = 274
        Top = 42
        Width = 209
        Height = 21
        DataField = 'TITULAR'
        TabOrder = 0
      end
      object DBEdit13: TDBEdit
        Left = 274
        Top = 221
        Width = 209
        Height = 21
        DataField = 'Email'
        TabOrder = 6
      end
      object DBEdit23: TDBEdit
        Left = 274
        Top = 248
        Width = 209
        Height = 21
        DataField = 'MSN'
        TabOrder = 7
      end
      object DBEdit19: TDBEdit
        Left = 274
        Top = 75
        Width = 209
        Height = 21
        DataField = 'Documento'
        TabOrder = 1
      end
      object DBEdit21: TDBEdit
        Left = 274
        Top = 109
        Width = 209
        Height = 21
        DataField = 'Rubro'
        TabOrder = 2
      end
      object DBEdit5: TDBEdit
        Left = 274
        Top = 282
        Width = 97
        Height = 21
        DataField = 'Pais'
        TabOrder = 8
      end
      object DBEdit17: TDBEdit
        Left = 274
        Top = 140
        Width = 82
        Height = 21
        DataField = 'CP'
        TabOrder = 3
      end
      object DBEdit11: TDBEdit
        Left = 274
        Top = 194
        Width = 82
        Height = 21
        DataField = 'Extencion'
        TabOrder = 5
      end
      object DBEdit18: TDBEdit
        Left = 274
        Top = 167
        Width = 82
        Height = 21
        DataField = 'CodigoArea'
        TabOrder = 4
      end
      object DBEdit8: TDBEdit
        Left = 274
        Top = 322
        Width = 97
        Height = 21
        DataField = 'Ciudad'
        TabOrder = 9
      end
    end
    object TabSheet5: TTabSheet
      Caption = 'Parametros'
      ImageIndex = 4
      ExplicitWidth = 640
      ExplicitHeight = 438
      object Label13: TLabel
        Left = 150
        Top = 61
        Width = 124
        Height = 13
        Alignment = taRightJustify
        Caption = 'T'#233'rminos del contrato'
        FocusControl = DBEdit14
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label16: TLabel
        Left = 194
        Top = 96
        Width = 80
        Height = 13
        Alignment = taRightJustify
        Caption = 'L'#237'mite Cr'#233'dito'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label17: TLabel
        Left = 237
        Top = 148
        Width = 37
        Height = 13
        Alignment = taRightJustify
        Caption = 'Precio'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label18: TLabel
        Left = 204
        Top = 120
        Width = 70
        Height = 13
        Alignment = taRightJustify
        Caption = 'Dias Cr'#233'dito'
        FocusControl = DBEdit1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label29: TLabel
        Left = 201
        Top = 200
        Width = 73
        Height = 13
        Caption = 'Promociones'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label30: TLabel
        Left = 205
        Top = 232
        Width = 69
        Height = 13
        Caption = 'Almanaques'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label31: TLabel
        Left = 333
        Top = 161
        Width = 34
        Height = 13
        Caption = '0=Lista'
      end
      object DBEdit14: TDBEdit
        Left = 281
        Top = 61
        Width = 145
        Height = 21
        DataField = 'TERMINOS'
        TabOrder = 0
      end
      object DBEdit15: TDBEdit
        Left = 281
        Top = 96
        Width = 145
        Height = 21
        DataField = 'LIMITECREDITO'
        TabOrder = 1
      end
      object DBComboBox1: TDBComboBox
        Left = 281
        Top = 144
        Width = 49
        Height = 21
        DataField = 'PRECIO'
        Items.Strings = (
          '1'
          '2'
          '3'
          '4'
          '5'
          '6'
          '0')
        TabOrder = 3
      end
      object DBEdit1: TDBEdit
        Left = 281
        Top = 120
        Width = 145
        Height = 21
        DataField = 'DiasCredito'
        TabOrder = 2
      end
      object DBCheckBox1: TDBCheckBox
        Left = 281
        Top = 174
        Width = 121
        Height = 17
        Caption = 'Suspendido'
        DataField = 'Suspendido'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 4
      end
      object DBEdit25: TDBEdit
        Left = 281
        Top = 200
        Width = 121
        Height = 21
        DataField = 'Promociones'
        TabOrder = 5
      end
      object DBEdit26: TDBEdit
        Left = 281
        Top = 227
        Width = 121
        Height = 21
        DataField = 'Almanaques'
        TabOrder = 6
      end
    end
  end
end
