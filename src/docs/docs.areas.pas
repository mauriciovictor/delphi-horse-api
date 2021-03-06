unit docs.areas;


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
      .Path('produtor/{id_produtor}/areas')
        .Tag('?reas de Produ??o')
        .GET('listar aras de produ??o de um produtor', 'listar aras de produ??o de um produtor')
            .AddParamPath('id_produtor', 'id_produtor')
              .Schema(SWAG_INTEGER)
              .Required(true)
            .&End
          .AddResponse(200)
            .Schema(TProductionArea)
            .isArray(true)
          .&End
          .AddResponse(404, 'produtor n?o encontrada')
            .Schema(TMessage)
          .&End
          .AddResponse(500, 'Internal Server Error')
          .&End
        .&End
      .&End
    .&End;

    Swagger
      .Path('produtor/{id_produtor}/areas/{id_area}/foto')
        .Tag('?reas de Produ??o')
        .GET('listar foto de uma ?rea de produ??o', 'listar foto de uma ?rea de produ??o')
            .AddParamPath('id_produtor', 'id_produtor')
              .Schema(SWAG_INTEGER)
              .required(true)
            .&End
            .AddParamPath('id_area', 'id_area')
              .Schema(SWAG_INTEGER)
              .required(true)
            .&End
          .AddResponse(200)
            .Schema('image/png')
          .&End
          .AddResponse(404, 'produtor n?o encontrada | ?rea n?o encontrada')
            .Schema(TMessage)
          .&End
          .AddResponse(500, 'Internal Server Error')
          .&End
        .&End
      .&End
    .&End;

    Swagger
      .Path('produtor/{id_produtor}/areas')
        .Tag('?reas de Produ??o')
        .Post('criar instiui??o', 'criar uma nova institui??o')
            .AddparamPath('id_produtor', 'id_produtor')
              .Schema(Swag_Integer)
            .&end
            .AddParamBody
              .Schema(TProductionArea)
            .&End
          .AddResponse(201)
            .Schema(TRegion)
          .&End
          .AddResponse(404, 'produtor n?o encontrado')
            .Schema(TMessage)
          .&End
          .AddResponse(500, 'Internal Server Error')
          .&End
        .&End
      .&End
    .&End;

    Swagger
      .Path('produtor/{id_produtor}/areas/{id_area}')
        .Tag('?reas de Produ??o')
        .Put('alterar uma a?rea de produ??o', 'alterar uma a?rea de produ??o')
            .AddParamPath('id_produtor', 'id_produtor')
              .Schema(SWAG_INTEGER)
            .&end
            .AddParamPath('id_area', 'id_area')
              .Schema(SWAG_INTEGER)
            .&end
            .AddParamBody
              .Schema(TProductionArea)
            .&End
          .AddResponse(200)
            .Schema(TRegion)
          .&End
          .AddResponse(404, 'produtor n?o encontrada | ?rea n?o encontrada')
            .Schema(TMessage)
          .&End
          .AddResponse(500, 'Internal Server Error')
          .&End
        .&End
      .&End
    .&End;

    Swagger
      .Path('produtor/{id_produtor}/areas/{id_area}')
        .Tag('?reas de Produ??o')
        .Delete('deletar area de produ??o', 'deletar area de produ??o')
            .AddParamPath('id_produtor', 'id_produtor')
              .Schema(SWAG_INTEGER)
            .&end
            .AddParamPath('id_area', 'id_area')
              .Schema(SWAG_INTEGER)
            .&end
          .AddResponse(200, 'institui??o deletada com sucesso')
            .Schema(TMessage)
          .&End
          .AddResponse(404, 'produtor n?o encontrada | ?rea n?o encontrada')
            .Schema(TMessage)
          .&End
          .AddResponse(500, 'Internal Server Error')
          .&End
        .&End
      .&End
    .&End;
end;
end.
