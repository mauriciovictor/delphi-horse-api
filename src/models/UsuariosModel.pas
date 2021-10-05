unit UsuariosModel;

interface


uses connection, Ragna, System.JSON, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.ConsoleUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Phys.PG, FireDAC.Phys.PGDef, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, Horse, System.SysUtils, Dataset.serialize,
  System.Classes, System.NetEncoding, Soap.EncdDecd;

Function findByCPF(CPF: string): TFDQuery;
Function save(userJson: String): TFDQuery;
function UpdateAvatar(id: integer; base64: string): string;
function findById(id: integer): TFDQuery;
function findUserImage(id: integer): string;
function saveAdministrator(adminJson: String): TFDQuery;
procedure saveFoto(base64: string; id:integer);

function login(CPF: string; senha:string): TFDQuery;

implementation

procedure saveFoto(base64: string; id:integer);
var
  Buf: TBytes;
begin
  DMConnection :=  TDMConnection.Create(DMConnection);
  var ProductionArea := DMConnection.Areas_Producao;

  const ss = TStringStream.Create(base64);
  const ms = TMemoryStream.Create;
  DecodeStream (ss, ms);

  ms.Position := 0;
  SetLength(Buf, ms.Size);
  ms.ReadBuffer(Buf, ms.Size);

  ProductionArea.close;
  ProductionArea.SQL.Clear;
  ProductionArea.SQL.Add('update usuarios set avatar=:foto where ');
  ProductionArea.SQL.Add('id =:id');
  ProductionArea.ParamByName('id').AsInteger := id;
  ProductionArea.ParamByName('foto').LoadFromStream(ms, ftBlob);

  ProductionArea.ExecSQL;
end;

Function findByCPF(CPF: string): TFDQuery;
begin
  DMConnection :=  TDMConnection.Create(DMConnection);
  var Usuarios   := DMConnection.Usuarios;
  Usuarios.where('CPF').Equals(CPF).openup();
  Result := Usuarios;
end;

function login(CPF: string; senha:string): TFDQuery;
begin
  DMConnection :=  TDMConnection.Create(DMConnection);
  var Usuarios   := DMConnection.Usuarios;

  Usuarios
    .where('CPF').Equals(CPF)
    .&And('senha').Equals(senha)
  .openup();

  Result := Usuarios;
end;

function saveAdministrator(adminJson: String): TFDQuery;
begin
  DMConnection :=  TDMConnection.Create(DMConnection);

  const Usuarios  = DMConnection.Usuarios;

    var jsonObj := TJSONObject
    .ParseJSONValue(TEncoding.UTF8.GetBytes(adminJson), 0) as TJSONObject;

  Usuarios.New(jsonObj).OpenUp;
  Result := Usuarios;
end;

Function save(userJson: String): TFDQuery;
begin
  DMConnection :=  TDMConnection.Create(DMConnection);

  const Usuarios  = DMConnection.Usuarios;
  const Produtores = DMConnection.Produtores;
  var jsonObj := TJSONObject
    .ParseJSONValue(TEncoding.UTF8.GetBytes(userJson), 0) as TJSONObject;

  const base64 = jsonObj.GetValue('foto').value;
  jsonObj.RemovePair('foto');

  Usuarios.New(jsonObj).OpenUp;

  const user_id = Usuarios.FieldByName('id').AsInteger;
  saveFoto(base64, user_id);

  Result := Usuarios;
end;

function findById(id: integer): TFDQuery;
begin
  DMConnection :=  TDMConnection.Create(DMConnection);
  const Usuarios = DMConnection.Usuarios;

  Usuarios.Where('id').Equals(id).OpenUp;

  Result := Usuarios;
end;

function findUserImage(id: integer): string;
begin
  const usuario = findById(id);

  const img = Usuario.CreateBlobStream(
    usuario.FieldByName('avatar'),
    bmRead
  );

  const memoryStream = TMemoryStream.Create;
  memoryStream.LoadFromStream(img);

  const imageBase64 = EncodeBase64(
    memoryStream.Memory,
    memoryStream.Size
  );

  result := imageBase64;
end;

function UpdateAvatar(id: integer; base64: string): string;
var
  Buf: TBytes;
begin
  DMConnection :=  TDMConnection.Create(DMConnection);
  const Usuarios = DMConnection.Usuarios;

  const ss = TStringStream.Create(Base64);
  const ms = TMemoryStream.Create;
  DecodeStream (ss, ms);

  ms.Position := 0;
  SetLength(Buf, ms.Size);
  ms.ReadBuffer(Buf, ms.Size);

  Usuarios.close;
  Usuarios.SQL.Clear;
  Usuarios.SQL.Add('update usuarios set avatar=:ava where ');
  Usuarios.SQL.Add('id =:id');
  usuarios.ParamByName('id').AsInteger := id;
  Usuarios.ParamByName('ava').LoadFromStream(ms, ftBlob);
  Usuarios.ExecSQL;

end;

end.
