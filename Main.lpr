program Main;
{$mode ObjFPC}{$H+}

uses
  Classes,
  SysUtils,
  StrUtils,
  DbServicesUnit,
  ModelsUnit,
  PersonUnit,
  CartUnit,
  ProductUnit,
  RepositoriesUnit;

function ComparePersonNames(a, b : Pointer) : integer;
begin
  Result := CompareStr(TPerson(a).Name, TPerson(b).Name);
end;

var
  DbServices: TDbServices;
  Entities: TEntities;
  person: TPerson;
  product: TProduct;
  cart: TCart;
  i: integer;
  search: String;
  index: longword;
  personClone: TList;
begin
  try
    DbServices := TDbServices.Create();
    Entities := TEntities.Create();
    DbServices.CsvPath := ExtractFilePath(ParamStr(0)) + 'DB';

    // Read entities
    person := TPerson.Create;
    product := TProduct.Create();
    cart := TCart.Create();
    // Attach persons table to repository
    Entities.persons := DbServices.ReadCsvToModel('Persons', person);
    // Attach products table to repository
    Entities.products := DbServices.ReadCsvToModel('Products', product);
    // Attach carts table to repository
    Entities.carts := DbServices.ReadCsvToModel('Carts', cart);

    WriteLn('==============================================');
    WriteLn('Finding by id:');
    // Test finding by id (persons)
    WriteLn(Entities.PersonToString(Entities.GetPerson(3)));
    WriteLn(Entities.PersonToString(Entities.GetPerson(1)));
    WriteLn(Entities.PersonToString(Entities.GetPerson(5)));
    // Test finding by id (products)
    WriteLn(Entities.ProductToString(Entities.GetProduct(2)));

    WriteLn('==============================================');
    WriteLn('Carts:');

    for i := 0 to Entities.carts.Count - 1 do
    begin
      WriteLn(
        Entities.PersonToString(Entities.GetPerson(TCart(Entities.carts[i]).PersonId),
        1) + ' --> ' + Entities.ProductToString(Entities.GetProduct(
        TCart(Entities.carts[i]).ProductId), 3) + ' , Quantity: ' +
        IntToStr(TCart(Entities.carts[i]).Quantity)
        );
    end;

    WriteLn('==============================================');
    WriteLn('Quick search by index:');
    search:='Clarke Oliver';
    index := TPerson.hash(search);
    for i := 0 to Entities.persons.Count - 1 do
    begin
      if (TPerson(Entities.persons[i]).IX_Name = index) and (TPerson(Entities.persons[i]).Name=search) then
      begin
        WriteLn(Entities.PersonToString(TPerson(Entities.persons[i])));
        Break;
      end;
    end;

    WriteLn('==============================================');
    WriteLn('Sort by name');
    WriteLn();

    personClone:=Entities.ClonePersons();
    personClone.Sort(@ComparePersonNames);
    for i:=0 to personClone.Count-1 do
    begin
      WriteLn(TPerson(personClone[i]).Name+' (Id: ' + IntToStr(TPerson(personClone[i]).Id)+')');
    end;

  finally
    DbServices.Free();
    Entities.Free();
  end;
end.
