object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 176
  Width = 369
  object BaseDatos: TIBDatabase
    DatabaseName = 'C:\Users\Usuario\Documents\GitHub\GeN-XE7\Bin\GeN\db\GeN.FDB'
    Params.Strings = (
      'user_name=SYSDBA'
      'password=masterkey'
      'lc_ctype=WIN1252'
      'sql_role_name=3')
    LoginPrompt = False
    DefaultTransaction = Transaccion
    ServerType = 'IBServer'
    AllowStreamedConnected = False
    Left = 80
    Top = 16
  end
  object Transaccion: TIBTransaction
    DefaultDatabase = BaseDatos
    DefaultAction = TARollback
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 80
    Top = 64
  end
  object ConfigQuery: TIBQuery
    Database = BaseDatos
    Transaction = Transaccion
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 152
    Top = 16
  end
  object Query: TIBQuery
    Database = BaseDatos
    Transaction = Transaccion
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 152
    Top = 64
  end
end
