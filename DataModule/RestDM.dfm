object RestDataModule: TRestDataModule
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 289
  Width = 302
  object RESTResponseCategories: TRESTResponse
    ContentType = 'application/json'
    Left = 112
    Top = 80
  end
  object RESTResponse1: TRESTResponse
    Left = 144
    Top = 80
  end
  object RESTClientCategories: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'UTF-8, *;q=0.8'
    BaseURL = 'https://gamersenmadryn.com.ar/wp-json/wc/v2'
    Params = <>
    RaiseExceptionOn500 = False
    Left = 112
  end
  object RESTClient1: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'UTF-8, *;q=0.8'
    BaseURL = 'https://gamersenmadryn.com.ar/wp-json/wc/v2'
    Params = <>
    RaiseExceptionOn500 = False
    Left = 144
  end
  object Q: TIBQuery
    Database = DM.BaseDatos
    Transaction = DM.Transaccion
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 176
  end
  object T: TIBQuery
    Database = DM.BaseDatos
    Transaction = DM.Transaccion
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 176
    Top = 32
  end
  object RESTRequest1: TRESTRequest
    Client = RESTClient1
    Params = <
      item
        Name = 'consumer_key'
        Value = 'ck_7c1d43a542563b3cf47e1bb51b86ccac0099c883'
      end>
    Resource = 'products/?'
    Response = RESTResponse1
    SynchronizedEvents = False
    Left = 144
    Top = 32
  end
  object RESTRequestCategories: TRESTRequest
    Client = RESTClientCategories
    Params = <
      item
        Name = 'consumer_key'
        Value = 'ck_7c1d43a542563b3cf47e1bb51b86ccac0099c883'
      end>
    Resource = 'products/?'
    Response = RESTResponseCategories
    SynchronizedEvents = False
    Left = 112
    Top = 32
  end
  object RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter
    Dataset = O
    FieldDefs = <>
    Response = RESTResponse1
    Left = 144
    Top = 120
  end
  object RESTResponseDataSetAdapterCategories: TRESTResponseDataSetAdapter
    Dataset = FDMemTableCategories
    FieldDefs = <>
    Response = RESTResponseCategories
    Left = 112
    Top = 120
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
    Left = 112
    Top = 168
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
    Left = 144
    Top = 168
  end
  object D: TIBQuery
    Database = DM.BaseDatos
    Transaction = DM.Transaccion
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 80
  end
end
