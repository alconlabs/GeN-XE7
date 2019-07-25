object fMercadoLibreEnvios: TfMercadoLibreEnvios
  Left = 0
  Top = 0
  Caption = 'Mercado Libre Envios'
  ClientHeight = 404
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
  object lPreparar: TLabel
    Left = 25
    Top = 9
    Width = 92
    Height = 16
    Caption = 'Para preparar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGrayText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    OnClick = lPrepararClick
  end
  object lVentas: TLabel
    Left = 25
    Top = 28
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
  object ProgressBar1: TProgressBar
    Left = 0
    Top = 0
    Width = 267
    Height = 5
    Align = alTop
    Min = 1
    Position = 1
    TabOrder = 0
    Visible = False
  end
  object Panel1: TPanel
    Left = 8
    Top = 54
    Width = 250
    Height = 70
    Color = clWhite
    ParentBackground = False
    TabOrder = 1
    object Label3: TLabel
      Left = 17
      Top = 17
      Width = 54
      Height = 13
      Caption = 'Mensajes'
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
    TabOrder = 2
    OnClick = pColectaClick
    object Label5: TLabel
      Left = 17
      Top = 17
      Width = 86
      Height = 13
      Caption = 'Para la colecta '
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
  object pFlex: TPanel
    Left = 8
    Top = 230
    Width = 250
    Height = 70
    Color = clWhite
    ParentBackground = False
    TabOrder = 3
    OnClick = pFlexClick
    object Label7: TLabel
      Left = 17
      Top = 18
      Width = 117
      Height = 13
      Caption = 'Mercado Env'#237'os Flex '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = Label7Click
    end
    object lMEFlex: TLabel
      Left = 17
      Top = 36
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
      OnClick = lMEFlexClick
    end
  end
  object pAcordar: TPanel
    Left = 8
    Top = 320
    Width = 250
    Height = 70
    Color = clWhite
    ParentBackground = False
    TabOrder = 4
    OnClick = pAcordarClick
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
      OnClick = Label11Click
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
      OnClick = lAcordarClick
    end
  end
  object tProgressBar: TTimer
    OnTimer = tProgressBarTimer
    Left = 128
    Top = 8
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 232
    Top = 8
  end
end
