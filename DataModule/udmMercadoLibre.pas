unit udmMercadoLibre;

interface

uses FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs, FireDAC.FMXUI.Wait, System.Classes, Data.DB,
  FireDAC.Comp.Client, System.IOUtils, System.SysUtils, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet,
  FMX.Types, FMX.Dialogs, FireDAC.Comp.BatchMove.Text, FireDAC.Comp.BatchMove,
  FireDAC.Comp.BatchMove.DataSet, FireDAC.Phys.FB, FireDAC.Phys.FBDef;

type
  TdmML = class(TDataModule)
    dbMain: TFDConnection;
    tOrders: TFDQuery;
    tOrder_items: TFDQuery;
    tMessages: TFDQuery;
    tOrdersid: TWideMemoField;
    tOrderscomments: TWideMemoField;
    tOrdersstatus: TWideMemoField;
    tOrdersstatus_detail: TWideMemoField;
    tOrdersdate_created: TWideMemoField;
    tOrdersdate_closed: TWideMemoField;
    tOrderslast_updated: TWideMemoField;
    tOrdersexpiration_date: TWideMemoField;
    tOrdersdate_last_updated: TWideMemoField;
    tOrdershidden_for_seller: TWideMemoField;
    tOrderscurrency_id: TWideMemoField;
    tOrdersorder_items: TWideMemoField;
    tOrderstotal_amount: TWideMemoField;
    tOrdersmediations: TWideMemoField;
    tOrderspayments: TWideMemoField;
    tOrdersshipping: TWideMemoField;
    tOrdersorder_request: TWideMemoField;
    tOrderspickup_id: TWideMemoField;
    tOrdersbuyer: TWideMemoField;
    tOrdersseller: TWideMemoField;
    tOrdersfeedback: TWideMemoField;
    tOrderstags: TWideMemoField;
    tOrdersmanufacturing_ending_date: TWideMemoField;
    tOrderspack_id: TWideMemoField;
    tOrdersfulfilled: TWideMemoField;
    tOrderstotal_amount_with_shipping: TWideMemoField;
    tOrderspaid_amount: TWideMemoField;
    tOrderscoupon: TWideMemoField;
    tOrderstaxes: TWideMemoField;
    FDQuery1: TFDQuery;
    tOrder_itemsid: TWideMemoField;
    tOrder_itemsorder_id: TWideMemoField;
    tOrder_itemsitem_id: TWideMemoField;
    tOrder_itemstitle: TWideMemoField;
    tOrder_itemscategory_id: TWideMemoField;
    tOrder_itemsvariation_id: TWideMemoField;
    tOrder_itemsseller_custom_field: TWideMemoField;
    tOrder_itemswarranty: TWideMemoField;
    tOrder_itemscondition: TWideMemoField;
    tOrder_itemsseller_sku: TWideMemoField;
    tOrder_itemsquantity: TWideMemoField;
    tOrder_itemssale_fee: TWideMemoField;
    tOrder_itemslisting_type_id: TWideMemoField;
    tOrder_itemsbase_currency_id: TWideMemoField;
    tOrder_itemsunit_price: TWideMemoField;
    tOrder_itemsfull_unit_price: TWideMemoField;
    tOrder_itemsbase_exchange_rate: TWideMemoField;
    tOrder_itemscurrency_id: TWideMemoField;
    tOrder_itemsmanufacturing_days: TWideMemoField;
    tMessagesid: TWideMemoField;
    tMessagesorder_id: TWideMemoField;
    tMessagespack_id: TWideMemoField;
    tMessagesmessage_id: TWideMemoField;
    tMessagesdate_received: TWideMemoField;
    tMessagesdate: TWideMemoField;
    tMessagesdate_available: TWideMemoField;
    tMessagesdate_notified: TWideMemoField;
    tMessagesdate_read: TWideMemoField;
    tMessagesfrom_user_id: TWideMemoField;
    tMessagesfrom_email: TWideMemoField;
    tMessagesfrom_name: TWideMemoField;
    tMessagesto_user_id: TWideMemoField;
    tMessagesto_email: TWideMemoField;
    tMessagessubject: TWideMemoField;
    tMessagestext_plain: TWideMemoField;
    tMessagesattachments: TWideStringField;
    tMessagesattachments_validations_invalid_size: TWideMemoField;
    tMessagesattachments_validations_invalid_extension: TWideMemoField;
    tMessagesattachments_validations_forbidden: TWideMemoField;
    tMessagesattachments_validations_internal_error: TWideMemoField;
    tMessagessite_id: TWideMemoField;
    tMessagesresource: TWideMemoField;
    tMessagesresource_id: TWideMemoField;
    tMessagesstatus: TWideMemoField;
    tMessagesmoderation_status: TWideMemoField;
    tMessagesmoderation_date_moderated: TWideMemoField;
    tMessagesmoderation_source: TWideMemoField;
    tMessagesconversation_first_message: TWideMemoField;
    tMessagesconversation_status: TWideMemoField;
    tMessagesconversation_status_date: TWideMemoField;
    tMessagesconversation_substatus: TWideMemoField;
    tMessagesconversation_is_blocking_allowed: TWideMemoField;
    tShipping: TFDQuery;
    tShippingid: TWideMemoField;
    tShippingorder_id: TWideMemoField;
    tShippingsite_id: TWideMemoField;
    tShippingshipment_type: TWideMemoField;
    tShippingmode: TWideMemoField;
    tShippingshipping_mode: TWideMemoField;
    tShippingstatus: TWideMemoField;
    tShippingsubstatus: TWideMemoField;
    tShippingdate_created: TWideMemoField;
    tShippingreceiver_address: TWideMemoField;
    tShippingsender_address: TWideMemoField;
    tShippingcurrency_id: TWideMemoField;
    tShippingdate_first_printed: TWideMemoField;
    tShippingservice_id: TWideMemoField;
    tShippingshipping_items: TWideMemoField;
    tShippingreceiver_id: TWideMemoField;
    tShippingsender_id: TWideMemoField;
    tShippingshipping_option: TWideMemoField;
    tShippinglogistic_type: TWideMemoField;
    tShippingpicking_type: TWideMemoField;
    tShippingcost_components: TWideMemoField;
    tShippingcost: TWideMemoField;
    tBuyer: TFDQuery;
    tBuyerid: TWideMemoField;
    tBuyernickname: TWideMemoField;
    tBuyeremail: TWideMemoField;
    tBuyerphone: TWideMemoField;
    tBuyeralternative_phone: TWideMemoField;
    tBuyerfirst_name: TWideMemoField;
    tBuyerlast_name: TWideMemoField;
    tBuyerbilling_info: TWideMemoField;
    tDespachados: TFDQuery;
    tDespachadosorder_id: TWideMemoField;
    tDespachadosembalado: TWideMemoField;
    tDespachadosenviado: TWideMemoField;
    FDBatchMove2: TFDBatchMove;
    FDBatchMoveDataSetReader1: TFDBatchMoveDataSetReader;
    FDBatchMoveTextWriter1: TFDBatchMoveTextWriter;
    SaveDialog1: TSaveDialog;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    dBname, path : string;
    procedure IniciarVariables;
    procedure OrdenesPrueba;
  public
    { Public declarations }
    refreshToken, seller_id, sqlOrder_items, sqlCountShipping, sqlCountMessages,
    sqlOrderFrom, sqlOrderWhere, sqlNoEmbalado, sqlEmbalado, sqlReady_to_ship,
    sqlShipped, sqlDelivered, sqlNoStatus, sqlPrepararFlex, sqlPrepararEnvios,
    sqlPrepararAcordar, sqlSMMe1, sqlSMMe2, sqlSMCustom, sqlDespacharColecta,
    sqlTransitoCamino, sqlDespacharFlex
