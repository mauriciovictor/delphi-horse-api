unit docs.graphics;

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
      .Path('graficos/anos')
        .Tag('Graficos')
        .get('anos que possuem registro de produ??o', 'anos que possuem registro de produ??o')
          .AddResponse(200)
            .Schema(TGraphicsYear)
          .&End
          .AddResponse(500, 'Internal Server Error')
          .&End
        .&End
      .&End
    .&End;

    Swagger
      .Path('graficos/comunidades')
        .Tag('Graficos')
        .get('comunidade que tem registro de produ??o', 'comunidade que tem registro de produ??o em determinado ano')
          .AddParamQuery('ano', 'ano')
            .Schema(SWAG_STRING)
          .&End
          .AddResponse(200)
            .Schema(TGraphicCommunity)
            .isArray(true)
          .&End
          .AddResponse(500, 'Internal Server Error')
          .&End
        .&End
      .&End
    .&End;
end;

end.
