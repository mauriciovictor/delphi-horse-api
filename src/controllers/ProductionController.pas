unit ProductionController;

interface
uses Horse, Jsons, System.JSON, Horse.JWT,
  JOSE.Core.JWT, JOSE.Core.Builder,
  System.DateUtils, System.SysUtils,
  System.RegularExpressions, Ragna, Dataset.serialize;

procedure store(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure ProductionProducer(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Destroy(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure index(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

uses ProducerController, ProducerModel, ProductionModel, ProductionAreaModel;


procedure index(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  const responseJson = TJson.Create();

  var area := '';
  var tp_prod := '';
  var data_inicio := '';
  var data_fim := '';

  if req.Query.ContainsKey('area') then
    area := req.Query.Items['area'];

  if req.Query.ContainsKey('tp_prod') then
    tp_prod := req.Query.Items['tp_prod'];

  if req.Query.ContainsKey('data_inicio') then
    data_inicio := req.Query.Items['data_inicio'];

  if req.Query.ContainsKey('data_fim') then
    data_fim := req.Query.Items['data_fim'];

  const id_produtor = strToInt(req.Params.Items['id_produtor']);

  var &total_pages := 0;
  var producers: TJSONArray;

  var page :=  0;
  var limit := 0;

  if ((req.Query.ContainsKey('page')) and ( req.Query.ContainsKey('limit') )) then
   begin
     page := strToInt(req.Query.Items['page']);
     limit := strToInt(req.Query.Items['limit']);

     producers := ProductionModel
     .findAll(page, limit, id_produtor, tp_prod, area,data_inicio, data_fim, total_pages)
     .ToJSONArray;

      responseJson['data'].Parse(producers.ToJSON);

      with responseJson['pagination'].AsObject do
        begin
          Put('total_pages', &total_pages);
          Put('current_page', page);
        end;
   end
  else
    begin
        producers := ProductionModel
       .findAll(
          tp_prod, area,
          data_inicio, id_produtor, data_fim, total_pages)
       .ToJSONArray;

      responseJson.Parse(producers.ToJSON);
    end;

  res.Send(responseJson.Stringify);
end;


procedure ProductionProducer(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin

   if not req.params.containsKey('id_produtor') then
    begin
       res.send('{"message" : "id ? obrigatorio" }').status(401);
       raise EHorseCallbackInterrupted.Create;
    end;

   const producer_id = strToInt(req.params.items['id_produtor']);

   const produtor = ProducerModel.findByPK(producer_id);

   if produtor.isEmpty() then
    begin
       res.send('{"message" : "produtor n?o existe" }').status(404);
       raise EHorseCallbackInterrupted.Create;
     end;

   const areas_production = ProductionAreaModel.findByProducer(producer_id);

   const data = TJson.Create;

   areas_production.First;
   while not areas_production.Eof do
    begin
         var production :=
          ProductionModel
          .findByProducerArea(areas_production.FieldByName('id').asInteger);

         if not production.IsEmpty then
          begin
            production.first;

            while not production.eof do
              begin

                with data['registro'].AsArray do
                  begin
                    const register = TJSON.Create;
                    register.Parse(production.toJsonObject.tostring);

                    register['register'].AsObject.Parse(production.toJsonObject.tostring);
                    Put(register['register'].AsObject);
                  end;

                production.next;
              end;

          end;

         areas_production.next;
    end;
   res.send(data['registro'].Stringify).status(200);
end;

procedure store(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
   const body = TJSon.Create;
   body.parse(req.body);

   const id_produtor  = strToInt(req.Params.Items['id_produtor']);
   const produtor = ProducerModel.findByPK(id_produtor);

   if produtor.isEmpty() then
    begin
       res.send('{"message" : "produtor n?o existe" }').status(404);
       raise EHorseCallbackInterrupted.Create;
    end;

   const id_area = strToInt(req.Params.Items['id_area']);
   const area = ProductionAreaModel.findByPkAndProducer(id_area, id_produtor);

   if area.IsEmpty then
    begin
      res.send('{"message" : "area n?o existe" }').status(404);
      raise EHorseCallbackInterrupted.Create;
    end;

   body.Put('id_area_prod', id_area);
   const production = ProductionModel.save(body.Stringify);

   const production_area = TJson.create;
   production_area.put('id', strToInt(production.toJsonObject.getValue('id').value));

   res.send(production_area.stringify).Status(201);
end;

procedure update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
   const body = TJSon.Create;
   body.parse(req.body);

   const id_produtor  = strToInt(req.Params.Items['id_produtor']);
   const produtor = ProducerModel.findByPK(id_produtor);

   if produtor.isEmpty() then
    begin
       res.send('{"message" : "produtor n?o existe" }').status(404);
       raise EHorseCallbackInterrupted.Create;
    end;

   const id_area = strToInt(req.Params.Items['id_area']);
   const area = ProductionAreaModel.findByPK(id_area);

   if area.IsEmpty then
    begin
      res.send('{"message" : "area n?o existe" }').status(404);
      raise EHorseCallbackInterrupted.Create;
    end;

   const id = strToInt(req.Params.Items['id']);
   const appointment = ProductionModel.findByPk(id);

   if appointment.IsEmpty then
    begin
      res.send('{"message" : "registro de produ??o  n?o existe" }').status(404);
      raise EHorseCallbackInterrupted.Create;
    end;

   const production = ProductionModel.update(id, body.Stringify);
   res.send(production.ToJSONObject);
end;

procedure Destroy(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
      const id_produtor  = strToInt(req.Params.Items['id_produtor']);
   const produtor = ProducerModel.findByPK(id_produtor);

   if produtor.isEmpty() then
    begin
       res.send('{"message" : "produtor n?o existe" }').status(404);
       raise EHorseCallbackInterrupted.Create;
    end;

   const id_area = strToInt(req.Params.Items['id_area']);
   const area = ProductionAreaModel.findByPK(id_area);

   if area.IsEmpty then
    begin
      res.send('{"message" : "area n?o existe" }').status(404);
      raise EHorseCallbackInterrupted.Create;
    end;

   const id = strToInt(req.Params.Items['id']);
   const appointment = ProductionModel.findByPk(id);

   if appointment.IsEmpty then
    begin
      res.send('{"message" : "registro de produ??o  n?o existe" }').status(404);
      raise EHorseCallbackInterrupted.Create;
    end;

  if ProductionModel.delete(id) then
    begin
      res.send('{"message" : "registro de produ??o deletada com sucesso" }').status(200);
      raise EHorseCallbackInterrupted.Create;
    end;

  res.send('{"message" : "n?o foi possivel deletar o registro de produ??o" }').status(401);
end;

end.