//    order_id, order_items_quantity, buyer_id, order_status, item_title, item_id,
//    shipping_id, pack_id, message_id, message_text
    : string;
    procedure AgregarOrder(order_id,order_status,buyer_id,shipping_id:string);
    procedure AgregarOrder_items(order_id,item_id,item_title:string);
    procedure ActualizarRefreshToken;
    procedure AgregarSeller(seller_id:string);
    procedure AgregarPack(order_id,pack_id:string);
    procedure AgregarMessages(order_id,message_text,message_id:string);
    function CantidadRegistros(tabla,codigo:string):integer;
    procedure BorrarRegistros(tabla,codigo:string);
    procedure InsertarRegistros(tabla,campos,valores:string);
    procedure Agregar(tabla,campos,valores,codigo:string);
    procedure AgregarDespachados(order_id,embalado:string);
  end;

var
  dmML: TdmML;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure TdmML.DataModuleCreate(Sender: TObject);
begin
  with dbMain do
  begin
    path := TPath.GetDocumentsPath()+'\Civeloo\MercadoLibreVentas\db';
    dBname := path+'\db.sdb';
    if not FileExists(DBName) then
      ForceDirectories(path);
    Params.Values['database'] := DBName;
    Connected:= True;

    ExecSQL('CREATE TABLE IF NOT EXISTS token ('
      +'refresh TEXT'
    +')');

    ExecSQL('CREATE TABLE IF NOT EXISTS seller ('
      +'seller_id TEXT PRIMARY KEY'
    +')');

    if ExecSQLScalar('SELECT COUNT(refresh) FROM token')=0 then
      ExecSQL('INSERT INTO token (refresh) ' +
                   'VALUES(:N)', ['']);

