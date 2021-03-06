unit docs.community;

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
      .Path('comunidade/{id_comunidade}')
        .Tag('Comunidades')
        .GET('listar uma comunidade', 'listar comunidade especifica')
            .AddParamPath('id_Comunidade', 'id_comunidade')
              .Schema(SWAG_INTEGER)
              .Required(true)
            .&End
            .AddParamHeader('Authorization', 'bearer token jwt')
              .Schema(SWAG_STRING)
          .&End
          .AddResponse(200)
            .Schema(TCommunity)
          .&End
          .AddResponse(404, 'comunidade n?o encontrada')
            .Schema(TMessage)
          .&End
          .AddResponse(500, 'Internal Server Error')
          .&End
        .&End
      .&End
    .&End;

    Swagger
      .Path('comunidade')
        .Tag('Comunidades')
        .GET('listar regi?es com pagina??o', 'listagem de comunidades com pagina??o e filtros')
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
            .Schema(TCommunityPagination)
          .&End
          .AddResponse(500, 'Internal Server Error')
          .&End
        .&End
      .&End
    .&End;

    Swagger
      .Path('comunidade')
        .Tag('Comunidades')
        .Post('criar comunidade', 'criar uma nova comunidade')
            .AddParamBody
              .Schema(TRegion)
            .&End
            .AddParamHeader('Authorization', 'bearer token jwt')
              .Schema(SWAG_STRING)
          .&End
          .AddResponse(201)
            .Schema(TCommunity)
          .&End
          .AddResponse(404, 'regi?o n?o encontrada')
            .Schema(TMessage)
          .&End
          .AddResponse(401, 'token n?o encontrado ou invalido')
            .Schema(SWAG_STRING)
          .&End
          .AddResponse(500, 'Internal Server Error')
          .&End
        .&End
      .&End
    .&End;

    Swagger
      .Path('comunidade/{id_comunidade}')
        .Tag('Comunidades')
        .Put('alterar comunidade', 'altera??o de uma comunidade')
            .AddParamPath('id_comunidade', 'id_comunidade')
              .Schema(SWAG_INTEGER)
            .&end
            .AddParamBody
              .Schema(TCommunity)
            .&End
            .AddParamHeader('Authorization', 'bearer token jwt')
              .Schema(SWAG_STRING)
          .&End
          .AddResponse(200)
            .Schema(TRegion)
          .&End
          .AddResponse(404, 'comunidade n?o encontrada')
            .Schema(TMessage)
          .&End
          .AddResponse(401, 'token n?o encontrado ou invalido')
            .Schema(SWAG_STRING)
          .&End
          .AddResponse(500, 'Internal Server Error')
          .&End
        .&End
      .&End
    .&End;

    Swagger
      .Path('comunidade/{id_comunidade}')
        .Tag('Comunidades')
        .Delete('deletar comunidade', 'deletar uma comunidade')
            .AddParamPath('id_comunidade', 'id_comunidade')
              .Schema(SWAG_INTEGER)
            .&end
            .AddParamHeader('Authorization', 'bearer token jwt')
              .Schema(SWAG_STRING)
          .&End
          .AddResponse(200, 'comunidade deletada com sucesso')
            .Schema(TMessage)
          .&End
          .AddResponse(404, 'comunidade n?o encontrada')
            .Schema(TMessage)
          .&End
          .AddResponse(401, 'token n?o encontrado ou invalido, n?o foi possivel deletar a comunidade')
            .Schema(SWAG_STRING)
          .&End
          .AddResponse(500, 'Internal Server Error')
          .&End
        .&End
      .&End
    .&End;
end;

end.
