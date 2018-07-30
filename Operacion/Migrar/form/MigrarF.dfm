object MigrarForm: TMigrarForm
  Left = 0
  Top = 0
  Caption = 'Migrar'
  ClientHeight = 239
  ClientWidth = 297
  Color = clWindow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 2
    Width = 19
    Height = 13
    Caption = 'URL'
  end
  object Label2: TLabel
    Left = 8
    Top = 48
    Width = 45
    Height = 13
    Caption = 'Resource'
  end
  object Label3: TLabel
    Left = 8
    Top = 92
    Width = 69
    Height = 13
    Caption = 'Consumer Key'
  end
  object Label4: TLabel
    Left = 8
    Top = 136
    Width = 82
    Height = 13
    Caption = 'Consumer Secret'
  end
  object ProcesarButton: TButton
    Left = 209
    Top = 175
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
    Top = 175
    Width = 201
    Height = 50
    TabOrder = 1
  end
  object EditUrl: TEdit
    Left = 8
    Top = 21
    Width = 281
    Height = 21
    TabOrder = 2
    Text = 'https://mysite.com.ar/wp-json/wc/v2/'
  end
  object EditResource: TEdit
    Left = 8
    Top = 65
    Width = 281
    Height = 21
    TabOrder = 3
    Text = 'products/?'
  end
  object EditUser: TEdit
    Left = 8
    Top = 109
    Width = 281
    Height = 21
    TabOrder = 4
    Text = 'ck'
  end
  object EditPassword: TEdit
    Left = 8
    Top = 153
    Width = 281
    Height = 21
    TabOrder = 5
    Text = 'cs'
  end
  object RESTClient1: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'UTF-8, *;q=0.8'
    BaseURL = 'https://gamersenmadryn.com.ar/wp-json/wc/v2'
    Params = <>
    HandleRedirects = True
    RaiseExceptionOn500 = False
    Left = 152
    Top = 240
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
    Left = 152
    Top = 272
  end
  object RESTResponse1: TRESTResponse
    Left = 48
    Top = 240
  end
  object RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter
    Dataset = O
    FieldDefs = <>
    Response = RESTResponse1
    Left = 48
    Top = 272
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
    Left = 48
    Top = 304
  end
  object RESTClientCategories: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'UTF-8, *;q=0.8'
    BaseURL = 'https://gamersenmadryn.com.ar/wp-json/wc/v2'
    Params = <>
    HandleRedirects = True
    RaiseExceptionOn500 = False
    Left = 120
    Top = 240
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
    Left = 120
    Top = 272
  end
  object RESTResponseCategories: TRESTResponse
    ContentType = 'application/json'
    Left = 8
    Top = 240
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
    Top = 304
  end
  object RESTResponseDataSetAdapterCategories: TRESTResponseDataSetAdapter
    Dataset = FDMemTableCategories
    FieldDefs = <>
    Response = RESTResponseCategories
    Left = 8
    Top = 272
  end
  object Q: TIBQuery
    Database = DM.BaseDatos
    Transaction = DM.Transaccion
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 184
    Top = 240
  end
  object T: TIBQuery
    Database = DM.BaseDatos
    Transaction = DM.Transaccion
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 184
    Top = 272
  end
  object D: TIBQuery
    Database = DM.BaseDatos
    Transaction = DM.Transaccion
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 88
    Top = 240
  end
end
