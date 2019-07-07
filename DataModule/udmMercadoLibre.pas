unit udmMercadoLibre;

interface

uses FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs, FireDAC.FMXUI.Wait, System.Classes, Data.DB,
  FireDAC.Comp.Client, System.IOUtils, System.SysUtils;

type
  TdmML = class(TDataModule)
    dbMain: TFDConnection;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    dBname, path : string;
    procedure IniciarVariables;
  public
    { Public declarations }
    order_id, order_items_quantity, buyer_id, shipping_id : Integer;
    order_status, item_title, item_id : string;
    refreshToken : string;
    procedure AgregarOrder;
    procedure ActualizarRefreshToken;
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

    if ExecSQLScalar('SELECT COUNT(refresh) FROM token')=0 then
      ExecSQL('INSERT INTO token (refresh) ' +
                   'VALUES(:N)', ['']);

//    ExecSQL('CREATE TABLE IF NOT EXISTS buyers ('
//    +'buyer_id INTEGER PRIMARY KEY'
//    +')');

    ExecSQL('CREATE TABLE IF NOT EXISTS orders ('
    +'order_id INTEGER PRIMARY KEY'
    +', order_status TEXT'
    +', buyer_id INTEGER'
    +', shipping_id TEXT'
    +')');

    ExecSQL('CREATE TABLE IF NOT EXISTS order_items ('
    +'order_id INTEGER'
    +', item_id TEXT'
    +', item_title TEXT'
    +')');

    ExecSQL('CREATE TABLE IF NOT EXISTS messages ('
//    +'message_id INTEGER PRIMARY KEY'
    +' pack_id INTEGER'
    +', order_id INTEGER'
    +', txt TEXT'
    +')');

    ExecSQL('CREATE TABLE IF NOT EXISTS packs ('
    +'id INTEGER PRIMARY KEY'
    +', order_id INTEGER'
    +')');

    refreshToken := ExecSQLScalar('SELECT refresh FROM token');
  end;
end;

procedure TdmML.AgregarOrder;
begin
  with dbMain do
  begin
    if ExecSQLScalar('SELECT COUNT(*) FROM orders WHERE order_id=:O',[order_id])>0 then
    begin
      ExecSQL('DELETE FROM orders WHERE order_id=:O',[order_id]);
      ExecSQL('DELETE FROM order_items WHERE order_id=:O',[order_id]);
    end;
    ExecSQL('INSERT INTO orders (order_id,order_status,buyer_id,shipping_id) ' +
                 'VALUES(:I,:S,:B,:H)', [order_id,order_status,buyer_id,shipping_id]);
    ExecSQL('INSERT INTO order_items (order_id,item_id,item_title) ' +
                 'VALUES(:I,:S,:B)', [order_id,item_id,item_title]);
  end;
end;

procedure TdmML.IniciarVariables;
begin
  order_id := 0;
  order_items_quantity := 0;
  buyer_id := 0;
  shipping_id := 0;
  order_status := '';
  item_title := '';
  item_id := '';
end;

procedure TdmML.ActualizarRefreshToken;
begin
  dbMain.ExecSQL('UPDATE token SET refresh = :P1', [refreshToken]);
end;

end.
