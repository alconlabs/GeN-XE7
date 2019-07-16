unit udmMercadoLibre;

interface

uses FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs, FireDAC.FMXUI.Wait, System.Classes, Data.DB,
  FireDAC.Comp.Client, System.IOUtils, System.SysUtils, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TdmML = class(TDataModule)
    dbMain: TFDConnection;
    tOrders: TFDQuery;
    tOrder_items: TFDQuery;
    tMessages: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    dBname, path : string;
    procedure IniciarVariables;
  public
    { Public declarations }
    refreshToken, seller_id
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
      +'order_id TEXT'
      +', id TEXT'
      +', amount TEXT'
    +')');

    ExecSQL('CREATE TABLE IF NOT EXISTS order_request ('
      +'order_id TEXT'
      +', return TEXT'
      +', change TEXT'
    +')');

    ExecSQL('CREATE TABLE IF NOT EXISTS feedback ('
      +'order_id TEXT'
      +', sale TEXT'
      +', purchase TEXT'
    +')');

    ExecSQL('CREATE TABLE IF NOT EXISTS status_detail ('
      +'order_id TEXT'
      +', code TEXT'
      +', description TEXT'
    +')');

    ExecSQL('CREATE TABLE IF NOT EXISTS order_items ('
      +'order_id TEXT'
      +', item_id TEXT'
      +', quantity TEXT'
      +', sale_fee TEXT'
      +', listing_type_id TEXT'
      +', base_currency_id TEXT'
      +', unit_price TEXT'
      +', full_unit_price TEXT'
      +', base_exchange_rate TEXT'
      +', currency_id TEXT'
      +', manufacturing_days TEXT'
    +')');

    ExecSQL('CREATE TABLE IF NOT EXISTS items ('
      +'order_id TEXT'
      +', id TEXT'
      +', title TEXT'
      +', category_id TEXT'
      +', variation_id TEXT'
      +', seller_custom_field TEXT'
      +', warranty TEXT'
      +', condition TEXT'
      +', seller_sku TEXT'
    +')');

    ExecSQL('CREATE TABLE IF NOT EXISTS messages ('
      +'order_id TEXT'
      +', pack_id TEXT'
      +', message_id TEXT'
      +', message_text TEXT'
    +')');

    ExecSQL('CREATE TABLE IF NOT EXISTS packs ('
      +' order_id TEXT PRIMARY KEY'
      +', pack_id TEXT'
    +')');

    ExecSQL('CREATE TABLE IF NOT EXISTS despachados ('
      +'order_id TEXT PRIMARY KEY'
      +', embalado TEXT'
      +', enviado TEXT'
    +')');

    ExecSQL('CREATE TABLE IF NOT EXISTS payments ('
      +' id TEXT'
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
      +'payments_id TEXT'
      +', company_id TEXT'
      +', transaction_id TEXT'
    +')');

    ExecSQL('CREATE TABLE IF NOT EXISTS available_actions ('
      +'payments_id TEXT'
      +', refund TEXT'
    +')');

    ExecSQL('CREATE TABLE IF NOT EXISTS collector ('
      +'payments_id TEXT'
      +', id TEXT'
    +')');

    ExecSQL('CREATE TABLE IF NOT EXISTS shipping ('
      +'order_id TEXT'
      +', id TEXT'
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
      +'id TEXT'
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
      +'id TEXT'
      +', name TEXT'
    +')');

    ExecSQL('CREATE TABLE IF NOT EXISTS state ('
      +'id TEXT'
      +', name TEXT'
    +')');

    ExecSQL('CREATE TABLE IF NOT EXISTS country ('
      +'id TEXT'
      +', name TEXT'
    +')');

    ExecSQL('CREATE TABLE IF NOT EXISTS neighborhood ('
      +'id TEXT'
      +', name TEXT'
    +')');

    ExecSQL('CREATE TABLE IF NOT EXISTS municipality ('
      +'id TEXT'
      +', name TEXT'
    +')');

    ExecSQL('CREATE TABLE IF NOT EXISTS receiver_address ('
      +'id TEXT'
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
      +'id TEXT'
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
      +'date TEXT'
    +')');

    ExecSQL('CREATE TABLE IF NOT EXISTS estimated_delivery_final ('
      +'date TEXT'
      +', offset TEXT'
    +')');

    ExecSQL('CREATE TABLE IF NOT EXISTS estimated_delivery_limit ('
      +'date TEXT'
      +', offset TEXT'
    +')');

    ExecSQL('CREATE TABLE IF NOT EXISTS estimated_schedule_limit ('
      +'date TEXT'
    +')');

    ExecSQL('CREATE TABLE IF NOT EXISTS estimated_delivery_time ('
      +'type TEXT'
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
      +'date TEXT'
      +', shipping TEXT'
    +')');

    ExecSQL('CREATE TABLE IF NOT EXISTS time_frame ('
      +'time_frame_from TEXT'
      +', time_frame_to TEXT'
    +')');

    ExecSQL('CREATE TABLE IF NOT EXISTS cost_components ('
      +'special_discount TEXT'
      +', loyal_discount TEXT'
      +', compensation TEXT'
      +', gap_discount TEXT'
      +', ratio TEXT'
    +')');

    ExecSQL('CREATE TABLE IF NOT EXISTS shipping_items ('
      +'id TEXT'
      +', description TEXT'
      +', quantity TEXT'
      +', dimensions TEXT'
      +', dimensions_source TEXT'
    +')');

    ExecSQL('CREATE TABLE IF NOT EXISTS dimensions_source ('
      +'id TEXT'
      +', origin TEXT'
    +')');

    ExecSQL('CREATE TABLE IF NOT EXISTS buyer ('
      +'id TEXT'
      +', nickname TEXT'
      +', email TEXT'
      +', phone TEXT'
      +', alternative_phone TEXT'
      +', first_name TEXT'
      +', last_name TEXT'
      +', billing_info TEXT'
    +')');

    ExecSQL('CREATE TABLE IF NOT EXISTS phone ('
      +'area_code TEXT'
      +', extension TEXT'
      +', number TEXT'
      +', verified TEXT'
    +')');

    ExecSQL('CREATE TABLE IF NOT EXISTS alternative_phone ('
      +'area_code TEXT'
      +', extension TEXT'
      +', number TEXT'
    +')');

    ExecSQL('CREATE TABLE IF NOT EXISTS billing_info ('
      +'doc_type TEXT'
      +', doc_number TEXT'
    +')');

    refreshToken := ExecSQLScalar('SELECT refresh FROM token');
    seller_id :=  ExecSQLScalar('SELECT seller_id FROM seller');
  end;
  tOrders.Open('SELECT embalado, order_status AS estado, buyer_id AS comprador, orders.order_id, shipping_id FROM orders LEFT JOIN despachados ON orders.order_id = despachados.order_id ORDER BY buyer_id');
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

end.
