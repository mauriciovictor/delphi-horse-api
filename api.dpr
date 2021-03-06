program api;

{$APPTYPE CONSOLE}

{$R *.res}
uses
  System.SysUtils,
  Dataset.serialize,
  DataSet.Serialize.Language,
  DataSet.Serialize.Config,
  Horse,
  Horse.OctetStream,
  Horse.Jhonson,
  Horse.Compression,
  Horse.GBSwagger,
  Horse.Logger,
  Horse.Logger.Provider.Console,
  DotEnv in 'src\core\DotEnv.pas',
  Horse.Upload in 'src\core\Horse.Upload.pas',
  LoginController in 'src\controllers\LoginController.pas',
  routes in 'src\routes.pas',
  UsuariosModel in 'src\models\UsuariosModel.pas',
  connection in 'src\providers\connection.pas' {DMConnection: TDataModule},
  ProducerController in 'src\controllers\ProducerController.pas',
  AvatarController in 'src\controllers\AvatarController.pas',
  User in 'src\middlewares\User.pas',
  AdministratorController in 'src\controllers\AdministratorController.pas',
  RegionsModel in 'src\models\RegionsModel.pas',
  InstituitionsModel in 'src\models\InstituitionsModel.pas',
  RegionsController in 'src\controllers\RegionsController.pas',
  Auth in 'src\middlewares\Auth.pas',
  ProductionAreaModel in 'src\models\ProductionAreaModel.pas',
  ProductionAreaController in 'src\controllers\ProductionAreaController.pas',
  ProducerModel in 'src\models\ProducerModel.pas',
  ProductionModel in 'src\models\ProductionModel.pas',
  ProductionController in 'src\controllers\ProductionController.pas',
  CommunityModel in 'src\models\CommunityModel.pas',
  CommunityController in 'src\controllers\CommunityController.pas',
  InstituitionController in 'src\controllers\InstituitionController.pas',
  AdminModel in 'src\models\AdminModel.pas',
  graphicsController in 'src\controllers\graphicsController.pas',
  GraficosGeralModel in 'src\models\GraficosGeralModel.pas',
  unityModel in 'src\models\unityModel.pas',
  UnityController in 'src\controllers\UnityController.pas',
  RelatModel in 'src\models\RelatModel.pas',
  RelatController in 'src\controllers\RelatController.pas',
  schemas.data in 'src\docs\schemas\schemas.classes.pas',
  docs.region in 'src\docs\docs.region.pas',
  docs.community in 'src\docs\docs.community.pas',
  docs.unity in 'src\docs\docs.unity.pas',
  docs.institution in 'src\docs\docs.institution.pas',
  docs.areas in 'src\docs\docs.areas.pas',
  docs.appointment in 'src\docs\docs.appointment.pas',
  docs.login in 'src\docs\docs.login.pas',
  docs.producer in 'src\docs\docs.producer.pas',
  docs.reports in 'src\docs\docs.reports.pas',
  docs.admin in 'src\docs\docs.admin.pas',
  docs.graphics in 'src\docs\docs.graphics.pas';

const LOGGER_FORMAT = ' method: ${request_method} - route: ' +
        '${request_path_info} - status: ${response_status}';
begin
  ReportMemoryLeaksOnShutdown := True;
  TDataSetSerializeConfig.GetInstance.CaseNameDefinition := cndNone;
  try
   const ConsoleLogConfig = THorseLoggerConsoleConfig
    .New
    .SetLogFormat(LOGGER_FORMAT);
   TDotEnv
    .getInstace()
    .loadDotEnvFile();

   THorseLoggerManager
    .RegisterProvider(THorseLoggerProviderConsole.New(ConsoleLogConfig));

   THorse
    .Use(Compression())
    .Use(Jhonson())
    .Use(THorseLoggerManager.HorseCallback())
    .Use(OctetStream)
    .Use(HorseSwagger)
    ;

   Swagger
    .Info
      .Title('BEMDIVERSO API')
      .Description('API FEITA EM HORSE')
      .Version('1.0.0')
      .Contact
        .Name('Brinfo - suporte')
        .Email('suporte@brinfo.inf.br')
        .URL('https://www.google.com')
      .&End
    .&End;

   docs.region.registry;
   docs.community.registry;
   docs.unity.registry;
   docs.institution.registry;
   docs.areas.registry;
   docs.appointment.registry;
   docs.login.registry;
   docs.producer.registry;
   docs.reports.registry;
   docs.admin.registry;
   docs.graphics.registry;

   routes.Registry;
   THorse.Listen(8181);
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
