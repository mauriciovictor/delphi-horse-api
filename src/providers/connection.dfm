object DMConnection: TDMConnection
  OldCreateOrder = False
  Height = 511
  Width = 670
  object connection: TFDConnection
    Params.Strings = (
      'Database=embrapa'
      'User_Name=sa'
      'Password=Lump261359@'
      'Server=localhost'
      'DriverID=MSSQL')
    Connected = True
    LoginPrompt = False
    Left = 32
    Top = 8
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    VendorLib = 'C:\DB_HORUS_CLOUD\fbclient.dll'
    Left = 120
    Top = 8
  end
  object Usuarios: TFDQuery
    Connection = connection
    SQL.Strings = (
      ''
      'select * from usuarios')
    Left = 72
    Top = 64
    object Usuariosid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object Usuariosid_grupo: TIntegerField
      FieldName = 'id_grupo'
      Origin = 'id_grupo'
      Required = True
    end
    object UsuariosCPF: TStringField
      FieldName = 'CPF'
      Origin = 'CPF'
      Size = 14
    end
    object Usuariosprodutor: TStringField
      FieldName = 'produtor'
      Origin = 'produtor'
      FixedChar = True
      Size = 1
    end
    object Usuariosadministrador: TStringField
      FieldName = 'administrador'
      Origin = 'administrador'
      FixedChar = True
      Size = 1
    end
    object Usuariossenha: TStringField
      FieldName = 'senha'
      Origin = 'senha'
      Size = 50
    end
    object Usuariosnome_usuario: TStringField
      FieldName = 'nome_usuario'
      Origin = 'nome_usuario'
      Size = 50
    end
    object Usuariosddd: TStringField
      FieldName = 'ddd'
      Origin = 'ddd'
      FixedChar = True
      Size = 2
    end
    object Usuariosfone: TStringField
      FieldName = 'fone'
      Origin = 'fone'
      Size = 10
    end
    object Usuariosstatus_usu: TStringField
      FieldName = 'status_usu'
      Origin = 'status_usu'
      FixedChar = True
      Size = 1
    end
    object Usuariosavatar: TBlobField
      FieldName = 'avatar'
      Origin = 'avatar'
      Size = 2147483647
    end
  end
  object DS_Usuarios: TDataSource
    DataSet = Usuarios
    Left = 184
    Top = 64
  end
  object DS_Produtores: TDataSource
    Left = 184
    Top = 128
  end
  object Regioes_Atendimento: TFDQuery
    Connection = connection
    SQL.Strings = (
      'select * from regioes_atendimento')
    Left = 72
    Top = 256
    object Regioes_Atendimentoid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object Regioes_Atendimentoid_instituicao: TIntegerField
      FieldName = 'id_instituicao'
      Origin = 'id_instituicao'
      Required = True
    end
    object Regioes_Atendimentonome_regiao: TStringField
      FieldName = 'nome_regiao'
      Origin = 'nome_regiao'
      Size = 50
    end
  end
  object DS_Regioes_Atendimento: TDataSource
    DataSet = Regioes_Atendimento
    Left = 184
    Top = 192
  end
  object Instituicoes: TFDQuery
    Connection = connection
    SQL.Strings = (
      'select * from Instituicoes')
    Left = 72
    Top = 312
    object Instituicoesid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object Instituicoesnome_instituicao: TStringField
      FieldName = 'nome_instituicao'
      Origin = 'nome_instituicao'
      Required = True
      Size = 50
    end
    object Instituicoescnpj: TStringField
      FieldName = 'cnpj'
      Origin = 'cnpj'
      Required = True
      Size = 14
    end
    object Instituicoesresponsavel_projeto: TStringField
      FieldName = 'responsavel_projeto'
      Origin = 'responsavel_projeto'
      Required = True
      Size = 50
    end
    object Instituicoespais: TStringField
      FieldName = 'pais'
      Origin = 'pais'
      Required = True
      Size = 30
    end
    object Instituicoesuf: TStringField
      FieldName = 'uf'
      Origin = 'uf'
      Required = True
      FixedChar = True
      Size = 2
    end
    object Instituicoesmunicipio: TStringField
      FieldName = 'municipio'
      Origin = 'municipio'
      Size = 30
    end
    object Instituicoesbairro: TStringField
      FieldName = 'bairro'
      Origin = 'bairro'
      Size = 30
    end
    object Instituicoescep: TStringField
      FieldName = 'cep'
      Origin = 'cep'
      Size = 8
    end
    object Instituicoesendereco: TStringField
      FieldName = 'endereco'
      Origin = 'endereco'
      Size = 50
    end
    object Instituicoescomplemento: TStringField
      FieldName = 'complemento'
      Origin = 'complemento'
      Size = 50
    end
    object Instituicoesnumero: TStringField
      FieldName = 'numero'
      Origin = 'numero'
      Size = 10
    end
    object Instituicoesddd_responsavel: TStringField
      FieldName = 'ddd_responsavel'
      Origin = 'ddd_responsavel'
      FixedChar = True
      Size = 2
    end
    object Instituicoesfone_responsavel: TStringField
      FieldName = 'fone_responsavel'
      Origin = 'fone_responsavel'
      Size = 10
    end
    object Instituicoesgps_x: TStringField
      FieldName = 'gps_x'
      Origin = 'gps_x'
      Size = 30
    end
    object Instituicoesgps_y: TStringField
      FieldName = 'gps_y'
      Origin = 'gps_y'
      Size = 30
    end
  end
  object DS_Instituicoes: TDataSource
    DataSet = Instituicoes
    Left = 184
    Top = 312
  end
  object Areas_Producao: TFDQuery
    Connection = connection
    SQL.Strings = (
      'select * from areas_producao')
    Left = 344
    Top = 88
    object Areas_Producaoid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object Areas_Producaoid_produtor: TIntegerField
      FieldName = 'id_produtor'
      Origin = 'id_produtor'
      Required = True
    end
    object Areas_Producaonome_area: TStringField
      FieldName = 'nome_area'
      Origin = 'nome_area'
      Required = True
      Size = 50
    end
    object Areas_Producaoresidencia_gps_x: TStringField
      FieldName = 'residencia_gps_x'
      Origin = 'residencia_gps_x'
      Size = 30
    end
    object Areas_Producaoresidencia_gps_y: TStringField
      FieldName = 'residencia_gps_y'
      Origin = 'residencia_gps_y'
      Size = 30
    end
    object Areas_Producaostatus_area: TStringField
      FieldName = 'status_area'
      Origin = 'status_area'
      FixedChar = True
      Size = 1
    end
    object Areas_Producaocomprimento: TBCDField
      FieldName = 'comprimento'
      Origin = 'comprimento'
      Precision = 10
      Size = 2
    end
    object Areas_Producaolargura: TBCDField
      FieldName = 'largura'
      Origin = 'largura'
      Precision = 10
      Size = 2
    end
    object Areas_Producaofoto: TBlobField
      FieldName = 'foto'
      Origin = 'foto'
      Size = 2147483647
    end
  end
  object DS_Areas_Producao: TDataSource
    Left = 448
    Top = 88
  end
  object Registro_Producao: TFDQuery
    Connection = connection
    SQL.Strings = (
      'select * from registro_producao')
    Left = 344
    Top = 160
    object Registro_Producaoid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object Registro_Producaoid_area_prod: TIntegerField
      FieldName = 'id_area_prod'
      Origin = 'id_area_prod'
      Required = True
    end
    object Registro_Producaodata_producao: TDateField
      FieldName = 'data_producao'
      Origin = 'data_producao'
      Required = True
    end
    object Registro_Producaotipo_prod: TStringField
      FieldName = 'tipo_prod'
      Origin = 'tipo_prod'
      Required = True
      FixedChar = True
      Size = 1
    end
    object Registro_Producaoquantidade: TBCDField
      FieldName = 'quantidade'
      Origin = 'quantidade'
      Required = True
      Precision = 10
      Size = 2
    end
    object Registro_Producaohora_producao: TTimeField
      FieldName = 'hora_producao'
      Origin = 'hora_producao'
    end
    object Registro_Producaovalor: TBCDField
      FieldName = 'valor'
      Origin = 'valor'
      Precision = 10
      Size = 2
    end
    object Registro_Producaoid_unidade: TIntegerField
      FieldName = 'id_unidade'
      Origin = 'id_unidade'
    end
  end
  object DS_Registro_Producao: TDataSource
    DataSet = Registro_Producao
    Left = 456
    Top = 160
  end
  object Comunidades: TFDQuery
    Connection = connection
    SQL.Strings = (
      'select * from comunidades')
    Left = 344
    Top = 32
    object Comunidadesid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object Comunidadesid_regiao: TIntegerField
      FieldName = 'id_regiao'
      Origin = 'id_regiao'
      Required = True
    end
    object Comunidadesnome_comunidade: TStringField
      FieldName = 'nome_comunidade'
      Origin = 'nome_comunidade'
      Required = True
      Size = 50
    end
    object Comunidadesuf: TStringField
      FieldName = 'uf'
      Origin = 'uf'
      Required = True
      FixedChar = True
      Size = 2
    end
    object Comunidadesmunicipio: TStringField
      FieldName = 'municipio'
      Origin = 'municipio'
      Required = True
      Size = 50
    end
  end
  object DS_Comunidades: TDataSource
    DataSet = Comunidades
    Left = 440
    Top = 32
  end
  object Produtores: TFDQuery
    Connection = connection
    SQL.Strings = (
      'select * from produtores')
    Left = 72
    Top = 128
    object Produtoresid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object Produtoresid_usuario: TIntegerField
      FieldName = 'id_usuario'
      Origin = 'id_usuario'
      Required = True
    end
    object Produtoresid_comunidade: TIntegerField
      FieldName = 'id_comunidade'
      Origin = 'id_comunidade'
      Required = True
    end
    object Produtoresresidencia_gps_x: TStringField
      FieldName = 'residencia_gps_x'
      Origin = 'residencia_gps_x'
      Size = 30
    end
    object Produtoresresidencia_gps_y: TStringField
      FieldName = 'residencia_gps_y'
      Origin = 'residencia_gps_y'
      Size = 30
    end
    object Produtoresdata_nascimento: TDateField
      FieldName = 'data_nascimento'
      Origin = 'data_nascimento'
    end
    object Produtoresgenero: TStringField
      FieldName = 'genero'
      Origin = 'genero'
      FixedChar = True
      Size = 1
    end
  end
  object Regions_instituicoes: TFDQuery
    Connection = connection
    SQL.Strings = (
      'select '
      #9'ra.*,'
      #9'i.nome_instituicao'
      'from '
      #9'regioes_atendimento ra inner join'
      #9'instituicoes i on'
      #9'i.id = ra.id_instituicao')
    Left = 352
    Top = 256
    object Regions_instituicoesid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object Regions_instituicoesid_instituicao: TIntegerField
      FieldName = 'id_instituicao'
      Origin = 'id_instituicao'
      Required = True
    end
    object Regions_instituicoesnome_regiao: TStringField
      FieldName = 'nome_regiao'
      Origin = 'nome_regiao'
      Size = 50
    end
    object Regions_instituicoesnome_instituicao: TStringField
      FieldName = 'nome_instituicao'
      Origin = 'nome_instituicao'
      Required = True
      Size = 50
    end
  end
  object Comunidades_Regiao: TFDQuery
    Connection = connection
    Left = 472
    Top = 280
  end
  object Produtores_All: TFDQuery
    Connection = connection
    SQL.Strings = (
      'select '
      '     u.id,'
      #9' u.nome_usuario,'
      #9' u.CPF,'
      #9' c.nome_comunidade,'
      'p.id id_produtor,'
      #9' re.nome_regiao,'
      #9' i.nome_instituicao,'
      'p.residencia_gps_x,'
      'p.residencia_gps_y'
      'from usuarios u inner join '
      #9' produtores p on'
      #9' p.id_usuario = u.id inner join '
      #9' comunidades c on'
      #9' c.id = p.id_comunidade inner join'
      #9' regioes_atendimento re on'
      #9' re.id = c.id_regiao inner join'
      #9' instituicoes i on'
      #9' i.id = re.id_instituicao'
      'where '
      #9'u.produtor = '#39'S'#39)
    Left = 72
    Top = 192
    object Produtores_Allid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object Produtores_Allnome_usuario: TStringField
      FieldName = 'nome_usuario'
      Origin = 'nome_usuario'
      Size = 50
    end
    object Produtores_AllCPF: TStringField
      FieldName = 'CPF'
      Origin = 'CPF'
      Size = 14
    end
    object Produtores_Allnome_comunidade: TStringField
      FieldName = 'nome_comunidade'
      Origin = 'nome_comunidade'
      Required = True
      Size = 50
    end
    object Produtores_Allnome_regiao: TStringField
      FieldName = 'nome_regiao'
      Origin = 'nome_regiao'
      Size = 50
    end
    object Produtores_Allnome_instituicao: TStringField
      FieldName = 'nome_instituicao'
      Origin = 'nome_instituicao'
      Required = True
      Size = 50
    end
    object Produtores_Allid_produtor: TFDAutoIncField
      FieldName = 'id_produtor'
      Origin = 'id_produtor'
      ReadOnly = True
    end
    object Produtores_Allresidencia_gps_x: TStringField
      FieldName = 'residencia_gps_x'
      Origin = 'residencia_gps_x'
      Size = 30
    end
    object Produtores_Allresidencia_gps_y: TStringField
      FieldName = 'residencia_gps_y'
      Origin = 'residencia_gps_y'
      Size = 30
    end
  end
  object Registro_producao_area: TFDQuery
    Connection = connection
    SQL.Strings = (
      'select '
      #9'ap.nome_area,'
      #9'rp.*,'
      '        um.sigla,'
      '        um.nome '
      'from '
      #9'registro_producao rp inner join'
      #9'areas_producao ap on'
      #9'ap.id = rp.id_area_prod inner join'
      '        unidade_medida um on'
      '        um.id = rp.id_unidade')
    Left = 192
    Top = 360
    object FDAutoIncField1: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object IntegerField1: TIntegerField
      FieldName = 'id_area_prod'
      Origin = 'id_area_prod'
      Required = True
    end
    object DateField1: TDateField
      FieldName = 'data_producao'
      Origin = 'data_producao'
      Required = True
    end
    object StringField1: TStringField
      FieldName = 'tipo_prod'
      Origin = 'tipo_prod'
      Required = True
      FixedChar = True
      Size = 1
    end
    object BCDField1: TBCDField
      FieldName = 'quantidade'
      Origin = 'quantidade'
      Required = True
      Precision = 10
      Size = 2
    end
    object TimeField1: TTimeField
      FieldName = 'hora_producao'
      Origin = 'hora_producao'
    end
    object Registro_producao_areanome_area: TStringField
      FieldName = 'nome_area'
      Origin = 'nome_area'
      Required = True
      Size = 50
    end
    object Registro_producao_areavalor: TBCDField
      FieldName = 'valor'
      Origin = 'valor'
      Precision = 10
      Size = 2
    end
    object Registro_producao_areaid_unidade: TIntegerField
      FieldName = 'id_unidade'
      Origin = 'id_unidade'
    end
    object Registro_producao_areasigla: TStringField
      FieldName = 'sigla'
      Origin = 'sigla'
      Size = 4
    end
    object Registro_producao_areanome: TStringField
      FieldName = 'nome'
      Origin = 'nome'
      Size = 50
    end
  end
  object Grafico_Geral: TFDQuery
    Connection = connection
    SQL.Strings = (
      ''
      'select * from ('
      'select '
      #9'c.nome_comunidade,'
      #9'c.id id_comunidade,'
      #9'rp.tipo_prod,'
      #9'substring(cast(rp.data_producao as varchar), 1, 4) ano,'
      #9'substring(cast(rp.data_producao as varchar), 6, 2) mes,'
      #9'case '
      
        #9#9'when  substring(cast(rp.data_producao as varchar), 6, 2)  = '#39'0' +
        '1'#39' then'
      #9#9#9#39'Janeiro'#39
      
        #9#9'when  substring(cast(rp.data_producao as varchar), 6, 2)  = '#39'0' +
        '2'#39' then'
      #9#9#9#39'Feveiro'#39
      
        #9#9'when  substring(cast(rp.data_producao as varchar), 6, 2)  = '#39'0' +
        '3'#39' then'
      #9#9#9#39'Mar'#231'o'#39
      
        #9#9'when  substring(cast(rp.data_producao as varchar), 6, 2)  = '#39'0' +
        '4'#39' then'
      #9#9#9#39'Abril'#39
      
        #9#9'when  substring(cast(rp.data_producao as varchar), 6, 2)  = '#39'0' +
        '5'#39' then'
      #9#9#9#39'Maio'#39
      
        #9#9'when  substring(cast(rp.data_producao as varchar), 6, 2)  = '#39'0' +
        '6'#39' then'
      #9#9#9#39'Junho'#39
      
        #9#9'when  substring(cast(rp.data_producao as varchar), 6, 2)  = '#39'0' +
        '7'#39' then'
      #9#9#9#39'Julho'#39
      
        #9#9'when  substring(cast(rp.data_producao as varchar), 6, 2)  = '#39'0' +
        '8'#39' then'
      #9#9#9#39'Agosto'#39
      
        #9#9'when  substring(cast(rp.data_producao as varchar), 6, 2)  = '#39'0' +
        '9'#39' then'
      #9#9#9#39'Setembro'#39
      
        #9#9'when  substring(cast(rp.data_producao as varchar), 6, 2)  = '#39'1' +
        '0'#39' then'
      #9#9#9#39'Outubro'#39
      
        #9#9'when  substring(cast(rp.data_producao as varchar), 6, 2)  = '#39'1' +
        '1'#39' then'
      #9#9#9#39'Novembro'#39
      
        #9#9'when  substring(cast(rp.data_producao as varchar), 6, 2)  = '#39'1' +
        '2'#39' then'
      #9#9#9#39'Dezembro'#39
      #9'end mes_extenso,'
      #9'sum(rp.quantidade) quant_total,'
      #9'case '
      #9#9'when rp.tipo_prod = '#39'V'#39' then'
      #9#9#9'min(rp.valor)'
      #9#9'else'
      #9#9' 0'
      #9'end menor_valor,'
      #9'case '
      #9#9'when rp.tipo_prod = '#39'V'#39' then'
      #9#9#9'max(rp.valor)'
      #9#9'else'
      #9#9' 0'
      #9'end maior_valor,'
      '        '
      #9'('#9'select '
      #9#9#9'count(*)'
      #9#9'from'
      #9#9#9'instituicoes i inner join '
      #9#9#9'regioes_atendimento ra on'
      #9#9#9'ra.id_instituicao = i.id inner join'
      #9#9#9'comunidades c on'
      #9#9#9'c.id_regiao = ra.id inner join'
      #9#9#9'produtores p on'
      #9#9#9'p.id_comunidade = c.id inner join'
      #9#9#9'usuarios u on'
      #9#9#9'u.id = p.id_usuario'
      #9#9'where '
      #9#9#9'c.id = :id and'
      #9#9#9'exists ('
      #9#9#9#9'select * from registro_producao p2, areas_producao ap where'
      #9#9#9#9'p2.id_area_prod = ap.id and'
      #9#9#9#9'ap.id_produtor = p.id and'
      #9#9#9#9'substring(cast(p2.data_producao as varchar), 1, 4) = :ano'
      #9')) tot_produtores_aponta,'
      #9'('
      #9'select '
      #9#9'count(*)'
      #9'from '
      #9#9'comunidades c  inner join'
      #9#9'produtores p on'
      #9#9'p.id_comunidade = c.id'
      #9'where'
      #9#9'c.id = :id) tot_produtores'
      'from'
      #9'produtores p inner join'
      #9'areas_producao ap on'
      #9'ap.id_produtor = p.id inner join'
      #9'registro_producao rp on'
      #9'rp.id_area_prod = ap.id inner join'
      #9'comunidades c on'
      #9'c.id = p.id_comunidade'
      'group by'
      
        #9'c.nome_comunidade, c.id, rp.tipo_prod, substring(cast(rp.data_p' +
        'roducao as varchar), 6, 2),'
      #9'substring(cast(rp.data_producao as varchar), 1, 4)'
      ') v '
      'where v.id_comunidade = :id and ano = :ano'
      'order by v.tipo_prod, v.mes'
      #9
      '')
    Left = 352
    Top = 312
    ParamData = <
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'ANO'
        DataType = ftString
        ParamType = ptInput
      end>
    object Grafico_Geralnome_comunidade: TStringField
      FieldName = 'nome_comunidade'
      Origin = 'nome_comunidade'
      Required = True
      Size = 50
    end
    object Grafico_Geralid_comunidade: TFDAutoIncField
      FieldName = 'id_comunidade'
      Origin = 'id_comunidade'
      ReadOnly = True
    end
    object Grafico_Geraltipo_prod: TStringField
      FieldName = 'tipo_prod'
      Origin = 'tipo_prod'
      Required = True
      FixedChar = True
      Size = 1
    end
    object Grafico_Geralano: TStringField
      FieldName = 'ano'
      Origin = 'ano'
      ReadOnly = True
      Size = 4
    end
    object Grafico_Geralmes: TStringField
      FieldName = 'mes'
      Origin = 'mes'
      ReadOnly = True
      Size = 2
    end
    object Grafico_Geralmes_extenso: TStringField
      FieldName = 'mes_extenso'
      Origin = 'mes_extenso'
      ReadOnly = True
      Size = 8
    end
    object Grafico_Geralquant_total: TFMTBCDField
      FieldName = 'quant_total'
      Origin = 'quant_total'
      ReadOnly = True
      Precision = 38
      Size = 2
    end
    object Grafico_Geralmenor_valor: TBCDField
      FieldName = 'menor_valor'
      Origin = 'menor_valor'
      ReadOnly = True
      Precision = 10
      Size = 2
    end
    object Grafico_Geralmaior_valor: TBCDField
      FieldName = 'maior_valor'
      Origin = 'maior_valor'
      ReadOnly = True
      Precision = 10
      Size = 2
    end
    object Grafico_Geraltot_produtores_aponta: TIntegerField
      FieldName = 'tot_produtores_aponta'
      Origin = 'tot_produtores_aponta'
      ReadOnly = True
    end
    object Grafico_Geraltot_produtores: TIntegerField
      FieldName = 'tot_produtores'
      Origin = 'tot_produtores'
      ReadOnly = True
    end
  end
  object Unidade_Medida: TFDQuery
    Connection = connection
    SQL.Strings = (
      'select * from unidade_medida')
    Left = 72
    Top = 368
    object Unidade_Medidaid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object Unidade_Medidasigla: TStringField
      FieldName = 'sigla'
      Origin = 'sigla'
      Size = 4
    end
    object Unidade_Medidanome: TStringField
      FieldName = 'nome'
      Origin = 'nome'
      Size = 50
    end
  end
  object Relat_Mes_Prods_Consumo_Venda: TFDQuery
    Connection = connection
    SQL.Strings = (
      ''
      'select v.* from ('
      ''
      'select '
      #9'v.*,'
      #9#9'(select  min(valor)'
      #9' from  registro_producao rp2 inner join areas_producao ap2 on'
      #9#9'ap2.id = rp2.id_area_prod inner join produtores p2 on'
      #9#9'p2.id = ap2.id_produtor'
      #9' where '
      
        #9#9'substring(cast(rp2.data_producao as varchar), 6, 2) + '#39'/'#39' + su' +
        'bstring(cast(rp2.data_producao as varchar), 1, 4) = :mes and'
      #9#9'ap2.id_produtor = v.id'
      #9') menor_valor_produtor,'
      #9'(select  max(valor)'
      #9' from  registro_producao rp2 inner join areas_producao ap2 on'
      #9#9'ap2.id = rp2.id_area_prod inner join produtores p2 on'
      #9#9'p2.id = ap2.id_produtor'
      #9' where '
      
        #9#9'substring(cast(rp2.data_producao as varchar), 6, 2) + '#39'/'#39' + su' +
        'bstring(cast(rp2.data_producao as varchar), 1, 4) = :mes and'
      #9#9'ap2.id_produtor = v.id'
      #9') maior_valor_produtor,'
      ''
      #9'(select  min(valor)'
      #9' from  registro_producao rp2 inner join areas_producao ap2 on'
      #9#9'ap2.id = rp2.id_area_prod inner join produtores p2 on'
      #9#9'p2.id = ap2.id_produtor'
      #9' where '
      
        #9#9'substring(cast(rp2.data_producao as varchar), 6, 2) + '#39'/'#39' + su' +
        'bstring(cast(rp2.data_producao as varchar), 1, 4) = :mes '
      #9') menor_valor_geral,'
      ''
      #9'(select  max(valor)'
      #9' from  registro_producao rp2 inner join areas_producao ap2 on'
      #9#9'ap2.id = rp2.id_area_prod inner join produtores p2 on'
      #9#9'p2.id = ap2.id_produtor'
      #9' where '
      
        #9#9'substring(cast(rp2.data_producao as varchar), 6, 2) + '#39'/'#39' + su' +
        'bstring(cast(rp2.data_producao as varchar), 1, 4) = :mes '
      #9') maior_valor_geral'
      'from V_CONSUMO_VENDA_MES v'
      'where'
      #9'v.mes_ano = :mes and'
      '    v.id_regiao = :regiao'
      'union all '
      'select '
      '    p.id,'
      #9'u.nome_usuario,'
      #9'i.id id_instituicao,'
      #9'ra.id id_regiao,'
      'c.id id_comunidade,'
      #9'i.nome_instituicao,'
      #9'ra.nome_regiao,'
      #9'c.nome_comunidade,'
      #9'c.uf,'
      #9'c.municipio,'
      #9#39#39' tipo_prod ,'
      #9':mes mes_ano,'
      #9#39'01'#39' dia,'
      #9'0 quant_total,'
      #9'0 valor_tot,'
      #9'0 menor_valor_produtor,'
      #9'0 maior_valor_produtor,'
      #9'0 maior_valor_geral,'
      #9'0 menor_valor_geral'
      'from'
      #9'instituicoes i inner join '
      #9'regioes_atendimento ra on'
      #9'ra.id_instituicao = i.id inner join'
      #9'comunidades c on'
      #9'c.id_regiao = ra.id inner join'
      #9'produtores p on'
      #9'p.id_comunidade = c.id inner join'
      #9'usuarios u on'
      #9'u.id = p.id_usuario'
      'where '
      '    ra.id = :regiao and '
      #9'not exists ('
      #9#9'select * from registro_producao p2, areas_producao ap where'
      #9#9'p2.id_area_prod = ap.id and'
      #9#9'ap.id_produtor = p.id and'
      
        #9#9'substring(cast(p2.data_producao as varchar), 6, 2) + '#39'/'#39' + sub' +
        'string(cast(p2.data_producao as varchar), 1, 4) = :mes'
      #9')'
      ') v'
      'order by '
      #9#9' v.id_comunidade, v.id, v.mes_ano, v.dia'
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      '')
    Left = 528
    Top = 336
    ParamData = <
      item
        Name = 'MES'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'REGIAO'
        DataType = ftInteger
        ParamType = ptInput
      end>
    object Relat_Mes_Prods_Consumo_Vendaid: TIntegerField
      FieldName = 'id'
      Origin = 'id'
      Required = True
    end
    object Relat_Mes_Prods_Consumo_Vendanome_usuario: TStringField
      FieldName = 'nome_usuario'
      Origin = 'nome_usuario'
      Size = 50
    end
    object Relat_Mes_Prods_Consumo_Vendanome_instituicao: TStringField
      FieldName = 'nome_instituicao'
      Origin = 'nome_instituicao'
      Required = True
      Size = 50
    end
    object Relat_Mes_Prods_Consumo_Vendanome_regiao: TStringField
      FieldName = 'nome_regiao'
      Origin = 'nome_regiao'
      Size = 50
    end
    object Relat_Mes_Prods_Consumo_Vendanome_comunidade: TStringField
      FieldName = 'nome_comunidade'
      Origin = 'nome_comunidade'
      Required = True
      Size = 50
    end
    object Relat_Mes_Prods_Consumo_Vendatipo_prod: TStringField
      FieldName = 'tipo_prod'
      Origin = 'tipo_prod'
      Required = True
      FixedChar = True
      Size = 1
    end
    object Relat_Mes_Prods_Consumo_Vendames_ano: TStringField
      FieldName = 'mes_ano'
      Origin = 'mes_ano'
      ReadOnly = True
      Size = 7
    end
    object Relat_Mes_Prods_Consumo_Vendadia: TStringField
      FieldName = 'dia'
      Origin = 'dia'
      ReadOnly = True
      Size = 2
    end
    object Relat_Mes_Prods_Consumo_Vendaquant_total: TFMTBCDField
      FieldName = 'quant_total'
      Origin = 'quant_total'
      Precision = 38
      Size = 2
    end
    object Relat_Mes_Prods_Consumo_Vendavalor_tot: TFMTBCDField
      FieldName = 'valor_tot'
      Origin = 'valor_tot'
      Precision = 38
      Size = 2
    end
    object Relat_Mes_Prods_Consumo_Vendamenor_valor_produtor: TBCDField
      FieldName = 'menor_valor_produtor'
      Origin = 'menor_valor_produtor'
      ReadOnly = True
      Precision = 10
      Size = 2
    end
    object Relat_Mes_Prods_Consumo_Vendamaior_valor_produtor: TBCDField
      FieldName = 'maior_valor_produtor'
      Origin = 'maior_valor_produtor'
      ReadOnly = True
      Precision = 10
      Size = 2
    end
    object Relat_Mes_Prods_Consumo_Vendamenor_valor_geral: TBCDField
      FieldName = 'menor_valor_geral'
      Origin = 'menor_valor_geral'
      ReadOnly = True
      Precision = 10
      Size = 2
    end
    object Relat_Mes_Prods_Consumo_Vendamaior_valor_geral: TBCDField
      FieldName = 'maior_valor_geral'
      Origin = 'maior_valor_geral'
      ReadOnly = True
      Precision = 10
      Size = 2
    end
    object Relat_Mes_Prods_Consumo_Vendaid_instituicao: TIntegerField
      FieldName = 'id_instituicao'
      Origin = 'id_instituicao'
      ReadOnly = True
      Required = True
    end
    object Relat_Mes_Prods_Consumo_Vendaid_regiao: TIntegerField
      FieldName = 'id_regiao'
      Origin = 'id_regiao'
      ReadOnly = True
      Required = True
    end
    object Relat_Mes_Prods_Consumo_Vendaid_comunidade: TIntegerField
      FieldName = 'id_comunidade'
      Origin = 'id_comunidade'
      ReadOnly = True
      Required = True
    end
    object Relat_Mes_Prods_Consumo_Vendauf: TStringField
      FieldName = 'uf'
      Origin = 'uf'
      ReadOnly = True
      Required = True
      FixedChar = True
      Size = 2
    end
    object Relat_Mes_Prods_Consumo_Vendamunicipio: TStringField
      FieldName = 'municipio'
      Origin = 'municipio'
      ReadOnly = True
      Required = True
      Size = 50
    end
  end
  object Relat_Mes_Prods_Consumo_Venda2: TFDQuery
    Connection = connection
    SQL.Strings = (
      ''
      'select v.* from ('
      ''
      'select '
      #9'v.*,'
      #9#9'(select  min(valor)'
      #9' from  registro_producao rp2 inner join areas_producao ap2 on'
      #9#9'ap2.id = rp2.id_area_prod inner join produtores p2 on'
      #9#9'p2.id = ap2.id_produtor'
      #9' where '
      
        #9#9'substring(cast(rp2.data_producao as varchar), 6, 2) + '#39'/'#39' + su' +
        'bstring(cast(rp2.data_producao as varchar), 1, 4) = :mes and'
      #9#9'ap2.id_produtor = v.id'
      #9') menor_valor_produtor,'
      #9'(select  max(valor)'
      #9' from  registro_producao rp2 inner join areas_producao ap2 on'
      #9#9'ap2.id = rp2.id_area_prod inner join produtores p2 on'
      #9#9'p2.id = ap2.id_produtor'
      #9' where '
      
        #9#9'substring(cast(rp2.data_producao as varchar), 6, 2) + '#39'/'#39' + su' +
        'bstring(cast(rp2.data_producao as varchar), 1, 4) = :mes and'
      #9#9'ap2.id_produtor = v.id'
      #9') maior_valor_produtor,'
      ''
      #9'(select  min(valor)'
      #9' from  registro_producao rp2 inner join areas_producao ap2 on'
      #9#9'ap2.id = rp2.id_area_prod inner join produtores p2 on'
      #9#9'p2.id = ap2.id_produtor'
      #9' where '
      
        #9#9'substring(cast(rp2.data_producao as varchar), 6, 2) + '#39'/'#39' + su' +
        'bstring(cast(rp2.data_producao as varchar), 1, 4) = :mes '
      #9') menor_valor_geral,'
      ''
      #9'(select  max(valor)'
      #9' from  registro_producao rp2 inner join areas_producao ap2 on'
      #9#9'ap2.id = rp2.id_area_prod inner join produtores p2 on'
      #9#9'p2.id = ap2.id_produtor'
      #9' where '
      
        #9#9'substring(cast(rp2.data_producao as varchar), 6, 2) + '#39'/'#39' + su' +
        'bstring(cast(rp2.data_producao as varchar), 1, 4) = :mes '
      #9') maior_valor_geral'
      'from V_CONSUMO_VENDA_MES v'
      'where'
      #9'v.mes_ano = :mes and'
      '    v.id_regiao = :regiao and'
      #9'v.id_comunidade = :comunidade'
      'union all '
      'select '
      '    p.id,'
      #9'u.nome_usuario,'
      #9'i.id id_instituicao,'
      #9'ra.id id_regiao,'
      #9'c.id id_comunidade,'
      #9'i.nome_instituicao,'
      #9'ra.nome_regiao,'
      #9'c.nome_comunidade,'
      #9'c.uf, '
      #9'c.municipio,'
      #9#39#39' tipo_prod ,'
      #9':mes mes_ano,'
      #9#39'01'#39' dia,'
      #9'0 quant_total,'
      #9'0 valor_tot,'
      #9'0 menor_valor_produtor,'
      #9'0 maior_valor_produtor,'
      #9'0 maior_valor_geral,'
      #9'0 menor_valor_geral'
      'from'
      #9'instituicoes i inner join '
      #9'regioes_atendimento ra on'
      #9'ra.id_instituicao = i.id inner join'
      #9'comunidades c on'
      #9'c.id_regiao = ra.id inner join'
      #9'produtores p on'
      #9'p.id_comunidade = c.id inner join'
      #9'usuarios u on'
      #9'u.id = p.id_usuario'
      'where '
      '    ra.id = :regiao and '
      #9'c.id = :comunidade and'
      #9'not exists ('
      #9#9'select * from registro_producao p2, areas_producao ap where'
      #9#9'p2.id_area_prod = ap.id and'
      #9#9'ap.id_produtor = p.id and'
      
        #9#9'substring(cast(p2.data_producao as varchar), 6, 2) + '#39'/'#39' + sub' +
        'string(cast(p2.data_producao as varchar), 1, 4) = :mes'
      #9')'
      ') v'
      'order by '
      #9#9' v.id_comunidade, v.id, v.mes_ano, v.dia'
      '')
    Left = 528
    Top = 384
    ParamData = <
      item
        Name = 'MES'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'REGIAO'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Name = 'COMUNIDADE'
        DataType = ftString
        ParamType = ptInput
      end>
    object IntegerField2: TIntegerField
      FieldName = 'id'
      Origin = 'id'
      Required = True
    end
    object StringField2: TStringField
      FieldName = 'nome_usuario'
      Origin = 'nome_usuario'
      Size = 50
    end
    object StringField3: TStringField
      FieldName = 'nome_instituicao'
      Origin = 'nome_instituicao'
      Required = True
      Size = 50
    end
    object StringField4: TStringField
      FieldName = 'nome_regiao'
      Origin = 'nome_regiao'
      Size = 50
    end
    object StringField5: TStringField
      FieldName = 'nome_comunidade'
      Origin = 'nome_comunidade'
      Required = True
      Size = 50
    end
    object StringField6: TStringField
      FieldName = 'tipo_prod'
      Origin = 'tipo_prod'
      Required = True
      FixedChar = True
      Size = 1
    end
    object StringField7: TStringField
      FieldName = 'mes_ano'
      Origin = 'mes_ano'
      ReadOnly = True
      Size = 7
    end
    object StringField8: TStringField
      FieldName = 'dia'
      Origin = 'dia'
      ReadOnly = True
      Size = 2
    end
    object FMTBCDField1: TFMTBCDField
      FieldName = 'quant_total'
      Origin = 'quant_total'
      Precision = 38
      Size = 2
    end
    object FMTBCDField2: TFMTBCDField
      FieldName = 'valor_tot'
      Origin = 'valor_tot'
      Precision = 38
      Size = 2
    end
    object BCDField2: TBCDField
      FieldName = 'menor_valor_produtor'
      Origin = 'menor_valor_produtor'
      ReadOnly = True
      Precision = 10
      Size = 2
    end
    object BCDField3: TBCDField
      FieldName = 'maior_valor_produtor'
      Origin = 'maior_valor_produtor'
      ReadOnly = True
      Precision = 10
      Size = 2
    end
    object BCDField4: TBCDField
      FieldName = 'menor_valor_geral'
      Origin = 'menor_valor_geral'
      ReadOnly = True
      Precision = 10
      Size = 2
    end
    object BCDField5: TBCDField
      FieldName = 'maior_valor_geral'
      Origin = 'maior_valor_geral'
      ReadOnly = True
      Precision = 10
      Size = 2
    end
    object IntegerField3: TIntegerField
      FieldName = 'id_instituicao'
      Origin = 'id_instituicao'
      ReadOnly = True
      Required = True
    end
    object IntegerField4: TIntegerField
      FieldName = 'id_regiao'
      Origin = 'id_regiao'
      ReadOnly = True
      Required = True
    end
    object Relat_Mes_Prods_Consumo_Venda2id_comunidade: TIntegerField
      FieldName = 'id_comunidade'
      Origin = 'id_comunidade'
      ReadOnly = True
      Required = True
    end
    object Relat_Mes_Prods_Consumo_Venda2uf: TStringField
      FieldName = 'uf'
      Origin = 'uf'
      ReadOnly = True
      Required = True
      FixedChar = True
      Size = 2
    end
    object Relat_Mes_Prods_Consumo_Venda2municipio: TStringField
      FieldName = 'municipio'
      Origin = 'municipio'
      ReadOnly = True
      Required = True
      Size = 50
    end
  end
  object SQL_GERAL: TFDQuery
    Connection = connection
    Left = 584
    Top = 40
  end
  object Resumo_venda_mes: TFDQuery
    Connection = connection
    SQL.Strings = (
      'select '
      #9'sum(quantidade) quant_total,'
      #9'sum(valor) valor_total'
      'from '
      #9'registro_producao rp inner join'
      #9'areas_producao ap on'
      #9'ap.id = rp.id_area_prod inner join'
      #9'produtores p on'
      #9'p.id = ap.id_produtor inner join'
      #9'comunidades c on'
      #9'c.id = p.id_comunidade'
      'where'
      #9'p.id_comunidade = :id and'
      #9'substring(cast(rp.data_producao as varchar), 1, 4) = :ano and'
      
        #9'substring(cast(rp.data_producao as varchar), 6, 2) in (:mes) an' +
        'd'
      #9'rp.tipo_prod = '#39'V'#39' and'
      #9'rp.valor = (select '
      #9#9#9#9#9'min(valor)'
      #9#9#9#9'from '
      #9#9#9#9#9'registro_producao rp inner join'
      #9#9#9#9#9'areas_producao ap on'
      #9#9#9#9#9'ap.id = rp.id_area_prod inner join'
      #9#9#9#9#9'produtores p on'
      #9#9#9#9#9'p.id = ap.id_produtor inner join'
      #9#9#9#9#9'comunidades c on'
      #9#9#9#9#9'c.id = p.id_comunidade'
      #9#9#9#9'where'
      #9#9#9#9#9'p.id_comunidade = :id and'
      
        #9#9#9#9#9'substring(cast(rp.data_producao as varchar), 1, 4) = :ano a' +
        'nd'
      
        #9#9#9#9#9'substring(cast(rp.data_producao as varchar), 6, 2) in (:mes' +
        ') and'
      #9#9#9#9#9'rp.tipo_prod = '#39'V'#39
      #9')'
      'group by '
      #9'rp.tipo_prod, valor')
    Left = 352
    Top = 368
    ParamData = <
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'ANO'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'MES'
        DataType = ftString
        ParamType = ptInput
      end>
  end
  object Max_Resumo_venda_mes: TFDQuery
    Connection = connection
    SQL.Strings = (
      'select '
      #9'sum(quantidade) quant_total,'
      #9'sum(valor) valor_total'
      'from '
      #9'registro_producao rp inner join'
      #9'areas_producao ap on'
      #9'ap.id = rp.id_area_prod inner join'
      #9'produtores p on'
      #9'p.id = ap.id_produtor inner join'
      #9'comunidades c on'
      #9'c.id = p.id_comunidade'
      'where'
      #9'p.id_comunidade = :id and'
      #9'substring(cast(rp.data_producao as varchar), 1, 4) = :ano and'
      
        #9'substring(cast(rp.data_producao as varchar), 6, 2) in (:mes) an' +
        'd'
      #9'rp.tipo_prod = '#39'V'#39' and'
      #9'rp.valor = (select '
      #9#9#9#9#9'max(valor)'
      #9#9#9#9'from '
      #9#9#9#9#9'registro_producao rp inner join'
      #9#9#9#9#9'areas_producao ap on'
      #9#9#9#9#9'ap.id = rp.id_area_prod inner join'
      #9#9#9#9#9'produtores p on'
      #9#9#9#9#9'p.id = ap.id_produtor inner join'
      #9#9#9#9#9'comunidades c on'
      #9#9#9#9#9'c.id = p.id_comunidade'
      #9#9#9#9'where'
      #9#9#9#9#9'p.id_comunidade = :id and'
      
        #9#9#9#9#9'substring(cast(rp.data_producao as varchar), 1, 4) = :ano a' +
        'nd'
      
        #9#9#9#9#9'substring(cast(rp.data_producao as varchar), 6, 2) in (:mes' +
        ') and'
      #9#9#9#9#9'rp.tipo_prod = '#39'V'#39
      #9')'
      'group by '
      #9'rp.tipo_prod, valor')
    Left = 344
    Top = 424
    ParamData = <
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'ANO'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'MES'
        DataType = ftString
        ParamType = ptInput
      end>
  end
end