//    ExecSQL('CREATE TABLE IF NOT EXISTS buyers ('
//    +'buyer_id TEXT PRIMARY KEY'
//    +')');

    ExecSQL('CREATE TABLE IF NOT EXISTS orders ('
      +'id TEXT PRIMARY KEY'
      +', comments TEXT'
      +', status TEXT'
      +', status_detail TEXT'
      +', date_created TEXT'
      +', date_closed TEXT'
      +', last_updated TEXT'
      +', expiration_date TEXT'
      +', date_last_updated TEXT'
      +', hidden_for_seller TEXT'
      +', currency_id TEXT'
      +', order_items TEXT'
      +', total_amount TEXT'
      +', mediations TEXT'
      +', payments TEXT'
      +', shipping TEXT'
      +', order_request TEXT'
      +', pickup_id TEXT'
      +', buyer TEXT'
      +', seller TEXT'
      +', feedback TEXT'
      +', tags TEXT'
      +', manufacturing_ending_date TEXT'
      +', pack_id TEXT'
      +', fulfilled TEXT'
      +', total_amount_with_shipping TEXT'
      +', paid_amount TEXT'
      +', coupon TEXT'
      +', taxes TEXT'
    +')');

    ExecSQL('CREATE TABLE IF NOT EXISTS coupon ('
      +'id TEXT PRIMARY KEY'
      +', order_id TEXT'
      +', amount TEXT'
    +')');

    ExecSQL('CREATE TABLE IF NOT EXISTS order_request ('
      +'id TEXT PRIMARY KEY'
      +', order_id TEXT'
      +', return TEXT'
      +', change TEXT'
    +')');

    ExecSQL('CREATE TABLE IF NOT EXISTS feedback ('
      +'id TEXT PRIMARY KEY'
      +', order_id TEXT'
      +', sale TEXT'
      +', purchase TEXT'
    +')');

    ExecSQL('CREATE TABLE IF NOT EXISTS status_detail ('
      +'id TEXT PRIMARY KEY'
      +', order_id TEXT'
      +', code TEXT'
      +', description TEXT'
    +')');

    ExecSQL('CREATE TABLE IF NOT EXISTS order_items ('
      +'id TEXT PRIMARY KEY'
      +', order_id TEXT'
      +', item_id TEXT'
      +', title TEXT'
      +', category_id TEXT'
      +', variation_id TEXT'
      +', variation_attributes TEXT'
      +', seller_custom_field TEXT'
      +', warranty TEXT'
      +', condition TEXT'
      +', seller_sku TEXT'
      +', quantity TEXT'
      +', differential_pricing_id TEXT'
      +', sale_fee TEXT'
      +', listing_type_id TEXT'
      +', base_currency_id TEXT'
      +', unit_price TEXT'
      +', full_unit_price TEXT'
      +', base_exchange_rate TEXT'
      +', currency_id TEXT'
      +', manufacturing_days TEXT'
    +')');

