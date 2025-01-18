unit DbServicesUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ModelsUnit, PersonUnit, CartUnit, ProductUnit;

type
  TDbServices = class(TObject)
  private
    FCsvPath: string;
  public
    property CsvPath: string read FCsvPath write FCsvPath;
    function ReadCsvToModel(TableName: string; model: IModel): TList;
  end;

implementation

function TDbServices.ReadCsvToModel(TableName: string; model: IModel): TList;
var
  csv: TStrings;
  i: integer;
  product: TProduct;
  person: TPerson;
  cart: TCart;
  row: string;
  fieldValues: array of string;
begin
  try
    csv := TStringList.Create;
    csv.LoadFromFile(ExcludeTrailingBackslash(CsvPath) + '/' + TableName + '.csv');
    if model is TPerson then
    begin
      Result := TList.Create();
      for i := 1 to csv.Count - 1 do
      begin
        {0,name,postalZip,region,country,address,email}
        person := TPerson.Create();
        row := csv.Strings[i];
        fieldValues := row.Split(',');
        person.Id := StrToInt64(fieldValues[0]);
        person.Name := fieldValues[1];
        person.Address := fieldValues[2] + fieldValues[3] + fieldValues[4] + fieldValues[5];
        person.Email := fieldValues[6];
        Result.Add(person);
      end;
    end
    else if model is TProduct then
    begin
      Result := TList.Create();
      for i := 1 to csv.Count - 1 do
      begin
        {id,title,barcode,price}
        product := TProduct.Create();
        row := csv.Strings[i];
        fieldValues := row.Split(',');
        product.Id := StrToInt64(fieldValues[0]);
        product.Title := fieldValues[1];
        product.BarCode := fieldValues[2];
        product.Price := StrToFloat(fieldValues[3]);
        Result.Add(product);
      end;
    end
    else if model is TCart then
    begin
      Result := TList.Create();
      for i := 1 to csv.Count - 1 do
      begin
        {personId,productId}
        cart := TCart.Create();
        row := csv.Strings[i];
        fieldValues := row.Split(',');
        cart.PersonId := StrToInt64(fieldValues[0]);
        cart.ProductId := StrToInt64(fieldValues[1]);
        cart.Quantity := StrToInt(fieldValues[2]);
        Result.Add(cart);
      end;

    end;
  finally
    csv.Free();
  end;
end;

end.
