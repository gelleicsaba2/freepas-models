unit ProductUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ModelsUnit;

type
  TProduct = class(TInterfacedObject, IModel)
    FId: longint;
    FTitle: string;
    FBarCode: string;
    FPrice: double;
  public
    property Id: longint read FId write FId;
    property Title: string read FTitle write FTitle;
    property BarCode: string read FBarCode write FBarCode;
    property Price: double read FPrice write FPrice;
    function EqualsTo(a: IModel): boolean;
  end;

implementation

function TProduct.EqualsTo(a: IModel): boolean;
var
  _a: TProduct;
begin
  if (a is TProduct) then
  begin
    _a := (a as TProduct);
    Result := (_a.Id = Id) and (_a.Title = Title) and
      (_a.BarCode = BarCode) and (_a.Price = Price);
  end
  else
  begin
    Result := False;
  end;
end;

end.