//    ExecSQL('CREATE TABLE IF NOT EXISTS items ('
//      +'order_id TEXT'
//      +', id TEXT'
//      +', title TEXT'
//      +', category_id TEXT'
//      +', variation_id TEXT'
//      +', seller_custom_field TEXT'
//      +', warranty TEXT'
//      +', condition TEXT'
//      +', seller_sku TEXT'
//    +')');

    ExecSQL('CREATE TABLE IF NOT EXISTS messages ('
      +'id TEXT PRIMARY KEY'
      +', order_id TEXT'
      +', pack_id TEXT'
      +', message_id TEXT'
      +', date_received TEXT'
      +', date TEXT'
      +', date_available TEXT'
      +', date_notified TEXT'
      +', date_read TEXT'
      +', from_user_id TEXT'
      +', from_email TEXT'
      +', from_name TEXT'
      +', to_user_id TEXT'
      +', to_email TEXT'
      +', subject TEXT'
      +', text_plain TEXT'
      +', attachments'
      +', attachments_validations_invalid_size TEXT'
      +', attachments_validations_invalid_extension TEXT'
      +', attachments_validations_forbidden TEXT'
      +', attachments_validations_internal_error TEXT'
      +', site_id TEXT'
      +', resource TEXT'
      +', resource_id TEXT'
      +', status TEXT'
      +', moderation_status TEXT'
      +', moderation_date_moderated TEXT'
      +', moderation_source TEXT'
      +', conversation_first_message TEXT'
      +', conversation_status TEXT'
      +', conversation_status_date TEXT'
      +', conversation_substatus TEXT'
      +', conversation_is_blocking_allowed TEXT'
    +')');

    ExecSQL('CREATE TABLE IF NOT EXISTS packs ('
      +'id TEXT PRIMARY KEY'
      +', order_id TEXT'
      +', pack_id TEXT'
    +')');

    ExecSQL('CREATE TABLE IF NOT EXISTS despachados ('
      +'order_id TEXT PRIMARY KEY'
      +', embalado TEXT'
      +', enviado TEXT'
    +')');

    ExecSQL('CREATE TABLE IF NOT EXISTS payments ('
      +'id TEXT PRIMARY KEY'
      +', order_id TEXT'
      +', payer_id TEXT'
      +', collector TEXT'
      +', card_id TEXT'
      +', site_id TEXT'
      +', reason TEXT'
      +', payment_method_id TEXT'
      +', currency_id TEXT'
      +', installments TEXT'
      +', issuer_id TEXT'
      +', atm_transfer_reference TEXT'
      +', coupon_id TEXT'
      +', activation_uri TEXT'
      +', operation_type TEXT'
      +', payment_type TEXT'
      +', available_actions TEXT'
      +', status TEXT'
      +', status_code TEXT'
      +', status_detail TEXT'
      +', transaction_amount TEXT'
      +', taxes_amount TEXT'
      +', shipping_cost TEXT'
      +', coupon_amount TEXT'
      +', overpaid_amount TEXT'
      +', total_paid_amount TEXT'
      +', installment_amount TEXT'
      +', deferred_period TEXT'
      +', date_approved TEXT'
      +', authorization_code TEXT'
      +', transaction_order_id TEXT'
      +', date_created TEXT'
      +', date_last_modified TEXT'
    +')');

    ExecSQL('CREATE TABLE IF NOT EXISTS atm_transfer_reference ('
      +'id TEXT PRIMARY KEY'
      +', payments_id TEXT'
      +', company_id TEXT'
      +', transaction_id TEXT'
    +')');

    ExecSQL('CREATE TABLE IF NOT EXISTS available_actions ('
      +'id TEXT PRIMARY KEY'
      +', payments_id TEXT'
      +', refund TEXT'
    +')');

    ExecSQL('CREATE TABLE IF NOT EXISTS collector ('
      +'id TEXT PRIMARY KEY'
      +', payments_id TEXT'
    +')');

    ExecSQL('CREATE TABLE IF NOT EXISTS shipping ('
      +'id TEXT PRIMARY KEY'
      +', order_id TEXT'
      +', site_id TEXT'
      +', shipment_type TEXT'
      +', mode TEXT'
      +', shipping_mode TEXT'
      +', status TEXT'
      +', substatus TEXT'
      +', date_created TEXT'
      +', receiver_address TEXT'
      +', sender_address TEXT'
      +', currency_id TEXT'
      +', date_first_printed TEXT'
      +', service_id TEXT'
      +', shipping_items TEXT'
      +', receiver_id TEXT'
      +', sender_id TEXT'
      +', shipping_option TEXT'
      +', logistic_type TEXT'
      +', picking_type TEXT'
      +', cost_components TEXT'
      +', cost TEXT'
    +')');

    ExecSQL('CREATE TABLE IF NOT EXISTS sender_address ('
      +'id TEXT PRIMARY KEY'
      +', address_line TEXT'
      +', street_name TEXT'
      +', street_number TEXT'
      +', comment TEXT'
      +', zip_code TEXT'
      +', city TEXT'
      +', state TEXT'
      +', country TEXT'
      +', neighborhood TEXT'
      +', municipality TEXT'
      +', agency TEXT'
      +', types TEXT'
      +', latitude TEXT'
      +', longitude TEXT'
      +', geolocation_type TEXT'
    +')');

    ExecSQL('CREATE TABLE IF NOT EXISTS city ('
      +'id TEXT PRIMARY KEY'
      +', name TEXT'
    +')');

    ExecSQL('CREATE TABLE IF NOT EXISTS state ('
      +'id TEXT PRIMARY KEY'
      +', name TEXT'
    +')');

    ExecSQL('CREATE TABLE IF NOT EXISTS country ('
      +'id TEXT PRIMARY KEY'
      +', name TEXT'
    +')');

    ExecSQL('CREATE TABLE IF NOT EXISTS neighborhood ('
      +'id TEXT PRIMARY KEY'
      +', name TEXT'
    +')');

    ExecSQL('CREATE TABLE IF NOT EXISTS municipality ('
      +'id TEXT PRIMARY KEY'
      +', name TEXT'
    +')');

    ExecSQL('CREATE TABLE IF NOT EXISTS receiver_address ('
      +'id TEXT PRIMARY KEY'
      +', address_line TEXT'
      +', street_name TEXT'
      +', street_number TEXT'
      +', comment TEXT'
      +', zip_code TEXT'
      +', city TEXT'
      +', state TEXT'
      +', country TEXT'
      +', neighborhood TEXT'
      +', municipality TEXT'
      +', types TEXT'
      +', receiver_name TEXT'
      +', receiver_phone TEXT'
    +')');

    ExecSQL('CREATE TABLE IF NOT EXISTS shipping_option ('
      +'id TEXT PRIMARY KEY'
      +', shipping_method_id TEXT'
      +', name TEXT'
      +', currency_id TEXT'
      +', list_cost TEXT'
      +', cost TEXT'
      +', delivery_type TEXT'
      +', estimated_schedule_limit TEXT'
      +', estimated_delivery_time TEXT'
      +', estimated_delivery_limit TEXT'
      +', estimated_delivery_final TEXT'
      +', estimated_handling_limit TEXT'
    +')');

    ExecSQL('CREATE TABLE IF NOT EXISTS estimated_handling_limit ('
      +'id TEXT PRIMARY KEY'
      +', date TEXT'
    +')');

    ExecSQL('CREATE TABLE IF NOT EXISTS estimated_delivery_final ('
      +'id TEXT PRIMARY KEY'
      +', date TEXT'
      +', offset TEXT'
    +')');

    ExecSQL('CREATE TABLE IF NOT EXISTS estimated_delivery_limit ('
      +'id TEXT PRIMARY KEY'
      +',date TEXT'
      +', offset TEXT'
    +')');

    ExecSQL('CREATE TABLE IF NOT EXISTS estimated_schedule_limit ('
      +'id TEXT PRIMARY KEY'
      +',date TEXT'
    +')');

    ExecSQL('CREATE TABLE IF NOT EXISTS estimated_delivery_time ('
      +'id TEXT PRIMARY KEY'
      +', type TEXT'
      +', date TEXT'
      +', unit TEXT'
      +', offset TEXT'
      +', time_frame TEXT'
      +', pay_before TEXT'
      +', shipping TEXT'
      +', handling TEXT'
      +', schedule TEXT'
    +')');

    ExecSQL('CREATE TABLE IF NOT EXISTS offset ('
      +'id TEXT PRIMARY KEY'
      +', date TEXT'
      +', shipping TEXT'
    +')');

    ExecSQL('CREATE TABLE IF NOT EXISTS time_frame ('
      +'id TEXT PRIMARY KEY'
      +', time_frame_from TEXT'
      +', time_frame_to TEXT'
    +')');

    ExecSQL('CREATE TABLE IF NOT EXISTS cost_components ('
      +'id TEXT PRIMARY KEY'
      +', special_discount TEXT'
      +', loyal_discount TEXT'
      +', compensation TEXT'
      +', gap_discount TEXT'
      +', ratio TEXT'
    +')');

    ExecSQL('CREATE TABLE IF NOT EXISTS shipping_items ('
      +'id TEXT PRIMARY KEY'
      +', description TEXT'
      +', quantity TEXT'
      +', dimensions TEXT'
      +', dimensions_source TEXT'
    +')');

    ExecSQL('CREATE TABLE IF NOT EXISTS dimensions_source ('
      +'id TEXT PRIMARY KEY'
      +', origin TEXT'
    +')');

    ExecSQL('CREATE TABLE IF NOT EXISTS buyer ('
      +'id TEXT PRIMARY KEY'
      +', nickname TEXT'
      +', email TEXT'
      +', phone TEXT'
      +', alternative_phone TEXT'
      +', first_name TEXT'
      +', last_name TEXT'
      +', billing_info TEXT'
    +')');

    ExecSQL('CREATE TABLE IF NOT EXISTS phone ('
      +'id TEXT PRIMARY KEY'
      +', area_code TEXT'
      +', extension TEXT'
      +', number TEXT'
      +', verified TEXT'
    +')');

    ExecSQL('CREATE TABLE IF NOT EXISTS alternative_phone ('
      +'id TEXT PRIMARY KEY'
      +', area_code TEXT'
      +', extension TEXT'
      +', number TEXT'
    +')');

    ExecSQL('CREATE TABLE IF NOT EXISTS billing_info ('
      +'id TEXT PRIMARY KEY'
      +', doc_type TEXT'
      +', doc_number TEXT'
    +')');

    refreshToken := ExecSQLScalar('SELECT refresh FROM token');
    seller_id :=  ExecSQLScalar('SELECT seller_id FROM seller');
  end;

  FDQuery1.Open('SELECT embalado, orders.status AS estado, orders.buyer AS comprador'
  +', orders.id, shipping FROM orders LEFT JOIN despachados'
  +' ON orders.id = despachados.order_id ORDER BY orders.buyer');
  tOrders.Open('SELECT * FROM orders');
  tOrder_items.Open('SELECT * FROM order_items');
  tMessages.Open('SELECT * FROM messages');
  tShipping.Open('SELECT * FROM shipping');
  tBuyer.Open('SELECT * FROM buyer');
  tDespachados.Open('SELECT * FROM despachados');

  sqlOrderFrom:=' FROM orders'
    +' INNER JOIN order_items ON orders.id = order_items.order_id'
    +' INNER JOIN shipping ON orders.id = shipping.order_id'
    +' INNER JOIN buyer ON orders.buyer = buyer.id'
    +' LEFT JOIN despachados ON orders.id = despachados.order_id';

  sqlOrderWhere:=' WHERE' //' (NOT(shipping.status=''ready_to_ship'')) AND'
    +' (NOT(shipping.status=''shipped''))'
    +' AND (NOT(shipping.status=''delivered''))'
    +' AND (NOT(shipping.status=''not_delivered''))'
    +' AND (NOT(despachados.embalado=''S''))'
    ;

  sqlReady_to_ship:='(shipping.status=''ready_to_ship'')';
  sqlShipped:='(shipping.status=''shipped'')';
  sqlDelivered:='(shipping.status=''delivered'')';
  sqlNoStatus:='(shipping.status='''')';
  sqlSMMe1:=' shipping_mode=''me1''';
  sqlSMMe2:=' shipping_mode=''me2''';
  sqlSMCustom:=' shipping_mode=''custom''';
  sqlEmbalado:=' (despachados.embalado=''S'')';
  sqlNoEmbalado:=' (NOT(despachados.embalado=''S''))';

  sqlOrder_items:= 'SELECT order_items.title AS TITULO'
    +', order_items.full_unit_price AS PRECIO, order_items.quantity AS CANTIDAD'
    +', order_items.seller_sku AS SKU, buyer.first_name AS NOMBRE'
    +', buyer.last_name AS APELLIDO, buyer.nickname AS NIK, "imprimir" AS ETIQUETA'
    +', shipping, buyer, order_items.order_id'
    +sqlOrderFrom
