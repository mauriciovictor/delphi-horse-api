unit ProductionAreaController;

interface
uses System.SysUtils, Horse, System.Classes, Horse.Upload, Jsons, System.JSON, Horse.JWT,
  JOSE.Core.JWT, JOSE.Core.Builder,
  System.DateUtils,
  System.RegularExpressions, Ragna, Dataset.serialize,
  IdCustomHTTPServer,
  IdMultipartFormData, Web.HTTPApp, System.Math,
  Web.ReqMulti, IdHashMessageDigest,
  Soap.EncdDecd, Horse.Commons, IdGlobalProtocols;

procedure store(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure AreasProducer(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure foto(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure update(Req: THorseRequest; Res: THorseResponse; Next: Tproc);
procedure Destroy(Req: THorseRequest; Res: THorseResponse; Next: TProc);

type
  TMultipartContentParserAccess = class(TMultipartContentParser);

implementation

uses ProductionAreaModel, ProducerModel;

procedure foto(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin

try
    const id_area = strToInt(req.Params.Items['id_area']);
    const id_producer = strToInt(req.Params.Items['id_produtor']);
    const img = ProductionAreaModel.findAvatarByProducer(id_producer, id_area);
    img.Position := 0;

    Res.Status(THTTPStatus.OK);
    res.RawWebResponse.ContentType := 'image/png';
    Res.RawWebResponse.ContentStream := img;
    Res.RawWebResponse.SendResponse;
except
  on E:Exception do
   Writeln(E.Message);
end;

end;

procedure AreasProducer(Req: THorseRequest; Res: THorseResponse; Next: TProc);
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

   const producer_areas = ProductionAreaModel.findByProducer(producer_id);

   res.send(producer_areas.ToJsonArray).status(200);
end;

procedure update(Req: THorseRequest; Res: THorseResponse; Next: Tproc);
begin
   const id_produtor  = strToInt(req.Params.Items['id_produtor']);
   const produtor = ProducerModel.findByPK(id_produtor);

   if produtor.isEmpty() then
    begin
       res.send('{"message" : "produtor n?o existe" }').status(404);
       raise EHorseCallbackInterrupted.Create;
     end;

  const id = strToInt(req.Params.Items['id_area']);
  const area = ProductionAreaModel.findByPK(id);

  if area.IsEmpty then
    begin
      res.send('{"message" : "area n?o existe" }').status(404);
      raise EHorseCallbackInterrupted.Create;
    end;

  res.Send(ProductionAreaModel.update(id, Req.Body).ToJSONObject);
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

   body.Put('id_produtor', id_produtor);
   const productionArea = ProductionAreaModel.save(body.stringify);

   const area = TJson.create;
   area.put('id', strToInt(productionArea.toJsonObject.getValue('id').value));

   res.send(area.Stringify).Status(201);
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

  const id = strToInt(req.Params.Items['id_area']);
  const area = ProductionAreaModel.findByPK(id);

  if area.IsEmpty then
    begin
      res.send('{"message" : "area n?o existe" }').status(404);
      raise EHorseCallbackInterrupted.Create;
    end;

  if ProductionAreaModel.delete(id) then
    begin
      res.send('{"message" : "area deletada com sucesso" }').status(200);
      raise EHorseCallbackInterrupted.Create;
    end;

  res.send('{"message" : "n?o foi possivel deletar a area" }').status(401);
end;

end.
