unit User;

interface

uses Horse, System.sysutils;

procedure Exist(Req: THorseRequest; Res: THorseResponse; Next: Tproc);
implementation

uses UsuariosModel;

procedure Exist(Req: THorseRequest; Res: THorseResponse; Next: Tproc);
begin
  if not req.Params.ContainsKey('id') then
      begin
           res.Send('{message: id usu?rio ? obrigatorio}');
           raise EHorseCallbackInterrupted.Create;
      end;

  const id =  req.Params.items['id'];
  const usuario = UsuariosModel.findById(StrToInt(id));

  if usuario.IsEmpty() then
    begin
      res.send('{message : Usu?rio n?o encontrado}');
      raise EHorseCallbackInterrupted.Create;
    end;

  Next();
end;


end.
