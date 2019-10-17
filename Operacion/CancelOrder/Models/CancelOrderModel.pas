unit CancelOrderModel;

interface

uses
  System.SysUtils;

type
  TCancelOrderModel = Class
  private
    c,t: string;
    function GetCodigo: string;
    procedure SetCodigo(const Value: string);
    function GetTipo: string;
    procedure SetTipo(const Value: string);
  public
    constructor Create;
    destructor Destroy; override;

    property Codigo: string read GetCodigo write SetCodigo;
    property Tipo: string read GetTipo write SetTipo;
  end;

implementation

{ TCancelOrderModel }

constructor TCancelOrderModel.Create;
begin
  inherited Create;
  c := '';
  t := '';
end;

destructor TCancelOrderModel.Destroy;
begin
  inherited;
end;

function TCancelOrderModel.GetCodigo: string;
begin
  Result := c;
end;

function TCancelOrderModel.GetTipo: string;
begin
  Result := t;
end;

procedure TCancelOrderModel.SetCodigo(const Value: string);
begin
  c := Value;
end;

procedure TCancelOrderModel.SetTipo(const Value: string);
begin
  t := Value;
end;

end.