//    +sqlOrderWhere
    ;

  sqlCountShipping:='SELECT COUNT(*)'
    +sqlOrderFrom
    +sqlOrderWhere
    ;

  sqlPrepararEnvios:=sqlOrder_items+' WHERE '+sqlReady_to_ship+' AND '+sqlNoEmbalado+' AND '+sqlSMMe2;
  sqlPrepararFlex:=sqlOrder_items+' WHERE '+sqlReady_to_ship+' AND '+sqlNoEmbalado+' AND '+sqlSMMe1;
  sqlPrepararAcordar:=sqlOrder_items+' WHERE '+sqlNoStatus+' AND '+sqlNoEmbalado+' AND '+sqlSMCustom;

  sqlDespacharColecta:=sqlOrder_items+' WHERE '+sqlReady_to_ship+' AND '+sqlEmbalado+' AND '+sqlSMMe2;
  sqlDespacharFlex:=sqlOrder_items+' WHERE '+sqlReady_to_ship+' AND '+sqlEmbalado+' AND '+sqlSMMe1;

  sqlTransitoCamino:=sqlOrder_items+' WHERE '+sqlReady_to_ship+' AND '+sqlNoEmbalado+' AND '+sqlSMCustom;

  sqlCountMessages:='SELECT COUNT(*)'
    +sqlOrderFrom
    +' INNER JOIN messages ON orders.id = messages.order_id'
    +sqlOrderWhere
    +' GROUP BY orders.id';

