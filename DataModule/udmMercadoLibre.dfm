object dmML: TdmML
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 325
  Width = 293
  object dbMain: TFDConnection
    Params.Strings = (
      'DriverID=SQLite')
    Left = 8
  end
  object tOrders: TFDQuery
    Connection = dbMain
    SQL.Strings = (
      'SELECT * FROM orders')
    Left = 64
  end
  object tOrder_items: TFDQuery
    Connection = dbMain
    SQL.Strings = (
      'SELECT * FROM order_items')
    Left = 64
    Top = 48
  end
  object tMessages: TFDQuery
    Connection = dbMain
    SQL.Strings = (
      'SELECT * FROM messages')
    Left = 64
    Top = 96
  end
end
