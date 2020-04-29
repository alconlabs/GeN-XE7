object FullMainForm: TFullMainForm
  Left = 425
  Top = 258
  Align = alTop
  BiDiMode = bdLeftToRight
  BorderIcons = [biSystemMenu, biMinimize, biMaximize, biHelp]
  Caption = 'GeN'
  ClientHeight = 7
  ClientWidth = 668
  Color = clBtnFace
  ParentFont = True
  KeyPreview = True
  Menu = MainMenu1
  OldCreateOrder = False
  ParentBiDiMode = False
  Position = poScreenCenter
  WindowState = wsMaximized
  OnClose = FormClose
  OnKeyUp = FormKeyUp
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object WebBrowser1: TWebBrowser
    Left = 0
    Top = 0
    Width = 668
    Height = 7
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 534
    ExplicitHeight = 4
    ControlData = {
      4C0000000A450000B90000000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object MainMenu1: TMainMenu
    Left = 16
    object Operaciones1: TMenuItem
      Caption = 'OPERACION'
      object Vender1: TMenuItem
        Caption = 'VENDER'
        OnClick = Vender1Click
      end
      object REMITO: TMenuItem
        Caption = 'REMITO'
        OnClick = REMITOClick
      end
      object CrearPedido1: TMenuItem
        Caption = 'CREAR PEDIDO'
        Visible = False
        OnClick = CrearPedido1Click
      end
      object Comprar1: TMenuItem
        Caption = 'COMPRAR'
        OnClick = Comprar1Click
      end
      object CuentaCorriente1: TMenuItem
        Caption = 'CUENTA CORRIENTE'
        Visible = False
        OnClick = CuentaCorriente1Click
      end
      object Aumentarporporcentaje1: TMenuItem
        Caption = 'AUMENTAR POR PORCENTAJE'
        Visible = False
        OnClick = Aumentarporporcentaje1Click
      end
      object Anular: TMenuItem
        Caption = 'ANULAR'
        object AnularVenta: TMenuItem
          Caption = 'VENTA'
          OnClick = AnularVentaClick
        end
        object AnularCompra: TMenuItem
          Caption = 'COMPRA'
          OnClick = AnularCompraClick
        end
      end
      object Bonificar: TMenuItem
        Caption = 'BONIFICAR'
        object BonificarCompra: TMenuItem
          Caption = 'COMPRA'
          OnClick = BonificarCompraClick
        end
      end
    end
    object CREDITOS1: TMenuItem
      Caption = 'CREDITOS'
      Visible = False
      OnClick = CREDITOS1Click
      object CREARCREDITO1: TMenuItem
        Caption = 'CREAR CREDITO'
        OnClick = CrearCredito1Click
      end
      object RENDICION2: TMenuItem
        Caption = 'RENDICION'
        object COBRADOR2: TMenuItem
          Caption = 'CARTON'
          OnClick = COBRADOR2Click
        end
        object RENDICIONDECOBRADORES1: TMenuItem
          Caption = 'COBRADOR'
          OnClick = RENDICIONDECOBRADORES1Click
        end
        object RENDICIONDECLIENTES1: TMenuItem
          Caption = 'CLIENTE'
          OnClick = RENDICIONDECLIENTES1Click
        end
        object RENDICIONDECUOTAS1: TMenuItem
          Caption = 'CUOTA'
          OnClick = RENDICIONDECUOTAS1Click
        end
      end
      object NOTADECREDITO1: TMenuItem
        Caption = 'NOTA DE CREDITO'
        OnClick = NOTADECREDITO1Click
      end
      object IMPRIMIRCARTON1: TMenuItem
        Caption = 'GENERAR CARTON'
        OnClick = IMPRIMIRCARTON1Click
      end
    end
    object CONTABILIDAD1: TMenuItem
      Caption = 'CONTABILIDAD'
      object PAGODEIIBB1: TMenuItem
        Caption = 'PAGO DE IIBB'
        OnClick = PAGODEIIBB1Click
      end
      object PAGODEIVA1: TMenuItem
        Caption = 'PAGO DE IVA'
        Visible = False
        OnClick = PAGODEIVA1Click
      end
      object APORTEDECAPITAL1: TMenuItem
        Caption = 'APORTE DE CAPITAL'
        Visible = False
        OnClick = APORTEDECAPITAL1Click
      end
      object ABM2: TMenuItem
        Caption = 'ABM'
        Visible = False
        object CUENTAS1: TMenuItem
          Caption = 'CUENTAS'
          OnClick = CUENTAS1Click
        end
        object CAPITULOS1: TMenuItem
          Caption = 'CAPITULOS'
          OnClick = CAPITULOS1Click
        end
        object RUBROS1: TMenuItem
          Caption = 'RUBROS'
          OnClick = RUBROS1Click
        end
        object IPODEGASTO1: TMenuItem
          Caption = 'TIPO DE GASTO'
          OnClick = IPODEGASTO1Click
        end
        object SOCIOS1: TMenuItem
          Caption = 'SOCIOS'
          OnClick = SOCIOS1Click
        end
      end
      object LIBROS1: TMenuItem
        Caption = 'LIBROS'
        object DIARIO1: TMenuItem
          Caption = 'DIARIO'
          OnClick = DIARIO1Click
        end
        object IVAVENTAS1: TMenuItem
          Caption = 'IVA VENTAS'
          OnClick = IVAVENTAS1Click
        end
        object IVACOMPRAS1: TMenuItem
          Caption = 'IVA COMPRAS'
          OnClick = IVACOMPRAS1Click
        end
      end
    end
    object COBRANZA1: TMenuItem
      Caption = 'COBRANZA'
      Visible = False
      object REGISTRO1: TMenuItem
        Caption = 'REGISTRO'
        OnClick = REGISTRO1Click
      end
      object GESTION1: TMenuItem
        Caption = 'GESTION'
        object EMPRANOS1: TMenuItem
          Caption = 'TEMPRANA'
          OnClick = EMPRANOS1Click
        end
        object EXTRAJUDICIAL1: TMenuItem
          Caption = 'EXTRA JUDICIAL'
          OnClick = EXTRAJUDICIAL1Click
        end
        object JUDICIAL1: TMenuItem
          Caption = 'JUDICIAL'
          OnClick = JUDICIAL1Click
        end
        object INCOBRABLE1: TMenuItem
          Caption = 'INCOBRABLE'
          OnClick = INCOBRABLE1Click
        end
      end
    end
    object Pagos1: TMenuItem
      Caption = 'PAGOS'
      Visible = False
      object PagosaProveedores1: TMenuItem
        Caption = 'PROVEEDORES'
        OnClick = PagosaProveedores1Click
      end
      object PagoaCobradores1: TMenuItem
        Caption = 'COBRADORES'
        Visible = False
        OnClick = PagoaCobradores1Click
      end
      object PagoaVendedores1: TMenuItem
        Caption = 'VENDEDORES'
        Visible = False
        OnClick = PagoaVendedores1Click
      end
    end
    object ABM1: TMenuItem
      Caption = 'ABM'
      object Productos: TMenuItem
        Caption = 'ARTICULO'
        OnClick = ProductosClick
      end
      object Proveedores: TMenuItem
        Caption = 'PROVEEDOR'
        OnClick = ProveedoresClick
      end
      object Clientes: TMenuItem
        Caption = 'CLIENTE'
        OnClick = ClientesClick
      end
      object PLANES1: TMenuItem
        Caption = 'PLANES'
        Visible = False
        OnClick = PLANES1Click
      end
      object Vendedores: TMenuItem
        Caption = 'VENDEDOR'
        Visible = False
        OnClick = VendedoresClick
      end
      object Cobradores: TMenuItem
        Caption = 'COBRADOR'
        Visible = False
        OnClick = CobradoresClick
      end
      object Rubro: TMenuItem
        Caption = 'RUBRO'
        OnClick = RubroClick
      end
      object Categoria: TMenuItem
        Caption = 'CATEGORIA'
        OnClick = CategoriaClick
      end
      object SubCategorias: TMenuItem
        Caption = 'SUBCATEGORIA'
        Visible = False
        OnClick = SubCategoriasClick
      end
      object Bancos: TMenuItem
        Caption = 'BANCOS'
        Visible = False
      end
      object IngresosBrutos: TMenuItem
        Caption = 'IIBB'
        Visible = False
        OnClick = IngresosBrutosClick
      end
    end
    object Listados1: TMenuItem
      Caption = 'LISTADO'
      object Productos1: TMenuItem
        Caption = 'STOCK'
        OnClick = Productos1Click
      end
      object Caja2: TMenuItem
        Caption = 'CAJA'
        OnClick = Caja2Click
      end
      object Ganancias1: TMenuItem
        Caption = 'GANANCIAS'
        Visible = False
        OnClick = Ganancias1Click
      end
      object Pedido1: TMenuItem
        Caption = 'PEDIDOS'
        Visible = False
        OnClick = Pedido1Click
      end
      object ListadePrecios1: TMenuItem
        Caption = 'PRECIOS'
        OnClick = ListadePrecios1Click
      end
      object Clientes1: TMenuItem
        Caption = 'CLIENTES'
        OnClick = Clientes1Click
      end
      object Proveedores1: TMenuItem
        Caption = 'PROVEEDORES'
        Visible = False
      end
      object Cheques2: TMenuItem
        Caption = 'CHEQUES'
        Visible = False
        object EnCartera1: TMenuItem
          Caption = 'EN CARTERA'
        end
        object Entregados1: TMenuItem
          Caption = 'ENTREGADOS'
          OnClick = Entregados1Click
        end
      end
      object RENDICION1: TMenuItem
        Caption = 'RENDICION'
        Visible = False
        object COBRADOR1: TMenuItem
          Caption = 'COBRADOR'
          OnClick = COBRADOR1Click
        end
        object CLIENTE1: TMenuItem
          Caption = 'CLIENTE'
          OnClick = CLIENTE1Click
        end
      end
      object ESTADODECUENTA1: TMenuItem
        Caption = 'ESTADO DE CUENTA'
        Visible = False
        OnClick = ESTADODECUENTA1Click
      end
      object COMPRAS1: TMenuItem
        Caption = 'COMPRAS'
        OnClick = COMPRAS1Click
      end
      object VENTAS1: TMenuItem
        Caption = 'VENTAS'
        OnClick = VENTAS1Click
      end
      object ListadoNotaCredito: TMenuItem
        Caption = 'NOTA DE CREDITO'
        OnClick = ListadoNotaCreditoClick
      end
    end
    object Configuracion1: TMenuItem
      Caption = 'CONFIGURACION'
      object Empresa1: TMenuItem
        Caption = 'EMPRESA'
        OnClick = Empresa1Click
      end
      object Login1: TMenuItem
        Caption = 'USUARIOS'
        Visible = False
        OnClick = Login1Click
      end
      object Sistema1: TMenuItem
        Caption = 'SISTEMA'
        OnClick = Sistema1Click
      end
      object BACKUPCopiadeSeguridad1: TMenuItem
        Caption = 'COPIA DE SEGURIDAD'
        Visible = False
        OnClick = BACKUPCopiadeSeguridad1Click
      end
      object MIGRAR1: TMenuItem
        Caption = 'MIGRAR'
        Hint = 'MIGRAR DESDE VERSIONES ANTERIORES'
        Visible = False
        object MigrarArticulos: TMenuItem
          Caption = 'ARTICULOS'
          OnClick = MigrarArticulosClick
        end
        object MigrarVentas: TMenuItem
          Caption = 'VENTAS'
          OnClick = MigrarVentasClick
        end
      end
      object VaciarBasedeDatos1: TMenuItem
        Caption = 'RESTAURAR SISTEMA'
        Visible = False
        OnClick = VaciarBasedeDatos1Click
      end
      object IniciarSesion1: TMenuItem
        Caption = 'INICIAR SESION'
        OnClick = IniciarSesion1Click
      end
      object WooCommerce1: TMenuItem
        Caption = 'WOOCOMMERCE'
        OnClick = WooCommerce1Click
      end
    end
    object N1: TMenuItem
      Caption = 'SALIR'
      OnClick = N1Click
    end
    object N2: TMenuItem
      Caption = '?'
      object Ayuda1: TMenuItem
        Caption = 'Ayuda'
        OnClick = Ayuda1Click
      end
      object Acercade1: TMenuItem
        Caption = 'Acerca de...'
        OnClick = Acercade1Click
      end
    end
  end
end
