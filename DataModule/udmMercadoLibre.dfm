object dmML: TdmML
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 150
  Width = 215
  object dbMain: TFDConnection
    Params.Strings = (
      'DriverID=SQLite')
    Left = 24
  end
end
