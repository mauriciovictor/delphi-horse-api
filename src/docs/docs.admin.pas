unit docs.admin;

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
      .Path('administrador')
        .Tag('Administradores')
        .GET('listar administradores', 'listar administradores')
            .AddParamHeader('Authorization', 'Authorization')
              .Schema(TToken)
            .&End
          .AddResponse(200)
            .Schema(TUserAdminPagination)
          .&End
          .AddResponse(401, 'token n?o encontrado ou invalido')
            .Schema(SWAG_STRING)
          .&End
          .AddResponse(404, 'administrador n?o encontrada')
            .Schema(TMessage)
          .&End
          .AddResponse(500, 'Internal Server Error')
          .&End
        .&End
      .&End
    .&End;

    Swagger
      .Path('administrador/{id_admin}')
        .Tag('Administradores')
        .GET('listar um administrador', 'listar administrador especifico')
            .AddParamPath('id_admin', 'id_admin')
              .Schema(SWAG_INTEGER)
              .required(true)
            .&End
            .AddParamHeader('Authorization', 'Authorization')
              .Schema(TToken)
            .&End
          .AddResponse(200)
            .Schema(TUserAdmin)
          .&End
          .AddResponse(401, 'token n?o encontrado ou invalido')
            .Schema(SWAG_STRING)
          .&End
          .AddResponse(404, 'administrador n?o encontrado')
            .Schema(TMessage)
          .&End
          .AddResponse(500, 'Internal Server Error')
          .&End
        .&End
      .&End
    .&End;

    Swagger
      .Path('administrador/{id_admin}/foto')
        .Tag('Administradores')
        .GET('listar foto administrador', 'listar foto administrador especifico')
            .AddParamPath('id_admin', 'id_admin')
              .Schema(SWAG_INTEGER)
              .required(true)
            .&End
            .AddParamHeader('Authorization', 'Authorization')
              .Schema(TToken)
            .&End
          .AddResponse(200)
            .Schema('image/png')
          .&End
          .AddResponse(401, 'token n?o encontrado ou invalido')
            .Schema(TMessage)
          .&End
          .AddResponse(404, 'administrador n?o encontrado')
            .Schema(TMessage)
          .&End
          .AddResponse(500, 'Internal Server Error')
          .&End
        .&End
      .&End
    .&End;

    Swagger
      .Path('administrador/criar')
        .Tag('Administradores')
        .Post('criar administrador', 'criar novo usu?rio administrador')
            .AddParamHeader('Authorization', 'Authorization')
              .Schema(TToken)
            .&End
            .AddParamBody
              .Schema(TUserAdmin)
            .&End
          .AddResponse(201)
            .Schema(TRegion)
          .&End
          .AddResponse(401, 'token n?o encontrado ou invalido')
            .Schema(TMessage)
          .&End
          .AddResponse(404, 'administrador n?o encontrado')
            .Schema(TMessage)
          .&End
          .AddResponse(500, 'Internal Server Error')
          .&End
        .&End
      .&End
    .&End;

    Swagger
      .Path('administrador/{id_admin}')
        .Tag('Administradores')
        .Put('alterar um administrador', 'um administrador')
            .AddParamPath('id_admin', 'id_admin')
              .Schema(SWAG_INTEGER)
            .&end
            .AddParamHeader('Authorization', 'Authorization')
              .Schema(TToken)
            .&End
            .AddParamBody
              .Schema(TUserAdmin)
            .&End
          .AddResponse(200)
            .Schema(TRegion)
          .&End
          .AddResponse(401, 'token n?o encontrado ou invalido')
            .Schema(TMessage)
          .&End
          .AddResponse(404, 'administrador n?o encontrado')
            .Schema(TMessage)
          .&End
          .AddResponse(500, 'Internal Server Error')
          .&End
        .&End
      .&End
    .&End;

    Swagger
      .Path('administrador/{id_admin}')
        .Tag('Administradores')
        .Delete('deletar um administrador', 'deletar um administrador')
            .AddParamPath('id_admin', 'id_admin')
              .Schema(SWAG_INTEGER)
            .&end
            .AddParamHeader('Authorization', 'Authorization')
              .Schema(TToken)
            .&End
          .AddResponse(200, 'administrador deletadado com sucesso')
            .Schema(TMessage)
          .&End
          .AddResponse(401, 'token n?o encontrado ou invalido')
            .Schema(TMessage)
          .&End
          .AddResponse(404, 'administrador n?o existe')
            .Schema(TMessage)
          .&End
          .AddResponse(500, 'Internal Server Error')
          .&End
        .&End
      .&End
    .&End;
end;

end.
