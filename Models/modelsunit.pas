unit ModelsUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

type
  IModel = interface
    function EqualsTo(a: IModel): boolean;
  end;

implementation

end.
