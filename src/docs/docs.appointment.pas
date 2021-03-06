unit docs.appointment;


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
      .Path('produtor/{id_produtor}/apontamento')
        .Tag('Registro de produ??o')
        .GET('listar todo o registro de produ??o com filtros ', 'listar todo o registro de produ??o com filtros')
            .Description('o filtro de data ser? aplicado somente se data_fim e data_inicio forem preenchidos' +
            '<br/> a pagina??o s? ser? aplicada se os parametros page e limit forem inseridos')
            .AddParamPath('id_produtor', 'id_produtor')
              .Schema(SWAG_INTEGER)
              .Required(true)
            .&End
            .AddParamQuery('page', 'page')
              .Schema(SWAG_INTEGER)
            .&End
            .AddParamQuery('limit', 'limit')
              .Schema(SWAG_INTEGER)
            .&End
            .AddParamQuery('area', 'area')
              .Schema(SWAG_Integer)
              .required(false)
            .&end
            .AddParamQuery('tp_prod', 'tp_prod')
              .Schema(SWAG_STRING)
              .required(false)
            .&end
            .AddParamQuery('data_inicio', 'data_inicio')
              .Schema(SWAG_STRING)
              .required(false)
            .&end
            .AddParamQuery('data_fim', 'data_fim')
              .Schema(SWAG_STRING)
              .required(false)
            .&end
          .AddResponse(200)
            .Schema(TAppointmentPagination)
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
      .Path('produtor/{id_produtor}/apontamento')
        .Tag('Registro de produ??o')
        .Post('criar registro de produ??o', 'criar registro de produ??o')
            .AddParamBody
              .Schema(TAppointment)
            .&End
          .AddResponse(201)
            .Schema(TAppointment)
          .&End
          .AddResponse(404, 'produtor n?o encontrado')
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
      .Path('produtor/{id_produtor}/apontamento/{id_apontamento}')
        .Tag('Registro de produ??o')
        .Put('alterar ?rea de produ??o', 'alterar ?rea de produ??o')
            .AddParamPath('id_produtor', 'id_produtor')
              .Schema(SWAG_INTEGER)
            .&end
            .AddParamPath('id_apontamento', 'id_apontamento')
              .Schema(SWAG_INTEGER)
            .&end
            .AddParamBody
              .Schema(TAppointment)
            .&End
          .AddResponse(200)
            .Schema(TRegion)
          .&End
          .AddResponse(404, 'produtor n?o encontrada | apontamento n?o enctrado')
            .Schema(TMessage)
          .&End
          .AddResponse(500, 'Internal Server Error')
          .&End
        .&End
      .&End
    .&End;

    Swagger
      .Path('produtor/{id_produtor}/apontamento/{id_apontamento}')
        .Tag('Registro de produ??o')
        .Delete('deletar institui??o', 'deletar uma institui??o')
            .AddParamPath('id_produtor', 'id_produtor')
              .Schema(SWAG_INTEGER)
            .&end
            .AddParamPath('id_apontamento', 'id_apontamento')
              .Schema(SWAG_INTEGER)
            .&end
          .AddResponse(200, 'registro de produ??o deletada com sucesso')
            .Schema(TMessage)
          .&End
          .AddResponse(404, 'produtor n?o encontrada | registro de produ??o n?o encontrada')
            .Schema(TMessage)
          .&End
          .AddResponse(500, 'Internal Server Error')
          .&End
        .&End
      .&End
    .&End;
end;

end.
