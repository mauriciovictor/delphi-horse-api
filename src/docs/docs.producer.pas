unit docs.producer;

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
      .Path('produtor/cpf')
        .Tag('Produtor')
        .get('verificar cpf', 'verificar se o cpf j? existe')
            .AddParamQuery('cpf', 'cpd do produtor')
              .Schema(SWAG_STRING)
            .&End
          .AddResponse(200, 'retorno os dados do produtor')
            .Schema(TProducerDetails)
          .&End
          .AddResponse(404, 'cpf n?o encontrado')
            .Schema(TMessage)
          .&End
          .AddResponse(401, 'cpf n?o pertence a nenhum produtor')
            .Schema(TMessage)
          .&End
          .AddResponse(500, 'Internal Server Error')
          .&End
        .&End
      .&End
    .&End;

    Swagger
      .Path('produtor/{id_produtor}')
        .Tag('Produtor')
        .get('produtor detalhado', 'cadastro detalhado do produtor')
            .AddParamPath('id_produtor', 'id_produtor')
              .Schema(SWAG_INTEGER)
            .&End
          .AddResponse(200, 'retorno os dados do produtor')
            .Schema(TProducerDetails)
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
      .Path('produtor')
        .Tag('Produtor')
        .get('produtores com pagina??o', 'produtores com pagina??o e filtros')
            .AddParamQuery('page', 'page')
              .Schema(SWAG_INTEGER)
            .&End
            .AddParamQuery('limit', 'limit')
              .Schema(SWAG_INTEGER)
            .&End
            .AddParamQuery('produtor', 'nome produtor')
              .Schema(SWAG_STRING)
            .&End
            .AddParamQuery('cpf', 'cpf')
              .Schema(SWAG_STRING)
            .&End
            .AddParamQuery('regiao', 'ID_regiao')
              .Schema(SWAG_INTEGER)
            .&End
            .AddParamQuery('comunidade', 'id_comunidade')
              .Schema(SWAG_INTEGER)
            .&End
            .AddParamQuery('instituicao', 'id_instituicao')
              .Schema(SWAG_INTEGER)
            .&End
          .AddResponse(200, 'retorno os dados do produtor')
            .Schema(TProducerREsume)
            .isArray(true)
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
      .Path('produtor')
        .Tag('Produtor')
        .Post('criar novo produtor', 'adicionar um novo produtor')
          .AddParamBody
            .Schema(TUserProducer)
          .&End
          .AddResponse(201, 'retorno os dados do produtor cadastrado')
            .Schema(TUserProducer)
          .&End
          .AddResponse(401, 'erro ao gravar o produtor | cpf j? existe')
            .Schema(TMessage)
          .&End
          .AddResponse(500, 'Internal Server Error')
          .&End
        .&End
      .&End
    .&End;

    Swagger
      .Path('produtor/{id_produtor}')
        .Tag('Produtor')
        .put('alterar produtor', 'alterar produtor')
          .AddParamPath('id_produtor', 'id_produtor')
            .Schema(SWAG_INTEGER)
          .&End
          .AddParamBody
            .Schema(TUserProducer)
          .&End
          .AddResponse(201, 'retorno os dados do produtor')
            .Schema(TUserProducer)
          .&End
          .AddResponse(401, 'erro ao gravar o produtor | cpf j? existe')
            .Schema(TMessage)
          .&End
          .AddResponse(500, 'Internal Server Error')
          .&End
        .&End
      .&End
    .&End;
end;

end.
