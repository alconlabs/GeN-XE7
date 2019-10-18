unit CancelOrderViewModel;

interface

uses
  CancelOrderModel, CancelOrderService, System.Classes,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  Graphics, Controls, Vcl.Forms, Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TCancelOrderViewModel = Class
  private
    CancelOrderModel : TCancelOrderModel;
    CancelOrderService : TCancelOrderService;
    function GetCodigo: string;
    function GetTipo: string;
    procedure SetCodigo(const Value: string);
    procedure SetTipo(const Value: string);
  public
    constructor Create;
    destructor Destroy; override;

    procedure FindButton;
    procedure YesButton(codigo,tipo:string);

    property Codigo: string read GetCodigo write SetCodigo;
    property Tipo: string read GetTipo write SetTipo;
  end;

implementation

{ TCancelOrderViewModel }

uses BuscarOperacion;

constructor TCancelOrderViewModel.Create;
begin
  inherited Create;
  CancelOrderModel := TCancelOrderModel.Create;
end;

destructor TCancelOrderViewModel.Destroy;
begin
  CancelOrderModel.Free;
  inherited;
end;

procedure TCancelOrderViewModel.FindButton;
begin
  BuscarOperacionForm := TBuscarOperacionForm.Create(nil);
  with BuscarOperacionForm do
  begin
    anular := true;
    esCompra := (Self.Tipo='Compra');
    try
      ShowModal;
  //    salir := BuscarOperacionForm.salir;
  //    if salir then Exit;
    finally
      if (TipoRadioGroup.ItemIndex=0) or (TipoRadioGroup.ItemIndex=3) then
        begin
          Self.Codigo := Codigo;
  //        BitBtn1.Click;
        end
      else
        ShowMessage('Solo se pueden anular Facturas!!!');
      Free;
    end;
  end;
end;

function TCancelOrderViewModel.GetCodigo: string;
begin
   Result := CancelOrderModel.Codigo;
end;

function TCancelOrderViewModel.GetTipo: string;
begin
   Result := CancelOrderModel.Tipo;
end;

procedure TCancelOrderViewModel.SetCodigo(const Value: string);
begin
  CancelOrderModel.Codigo := Value;
end;

procedure TCancelOrderViewModel.SetTipo(const Value: string);
begin
  CancelOrderModel.Tipo := Value;
end;

procedure TCancelOrderViewModel.YesButton;
begin
  if (codigo<>'') and (tipo<>'') then
  begin
    CancelOrderService := TCancelOrderService.Create(codigo,tipo);
    CancelOrderService.Execute;
    CancelOrderService.Free;
  end;
end;

end.
