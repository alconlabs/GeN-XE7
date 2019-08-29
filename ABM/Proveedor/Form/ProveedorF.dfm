object ProveedorForm: TProveedorForm
  Left = 182
  Top = 90
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Altas, Bajas y Modificaciones de Proveedores'
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
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 719
    Height = 468
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Informaci'#243'n General'
      object Label2: TLabel
        Left = 181
        Top = 64
        Width = 44
        Height = 13
        Caption = 'Nombre'
        FocusControl = DBEdit2
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label3: TLabel
        Left = 170
        Top = 91
        Width = 55
        Height = 13
        Caption = 'Direcci'#243'n'
        FocusControl = DBEdit3
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label1: TLabel
        Left = 177
        Top = 37
        Width = 48
        Height = 13
        Caption = 'Nro. Cta'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object VendedorLabel: TLabel
        Left = 632
        Top = 64
        Width = 9
        Height = 13
        Caption = '...'
      end
      object Label4: TLabel
        Left = 185
        Top = 199
        Width = 40
        Height = 13
        Caption = 'Celular'
        FocusControl = DBEdit9
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label9: TLabel
        Left = 174
        Top = 145
        Width = 51
        Height = 13
        Caption = 'Tel'#233'fono'
        FocusControl = DBEdit10
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label11: TLabel
        Left = 204
        Top = 172
        Width = 21
        Height = 13
        Caption = 'Fax'
        FocusControl = DBEdit12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label6: TLabel
        Left = 171
        Top = 226
        Width = 54
        Height = 13
        Caption = 'Provincia'
        FocusControl = DBEdit6
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label7: TLabel
        Left = 145
        Top = 253
        Width = 80
        Height = 13
        Caption = 'Departamento'
        FocusControl = DBEdit7
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label27: TLabel
        Left = 169
        Top = 280
        Width = 56
        Height = 13
        Caption = 'Localidad'
        FocusControl = DBEdit24
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object DBEdit2: TDBEdit
        Left = 231
        Top = 64
        Width = 226
        Height = 21
        DataField = 'Nombre'
        DataSource = DM.dstProveedor
        TabOrder = 0
      end
      object DBEdit3: TDBEdit
        Left = 231
        Top = 91
        Width = 226
        Height = 21
        DataField = 'DIRECCION'
        DataSource = DM.dstProveedor
        TabOrder = 1
      end
      object CodigoDBEdit: TDBEdit
        Left = 231
        Top = 37
        Width = 76
        Height = 21
        DataField = 'CODIGO'
        DataSource = DM.dstProveedor
        TabOrder = 9
      end
      object DBEdit9: TDBEdit
        Left = 231
        Top = 199
        Width = 76
        Height = 21
        DataField = 'Celular'
        DataSource = DM.dstProveedor
        TabOrder = 5
      end
      object DBEdit4: TDBEdit
        Left = 231
        Top = 118
        Width = 226
        Height = 21
        DataField = 'DIRECCIONCOMERCIAL'
        DataSource = DM.dstProveedor
        TabOrder = 2
      end
      object DBEdit10: TDBEdit
        Left = 231
        Top = 145
        Width = 76
        Height = 21
        DataField = 'Telefono'
        DataSource = DM.dstProveedor
        TabOrder = 3
      end
      object DBEdit12: TDBEdit
        Left = 231
        Top = 172
        Width = 76
        Height = 21
        DataField = 'Fax'
        DataSource = DM.dstProveedor
        TabOrder = 4
      end
      object DBEdit6: TDBEdit
        Left = 231
        Top = 226
        Width = 226
        Height = 21
        DataField = 'Provincia'
        DataSource = DM.dstProveedor
        TabOrder = 6
      end
      object DBEdit7: TDBEdit
        Left = 231
        Top = 253
        Width = 226
        Height = 21
        DataField = 'Departamento'
        DataSource = DM.dstProveedor
        TabOrder = 7
      end
      object DBEdit24: TDBEdit
        Left = 231
        Top = 280
        Width = 226
        Height = 21
        DataField = 'Ciudad'
        DataSource = DM.dstProveedor
        TabOrder = 8
        OnExit = DBEdit24Exit
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Notas'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object DBMemo1: TDBMemo
        Left = 0
        Top = 0
        Width = 711
        Height = 440
        Align = alClient
        DataField = 'Notas'
        TabOrder = 0
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Contabilidad'
      ImageIndex = 2
      object Label15: TLabel
        Left = 209
        Top = 155
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
        Left = 116
        Top = 77
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
        Left = 175
        Top = 39
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
        Left = 106
        Top = 116
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
        Left = 282
        Top = 116
        Width = 9
        Height = 13
        Caption = '...'
      end
      object Label54: TLabel
        Left = 170
        Top = 259
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
      object Label52: TLabel
        Left = 161
        Top = 182
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
        Left = 179
        Top = 219
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
        Left = 209
        Top = 77
        Width = 201
        Height = 21
        DataField = 'IIBB'
        TabOrder = 1
      end
      object DBEdit22: TDBEdit
        Left = 209
        Top = 39
        Width = 201
        Height = 21
        DataField = 'CUIT'
        TabOrder = 0
      end
      object IVADBComboBox: TDBComboBox
        Left = 209
        Top = 113
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
        Left = 209
        Top = 178
        Width = 351
        Height = 21
        DataField = 'CtaNombre'
        KeyField = 'CODIGO'
        ListField = 'DESCRIPCION'
        TabOrder = 3
      end
      object CtaAnticipoDBLookupComboBox: TDBLookupComboBox
        Left = 209
        Top = 255
        Width = 351
        Height = 21
        DataField = 'CtaAnticipo'
        KeyField = 'CODIGO'
        ListField = 'DESCRIPCION'
        TabOrder = 5
      end
      object CtaTipoDBLookupComboBox: TDBLookupComboBox
        Left = 209
        Top = 215
        Width = 351
        Height = 21
        DataField = 'CtaTipo'
        KeyField = 'CODIGO'
        ListField = 'DESCRIPCION'
        TabOrder = 4
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Datos Secundarios'
      ImageIndex = 3
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label19: TLabel
        Left = 208
        Top = 42
        Width = 86
        Height = 13
        Caption = 'Nombre del Titular'
        FocusControl = DBEdit16
      end
      object Label12: TLabel
        Left = 269
        Top = 204
        Width = 25
        Height = 13
        Caption = 'Email'
        FocusControl = DBEdit13
      end
      object Label28: TLabel
        Left = 242
        Top = 231
        Width = 52
        Height = 13
        Caption = 'Messenger'
        FocusControl = DBEdit23
      end
      object Label23: TLabel
        Left = 275
        Top = 69
        Width = 19
        Height = 13
        Caption = 'DNI'
        FocusControl = DBEdit19
      end
      object Label26: TLabel
        Left = 265
        Top = 96
        Width = 29
        Height = 13
        Caption = 'Rubro'
      end
      object Label5: TLabel
        Left = 274
        Top = 258
        Width = 20
        Height = 13
        Caption = 'Pais'
        FocusControl = DBEdit5
      end
      object Label21: TLabel
        Left = 229
        Top = 123
        Width = 65
        Height = 13
        Caption = 'Codigo Postal'
        FocusControl = DBEdit17
      end
      object Label22: TLabel
        Left = 221
        Top = 152
        Width = 73
        Height = 13
        Caption = 'Codigo de Area'
      end
      object Label10: TLabel
        Left = 247
        Top = 177
        Width = 47
        Height = 13
        Caption = 'Extenci'#243'n'
        FocusControl = DBEdit11
      end
      object Label8: TLabel
        Left = 261
        Top = 288
        Width = 3
        Height = 13
      end
      object Label18: TLabel
        Left = 237
        Top = 285
        Width = 57
        Height = 13
        Alignment = taRightJustify
        Caption = 'Dias Cr'#233'dito'
        FocusControl = DBEdit1
      end
      object DBEdit16: TDBEdit
        Left = 300
        Top = 42
        Width = 209
        Height = 21
        DataField = 'Gerente'
        TabOrder = 0
      end
      object DBEdit13: TDBEdit
        Left = 298
        Top = 204
        Width = 209
        Height = 21
        DataField = 'Email'
        TabOrder = 6
      end
      object DBEdit23: TDBEdit
        Left = 298
        Top = 231
        Width = 209
        Height = 21
        DataField = 'MSN'
        TabOrder = 7
      end
      object DBEdit19: TDBEdit
        Left = 298
        Top = 69
        Width = 209
        Height = 21
        DataField = 'Documento'
        TabOrder = 1
      end
      object DBEdit21: TDBEdit
        Left = 298
        Top = 96
        Width = 209
        Height = 21
        DataField = 'Rubro'
        TabOrder = 2
      end
      object DBEdit5: TDBEdit
        Left = 298
        Top = 258
        Width = 97
        Height = 21
        DataField = 'Pais'
        TabOrder = 8
      end
      object DBEdit17: TDBEdit
        Left = 298
        Top = 123
        Width = 82
        Height = 21
        DataField = 'CP'
        TabOrder = 3
      end
      object DBEdit11: TDBEdit
        Left = 298
        Top = 177
        Width = 82
        Height = 21
        DataField = 'Extencion'
        TabOrder = 5
      end
      object DBEdit18: TDBEdit
        Left = 298
        Top = 150
        Width = 82
        Height = 21
        DataField = 'CodigoArea'
        TabOrder = 4
      end
      object DBEdit1: TDBEdit
        Left = 298
        Top = 285
        Width = 145
        Height = 21
        DataField = 'DiasCredito'
        TabOrder = 9
      end
    end
  end
  object Panel1: TPanel
    Left = 719
    Top = 0
    Width = 75
    Height = 468
    Align = alRight
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 1
    object SiBitBtn: TBitBtn
      Left = 1
      Top = 367
      Width = 73
      Height = 50
      Align = alBottom
      Caption = 'Grabar'
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
      OnClick = SiBitBtnClick
    end
    object NoBitBtn: TBitBtn
      Left = 1
      Top = 417
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
      OnClick = NoBitBtnClick
    end
    object ImprimirBitBtn: TBitBtn
      Left = 1
      Top = 292
      Width = 73
      Height = 25
      Align = alBottom
      Caption = 'Imprimir'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clPurple
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = ImprimirBitBtnClick
    end
    object DBNavigator1: TDBNavigator
      Left = 9
      Top = 486
      Width = 120
      Height = 32
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
      TabOrder = 3
    end
    object BuscarBitBtn: TBitBtn
      Left = 1
      Top = 267
      Width = 73
      Height = 25
      Align = alBottom
      Caption = 'Buscar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      OnClick = BuscarBitBtnClick
    end
    object bExportar: TButton
      Left = 1
      Top = 317
      Width = 73
      Height = 25
      Align = alBottom
      Caption = 'Exportar'
      TabOrder = 5
      OnClick = bExportarClick
    end
    object bImportar: TButton
      Left = 1
      Top = 342
      Width = 73
      Height = 25
      Align = alBottom
      Caption = 'Importar'
      TabOrder = 6
      OnClick = bImportarClick
    end
  end
end
