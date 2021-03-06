unit docs.reports;

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
      .Path('relat/produtores')
        .Tag('Relatorios')
        .Post('autenti??o api', 'autentica??o api')
            .AddParamQuery('mes_ano', 'mes_ano')
             .Schema(SWAG_STRING)
            .&End
            .AddParamQuery('regiao', 'id_regiao')
             .Schema(SWAG_INTEGER)
            .&End
            .AddParamQuery('comunidade', 'id_comunidade')
             .Schema(SWAG_INTEGER)
            .&End
            .AddParamHeader('Authorization', 'Authorization')
              .Schema(TToken)
            .&End
          .AddResponse(200)
            .Schema(TReportRegion)
            .isArray(true)
          .&End
          .AddResponse(401, 'token n?o encontrado ou invalido')
            .Schema(SWAG_STRing)
          .&End
          .AddResponse(500, 'Internal Server Error')
          .&End
        .&End
      .&End
    .&End;
end;

end.
