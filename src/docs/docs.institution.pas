unit docs.institution;

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
      .Path('instituicao/{id_instituicao}')
        .Tag('Institui��es')
        .GET('listar uma institui��o', 'listar um institui��o especifica')
            .AddParamPath('id_instituicao', 'id_instituicao')
              .Schema(SWAG_INTEGER)
              .Required(true)
            .&End
            .AddParamHeader('Authorization', 'bearer token jwt')
              .Schema(SWAG_STRING)
          .&End
          .AddResponse(200)
            .Schema(TInstitution)
          .&End
          .AddResponse(404, 'institui��o n�o encontrada')
            .Schema(TMessage)
          .&End
          .AddResponse(500, 'Internal Server Error')
          .&End
        .&End
      .&End
    .&End;

    Swagger
      .Path('instituicao')
        .Tag('Institui��es')
        .GET('listar institui��es com pagina��o', 'listagem de institui��o com pagina��o e filtros')
            .Description('o query param find representa o nome de uma coluna do banco e value o valor que sera colocado no criterio de filtro exemplo: find=id&value=10')
            .AddParamQuery('page', 'page')
              .Schema(SWAG_INTEGER)
            .&End
            .AddParamQuery('limit', 'limit')
              .Schema(SWAG_INTEGER)
            .&End
            .AddParamQuery('find', 'find')
              .Schema(SWAG_STRING)
            .&End
            .AddParamQuery('value', 'value')
              .Schema(SWAG_STRING)
            .&End
            .AddParamHeader('Authorization', 'bearer token jwt')
              .Schema(SWAG_STRING)
          .&End
          .AddResponse(200)
            .Schema(TInstitutionPagination)
          .&End
          .AddResponse(500, 'Internal Server Error')
          .&End
        .&End
      .&End
    .&End;

    Swagger
      .Path('instituicao')
        .Tag('Institui��es')
        .Post('criar instiui��o', 'criar uma nova institui��o')
            .AddParamBody
              .Schema(TInstitution)
            .&End
            .AddParamHeader('Authorization', 'bearer token jwt')
              .Schema(SWAG_STRING)
          .&End
          .AddResponse(201)
            .Schema(TRegion)
          .&End
          .AddResponse(404, 'institui��o n�o encontrada')
            .Schema(TMessage)
          .&End
          .AddResponse(401, 'token n�o encontrado ou invalido')
            .Schema(SWAG_STRING)
          .&End
          .AddResponse(500, 'Internal Server Error')
          .&End
        .&End
      .&End
    .&End;

    Swagger
      .Path('instituicao/{id_instituicao}')
        .Tag('Institui��es')
        .Put('alterar institui��o', 'altera��o de uma institui��o')
            .AddParamPath('id_instituicao', 'id_instituicao')
              .Schema(SWAG_INTEGER)
            .&end
            .AddParamBody
              .Schema(TInstitution)
            .&End
            .AddParamHeader('Authorization', 'bearer token jwt')
              .Schema(SWAG_STRING)
          .&End
          .AddResponse(200)
            .Schema(TRegion)
          .&End
          .AddResponse(404, 'comunidade n�o encontrada')
            .Schema(TMessage)
          .&End
          .AddResponse(401, 'token n�o encontrado ou invalido')
            .Schema(SWAG_STRING)
          .&End
          .AddResponse(500, 'Internal Server Error')
          .&End
        .&End
      .&End
    .&End;

    Swagger
      .Path('instituicao/{id_instituicao}')
        .Tag('Institui��es')
        .Delete('deletar institui��o', 'deletar uma institui��o')
            .AddParamPath('id_instituicao', 'id_instituicao')
              .Schema(SWAG_INTEGER)
            .&end
            .AddParamHeader('Authorization', 'bearer token jwt')
              .Schema(SWAG_STRING)
          .&End
          .AddResponse(200, 'institui��o deletada com sucesso')
            .Schema(TMessage)
          .&End
          .AddResponse(404, 'institui��o n�o encontrada')
            .Schema(TMessage)
          .&End
          .AddResponse(401, 'token n�o encontrado ou invalido, n�o foi possivel deletar a institui��o')
            .Schema(SWAG_STRING)
          .&End
          .AddResponse(500, 'Internal Server Error')
          .&End
        .&End
      .&End
    .&End;
end;

end.