//    OrdenesPrueba;
end;

procedure TdmML.AgregarOrder;
begin
//  with dbMain do
//  begin
//    if ExecSQLScalar('SELECT COUNT(*) FROM orders WHERE order_id=:O',[order_id])>0 then
//    begin
//      ExecSQL('DELETE FROM orders WHERE order_id=:O',[order_id]);
//      ExecSQL('DELETE FROM order_items WHERE order_id=:O',[order_id]);
//    end;
//    ExecSQL('INSERT INTO orders (order_id,order_status,buyer_id,shipping_id) ' +
//                 'VALUES(:I,:S,:B,:H)', [order_id,order_status,buyer_id,shipping_id]);
  Agregar('orders', 'order_id,order_status,buyer_id,shipping_id',
  order_id+','+QuotedStr(order_status)+','+buyer_id+','+shipping_id,
  'order_id='+order_id );
//    ExecSQL('INSERT INTO order_items (order_id,item_id,item_title) ' +
//                 'VALUES(:I,:S,:B)', [order_id,item_id,item_title]);
//  Agregar('order_items', 'order_id,item_id,item_title',
//  order_id+','+item_id+','+item_title, 'order_id'+order_id );
//  end;
end;

procedure TdmML.AgregarOrder_items;
begin
  Agregar('order_items', 'order_id,item_id,item_title',
  order_id+','+QuotedStr(item_id)+','+QuotedStr(item_title), 'order_id='+order_id );
