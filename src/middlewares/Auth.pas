unit Auth;

interface

uses Horse, System.sysutils, Horse.JWT,
     JOSE.Core.JWT, JOSE.Core.Builder,
     System.RegularExpressions;

function Authorization: THorseCallback;

implementation

function Authorization: THorseCallback;
begin
  Result := HorseJWT('@@@##BEMDIVERSO!@!#@!');
end;

end.
