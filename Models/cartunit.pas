unit CartUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, PersonUnit, ProductUnit, ModelsUnit;

type
  TCart = class(TInterfacedObject, IModel)
    FPersonId: longint;
    FProductId: longint;
    FQuantity: integer;
  public
    property PersonId: longint read FPersonId write FPersonId;
    property ProductId: longint read FProductId write FProductId;
    property Quantity: integer read FQuantity write FQuantity;
    function EqualsTo(a: IModel): boolean;
  end;

implementation

function TCart.EqualsTo(a: IModel): boolean;
var
  _a: TCart;
begin
  if (a is TCart) then
  begin
    Result := _a = self;
  end
  else
  begin
    Result := False;
  end;
end;

end.
