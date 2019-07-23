object fOrders: TfOrders
  Left = 0
  Top = 0
  Caption = 'Ordenes'
  ClientHeight = 452
  ClientWidth = 656
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object StringGridBindSourceDB1: TStringGrid
    Tag = 8
    Left = 0
    Top = 0
    Width = 656
    Height = 452
    Align = alClient
    ColCount = 8
    FixedCols = 0
    RowCount = 2
    TabOrder = 0
    ExplicitWidth = 632
    ColWidths = (
      200
      64
      30
      25
      64
      64
      130
      64)
  end
  object FDQuery1: TFDQuery
    Connection = dmML.dbMain
    SQL.Strings = (
      
        'SELECT order_items.title AS TITULO, order_items.full_unit_price ' +
        'AS PRECIO, order_items.quantity AS CANTIDAD, order_items.seller_' +
        'sku AS SKU, buyer.first_name AS NOMBRE, buyer.last_name AS APELL' +
        'IDO, buyer.nickname AS NIK, "imprimir" AS ETIQUETA'
      ' FROM orders'
      ' INNER JOIN order_items ON orders.id = order_items.order_id'
      ' INNER JOIN buyer ON orders.buyer = buyer.id'
      ' GROUP BY orders.buyer')
    Left = 592
    Top = 8
  end
  object BindSourceDB1: TBindSourceDB
    DataSet = FDQuery1
    ScopeMappings = <>
    Left = 24
    Top = 16
  end
  object BindingsList1: TBindingsList
    Methods = <>
    OutputConverters = <>
    Left = 12
    Top = 13
    object LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource
      Category = 'Quick Bindings'
      DataSource = BindSourceDB1
      GridControl = StringGridBindSourceDB1
      Columns = <
        item
          MemberName = 'TITULO'
          Width = 200
        end
        item
          MemberName = 'PRECIO'
        end
        item
          MemberName = 'CANTIDAD'
          Width = 30
        end
        item
          MemberName = 'SKU'
          Width = 25
        end
        item
          MemberName = 'NOMBRE'
        end
        item
          MemberName = 'APELLIDO'
        end
        item
          MemberName = 'NIK'
          Width = 130
        end
        item
          MemberName = 'ETIQUETA'
        end>
    end
  end
end
