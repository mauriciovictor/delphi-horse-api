unit docs.unity;
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
      .Path('unidades/{id_unidade}')
        .Tag('Unidades Medidas')
        .GET('listar uma unidade medida', 'listar unidade de medida especifica')
            .AddParamPath('id_unidade', 'id_unidade')
              .Schema(SWAG_INTEGER)
              .Required(true)
            .&End
            .AddParamHeader('Authorization', 'bearer token jwt')
              .Schema(SWAG_STRING)
          .&End
          .AddResponse(200)
            .Schema(TUnityPagination)
          .&End
          .AddResponse(404, 'unidade não encontrada')
            .Schema(TMessage)
          .&End
          .AddResponse(500, 'Internal Server Error')
          .&End
        .&End
      .&End
    .&End;

    Swagger
      .Path('unidades')
        .Tag('Unidades Medidas')
        .GET('listar unidade medidades com paginação', 'listagem de unidade medidas com paginação e filtros')
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
            .Schema(TUnity)
          .&End
          .AddResponse(500, 'Internal Server Error')
          .&End
        .&End
      .&End
    .&End;

    Swagger
      .Path('unidades')
        .Tag('Unidades Medidas')
        .Post('criar unidade', 'criar uma nova unidade medidads')
            .AddParamBody
              .Schema(TUnity)
            .&End
            .AddParamHeader('Authorization', 'bearer token jwt')
              .Schema(SWAG_STRING)
          .&End
          .AddResponse(201)
            .Schema(TUnity)
          .&End
          .AddResponse(404, 'unidade medida não encontrada')
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
      .Path('unidades/{id_unidade}')
        .Tag('Unidades Medidas')
        .Put('alterar unidade medida ', 'alteração de uma unidades medida')
            .AddParamPath('id_unidade', 'id_unidade')
              .Schema(SWAG_INTEGER)
            .&end
            .AddParamBody
              .Schema(TUnity)
            .&End
            .AddParamHeader('Authorization', 'bearer token jwt')
              .Schema(SWAG_STRING)
          .&End
          .AddResponse(200)
            .Schema(TRegion)
          .&End
          .AddResponse(404, 'unidade de medida não encontrada')
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
      .Path('unidades/{id_unidade}')
        .Tag('Unidades Medidas')
        .Delete('deletar unidade medida ', 'deletar uma unidade medida')
            .AddParamPath('id_unidade', 'id_unidade')
              .Schema(SWAG_INTEGER)
            .&end
            .AddParamHeader('Authorization', 'bearer token jwt')
              .Schema(SWAG_STRING)
          .&End
          .AddResponse(200, 'unidade medida deletada com sucesso')
            .Schema(TMessage)
          .&End
          .AddResponse(404, 'unidade não encontrada')
            .Schema(TMessage)
          .&End
          .AddResponse(401, 'token não encontrado ou invalido, não foi possivel deletar a comunidade')
            .Schema(SWAG_STRING)
          .&End
          .AddResponse(500, 'Internal Server Error')
          .&End
        .&End
      .&End
    .&End;
end;
end.
