unit GraficosGeralModel;

interface

uses connection, Ragna, System.JSON, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.ConsoleUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Phys.PG, FireDAC.Phys.PGDef, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, Horse, System.SysUtils, Dataset.serialize,
  System.Classes, System.NetEncoding, Soap.EncdDecd;

function findAll(ano: string; id: integer): TFDQuery;
function getYearsProduction(): TFDQuery;
function communityProduction(ano: string): TFDQuery;
function ResmeMinValuesInMonth(ano: string; mes: string; id: integer): TFDQuery;
function ResmeMaxValuesInMonth(ano: string; mes: string; id: integer): TFDQuery;

implementation

function getYearsProduction(): TFDQuery;
begin
  DMConnection :=  TDMConnection.Create(nil);
  const SQL_GERAL  = DMConnection.SQL_GERAL;

  SQL_GERAL.close;
  SQL_GERAL.sql.clear;
  SQL_GERAL.sql.add( ' select' );
  SQL_GERAL.sql.add( ' substring(cast(rp.data_producao as varchar), 1, 4) ano ' );
  SQL_GERAL.sql.add( ' from registro_producao rp  ');
  SQL_GERAL.sql.add( ' group by substring(cast(rp.data_producao as varchar), 1, 4)');

  SQL_GERAL.open;
  result := SQL_GERAL;
end;

function communityProduction(ano: string): TFDQuery;
begin
  DMConnection :=  TDMConnection.Create(nil);
  const SQL_GERAL  = DMConnection.SQL_GERAL;

  SQL_GERAL.sql.add( ' select ');
  SQL_GERAL.sql.add( ' c.id,');
  SQL_GERAL.sql.add( ' c.nome_comunidade,');
  SQL_GERAL.sql.add( ' substring(cast(rp.data_producao as varchar), 1, 4) ano');
  SQL_GERAL.sql.add( ' from ');
  SQL_GERAL.sql.add( ' registro_producao rp inner join');
  SQL_GERAL.sql.add( ' areas_producao ap on');
  SQL_GERAL.sql.add( ' rp.id_area_prod = ap.id inner join');
  SQL_GERAL.sql.add( ' produtores p on');
  SQL_GERAL.sql.add( ' p.id = ap.id_produtor inner join');
  SQL_GERAL.sql.add( ' comunidades c on');
  SQL_GERAL.sql.add( ' c.id  = p.id_comunidade');
  SQL_GERAL.sql.add( ' where substring(cast(rp.data_producao as varchar), 1, 4)= ' + QuotedStr(ano));
  SQL_GERAL.sql.add( ' group by ');
  SQL_GERAL.sql.add( ' substring(cast(rp.data_producao as varchar), 1, 4),');
  SQL_GERAL.sql.add( ' c.id,');
  SQL_GERAL.sql.add( ' c.nome_comunidade');

  SQL_GERAL.open;
  result := SQL_GERAL;
end;

function findAll(ano: string; id: integer): TFDQuery;
begin
  DMConnection :=  TDMConnection.Create(nil);
  const Graficos  = DMConnection.Grafico_geral;

  Graficos.ParamByName('id').AsInteger := id;
  Graficos.ParamByName('ano').AsString := ano;

  Graficos.openUp;
  Result := Graficos;
end;

function ResmeMinValuesInMonth(ano: string; mes: string; id: integer): TFDQuery;
begin
  DMConnection :=  TDMConnection.Create(nil);
  const Resume  = DMConnection.Resumo_venda_mes;

  Resume.ParamByName('id').AsInteger := id;
  Resume.ParamByName('ano').AsString := ano;
  Resume.ParamByName('mes').AsString := mes;

  Resume.openUp;
  Result := Resume;
end;

function ResmeMaxValuesInMonth(ano: string; mes: string; id: integer): TFDQuery;
begin
  DMConnection :=  TDMConnection.Create(nil);
  const Resume  = DMConnection.Max_Resumo_venda_mes;

  Resume.ParamByName('id').AsInteger := id;
  Resume.ParamByName('ano').AsString := ano;
  Resume.ParamByName('mes').AsString := mes;

  Resume.openUp;
  Result := Resume;
end;

end.
