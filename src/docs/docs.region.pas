unit docs.region;

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
      .Path('regiao/{id_regiao}')
        .Tag('Regi?es de atendimento')
        .GET('listar uma regi?o', 'listar regi?o especifica')
            .AddParamPath('id_regiao', 'id_regiao')
              .Schema(SWAG_INTEGER)
              .Required(true)
            .&End
            .AddParamHeader('Authorization', 'bearer token jwt')
              .Schema(SWAG_STRING)
          .&End
          .AddResponse(200)
            .Schema(TRegion)
          .&End
          .AddResponse(404, 'regi?o n?o encontrada')
            .Schema(TMessage)
          .&End
          .AddResponse(500, 'Internal Server Error')
          .&End
        .&End
      .&End
    .&End;

    Swagger
      .Path('regiao')
        .Tag('Regi?es de atendimento')
        .GET('listar regi?es com pagina??o', 'listagem de reg?es com pagina??o e filtros')
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
            .Schema(TRegionPagination)
            .isArray(true)
          .&End
          .AddResponse(500, 'Internal Server Error')
          .&End
        .&End
      .&End
    .&End;

    Swagger
      .Path('regiao/all')
        .Tag('Regi?es de atendimento')
        .GET('listar todas as regi?es', 'listagem de reg?es sem pagina??o e filtros')
          .Description('lista todas as regi?o sem nenhum criterio')
          .AddResponse(200)
            .Schema(TRegion)
            .isArray(true)
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
      .Path('regiao')
        .Tag('Regi?es de atendimento')
        .Post('criar regi?o', 'criar uma nova regi?o')
            .AddParamBody
              .Schema(TRegion)
            .&End
            .AddParamHeader('Authorization', 'bearer token jwt')
              .Schema(SWAG_STRING)
          .&End
          .AddResponse(201)
            .Schema(TRegion)
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
      .Path('regiao/{id_regiao}')
        .Tag('Regi?es de atendimento')
        .Put('alterar regi?o', 'altera??o de uma regi?o')
            .AddParamPath('id_regiao', 'id_regiao')
              .Schema(SWAG_INTEGER)
            .&end
            .AddParamBody
              .Schema(TRegion)
            .&End
            .AddParamHeader('Authorization', 'bearer token jwt')
              .Schema(SWAG_STRING)
          .&End
          .AddResponse(200)
            .Schema(TRegion)
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
      .Path('regiao/{id_regiao}')
        .Tag('Regi?es de atendimento')
        .Delete('deletar regi?o', 'deletar uma regi?o')
            .AddParamPath('id_regiao', 'id_regiao')
              .Schema(SWAG_INTEGER)
            .&end
            .AddParamHeader('Authorization', 'bearer token jwt')
              .Schema(SWAG_STRING)
          .&End
          .AddResponse(200, 'regi?o deletada com sucesso')
            .Schema(TMessage)
          .&End
          .AddResponse(404, 'regi?o n?o encontrada')
            .Schema(TMessage)
          .&End
          .AddResponse(401, 'token n?o encontrado ou invalido, n?o foi possivel deletar a regi?o')
            .Schema(SWAG_STRING)
          .&End
          .AddResponse(500, 'Internal Server Error')
          .&End
        .&End
      .&End
    .&End;
end;

end.
