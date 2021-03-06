unit CommunityController;

interface

uses Horse, Jsons, System.JSON, Horse.JWT,
  JOSE.Core.JWT, JOSE.Core.Builder,
  System.DateUtils, System.SysUtils,
  System.RegularExpressions, Ragna, Dataset.serialize;

procedure store(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure index(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Destroy(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Communities(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure show(Req: THorseRequest; Res: THorseResponse; Next: TProc);


implementation

uses CommunityModel, RegionsModel;

procedure Communities(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
   const communities = CommunityModel.findAll();
   res.send(communities.ToJSONArray);
end;

procedure show(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
     const id = strToInt(req.Params.Items['id']);

     const community = CommunityModel.findByPK(id);

     if community.IsEmpty then
      begin
         res.send('{"message" : "comunidade n?o encontrado" }').status(404);
         raise EHorseCallbackInterrupted.Create;
      end;

     res.Send(community.ToJSONObject);
end;


procedure index(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  const responseJson = TJson.Create();

  var &total_pages := 0;
  var communities :TJSONArray;

  var value := '';
  var find := '';

  if ((req.Query.ContainsKey('page')) and (req.Query.ContainsKey('limit'))) then
    begin
      const page = strToInt(req.Query.Items['page']);
      const limit = strToInt(req.Query.Items['limit']);

      if ((req.Query.ContainsKey('find')) and (req.Query.ContainsKey('value'))) then
        begin
          value := req.Query.Items['value'];
          find := req.Query.Items['find'];

          communities := CommunityModel
            .findAll(page, limit, find, value, &total_pages)
            .ToJSONArray;
        end
      else
        begin
          communities := CommunityModel
            .findAll(page, limit, find, value, &total_pages)
            .ToJSONArray;
        end;

        responseJson['data'].Parse(communities.ToJSON);

      with responseJson['pagination'].AsObject do
        begin
          Put('total_pages', &total_pages);
          Put('current_page', page);
        end;
    end
  else if ((req.Query.ContainsKey('find')) and (req.Query.ContainsKey('value'))) then
    begin
      find := req.Query.Items['find'];
      value := req.Query.Items['value'];

      communities := CommunityModel
            .findAll(find, value)
            .ToJSONArray;

      responseJson.Parse(communities.ToJSON);
    end;


  res.Send(responseJson.Stringify);
end;

procedure store(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  const body = TJson.Create;
  body.parse(Req.Body);


  if body['nome_comunidade'].AsString = '' then
    begin
       res.send('{"message" : "campo nome n?o pode ser vazio" }').status(401);
       raise EHorseCallbackInterrupted.Create;
     end;

  if body['uf'].AsString = '' then
    begin
       res.send('{"message" : "campo uf n?o pode ser vazio" }').status(401);
       raise EHorseCallbackInterrupted.Create;
     end;

  if body['municipio'].AsString = '' then
    begin
       res.send('{"message" : "campo municipio n?o pode ser vazio" }').status(404);
       raise EHorseCallbackInterrupted.Create;
     end;

  const region = RegionsModel
    .findByPK(body['id_regiao'].AsInteger);

  if region.isEmpty() then
    begin
       res.send('{"message" : "regi?o n?o existe" }').status(404);
       raise EHorseCallbackInterrupted.Create;
    end;

  const Community = CommunityModel
    .save(body.stringify)
    .ToJsonObject();

  res.send(Community).status(201);
end;

procedure update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  const body = TJson.Create;
  body.parse(Req.Body);

  if body['nome_comunidade'].AsString = '' then
    begin
       res.send('{"message" : "campo nome n?o pode ser vazio" }').status(401);
       raise EHorseCallbackInterrupted.Create;
     end;

  const id = strToInt(req.Params.Items['id']);

  const community = CommunityModel.findByPK(id);

  if community.isEmpty then
    begin
      res.send('{"message" : "Comunidade n?o existe" }').status(404);
      raise EHorseCallbackInterrupted.Create;
    end;

  const region = RegionsModel
    .findByPK(body['id_regiao'].AsInteger);

  if region.isEmpty() then
    begin
       res.send('{"message" : "regi?o n?o existe" }').status(404);
       raise EHorseCallbackInterrupted.Create;
    end;

  if not req.Params.ContainsKey('id') then
    begin
       res.send('{"message" : "id n?o foi passado" }').status(401);
       raise EHorseCallbackInterrupted.Create;
    end;

  res.Send(CommunityModel.update(id, Req.Body).ToJSONObject);
end;

procedure Destroy(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  const id = strToInt(req.Params.Items['id']);

  const community = CommunityModel.findByPK(id);

  if community.IsEmpty then
    begin
      res.send('{"message" : "comunidade n?o existe" }').status(404);
      raise EHorseCallbackInterrupted.Create;
    end;

  if CommunityModel.delete(id) then
    begin
      res.send('{"message" : "comunidade deletada com sucesso" }').status(200);
      raise EHorseCallbackInterrupted.Create;
    end;

  res.send('{"message" : "n?o foi possivel deletar a regi?o" }').status(401);
end;

end.
