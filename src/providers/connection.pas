unit connection;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.ConsoleUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Phys.FB, FireDAC.Phys.FBDef,
  FireDAC.Phys.IBBase, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Phys.MSSQL, FireDAC.Phys.MSSQLDef;

type
  TDMConnection = class(TDataModule)
    connection: TFDConnection;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    Usuarios: TFDQuery;
    Usuariosid: TFDAutoIncField;
    Usuariosid_grupo: TIntegerField;
    UsuariosCPF: TStringField;
    Usuariosprodutor: TStringField;
    Usuariosadministrador: TStringField;
    Usuariossenha: TStringField;
    Usuariosnome_usuario: TStringField;
    Usuariosddd: TStringField;
    Usuariosfone: TStringField;
    Usuariosstatus_usu: TStringField;
    DS_Usuarios: TDataSource;
    DS_Produtores: TDataSource;
    Usuariosavatar: TBlobField;
    Regioes_Atendimento: TFDQuery;
    DS_Regioes_Atendimento: TDataSource;
    Regioes_Atendimentoid: TFDAutoIncField;
    Regioes_Atendimentoid_instituicao: TIntegerField;
    Regioes_Atendimentonome_regiao: TStringField;
    Instituicoes: TFDQuery;
    DS_Instituicoes: TDataSource;
    Areas_Producao: TFDQuery;
    Areas_Producaoid: TFDAutoIncField;
    Areas_Producaoid_produtor: TIntegerField;
    Areas_Producaonome_area: TStringField;
    Areas_Producaoresidencia_gps_x: TStringField;
    Areas_Producaoresidencia_gps_y: TStringField;
    Areas_Producaostatus_area: TStringField;
    DS_Areas_Producao: TDataSource;
    Registro_Producao: TFDQuery;
    Registro_Producaoid: TFDAutoIncField;
    Registro_Producaoid_area_prod: TIntegerField;
    Registro_Producaodata_producao: TDateField;
    Registro_Producaotipo_prod: TStringField;
    Registro_Producaoquantidade: TBCDField;
    DS_Registro_Producao: TDataSource;
    Registro_Producaohora_producao: TTimeField;
    Comunidades: TFDQuery;
    DS_Comunidades: TDataSource;
    Comunidadesid: TFDAutoIncField;
    Comunidadesid_regiao: TIntegerField;
    Comunidadesnome_comunidade: TStringField;
    Comunidadesuf: TStringField;
    Comunidadesmunicipio: TStringField;
    Instituicoesid: TFDAutoIncField;
    Instituicoesnome_instituicao: TStringField;
    Instituicoescnpj: TStringField;
    Instituicoesresponsavel_projeto: TStringField;
    Instituicoespais: TStringField;
    Instituicoesuf: TStringField;
    Instituicoesmunicipio: TStringField;
    Instituicoesbairro: TStringField;
    Instituicoescep: TStringField;
    Instituicoesendereco: TStringField;
    Instituicoescomplemento: TStringField;
    Instituicoesnumero: TStringField;
    Instituicoesddd_responsavel: TStringField;
    Instituicoesfone_responsavel: TStringField;
    Instituicoesgps_x: TStringField;
    Instituicoesgps_y: TStringField;
    Produtores: TFDQuery;
    Produtoresid: TFDAutoIncField;
    Produtoresid_usuario: TIntegerField;
    Produtoresid_comunidade: TIntegerField;
    Produtoresresidencia_gps_x: TStringField;
    Produtoresresidencia_gps_y: TStringField;
    Regions_instituicoes: TFDQuery;
    Regions_instituicoesid: TFDAutoIncField;
    Regions_instituicoesid_instituicao: TIntegerField;
    Regions_instituicoesnome_regiao: TStringField;
    Regions_instituicoesnome_instituicao: TStringField;
    Comunidades_Regiao: TFDQuery;
    Produtoresdata_nascimento: TDateField;
    Produtoresgenero: TStringField;
    Areas_Producaocomprimento: TBCDField;
    Areas_Producaolargura: TBCDField;
    Areas_Producaofoto: TBlobField;
    Produtores_All: TFDQuery;
    Produtores_Allid: TFDAutoIncField;
    Produtores_Allnome_usuario: TStringField;
    Produtores_AllCPF: TStringField;
    Produtores_Allnome_comunidade: TStringField;
    Produtores_Allnome_regiao: TStringField;
    Produtores_Allnome_instituicao: TStringField;
    Produtores_Allid_produtor: TFDAutoIncField;
    Registro_producao_area: TFDQuery;
    FDAutoIncField1: TFDAutoIncField;
    IntegerField1: TIntegerField;
    DateField1: TDateField;
    StringField1: TStringField;
    BCDField1: TBCDField;
    TimeField1: TTimeField;
    Registro_producao_areanome_area: TStringField;
    Registro_Producaovalor: TBCDField;
    Registro_producao_areavalor: TBCDField;
    Grafico_Geral: TFDQuery;
    Unidade_Medida: TFDQuery;
    Unidade_Medidaid: TFDAutoIncField;
    Unidade_Medidasigla: TStringField;
    Unidade_Medidanome: TStringField;
    Registro_Producaoid_unidade: TIntegerField;
    Registro_producao_areaid_unidade: TIntegerField;
    Registro_producao_areasigla: TStringField;
    Registro_producao_areanome: TStringField;
    Produtores_Allresidencia_gps_x: TStringField;
    Produtores_Allresidencia_gps_y: TStringField;
    Relat_Mes_Prods_Consumo_Venda: TFDQuery;
    Relat_Mes_Prods_Consumo_Vendaid: TIntegerField;
    Relat_Mes_Prods_Consumo_Vendanome_usuario: TStringField;
    Relat_Mes_Prods_Consumo_Vendanome_instituicao: TStringField;
    Relat_Mes_Prods_Consumo_Vendanome_regiao: TStringField;
    Relat_Mes_Prods_Consumo_Vendanome_comunidade: TStringField;
    Relat_Mes_Prods_Consumo_Vendatipo_prod: TStringField;
    Relat_Mes_Prods_Consumo_Vendames_ano: TStringField;
    Relat_Mes_Prods_Consumo_Vendadia: TStringField;
    Relat_Mes_Prods_Consumo_Vendaquant_total: TFMTBCDField;
    Relat_Mes_Prods_Consumo_Vendavalor_tot: TFMTBCDField;
    Relat_Mes_Prods_Consumo_Vendamenor_valor_produtor: TBCDField;
    Relat_Mes_Prods_Consumo_Vendamaior_valor_produtor: TBCDField;
    Relat_Mes_Prods_Consumo_Vendamenor_valor_geral: TBCDField;
    Relat_Mes_Prods_Consumo_Vendamaior_valor_geral: TBCDField;
    Relat_Mes_Prods_Consumo_Vendaid_instituicao: TIntegerField;
    Relat_Mes_Prods_Consumo_Vendaid_regiao: TIntegerField;
    Relat_Mes_Prods_Consumo_Venda2: TFDQuery;
    IntegerField2: TIntegerField;
    StringField2: TStringField;
    StringField3: TStringField;
    StringField4: TStringField;
    StringField5: TStringField;
    StringField6: TStringField;
    StringField7: TStringField;
    StringField8: TStringField;
    FMTBCDField1: TFMTBCDField;
    FMTBCDField2: TFMTBCDField;
    BCDField2: TBCDField;
    BCDField3: TBCDField;
    BCDField4: TBCDField;
    BCDField5: TBCDField;
    IntegerField3: TIntegerField;
    IntegerField4: TIntegerField;
    Relat_Mes_Prods_Consumo_Venda2id_comunidade: TIntegerField;
    Relat_Mes_Prods_Consumo_Vendaid_comunidade: TIntegerField;
    Relat_Mes_Prods_Consumo_Venda2uf: TStringField;
    Relat_Mes_Prods_Consumo_Venda2municipio: TStringField;
    Relat_Mes_Prods_Consumo_Vendauf: TStringField;
    Relat_Mes_Prods_Consumo_Vendamunicipio: TStringField;
    Grafico_Geralnome_comunidade: TStringField;
    Grafico_Geralid_comunidade: TFDAutoIncField;
    Grafico_Geraltipo_prod: TStringField;
    Grafico_Geralano: TStringField;
    Grafico_Geralmes: TStringField;
    Grafico_Geralmes_extenso: TStringField;
    Grafico_Geralquant_total: TFMTBCDField;
    Grafico_Geralmenor_valor: TBCDField;
    Grafico_Geralmaior_valor: TBCDField;
    SQL_GERAL: TFDQuery;
    Grafico_Geraltot_produtores_aponta: TIntegerField;
    Grafico_Geraltot_produtores: TIntegerField;
    Resumo_venda_mes: TFDQuery;
    Max_Resumo_venda_mes: TFDQuery;
  private
  public
    function getConnection(): TDMConnection;
  end;

var
  DMConnection: TDMConnection;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}


function TDMConnection.getConnection(): TDMConnection;
begin
  result := getConnection();
end;

end.
