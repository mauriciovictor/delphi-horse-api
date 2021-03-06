unit RelatModel;

interface

uses connection, Ragna, System.JSON, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.ConsoleUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Phys.PG, FireDAC.Phys.PGDef, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, Horse, System.SysUtils, Dataset.serialize,
  System.Classes, System.NetEncoding, Soap.EncdDecd;

function FindRelatMonthYearProducersConsumerSale(mes_ano: string; regiao: integer; comunidade: integer ): TFDQuery;

implementation


function FindRelatMonthYearProducersConsumerSale(mes_ano: string; regiao: integer; comunidade: integer ): TFDQuery;
begin
  DMConnection :=  TDMConnection.Create(DMConnection);

  var Relat :TFDQuery;

  if comunidade = 0 then
    Relat := DMConnection.Relat_Mes_Prods_Consumo_Venda
  else
    Relat := DMConnection.Relat_Mes_Prods_Consumo_Venda2;


  Relat.paramByname('mes').AsString := mes_ano;
  Relat.paramByname('regiao').AsInteger := regiao;

  if comunidade > 0 then
    Relat.paramByname('comunidade').AsInteger := comunidade;

  Relat.open;

  Result := Relat;
end;

end.
