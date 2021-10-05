unit ProductionAreaModel;

interface


uses connection, Ragna, System.JSON, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.ConsoleUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Phys.PG, FireDAC.Phys.PGDef, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, Horse, System.SysUtils, Dataset.serialize,
  System.Classes, System.NetEncoding, Soap.EncdDecd;

Function save(productionAreaJson: String): TFDQuery;
Function findByProducer(id: integer): TFDQuery;
Function findByPk(id: integer): TFDQuery;
Function findAvatarByProducer(id_producer: integer; id_area: integer): TMemoryStream;
function update(id: integer; productionAreaJson: string ): TFDQuery;
function delete(id: integer ): boolean;
Function findByPkAndProducer(id: integer; id_producer: integer): TFDQuery;

implementation


Function findAvatarByProducer(id_producer: integer; id_area: integer): TMemoryStream;
begin
  const fileStream = TMemoryStream.Create;
  const DMConnection = TDMConnection.Create(nil);
  var ProductionArea := DMConnection.Areas_Producao;
  try
    ProductionArea
      .Where('id').Equals(id_area)
      .&And('id_produtor').Equals(id_producer).OpenUp;

    const img = ProductionArea.CreateBlobStream(
      ProductionArea.FieldByName('foto'),
      bmRead
    );

    fileStream.LoadFromStream(img);
    result := fileStream;

  except
    on E:Exception do
      Writeln(E.Message);
  end;

end;

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
  ProductionArea.SQL.Add('update areas_producao set foto=:foto where ');
  ProductionArea.SQL.Add('id =:id');
  ProductionArea.ParamByName('id').AsInteger := id;
  ProductionArea.ParamByName('foto').LoadFromStream(ms, ftBlob);

  ProductionArea.ExecSQL;
end;

Function save(productionAreaJson: String): TFDQuery;
begin
  DMConnection :=  TDMConnection.Create(DMConnection);
  var ProductionArea := DMConnection.Areas_Producao;

  var jsonObj := TJSONObject
    .ParseJSONValue(TEncoding.UTF8.GetBytes(productionAreaJson), 0) as TJSONObject;

  const base64 = jsonObj.GetValue('foto').value;
  jsonObj.RemovePair('foto');

  ProductionArea.New(jsonObj).OpenUp;

  const id = ProductionArea.FieldByName('id').AsInteger;
  saveFoto(base64, id);

  Result := ProductionArea;
end;

function update(id: integer; productionAreaJson: string ): TFDQuery;
begin
  DMConnection :=  TDMConnection.Create(DMConnection);
  const ProductionArea  = DMConnection.Areas_Producao;

  var jsonObj := TJSONObject
    .ParseJSONValue(TEncoding.UTF8.GetBytes(productionAreaJson), 0) as TJSONObject;

  var base64 := '';
  if jsonObj.TryGetValue('foto', base64) then
    begin
      base64 := jsonObj.GetValue('foto').value;
      jsonObj.RemovePair('foto');
    end;

  ProductionArea.where('id').Equals(id).OpenUp;
  ProductionArea.MergeFromJSONObject(jsonObj);

  if base64 <> '' then
    begin
      const id_area = ProductionArea.FieldByName('id').AsInteger;
      saveFoto(base64, id_area);
    end;

  Result := ProductionArea;
end;

Function findByPk(id: integer): TFDQuery;
begin
  DMConnection :=  TDMConnection.Create(DMConnection);
  var ProductionArea := DMConnection.Areas_Producao;

  ProductionArea.where('id').equals(id).OpenUp;
  Result := ProductionArea;
end;

Function findByPkAndProducer(id: integer; id_producer: integer): TFDQuery;
begin
  DMConnection :=  TDMConnection.Create(DMConnection);
  var ProductionArea := DMConnection.Areas_Producao;

  ProductionArea
    .where('id').equals(id)
    .&And('id_produtor').Equals(id_producer)
    .OpenUp;
  Result := ProductionArea;
end;

Function findByProducer(id: integer): TFDQuery;
begin
  DMConnection :=  TDMConnection.Create(DMConnection);
  var ProductionArea := DMConnection.Areas_Producao;

  ProductionArea.where('id_produtor').equals(id).OpenUp;
  Result := ProductionArea;
end;

function delete(id: integer ): boolean;
begin
  DMConnection :=  TDMConnection.Create(DMConnection);
  const Area  = DMConnection.Areas_Producao;
  try
    Area.Remove(Area.FieldByName('id'), id).OpenUp;
    result:= true;
  except
    on E:Exception do
      result:= false;
  end;
end;

end.
