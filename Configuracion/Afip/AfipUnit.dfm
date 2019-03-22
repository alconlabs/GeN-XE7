object AfipForm: TAfipForm
  Left = 0
  Top = 0
  Caption = 'memo'
  ClientHeight = 281
  ClientWidth = 643
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 520
    Top = 0
    Width = 123
    Height = 281
    Align = alRight
    TabOrder = 0
    object Label38: TLabel
      Left = 1
      Top = 142
      Width = 121
      Height = 13
      Align = alBottom
      ExplicitLeft = 6
      ExplicitTop = 136
    end
    object CRTButton: TButton
      Left = 1
      Top = 230
      Width = 121
      Height = 25
      Align = alBottom
      Caption = '3 - CRT'
      TabOrder = 0
      OnClick = CRTButtonClick
    end
    object CSRButton: TButton
      Left = 1
      Top = 205
      Width = 121
      Height = 25
      Align = alBottom
      Caption = '2 - CSR'
      TabOrder = 1
      OnClick = CSRButtonClick
    end
    object AyudaButton: TButton
      Left = 1
      Top = 1
      Width = 121
      Height = 25
      Align = alTop
      Caption = '?'
      TabOrder = 2
      OnClick = AyudaButtonClick
    end
    object Button1: TButton
      Left = 1
      Top = 255
      Width = 121
      Height = 25
      Align = alBottom
      Caption = '4 - Autorizar'
      TabOrder = 3
      OnClick = Button1Click
    end
    object PuntoVentaButton: TButton
      Left = 1
      Top = 180
      Width = 121
      Height = 25
      Align = alBottom
      Caption = '1 - Punto Venta'
      TabOrder = 4
      OnClick = PuntoVentaButtonClick
    end
    object OpensslButton: TButton
      Left = 1
      Top = 155
      Width = 121
      Height = 25
      Align = alBottom
      Caption = '0 - OpenSSL'
      TabOrder = 5
      OnClick = OpensslButtonClick
    end
  end
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 520
    Height = 281
    Align = alClient
    TabOrder = 1
  end
  object SaveTextFileDialog1: TSaveTextFileDialog
    Left = 312
    Top = 144
  end
  object OpenTextFileDialog1: TOpenTextFileDialog
    Left = 312
    Top = 192
  end
  object OpenDialog1: TOpenDialog
    Left = 312
    Top = 240
  end
end
