unit CommunityModel;

interface

uses connection, Ragna, System.JSON, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.ConsoleUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Phys.PG, FireDAC.Phys.PGDef, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, Horse, System.SysUtils, Dataset.serialize,
  System.Classes, System.NetEncoding, Soap.EncdDecd;

function save(communitJson: string ): TFDQuery;
function update(id: integer; communitJson: string ): TFDQuery;
function delete(id: integer ): boolean;
function findAll(page: integer; limit: integer; findName:string; findValue: string;  var tot_page: integer): TFDQuery; overload;
function findAll(): TFDQuery; overload;
function findAll(findName:string; findValue: string): TFDQuery; overload;

function findByPK(id: integer): TFDQuery;
implementation

function save(communitJson: string ): TFDQuery;
begin
  DMConnection :=  TDMConnection.Create(DMConnection);
  const Community  = DMConnection.Comunidades;

    var jsonObj := TJSONObject
    .ParseJSONValue(TEncoding.UTF8.GetBytes(communitJson), 0) as TJSONObject;

  Community.New(jsonObj).OpenUp;
  Result := Community;
end;

function findAll(findName:string; findValue: string): TFDQuery; overload;
begin
  DMConnection :=  TDMConnection.Create(DMConnection);
  const Community = DMConnection.Comunidades;

  Community
    .where(findName).Equals(findValue)
    .Order(Community.FieldByName('nome_comunidade'))
    .OpenUp;

  Result := Community;
end;

function findAll(): TFDQuery; overload;
begin
  DMConnection :=  TDMConnection.Create(DMConnection);
  const Community = DMConnection.Comunidades;

  Community
    .Order(Community.FieldByName('nome_comunidade'))
    .OpenUp;

  Result := Community;
end;

function update(id: integer; communitJson: string ): TFDQuery;
begin
  DMConnection :=  TDMConnection.Create(DMConnection);
  const Community  = DMConnection.Comunidades;

  var jsonObj := TJSONObject
    .ParseJSONValue(TEncoding.UTF8.GetBytes(communitJson), 0) as TJSONObject;

  Community.where('id').Equals(id).OpenUp;
  Community.MergeFromJSONObject(jsonObj);
  Result := Community;
end;

function delete(id: integer ): boolean;
begin
  DMConnection :=  TDMConnection.Create(DMConnection);
  const Community = DMConnection.comunidades;
  try
    Community.Remove(Community.FieldByName('id'), id).OpenUp;
    result:= true;
  except
    on E:Exception do
      result:= false;
  end;
end;

function findAll(page: integer; limit: integer; findName:string; findValue: string;  var tot_page: integer): TFDQuery; overload;
begin
  DMConnection :=  TDMConnection.Create(DMConnection);
  const Community = DMConnection.Comunidades_Regiao;


  Community.Close;
  Community.SQL.Clear;
  Community.SQL.Add('select ');
  Community.SQL.Add('c.*,');
  Community.SQL.Add('r.nome_regiao');
  Community.SQL.Add('from ');
  Community.SQL.Add('comunidades c inner join');
  Community.SQL.Add('regioes_atendimento r on');
  Community.SQL.Add('r.id = c.id_regiao');

  var filtered := false;
  var tot := false;

  if ((findName <> '') and (findValue <> '')) then
    begin
      Community.SQL.Add(' where ');
      Community.SQL.Add( findName +' like ' + QuotedStr('%' + findValue + '%'));
      Community.Open;

      filtered := true;

      tot :=  Trunc((Community.RowsAffected/limit)) < (Community.RowsAffected/limit);

      if tot then
        tot_page := Trunc(Community.RowsAffected/limit) + 1
      else
        tot_page := Trunc(Community.RowsAffected/limit);

      Community.close;
    end;

  if not filtered then
    begin
      tot :=  Trunc((Community.OpenUp.RowsAffected/limit)) < (Community.OpenUp.RowsAffected/limit);

      if tot then
        tot_page := Trunc(Community.OpenUp.RowsAffected/limit) + 1
      else
        tot_page := Trunc(Community.OpenUp.RowsAffected/limit);
    end;

  var initial := page - 1;
  initial := initial * limit;

  Community.SQL.Add('ORDER BY ');
  Community.SQL.Add('c.id OFFSET :offset ROWS FETCH NEXT :limit ROWS ONLY;');

  Community.ParamByName('offset').AsInteger := initial;
  Community.ParamByName('limit').AsInteger := limit;

  Community.Open;
  Result := Community;
end;

function findByPK(id: integer): TFDQuery;
begin
  DMConnection :=  TDMConnection.Create(DMConnection);
  const Community  = DMConnection.Comunidades;
  Community.where('id').equals(id).openUp;
  result := Community;
end;

end.
