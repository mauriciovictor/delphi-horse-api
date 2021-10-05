unit routes;

interface

uses Horse, Horse.JWT;

procedure publicRoutes;
procedure Registry;
procedure privateRoutes;

implementation

uses LoginController, ProducerController, AvatarController, User,
  AdministratorController, RegionsController, Auth, ProductionAreaController,
  ProductionController, CommunityController, InstituitionController,
  graphicsController, UnityController, RelatController;

procedure publicRoutes;
begin

  THorse
    .Group
    .Prefix('produtor')
    .post('/:id_produtor/areas/', ProductionAreaController.store)
    .get('/:id_produtor/areas/', ProductionAreaController.AreasProducer)
    .put('/:id_produtor/areas/:id_area', ProductionAreaController.update)
    .delete('/:id_produtor/areas/:id_area', ProductionAreaController.Destroy)
    .get('/:id_produtor/areas/:id_area/foto', ProductionAreaController.foto);

  THorse
    .Group
    .Prefix('produtor')
    .post('/:id_produtor/area/:id_area/apontamento', ProductionController.store)
    .get('/:id_produtor/apontamento', ProductionController.index)
    .put('/:id_produtor/area/:id_area/apontamento/:id', ProductionController.update)
    .delete('/:id_produtor/area/:id_area/apontamento/:id', ProductionController.Destroy);


  THorse
    .Group
    .Prefix('produtor')
    .post('/', ProducerController.store)
    .get('/cpf', ProducerController.verifyCPF)
    .put('/:id/avatar', User.Exist, AvatarController.update)
    .get('/:id/avatar', User.Exist, AvatarController.show);

  THorse
    .Group
    .Prefix('usuario')
    .put('/:id/avatar', User.Exist, AvatarController.update)
    .get('/:id/avatar', User.Exist, AvatarController.show);

  THorse
    .Post('/login', LoginController.Login)
    .get('/comunidades', CommunityController.communities);
end;

procedure privateRoutes;
begin
   THorse
    .Group
    .Prefix('regiao')
    .Use(Auth.Authorization())
    .get('/', RegionsController.index)
    .post('/', RegionsController.store)
    .get('/:id', RegionsController.show)
    .put('/:id', RegionsController.update)
    .delete('/:id', RegionsController.Destroy)
    .get('/all', RegionsController.listAll);

    THorse
    .Group
    .Prefix('unidades')
    .Use(Auth.Authorization())
    .get('/', UnityController.index)
    .post('/', UnityController.store)
    .get('/:id', UnityController.show)
    .put('/:id', UnityController.update)
    .delete('/:id', UnityController.Destroy)
    .get('/all', UnityController.listAll);

   THorse
    .Group
    .Prefix('comunidade')
    .Use(Auth.Authorization())
    .get('/', CommunityController.index)
    .post('/', CommunityController.store)
    .get('/:id', CommunityController.show)
    .put('/:id', CommunityController.update)
    .delete('/:id', CommunityController.Destroy);

   THorse
    .Group
    .Prefix('instituicao')
    .Use(Auth.Authorization())
    .get('/', InstituitionController.index)
    .get('/:id', InstituitionController.show)
    .get('/all', InstituitionController.listAll)
    .post('/', InstituitionController.store)
    .put('/:id', InstituitionController.update)
    .delete('/:id', InstituitionController.Destroy);


   THorse.get('/admin/:id/foto', AdministratorController.avatar);

   THorse
    .Group
    .Prefix('administrador')
    .get('/:id', AdministratorController.show)
    .Use(Auth.Authorization())
    .post('/criar', AdministratorController.store)
    .get('/', AdministratorController.index)
    .put('/:id', AdministratorController.update)
    .delete('/:id', AdministratorController.Destroy);

   THorse
    .Group
    .Prefix('graficos')
    .Get('/geral', graphicsController.dataSales)
    .get('/anos', graphicsController.yearsProduction)
    .get('/comunidades', graphicsController.communityProduction);

    THorse
    .Group
    .Prefix('relat')
    .Use(Auth.Authorization())
    .Get('/produtores', relatController.RelatMonthYearProducersProducerSale);

   THorse.get('/produtor/:id', Auth.Authorization(), ProducerController.show);
   THorse.get('/produtor', Auth.Authorization(), ProducerController.index);
   THorse.get('/produtor/:id/foto', ProducerController.avatar);
end;

procedure Registry;
begin
  publicRoutes;
  privateRoutes;
end;

end.
