unit ProducerModel;

interface

uses connection, Ragna, System.JSON, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.ConsoleUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Phys.PG, FireDAC.Phys.PGDef, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, Horse, System.SysUtils, Dataset.serialize,
  System.Classes, System.NetEncoding, Soap.EncdDecd;

function findByPK(id: integer): TFDQuery;
function findByUser(id: integer): TFDQuery;

function findAll(
          page: integer; limit: integer;
          produtor: string; cpf: string; regiao: string;
          comunidade: string; instituicao: string;
          var tot_page: integer): TFDQuery; overload;

function findAll(
          produtor: string; cpf: string; regiao: string;
          comunidade: string; instituicao: string;
          var tot_page: integer): TFDQuery; overload;

function saveProducer(producerJson: string): TFDQuery;

function findAvatar(id: integer): TMemoryStream;
implementation

uses UsuariosModel;

function saveProducer(producerJson: string): TFDQuery;
begin
  DMConnection :=  TDMConnection.Create(DMConnection);
  const Produtores = DMConnection.Produtores;

  var jsonObj := TJSONObject
    .ParseJSONValue(TEncoding.UTF8.GetBytes(producerJson), 0) as TJSONObject;

  Produtores.New(jsonObj).OpenUp;

  Result := Produtores;
end;

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

function findAll(
          page: integer; limit: integer;
          produtor: string; cpf: string; regiao: string;
          comunidade: string; instituicao: string;
          var tot_page: integer): TFDQuery;
begin
  DMConnection :=  TDMConnection.Create(DMConnection);
  const Produtores = DMConnection.Produtores_all;

  Produtores.close;
  Produtores.sql.clear;

  Produtores.sql.add('select ');
  Produtores.sql.add('  u.id,');
  Produtores.sql.add('  u.nome_usuario,');
  Produtores.sql.add('  u.CPF,');
  Produtores.sql.add('  p.id id_produtor,');
  Produtores.sql.add('  c.nome_comunidade,');
  Produtores.sql.add('  re.nome_regiao,');
  Produtores.sql.add('  i.nome_instituicao,');
  Produtores.sql.add('  p.residencia_gps_x,');
  Produtores.sql.add('  p.residencia_gps_y');
  Produtores.sql.add('from usuarios u inner join ');
  Produtores.sql.add('  produtores p on');
  Produtores.sql.add('  p.id_usuario = u.id inner join ');
  Produtores.sql.add('  comunidades c on');
  Produtores.sql.add('  c.id = p.id_comunidade inner join');
  Produtores.sql.add('  regioes_atendimento re on');
  Produtores.sql.add('  re.id = c.id_regiao inner join');
  Produtores.sql.add('  instituicoes i on');
  Produtores.sql.add('  i.id = re.id_instituicao');
  Produtores.sql.add('where ');
  Produtores.sql.add('  u.produtor = '+QuotedStr('S'));

  if produtor <> '' then
    Produtores.sql.add(' and u.nome_usuario LIKE '+ QuotedStr('%'+produtor+'%'));

  if cpf <> '' then
    Produtores.sql.add(' and u.cpf LIKE '+ QuotedStr('%'+cpf+'%'));

  if regiao <> '' then
    Produtores.sql.add(' and re.id = '+ regiao);

  if comunidade <> '' then
    Produtores.sql.add(' and c.id = '+ comunidade );

  if instituicao <> '' then
    Produtores.sql.add(' and i.id = '+ instituicao );

  Produtores.open;

  var tot :=  Trunc((Produtores.RowsAffected/limit)) < (Produtores.RowsAffected/limit);

  if tot then
    tot_page := Trunc(Produtores.RowsAffected/limit) + 1
  else
    tot_page := Trunc(Produtores.RowsAffected/limit);

  produtores.close;

  var initial := page - 1;
  initial := initial * limit;

  Produtores.SQL.Add('ORDER BY ');
  Produtores.SQL.Add('u.id OFFSET :offset ROWS FETCH NEXT :limit ROWS ONLY;');

  Produtores.ParamByName('offset').AsInteger := initial;
  Produtores.ParamByName('limit').AsInteger := limit;

  Produtores.Open;
  Result := Produtores;
end;


function findAll(
          produtor: string; cpf: string; regiao: string;
          comunidade: string; instituicao: string;
          var tot_page: integer): TFDQuery;
begin
  DMConnection :=  TDMConnection.Create(DMConnection);
  const Produtores = DMConnection.Produtores_all;

  Produtores.close;
  Produtores.sql.clear;

  Produtores.sql.add('select ');
  Produtores.sql.add('  u.id,');
  Produtores.sql.add('  u.nome_usuario,');
  Produtores.sql.add('  u.CPF,');
  Produtores.sql.add('  p.id id_produtor,');
  Produtores.sql.add('  c.nome_comunidade,');
  Produtores.sql.add('  re.nome_regiao,');
  Produtores.sql.add('  i.nome_instituicao,');
  Produtores.sql.add('  p.residencia_gps_x,');
  Produtores.sql.add('  p.residencia_gps_y');
  Produtores.sql.add('from usuarios u inner join ');
  Produtores.sql.add('  produtores p on');
  Produtores.sql.add('  p.id_usuario = u.id inner join ');
  Produtores.sql.add('  comunidades c on');
  Produtores.sql.add('  c.id = p.id_comunidade inner join');
  Produtores.sql.add('  regioes_atendimento re on');
  Produtores.sql.add('  re.id = c.id_regiao inner join');
  Produtores.sql.add('  instituicoes i on');
  Produtores.sql.add('  i.id = re.id_instituicao');
  Produtores.sql.add('where ');
  Produtores.sql.add('  u.produtor = '+QuotedStr('S'));

  if produtor <> '' then
    Produtores.sql.add(' and u.nome_usuario LIKE '+ QuotedStr('%'+produtor+'%'));

  if cpf <> '' then
    Produtores.sql.add(' and u.cpf LIKE '+ QuotedStr('%'+cpf+'%'));

  if regiao <> '' then
    Produtores.sql.add(' and re.id = '+ regiao);

  if comunidade <> '' then
    Produtores.sql.add(' and c.id = '+ comunidade );

  if instituicao <> '' then
    Produtores.sql.add(' and i.id = '+ instituicao );

  Produtores.Open;
  Result := Produtores;
end;

function findByPK(id: integer): TFDQuery;
begin
  DMConnection :=  TDMConnection.Create(DMConnection);
  const Produtores = DMConnection.Produtores;

  Produtores.Where('id').Equals(id).OpenUp;

  Result := Produtores;
end;

function findByUser(id: integer): TFDQuery;
begin
  DMConnection :=  TDMConnection.Create(DMConnection);
  const Produtores = DMConnection.Produtores;

  Produtores.Where('id_usuario').Equals(id).OpenUp;

  Result := Produtores;
end;

end.
