object fOrders: TfOrders
  Left = 0
  Top = 0
  Caption = 'Ordenes'
  ClientHeight = 452
  ClientWidth = 727
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
    Width = 727
    Height = 452
    Align = alClient
    ColCount = 8
    DrawingStyle = gdsGradient
    FixedCols = 0
    RowCount = 2
    TabOrder = 0
    OnClick = StringGridBindSourceDB1Click
    ColWidths = (
      200
      70
      40
      40
      70
      70
      130
      70)
  end
  object qOrders: TFDQuery
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
    Left = 584
    Top = 54
  end
  object BindSourceDB1: TBindSourceDB
    DataSet = qOrders
    ScopeMappings = <>
    Left = 24
    Top = 24
  end
  object BindingsList1: TBindingsList
    Methods = <>
    OutputConverters = <>
    Left = 12
    Top = 21
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
          Width = 70
        end
        item
          MemberName = 'CANTIDAD'
          Width = 40
        end
        item
          MemberName = 'SKU'
          Width = 40
        end
        item
          MemberName = 'NOMBRE'
          Width = 70
        end
        item
          MemberName = 'APELLIDO'
          Width = 70
        end
        item
          MemberName = 'NIK'
          Width = 130
        end
        item
          MemberName = 'ETIQUETA'
          Width = 70
        end>
    end
  end
end
