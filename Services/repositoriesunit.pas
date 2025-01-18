unit RepositoriesUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, PersonUnit, ProductUnit, CartUnit;

type

  TEntities = class(TObject)
  public
    /// Entity tables
    persons: TList;
    products: TList;
    carts: TList;
    /// Get Person by Id
    function GetPerson(PersonId: longint): TPerson; virtual;
    /// Get Product by Id
    function GetProduct(ProductId: longint): TProduct; virtual;
    /// Get Person data as readable
    function PersonToString(person: TPerson; projection: byte = 0): string; virtual;
    /// Get Person data as readable
    function ProductToString(product: TProduct; projection: byte = 0): string; virtual;
    /// clone person to another list
    function ClonePersons(): TList;
  end;


implementation

function TEntities.GetPerson(PersonId: longint): TPerson;
var
  a, b, c: integer;
  found: boolean;
begin
  a := 0;
  b := persons.Count - 1;
  found := False;
  // binary search
  while a < b do
  begin
    c := (a + b) div 2;
    if TPerson(persons[c]).Id > PersonId then
    begin
      b := c - 1;
    end
    else if TPerson(persons[c]).Id < PersonId then
    begin
      a := c + 1;
    end
    else
    begin
      a := c;
      b := c;
    end;
  end;
  if found or (TPerson(persons[a]).Id = PersonId) then
  begin
    Result := TPerson(persons[a]);
  end
  else
  begin
    Result := nil;
  end;
end;

function TEntities.GetProduct(ProductId: longint): TProduct;
var
  a, b, c: integer;
  found: boolean;
begin
  a := 0;
  b := products.Count - 1;
  found := False;
  // binary search
  while a < b do
  begin
    c := (a + b) div 2;
    if TProduct(products[c]).Id > ProductId then
    begin
      b := c - 1;
    end
    else if TProduct(products[c]).Id < ProductId then
    begin
      a := c + 1;
    end
    else
    begin
      a := c;
      b := c;
      found := True;
    end;
  end;
  if found or (TProduct(products[a]).Id = ProductId) then
  begin
    Result := TProduct(products[a]);
  end
  else
  begin
    Result := nil;
  end;
end;

function TEntities.PersonToString(person: TPerson; projection: byte = 0): string;
var
  builder: TStringBuilder;
begin
  try
    builder := TStringBuilder.Create();
    builder.Append('Person {Id: ');
    builder.Append(IntToStr(person.Id));
    if (projection = 0) or ((projection and 1) = 1) then
    begin
      builder.Append(', Name: ');
      builder.Append(person.Name);
    end;
    if (projection = 0) or ((projection and 2) = 2) then
    begin
      builder.Append(', Address: ');
      builder.Append(person.Address);
    end;
    if (projection = 0) or ((projection and 4) = 4) then
    begin
      builder.Append(', Email: ');
      builder.Append(person.Email);
    end;
    Result := builder.ToString();
  finally
    builder.Free();
  end;

end;

function TEntities.ProductToString(product: TProduct; projection: byte = 0): string;
var
  builder: TStringBuilder;
begin
  try
    builder := TStringBuilder.Create();
    builder.Append('Product {Id: ');
    builder.Append(IntToStr(product.Id));
    if (projection = 0) or ((projection and 1) = 1) then
    begin
      builder.Append(', Title: ');
      builder.Append(product.Title);
    end;
    if (projection = 0) or ((projection and 2) = 2) then
    begin
      builder.Append(', Price: ');
      builder.Append(FloatToStr(product.Price));
    end;
    if (projection = 0) or ((projection and 4) = 4) then
    begin
      builder.Append(', BarCode: ');
      builder.Append(product.BarCode);
    end;
    Result := builder.ToString();
  finally
    builder.Free();
  end;
end;

function TEntities.ClonePersons(): TList;
var
  i: integer;
begin
  Result:=TList.Create();
  for i:=0 to persons.Count-1 do
  begin
    Result.Add(TPerson(persons[i]));
  end;
end;

end.
