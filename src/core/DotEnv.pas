unit DotEnv;

interface

uses  System.SysUtils, System.Types, System.UITypes, System.Classes,
      System.RegularExpressions, System.RegularExpressionsCore;

type
  TDotEnv = class
    private
    public
      dotEnvFile: TStringList;
      class var Instance : TDotEnv;
      class function getInstace: TDotEnv; static;
      function loadDotEnvFile(fileName: string = 'env'): TDotEnv;
      class function Get(key: string): string; static;
  end;

implementation

class function TDotEnv.getInstace: TDotEnv;
begin
  if Instance = nil then
      Instance := TDotEnv.Create();

  result := Instance;
end;


function TDotEnv.loadDotEnvFile(fileName: string ): TDotEnv;
begin
  self.dotEnvFile := TStringList.Create;
  self.dotEnvFile.LoadFromFile(GetCurrentDir + '/.'+ fileName);

  result := self;
end;

class function TDotEnv.Get(key: string): string;
begin
  const regex = TRegEx.Match(TDotEnv.getInstace().dotEnvFile.Text, key+'=.+').Value;
  const value = TRegEx.Split(regex, '=')[1];

  if value <> '' then
    result := value
  else
    result := '';
end;

end.
