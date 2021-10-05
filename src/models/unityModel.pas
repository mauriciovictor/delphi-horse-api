unit unityModel;

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

uses GraficosGeralModel;

function save(regionJson: string ): TFDQuery;
begin
  DMConnection :=  TDMConnection.Create(DMConnection);
  const Unity  = DMConnection.Unidade_medida;

    var jsonObj := TJSONObject
    .ParseJSONValue(TEncoding.UTF8.GetBytes(regionJson), 0) as TJSONObject;

  Unity.New(jsonObj).OpenUp;
  Result := Unity;
end;

function update(id: integer; regionJson: string ): TFDQuery;
begin
  DMConnection :=  TDMConnection.Create(DMConnection);
  const Unity  = DMConnection.Unidade_Medida;

  var jsonObj := TJSONObject
    .ParseJSONValue(TEncoding.UTF8.GetBytes(regionJson), 0) as TJSONObject;

  Unity.where('id').Equals(id).OpenUp;
  Unity.MergeFromJSONObject(jsonObj);
  Result := Unity;
end;

function delete(id: integer ): boolean;
begin
  DMConnection :=  TDMConnection.Create(DMConnection);
  const Unity  = DMConnection.Unidade_Medida;
  try
    Unity.Remove(Unity.FieldByName('id'), id).OpenUp;
    result:= true;
  except
    on E:Exception do
      result:= false;
  end;
end;

function findAll(page: integer; limit: integer; findName:string; findValue: string;  var tot_page: integer): TFDQuery;
begin
  DMConnection :=  TDMConnection.Create(DMConnection);

  const Unity = DMConnection.Unidade_Medida;

  Unity.Close;
  Unity.SQL.Clear;
  Unity.SQL.Add('select ');
  Unity.SQL.Add(' * ');
  Unity.SQL.Add('from ');
  Unity.SQL.Add(' unidade_medida ');

  var filtered := false;
  var tot := false;

  if ((findName <> '') and (findValue <> '')) then
    begin
      Unity.SQL.Add(' where ');
      Unity.SQL.Add( findName +' like ' + QuotedStr('%' + findValue + '%'));
      Unity.Open;

      filtered := true;

      tot :=  Trunc((Unity.RowsAffected/limit)) < (Unity.RowsAffected/limit);

      if tot then
        tot_page := Trunc(Unity.RowsAffected/limit) + 1
      else
        tot_page := Trunc(Unity.RowsAffected/limit);

      Unity.close;
    end;

  if not filtered then
    begin
      tot :=  Trunc((Unity.OpenUp.RowsAffected/limit)) < (Unity.OpenUp.RowsAffected/limit);

      if tot then
        tot_page := Trunc(Unity.OpenUp.RowsAffected/limit) + 1
      else
        tot_page := Trunc(Unity.OpenUp.RowsAffected/limit);
    end;

  var initial := page - 1;
  initial := initial * limit;

  Unity.SQL.Add('ORDER BY ');
  Unity.SQL.Add(' id OFFSET :offset ROWS FETCH NEXT :limit ROWS ONLY;');

  Unity.ParamByName('offset').AsInteger := initial;
  Unity.ParamByName('limit').AsInteger := limit;

  Unity.Open;
  Result := Unity;
end;

function findAll(): TFDQuery; overload;
begin
  DMConnection :=  TDMConnection.Create(DMConnection);
  const Unity = DMConnection.Unidade_Medida;
  Unity.OpenUp;
  Result := Unity;
end;

function findByPk(id: integer): TFDQuery;
begin
  DMConnection :=  TDMConnection.Create(DMConnection);
  const Unity  = DMConnection.Unidade_Medida;
  Unity.where('id').equals(id).openUp;
  result := Unity;
end;


end.
