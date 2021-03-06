unit AdministratorController;

interface
uses
  Horse, Jsons, System.JSON, Horse.JWT,
  JOSE.Core.JWT, JOSE.Core.Builder,
  System.DateUtils, System.SysUtils,
  System.RegularExpressions, Ragna, Dataset.serialize;

procedure store(Req: THorseRequest; Res: THorseResponse; Next: Tproc);
procedure index(Req: THorseRequest; Res: THorseResponse; Next: Tproc);
procedure Destroy(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure avatar(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure show(Req: THorseRequest; Res: THorseResponse; Next: Tproc);
procedure update(Req: THorseRequest; Res: THorseResponse; Next: Tproc);

implementation

uses UsuariosModel, AdminModel;

procedure avatar(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin

    const id = strToInt(req.Params.Items['id']);
    const img = adminModel.findAvatar(id);
    img.Position := 0;

    Res.Status(THTTPStatus.OK);
    res.RawWebResponse.ContentType := 'image/png';
    Res.RawWebResponse.ContentStream := img;
    Res.RawWebResponse.SendResponse;
end;

procedure update(Req: THorseRequest; Res: THorseResponse; Next: Tproc);
begin

  const id = strToInt(req.Params.Items['id']);
  const admin = adminModel.findByPK(id);

  if admin.IsEmpty then
    begin
      res.send('{"message" : "usu?rio n?o existe" }').status(404);
      raise EHorseCallbackInterrupted.Create;
    end;

  res.Send(adminModel.update(Req.Body, id).ToJSONObject);
end;

procedure index(Req: THorseRequest; Res: THorseResponse; Next: Tproc);
begin
  const responseJson = TJson.Create();

  const page = strToInt(req.Query.Items['page']);
  const limit = strToInt(req.Query.Items['limit']);

  var &total_pages := 0;
  var admins: TJSONArray;

  if ((req.Query.ContainsKey('find')) and (req.Query.ContainsKey('value'))) then
    begin
      admins := AdminModel
        .findAll(page, limit, req.Query.Items['find'], req.Query.Items['value'], &total_pages)
        .ToJSONArray;
    end
  else
    begin
      admins := AdminModel
        .findAll(page, limit, '', '', &total_pages)
        .ToJSONArray;
    end;

  responseJson['data'].Parse(admins.ToJSON);

  for var i:= 0 to responseJson['data'].AsArray.Count -1 do
    begin
      const admin =
        responseJson['data'].AsArray.items[i].AsObject;

      if admin['avatar'].AsString <> '' then
        begin
          admin.Delete('avatar');
          admin.Put('avatar','http://173.212.240.239:8181/admin/' + admin['id'].AsString + '/foto');
        end;
    end;

  with responseJson['pagination'].AsObject do
    begin
      Put('total_pages', &total_pages);
      Put('current_page', page);
    end;

  res.Send(responseJson.Stringify);
end;


procedure show(Req: THorseRequest; Res: THorseResponse; Next: Tproc);
begin
  const id = strToInt(req.Params.Items['id']);

  const admin = adminModel.findByPK(id);

  if admin.IsEmpty then
    begin
      res.send('{"message" : "administrator n?o existe" }').status(404);
      raise EHorseCallbackInterrupted.Create;
    end;

  const adminJson = TJson.Create;
  adminJson.Parse(admin.ToJSONObject.tostring);

  if adminJson['avatar'].AsString <> '' then
    begin
      adminJson.Delete('avatar');
      adminJson.Put('avatar','http://173.212.240.239:8181/admin/' + adminJson['id'].AsString + '/foto');
    end;

  res.Send(adminJson.stringify);
end;

procedure store(Req: THorseRequest; Res: THorseResponse; Next: Tproc);
begin
   const body = TJson.create;
   body.parse(req.body);

   const existCpf =  UsuariosModel
      .findByCPF(body['cpf'].AsString)
      .isEmpty();

   if not existCpf then
    begin
      res.send('{"message" : "CPF j? cadastrado"}').status(401);
      raise EHorseCallbackInterrupted.Create;
    end;

   const administrator = UsuariosModel
    .saveAdministrator(Req.Body)
    .ToJSONObject();

   res.send(administrator).Status(201);
end;



procedure Destroy(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  const id = strToInt(req.Params.Items['id']);

  const admin = UsuariosModel.findById(id);

  if admin.IsEmpty then
    begin
      res.send('{"message" : "administrator n?o existe" }').status(404);
      raise EHorseCallbackInterrupted.Create;
    end;


  if adminModel.delete(id) then
    begin
      res.send('{"message" : "administrator deletada com sucesso" }').status(200);
      raise EHorseCallbackInterrupted.Create;
    end;

  res.send('{"message" : "n?o foi possivel deletar o administrator" }').status(401);
end;

end.
