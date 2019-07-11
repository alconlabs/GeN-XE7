object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'fMercadoLibreEnvios'
  ClientHeight = 460
  ClientWidth = 632
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
  object BitBtn1: TBitBtn
    Left = 554
    Top = 434
    Width = 75
    Height = 25
    Caption = 'Actualizar'
    TabOrder = 0
    OnClick = BitBtn1Click
  end
  object StringGridBindSourceDB1: TStringGrid
    Left = 0
    Top = 0
    Width = 273
    Height = 460
    Align = alLeft
    ColCount = 1
    FixedCols = 0
    RowCount = 2
    TabOrder = 1
    OnClick = StringGridBindSourceDB1Click
    ExplicitHeight = 337
  end
  object bImprimirEtiqueta: TButton
    Left = 279
    Top = 434
    Width = 75
    Height = 25
    Caption = 'Imprimir'
    TabOrder = 2
    OnClick = bImprimirEtiquetaClick
  end
  object sgOrder_items: TStringGrid
    Left = 279
    Top = 0
    Width = 353
    Height = 137
    ColCount = 1
    FixedCols = 0
    RowCount = 2
    TabOrder = 3
    ColWidths = (
      347)
  end
  object ProgressBar1: TProgressBar
    Left = 224
    Top = 176
    Width = 150
    Height = 16
    Min = 1
    Position = 1
    TabOrder = 4
    Visible = False
  end
  object sgMessages: TStringGrid
    Left = 279
    Top = 143
    Width = 353
    Height = 194
    ColCount = 1
    FixedCols = 0
    RowCount = 2
    TabOrder = 5
    OnClick = sgMessagesClick
    ColWidths = (
      348)
  end
  object Memo1: TMemo
    Left = 279
    Top = 343
    Width = 353
    Height = 89
    ScrollBars = ssVertical
    TabOrder = 6
  end
  object BindSourceDB1: TBindSourceDB
    DataSet = dmML.tOrders
    ScopeMappings = <>
    Left = 32
    Top = 16
  end
  object BindingsList1: TBindingsList
    Methods = <>
    OutputConverters = <>
    Left = 20
    Top = 5
    object LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource
      Category = 'Quick Bindings'
      DataSource = BindSourceDB1
      GridControl = StringGridBindSourceDB1
      Columns = <>
    end
    object LinkGridToDataSourceBindSourceDB2: TLinkGridToDataSource
      Category = 'Quick Bindings'
      DataSource = BindSourceDB2
      GridControl = sgOrder_items
      Columns = <>
      DefaultColumnWidth = 350
    end
    object LinkGridToDataSourceBindSourceDB3: TLinkGridToDataSource
      Category = 'Quick Bindings'
      DataSource = BindSourceDB3
      GridControl = sgMessages
      Columns = <>
      DefaultColumnWidth = 350
    end
  end
  object BindSourceDB2: TBindSourceDB
    DataSet = dmML.tOrder_items
    ScopeMappings = <>
    Left = 288
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 288
    Top = 168
  end
  object BindSourceDB3: TBindSourceDB
    DataSet = dmML.tMessages
    ScopeMappings = <>
    Left = 304
    Top = 224
  end
end
