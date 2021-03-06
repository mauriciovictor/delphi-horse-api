unit schemas.classes;

interface

uses
  GBSwagger.Model.Attributes,
  System.Variants,
  System.Generics.Collections;

type

 TProducer = class
  private
    Fid: Integer;
    Fid_comunidade: Integer;
    Fresidencia_gps_x: string;
    Fresidencia_gps_y: string;
    Fdata_nascimento : string;
    Fgenero : string;
    public
      property id: Integer read Fid write Fid;
      property id_comunidade: Integer read Fid_comunidade write Fid_comunidade;
      property residencia_gps_x: string read Fresidencia_gps_x write Fresidencia_gps_x;
      property residencia_gps_y: string read Fresidencia_gps_y write Fresidencia_gps_y;
      property data_nascimento: string read Fdata_nascimento write Fdata_nascimento;
      property genero: string read Fgenero write Fgenero;
  end;


 TUserProducer = class
   private
     Fid: integer;
     Fid_grupo: integer;
     FCPF: string;
     Fprodutor: string;
     Fnome_usuario: string;
     Fstatus_usu: string;
     Ffoto: string;
     Fprodutor_info : TProducer;
     public
      property id: integer read Fid write Fid;
      property id_grupo: integer read Fid_grupo write Fid_grupo;
      property CPF: string read FCPF write FCPF;
      property produtor: string read Fprodutor write Fprodutor;
      property nome_usuario: string read Fnome_usuario write Fnome_usuario;
      property status_usu: string read Fstatus_usu write Fstatus_usu;
      property foto: string read Ffoto write Ffoto;
      property produtor_info : TProducer read Fprodutor_info write Fprodutor_info;
 end;

 TRegion = class
  private
    Fid: Integer;
    Fid_instituicao: Integer;
    Fnome : string;
    public
      property id: Integer read Fid write Fid;
      property id_instituicao: Integer read Fid_instituicao write Fid_instituicao;
      property nome: string read Fnome write Fnome;
  end;



 TCommunity = class
  private
    Fid: Integer;
    Fid_regiao: Integer;
    Fnome_comunidade : string;
    Fuf : string;
    Fmunicipio : string;
    public
      property id: Integer read Fid write Fid;
      property id_regiao: Integer read Fid_regiao write Fid_regiao;
      property nome_comunidade: string read Fnome_comunidade write Fnome_comunidade;
      property uf: string read Fuf write Fuf;
      property municipio: string read Fmunicipio write Fmunicipio;
  end;

  TPagination = class
    private
      Ftotal_pages: Integer;
      Fcurrent_page: Integer;
      public
        property total_pages: Integer read Ftotal_pages write Ftotal_pages;
        property current_page: Integer read Fcurrent_page write Fcurrent_page;
  end;

  TRegionPagination = class
    private
      FData : TObjectList<TRegion>;
      FPagination: TPagination;
      public
        property data: TObjectList<TRegion> read FData write FData;
        property pagination: TPagination read Fpagination write Fpagination;
  end;

  TUnity = class
    private
      Fid: Integer;
      Fsigla: string;
      Fnome : string;
      public
        property id: Integer read Fid write Fid;
        property sigla: string read Fsigla write Fsigla;
        property nome: string read Fnome write Fnome;
  end;

  TUnityPagination  = class
    private
      FData : TObjectList<TUnity>;
      FPagination: TPagination;
      public
        property data: TObjectList<TUnity> read FData write FData;
        property pagination: TPagination read Fpagination write Fpagination;
  end;

  TInstitution = class
    private
      Fid: integer;
      Fnome_instituicao: string;
      Fcnpj: string;
      Fresponsavel_projeto: string;
      Fpais: string;
      Fuf: string;
      Fmunicipio: string;
      Fbairro: string;
      Fendereco: string;
      Fcep: string;
      Fcomplemento: string;
      Fnumero: string;
      Fddd_responsavel: string;
      Ffone_responsavel: string;
      Fgps_x: string;
      Fgps_y: string;
       public
          property nome_instituicao: string read Fnome_instituicao write Fnome_instituicao;
          property cnpj: string read Fcnpj write Fcnpj;
          property responsavel_projeto: string read Fresponsavel_projeto write Fresponsavel_projeto;
          property pais: string read Fpais write Fpais;
          property uf: string read Fuf write Fuf;
          property municipio: string read Fmunicipio write Fmunicipio;
          property bairro: string read Fbairro write Fbairro;
          property endereco: string read Fendereco write Fendereco;
          property cep: string read Fcep write Fcep;
          property complemento: string read Fcomplemento write Fcomplemento;
          property numero: string read Fnumero write Fnumero;
          property ddd_responsavel: string read Fddd_responsavel write Fddd_responsavel;
          property fone_responsavel: string read Ffone_responsavel write Ffone_responsavel;
          property gps_x: string read Fgps_x write Fgps_x;
          property gps_y: string read Fgps_y write Fgps_y;
  end;

  TInstitutionPagination = class
    private
      FData : TObjectList<TInstitution>;
      FPagination: TPagination;
      public
        property data: TObjectList<TInstitution> read FData write FData;
        property pagination: TPagination read Fpagination write Fpagination;
  end;


  TProductionArea = class
    private
      Fid: integer;
      Fnome_area: string;
      Fresidencia_gps_x: string;
      Fresidencia_gps_y: string;
      Fstatus_area: string;
      Fcomprimento: string;
      Flargura: string;
      Ffoto: string;
        public
           property nome_area: string read Fnome_area write Fnome_area;
           property residencia_gps_x: string read Fresidencia_gps_x write Fresidencia_gps_x;
           property residencia_gps_y: string read Fresidencia_gps_y write Fresidencia_gps_y;
           property status_area: string read Fstatus_area write Fstatus_area;
           property comprimento: string read Fcomprimento write Fcomprimento;
           property largura: string read Flargura write Flargura;
           property foto: string read Ffoto write Ffoto;
  end;

   TProductionAreaPagination = class
    private
      FData : TObjectList<TProductionArea>;
      FPagination: TPagination;
      public
        property data: TObjectList<TProductionArea> read FData write FData;
        property pagination: TPagination read Fpagination write Fpagination;
  end;

  TAppointment = class
    private
      Fid: integer;
      Fdata_producao: string;
      Fhora_producao: string;
      Ftipo_prod: string;
      Fquantidade: string;
      Fvalor: Double;
      Fid_unidade: integer;
        public
          property id: integer read Fid write Fid;
          property data_producao: string read Fdata_producao write Fdata_producao;
          property hora_producao: string read Fhora_producao write Fhora_producao;
          property tipo_prod: string read Ftipo_prod write Ftipo_prod;
          property quantidade: string read Fquantidade write Fquantidade;
          property valor: Double read Fvalor write Fvalor;
          property id_unidade: integer read Fid_unidade write Fid_unidade;
  end;


 TLogin = class
    private
      Fcpf: string;
      Fsenha: string;
        public
          property cpf: string read Fcpf write Fcpf;
          property senha: string read Fsenha write Fsenha;
  end;

 TToken = class
    private
      Ftoken: string;
        public
          property token: string read Ftoken write Ftoken;
  end;

 TAppointmentPagination  = class
    private
      FData : TObjectList<TAppointment>;
      FPagination: TPagination;
      public
        property data: TObjectList<TAppointment> read FData write FData;
        property pagination: TPagination read Fpagination write Fpagination;
  end;

 TCommunityPagination  = class
    private
      FData : TObjectList<TCommunity>;
      FPagination: TPagination;
      public
        property data: TObjectList<TCommunity> read FData write FData;
        property pagination: TPagination read Fpagination write Fpagination;
  end;

 Tmessage = class
  private
    Fmessage : string;
    public
      property message: string read Fmessage write Fmessage;
  end;

 TCommunityRegion = class
    private
      Fid: Integer;
      Fid_regiao: Integer;
      Fnome_comunidade : string;
      Fuf : string;
      Fmunicipio : string;
      Fregion : TRegion;
      public
         property id: Integer read Fid write Fid;
         property id_regiao: Integer read Fid_regiao write Fid_regiao;
         property nome_comunidade: string read Fnome_comunidade write Fnome_comunidade;
         property uf: string read Fuf write Fuf;
         property municipio: string read Fmunicipio write Fmunicipio;
         property  region : TRegion read Fregion write Fregion;
  end;

 TProducerDetails = class
    private
      Fid: integer;
      Fid_grupo: integer;
      FCPF: string;
      Fprodutor: string;
      Fnome_usuario: string;
      Fddd: string;
      Ffone: string;
      Fstatus_usu: string;
      Fprodutor_info : TProducer;
      Fcomunidade:  TCommunityRegion;
      Fareas_producao : TObjectList<TProductionArea>;
      public
        property id: integer read Fid write Fid;
        property id_grupo: integer read Fid_grupo write Fid_grupo;
        property CPF: string read FCPF write FCPF;
        property produtor: string read Fprodutor write Fprodutor;
        property nome_usuario: string read Fnome_usuario write Fnome_usuario;
        property ddd: string read Fddd write Fddd;
        property fone: string read Ffone write Ffone;
        property status_usu: string read Fstatus_usu write Fstatus_usu;
        property produtor_info : TProducer read Fprodutor_info write Fprodutor_info;
        property comunidade:  TCommunityRegion read Fcomunidade write Fcomunidade;
        property areas_producao : TObjectList<TProductionArea> read Fareas_producao write Fareas_producao;

  end;

 TProducerResume = class
   private
    Fid: integer;
    Fnome_usuario: string;
    FCPF: string;
    Fnome_comunidade: string;
    Fnome_regiao: string;
    Fnome_instituicao: string;
    Fid_produtor: integer;
    Fresidencia_gps_x: string;
    Fresidencia_gps_y: string;
    public
      property id: integer read Fid write Fid;
      property nome_usuario: string read Fnome_usuario write Fnome_usuario;
      property CPF: string read FCPF write FCPF;
      property nome_comunidade: string read Fnome_comunidade write Fnome_comunidade;
      property nome_regiao: string read Fnome_regiao write Fnome_regiao;
      property nome_instituicao: string read Fnome_instituicao write Fnome_instituicao;
      property id_produtor: integer read Fid_produtor write Fid_produtor;
      property residencia_gps_x: string read Fresidencia_gps_x write Fresidencia_gps_x;
      property residencia_gps_y: string read Fresidencia_gps_y write Fresidencia_gps_y;
 end;

 TProducerResumePagination = class
   private
    FData : TObjectList<TProducerResume>;
    FPagination: TPagination;
    public
      property data: TObjectList<TProducerResume> read FData write FData;
      property pagination: TPagination read Fpagination write Fpagination;
 end;

 TReportRegion = class
  private
    Fid: integer;
    Fnome_usuario: string;
    Fnome_instituicao: string;
    Fnome_regiao: string;
    Fnome_comunidade: string;
    Ftipo_prod: string;
    Fmes_ano: string;
    Fdia: string;
    Fquant_total: double;
    Fvalor_tot: double;
    Fmenor_valor_produtor: double;
    Fmaior_valor_produtor: double;
    Fmenor_valor_geral: double;
    Fmaior_valor_geral: double;
    Fid_instituicao: integer;
    Fid_regiao: integer;
    Fid_comunidade: integer;
    Fuf: string;
    Fmunicipio: string;
    public
      property id: integer read Fid write Fid;
      property nome_usuario: string read Fnome_usuario write Fnome_usuario;
      property nome_instituicao: string read Fnome_instituicao write Fnome_instituicao;
      property nome_regiao: string read Fnome_regiao write Fnome_regiao;
      property nome_comunidade: string read Fnome_comunidade write Fnome_comunidade;
      property tipo_prod: string read Ftipo_prod write Ftipo_prod;
      property mes_ano: string read Fmes_ano write Fmes_ano;
      property dia: string read Fdia write Fdia;
      property quant_total: double read Fquant_total write Fquant_total;
      property valor_tot: double read Fvalor_tot write Fvalor_tot;
      property menor_valor_produtor: double read Fmenor_valor_produtor write Fmenor_valor_produtor;
      property maior_valor_produtor: double read Fmaior_valor_produtor write Fmaior_valor_produtor;
      property menor_valor_geral: double read Fmenor_valor_geral write Fmenor_valor_geral;
      property maior_valor_geral: double read Fmaior_valor_geral write Fmaior_valor_geral;
      property id_instituicao: integer read Fid_instituicao write Fid_instituicao;
      property id_regiao: integer read Fid_regiao write Fid_regiao;
      property id_comunidade: integer read Fid_comunidade write Fid_comunidade;
      property uf: string read Fuf write Fuf;
      property municipio: string read Fmunicipio write Fmunicipio;
 end;

 TUserAdmin = class
  private
    Fid: integer;
    Fid_grupo: integer;
    FCPF: string;
    Fadministrador: string;
    Fsenha: string;
    Fnome_usuario: string;
    Fstatus_usu: string;
    Ffoto: string;
    public
      property id: integer  read Fid write Fid;
      property id_grupo: integer  read Fid_grupo write Fid_grupo;
      property CPF: string  read FCPF write FCPF;
      property administrador: string  read Fadministrador write Fadministrador;
      property senha: string  read Fsenha write Fsenha;
      property nome_usuario: string  read Fnome_usuario write Fnome_usuario;
      property status_usu: string  read Fstatus_usu write Fstatus_usu;
      property foto: string  read Ffoto write Ffoto;
 end;

 TUserAdminPagination = class
   private
    Fdata: TObjectList<TUserAdmin>;
    Fpagination : TPagination;
    public
      property data: TObjectList<TUserAdmin> read Fdata write Fdata;
      property pagination: TPagination  read Fpagination write Fpagination;
 end;

 TGraphicsYear = class
   private
    Fdata: TArray<string>;
    public
      property data: TArray<string> read Fdata write Fdata;
  end;

 TGraphicCommunity = class
    private
      Fid: integer;
      Fnome: string;
      public
        property id: integer read Fid write Fid;
        property nome : string read Fnome write Fnome;
  end;

implementation

end.
