object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'fMercadoLibreEnvios'
  ClientHeight = 406
  ClientWidth = 267
  Color = clCream
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 25
    Top = 8
    Width = 92
    Height = 16
    Caption = 'Para preparar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGrayText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lVentas: TLabel
    Left = 25
    Top = 27
    Width = 42
    Height = 13
    Caption = '0 ventas'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGrayText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object bActualizar: TBitBtn
    Left = 211
    Top = 383
    Width = 75
    Height = 25
    Caption = 'Actualizar'
    TabOrder = 0
    OnClick = bActualizarClick
  end
  object ProgressBar1: TProgressBar
    Left = 55
    Top = 383
    Width = 150
    Height = 16
    Min = 1
    Position = 1
    TabOrder = 1
    Visible = False
  end
  object Panel1: TPanel
    Left = 8
    Top = 54
    Width = 250
    Height = 70
    Color = clWhite
    ParentBackground = False
    TabOrder = 2
    object Label3: TLabel
      Left = 17
      Top = 17
      Width = 98
      Height = 13
      Caption = 'Mensajes nuevos'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lMensajes: TLabel
      Left = 17
      Top = 33
      Width = 42
      Height = 13
      Caption = '0 ventas'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGrayText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
  end
  object pColecta: TPanel
    Left = 8
    Top = 139
    Width = 250
    Height = 70
    Color = clWhite
    ParentBackground = False
    TabOrder = 3
    OnClick = pColectaClick
    object Label5: TLabel
      Left = 17
      Top = 17
      Width = 141
      Height = 13
      Caption = 'Para la colecta | Ma'#241'ana'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = Label5Click
    end
    object lMEnvios: TLabel
      Left = 17
      Top = 33
      Width = 42
      Height = 13
      Caption = '0 ventas'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGrayText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      OnClick = lMEnviosClick
    end
  end
  object Panel3: TPanel
    Left = 8
    Top = 222
    Width = 250
    Height = 70
    Color = clWhite
    ParentBackground = False
    TabOrder = 4
    object Label7: TLabel
      Left = 17
      Top = 15
      Width = 172
      Height = 13
      Caption = 'Mercado Env'#237'os Flex | Ma'#241'ana'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lMEFlex: TLabel
      Left = 17
      Top = 33
      Width = 42
      Height = 13
      Caption = '0 ventas'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGrayText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
  end
  object Panel4: TPanel
    Left = 8
    Top = 307
    Width = 250
    Height = 70
    Color = clWhite
    ParentBackground = False
    TabOrder = 5
    object Label11: TLabel
      Left = 17
      Top = 17
      Width = 146
      Height = 13
      Caption = 'Acordar con el comprador'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lAcordar: TLabel
      Left = 17
      Top = 33
      Width = 42
      Height = 13
      Caption = '0 ventas'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGrayText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
  end
  object tProgressBar: TTimer
    OnTimer = tProgressBarTimer
    Left = 112
    Top = 376
  end
end
