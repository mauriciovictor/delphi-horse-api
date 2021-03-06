unit RegionsModel;

interface

uses connection, Ragna, System.JSON, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.ConsoleUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Phys.PG, FireDAC.Phys.PGDef, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, Horse, System.SysUtils, Dataset.serialize,
  System.Classes, System.NetEncoding, Soap.EncdDecd;

function save(regionJson: string ): TFDQuery;
function update(id: integer; regionJson: string ): TFDQuery;
function delete(id: integer ): boolean;
function findAll(page: integer; limit: integer; findName:string; findValue: string;  var tot_page: integer): TFDQuery; overload;
function findAll(): TFDQuery; overload;
function findByPK(id: integer): TFDQuery;


implementation

function save(regionJson: string ): TFDQuery;
begin
  DMConnection :=  TDMConnection.Create(DMConnection);
  const Regions  = DMConnection.Regioes_Atendimento;

    var jsonObj := TJSONObject
    .ParseJSONValue(TEncoding.UTF8.GetBytes(regionJson), 0) as TJSONObject;

  Regions.New(jsonObj).OpenUp;
  Result := Regions;
end;

function update(id: integer; regionJson: string ): TFDQuery;
begin
  DMConnection :=  TDMConnection.Create(DMConnection);
  const Regions  = DMConnection.Regioes_Atendimento;

  var jsonObj := TJSONObject
    .ParseJSONValue(TEncoding.UTF8.GetBytes(regionJson), 0) as TJSONObject;

  Regions.where('id').Equals(id).OpenUp;
  Regions.MergeFromJSONObject(jsonObj);
  Result := Regions;
end;

function delete(id: integer ): boolean;
begin
  DMConnection :=  TDMConnection.Create(DMConnection);
  const Regions  = DMConnection.Regioes_Atendimento;
  try
    Regions.Remove(Regions.FieldByName('id'), id).OpenUp;
    result:= true;
  except
    on E:Exception do
      result:= false;
  end;
end;

function findAll(page: integer; limit: integer; findName:string; findValue: string;  var tot_page: integer): TFDQuery;
begin
  DMConnection :=  TDMConnection.Create(DMConnection);

  const regions = DMConnection.Regions_instituicoes;

  regions.Close;
  regions.SQL.Clear;
  regions.SQL.Add('select ');
  regions.SQL.Add('ra.*,');
  regions.SQL.Add('i.nome_instituicao');
  regions.SQL.Add('from ');
  regions.SQL.Add('regioes_atendimento ra inner join');
  regions.SQL.Add('instituicoes i on');
  regions.SQL.Add('i.id = ra.id_instituicao');

  var filtered := false;
  var tot := false;

  if ((findName <> '') and (findValue <> '')) then
    begin
      regions.SQL.Add(' where ');
      regions.SQL.Add( findName +' like ' + QuotedStr('%' + findValue + '%'));
      regions.Open;

      filtered := true;

      tot :=  Trunc((Regions.RowsAffected/limit)) < (Regions.RowsAffected/limit);

      if tot then
        tot_page := Trunc(Regions.RowsAffected/limit) + 1
      else
        tot_page := Trunc(Regions.RowsAffected/limit);

      regions.close;
    end;

  if not filtered then
    begin
      tot :=  Trunc((Regions.OpenUp.RowsAffected/limit)) < (Regions.OpenUp.RowsAffected/limit);

      if tot then
        tot_page := Trunc(Regions.OpenUp.RowsAffected/limit) + 1
      else
        tot_page := Trunc(Regions.OpenUp.RowsAffected/limit);
    end;

  var initial := page - 1;
  initial := initial * limit;

  regions.SQL.Add('ORDER BY ');
  regions.SQL.Add('ra.id OFFSET :offset ROWS FETCH NEXT :limit ROWS ONLY;');

  regions.ParamByName('offset').AsInteger := initial;
  regions.ParamByName('limit').AsInteger := limit;

  regions.Open;
  Result := Regions;
end;

function findAll(): TFDQuery; overload;
begin
  DMConnection :=  TDMConnection.Create(DMConnection);
  const Regions = DMConnection.Regioes_Atendimento;
  Regions.OpenUp;
  Result := Regions;
end;

function findByPk(id: integer): TFDQuery;
begin
  DMConnection :=  TDMConnection.Create(DMConnection);
  const Regions  = DMConnection.Regioes_Atendimento;
  Regions.where('id').equals(id).openUp;
  result := Regions;
end;

end.
