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
//    _noGra, _pagCueIva, _pagCueOtr, _perIIBB, _perImpMun, _impInt, _otrTrib : Double;
    function GetCodigo: string;
    function GetTipo: string;
    procedure SetCodigo(const Value: string);
    procedure SetTipo(const Value: string);
  public
    constructor Create;
    destructor Destroy; override;

    procedure FindButton;
    procedure YesButton(codigo,tipo,comp,bonificar,fecha :string);
//    procedure RetPerc(noGra, pagCueIva, pagCueOtr, perIIBB, perImpMun, impInt, otrTrib);

    property Codigo: string read GetCodigo write SetCodigo;
    property Tipo: string read GetTipo write SetTipo;
//    property noGra: double read _noGra write _noGra;
//    property pagCueIva: double read _pagCueIva write _pagCueIva;
//    property pagCueOtr: double read _pagCueOtr write _pagCueOtr;
//    property perIIBB: double read _perIIBB write _perIIBB;
//    property perImpMun_: double read _perImpMun write _perImpMun;
//    property impInt: double read _impInt write _impInt;
//    property otrTrib: double read _otrTrib write _otrTrib;
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
    CancelOrderService := TCancelOrderService.Create(codigo,tipo,comp,bonificar,fecha);
    CancelOrderService.Execute;
    CancelOrderService.Free;
  end;
end;

end.
