unit InstituitionController;

interface

uses Horse, Jsons, System.JSON, Horse.JWT,
  JOSE.Core.JWT, JOSE.Core.Builder,
  System.DateUtils, System.SysUtils,
  System.RegularExpressions, Ragna, Dataset.serialize;

procedure store(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure index(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure listAll(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Destroy(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure show(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

uses InstituitionsModel;

procedure show(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  const id = strToInt(req.Params.Items['id']);
  const instituition = instituitionsModel.findByPK(id);

  if instituition.isEmpty then
    begin
      res.send('{"message" : "Instituição não existe" }').status(404);
      raise EHorseCallbackInterrupted.Create;
    end;

  res.Send(instituition.ToJSONObject.ToString);
end;

procedure listAll(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
   const instituition = InstituitionsModel.findAll().ToJSONArray;
   res.Send(instituition);
end;

procedure store(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  const body = TJson.Create;
  body.parse(Req.Body);

  try
    const instituition = InstituitionsModel
    .save(body.stringify)
    .ToJsonObject();

    res.send(instituition).status(201);
  except
    on E:Exception do
        res.send('{"message": "'+ E.Message+ '"}').status(401);
  end;
end;

procedure index(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  const responseJson = TJson.Create();

  const page = strToInt(req.Query.Items['page']);
  const limit = strToInt(req.Query.Items['limit']);

  var &total_pages := 0;
  var Instituitions: TJSONArray;

  if ((req.Query.ContainsKey('find')) and (req.Query.ContainsKey('value'))) then
    begin
      Instituitions := InstituitionsModel
        .findAll(page, limit, req.Query.Items['find'], req.Query.Items['value'], &total_pages)
        .ToJSONArray;
    end
  else
    begin
      Instituitions := InstituitionsModel
        .findAll(page, limit, '', '', &total_pages)
        .ToJSONArray;
    end;

  responseJson['data'].Parse(Instituitions.ToJSON);

  with responseJson['pagination'].AsObject do
    begin
      Put('total_pages', &total_pages);
      Put('current_page', page);
    end;

  res.Send(responseJson.Stringify);
end;

procedure update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  const body = TJson.Create;
  body.parse(Req.Body);

  const id = strToInt(req.Params.Items['id']);

  const instituition = instituitionsModel.findByPK(id);

  if instituition.isEmpty then
    begin
      res.send('{"message" : "Instituição não existe" }').status(404);
      raise EHorseCallbackInterrupted.Create;
    end;

  if not req.Params.ContainsKey('id') then
    begin
       res.send('{"message" : "id não foi passado" }').status(401);
       raise EHorseCallbackInterrupted.Create;
    end;

  res.Send(instituitionsModel.update(id, Req.Body).ToJSONObject);
end;

procedure Destroy(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  const id = strToInt(req.Params.Items['id']);

  const instituition = instituitionsModel.findByPK(id);

  if instituition.IsEmpty then
    begin
      res.send('{"message" : "instituição não existe" }').status(404);
      raise EHorseCallbackInterrupted.Create;
    end;

  if instituitionsModel.delete(id) then
    begin
      res.send('{"message" : "instituição deletada com sucesso" }').status(200);
      raise EHorseCallbackInterrupted.Create;
    end;

  res.send('{"message" : "não foi possivel deletar a instituição" }').status(401);
end;


end.
