unit AdminModel;

interface


uses
  connection, Ragna, System.JSON, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.ConsoleUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Phys.PG, FireDAC.Phys.PGDef, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet, Horse,
  System.SysUtils, Dataset.serialize, System.Classes, System.NetEncoding,
  Soap.EncdDecd, System.IOUtils;

function delete(id: integer ): boolean;
function findAll(page: integer; limit: integer; findName:string; findValue: string;  var tot_page: integer): TFDQuery; overload;
function findAvatar(id: integer): TMemoryStream;
function findByPK(id:integer): TFDQuery;
function update(adminJson: string; id: integer): TFDQuery;

implementation

uses UsuariosModel;

function findAvatar(id: integer): TMemoryStream;
begin
  const usuario = findById(id);

  const img = Usuario.CreateBlobStream(
    usuario.FieldByName('avatar'),
    bmRead
  );

  const fileStream = TMemoryStream.Create;
  fileStream.LoadFromStream(img);

  result := fileStream;
end;

function findByPK(id:integer): TFDQuery;
begin
  DMConnection :=  TDMConnection.Create(DMConnection);
  const Usuarios = DMConnection.Usuarios;

  Usuarios.where('id').equals(id).openup;

  result := Usuarios;
end;

function update(adminJson: string; id: integer): TFDQuery;
begin
  DMConnection :=  TDMConnection.Create(DMConnection);
  const admin  = DMConnection.Usuarios;

  var jsonObj := TJSONObject
    .ParseJSONValue(TEncoding.UTF8.GetBytes(adminJson), 0) as TJSONObject;

  admin.where('id').Equals(id).OpenUp;
  admin.MergeFromJSONObject(jsonObj);
  Result := admin;
end;

function findAll(page: integer; limit: integer; findName:string; findValue: string;  var tot_page: integer): TFDQuery; overload;
begin
 DMConnection :=  TDMConnection.Create(DMConnection);
 const Usuarios = DMConnection.Usuarios;

  Usuarios.Close;
  Usuarios.SQL.Clear;
  Usuarios.SQL.Add('select * from usuarios');
  Usuarios.SQL.Add(' where ');
  Usuarios.SQL.Add(' administrador = ' + QuotedStr('S'));

  var filtered := false;
  var tot := false;

  if ((findName <> '') and (findValue <> '')) then
    begin
      Usuarios.SQL.Add(' and ');
      Usuarios.SQL.Add( findName +' like ' + QuotedStr('%' + findValue + '%'));
      Usuarios.Open;

      filtered := true;

      tot :=  Trunc((Usuarios.RowsAffected/limit)) < (Usuarios.RowsAffected/limit);

      if tot then
        tot_page := Trunc(Usuarios.RowsAffected/limit) + 1
      else
        tot_page := Trunc(Usuarios.RowsAffected/limit);

      Usuarios.close;
    end;

  if not filtered then
    begin
      tot :=  Trunc((Usuarios.OpenUp.RowsAffected/limit)) < (Usuarios.OpenUp.RowsAffected/limit);

      if tot then
        tot_page := Trunc(Usuarios.OpenUp.RowsAffected/limit) + 1
      else
        tot_page := Trunc(Usuarios.OpenUp.RowsAffected/limit);
    end;

  var initial := page - 1;
  initial := initial * limit;

  Usuarios.SQL.Add('ORDER BY ');
  Usuarios.SQL.Add('id OFFSET :offset ROWS FETCH NEXT :limit ROWS ONLY;');

  Usuarios.ParamByName('offset').AsInteger := initial;
  Usuarios.ParamByName('limit').AsInteger := limit;

  Usuarios.Open;
  Result := Usuarios;
end;

function delete(id: integer ): boolean;
begin
  DMConnection :=  TDMConnection.Create(DMConnection);
  const Usuarios  = DMConnection.Usuarios;
  try
    Usuarios.Remove(Usuarios.FieldByName('id'), id).OpenUp;
    result:= true;
  except
    on E:Exception do
      result:= false;
  end;
end;

end.
