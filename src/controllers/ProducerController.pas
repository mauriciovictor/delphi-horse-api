unit ProducerController;

interface

uses Horse, Jsons, System.JSON, Horse.JWT,
  JOSE.Core.JWT, JOSE.Core.Builder,
  System.DateUtils, System.SysUtils,
  System.RegularExpressions, Ragna, Dataset.serialize;


procedure verifyCPF(Req: THorseRequest; Res: THorseResponse; Next: Tproc);
procedure index(Req: THorseRequest; Res: THorseResponse; Next: Tproc);
procedure store(Req: THorseRequest; Res: THorseResponse; Next: Tproc);
procedure show(Req: THorseRequest; Res: THorseResponse; Next: Tproc);
procedure avatar(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

uses UsuariosModel, ProducerModel, CommunityModel, ProductionModel, RegionsModel,
  InstituitionsModel, ProductionAreaModel;

procedure avatar(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
    const id = strToInt(req.Params.Items['id']);
    const img = ProducerModel.findAvatar(id);
    img.Position := 0;

    Res.Status(THTTPStatus.OK);
    res.RawWebResponse.ContentType := 'image/png';
    Res.RawWebResponse.ContentStream := img;
    Res.RawWebResponse.SendResponse;
end;

procedure verifyCPF(Req: THorseRequest; Res: THorseResponse; Next: Tproc);
begin

  if  not Req.Query.ContainsKey('cpf') then
    begin
      res.Send('{"message": "parametro CPF é obrigatorio"}');
      exit;
    end;

  const userData = TJson.create;

  const CPF = req.Query.Items['cpf'];

  const user = UsuariosModel
    .findByCPF(CPF);

  if user.IsEmpty then
    begin
      res
        .Send('{"message": "usuário não existe"}')
        .status(404);
      exit;
    end;

  userData.Parse(user.ToJsonObject().toString());

  if userData['id'].IsEmpty then
    begin
      res
        .Send('{"message": "nunhum registro encontrado"}')
        .status(401);
      exit;
    end;

  if userData['status_usu'].AsString <> 'A' then
    begin
      res
        .Send('{"message": "Usuário Bloqueado."}')
        .status(401);
      exit;
    end;

  if userData['administrador'].AsString = 'S' then
    begin
      res
        .Send('{"message": "Usuário não pertence a nenhum produtor"}')
        .status(401);
      exit;
    end;

  const producer = ProducerModel.findByUser(userData['id'].AsInteger);

  userData['produtor_info'].AsObject.Parse(producer.ToJSONObject.ToString);

  const id_comunidade =
    userData['produtor_info']
    .AsObject['id_comunidade']
    .AsInteger;

  const community = CommunityModel.findByPK(id_comunidade);

  userData['comunidade'].AsObject.Parse(community.ToJSONObject.ToString);

  const id_regiao =
    userData['comunidade']
    .AsObject['id_regiao']
    .asInteger;

  const region = RegionsModel.findByPK(id_regiao);

  userData['comunidade']
    .AsObject['regiao']
    .AsObject
    .Parse(region.ToJSONObject.ToString);

  const id_instituicao =
    userData['comunidade']
    .AsObject['regiao']
    .AsObject['id_instituicao']
    .asInteger;

  const production =
    ProductionAreaModel
    .findByProducer(producer.FieldByName('id').AsInteger);

  userData['areas_producao']
    .AsArray
    .Parse(production.ToJSONArray.ToString);

  userData['comunidade'].AsObject.delete('id_regiao');
  userData['produtor_info'].AsObject.Delete('id_usuario');
  userData['produtor_info'].AsObject.Delete('id_comunidade');
  userData.Delete('avatar');
  userData.Delete('senha');
  userData.Delete('administrador');

  res.Send(userData.Stringify).Status(200);
end;

procedure store(Req: THorseRequest; Res: THorseResponse; Next: Tproc);
begin
   const bodyJson = TJson.Create;
   bodyJson.parse(req.body);

   const isExistCPF = not UsuariosModel
    .findByCPF(bodyJson['cpf'].AsString)
    .IsEmpty;

   if isExistCPF then
    begin
      res
        .Send('{"message": "CPF já cadastrado"}')
        .status(401);
      exit;
    end;

   const user = UsuariosModel
      .save(req.body)
      .ToJSONObject();

   const id_usuario = strToInt(user.GetValue('id').Value);

   const produtorJson = bodyJson['produtor_info']
    .AsArray.Items[0]
    .AsObject;

   produtorJson.Put('id_usuario', id_usuario);

   const produtor = ProducerModel
    .saveProducer(produtorJson.Stringify)
    .ToJSONObject;

   user.AddPair('produtor_info', produtor);

   res.Send(user).Status(201);
end;

procedure show(Req: THorseRequest; Res: THorseResponse; Next: Tproc);
begin
    if  not Req.Params.ContainsKey('id') then
      begin
        res.Send('{"message": "parametro CPF é obrigatorio"}');
        exit;
      end;

  const id = strToInt(req.Params.Items['id']);
  const producer = ProducerModel.findByPK(id);

  if  producer.IsEmpty then
    begin
      res.Send('{"message": "Produtor não existe"}').Status(404);
      exit;
    end;

  const id_usuario = strToInt(producer.ToJSONObject.GetValue('id_usuario').Value);

    const user = UsuariosModel
    .findById(id_usuario)
    .ToJsonObject()
    .toString();

  const data = TJson.Create;
  Data.Parse(user);

  Data['produtor_info']
    .AsObject
    .Parse(producer.TOJsonObject.ToString);

  if Data['avatar'].AsString <> '' then
    begin
      Data.Delete('avatar');
      Data.Put('avatar','http://173.212.240.239:8181/produtor/' + data['id'].AsString + '/foto');
    end;


  const id_comunidade =
    data['produtor_info']
    .AsObject['id_comunidade']
    .AsInteger;

  const community =
    CommunityModel
    .findByPk(id_comunidade);

  data['produtor_info']
    .AsObject['comunidade']
    .AsObject
    .Parse(community.toJSONObject.tostring);

  const id_regiao =
    data['produtor_info']
    .AsObject['comunidade']
    .AsObject['id_regiao']
    .asInteger;

  const region = RegionsModel.findByPK(id_regiao);

  data['produtor_info']
    .AsObject['comunidade']
    .AsObject['regiao']
    .AsObject
    .Parse(region.ToJSONObject.ToString);

  const production = ProductionAreaModel
    .findByProducer(id);

  data['produtor_info']
  .AsObject['areas_producao']
  .AsArray
  .Parse(production.ToJSONArray.ToString);

  for var i:= 0 to data['produtor_info'].AsObject['areas_producao'].AsArray.Count -1 do
    begin
      const area =
        data['produtor_info'].AsObject['areas_producao'].AsArray.items[i].AsObject;

      if area['foto'].AsString <> '' then
        begin
          area.Delete('foto');
          area.Put('foto','http://173.212.240.239:8181/produtor/' +
            area['id_produtor'].AsString +
            '/areas/' + area['id'].AsString + '/foto'
          );
        end;
    end;

//  data['comunidade'].AsObject.delete('id_regiao');
  data['produtor_info'].AsObject.Delete('id_usuario');
  data['produtor_info'].AsObject.Delete('id_comunidade');
//  data.Delete('avatar');
  data.Delete('senha');
  data.Delete('administrador');

  res.send(data.stringify);
end;


procedure index(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  const responseJson = TJson.Create();

  var produtor := '';
  var cpf := '';
  var regiao := '';
  var comunidade := '';
  var instituicao := '';

  if req.Query.ContainsKey('produtor') then
    produtor := req.Query.Items['produtor'];

  if req.Query.ContainsKey('cpf') then
    cpf := req.Query.Items['cpf'];

  if req.Query.ContainsKey('regiao') then
    regiao := req.Query.Items['regiao'];

  if req.Query.ContainsKey('comunidade') then
    comunidade := req.Query.Items['comunidade'];

  if req.Query.ContainsKey('instituicao') then
    instituicao := req.Query.Items['instituicao'];

  var producers: TJSONArray;
  var &total_pages := 0;

  if (( not req.Query.ContainsKey('limit')) and (not req.Query.ContainsKey('page'))) then
    begin
      producers := ProducerModel
        .findAll(
          produtor, cpf, regiao,
          comunidade, instituicao, &total_pages
        ).ToJSONArray;

      responseJson.Parse(producers.ToJSON);
    end
  else
    begin
      const page = strToInt(req.Query.Items['page']);
      const limit = strToInt(req.Query.Items['limit']);

      producers := ProducerModel
        .findAll(
          page, limit, produtor, cpf, regiao,
          comunidade, instituicao, &total_pages
        ).ToJSONArray;

      responseJson['data'].Parse(producers.ToJSON);

      with responseJson['pagination'].AsObject do
        begin
          Put('total_pages', &total_pages);
          Put('current_page', page);
        end;
    end;

  res.Send(responseJson.Stringify);
end;
end.
