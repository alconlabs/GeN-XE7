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
    +'seller_id INTEGER PRIMARY KEY'
    +')');

    if ExecSQLScalar('SELECT COUNT(refresh) FROM token')=0 then
      ExecSQL('INSERT INTO token (refresh) ' +
                   'VALUES(:N)', ['']);

//    ExecSQL('CREATE TABLE IF NOT EXISTS buyers ('
//    +'buyer_id INTEGER PRIMARY KEY'
//    +')');

    ExecSQL('CREATE TABLE IF NOT EXISTS orders ('
    +'id INTEGER PRIMARY KEY'
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
    +', total_amount REAL'
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
    +', mediations TEXT'
    +', pack_id TEXT'
    +', order_request TEXT'
    +', fulfilled TEXT'
    +', total_amount_with_shipping REAL'
    +', paid_amount REAL'
    +', coupon TEXT'
    +', taxes TEXT'
    +')');

    ExecSQL('CREATE TABLE IF NOT EXISTS coupon {'
    +'order_id INTEGER'
    +', id TEXT'
    +', amount REAL'
    +')');

    ExecSQL('CREATE TABLE IF NOT EXISTS order_request ('
    +'order_id INTEGER'
    +', return TEXT'
    +', change TEXT'
    +')');

    ExecSQL('CREATE TABLE IF NOT EXISTS feedback ('
    +'order_id INTEGER'
    +', sale TEXT'
    +', purchase TEXT'
    +')');

    ExecSQL('CREATE TABLE IF NOT EXISTS status_detail ('
    +'order_id INTEGER'
    +', code TEXT'
    +', description TEXT'
    +')');

    ExecSQL('CREATE TABLE IF NOT EXISTS order_items ('
    +'order_id INTEGER'
    +', item_id TEXT'
    +', quantity INTEGER'
    +', sale_fee REAL'
    +', listing_type_id TEXT'
    +', base_currency_id TEXT'
    +', unit_price REAL'
    +', full_unit_price REAL'
    +', base_exchange_rate TEXT'
    +', currency_id TEXT'
    +', manufacturing_days TEXT'
    +')');

    ExecSQL('CREATE TABLE IF NOT EXISTS items ('
    +'order_id INTEGER'
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
    +'order_id INTEGER'
    +', pack_id INTEGER'
    +', message_id TEXT'
    +', message_text TEXT'
    +')');

    ExecSQL('CREATE TABLE IF NOT EXISTS packs ('
    +' order_id INTEGER PRIMARY KEY'
    +', pack_id INTEGER'
    +')');

    ExecSQL('CREATE TABLE IF NOT EXISTS despachados ('
    +' order_id INTEGER PRIMARY KEY'
    +', embalado TEXT'
    +', enviado TEXT'
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