end;

procedure TdmML.IniciarVariables;
begin
//  order_id := '';
//  order_items_quantity := '';
//  buyer_id := '';
//  shipping_id := '';
//  order_status := '';
//  item_title := '';
//  item_id := '';
//  pack_id := '';
//  message_id := '';
//  message_text := '';
end;

procedure TdmML.ActualizarRefreshToken;
begin
  dbMain.ExecSQL('UPDATE token SET refresh = :P1', [refreshToken]);
end;

procedure TdmML.AgregarSeller;
//var
//  t, c : string;
begin
//  t:='seller';
//  c:='seller_id';
//  if seller_id<>'' then
//  begin
//    if CantidadRegistros(t,c,seller_id)>0 then
//      BorrarRegistros(t,c,seller_id);
//    InsertarRegistros(t,c,seller_id)
//  end;
  Agregar('seller', 'seller_id', seller_id, 'seller_id='+seller_id);
end;

procedure TdmML.AgregarPack;
//var
//  t, c : string;
begin
//  t:='packs';
//  c:='pack_id';
//  if pack_id<>'' then
//  begin
//    if CantidadRegistros(t,c,pack_id)>0 then
//      BorrarRegistros(t,c,pack_id);
//    InsertarRegistros(t,'order_id, pack_id',order_id+','+pack_id)
//  end;
  Agregar('packs', 'order_id, pack_id', order_id+','+pack_id, 'pack_id='+pack_id);
end;

function TdmML.CantidadRegistros;//(tabla,campo,id:string):integer;
begin
  result := dbMain.ExecSQLScalar('SELECT COUNT(*) FROM '+tabla+' WHERE '+codigo);
end;

procedure TdmML.BorrarRegistros;//(tabla,campo,id:string):integer;
begin
  dbMain.ExecSQL('DELETE FROM '+tabla+' WHERE '+codigo);
end;

procedure TdmML.InsertarRegistros;//(tabla,campo,id:string):integer;
begin
  dbMain.ExecSQL('INSERT INTO '+tabla+' ('+campos+') VALUES ('+valores+')');
end;

procedure TdmML.AgregarMessages;
begin
  Agregar('messages',
  'order_id, message_text, message_id',
  order_id+','+QuotedStr(message_text)+','+QuotedStr(message_id) ,
  'message_id='+QuotedStr(message_id));
end;

procedure TdmML.Agregar(tabla, campos, valores, codigo : string);
begin
  if valores<>'' then
  begin
    if CantidadRegistros(tabla,codigo)>0 then
      BorrarRegistros(tabla,codigo);
    InsertarRegistros(tabla,campos,valores)
  end;
end;

procedure TdmML.AgregarDespachados;
begin
  Agregar('despachados', 'order_id, embalado', order_id+','+QuotedStr(embalado),
  'order_id='+order_id);
end;

