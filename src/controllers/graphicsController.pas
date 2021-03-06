unit graphicsController;

interface

uses
  Horse, Jsons, System.JSON, Horse.JWT,
  JOSE.Core.JWT, JOSE.Core.Builder,
  System.DateUtils, System.SysUtils,
  System.RegularExpressions, Ragna, Dataset.serialize;

procedure dataSales(Req: THorseRequest; Res: THorseResponse; Next: Tproc);
procedure yearsProduction(Req: THorseRequest; Res: THorseResponse; Next: Tproc);
procedure communityProduction(Req: THorseRequest; Res: THorseResponse; Next: Tproc);

implementation

uses GraficosGeralModel;


procedure communityProduction(Req: THorseRequest; Res: THorseResponse; Next: Tproc);
begin
  const ano = req.Query.Items['ano'];
  var json := TJson.Create;

  var years := GraficosGeralModel.communityProduction(ano);

  years.first;
  while not years.eof do
    begin
      var community :=  Tjson.Create;

     community['teste'].AsObject.Put('id', years.fieldByName('id').AsInteger);
     community['teste'].AsObject.Put('nome', years.fieldByName('nome_comunidade').AsString);

     json['comunidades'].AsArray.Put(community['teste']);
     years.next;
    end;

  Res.Send(json['comunidades'].Stringify);
end;

procedure yearsProduction(Req: THorseRequest; Res: THorseResponse; Next: Tproc);
begin
  var json := TJson.Create;

  var years := GraficosGeralModel.getYearsProduction();

  with json['Data'].AsArray do
    begin
     Put(years.fieldByName('ano').AsString);
    end;

  Res.Send(json.Stringify);

end;

procedure dataSales(Req: THorseRequest; Res: THorseResponse; Next: Tproc);
begin

  const jsonData = TJson.Create;

  const id = strToInt(req.Query.Items['id']);
  const ano = req.Query.Items['ano'];

  const graficos = GraficosGeralModel.findAll(ano, id);
  const monthYear = '07-2021';

  var tot_geral := 0.0;

  var months := [
    'Janeiro', 'Feveiro', 'Mar?o',
    'Abril', 'Maio', 'Junho',
    'Julho', 'Agosto', 'Setembro',
    'Outubro', 'Novembro', 'Dezembro'
  ];

  var data := [
    0.0, 0.0,0.0,
    0.0, 0.0, 0.0,
    0.0, 0.0, 0.0,
    0.0, 0.0, 0.0
  ];

  var values :=  [
    0.0, 0.0,0.0,
    0.0, 0.0, 0.0,
    0.0, 0.0, 0.0,
    0.0, 0.0, 0.0
  ];

  var min_values_of_sale :=  [
    0.0, 0.0,0.0,
    0.0, 0.0, 0.0,
    0.0, 0.0, 0.0,
    0.0, 0.0, 0.0
  ];

  var max_values_of_sale :=  [
    0.0, 0.0,0.0,
    0.0, 0.0, 0.0,
    0.0, 0.0, 0.0,
    0.0, 0.0, 0.0
  ];

  var consumer := jsonData['Consumer'];
  var sale := jsonData['Venda'];

  var averageSale := jsonData['Venda_Media'];
  var min_sale := jsonData['min_sale'];
  var max_sale := jsonData['max_sale'];

  var curr_tipo_prod := '';
  var count := 1;

  var current := jsonData['data'];

  var countRecord := graficos.recordCount;
  var countRegister := 1;

  var quant_tot_consumer := 0.0;
  var quant_tot_sale := 0.0;

  var nome_comunidade := '';
  var tot_produtores_aponta := 0;
  var tot_produtores := 0;

  var min_value := 10000.0;
  var max_value := 0.0;
  var months_min_value := '';
  var months_max_value := '';

  graficos.first;
  while not graficos.eof do
    begin
      var tipo_prod := graficos.fieldByName('tipo_prod' ).AsString;
      if count = 1 then
        begin
           nome_comunidade := graficos.fieldByName('nome_comunidade' ).AsString;
           tot_produtores_aponta := graficos.fieldByName('tot_produtores_aponta' ).asInteger;
           tot_produtores := graficos.fieldByName('tot_produtores' ).asInteger;
           curr_tipo_prod := graficos.fieldByName('tipo_prod' ).AsString;
           count := count + 1;
        end;

      if graficos.fieldByName('tipo_prod' ).AsString = 'C' then
        begin
             current := consumer;
             quant_tot_consumer := quant_tot_consumer +
              graficos.fieldByName('quant_total').AsFloat;
        end
      else
        begin
             current := sale;
             quant_tot_sale := quant_tot_sale +
              graficos.fieldByName('quant_total').AsFloat;
        end;

      if ((min_value > graficos.fieldByName('menor_valor' ).AsFloat) and(tipo_prod = 'V')) then
        begin
          min_value := graficos.fieldByName('menor_valor' ).AsFloat;
          months_min_value := graficos.fieldByName('mes').AsString;
        end
      else if ((min_value = graficos.fieldByName('menor_valor' ).AsFloat) and(tipo_prod = 'V')) then
        begin
          months_min_value := months_min_value + ',' + graficos.fieldByName('mes' ).AsString;
        end;

      if ((max_value < graficos.fieldByName('maior_valor' ).AsFloat) and(tipo_prod = 'V')) then
        begin
          max_value := graficos.fieldByName('maior_valor' ).AsFloat;
          months_max_value := graficos.fieldByName('mes' ).AsString;
        end
      else if ((max_value = graficos.fieldByName('maior_valor' ).AsFloat) and(tipo_prod = 'V')) then
        begin
          months_max_value := months_max_value+ ','+ graficos.fieldByName('mes' ).AsString;
        end;

      if curr_tipo_prod <> graficos.fieldByName('tipo_prod' ).AsString  then
        begin
          for var i := Low(months) to High(months) do
            consumer.AsObject['labels'].AsArray.Put(months[i]);

          for var i := Low(data) to High(data) do
            consumer.AsObject['data'].AsArray.Put(data[i]);

          curr_tipo_prod :=  graficos.fieldByName('tipo_prod' ).AsString;

          data := [
            0.0, 0.0,0.0,
            0.0, 0.0, 0.0,
            0.0, 0.0, 0.0,
            0.0, 0.0, 0.0
          ];

        end;

      for var i := Low(months) to High(months) do
        begin
         if graficos.fieldByname('mes_extenso').AsString = months[i] then
          begin
            data[i] := graficos.fieldByname('quant_total').AsFloat;
            if curr_tipo_prod = 'V' then
              begin
                min_values_of_sale[i] := graficos.fieldByname('menor_valor').AsFloat;
                max_values_of_sale[i] := graficos.fieldByname('maior_valor').AsFloat;
              end;
          end;
        end;

