object AfipDataModule: TAfipDataModule
  OldCreateOrder = False
  Height = 256
  Width = 433
  object RESTClient1: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'UTF-8, *;q=0.8'
    BaseURL = 'http://civeloo.com/afip/jsonpb.php'
    Params = <>
    HandleRedirects = True
    RaiseExceptionOn500 = False
    Left = 16
  end
  object RESTRequest1: TRESTRequest
    Client = RESTClient1
    Method = rmPOST
    Params = <
      item
        Kind = pkREQUESTBODY
        name = 'body'
        Options = [poDoNotEncode]
        ContentType = ctAPPLICATION_JSON
      end>
    SynchronizedEvents = False
    Left = 16
    Top = 48
  end
end
