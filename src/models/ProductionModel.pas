unit ProductionModel;

interface
uses connection, Ragna, System.JSON, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.ConsoleUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Phys.PG, FireDAC.Phys.PGDef, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, Horse, System.SysUtils, Dataset.serialize,
  System.Classes, System.NetEncoding, Soap.EncdDecd;

Function save(productionJson: String): TFDQuery;
Function findByProducerArea(id: integer): TFDQuery;
function findByPk(id: integer): TFDQuery;
function update(id: integer; productionJson: string ): TFDQuery;
function delete(id: integer ): boolean;
function findAll(
          page: integer; limit: integer;
          id_produtor: integer;
          tp_prod: string; area: string; data_inicio: string;
          data_fim: string; var tot_page: integer): TFDQuery; overload;

function findAll(
  tp_prod: string; area: string; data_inicio: string;
  id_produtor: integer;
  data_fim: string; var tot_page: integer
): TFDQuery; overload;

implementation

function findAll(
  tp_prod: string; area: string; data_inicio: string;
  id_produtor: integer;
  data_fim: string; var tot_page: integer
): TFDQuery;
begin
    DMConnection :=  TDMConnection.Create(DMConnection);
  const Production = DMConnection.Registro_producao_area;

  Production.close;
  Production.sql.clear;

  Production.sql.add('select ');
  Production.sql.add('	ap.nome_area, ');
  Production.sql.add('	um.nome, ');
  Production.sql.add('	um.sigla, ');
  Production.sql.add('	rp.* ');
  Production.sql.add('from ');
  Production.sql.add('    registro_producao rp inner join ');
  Production.sql.add('	areas_producao ap on ');
  Production.sql.add('	ap.id = rp.id_area_prod  inner join');
  Production.sql.add('	unidade_medida um on ');
  Production.sql.add('	um.id = rp.id_unidade ');

  if area <> '' then
    Production.sql.add(' and rp.id_area_prod = '+ area);

  if tp_prod  <> '' then
    Production.sql.add(' and rp.tipo_prod = '+ QuotedStr(tp_prod));

  if ((data_inicio <> '') and (data_fim  <> '')) then
    Production.sql.add(' and rp.data_producao between ' +
      QuotedStr(data_inicio) + ' and ' + QuotedStr(data_fim)
    );

  Production.sql.add( ' where ap.id_produtor = ' + intToStr(id_produtor));

  Production.Open;
  Result := Production;
end;

function findAll(
          page: integer; limit: integer;
          id_produtor: integer;
          tp_prod: string; area: string; data_inicio: string;
          data_fim: string; var tot_page: integer): TFDQuery;
begin
  DMConnection :=  TDMConnection.Create(DMConnection);
  const Production = DMConnection.Registro_producao_area;

  Production.close;
  Production.sql.clear;

  Production.sql.add('select ');
  Production.sql.add('	ap.nome_area, ');
  Production.sql.add('	um.nome, ');
  Production.sql.add('	um.sigla, ');
  Production.sql.add('	rp.* ');
  Production.sql.add('from ');
  Production.sql.add('    registro_producao rp inner join ');
  Production.sql.add('	areas_producao ap on ');
  Production.sql.add('	ap.id = rp.id_area_prod  inner join');
  Production.sql.add('	unidade_medida um on ');
  Production.sql.add('	um.id = rp.id_unidade ');

  if area <> '' then
    Production.sql.add(' and rp.id_area_prod = '+ area);

  if tp_prod  <> '' then
    Production.sql.add(' and rp.tipo_prod = '+ QuotedStr(tp_prod));

  if ((data_inicio <> '') and (data_fim  <> '')) then
    Production.sql.add(' and rp.data_producao between ' +
      QuotedStr(data_inicio) + ' and ' + QuotedStr(data_fim)
    );

  Production.sql.add( ' where ap.id_produtor = ' + intToStr(id_produtor));

  Production.open;

  var tot :=  Trunc((Production.RowsAffected/limit)) < (Production.RowsAffected/limit);

  if tot then
    tot_page := Trunc(Production.RowsAffected/limit) + 1
  else
    tot_page := Trunc(Production.RowsAffected/limit);

  Production.close;

  var initial := page - 1;
  initial := initial * limit;

  Production.SQL.Add('ORDER BY ');
  Production.SQL.Add('rp.id OFFSET :offset ROWS FETCH NEXT :limit ROWS ONLY;');

  Production.ParamByName('offset').AsInteger := initial;
  Production.ParamByName('limit').AsInteger := limit;

  Production.Open;
  Result := Production;
end;

Function save(productionJson: string): TFDQuery;
begin
  DMConnection :=  TDMConnection.Create(DMConnection);
  var Production := DMConnection.Registro_Producao;

   var jsonObj := TJSONObject
    .ParseJSONValue(TEncoding.UTF8.GetBytes(productionJson), 0) as TJSONObject;

  Production.New(jsonObj).OpenUp;
  Result := Production;
end;

function update(id: integer; productionJson: string ): TFDQuery;
begin
  DMConnection :=  TDMConnection.Create(DMConnection);
  const Production  = DMConnection.Registro_Producao;

  var jsonObj := TJSONObject
    .ParseJSONValue(TEncoding.UTF8.GetBytes(productionJson), 0) as TJSONObject;

  Production.where('id').Equals(id).OpenUp;
  Production.MergeFromJSONObject(jsonObj);

  Result := Production;
end;

function findByPk(id: integer): TFDQuery;
begin
  DMConnection :=  TDMConnection.Create(DMConnection);
  var Production := DMConnection.Registro_Producao;

  Production.where('id').equals(id).OpenUp;
  Result := Production;
end;

Function findByProducerArea(id: integer): TFDQuery;
begin
  DMConnection :=  TDMConnection.Create(DMConnection);
  var Production := DMConnection.Registro_Producao;


  Production.where('id_area_prod').equals(id).OpenUp;
  Result := Production;
end;

function delete(id: integer ): boolean;
begin
  DMConnection :=  TDMConnection.Create(DMConnection);
  const Production  = DMConnection.Registro_Producao;
  try
    Production.Remove(Production.FieldByName('id'), id).OpenUp;
    result:= true;
  except
    on E:Exception do
      result:= false;
  end;
end;

end.
