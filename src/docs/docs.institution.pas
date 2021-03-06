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
        .Tag('Instituições')
        .GET('listar uma instituição', 'listar um instituição especifica')
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
          .AddResponse(404, 'instituição não encontrada')
            .Schema(TMessage)
          .&End
          .AddResponse(500, 'Internal Server Error')
          .&End
        .&End
      .&End
    .&End;

    Swagger
      .Path('instituicao')
        .Tag('Instituições')
        .GET('listar instituições com paginação', 'listagem de instituição com paginação e filtros')
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
        .Tag('Instituições')
        .Post('criar instiuição', 'criar uma nova instituição')
            .AddParamBody
              .Schema(TInstitution)
            .&End
            .AddParamHeader('Authorization', 'bearer token jwt')
              .Schema(SWAG_STRING)
          .&End
          .AddResponse(201)
            .Schema(TRegion)
          .&End
          .AddResponse(404, 'instituição não encontrada')
            .Schema(TMessage)
          .&End
          .AddResponse(401, 'token não encontrado ou invalido')
            .Schema(SWAG_STRING)
          .&End
          .AddResponse(500, 'Internal Server Error')
          .&End
        .&End
      .&End
    .&End;

    Swagger
      .Path('instituicao/{id_instituicao}')
        .Tag('Instituições')
        .Put('alterar instituição', 'alteração de uma instituição')
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
          .AddResponse(404, 'comunidade não encontrada')
            .Schema(TMessage)
          .&End
          .AddResponse(401, 'token não encontrado ou invalido')
            .Schema(SWAG_STRING)
          .&End
          .AddResponse(500, 'Internal Server Error')
          .&End
        .&End
      .&End
    .&End;

    Swagger
      .Path('instituicao/{id_instituicao}')
        .Tag('Instituições')
        .Delete('deletar instituição', 'deletar uma instituição')
            .AddParamPath('id_instituicao', 'id_instituicao')
              .Schema(SWAG_INTEGER)
            .&end
            .AddParamHeader('Authorization', 'bearer token jwt')
              .Schema(SWAG_STRING)
          .&End
          .AddResponse(200, 'instituição deletada com sucesso')
            .Schema(TMessage)
          .&End
          .AddResponse(404, 'instituição não encontrada')
            .Schema(TMessage)
          .&End
          .AddResponse(401, 'token não encontrado ou invalido, não foi possivel deletar a instituição')
            .Schema(SWAG_STRING)
          .&End
          .AddResponse(500, 'Internal Server Error')
          .&End
        .&End
      .&End
    .&End;
end;

end.
