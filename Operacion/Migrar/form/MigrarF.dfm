object MigrarForm: TMigrarForm
  Left = 0
  Top = 0
  Caption = 'Migrar'
  ClientHeight = 652
  ClientWidth = 526
  Color = clWindow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object ProcesarButton: TButton
    Left = 337
    Top = 148
    Width = 80
    Height = 50
    Caption = 'PROCESAR'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnClick = ProcesarButtonClick
  end
  object ProgressBar1: TProgressBar
    Left = 8
    Top = 168
    Width = 323
    Height = 30
    TabOrder = 1
  end
  object Edit1: TEdit
    Left = 40
    Top = 30
    Width = 178
    Height = 21
    TabOrder = 2
  end
  object BitBtn1: TBitBtn
    Left = 239
    Top = 28
    Width = 49
    Height = 25
    Caption = 'desde'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = BitBtn1Click
  end
  object EditUrl: TEdit
    Left = 40
    Top = 57
    Width = 178
    Height = 21
    TabOrder = 4
    Text = 'https://gamersenmadryn.com.ar/wp-json/wc/v2/'
  end
  object EditResource: TEdit
    Left = 40
    Top = 81
    Width = 178
    Height = 21
    TabOrder = 5
    Text = 'products/2340?'
  end
  object EditUser: TEdit
    Left = 40
    Top = 108
    Width = 178
    Height = 21
    TabOrder = 6
  end
  object EditPassword: TEdit
    Left = 40
    Top = 135
    Width = 178
    Height = 21
    TabOrder = 7
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 204
    Width = 411
    Height = 101
    DataSource = DataSource1
    TabOrder = 8
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object Button1: TButton
    Left = 224
    Top = 77
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 9
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 8
    Top = 311
    Width = 411
    Height = 103
    Lines.Strings = (
      'Memo1')
    TabOrder = 10
  end
  object RESTClient1: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'UTF-8, *;q=0.8'
    BaseURL = 'https://gamersenmadryn.com.ar/wp-json/wc/v2'
    Params = <>
    HandleRedirects = True
    RaiseExceptionOn500 = False
  end
  object RESTRequest1: TRESTRequest
    Client = RESTClient1
    Params = <
      item
        name = 'consumer_key'
        Value = 'ck_7c1d43a542563b3cf47e1bb51b86ccac0099c883'
      end>
    Resource = 'products/?'
    Response = RESTResponse1
    SynchronizedEvents = False
    Top = 32
  end
  object RESTResponse1: TRESTResponse
    Top = 64
  end
  object RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter
    Dataset = O
    FieldDefs = <>
    Response = RESTResponse1
    Top = 96
  end
  object O: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    StoreDefs = True
    Top = 128
  end
  object DataSource1: TDataSource
    DataSet = O
    Top = 168
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'ConnectionDef=GeN')
    Left = 376
    Top = 8
  end
  object T: TFDQuery
    Connection = FDConnection1
    Left = 376
    Top = 56
  end
  object D: TFDQuery
    Connection = FDConnection1
    Left = 376
    Top = 104
  end
  object Q: TFDQuery
    Connection = FDConnection1
    Left = 320
    Top = 56
  end
  object FDMemTable1: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 288
    Top = 120
  end
  object RESTClientCategories: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'UTF-8, *;q=0.8'
    BaseURL = 'https://gamersenmadryn.com.ar/wp-json/wc/v2'
    Params = <>
    HandleRedirects = True
    RaiseExceptionOn500 = False
    Left = 8
    Top = 416
  end
  object RESTRequestCategories: TRESTRequest
    Client = RESTClientCategories
    Params = <
      item
        name = 'consumer_key'
        Value = 'ck_7c1d43a542563b3cf47e1bb51b86ccac0099c883'
      end>
    Resource = 'products/?'
    Response = RESTResponseCategories
    SynchronizedEvents = False
    Left = 8
    Top = 464
  end
  object RESTResponseCategories: TRESTResponse
    ContentType = 'application/json'
    Left = 8
    Top = 512
  end
  object FDMemTableCategories: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    StoreDefs = True
    Left = 8
    Top = 608
  end
  object RESTResponseDataSetAdapterCategories: TRESTResponseDataSetAdapter
    Dataset = FDMemTableCategories
    FieldDefs = <>
    Response = RESTResponseCategories
    Left = 8
    Top = 560
  end
end