procedure TdmML.OrdenesPrueba;
begin
    with tOrders do
  begin
    Open('SELECT * FROM orders WHERE id=:I',['1']);
    if RowsAffected>0 then
      Edit
    else
    begin
      Insert;
      tOrdersid.AsString:='1';
    end;
    tOrdersshipping.AsString:='1';
    tOrdersbuyer.AsString:='1';
    tOrderstotal_amount.AsString:='999';
    Post;
  end;
  with tOrder_items do
  begin
    Open('SELECT * FROM order_items WHERE id=:I',['1']);
    if RowsAffected>0 then
      Edit
    else
    begin
      Insert;
      tOrder_itemsid.AsString:='1';
    end;
    tOrder_itemsorder_id.AsString:='1';
    tOrder_itemstitle.AsString:='Articulo Prueba 1';
    tOrder_itemsseller_sku.AsString:='1';
    tOrder_itemsfull_unit_price.AsString:='999';
    tOrder_itemsquantity.AsString:='1';
    Post;
  end;
  with tShipping do
  begin
    Open('SELECT * FROM shipping WHERE id=:I',['1']);
    if RowsAffected>0 then
      Edit
    else
    begin
      Insert;
      tShippingid.AsString:='1';
    end;
    tShippingorder_id.AsString:='1';
    tShippingstatus.AsString:='';
    tShippingshipping_mode.AsString:='me2';
    Post;
  end;
  with tMessages do
  begin
    Open('SELECT * FROM messages WHERE id=:I',['1']);
    if RowsAffected>0 then
      Edit
    else
    begin
      Insert;
      tMessagesid.AsString:='1';
    end;
    tMessagesorder_id.AsString:='1';
    tMessagestext_plain.AsString:='blablablablablablablablablablablablablablabla';
    Post;
  end;
  with tBuyer do
  begin
    Open('SELECT * FROM buyer WHERE id=:I',['1']);
    if RowsAffected>0 then
      Edit
    else
    begin
      Insert;
      tBuyerid.AsString:='1';
    end;
    tBuyerfirst_name.AsString:='Juan';
    tBuyerlast_name.AsString:='Prueba';
    tBuyernickname.AsString:='JuanPrueba1';
    Post;
  end;
  with tDespachados do
  begin
    Open('SELECT * FROM despachados WHERE order_id=:I',['1']);
    if RowsAffected>0 then
      Edit
    else
    begin
      Insert;
      tDespachadosorder_id.AsString := '1';
    end;
//    if tDespachadosembalado.AsString = '' then
      tDespachadosembalado.AsString := 'N';
//    if tDespachadosenviado.AsString = '' then
      tDespachadosenviado.AsString := 'N';
    Post;
  end;
  //#2
  with tOrders do
  begin
    Open('SELECT * FROM orders WHERE id=:I',['2']);
    if RowsAffected>0 then
      Edit
    else
    begin
      Insert;
      tOrdersid.AsString:='2';
    end;
    tOrdersshipping.AsString:='2';
    tOrdersbuyer.AsString:='1';
    tOrderstotal_amount.AsString:='999';
    Post;
  end;
  with tOrder_items do
  begin
    Open('SELECT * FROM order_items WHERE id=:I',['2']);
    if RowsAffected>0 then
      Edit
    else
    begin
      Insert;
      tOrder_itemsid.AsString:='2';
    end;
    tOrder_itemsorder_id.AsString:='2';
    tOrder_itemstitle.AsString:='Articulo Prueba 2';
    tOrder_itemsseller_sku.AsString:='2';
    tOrder_itemsfull_unit_price.AsString:='992';
    tOrder_itemsquantity.AsString:='1';
    Post;
  end;
  with tShipping do
  begin
    Open('SELECT * FROM shipping WHERE id=:I',['2']);
    if RowsAffected>0 then
      Edit
    else
    begin
      Insert;
      tShippingid.AsString:='2';
    end;
    tShippingorder_id.AsString:='2';
    tShippingstatus.AsString:='';
    tShippingshipping_mode.AsString:='custom';
    Post;
  end;
  with tMessages do
  begin
    Open('SELECT * FROM messages WHERE id=:I',['2']);
    if RowsAffected>0 then
      Edit
    else
    begin
      Insert;
      tMessagesid.AsString:='2';
    end;
    tMessagesorder_id.AsString:='2';
    tMessagestext_plain.AsString:='blebleblebleblebleblebleblebleblebleblebleble';
    Post;
  end;
  with tMessages do
  begin
    Open('SELECT * FROM messages WHERE id=:I',['3']);
    if RowsAffected>0 then
      Edit
    else
    begin
      Insert;
      tMessagesid.AsString:='3';
    end;
    tMessagesorder_id.AsString:='2';
    tMessagestext_plain.AsString:='brrbrrbrrbrrbrrbrrbrrbrrbrrbrrbrrbrrbrrbrrbrr';
    Post;
  end;
  with tDespachados do
  begin
    Open('SELECT * FROM despachados WHERE order_id=:I',['2']);
    if RowsAffected>0 then
      Edit
    else
    begin
      Insert;
      tDespachadosorder_id.AsString := '2';
    end;
//    if tDespachadosembalado.AsString = '' then
      tDespachadosembalado.AsString := 'N';
//    if tDespachadosenviado.AsString = '' then
      tDespachadosenviado.AsString := 'N';
    Post;
  end;
end;

end.
