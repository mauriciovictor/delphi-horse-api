unit LoginController;

interface

uses Horse, Jsons, System.JSON, Horse.JWT,
  JOSE.Core.JWT, JOSE.Core.Builder,
  System.DateUtils, System.SysUtils,
  System.RegularExpressions, Ragna, Dataset.serialize;

procedure Login(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure token(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

uses DotEnv, UsuariosModel;

procedure token(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  const token = TRegex.Split(req.Headers['Authorization'], ' ')[1];
  var LToken := TJOSE.DeserializeCompact('', token);
  res.Send(LToken.Claims.JSON.ToJSON);
end;

procedure Login(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
   const body = TJson.create;
   body.Parse(Req.Body);

   const usuario = UsuariosModel
      .findByCPF(body['cpf'].AsString);

   if usuario.IsEmpty then
    begin
      res.send('{"message" : "CPF e/ou senha Invalidos" }').status(401);
      raise EHorseCallbackInterrupted.Create;
    end;

   if  usuario.ToJSONObject.GetValue('administrador').value <> 'S' then
     begin
       res.send('{message : CPF e/ou senha Invalidos }').status(401);
       raise EHorseCallbackInterrupted.Create;
     end;

   if  usuario.ToJSONObject.GetValue('status_usu').value <> 'A' then
     begin
       res.send('{message : CPF e/ou senha Invalidos }').status(401);
       raise EHorseCallbackInterrupted.Create;
     end;

   if body['senha'].AsString <>  usuario.ToJSONObject.GetValue('senha').value then
    begin
      res.send('{message : CPF e/ou senha Invalidos }').status(401);
      raise EHorseCallbackInterrupted.Create;
    end;

    const jwtPayload = TJson.Create;

  jwtPayload.Put('id', usuario.FieldByName('id').AsInteger);
  jwtPayload.Put('nome_usuario', usuario.FieldByName('nome_usuario').AsString);

  var JWT: TJWT;
  var Token: String;


  JWT := TJWT.Create();
  try

    JWT.Claims.SetAsJSON(jwtPayload.Stringify);

    Token := TJOSE.SHA256CompactToken('@@@##BEMDIVERSO!@!#@!', JWT);
  finally
    FreeAndNil(JWT);
  end;

  Res.Send('{"token":"'+ Token+ '"}').Status(201);
end;

end.
