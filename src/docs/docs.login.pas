unit docs.login;

interface

uses
  Horse,
  Horse.GBSwagger;
procedure registry();
implementation

uses schemas.classes;

procedure registry();
begin
    Swagger
      .Path('login')
        .Tag('Login')
        .Post('autentição api', 'autenticação api')
            .AddParamBody
              .Schema(TLogin)
            .&End
          .AddResponse(201)
            .Schema(TToken)
          .&End
          .AddResponse(404, 'cpf e/ou senha invalidos')
            .Schema(TMessage)
          .&End
          .AddResponse(500, 'Internal Server Error')
          .&End
        .&End
      .&End
    .&End;
end;

end.
