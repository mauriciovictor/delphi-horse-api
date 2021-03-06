unit InstituitionsModel;

interface
uses connection, Ragna, System.JSON, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.ConsoleUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Phys.PG, FireDAC.Phys.PGDef, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, Horse, System.SysUtils, Dataset.serialize,
  System.Classes, System.NetEncoding, Soap.EncdDecd;

function findByPK(id: integer): TFDQuery;
function save(instituitionJson: string ): TFDQuery;
function update(id: integer; instituitionJson: string ): TFDQuery;
function delete(id: integer ): boolean;
function findAll(page: integer; limit: integer; findName:string; findValue: string;  var tot_page: integer): TFDQuery; overload;
function findAll(): TFDQuery; overload;

implementation

function findByPK(id: integer): TFDQuery;
begin
  DMConnection :=  TDMConnection.Create(DMConnection);
  const Instituition  = DMConnection.Instituicoes;
  instituition.where('id').equals(id).openup;
  result := instituition;
end;

function save(instituitionJson: string ): TFDQuery;
begin
  DMConnection :=  TDMConnection.Create(DMConnection);
  const Instituition  = DMConnection.Instituicoes;

    var jsonObj := TJSONObject
    .ParseJSONValue(TEncoding.UTF8.GetBytes(instituitionJson), 0) as TJSONObject;

  Instituition.New(jsonObj).OpenUp;
  Result := Instituition;
end;

function update(id: integer; instituitionJson: string ): TFDQuery;
begin
  DMConnection :=  TDMConnection.Create(DMConnection);
  const Instituition  = DMConnection.Instituicoes;

  var jsonObj := TJSONObject
    .ParseJSONValue(TEncoding.UTF8.GetBytes(instituitionJson), 0) as TJSONObject;

  Instituition
    .where('id')
    .Equals(id)
    .OpenUp;

  Instituition
    .MergeFromJSONObject(jsonObj);

  Result := Instituition;
end;

function delete(id: integer ): boolean;
begin
  DMConnection :=  TDMConnection.Create(DMConnection);
  const Instituition = DMConnection.Instituicoes;
  try
    Instituition
      .Remove(Instituition.FieldByName('id'), id)
      .OpenUp;

    result:= true;
  except
    on E:Exception do
      result:= false;
  end;
end;

function findAll(page: integer; limit: integer; findName:string; findValue: string;  var tot_page: integer): TFDQuery; overload;
begin
  DMConnection :=  TDMConnection.Create(DMConnection);
  const Instituition = DMConnection.Instituicoes;

  Instituition.Close;
  Instituition.SQL.Clear;
  Instituition.SQL.Add('select ');
  Instituition.SQL.Add('i.*');
  Instituition.SQL.Add('from ');
  Instituition.SQL.Add('instituicoes i');

  var filtered := false;
  var tot := false;

  if ((findName <> '') and (findValue <> '')) then
    begin
      Instituition.SQL.Add(' where ');
      Instituition.SQL.Add( findName +' like ' + QuotedStr('%' + findValue + '%'));
      Instituition.Open;

      filtered := true;

      tot :=  Trunc((Instituition.RowsAffected/limit)) < (Instituition.RowsAffected/limit);

      if tot then
        tot_page := Trunc(Instituition.RowsAffected/limit) + 1
      else
        tot_page := Trunc(Instituition.RowsAffected/limit);

      Instituition.close;
    end;

  if not filtered then
    begin
      tot :=  Trunc((Instituition.OpenUp.RowsAffected/limit)) < (Instituition.OpenUp.RowsAffected/limit);

      if tot then
        tot_page := Trunc(Instituition.OpenUp.RowsAffected/limit) + 1
      else
        tot_page := Trunc(Instituition.OpenUp.RowsAffected/limit);
    end;

  var initial := page - 1;
  initial := initial * limit;

  Instituition.SQL.Add('ORDER BY ');
  Instituition.SQL.Add('i.id OFFSET :offset ROWS FETCH NEXT :limit ROWS ONLY;');

  Instituition.ParamByName('offset').AsInteger := initial;
  Instituition.ParamByName('limit').AsInteger := limit;

  Instituition.Open;
  Result := Instituition;

end;

function findAll(): TFDQuery; overload;
begin
  DMConnection :=  TDMConnection.Create(DMConnection);
  const Instituition = DMConnection.Instituicoes;
  Instituition.OpenUp;
  Result := Instituition;
end;

end.
