unit RelatController;

interface

uses Horse, Jsons, System.JSON, Horse.JWT,
  JOSE.Core.JWT, JOSE.Core.Builder,
  System.DateUtils, System.SysUtils,
  System.RegularExpressions, Ragna, Dataset.serialize;

procedure RelatMonthYearProducersProducerSale(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

uses RelatModel;

procedure RelatMonthYearProducersProducerSale(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  if not req.Query.ContainsKey('mes_ano') then
    begin
       res.send('{"message" : "Parametro mes_ano não pode ser vazio" }').status(401);
       raise EHorseCallbackInterrupted.Create;
    end;

  const mes_ano = req.query.Items['mes_ano'];
  const regiao = strToInt(req.query.Items['regiao']);

  var comunidade := 0;

  if req.Query.ContainsKey('comunidade') then
    comunidade := strToInt(req.Query.Items['comunidade']);

  const relat = RelatModel
    .FindRelatMonthYearProducersConsumerSale(
      mes_ano,
      regiao,
      comunidade
    );


  res.Send(relat.ToJSONArray);

end;

end.
