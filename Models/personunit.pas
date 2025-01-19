unit PersonUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ModelsUnit, crc;

type
  TPerson = class(TInterfacedObject, IModel)
    // fields
    FId: longint;
    FName: string;
    FAddress: string;
    FEmail: string;
    // search indexes (when we search a name use this)
    FIX_Name: longword;
    // sort indexes (when we sort by name use this)
    FSX_Name: longint;
    procedure SetName(_name: string);
  public
    property Id: longint read FId write FId;
    property Name: string read FName write SetName;
    property Address: string read FAddress write FAddress;
    property Email: string read FEmail write FEmail;
    property IX_Name: longword read FIX_Name;
    property SX_Name: longint read FSX_Name write FSX_Name;
    function EqualsTo(a: IModel): boolean;
    class function hash(const mystring: string): longword;
  end;

implementation

procedure TPerson.SetName(_name: string);
begin
  FName := _name;
  FIX_Name := hash(_name);
end;

class function TPerson.hash(const mystring: string): longword;
var
  crcvalue: longword;
begin
  crcvalue := crc32(0, nil, 0);
  Result := crc32(crcvalue, @mystring[1], length(mystring));
end;

function TPerson.EqualsTo(a: IModel): boolean;
var
  _a: TPerson;
begin
  if (a is TPerson) then
  begin
    _a := (a as TPerson);
    Result := (_a.Id = Id) and (_a.Name = Name) and (_a.Address = Address);
  end
  else
  begin
    Result := False;
  end;
end;

end.
