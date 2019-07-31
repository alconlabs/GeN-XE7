object fMercadoLibreEnvios: TfMercadoLibreEnvios
  AlignWithMargins = True
  Left = 0
  Top = 0
  Caption = 'Mercado Libre Envios'
  ClientHeight = 467
  ClientWidth = 750
  Color = clBtnFace
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
  object ProgressBar1: TProgressBar
    Left = 0
    Top = 0
    Width = 750
    Height = 5
    Align = alTop
    Min = 1
    Position = 1
    TabOrder = 0
    Visible = False
  end
  object pPreparar: TPanel
    Left = 0
    Top = 5
    Width = 250
    Height = 462
    Align = alLeft
    BevelOuter = bvSpace
    TabOrder = 1
    object pPrepararMensajes: TPanel
      AlignWithMargins = True
      Left = 6
      Top = 86
      Width = 238
      Height = 70
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alTop
      ParentBackground = False
      TabOrder = 0
      object lTituloPrepararMensajes: TLabel
        Left = 17
        Top = 17
        Width = 54
        Height = 13
        Caption = 'Mensajes'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lVentasPrepararMensajes: TLabel
        Left = 17
        Top = 33
        Width = 42
        Height = 13
        Caption = '0 ventas'
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
    end
    object pPrepararEnvios: TPanel
      AlignWithMargins = True
      Left = 6
      Top = 166
      Width = 238
      Height = 70
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alTop
      Ctl3D = True
      ParentBackground = False
      ParentCtl3D = False
      TabOrder = 1
      OnClick = pPrepararEnviosClick
      object lTituloPrepararEnvios: TLabel
        Left = 17
        Top = 17
        Width = 141
        Height = 13
        Caption = 'Para la colecta | Ma'#241'ana'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = pPrepararEnviosClick
      end
      object lVentasPrepararEnvios: TLabel
        Left = 17
        Top = 33
        Width = 42
        Height = 13
        Caption = '0 ventas'
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        OnClick = pPrepararEnviosClick
      end
    end
    object pPrepararFlex: TPanel
      AlignWithMargins = True
      Left = 6
      Top = 246
      Width = 238
      Height = 70
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alTop
      ParentBackground = False
      TabOrder = 2
      OnClick = pPrepararFlexClick
      object lTituloPrepararFlex: TLabel
        Left = 17
        Top = 18
        Width = 175
        Height = 13
        Caption = 'Mercado Env'#237'os Flex  | Ma'#241'ana'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = pPrepararFlexClick
      end
      object lVentasPrepararFlex: TLabel
        Left = 17
        Top = 36
        Width = 42
        Height = 13
        Caption = '0 ventas'
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        OnClick = pPrepararFlexClick
      end
    end
    object pPrepararAcordar: TPanel
      AlignWithMargins = True
      Left = 6
      Top = 326
      Width = 238
      Height = 70
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alTop
      ParentBackground = False
      TabOrder = 3
      OnClick = pPrepararAcordarClick
      object lTituloPrepararAcordar: TLabel
        Left = 17
        Top = 17
        Width = 207
        Height = 13
        Caption = 'Acordar con el comprador | Ma'#241'ana '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = pPrepararAcordarClick
      end
      object lVentasPrepararAcordar: TLabel
        Left = 17
        Top = 33
        Width = 42
        Height = 13
        Caption = '0 ventas'
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        OnClick = pPrepararAcordarClick
      end
    end
    object pTituloPreparar: TPanel
      AlignWithMargins = True
      Left = 6
      Top = 6
      Width = 238
      Height = 70
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 4
      object lPreparar: TLabel
        Left = 17
        Top = 16
        Width = 92
        Height = 16
        Caption = 'Para preparar'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = lPrepararClick
      end
      object lVentasPreparar: TLabel
        Left = 17
        Top = 35
        Width = 42
        Height = 13
        Caption = '0 ventas'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
    end
  end
  object pDespachar: TPanel
    Left = 250
    Top = 5
    Width = 250
    Height = 462
    Align = alLeft
    TabOrder = 2
    object pDespacharDemoradas: TPanel
      AlignWithMargins = True
      Left = 6
      Top = 86
      Width = 238
      Height = 70
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alTop
      ParentBackground = False
      TabOrder = 0
      object lTituloDespacharDemoradas: TLabel
        Left = 17
        Top = 17
        Width = 65
        Height = 13
        Caption = 'Demoradas'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lVentasDespacharDemoradas: TLabel
        Left = 17
        Top = 33
        Width = 42
        Height = 13
        Caption = '0 ventas'
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
    end
    object pDespacharMensajes: TPanel
      AlignWithMargins = True
      Left = 6
      Top = 166
      Width = 238
      Height = 70
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alTop
      ParentBackground = False
      TabOrder = 1
      object lTituloDespacharMensajes: TLabel
        Left = 17
        Top = 17
        Width = 98
        Height = 13
        Caption = 'Mensajes nuevos'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lVentasDespacharMensajes: TLabel
        Left = 17
        Top = 33
        Width = 42
        Height = 13
        Caption = '0 ventas'
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
    end
    object pDespacharFlex: TPanel
      AlignWithMargins = True
      Left = 6
      Top = 246
      Width = 238
      Height = 70
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alTop
      ParentBackground = False
      TabOrder = 2
      OnClick = pDespacharFlexClick
      object lTituloDespacharFlex: TLabel
        Left = 17
        Top = 18
        Width = 152
        Height = 13
        Caption = 'Mercado Env'#237'os FLex | Hoy'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = pDespacharFlexClick
      end
      object lVentasDespacharFlex: TLabel
        Left = 17
        Top = 36
        Width = 42
        Height = 13
        Caption = '0 ventas'
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        OnClick = pDespacharFlexClick
      end
    end
    object pDespacharColecta: TPanel
      AlignWithMargins = True
      Left = 6
      Top = 326
      Width = 238
      Height = 70
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alTop
      ParentBackground = False
      TabOrder = 3
      OnClick = pDespacharColectaClick
      object lTituloDespacharColecta: TLabel
        Left = 17
        Top = 14
        Width = 118
        Height = 13
        Caption = 'Para la colecta | Hoy'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = pDespacharColectaClick
      end
      object lVentasDespacharColecta: TLabel
        Left = 17
        Top = 33
        Width = 42
        Height = 13
        Caption = '0 ventas'
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        OnClick = pDespacharColectaClick
      end
    end
    object pTituloDespachar: TPanel
      AlignWithMargins = True
      Left = 6
      Top = 6
      Width = 238
      Height = 70
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 4
      object lDespachar: TLabel
        Left = 17
        Top = 16
        Width = 144
        Height = 16
        Caption = 'Listas para despachar'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lVentasDespachar: TLabel
        Left = 17
        Top = 35
        Width = 42
        Height = 13
        Caption = '0 ventas'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
    end
  end
  object Panel1: TPanel
    Left = 500
    Top = 5
    Width = 250
    Height = 462
    Align = alLeft
    TabOrder = 3
    object pTransitoCamino: TPanel
      AlignWithMargins = True
      Left = 6
      Top = 166
      Width = 238
      Height = 70
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alTop
      ParentBackground = False
      TabOrder = 0
      object lTituloTransitoCamino: TLabel
        Left = 17
        Top = 17
        Width = 58
        Height = 13
        Caption = 'En Camino'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lVentasTransitoCamino: TLabel
        Left = 17
        Top = 33
        Width = 42
        Height = 13
        Caption = '0 ventas'
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
    end
    object pTransitoMensajes: TPanel
      AlignWithMargins = True
      Left = 6
      Top = 86
      Width = 238
      Height = 70
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alTop
      ParentBackground = False
      TabOrder = 1
      object lTituloTransitoMensajes: TLabel
        Left = 17
        Top = 17
        Width = 98
        Height = 13
        Caption = 'Mensajes nuevos'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lVentasTransitoMensajes: TLabel
        Left = 17
        Top = 33
        Width = 42
        Height = 13
        Caption = '0 ventas'
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
    end
    object pTransitoEsperandoRetiro: TPanel
      AlignWithMargins = True
      Left = 6
      Top = 246
      Width = 238
      Height = 70
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alTop
      ParentBackground = False
      TabOrder = 2
      object lTituloTransitoEsperandoRetiro: TLabel
        Left = 17
        Top = 18
        Width = 179
        Height = 13
        Caption = 'Esperando retiro del comprador'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lVentasTransitoEsperandoRetiro: TLabel
        Left = 17
        Top = 36
        Width = 42
        Height = 13
        Caption = '0 ventas'
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        OnClick = pDespacharFlexClick
      end
    end
    object Panel6: TPanel
      AlignWithMargins = True
      Left = 6
      Top = 6
      Width = 238
      Height = 70
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 3
      object lTransito: TLabel
        Left = 17
        Top = 16
        Width = 72
        Height = 16
        Caption = 'En Transito'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lVentasTransito: TLabel
        Left = 17
        Top = 35
        Width = 42
        Height = 13
        Caption = '0 ventas'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
    end
  end
  object tProgressBar: TTimer
    OnTimer = tProgressBarTimer
    Left = 136
    Top = 8
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 168
    Top = 8
  end
end