//      current.AsObject['labels'].AsArray.put();
      if countRecord = countRegister then
        begin
          for var i := Low(months) to High(months) do
             begin
                sale.AsObject['labels'].AsArray.Put(months[i]);
                averageSale.AsObject['labels'].AsArray.Put(months[i]);
             end;

          for var i := Low(data) to High(data) do
             begin
                sale.AsObject['data'].AsArray.Put(data[i]);
             end;

          for var i := Low(min_values_of_sale) to High(min_values_of_sale) do
             begin
                min_sale.AsObject['data'].AsArray.Put(min_values_of_sale[i]);
             end;

          for var i := Low(max_values_of_sale) to High(max_values_of_sale) do
             begin
                max_sale.AsObject['data'].AsArray.Put(max_values_of_sale[i]);
             end;


           for var i := Low(values) to High(values) do
             begin
                averageSale.AsObject['data'].AsArray.Put(values[i]);
             end;
        end;

      countRegister := countRegister + 1;
      graficos.next;
    end;

  tot_geral := quant_tot_sale + quant_tot_consumer;

  var percentage_consumer :=  (quant_tot_consumer * 100)/ tot_geral;
  var percentage_sale :=  (quant_tot_sale * 100)/ tot_geral;

  var json := TJson.Create;
  json['comunidade'].AsObject.Put('comunidade', nome_comunidade);

  json['produtores'].AsObject.Put('tot_prod_aponta', tot_produtores_aponta);
  json['produtores'].AsObject.Put('tot_prod', tot_produtores);

  json['Consumer'].Parse(consumer.Stringify);
  json['Sale'].Parse(sale.Stringify);
  json['Average_Sale'].Parse(averageSale.Stringify);

  json.Put('tot_consumer', percentage_consumer);
  json.Put('tot_sale', percentage_sale);

  json['max_values'].Parse(max_sale.Stringify);
  json['min_values'].parse(min_sale.Stringify);

  var monthsSplited := TRegEx.split(months_min_value, ',');

  var min_quant_total := 0.0;
  var min_value_total := 0.0;

  for var I := Low(monthsSplited) to High(monthsSplited) do
    begin
      var resumeMinValue := GraficosGeralModel
        .ResmeMinValuesInMonth(ano, monthsSplited[I], id);

       min_quant_total := min_quant_total + resumeMinValue.fieldByName('quant_total').AsFloat;
       min_value_total := min_value_total + resumeMinValue.fieldByName('valor_total').AsFloat;
    end;

  var monthsMaxSplited := TRegEx.split(months_max_value, ',');
  var max_quant_total := 0.0;
  var max_value_total := 0.0;

  for var I := Low(monthsMaxSplited) to High(monthsMaxSplited) do
    begin
      var resumeMinValue := GraficosGeralModel
        .ResmeMaxValuesInMonth(ano, monthsMaxSplited[I], id);

       max_quant_total := max_quant_total + resumeMinValue.fieldByName('quant_total').AsFloat;
       max_value_total := max_value_total + resumeMinValue.fieldByName('valor_total').AsFloat;
    end;

  json['months_min_vulue'].AsObject.put('months', months_min_value);
  json['months_min_vulue'].AsObject.put('value', min_value);
  json['months_min_vulue'].AsObject.put('quant_total',min_quant_total);
  json['months_min_vulue'].AsObject.put('valor_total',min_value_total);

  json['months_max_vulue'].AsObject.put('months', months_max_value);
  json['months_max_vulue'].AsObject.put('value', max_value);
  json['months_max_vulue'].AsObject.put('quant_total', max_quant_total);
  json['months_max_vulue'].AsObject.put('valor_total', max_value_total);

  Res.Send(json.Stringify);
end;

end.
