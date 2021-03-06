unit AvatarController;

interface

uses Horse, Horse.Upload, System.Json, System.Classes, System.NetEncoding,
     Dataset.serialize, Jsons, System.SysUtils, Soap.EncdDecd, Data.DB,
     System.Hash;

procedure update(Req: THorseRequest; Res: THorseResponse; Next: Tproc);
procedure show(Req: THorseRequest; Res: THorseResponse; Next: Tproc);

implementation

uses connection, UsuariosModel;

procedure show(Req: THorseRequest; Res: THorseResponse; Next: Tproc);
begin
  const id = req.Params.Items['id'];
  const img = UTF8Encode((UsuariosModel.findUserImage(StrToInt(id))));

  const ss = TStringStream.Create(img);
  const ms = TMemoryStream.Create;

  DecodeStream (ss, ms);

  Res.Send<TStream>(ms);
end;

procedure update(Req: THorseRequest; Res: THorseResponse; Next: Tproc);
var
  Buf: TBytes;
begin
  try
    const id = req.Params.Items['id'];
    var LUploadConfig: TUploadConfig;
    LUploadConfig := TUploadConfig.Create('C:\teste');
    LUploadConfig.ForceDir := True;
    LUploadConfig.OverrideFiles := false;

    var result := '';
    LUploadConfig.UploadFileCallBack :=
        procedure(Sender: TObject; AFile: TUploadFileInfo)
        begin
        Writeln(afile.base64);
          result :=  usuariosModel.UpdateAvatar(StrToInt(id), AFile.base64);
        end;

    Res.Send(LUploadConfig).Status(201);
  except
    on E:Exception do
      res.send('{message: Erro ao Alterar Imagem}').Status(401);
  end;
end;

end.
