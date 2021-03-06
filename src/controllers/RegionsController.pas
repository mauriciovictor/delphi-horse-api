unit RegionsController;

interface

uses Horse, Jsons, System.JSON, Horse.JWT,
  JOSE.Core.JWT, JOSE.Core.Builder,
  System.DateUtils, System.SysUtils,
  System.RegularExpressions, Ragna, Dataset.serialize;

procedure store(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure index(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure show(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Destroy(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure listAll(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

uses RegionsModel, InstituitionsModel;

procedure listAll(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
   const regions = RegionsModel.findAll().ToJSONArray;
   res.Send(regions);
end;

procedure show(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
     const id = strToInt(req.Params.Items['id']);

     const region = RegionsModel.findByPK(id);

     if region.IsEmpty then
      begin
         res.send('{"message" : "regi?o n?o encontrado" }').status(404);
         raise EHorseCallbackInterrupted.Create;
      end;

     res.Send(region.ToJSONObject);
end;

procedure index(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  const responseJson = TJson.Create();

  const page = strToInt(req.Query.Items['page']);
  const limit = strToInt(req.Query.Items['limit']);

  var &total_pages := 0;
  var regions: TJSONArray;

  if ((req.Query.ContainsKey('find')) and (req.Query.ContainsKey('value'))) then
    begin
      regions := RegionsModel
        .findAll(page, limit, req.Query.Items['find'], req.Query.Items['value'], &total_pages)
        .ToJSONArray;
    end
  else
    begin
      regions := RegionsModel
        .findAll(page, limit, '', '', &total_pages)
        .ToJSONArray;
    end;

  responseJson['data'].Parse(regions.ToJSON);

  with responseJson['pagination'].AsObject do
    begin
      Put('total_pages', &total_pages);
      Put('current_page', page);
    end;

  res.Send(responseJson.Stringify);
end;

procedure store(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  const body = TJson.Create;
  body.parse(Req.Body);


  if body['nome_regiao'].AsString = '' then
    begin
       res.send('{"message" : "campo nome n?o pode ser vazio" }').status(401);
       raise EHorseCallbackInterrupted.Create;
     end;

  const instituition = InstituitionsModel
    .findByPK(body['id_instituicao'].AsInteger);

  if instituition.isEmpty() then
    begin
       res.send('{"message" : "institui??o n?o existe" }').status(404);
       raise EHorseCallbackInterrupted.Create;
    end;

  const region = RegionsModel
    .save(body.stringify)
    .ToJsonObject();

  res.send(region).status(201);

end;

procedure update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  const body = TJson.Create;
  body.parse(Req.Body);

  if body['nome_regiao'].AsString = '' then
    begin
       res.send('{"message" : "campo nome n?o pode ser vazio" }').status(401);
       raise EHorseCallbackInterrupted.Create;
     end;

  const id = strToInt(req.Params.Items['id']);

  const region = RegionsModel.findByPK(id);

  if region.IsEmpty then
    begin
      res.send('{"message" : "regi?o n?o existe" }').status(404);
      raise EHorseCallbackInterrupted.Create;
    end;

  const instituition = InstituitionsModel
    .findByPK(body['id_instituicao'].AsInteger);

  if instituition.isEmpty() then
    begin
       res.send('{"message" : "institui??o n?o existe" }').status(404);
       raise EHorseCallbackInterrupted.Create;
    end;

  if not req.Params.ContainsKey('id') then
    begin
       res.send('{"message" : "id n?o foi passado" }').status(401);
       raise EHorseCallbackInterrupted.Create;
    end;

  res.Send(RegionsModel.update(id, Req.Body).ToJSONObject);
end;


procedure Destroy(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  const id = strToInt(req.Params.Items['id']);

  const region = RegionsModel.findByPK(id);

  if region.IsEmpty then
    begin
      res.send('{"message" : "regi?o n?o existe" }').status(404);
      raise EHorseCallbackInterrupted.Create;
    end;


  if RegionsModel.delete(id) then
    begin
      res.send('{"message" : "regi?o deletada com sucesso" }').status(200);
      raise EHorseCallbackInterrupted.Create;
    end;

  res.send('{"message" : "n?o foi possivel deletar a regi?o" }').status(401);
end;



end.
