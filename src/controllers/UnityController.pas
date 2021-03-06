unit UnityController;

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

uses unityModel;

procedure listAll(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
   const Unities = unityModel.findAll().ToJSONArray;
   res.Send(Unities);
end;

procedure show(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
     const id = strToInt(req.Params.Items['id']);

     const unity = unityModel.findByPK(id);

     if unity.IsEmpty then
      begin
         res.send('{"message" : "unidade medida n?o encontrado" }').status(404);
         raise EHorseCallbackInterrupted.Create;
      end;

     res.Send(unity.ToJSONObject);
end;

procedure index(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  const responseJson = TJson.Create();

  const page = strToInt(req.Query.Items['page']);
  const limit = strToInt(req.Query.Items['limit']);

  var &total_pages := 0;
  var unities: TJSONArray;

  if ((req.Query.ContainsKey('find')) and (req.Query.ContainsKey('value'))) then
    begin
      unities := unityModel
        .findAll(page, limit, req.Query.Items['find'], req.Query.Items['value'], &total_pages)
        .ToJSONArray;
    end
  else
    begin
      unities := unityModel
        .findAll(page, limit, '', '', &total_pages)
        .ToJSONArray;
    end;

  responseJson['data'].Parse(unities.ToJSON);

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

  if body['sigla'].AsString = '' then
    begin
       res.send('{"message" : "campo sigla n?o pode ser vazio" }').status(401);
       raise EHorseCallbackInterrupted.Create;
     end;

  if body['nome'].AsString = '' then
    begin
       res.send('{"message" : "campo nome unidade n?o pode ser vazio" }').status(401);
       raise EHorseCallbackInterrupted.Create;
     end;

  const unity = unityModel
    .save(body.stringify)
    .ToJsonObject();

  res.send(unity).status(201);

end;

procedure update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  const body = TJson.Create;
  body.parse(Req.Body);

  if body['sigla'].AsString = '' then
    begin
       res.send('{"message" : "campo sigla n?o pode ser vazio" }').status(401);
       raise EHorseCallbackInterrupted.Create;
     end;

  if body['nome'].AsString = '' then
    begin
       res.send('{"message" : "campo nome unidade n?o pode ser vazio" }').status(401);
       raise EHorseCallbackInterrupted.Create;
     end;

  const id = strToInt(req.Params.Items['id']);

  const unity = unityModel.findByPK(id);

  if unity.IsEmpty then
    begin
      res.send('{"message" : "unidade medida n?o existe" }').status(404);
      raise EHorseCallbackInterrupted.Create;
    end;

  if not req.Params.ContainsKey('id') then
    begin
       res.send('{"message" : "id n?o foi passado" }').status(401);
       raise EHorseCallbackInterrupted.Create;
    end;

  res.Send(unityModel.update(id, Req.Body).ToJSONObject);
end;


procedure Destroy(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  const id = strToInt(req.Params.Items['id']);

  const unity = unityModel.findByPK(id);

  if unity.IsEmpty then
    begin
      res.send('{"message" : "unidade medida n?o existe" }').status(404);
      raise EHorseCallbackInterrupted.Create;
    end;


  if unityModel.delete(id) then
    begin
      res.send('{"message" : "unidade medidade deletada com sucesso" }').status(200);
      raise EHorseCallbackInterrupted.Create;
    end;

  res.send('{"message" : "n?o foi possivel deletar a unidade de medida" }').status(401);
end;

end.
