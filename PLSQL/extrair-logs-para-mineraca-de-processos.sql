/**************************************************************************
      APAGA TABELAS UTILIZADAS PARA A ANÁLISE                          
**************************************************************************/
DROP TABLE temporocorrenciasselecionadas;

DROP TABLE tempsolicitacaoitemtrabalho;

DROP TABLE tempOcorrenciaItemTrabalho;

DROP TABLE tempanaliseocorrencias;

DROP TABLE tempEventLogforProcessMiningbyArea;




/**************************************************************************
      CRIAÇÃO DAS TABELAS TEMPORÁRIAS NECESSÁRIAS PARA A ANÁLISE       --
**************************************************************************/

/*ESTRUTURA PARA TRATAR  AS  OCORRENCIAS DUPLICADAS*/
CREATE TABLE temporocorrenciasselecionadas
(
  idocorrencia integer,
  categoria character varying(20),
  idsolicitacaoservico bigint,
  iditemtrabalho bigint,
  dataregistro date,
  horaregistro character varying(5),
  datahora TIMESTAMP without time zone,
  selecionada bit,
  situacaosolicitacao  character varying(20),
  idgrupo   character varying(20)
);

/* CRIA ESTRURA PARA RECEBER OS DADOS DE LOG DO WORKFLOW DO PROCESSO DE 
ATENDIMENTO DOS CHAMADOS ESSES DADOS SERÃO UTILIZADOS PARA IDENTIFICAR 
O GRUPO EXECUTOR E O TÉCNICO QUE ATUOU EM CADA ETAPA DO CHAMADO
*/
CREATE TABLE tempsolicitacaoitemtrabalho
(
  id serial NOT NULL,
  idsolicitacaoservico integer,
  iditemtrabalho integer,
  idresponsavelitemtrabalho integer,
  nomeresponsavel character varying(100),
  datahoracriacaoitemtrabalho TIMESTAMP without time zone,
  datahorainicioitemtrabalho TIMESTAMP without time zone,
  situacaoitemtrabalho character varying(100),
  datahorafinalizacao TIMESTAMP without time zone,
  idgrupoexecutor integer,
  nomegrupoexecutoratual character varying(100),
  arearesponsavel character varying(100),
  idfluxo integer,
  nomefluxo character varying(100),
  versao character varying(10)
);

/* 
CRIA ESTRURA PARA RECEBER A CORRELAÇAO DA OCORRENCIA COM OS RESPECTIVOS ITENS DE TRABALHO
*/
CREATE   TABLE tempOcorrenciaItemTrabalho 
(
	id Serial,
	idsolicitacaoservico integer, 
	idocorrencia integer, 
	dataocorrencia TIMESTAMP, 
	iditemtrabalho integer
);


/* 
CRIA ESTRURA PARA RECEBER AS OCORRÊNCIAS SELECIONADAS PARA A GERAÇÃO DOS LOGS PARA MINERAÇÃO
*/
CREATE TABLE tempanaliseocorrencias
(
  idsolicitacaoservico integer,
  situacaoatual character varying(30),
  idocorrencia integer,
  categoriaocorrencia character varying(30),
  transicao character varying(30),
  dataocorrencia TIMESTAMP without time zone,
  situacaosolicitacao character varying(30),
  idgrupoexecutor integer,
  nomegrupoexecutor character varying(100),
  arearesponsavel character varying(100),
  idtecnico integer,
  nometecnico character varying(100),
  idfluxo integer,
  nomefluxo character varying(100),
  versao character varying(10),
  idgrupoexecutoroc integer,
  nomegrupoexecutoroc character varying(100),
  areaoc character varying(100),
  datainicio TIMESTAMP without time zone,
  datafim TIMESTAMP without time zone,
  tempoutil interval,
  tempoutildecimal numeric,
  tempoutilacumuladoinicio interval,
  tempoutildecimalacumuladoinicio numeric,
  tempoutilacumuladotermino interval,
  tempoutildecimalacumuladotermino numeric,
  atividade character varying(100),
  agrupamentoregistrosporarea integer
);


/* 
CRIA ESTRURA PARA RECEBER AS OS EVENTOS DE LOG GERADOS POR ATIVIDADE E ÁREA RESPONSÁVEIS PELA ATIVIDADES
*/

CREATE TABLE tempEventLogforProcessMiningbyArea
(       nomefluxo  character varying(200),
	situacaosolicitacao character varying(30),
	event_Id serial,
	case_id integer,  
	agrupamento integer, 
	activityInstance_Name character varying(100), 
	event_Transition character varying(30),
	org_group character varying(100), 
	role_name character varying(100), 
	resource_name character varying(100), 
	event_timeStamp timestamp without time zone
);

/* 
 AJUSTA OS DADOS DAS ÁREAS DOS GRUPOS EXECUTORES
*/

UPDATE GRUPO SET DESCRICAO = '[AREA=DTI-CGSIS]' WHERE nome = 'GR_Sistema_Corporativo_CGSIS';
UPDATE GRUPO SET DESCRICAO = '[AREA=CIT-INFRA]' WHERE nome = 'GR_CentralIT_Segurança';
UPDATE GRUPO SET DESCRICAO = '[AREA=CIT-INFRA]' WHERE nome = 'GR_CentralIT_SisColab';
UPDATE GRUPO SET DESCRICAO = '[AREA=CIT-INFRA]' WHERE nome = 'GR_CentralIT_Storage';
UPDATE GRUPO SET DESCRICAO = '[AREA=CIT-INFRA]' WHERE nome = 'GR_CentralIT_Virtualização';
UPDATE GRUPO SET DESCRICAO = '[AREA=DTI-CGSIS]' WHERE nome = 'GR_CGSIS_Engenharia';
UPDATE GRUPO SET DESCRICAO = '[AREA=CIT-PRES-DF]' WHERE nome = 'GR_CentralIT_Bloco_C';
UPDATE GRUPO SET DESCRICAO = '[AREA=DTI-CGSIS]' WHERE nome = 'GR_CGSIS_Entrega';
UPDATE GRUPO SET DESCRICAO = '[AREA=DTI-CGSIS]' WHERE nome = 'GR_CGSIS_Estruturação';
UPDATE GRUPO SET DESCRICAO = '[AREA=DTI-CGSIS]' WHERE nome = 'GR_Gerencia_Configuração_CGSIS';
UPDATE GRUPO SET DESCRICAO = '[AREA=DTI-INFRA]' WHERE nome = 'GR_Infra-DTI_Backup';
UPDATE GRUPO SET DESCRICAO = '[AREA=DTI-INFRA]' WHERE nome = 'GR_Infra-DTI_BancoDados';
UPDATE GRUPO SET DESCRICAO = '[AREA=DTI-INFRA]' WHERE nome = 'GR_Infra-DTI_Outros';
UPDATE GRUPO SET DESCRICAO = '[AREA=DTI-INFRA]' WHERE nome = 'GR_Infra-DTI-RAC-ICS';
UPDATE GRUPO SET DESCRICAO = '[AREA=DTI-INFRA]' WHERE nome = 'GR_Infra-DTI_Redes';
UPDATE GRUPO SET DESCRICAO = '[AREA=DTI-INFRA]' WHERE nome = 'GR_Infra-DTI_Servidores';
UPDATE GRUPO SET DESCRICAO = '[AREA=DTI-INFRA]' WHERE nome = 'GR_Infra-DTI_Sistemas';
UPDATE GRUPO SET DESCRICAO = '[AREA=DTI-INFRA]' WHERE nome = 'GR_Infra-DTI-Storage';
UPDATE GRUPO SET DESCRICAO = '[AREA=DTI-INFRA]' WHERE nome = 'GR_Infra-DTI_Virtualização';
UPDATE GRUPO SET DESCRICAO = '[AREA=DTI-SEGURANÇA]' WHERE nome = 'GR_Segurança_Abuse';
UPDATE GRUPO SET DESCRICAO = '[AREA=DTI-SEGURANÇA]' WHERE nome = 'GR_Segurança_ETIR';
UPDATE GRUPO SET DESCRICAO = '[AREA=DTI-SEGURANÇA]' WHERE nome = 'GR_Segurança_Outros';
UPDATE GRUPO SET DESCRICAO = '[AREA=DTI-SEGURANÇA]' WHERE nome = 'GR_Segurança_Redes';
UPDATE GRUPO SET DESCRICAO = '[AREA=DTI-SEGURANÇA]' WHERE nome = 'GR_Segurança_Software';
UPDATE GRUPO SET DESCRICAO = '[AREA=DTI-SUPORTE]' WHERE nome = 'GR_Suporte_Impressoras';
UPDATE GRUPO SET DESCRICAO = '[AREA=DTI-SUPORTE]' WHERE nome = 'GR_Suporte_Outros';
UPDATE GRUPO SET DESCRICAO = '[AREA=DTI-SUPORTE]' WHERE nome = 'GR_Suporte_Redes ';
UPDATE GRUPO SET DESCRICAO = '[AREA=DTI-SUPORTE]' WHERE nome = 'GR_Suporte_Software';
UPDATE GRUPO SET DESCRICAO = '[AREA=DTI-SUPORTE]' WHERE nome = 'GR_Suporte_VideoConferência';
UPDATE GRUPO SET DESCRICAO = '[AREA=CIT-PRES-DF]' WHERE nome = 'GR_CentralIT_Bloco_K';
UPDATE GRUPO SET DESCRICAO = '[AREA=CIT-VIDEOCONF]' WHERE nome = 'GR_CentralIT_VideoConferência';
UPDATE GRUPO SET DESCRICAO = '[AREA=OUTROS]' WHERE nome = '3º NÍVEL - Aplicação';
UPDATE GRUPO SET DESCRICAO = '[AREA=DIPAT]' WHERE nome = 'GR_DIPAT';
UPDATE GRUPO SET DESCRICAO = '[AREA=OUTROS]' WHERE nome = '3º NÍVEL - Infraestrutura';
UPDATE GRUPO SET DESCRICAO = '[AREA=OUTROS]' WHERE nome = '3º NÍVEL - Sistemas';
UPDATE GRUPO SET DESCRICAO = '[AREA=OUTROS]' WHERE nome = '3º NÍVEL - Telefonia';
UPDATE GRUPO SET DESCRICAO = '[AREA=OUTROS]' WHERE nome = 'Coordenação Geral';
UPDATE GRUPO SET DESCRICAO = '[AREA=OUTROS]' WHERE nome = 'Coordenador';
UPDATE GRUPO SET DESCRICAO = '[AREA=OUTROS]' WHERE nome = 'Coordenadores Externos';
UPDATE GRUPO SET DESCRICAO = '[AREA=OUTROS]' WHERE nome = 'Desenvolvimento';
UPDATE GRUPO SET DESCRICAO = '[AREA=OUTROS]' WHERE nome = 'Gerentes';
UPDATE GRUPO SET DESCRICAO = '[AREA=OUTROS]' WHERE nome = 'Gestores Internos';
UPDATE GRUPO SET DESCRICAO = '[AREA=OUTROS]' WHERE nome = 'GR_AUTORIZ_COGEP';
UPDATE GRUPO SET DESCRICAO = '[AREA=OUTROS]' WHERE nome = 'GR_AUTORIZ_CONJUR';
UPDATE GRUPO SET DESCRICAO = '[AREA=OUTROS]' WHERE nome = 'GR_AUTORIZ_DEPEX';
UPDATE GRUPO SET DESCRICAO = '[AREA=OUTROS]' WHERE nome = 'GR_AUTORIZ_DEST';
UPDATE GRUPO SET DESCRICAO = '[AREA=OUTROS]' WHERE nome = 'GR_AUTORIZ_DIPLA';
UPDATE GRUPO SET DESCRICAO = '[AREA=OUTROS]' WHERE nome = 'GR_AUTORIZ_DIRAD';
UPDATE GRUPO SET DESCRICAO = '[AREA=OUTROS]' WHERE nome = 'GR_AUTORIZ_DTI';
UPDATE GRUPO SET DESCRICAO = '[AREA=OUTROS]' WHERE nome = 'GR_AUTORIZ_GAB_SE';
UPDATE GRUPO SET DESCRICAO = '[AREA=OUTROS]' WHERE nome = 'GR_AUTORIZ_GERAL';
UPDATE GRUPO SET DESCRICAO = '[AREA=OUTROS]' WHERE nome = 'GR_AUTORIZ_GM';
UPDATE GRUPO SET DESCRICAO = '[AREA=OUTROS]' WHERE nome = 'GR_AUTORIZ_SEAIN';
UPDATE GRUPO SET DESCRICAO = '[AREA=OUTROS]' WHERE nome = 'GR_AUTORIZ_SEGEP';
UPDATE GRUPO SET DESCRICAO = '[AREA=OUTROS]' WHERE nome = 'GR_AUTORIZ_SEPAC';
UPDATE GRUPO SET DESCRICAO = '[AREA=CIT-INFRA]' WHERE nome = 'GR_CentralIT_Adm_Contrato';
UPDATE GRUPO SET DESCRICAO = '[AREA=OUTROS]' WHERE nome = 'GR_SistemaGPD';
UPDATE GRUPO SET DESCRICAO = '[AREA=CIT-INFRA]' WHERE nome = 'GR_CentralIT_Aplicações';
UPDATE GRUPO SET DESCRICAO = '[AREA=CIT-INFRA]' WHERE nome = 'GR_CentralIT_Backup';
UPDATE GRUPO SET DESCRICAO = '[AREA=CIT-INFRA]' WHERE nome = 'GR_CentralIT_BancoDados';
UPDATE GRUPO SET DESCRICAO = '[AREA=CIT-INFRA]' WHERE nome = 'GR_CentralIT_Linux';
UPDATE GRUPO SET DESCRICAO = '[AREA=CIT-INFRA]' WHERE nome = 'GR_CentralIT_Monitoramento';
UPDATE GRUPO SET DESCRICAO = '[AREA=CIT-INFRA]' WHERE nome = 'GR_CentralIT_MSWindows';
UPDATE GRUPO SET DESCRICAO = '[AREA=CIT-INFRA]' WHERE nome = 'GR_CentralIT_NOC_CentroOperaçõesRede';
UPDATE GRUPO SET DESCRICAO = '[AREA=CIT-INFRA]' WHERE nome = 'GR_CentralIT_Outros';
UPDATE GRUPO SET DESCRICAO = '[AREA=CIT-INFRA]' WHERE nome = 'GR_CentralIT_Redes';
UPDATE GRUPO SET DESCRICAO = '[AREA=HPRINT]' WHERE nome = 'Gr_HPrint';
UPDATE GRUPO SET DESCRICAO = '[AREA=OUTROS]' WHERE nome = 'GR_AUTORIZ_SLTI';
UPDATE GRUPO SET DESCRICAO = '[AREA=OUTROS]' WHERE nome = 'GR_AUTORIZ_SOF';
UPDATE GRUPO SET DESCRICAO = '[AREA=OUTROS]' WHERE nome = 'GR_AUTORIZ_SPI';
UPDATE GRUPO SET DESCRICAO = '[AREA=OUTROS]' WHERE nome = 'GR_AUTORIZ_SPU_DF';
UPDATE GRUPO SET DESCRICAO = '[AREA=OUTROS]' WHERE nome = 'GR_AUTORIZ_SPU_OC';
UPDATE GRUPO SET DESCRICAO = '[AREA=OUTROS]' WHERE nome = 'GR_AUTORIZ_SRT';
UPDATE GRUPO SET DESCRICAO = '[AREA=OUTROS]' WHERE nome = 'GR_Representante_TI_CONJUR';
UPDATE GRUPO SET DESCRICAO = '[AREA=OUTROS]' WHERE nome = 'GR_Representante_TI_DIRAD';
UPDATE GRUPO SET DESCRICAO = '[AREA=OUTROS]' WHERE nome = 'GR_Representante_TI_FUNPRESP';
UPDATE GRUPO SET DESCRICAO = '[AREA=OUTROS]' WHERE nome = 'GR_Representante_TI_GM';
UPDATE GRUPO SET DESCRICAO = '[AREA=OUTROS]' WHERE nome = 'GR_Representante_TI_SE';
UPDATE GRUPO SET DESCRICAO = '[AREA=OUTROS]' WHERE nome = 'GR_Representante_TI_SEAIN';
UPDATE GRUPO SET DESCRICAO = '[AREA=OUTROS]' WHERE nome = 'GR_Representante_TI_SEGEP';
UPDATE GRUPO SET DESCRICAO = '[AREA=OUTROS]' WHERE nome = 'GR_Representante_TI_SEPAC';
UPDATE GRUPO SET DESCRICAO = '[AREA=OUTROS]' WHERE nome = 'GR_Representante_TI_SPI';
UPDATE GRUPO SET DESCRICAO = '[AREA=OUTROS]' WHERE nome = 'GR_Representante_TI_SPU_DF ';
UPDATE GRUPO SET DESCRICAO = '[AREA=OUTROS]' WHERE nome = 'GR_Representante_TI_SPU_OC';
UPDATE GRUPO SET DESCRICAO = '[AREA=OUTROS]' WHERE nome = 'GR_Representante_TI_SRT';
UPDATE GRUPO SET DESCRICAO = '[AREA=SISTEMA-SEI]' WHERE nome = 'GR_SistemaSEI';
UPDATE GRUPO SET DESCRICAO = '[AREA=OUTROS]' WHERE nome = 'Qualidade';
UPDATE GRUPO SET DESCRICAO = '[AREA=CIT-PRES-DF]' WHERE nome = 'GR_CentralIT_Presencial_DF';
UPDATE GRUPO SET DESCRICAO = '[AREA=DTI-ELETR/REDE]' WHERE nome = 'GR_RCS_Tecnologia_Finalização';
UPDATE GRUPO SET DESCRICAO = '[AREA=DTI-SUPORTE]' WHERE nome = 'GR_Suporte_Hardware';
UPDATE GRUPO SET DESCRICAO = '[AREA=DTI-SUPORTE]' WHERE nome = 'GR_Suporte_Senhas';
UPDATE GRUPO SET DESCRICAO = '[AREA=DTI-SUPORTE]' WHERE nome = 'GR_Suporte_Sistemas_Setoriais';
UPDATE GRUPO SET DESCRICAO = '[AREA=OUTROS]' WHERE nome = 'GR_Representante_TI_DEPEX-DF ';
UPDATE GRUPO SET DESCRICAO = '[AREA=OUTROS]' WHERE nome = 'Solicitante MPOG';
UPDATE GRUPO SET DESCRICAO = '[AREA=OUTROS]' WHERE nome = 'Supervisor';
UPDATE GRUPO SET DESCRICAO = '[AREA=RCS-TECNOLOGIA]' WHERE nome = 'GR_RCS_Tecnologia';
UPDATE GRUPO SET DESCRICAO = '[AREA=SERPRO]' WHERE nome = 'GR_CSS_SERPRO';
UPDATE GRUPO SET DESCRICAO = '[AREA=CIT-SISTEMAS]' WHERE nome = 'GR_CentralIT_Sistemas';
UPDATE GRUPO SET DESCRICAO = '[AREA=CIT-NIVEL1]' WHERE nome = 'GR_CentralIT_Atendimento_1ºNivel ';
UPDATE GRUPO SET DESCRICAO = '[AREA=DTI-ELETR/REDE]' WHERE nome = 'GR_Infra-DTI_EletricaEstabilizada e Rede logicaCabeada';
UPDATE GRUPO SET DESCRICAO = '[AREA=CIT-INFRA]' WHERE nome = 'GR_CentralIT_Gerencia_Configuração';


/*
SELECT IDGRUPO, NOME FROM GRUPO 
WHERE DESCRICAO  NOT LIKE '%AREA%'
ORDER BY NOME
*/


/**************************************************************************
       PREPARAÇÃO DOS DADOS NECESSÁRIOS PARA A ANÁLISE                  
***************************************************************************/
/*
OS SISTEMA CITSMART REGISTRO OCORRENCIAS DUPLICADAS COM MESMA DATAHORA EM VÁRIAS SITUAÇÕES, CONFORME PODER SER OBSERVADO 
NA CONSULTA ABAIXO, POR ESSE MOTIVO SERÁ NECESSÁRIO TRATAR OS CASOS DUPLICADOS PARA SELECIONAR APENAS A OCORRENCIA
RELEVANTE PARA O ESTUDO DO FLUXO DE ATENDIMENTO E PARA GERAÇÃO DO LOGO DE EVENTOS NECESSÁRIO PARA O ESTUDO DE MINERAÇÃO DE
PROCESSOS. MAIS MAIORIA DOS CASOS OS DIFERENTES CATEGORIA VEM SEGUIDO DE UM REGISTRO DE EXECUÇÃO, NESSES CASO SERÁ CONSIDERADA
A OCORRENCIA DE CATEGORIA DIFERENTE DE EXECUCAO.  
AS CATEGORIA DE OCORRENCIAS DE COMPARTILHAMENTO E AGENDAMENTO VEM SEMPRE ACOMPANHADAS DE OCORRENCIA DE EXECUÇÃO E SERÃO EXCLUÍDAS E 
MANTIDOS OS REGISTROS DE EXECUÇÃO.
AS OCORRENCIA DE RELACIONADAS AO SLA SERÃO TAMBÉM DESCONSIDERADAS, E SERÃO MANTIDAS  AS  OCORRENCIA DE CATEGORIA DIFERENTE QUE ACOMPANHAR.
*/

/*

SELECT 
"Criacao", "Reabertura", "InicioSLA", "Reclassificacao", "Direcionamento", "Execucao", "Encerramento",
"Suspensao","SuspensaoSLA","Reativacao", "ReativacaoSLA", "Agendamento", "Compartilhamento","MudancaSLA",   
COUNT(*)
FROM (
	SELECT idsolicitacaoservico, CAST(CONCAT(dataregistro,' ' , horaregistro)  AS  TIMESTAMP)  AS  "DataHora", 
	CASE WHEN COUNT(CASE WHEN categoria = 'Agendamento' THEN 1 ELSE NULL END) > 0 THEN 'X' ELSE '' END  AS  "Agendamento",
	CASE WHEN COUNT(CASE WHEN categoria = 'Compartilhamento' THEN 1 ELSE NULL END)  > 0 THEN 'X' ELSE '' END  AS  "Compartilhamento",
	CASE WHEN COUNT(CASE WHEN categoria = 'Criacao' THEN 1 ELSE NULL END)  > 0 THEN 'X' ELSE '' END  AS  "Criacao",
	CASE WHEN COUNT(CASE WHEN categoria = 'Direcionamento' THEN 1 ELSE NULL END)  > 0 THEN 'X' ELSE '' END  AS  "Direcionamento",
	CASE WHEN COUNT(CASE WHEN categoria = 'Encerramento' THEN 1 ELSE NULL END)  > 0 THEN 'X' ELSE '' END  AS  "Encerramento",
	CASE WHEN COUNT(CASE WHEN categoria = 'Execucao' THEN 1 ELSE NULL END)  > 0 THEN 'X' ELSE '' END  AS  "Execucao",
	CASE WHEN COUNT(CASE WHEN categoria = 'Reabertura' THEN 1 ELSE NULL END)  > 0 THEN 'X' ELSE '' END  AS  "Reabertura",
	CASE WHEN COUNT(CASE WHEN categoria = 'Reativacao' THEN 1 ELSE NULL END)  > 0 THEN 'X' ELSE '' END  AS  "Reativacao",
	CASE WHEN COUNT(CASE WHEN categoria = 'Reclassificacao' THEN 1 ELSE NULL END)  > 0 THEN 'X' ELSE '' END  AS  "Reclassificacao",
	CASE WHEN COUNT(CASE WHEN categoria = 'Suspensao' THEN 1 ELSE NULL END)  > 0 THEN 'X' ELSE '' END  AS  "Suspensao",
	CASE WHEN COUNT(CASE WHEN categoria = 'SuspensaoSLA' THEN 1 ELSE NULL END)  > 0 THEN 'X' ELSE '' END  AS  "SuspensaoSLA",
	CASE WHEN COUNT(CASE WHEN categoria = 'InicioSLA' THEN 1 ELSE NULL END)  > 0 THEN 'X' ELSE '' END  AS  "InicioSLA",
	CASE WHEN COUNT(CASE WHEN categoria = 'ReativacaoSLA' THEN 1 ELSE NULL END)  > 0 THEN 'X' ELSE '' END  AS  "ReativacaoSLA",
	CASE WHEN COUNT(CASE WHEN categoria = 'MudancaSLA' THEN 1 ELSE NULL END)  > 0 THEN 'X' ELSE '' END  AS  "MudancaSLA",
	COUNT(*)
	FROM ocorrenciasolicitacao
	WHERE idcategoriaocorrencia is null 
	GROUP BY idsolicitacaoservico, CAST(CONCAT(dataregistro,' ' , horaregistro)  AS  TIMESTAMP)
	HAVING COUNT(*) > 1
)  AS  OcorrenciaRepetidas
GROUP BY
"Criacao", "Reabertura", "InicioSLA", "Reclassificacao", "Direcionamento", "Execucao", "Encerramento",

"Suspensao","SuspensaoSLA","Reativacao", "ReativacaoSLA", "Agendamento", "Compartilhamento","MudancaSLA"
ORDER BY COUNT(*) DESC;

*/




/*
ESSA ESTRUTURA TEM COMO OBJETIVO POSSIBILITAR O TRATAMENTO DAS OCORRENCIA DUPLICADAS. 
TODAS  AS  OCORRENCIA SERÃO IMPORTADAS PARA ESSE TABELA E EM SEGUIDA SERÃO ELIMINADAS  AS  DUPLICADAS DE ACORDO COM A
A RELEVÂNCIA DA CATEGORIA DA OCORRENCIA.
*/

TRUNCATE TABLE temporocorrenciasselecionadas;

INSERT INTO temporocorrenciasselecionadas( 
idocorrencia,categoria,idsolicitacaoservico, iditemtrabalho, 
dataregistro, horaregistro,datahora,situacaosolicitacao , idgrupo)
SELECT idOcorrencia, categoria , idsolicitacaoservico, iditemtrabalho, 
dataregistro, horaregistro,  CAST(CONCAT(dataregistro,' ' , horaregistro)  AS  TIMESTAMP)  AS  DataHora,
CASE 
	WHEN categoria = 'Criacao' THEN 'Registrada' 
	WHEN categoria = 'Encerramento' THEN 'Fechada'
	ELSE  split_part(substring( dadossolicitacao FROM position('descrSituacao' in dadossolicitacao) +16 for 15), '"', 1) 
END  AS  situacaosolicitacao,
CASE 
	WHEN dadossolicitacao like '%GrupoAtual%' then replace(replace( substring( dadossolicitacao FROM position('GrupoAtual' in dadossolicitacao)+ 12 for 3),',',''),'"','')
	WHEN dadossolicitacao like '%idGrupo%' then replace(replace( substring( dadossolicitacao FROM position('idGrupo' in dadossolicitacao)+ 9 for 3),',',''),'"','')
	ELSE  '0' 
END AS  idgrupo
FROM ocorrenciasolicitacao
WHERE idcategoriaocorrencia is null --DESCONSIDERA APENAS OCORRENCIA DE ANOTAÇÃO TÉCNICA
ORDER BY idOcorrencia;


/*
MARCA  AS  OCORRENCIAS DE ABERTURA E ENCERRAMENTO EXECUTADAS SIMULTANEAMENTE COMO SELECIONADAS
*/
UPDATE temporocorrenciasselecionadas o SET   selecionada = CAST(1  AS  BIT), datahora =  CASE WHEN o.categoria = 'Criacao' THEN o.datahora - INTERVAL '1 min' ELSE o.datahora END
FROM (
	SELECT * 
	FROM temporocorrenciasselecionadas  AS  toc
	JOIN (
		SELECT idsolicitacaoservico, datahora , 
		COUNT(CASE WHEN categoria = 'Criacao' THEN 1 ELSE NULL END)  AS  "Criacao",
		COUNT(CASE WHEN categoria = 'InicioSLA' THEN 1 ELSE NULL END)   AS  "InicioSLA",
		COUNT(*) 
		FROM temporocorrenciasselecionadas
		WHERE selecionada IS NULL
		GROUP BY idsolicitacaoservico, datahora 
		HAVING COUNT(*)  = 2
		AND COUNT(CASE WHEN categoria = 'Criacao' THEN 1 ELSE NULL END)= 1
		AND COUNT(CASE WHEN categoria = 'InicioSLA' THEN 1 ELSE NULL END)  = 1
		AND COUNT(*)  = COUNT(CASE WHEN categoria = 'Criacao' THEN 1 ELSE NULL END) 
				+ COUNT(CASE WHEN categoria = 'InicioSLA' THEN 1 ELSE NULL END)		
	     )  AS  un ON un.idsolicitacaoservico = toc.idsolicitacaoservico
	     AND un.datahora = toc.datahora
	WHERE TOC.selecionada IS NULL
	AND toc.categoria IN('Criacao','InicioSLA')
	)  AS  T
WHERE T.idocorrencia = o.idocorrencia ;   

/*
MARCAS  AS  OCORRENCIA DE SLA COMO NÃO SELECIONADAS 
*/
UPDATE temporocorrenciasselecionadas SET  selecionada = CAST(0  AS  BIT)
--SELECT * FROM temporocorrenciasselecionadas
WHERE selecionada IS  NULL
AND UPPER(categoria) like '%SLA%'
AND UPPER(categoria) not like 'InicioSLA'; 

/*
MARCAS  AS  OCORRENCIA DE AGENDAMENTO COMO NÃO SELECIONADAS 
*/
UPDATE temporocorrenciasselecionadas SET  selecionada = CAST(0  AS  BIT)
--SELECT * FROM temporocorrenciasselecionadas
WHERE selecionada IS NULL
AND categoria = 'Agendamento';


/*
REPETIDAS MAS DE MESMA CATERGORIA, SELECIONA A PRIMEIRA OCORRENCIA
*/
UPDATE temporocorrenciasselecionadas o SET   selecionada = CASE WHEN o.idocorrencia =  menorocorrencia THEN CAST(1  AS  BIT) ELSE CAST(0  AS  BIT) END
FROM (
	SELECT * 
	FROM temporocorrenciasselecionadas  AS  toc
	JOIN (
		SELECT idsolicitacaoservico, datahora , COUNT (DISTINCT categoria)  AS  categorias,
		COUNT(*) ,
		MIN(idocorrencia)  AS  menorocorrencia
		FROM temporocorrenciasselecionadas
		WHERE selecionada IS NULL
		GROUP BY idsolicitacaoservico, datahora 
		HAVING COUNT(*)  >= 1
		AND COUNT (DISTINCT categoria) = 1
	     )  AS  un ON un.idsolicitacaoservico = toc.idsolicitacaoservico
	     AND un.datahora = toc.datahora
	WHERE TOC.selecionada IS NULL
	AND toc.categoria IN('Criacao','Execucao', 'Compartilhamento', 'Reclassificacao','Suspensao','Reativacao','Encerramento','Direcionamento','Reabertura')
	)  AS  T
WHERE T.idocorrencia = o.idocorrencia ;  



/*
DESMARCA OCORRENCIAS DE EXECUÇÃO QUANDO REPETIR COM OUTRA TIPO PRINCIPAL E HOUVER APENAS DOI TIPOS DE OCORRENCIA NA MESMA DATAHORA
*/
UPDATE temporocorrenciasselecionadas o SET   selecionada = CASE WHEN o.categoria = 'Execucao' THEN  CAST(0  AS  BIT) ELSE CAST(1  AS  BIT) END
FROM (
	SELECT * 
	FROM temporocorrenciasselecionadas  AS  toc
	JOIN (
		SELECT idsolicitacaoservico, datahora , COUNT(DISTINCT categoria )  AS  categorias,
		COUNT(CASE WHEN categoria IN('Compartilhamento', 'Reclassificacao','Suspensao','Reativacao','Encerramento','Direcionamento', 'Reabertura', 'Criacao') THEN 1 ELSE NULL END)  AS  "Outra",
		COUNT(CASE WHEN categoria = 'Execucao' THEN 1 ELSE NULL END)   AS  "Execucao",
		COUNT(*) 
		FROM temporocorrenciasselecionadas
		WHERE selecionada IS NULL
		GROUP BY idsolicitacaoservico, datahora 
		HAVING COUNT(*)  >= 2
		AND COUNT(DISTINCT categoria ) =2
		AND COUNT(CASE WHEN categoria IN('Compartilhamento', 'Reclassificacao','Suspensao','Reativacao','Encerramento','Direcionamento', 'Reabertura', 'Criacao') THEN 1 ELSE NULL END)= 1
		AND COUNT(CASE WHEN categoria = 'Execucao' THEN 1 ELSE NULL END)>= 1
		AND COUNT(*)  = COUNT(CASE WHEN categoria IN('Compartilhamento', 'Reclassificacao','Suspensao','Reativacao','Encerramento','Direcionamento', 'Reabertura', 'Criacao') THEN 1 ELSE NULL END) 
				+ COUNT(CASE WHEN categoria = 'Execucao' THEN 1 ELSE NULL END)		
	     )  AS  un ON un.idsolicitacaoservico = toc.idsolicitacaoservico
	     AND un.datahora = toc.datahora
	WHERE TOC.selecionada IS NULL
	AND toc.categoria IN('Execucao','Compartilhamento', 'Reclassificacao','Suspensao','Reativacao','Encerramento','Direcionamento', 'Reabertura', 'Criacao')
	)  AS  T
WHERE T.idocorrencia = o.idocorrencia ;  



/*
DESMARCA OCORRENCIAS DE EXECUÇÃO QUANDO REPETIR COM OUTRA TIPO PRINCIPAL E HOUVER APENAS DOI TIPOS DE OCORRENCIA NA MESMA DATAHORA
*/
UPDATE temporocorrenciasselecionadas o SET   selecionada = CASE WHEN o.categoria = 'Execucao' THEN  CAST(0  AS  BIT) ELSE CAST(1  AS  BIT) END
FROM (
	SELECT * 
	FROM temporocorrenciasselecionadas  AS  toc
	JOIN (
		SELECT idsolicitacaoservico, datahora , COUNT(DISTINCT categoria )  AS  categorias,
		COUNT(CASE WHEN categoria IN('Compartilhamento', 'Reclassificacao','Suspensao','Reativacao','Encerramento','Direcionamento', 'Reabertura', 'Criacao') THEN 1 ELSE NULL END)  AS  "Outra",
		COUNT(CASE WHEN categoria = 'Execucao' THEN 1 ELSE NULL END)   AS  "Execucao",
		COUNT(*) 
		FROM temporocorrenciasselecionadas
		WHERE selecionada IS NULL
		GROUP BY idsolicitacaoservico, datahora 
		HAVING COUNT(*)  >= 2
		AND COUNT(DISTINCT categoria ) =2
		AND COUNT(CASE WHEN categoria IN('Compartilhamento', 'Reclassificacao','Suspensao','Reativacao','Encerramento','Direcionamento', 'Reabertura', 'Criacao') THEN 1 ELSE NULL END)>= 1
		AND COUNT(CASE WHEN categoria = 'Execucao' THEN 1 ELSE NULL END)>= 1
		AND COUNT(*)  = COUNT(CASE WHEN categoria IN('Compartilhamento', 'Reclassificacao','Suspensao','Reativacao','Encerramento','Direcionamento', 'Reabertura', 'Criacao') THEN 1 ELSE NULL END) 
				+ COUNT(CASE WHEN categoria = 'Execucao' THEN 1 ELSE NULL END)		
	     )  AS  un ON un.idsolicitacaoservico = toc.idsolicitacaoservico
	     AND un.datahora = toc.datahora
	WHERE TOC.selecionada IS NULL
	AND toc.categoria IN('Execucao','Compartilhamento', 'Reclassificacao','Suspensao','Reativacao','Encerramento','Direcionamento', 'Reabertura', 'Criacao')
	)  AS  T
WHERE T.idocorrencia = o.idocorrencia ;  



/*
MARCA  AS  OCORRENCIAS DE ABERTURA E ENCERRAMENTO EXECUTADAS SIMULTANEAMENTE COMO SELECIONADAS
*/
UPDATE temporocorrenciasselecionadas o SET   selecionada = CAST(1  AS  BIT)
FROM (
	SELECT * 
	FROM temporocorrenciasselecionadas  AS  toc
	JOIN (
		SELECT idsolicitacaoservico, datahora , 
		COUNT(CASE WHEN categoria = 'Criacao' THEN 1 ELSE NULL END)  AS  "Criacao",
		COUNT(CASE WHEN categoria = 'Encerramento' THEN 1 ELSE NULL END)   AS  "Encerramento",
		COUNT(*) 
		FROM temporocorrenciasselecionadas
		WHERE selecionada IS NULL
		GROUP BY idsolicitacaoservico, datahora 
		HAVING COUNT(*)  >= 2
		AND COUNT(CASE WHEN categoria = 'Criacao' THEN 1 ELSE NULL END)>= 1
		AND COUNT(CASE WHEN categoria = 'Encerramento' THEN 1 ELSE NULL END)  >= 1
		AND COUNT(*)  = COUNT(CASE WHEN categoria = 'Criacao' THEN 1 ELSE NULL END) 
				+ COUNT(CASE WHEN categoria = 'Encerramento' THEN 1 ELSE NULL END)		
	     )  AS  un ON un.idsolicitacaoservico = toc.idsolicitacaoservico
	     AND un.datahora = toc.datahora
	WHERE TOC.selecionada IS NULL
	AND toc.categoria IN('Criacao','Encerramento')
	)  AS  T
WHERE T.idocorrencia = o.idocorrencia ;   

/*
MARCA  AS  OCORRENCIAS DE SUSPENSAO E REATIVAÇÃO  EXECUTADAS SIMULTANEAMENTE COMO NAO SELECIONADAS
*/
UPDATE temporocorrenciasselecionadas o SET   selecionada = CAST(0  AS  BIT)
FROM (
	SELECT * 
	FROM temporocorrenciasselecionadas  AS  toc
	JOIN (
		SELECT idsolicitacaoservico, datahora , 
		COUNT(CASE WHEN categoria = 'Suspensao' THEN 1 ELSE NULL END)  AS  "Suspensao",
		COUNT(CASE WHEN categoria = 'Reativacao' THEN 1 ELSE NULL END)   AS  "Reativacao",
		COUNT(CASE WHEN categoria = 'Execucao' THEN 1 ELSE NULL END)   AS  "Execucao",
		COUNT(*) 
		FROM temporocorrenciasselecionadas
		WHERE selecionada IS NULL
		GROUP BY idsolicitacaoservico, datahora 
		HAVING COUNT(*)  >= 2
		AND COUNT(CASE WHEN categoria = 'Suspensao' THEN 1 ELSE NULL END)>= 1
		AND COUNT(CASE WHEN categoria = 'Reativacao' THEN 1 ELSE NULL END)  >= 1
		AND COUNT(CASE WHEN categoria = 'Execucao' THEN 1 ELSE NULL END)  >= 0
		AND COUNT(*)  = COUNT(CASE WHEN categoria = 'Suspensao' THEN 1 ELSE NULL END) 
				+ COUNT(CASE WHEN categoria = 'Reativacao' THEN 1 ELSE NULL END)
				+ COUNT(CASE WHEN categoria = 'Execucao' THEN 1 ELSE NULL END)		
	     )  AS  un ON un.idsolicitacaoservico = toc.idsolicitacaoservico
	     AND un.datahora = toc.datahora
	WHERE TOC.selecionada IS NULL
	AND toc.categoria IN('Suspensao','Reativacao','Execucao')
	)  AS  T
WHERE T.idocorrencia = o.idocorrencia ;   




/*
MARCA  AS  OCORRENCIAS RECLASSIFICAÇÃO COMO SELECIONADA , QUANDO REPETIDA COM EXECUCAO E DIRECIONAMENTO NA MESMA DATAHORA
*/
UPDATE temporocorrenciasselecionadas o SET   selecionada = CASE WHEN o.categoria in('Reclassificacao','Direcionamento') THEN  CAST(1  AS  BIT) ELSE CAST(0  AS  BIT) END
FROM (
	SELECT * 
	FROM temporocorrenciasselecionadas  AS  toc
	JOIN (
		SELECT idsolicitacaoservico, datahora , 
		COUNT(CASE WHEN categoria = 'Execucao' THEN 1 ELSE NULL END)  AS  "Execucao",
		COUNT(CASE WHEN categoria = 'Direcionamento' THEN 1 ELSE NULL END)   AS  "Direcionamento",
		COUNT(CASE WHEN categoria = 'Reclassificacao' THEN 1 ELSE NULL END)   AS  "Reclassificacao",
		COUNT(*) 
		FROM temporocorrenciasselecionadas
		WHERE selecionada IS NULL
		GROUP BY idsolicitacaoservico, datahora 
		HAVING COUNT(*)  >= 3
		AND COUNT(CASE WHEN categoria = 'Execucao' THEN 1 ELSE NULL END)>= 1
		AND COUNT(CASE WHEN categoria = 'Direcionamento' THEN 1 ELSE NULL END) >= 1
		AND COUNT(CASE WHEN categoria = 'Reclassificacao' THEN 1 ELSE NULL END) >= 1
		AND COUNT(*)  = COUNT(CASE WHEN categoria = 'Execucao' THEN 1 ELSE NULL END)
				+ COUNT(CASE WHEN categoria = 'Direcionamento' THEN 1 ELSE NULL END)
				+ COUNT(CASE WHEN categoria = 'Reclassificacao' THEN 1 ELSE NULL END)
	     )  AS  un ON un.idsolicitacaoservico = toc.idsolicitacaoservico
	     AND un.datahora = toc.datahora
	WHERE toc.selecionada IS NULL
	AND toc.categoria IN('Reclassificacao','Execucao','Direcionamento')
	)  AS  T
WHERE T.idocorrencia = o.idocorrencia ;   
  
/*

*/ 

--MARCA OCORRENCIA DE CRIACAO QUANDO REPETIR COM OUTRA TIPO PRINCIPAL E HOUVER APENAS DOI TIPOS DE OCORRENCIA NA MESMA DATAHORA
UPDATE temporocorrenciasselecionadas o SET   selecionada = CASE WHEN o.categoria = 'Criacao' THEN  CAST(1  AS  BIT) ELSE CAST(0  AS  BIT) END
FROM (
	SELECT * 
	FROM temporocorrenciasselecionadas  AS  toc
	JOIN (
		SELECT idsolicitacaoservico, datahora , COUNT(DISTINCT categoria )  AS  categorias,
		COUNT(CASE WHEN categoria <> 'Criacao' THEN 1 ELSE NULL END)  AS  "Outra",
		COUNT(CASE WHEN categoria = 'Criacao' THEN 1 ELSE NULL END)   AS  "Criacao",
		COUNT(*) 
		FROM temporocorrenciasselecionadas
		WHERE selecionada IS NULL
		GROUP BY idsolicitacaoservico, datahora 
		HAVING COUNT(*)  >= 2
		AND COUNT(DISTINCT categoria ) >=2
		AND COUNT(CASE WHEN categoria <> 'Criacao' THEN 1 ELSE NULL END)>= 1
		AND COUNT(CASE WHEN categoria = 'Criacao' THEN 1 ELSE NULL END)>= 1
		AND COUNT(*)  = COUNT(CASE WHEN categoria <> 'Criacao' THEN 1 ELSE NULL END) 
				+ COUNT(CASE WHEN categoria = 'Criacao' THEN 1 ELSE NULL END)		
	     )  AS  un ON un.idsolicitacaoservico = toc.idsolicitacaoservico
	     AND un.datahora = toc.datahora
	WHERE TOC.selecionada IS NULL
	)  AS  T
WHERE T.idocorrencia = o.idocorrencia ;  


/*

*/ 
--MARCA OCORRENCIA DE SUSPENSAO QUANDO REPETIR COM OUTRA TIPO PRINCIPAL E HOUVER APENAS DOI TIPOS DE OCORRENCIA NA MESMA DATAHORA
UPDATE temporocorrenciasselecionadas o SET   selecionada = CASE WHEN o.categoria = 'Suspensao' THEN  CAST(1  AS  BIT) ELSE CAST(0  AS  BIT) END
FROM (
	SELECT * 
	FROM temporocorrenciasselecionadas  AS  toc
	JOIN (
		SELECT idsolicitacaoservico, datahora , COUNT(DISTINCT categoria )  AS  categorias,
		COUNT(CASE WHEN categoria <> 'Suspensao' THEN 1 ELSE NULL END)  AS  "Outra",
		COUNT(CASE WHEN categoria = 'Suspensao' THEN 1 ELSE NULL END)   AS  "Suspensao",
		COUNT(*) 
		FROM temporocorrenciasselecionadas
		WHERE selecionada IS NULL
		GROUP BY idsolicitacaoservico, datahora 
		HAVING COUNT(*)  >= 1
		AND COUNT(DISTINCT categoria ) >=2
		AND COUNT(CASE WHEN categoria <> 'Suspensao' THEN 1 ELSE NULL END)>= 1
		AND COUNT(CASE WHEN categoria = 'Suspensao' THEN 1 ELSE NULL END)>= 1
		AND COUNT(*)  = COUNT(CASE WHEN categoria <> 'Suspensao' THEN 1 ELSE NULL END) 
				+ COUNT(CASE WHEN categoria = 'Suspensao' THEN 1 ELSE NULL END)		
	     )  AS  un ON un.idsolicitacaoservico = toc.idsolicitacaoservico
	     AND un.datahora = toc.datahora
	WHERE TOC.selecionada IS NULL
	)  AS  T
WHERE T.idocorrencia = o.idocorrencia ;  

/*

*/ 
--MARCA OCORRENCIA DE REATIVACAO QUANDO REPETIR COM OUTRA TIPO PRINCIPAL E HOUVER APENAS DOI TIPOS DE OCORRENCIA NA MESMA DATAHORA
UPDATE temporocorrenciasselecionadas o SET   selecionada = CASE WHEN o.categoria = 'Reativacao' THEN  CAST(1  AS  BIT) ELSE CAST(0  AS  BIT) END
FROM (
	SELECT * 
	FROM temporocorrenciasselecionadas  AS  toc
	JOIN (
		SELECT idsolicitacaoservico, datahora , COUNT(DISTINCT categoria )  AS  categorias,
		COUNT(CASE WHEN categoria <> 'Reativacao' THEN 1 ELSE NULL END)  AS  "Outra",
		COUNT(CASE WHEN categoria = 'Reativacao' THEN 1 ELSE NULL END)   AS  "Reativacao",
		COUNT(*) 
		FROM temporocorrenciasselecionadas
		WHERE selecionada IS NULL
		GROUP BY idsolicitacaoservico, datahora 
		HAVING COUNT(*)  >= 1
		AND COUNT(DISTINCT categoria ) >=2
		AND COUNT(CASE WHEN categoria <> 'Reativacao' THEN 1 ELSE NULL END)>= 1
		AND COUNT(CASE WHEN categoria = 'Reativacao' THEN 1 ELSE NULL END)>= 1
		AND COUNT(*)  = COUNT(CASE WHEN categoria <> 'Reativacao' THEN 1 ELSE NULL END) 
				+ COUNT(CASE WHEN categoria = 'Reativacao' THEN 1 ELSE NULL END)		
	     )  AS  un ON un.idsolicitacaoservico = toc.idsolicitacaoservico
	     AND un.datahora = toc.datahora
	WHERE TOC.selecionada IS NULL
	)  AS  T
WHERE T.idocorrencia = o.idocorrencia ; 


/*

*/ 
--MARCA OCORRENCIA DE ENCERRAMENTO QUANDO REPETIR COM OUTRA TIPO PRINCIPAL E HOUVER APENAS DOI TIPOS DE OCORRENCIA NA MESMA DATAHORA
UPDATE temporocorrenciasselecionadas o SET   selecionada = CASE WHEN o.categoria = 'Encerramento' THEN  CAST(1  AS  BIT) ELSE CAST(0  AS  BIT) END
FROM (
	SELECT * 
	FROM temporocorrenciasselecionadas  AS  toc
	JOIN (
		SELECT idsolicitacaoservico, datahora , COUNT(DISTINCT categoria )  AS  categorias,
		COUNT(CASE WHEN categoria <> 'Encerramento' THEN 1 ELSE NULL END)  AS  "Outra",
		COUNT(CASE WHEN categoria = 'Encerramento' THEN 1 ELSE NULL END)   AS  "Encerramento",
		COUNT(*) 
		FROM temporocorrenciasselecionadas
		WHERE selecionada IS NULL
		GROUP BY idsolicitacaoservico, datahora 
		HAVING COUNT(*)  >= 1
		AND COUNT(DISTINCT categoria ) >=2
		AND COUNT(CASE WHEN categoria <> 'Encerramento' THEN 1 ELSE NULL END)>= 1
		AND COUNT(CASE WHEN categoria = 'Encerramento' THEN 1 ELSE NULL END)>= 1
		AND COUNT(*)  = COUNT(CASE WHEN categoria <> 'Encerramento' THEN 1 ELSE NULL END) 
				+ COUNT(CASE WHEN categoria = 'Encerramento' THEN 1 ELSE NULL END)		
	     )  AS  un ON un.idsolicitacaoservico = toc.idsolicitacaoservico
	     AND un.datahora = toc.datahora
	WHERE TOC.selecionada IS NULL
	)  AS  T
WHERE T.idocorrencia = o.idocorrencia ; 


/*

*/ 
--MARCA OCORRENCIA DE COMPARTILHAMENTO QUANDO REPETIR COM OUTRA TIPO PRINCIPAL E HOUVER APENAS DOI TIPOS DE OCORRENCIA NA MESMA DATAHORA
UPDATE temporocorrenciasselecionadas o SET   selecionada = CASE WHEN o.categoria = 'Compartilhamento' THEN  CAST(1  AS  BIT) ELSE CAST(0  AS  BIT) END
FROM (
	SELECT * 
	FROM temporocorrenciasselecionadas  AS  toc
	JOIN (
		SELECT idsolicitacaoservico, datahora , COUNT(DISTINCT categoria )  AS  categorias,
		COUNT(CASE WHEN categoria <> 'Compartilhamento' THEN 1 ELSE NULL END)  AS  "Outra",
		COUNT(CASE WHEN categoria = 'Compartilhamento' THEN 1 ELSE NULL END)   AS  "Compartilhamento",
		COUNT(*) 
		FROM temporocorrenciasselecionadas
		WHERE selecionada IS NULL
		GROUP BY idsolicitacaoservico, datahora 
		HAVING COUNT(*)  >= 1
		AND COUNT(DISTINCT categoria ) >=2
		AND COUNT(CASE WHEN categoria <> 'Compartilhamento' THEN 1 ELSE NULL END)>= 1
		AND COUNT(CASE WHEN categoria = 'Compartilhamento' THEN 1 ELSE NULL END)>= 1
		AND COUNT(*)  = COUNT(CASE WHEN categoria <> 'Compartilhamento' THEN 1 ELSE NULL END) 
				+ COUNT(CASE WHEN categoria = 'Compartilhamento' THEN 1 ELSE NULL END)		
	     )  AS  un ON un.idsolicitacaoservico = toc.idsolicitacaoservico
	     AND un.datahora = toc.datahora
	WHERE TOC.selecionada IS NULL
	)  AS  T
WHERE T.idocorrencia = o.idocorrencia ; 


/*

*/ 
--QUANDO A CRIAÇÃO E ENCERAMENTO OCORREREM NA MESMA HORA ADICIONAR 1 MINUTO NO TEMPO DE ENCERRAMENTO
UPDATE temporocorrenciasselecionadas o SET   datahora = o.datahora + interval '1 min'
FROM (
	SELECT * 
	FROM temporocorrenciasselecionadas  AS  toc
	JOIN (
		SELECT idsolicitacaoservico, datahora , 
		COUNT(CASE WHEN categoria = 'Criacao' THEN 1 ELSE NULL END)  AS  "Criacao",
		COUNT(CASE WHEN categoria = 'Encerramento' THEN 1 ELSE NULL END)   AS  "Encerramento",
		COUNT(*) 
		FROM temporocorrenciasselecionadas
		WHERE selecionada = CAST(1  AS  BIT)
		GROUP BY idsolicitacaoservico, datahora 
		HAVING COUNT(*)  >= 2
		AND COUNT(CASE WHEN categoria = 'Criacao' THEN 1 ELSE NULL END)>= 1
		AND COUNT(CASE WHEN categoria = 'Encerramento' THEN 1 ELSE NULL END)  >= 1
		AND COUNT(*)  = COUNT(CASE WHEN categoria = 'Criacao' THEN 1 ELSE NULL END) 
				+ COUNT(CASE WHEN categoria = 'Encerramento' THEN 1 ELSE NULL END)		
	     )  AS  un ON un.idsolicitacaoservico = toc.idsolicitacaoservico
	     AND un.datahora = toc.datahora
	WHERE TOC.selecionada = CAST(1  AS  BIT)
	AND toc.categoria IN('Encerramento')
	)  AS  T
WHERE T.idocorrencia = o.idocorrencia ;   

--QUANDO A RECLASSIFICAÇÃO E DIRECIONAMENTO OCORREREM NA MESMA HORA ADICIONAR 1 MINUTO NO TEMPO DE DIRECIONAMENTO
UPDATE temporocorrenciasselecionadas o SET   datahora = o.datahora + interval '1 min'
FROM (
	SELECT * 
	FROM temporocorrenciasselecionadas  AS  toc
	JOIN (
		SELECT idsolicitacaoservico, datahora , 
		COUNT(CASE WHEN categoria = 'Reclassificacao' THEN 1 ELSE NULL END)  AS  "Reclassificacao",
		COUNT(CASE WHEN categoria = 'Direcionamento' THEN 1 ELSE NULL END)   AS  "Direcionamento",
		COUNT(*) 
		FROM temporocorrenciasselecionadas
		WHERE selecionada = CAST(1  AS  BIT)
		GROUP BY idsolicitacaoservico, datahora 
		HAVING COUNT(*)  >= 2
		AND COUNT(CASE WHEN categoria = 'Reclassificacao' THEN 1 ELSE NULL END)>= 1
		AND COUNT(CASE WHEN categoria = 'Direcionamento' THEN 1 ELSE NULL END)  >= 1
		AND COUNT(*)  = COUNT(CASE WHEN categoria = 'Reclassificacao' THEN 1 ELSE NULL END) 
				+ COUNT(CASE WHEN categoria = 'Direcionamento' THEN 1 ELSE NULL END)		
	     )  AS  un ON un.idsolicitacaoservico = toc.idsolicitacaoservico
	     AND un.datahora = toc.datahora
	WHERE TOC.selecionada = CAST(1  AS  BIT)
	AND toc.categoria IN('Direcionamento')
	)  AS  T
WHERE T.idocorrencia = o.idocorrencia ;   



/*

*/ 
--REPETIDAS MAS DE MESMA CATERGORIA, SELECIONA A PRIMEIRA OCORRENCIA

UPDATE temporocorrenciasselecionadas o SET   selecionada = CASE WHEN o.idocorrencia =  menorocorrencia THEN CAST(1  AS  BIT) ELSE CAST(0  AS  BIT) END
FROM (
	SELECT * 
	FROM temporocorrenciasselecionadas  AS  toc
	JOIN (
		SELECT idsolicitacaoservico, datahora , COUNT (DISTINCT categoria)  AS  categorias,
		COUNT(*) ,
		MIN(idocorrencia)  AS  menorocorrencia
		FROM temporocorrenciasselecionadas
		WHERE selecionada IS NULL
		GROUP BY idsolicitacaoservico, datahora 
		HAVING COUNT(*)  >= 2
		AND COUNT (DISTINCT categoria) = 1
	     )  AS  un ON un.idsolicitacaoservico = toc.idsolicitacaoservico
	     AND un.datahora = toc.datahora
	WHERE TOC.selecionada IS NULL
	AND toc.categoria IN('Criacao','Execucao', 'Compartilhamento', 'Reclassificacao','Suspensao','Reativacao','Encerramento','Direcionamento','Reabertura')
	)  AS  T
WHERE T.idocorrencia = o.idocorrencia ;  


/*

*/ 
--QUANDO HOUVER DOIS REGISTROS DA MESMA CATEGORIA COM MESMA DATAHORA MANTER A PRIMEIRA OCORRENCIA MENOR ID
UPDATE temporocorrenciasselecionadas o SET   selecionada = CASE WHEN o.idocorrencia = menorocorrencia THEN CAST(1  AS  BIT)  ELSE CAST(0  AS  BIT) END
FROM (
	SELECT * 
	FROM temporocorrenciasselecionadas  AS  toc
	JOIN (
		SELECT idsolicitacaoservico, datahora, count(*) registros, COUNT(DISTINCT categoria) categorias, MIN(idocorrencia)AS menorocorrencia
		FROM temporocorrenciasselecionadas
		WHERE selecionada = CAST(1  AS  BIT)
		GROUP BY idsolicitacaoservico, datahora
		HAVING count(*) >= 1		
	     )  AS  un ON un.idsolicitacaoservico = toc.idsolicitacaoservico
	     AND un.datahora = toc.datahora
	WHERE TOC.selecionada = CAST(1  AS  BIT)
	)  AS  T
WHERE T.idocorrencia = o.idocorrencia ;   


--QUANDO HOUVER DOIS REGISTROS DA MESMA CATEGORIA COM MESMA DATAHORA MANTER A PRIMEIRA OCORRENCIA MENOR ID
UPDATE temporocorrenciasselecionadas o SET   selecionada = CASE WHEN o.idocorrencia = menorocorrencia THEN CAST(1  AS  BIT)  ELSE CAST(0  AS  BIT) END
FROM (
	SELECT * 
	FROM temporocorrenciasselecionadas  AS  toc
	JOIN (
		SELECT idsolicitacaoservico, datahora, count(*) registros, COUNT(DISTINCT categoria) categorias, MIN(idocorrencia)AS menorocorrencia
		FROM temporocorrenciasselecionadas
		WHERE selecionada = CAST(1  AS  BIT)
		GROUP BY idsolicitacaoservico, datahora
		HAVING count(*) > 1		
	     )  AS  un ON un.idsolicitacaoservico = toc.idsolicitacaoservico
	     AND un.datahora = toc.datahora
	WHERE TOC.selecionada = CAST(1  AS  BIT)
	)  AS  T
WHERE T.idocorrencia = o.idocorrencia ;   


/*
RESULTADO NAS OCORRENCIA SELECIONADAS
*/ 

/*
SELECT 
"Criacao", "Reabertura", "InicioSLA", "Reclassificacao", "Direcionamento", "Execucao", "Encerramento",
"Suspensao","SuspensaoSLA","Reativacao", "ReativacaoSLA", "Agendamento", "Compartilhamento","MudancaSLA",   
COUNT(*)
FROM (
	SELECT idsolicitacaoservico, datahora, 
	CASE WHEN COUNT(CASE WHEN categoria = 'Agendamento' THEN 1 ELSE NULL END) > 0 THEN 'X' ELSE '' END  AS  "Agendamento",
	CASE WHEN COUNT(CASE WHEN categoria = 'Compartilhamento' THEN 1 ELSE NULL END)  > 0 THEN 'X' ELSE '' END  AS  "Compartilhamento",
	CASE WHEN COUNT(CASE WHEN categoria = 'Criacao' THEN 1 ELSE NULL END)  > 0 THEN 'X' ELSE '' END  AS  "Criacao",
	CASE WHEN COUNT(CASE WHEN categoria = 'Direcionamento' THEN 1 ELSE NULL END)  > 0 THEN 'X' ELSE '' END  AS  "Direcionamento",
	CASE WHEN COUNT(CASE WHEN categoria = 'Encerramento' THEN 1 ELSE NULL END)  > 0 THEN 'X' ELSE '' END  AS  "Encerramento",
	CASE WHEN COUNT(CASE WHEN categoria = 'Execucao' THEN 1 ELSE NULL END)  > 0 THEN 'X' ELSE '' END  AS  "Execucao",
	CASE WHEN COUNT(CASE WHEN categoria = 'Reabertura' THEN 1 ELSE NULL END)  > 0 THEN 'X' ELSE '' END  AS  "Reabertura",
	CASE WHEN COUNT(CASE WHEN categoria = 'Reativacao' THEN 1 ELSE NULL END)  > 0 THEN 'X' ELSE '' END  AS  "Reativacao",
	CASE WHEN COUNT(CASE WHEN categoria = 'Reclassificacao' THEN 1 ELSE NULL END)  > 0 THEN 'X' ELSE '' END  AS  "Reclassificacao",
	CASE WHEN COUNT(CASE WHEN categoria = 'Suspensao' THEN 1 ELSE NULL END)  > 0 THEN 'X' ELSE '' END  AS  "Suspensao",
	CASE WHEN COUNT(CASE WHEN categoria = 'SuspensaoSLA' THEN 1 ELSE NULL END)  > 0 THEN 'X' ELSE '' END  AS  "SuspensaoSLA",
	CASE WHEN COUNT(CASE WHEN categoria = 'InicioSLA' THEN 1 ELSE NULL END)  > 0 THEN 'X' ELSE '' END  AS  "InicioSLA",
	CASE WHEN COUNT(CASE WHEN categoria = 'ReativacaoSLA' THEN 1 ELSE NULL END)  > 0 THEN 'X' ELSE '' END  AS  "ReativacaoSLA",
	CASE WHEN COUNT(CASE WHEN categoria = 'MudancaSLA' THEN 1 ELSE NULL END)  > 0 THEN 'X' ELSE '' END  AS  "MudancaSLA",
	COUNT(*)
	FROM temporocorrenciasselecionadas
	WHERE selecionada = CAST(1  AS  BIT)
	GROUP BY idsolicitacaoservico, datahora
	--HAVING COUNT(*) > 1
)  AS  OcorrenciaRepetidas
GROUP BY
"Criacao", "Reabertura", "InicioSLA", "Reclassificacao", "Direcionamento", "Execucao", "Encerramento",
"Suspensao","SuspensaoSLA","Reativacao", "ReativacaoSLA", "Agendamento", "Compartilhamento","MudancaSLA"
ORDER BY "Criacao", "Reabertura", "InicioSLA", "Reclassificacao", "Direcionamento", "Execucao", "Encerramento",
"Suspensao","SuspensaoSLA","Reativacao", "ReativacaoSLA", "Agendamento", "Compartilhamento","MudancaSLA" ;

*/



/* 
RESULTADO NAS OCORRENCIA NAO SELECIONADAS
*/

/*
SELECT 
"Criacao", "Reabertura", "InicioSLA", "Reclassificacao", "Direcionamento", "Execucao", "Encerramento",
"Suspensao","SuspensaoSLA","Reativacao", "ReativacaoSLA", "Agendamento", "Compartilhamento","MudancaSLA",   
COUNT(*)
FROM (
	SELECT idsolicitacaoservico, datahora, 
	CASE WHEN COUNT(CASE WHEN categoria = 'Agendamento' THEN 1 ELSE NULL END) > 0 THEN 'X' ELSE '' END  AS  "Agendamento",
	CASE WHEN COUNT(CASE WHEN categoria = 'Compartilhamento' THEN 1 ELSE NULL END)  > 0 THEN 'X' ELSE '' END  AS  "Compartilhamento",
	CASE WHEN COUNT(CASE WHEN categoria = 'Criacao' THEN 1 ELSE NULL END)  > 0 THEN 'X' ELSE '' END  AS  "Criacao",
	CASE WHEN COUNT(CASE WHEN categoria = 'Direcionamento' THEN 1 ELSE NULL END)  > 0 THEN 'X' ELSE '' END  AS  "Direcionamento",
	CASE WHEN COUNT(CASE WHEN categoria = 'Encerramento' THEN 1 ELSE NULL END)  > 0 THEN 'X' ELSE '' END  AS  "Encerramento",
	CASE WHEN COUNT(CASE WHEN categoria = 'Execucao' THEN 1 ELSE NULL END)  > 0 THEN 'X' ELSE '' END  AS  "Execucao",
	CASE WHEN COUNT(CASE WHEN categoria = 'Reabertura' THEN 1 ELSE NULL END)  > 0 THEN 'X' ELSE '' END  AS  "Reabertura",
	CASE WHEN COUNT(CASE WHEN categoria = 'Reativacao' THEN 1 ELSE NULL END)  > 0 THEN 'X' ELSE '' END  AS  "Reativacao",
	CASE WHEN COUNT(CASE WHEN categoria = 'Reclassificacao' THEN 1 ELSE NULL END)  > 0 THEN 'X' ELSE '' END  AS  "Reclassificacao",
	CASE WHEN COUNT(CASE WHEN categoria = 'Suspensao' THEN 1 ELSE NULL END)  > 0 THEN 'X' ELSE '' END  AS  "Suspensao",
	CASE WHEN COUNT(CASE WHEN categoria = 'SuspensaoSLA' THEN 1 ELSE NULL END)  > 0 THEN 'X' ELSE '' END  AS  "SuspensaoSLA",
	CASE WHEN COUNT(CASE WHEN categoria = 'InicioSLA' THEN 1 ELSE NULL END)  > 0 THEN 'X' ELSE '' END  AS  "InicioSLA",
	CASE WHEN COUNT(CASE WHEN categoria = 'ReativacaoSLA' THEN 1 ELSE NULL END)  > 0 THEN 'X' ELSE '' END  AS  "ReativacaoSLA",
	CASE WHEN COUNT(CASE WHEN categoria = 'MudancaSLA' THEN 1 ELSE NULL END)  > 0 THEN 'X' ELSE '' END  AS  "MudancaSLA",
	COUNT(*)
	FROM temporocorrenciasselecionadas
	WHERE selecionada = CAST(0  AS  BIT)
	GROUP BY idsolicitacaoservico, datahora
	--HAVING COUNT(*) > 1
)  AS  OcorrenciaRepetidas
GROUP BY
"Criacao", "Reabertura", "InicioSLA", "Reclassificacao", "Direcionamento", "Execucao", "Encerramento",
"Suspensao","SuspensaoSLA","Reativacao", "ReativacaoSLA", "Agendamento", "Compartilhamento","MudancaSLA"
ORDER BY COUNT(*) DESC;

*/


/*
RESULTADOS DA SELEÇÃO DE OCORRÊNCIAS RELEVANTES
SELECT selecionada, COUNT(*)
FROM temporocorrenciasselecionadas
GROUP BY selecionada;
*/


/*
ARMAZENA  AS  INFORMAÇÕES DO WORKFLOW DO CHAMADO PARA UTILIZAR NA IDENTIFICAÇÃO DAS EQUIPE E TÉCNICOS RELACIONADOS
COM  AS  OCORRENCIAS SELECIONADAS
*/


/*
LIMPA A TABELA EXISTENTE
*/


TRUNCATE TABLE tempsolicitacaoitemtrabalho;


/*
POPULA A TABELA
*/

INSERT INTO tempSolicitacaoItemTrabalho(
idsolicitacaoservico, iditemtrabalho, idresponsavelitemtrabalho,
nomeresponsavel, datahoracriacaoitemtrabalho,  datahorainicioitemtrabalho, 
situacaoitemtrabalho, datahorafinalizacao, idgrupoexecutor,  nomegrupoexecutoratual,arearesponsavel,
idfluxo, nomefluxo,  versao)
SELECT  ss.idsolicitacaoservico, itrabflx.iditemtrabalho, itrabflx.idresponsavelatual  AS  idresponsavelitemtrabalho, 
rit.nome nomeresponsavel, itrabflx.datahoracriacao  AS  datahoracriacaoitemtrabalho, 
itrabflx.datahorainicio  AS  datahorainicioitemtrabalho, itrabflx.situacao  AS  situacaoitemtrabalho, 
itrabflx.datahorafinalizacao  AS  datahorafinalizacaoitemtrabalho,
atrflx.idgrupo  AS  idgrupoexecutor, g.nome  AS  nomegrupoexecutoratual, SPLIT_PART(SPLIT_PART(g.descricao, 'AREA=', 2),']',1)  AS  arearesponsavel,
bflx.idfluxo, upper(btflx.nomefluxo),  bflx.versao
FROM solicitacaoservico ss
LEFT JOIN execucaosolicitacao ess ON ess.idsolicitacaoservico = ss.idsolicitacaoservico
LEFT JOIN bpm_fluxo bflx ON bflx.idfluxo = ess.idfluxo
LEFT JOIN bpm_tipofluxo btflx ON btflx.idtipofluxo = bflx.idtipofluxo
LEFT JOIN bpm_instanciafluxo bitflx ON bitflx.idinstancia = ess.idinstanciafluxo 
LEFT JOIN faseservico fs ON fs.idfase = ess.idfase
LEFT JOIN bpm_objetoinstanciafluxo obitflxga ON obitflxga.idinstancia = bitflx.idinstancia AND obitflxga.nomeobjeto =  'solicitacaoServico.grupoAtual'
LEFT JOIN bpm_objetoinstanciafluxo obitflxgs ON obitflxgs.idinstancia = bitflx.idinstancia AND obitflxgs.nomeobjeto =  'solicitacaoServico.situacao'
LEFT JOIN bpm_itemtrabalhofluxo itrabflx ON itrabflx.idinstancia = bitflx.idinstancia 
LEFT JOIN bpm_elementofluxo elflx ON elflx.idelemento =  itrabflx.idelemento AND elflx.idfluxo =  ess.idfluxo
LEFT JOIN bpm_atribuicaofluxo atrflx ON atrflx.iditemtrabalho = itrabflx.iditemtrabalho AND atrflx.tipo = 'Automatica'
LEFT JOIN grupo g ON g.idgrupo = atrflx.idgrupo
LEFT JOIN usuario rit ON rit.idusuario = itrabflx.idresponsavelatual
LEFT JOIN empregados solicitante ON solicitante.idempregado = ss.idsolicitante
LEFT JOIN empregados su ON su.idempregado = atrflx.idusuario
--WHERE ss.idsolicitacaoservico = 10737;
;

/*
CRIA TABELA PARA ARMAZENAR DADOS PARA ANALISE DA VINCULAÇÃO DAS OCORRENCIAS DOS CHAMADOS E ITENS DE TRABALHO DO WORKFLOW
*/
INSERT INTO tempOcorrenciaItemTrabalho (
idsolicitacaoservico, idocorrencia, dataocorrencia, iditemtrabalho)
SELECT idsolicitacaoservico, idocorrencia, datahora  AS  dataocorrencia, iditemtrabalho
FROM  temporocorrenciasselecionadas
WHERE selecionada = CAST(1  AS  BIT)
ORDER BY idsolicitacaoservico, idocorrencia;

/*
VINCULA ITEM DE TRABALHO A OCORRÊNCIA NÃO TEM ESSA VINCULAÇÃO, NOS CASOS QUE O CHAMADO SÓ TEM UM ÍTEM DE TRABALHO, ELE E REPLICADO PARA TODAS  AS  OCORRÊNCIAS EM ITEM DE TRABALHO VINCULADO
*/
UPDATE tempOcorrenciaItemTrabalho tot SET  iditemtrabalho = t.novoiditemtrabalho
FROM (
	SELECT idsolicitacaoservico, COUNT(iditemtrabalho)  AS  qtdItenstrabalho, MAX(iditemtrabalho)  AS  novoiditemtrabalho
	FROM tempSolicitacaoItemTrabalho
	GROUP BY idsolicitacaoservico
	HAVING count(iditemtrabalho) = 1
    )  AS  t
WHERE t.idsolicitacaoservico = tot.idsolicitacaoservico
AND tot.iditemtrabalho IS NULL;



/*
CASO A OCORRÊNCIA POSTERIOR NÃO TENHA ITEM DE TRABALHO, VINCULA AO MESMO ITEM DE TRABALHO DA OCORRÊNCIA ANTERIOR
*/
UPDATE tempOcorrenciaItemTrabalho tot SET  iditemtrabalho = t.novoiditemtrabalho
FROM (
	SELECT p.id, p.idsolicitacaoservico, p.idocorrencia,
	p.dataocorrencia, p.iditemtrabalho, MAX(a.iditemtrabalho)  AS  novoiditemtrabalho
	FROM tempOcorrenciaItemTrabalho p
	JOIN tempOcorrenciaItemTrabalho a ON a.idsolicitacaoservico = p.idsolicitacaoservico
		AND p.id > a.id
		AND a.iditemtrabalho IS NOT NULL
		AND p.iditemtrabalho IS NULL
	GROUP BY p.id, p.idsolicitacaoservico, p.idocorrencia,
	p.dataocorrencia, p.iditemtrabalho
    )  AS  t
WHERE t.id = tot.id;
      
/*
NOS CASOS DE CHAMADOS COM MAIS DE UM ITEM DE TRABALHO, VINCULA DO ITEM DE TRABALHO DA 
PRÓXIMA OCORRÊNCIA NA OCORRENCIA ANTERIOR SEM ITEM DE TRABALHO
*/
UPDATE tempOcorrenciaItemTrabalho tot SET  iditemtrabalho = t.novoiditemtrabalho
FROM (
	SELECT a.id, a.idsolicitacaoservico, a.idocorrencia,
	a.dataocorrencia, a.iditemtrabalho, MIN(p.iditemtrabalho)  AS  novoiditemtrabalho
	FROM tempOcorrenciaItemTrabalho a
	JOIN tempOcorrenciaItemTrabalho p ON p.idsolicitacaoservico = a.idsolicitacaoservico
		AND p.id > a.id
		AND a.iditemtrabalho IS NULL 
		AND p.iditemtrabalho IS NOT NULL
	GROUP BY  a.id, a.idsolicitacaoservico, a.idocorrencia,
	a.dataocorrencia, a.iditemtrabalho
    )  AS  t
WHERE t.id = tot.id;


    
/*
OS CHAMADOS QUE FORAM ABERTOS E ENCERRADOS AO MESMO TEMPO NÃO POSSUEM ITEM DE TRABALHO
*/
/*
SELECT TT.* , O.*
FROM ocorrenciasolicitacao O
JOIN (
	SELECT T.*, T2.qtdItenstrabalho, T2.iditemtrabalho
	FROM (
		SELECT idsolicitacaoservico, 
		count(case when iditemtrabalho is null then 1 else null end )  AS  vazio,
		count(case when iditemtrabalho is not null then 1 else null end)  AS  preenchido ,
		count(*)  AS  todos
		FROM tempOcorrenciaItemTrabalho
		GROUP BY idsolicitacaoservico
	)  AS  t 
	left JOIN (
		SELECT idsolicitacaoservico, count(iditemtrabalho)  AS  qtdItenstrabalho, max(iditemtrabalho) iditemtrabalho
			FROM tempSolicitacaoItemTrabalho
		GROUP BY idsolicitacaoservico
	) t2 ON t2.idsolicitacaoservico = t.idsolicitacaoservico
	WHERE vazio = todos
	or vazio > 0 
	--ORDER BY todos desc
)  AS  TT ON O.idsolicitacaoservico = TT.idsolicitacaoservico
ORDER BY TT.idsolicitacaoservico, O.idocorrencia;
*/


/*
IMPORTA DOS DADOS DAS OCORRÊNCIA PARA TABELA TEMPORÁRIA PARA ESTRUTURAR OS DADOS DE ANÁLISE
APENAS  AS  OCORRENCIAS MARCADAS COMO SELECIONADAS NA ETAPA ANTERIOR SERÃO IMPORTADAS
NESSE MOMENTO SÃO UTILIZADAS  AS  INFORMAÇÕES DO TÉCNICO E GRUPO DEFINIDOS NO ITEM DE TRABALHO, 
E SE NÃO TIVER ITEM DE TRABALHO ENTÃO É EXTRAIDA A INFORMAÇÃO DO OBJETO DA OCORRENCIA.
*/

/*
LIMPA A TABELA
*/
TRUNCATE TABLE tempanaliseocorrencias;

/*
POPULA A TABELA
*/


INSERT INTO tempanaliseocorrencias ( 
idocorrencia, dataocorrencia, idsolicitacaoservico,situacaoatual, categoriaocorrencia, situacaosolicitacao,
idgrupoexecutor,  nomegrupoexecutor, arearesponsavel, idtecnico, nometecnico, idfluxo, 
nomefluxo, versao, idgrupoexecutoroc ,  nomegrupoexecutoroc, areaoc
)
SELECT sel.idocorrencia, sel.datahora, sel.idsolicitacaoservico,replace(UPPER(s.situacao),'"','') AS  situacaoatual, UPPER(sel.categoria) AS  categoriaocorrencia,
UPPER(sel.situacaosolicitacao) AS  situacaosolicitacao, 
COALESCE(grupo.idgrupo, stit.idgrupoexecutor)  AS   idgrupoexecutor, 
UPPER(COALESCE( grupo.nome, stit.nomegrupoexecutoratual))  AS  nomegrupoexecutor, 
UPPER(COALESCE(SPLIT_PART(SPLIT_PART(grupo.descricao, 'AREA=', 2),']',1), stit.arearesponsavel))  AS  arearesponsavel,
COALESCE(stit.idresponsavelitemtrabalho,0) AS  idtecnico, UPPER(COALESCE(stit.nomeresponsavel,'não informado')) AS  nometecnico ,
stit.idfluxo , UPPER(stit.nomefluxo) AS  nomefluxo ,  UPPER(stit.versao) AS  versao,
grupo.idgrupo  AS  idgrupoexecutoroc , UPPER(grupo.nome)  AS  nomegrupoexecutoroc, 
UPPER(split_part(split_part(grupo.descricao, 'AREA=', 2),']',1))  AS  areaoc
FROM (
	SELECT *
	FROM temporocorrenciasselecionadas
	WHERE selecionada = CAST(1 AS  BIT)
	) AS  sel
JOIN solicitacaoservico s ON s.idsolicitacaoservico = sel.idsolicitacaoservico	
JOIN grupo  ON CAST(grupo.idgrupo  AS  VARCHAR(100)) = sel.idgrupo
left JOIN tempOcorrenciaItemTrabalho tit ON tit.idocorrencia = sel.idocorrencia	
left JOIN tempSolicitacaoItemTrabalho stit ON stit.idsolicitacaoservico = sel.idsolicitacaoservico 
	AND stit.iditemtrabalho = tit.iditemtrabalho
ORDER BY sel.idsolicitacaoservico, sel.idocorrencia;


/*
SELECT DISTINCT categoria
FROM temporocorrenciasselecionadas
WHERE selecionada = CAST(1 AS  BIT);
*/

/*
SELECT nomegrupoexecutor, arearesponsavel,categoriaocorrencia,  O.REGISTRADOPOR,U.NOME, COUNT(*)
FROM  tempanaliseocorrencias TAO
JOIN OCORRENCIASOLICITACAO O ON O.IDOCORRENCIA = TAO.IDOCORRENCIA
LEFT JOIN USUARIO U ON U.LOGIN = O.REGISTRADOPOR
GROUP BY nomegrupoexecutor, arearesponsavel,categoriaocorrencia, O.REGISTRADOPOR,U.NOME
ORDER BY categoriaocorrencia, COUNT(*) DESC
*/




/*
TRATA OCORRENCIA COM SITUAÇÃO INCONSISTENTE 
*/
UPDATE tempanaliseocorrencias SET  situacaosolicitacao = 'EM ANDAMENTO' 
--SELECT * FROM tempanaliseocorrencias
WHERE LENGTH(situacaosolicitacao) <=2;

/*
CALCULA A DATA DE INICIO DA OCORRENCIA COMO SENDO A DATA EM QUE A OCORRÊNCIA FOI CRIADA
*/
UPDATE tempanaliseocorrencias AS  o SET  datainicio = dataocorrencia;

/*
CASO HAJA VÁRIAS OCORRÊNCIAS CRIADAS COM A MESMA DATA , DIFERENCIA-SE O TEMPO DE INICIO 
DAS OCORRENCIA DA MESMA SOLICITAÇÃO COM A MESMA DATA ADICIONANDO SEGUNDOS A DATA DAS OCORRENCIAS SUBSEQUENTES
*/
UPDATE tempanaliseocorrencias AS  o SET  datainicio = o.datainicio + (INTERVAL '10 sec' * t.minutos)
FROM (
SELECT top.idsolicitacaoservico, top.idocorrencia , top.datainicio, top.situacaosolicitacao,  count(*) AS  minutos
FROM tempanaliseocorrencias top
JOIN tempanaliseocorrencias toa 
	on top.idsolicitacaoservico = toa.idsolicitacaoservico
	AND top.datainicio = toa.datainicio 
	AND top.idocorrencia > toa.idocorrencia
GROUP BY top.idsolicitacaoservico, top.idocorrencia , top.datainicio, top.situacaosolicitacao
--ORDER BY count(*) DESC
) AS  t
WHERE t.idocorrencia = o.idocorrencia;


/*
PREENCHE A DATA FIM COM A DATA DA OCORRÊNCIA SEGUINTES
*/
UPDATE tempanaliseocorrencias AS  o 
SET  datafim = tp.dataencerramento
FROM (
	SELECT tpo.idocorrencia, po.datainicio - (interval '2 sec') AS  dataencerramento
	FROM  (
		SELECT ta.idsolicitacaoservico, ta.idocorrencia, min(tp.idocorrencia) proximaocorrencia
		FROM tempanaliseocorrencias ta
		JOIN tempanaliseocorrencias tp ON 
			ta.idsolicitacaoservico = tp.idsolicitacaoservico
			AND ta.idocorrencia < tp.idocorrencia
		GROUP BY ta.idsolicitacaoservico, ta.idocorrencia
	      ) AS  tpo 
	   JOIN tempanaliseocorrencias po ON tpo.proximaocorrencia = po.idocorrencia	
     ) AS  tp
WHERE tp.idocorrencia  = o.idocorrencia ;

/*
INFORMA COMO DATA DE ENCERRAMENTO DA OCORRENCIA A HORA ATUAL PARA CHAMADOS EM ANDAMENTO
*/

  
-- USAR A MAXA DATA INICIO MAIS 1 DIA  QUANDO OS DADOS FOREM DESATUALIZADOS
UPDATE tempanaliseocorrencias SET  datafim = (SELECT  MAX(datainicio) + interval '1 day' FROM tempanaliseocorrencias)
--SELECT * FROM tempanaliseocorrencias
WHERE datafim is null
AND lower(situacaoatual) in ('resolvida','emandamento','reaberta','suspensa');

-- USAR A DATA DO RELÓGIO QUANDO OS DADOS FOREM ATUALIZADOS
UPDATE tempanaliseocorrencias SET  datafim = clock_timestamp()
--SELECT * FROM tempanaliseocorrencias
WHERE datafim is null
AND lower(situacaoatual) in ('resolvida','emandamento','reaberta','suspensa');



/*
INFORMA COMO DATA DE ENCERRAMENTO DA OCORRENCIA A HORA ATUAL PARA CHAMADOS FECHADAS E CANCELADAS
*/
UPDATE tempanaliseocorrencias SET  datafim = dataocorrencia + (interval '1 min') 
WHERE datafim is null
AND lower(situacaoatual) in ('fechada','cancelada');

/*
PREENCHE ESSES CASOS COM  A DATA FIM = DATA INICIO PARA ZERAR ESSE CASOS NA APURAÇÃO, 
ESSES SÃO CASOS RAROS QUE OCORRERAM NO INICIO DA OPERAÇÃO DO SISTEMA
*/
UPDATE tempanaliseocorrencias SET  datafim = datainicio + (interval '10 sec')
WHERE datainicio > datafim;


/*
VERIFICA SE FICARAM REGISTROS SEM DATA INICIO OU FIM
*/
SELECT * FROM tempanaliseocorrencias
WHERE datainicio is null
or datafim is null;

---update tempanaliseocorrencias set situacaoatual = 'CANCELADA' where idsolicitacaoservico = 8774
 

/*
COMBINA AS  INFORMAÇÕES DE SITUAÇÃO E CATEGORIA DA OCORRÊNCIA PARA DEFINIR O TIPO DE ATIVIDADE QUE ESTÁ OCORRENDO NO CHAMADO
*/
UPDATE tempanaliseocorrencias 
SET  atividade = case
		when situacaosolicitacao = 'CANCELADA' then 'CANCELAMENTO'
		when situacaosolicitacao = 'EM ANDAMENTO' AND  categoriaocorrencia = 'RECLASSIFICACAO' AND arearesponsavel = 'CIT-NIVEL1' then 'RECLASSIFICAÇÃO'
		when situacaosolicitacao = 'EM ANDAMENTO' then 'ATENDIMENTO'
		when situacaosolicitacao = 'FECHADA'  then 'FECHAMENTO'
		when situacaosolicitacao = 'REABERTA' AND  categoriaocorrencia = 'REABERTURA' then 'REABERTURA'		
		when situacaosolicitacao = 'REABERTA' then 'ATENDIMENTO'
		when situacaosolicitacao = 'REGISTRADA' then 'ABERTURA'
		when situacaosolicitacao = 'RESOLVIDA' then 'ENCERRAMENTO'
		when situacaosolicitacao = 'SUSPENSA' then 'ATENDIMENTO'
		else 'ATENDIMENTO'
	end;

/*
COMBINA AS  INFORMAÇÕES DE SITUAÇÃO E ACATEGORIA PARA CRIAR AS  TRANSIÇÕES NECESSÁRIA PARA A MINERAÇÃO E PROCESSOS RESUME E SUSPEND
*/ 
UPDATE tempanaliseocorrencias 
SET  transicao = CASE
		WHEN situacaosolicitacao = 'EM ANDAMENTO' AND  categoriaocorrencia = 'REATIVACAO' then 'resume'
		WHEN situacaosolicitacao = 'SUSPENSA' AND  categoriaocorrencia = 'SUSPENSAO' then 'suspend'
		ELSE 'start' END;


/*
ALTERAR A ÁREA DE GRUPO EXECUTOR DA ATIVIDADE DE 'ABERTURA' ,'FECHAMENTO', 'CANCELAMENTO','REABERTURA PARA USAR INFORMAÇÃO GENÉRICA, POIS O CITSMART MANTEM A INFORMAÇÃO DO
GRUPO ANTERIOR NO CHAMADO E NÃO DO GRUPO QUE REALIZOU  A OPERAÇÃO NO SISTEMA.
*/
UPDATE tempanaliseocorrencias toc SET  arearesponsavel = 'CIT-NIVEL1'
FROM (
	SELECT toc.idocorrencia 
	FROM tempanaliseocorrencias toc
	JOIN ocorrenciasolicitacao o on o.idocorrencia = toc.idocorrencia
	JOIN solicitacaoServico ss ON ss.idsolicitacaoservico = o.idsolicitacaoservico
        WHERE  toc.atividade IN ('FECHAMENTO')
	AND ss.idgruponivel1 = 2
	) AS T 
WHERE T.idocorrencia = toc.idocorrencia;


/*
ALTERAR A ÁREA DE GRUPO EXECUTOR DA ATIVIDADE DE ABERTURA PARA INDICAR OS CHAMADOS ABERTO PELO HELPDESK CIT-NIVEL1
*/
UPDATE tempanaliseocorrencias toc SET arearesponsavel = 'CIT-NIVEL1'
FROM (
	SELECT toc.idocorrencia 
	FROM tempanaliseocorrencias toc
	JOIN ocorrenciasolicitacao o on o.idocorrencia = toc.idocorrencia
	JOIN solicitacaoServico ss ON ss.idsolicitacaoservico = o.idsolicitacaoservico
	JOIN (
		SELECT u.nome, u.login, 
		COUNT(DISTINCT g.nome) grupos,
		COUNT(CASE WHEN  TRIM(g.nome) ='GR_CentralIT_Atendimento_1ºNivel' THEN g.nome ELSE NULL END) grupoNivel1
		FROM gruposempregados ge
		JOIN grupo g on g.idgrupo = ge.idgrupo
		JOIN empregados e on e.idempregado = ge.idempregado
		JOIN usuario u on u.idempregado = e.idempregado
		WHERE  upper(g.nome)  NOT LIKE 'SOLICITANTE MPOG'
		GROUP BY u.nome, u.login
		HAVING COUNT(CASE WHEN  TRIM(g.nome) ='GR_CentralIT_Atendimento_1ºNivel' THEN g.nome ELSE NULL END) = 1
		AND COUNT(DISTINCT g.nome) = 1
	     ) AS n1 ON n1.nome = o.registradopor or  n1.login = o.registradopor
	WHERE  toc.atividade IN ('ABERTURA')
	AND ss.idresponsavel <> ss.idsolicitante
	) AS T 
WHERE T.idocorrencia = toc.idocorrencia;





/*
ALTERAR A ÁREA DE GRUPO EXECUTOR DA ATIVIDADE DE ABERTURA PARA INDICAR OS CHAMADOS ABERTO PELO PORTAL
*/
UPDATE tempanaliseocorrencias taoc SET arearesponsavel = 'PORTAL'
FROM (
	SELECT toc.idocorrencia 
	FROM tempanaliseocorrencias toc
	JOIN ocorrenciasolicitacao o on o.idocorrencia = toc.idocorrencia
	JOIN solicitacaoServico ss ON ss.idsolicitacaoservico = o.idsolicitacaoservico
	WHERE  toc.atividade IN ('ABERTURA')
	AND ss.idresponsavel = ss.idsolicitante
	) AS T 
WHERE T.idocorrencia = taoc.idocorrencia;

-- select * 
-- from solicitacaoServico  ss
-- JOIN origematendimento org ON org.idorigem = ss.idorigem 
-- where org.descricao = 'Portal Citsmart'
-- AND ss.idresponsavel = ss.idsolicitante
-- limit 100

/*
--CONFERE O RESULTADO DAS ATIVIDADES E TRANSAÇÕES

SELECT  atividade, transicao, situacaosolicitacao, categoriaocorrencia, count(*)
FROM tempanaliseocorrencias
GROUP BY situacaosolicitacao, categoriaocorrencia, atividade, transicao
order by  atividade, transicao, situacaosolicitacao, categoriaocorrencia;


SELECT  DISTINCT atividade,categoriaocorrencia
FROM tempanaliseocorrencias
WHERE categoriaocorrencia LIKE '%SLA%';

*/

/*
***************************************************************************************************
GERA SAIDA DOS DADOS PARA ANÁLISE DO DESEMPENHO POR AREA RESPONSAVEL
GERAR ARQUIVOS DE LOGS DOS CHAMADOS POR ATIVIDADE E ÁREA RESPONSÁVEL
INICIO
***************************************************************************************************
*/
UPDATE tempanaliseocorrencias SET   agrupamentoregistrosporarea = null;


/*
*/

-- CRIA AGRUPAMENTO DE DADOS REGISTROS DE OCORRÊNCIA
UPDATE tempanaliseocorrencias toc SET   agrupamentoregistrosporarea = t.proxima
FROM (
	SELECT a.idocorrencia, a.idsolicitacaoservico, a.atividade, a.arearesponsavel, a.transicao, min(pd.idocorrencia) proxima
	FROM tempanaliseocorrencias a
	JOIN tempanaliseocorrencias pd 
		ON a.idsolicitacaoservico = pd.idsolicitacaoservico
	AND a.idocorrencia < pd.idocorrencia
	AND (a.atividade <> pd.atividade
	    OR a.arearesponsavel <> pd.arearesponsavel 
	    OR  a.transicao <>  pd.transicao
	    )
	GROUP BY  a.idocorrencia, a.idsolicitacaoservico, a.atividade, a.arearesponsavel, a.transicao
	--order by a.idsolicitacaoservico, a.idocorrencia
) AS  t
WHERE t.idocorrencia = toc.idocorrencia;

/*
*/
-- PREENCHE O AGRUPAMENTO DAS ÚLTIMAS OCORRENCIA COM O ULTIMO AGRUPAMENTO ADICIONANDO 1
UPDATE tempanaliseocorrencias toc SET   agrupamentoregistrosporarea = t.proxima + 1
FROM (
	SELECT u.idocorrencia, u.idsolicitacaoservico, u.atividade, u. arearesponsavel,u.transicao, max(aag. agrupamentoregistrosporarea) proxima
	FROM tempanaliseocorrencias u
	JOIN tempanaliseocorrencias aag 
	ON aag.idsolicitacaoservico = u.idsolicitacaoservico
	AND aag.idocorrencia < u.idocorrencia
	AND (aag.atividade <> u.atividade
	    OR aag. arearesponsavel <> u. arearesponsavel 
	    )
   
	WHERE u. agrupamentoregistrosporarea is null 
	GROUP BY  u.idocorrencia,u.idsolicitacaoservico, u.atividade, u. arearesponsavel,u.transicao
) AS  t
WHERE t.idocorrencia = toc.idocorrencia;

/*
*/
--AJUSTA OS REGISTRO QUE TEM APENAS UM REGISROS DE OCORRENCIA PARA USAR COMO AGRUPO O NUMERO DA OCORRECIA MENOS 1
UPDATE tempanaliseocorrencias toc SET   agrupamentoregistrosporarea = t.idocorrencia -1 
FROM (
	SELECT idsolicitacaoservico, count(*)qtdreg , 
	count(distinct  agrupamentoregistrosporarea) qtdagrup,
	min(idocorrencia) AS  idocorrencia
	FROM  tempanaliseocorrencias 
	GROUP BY idsolicitacaoservico
	having count(distinct  agrupamentoregistrosporarea) = 0
	AND count(*) = 1
  ) AS  t 
  WHERE t.idsolicitacaoservico = toc.idsolicitacaoservico
	AND t.idocorrencia = toc.idocorrencia;

/*
--VERIFICA SE FICAREM REGISTROS SEM AGRUPAMENTO	
SELECT *
FROM  tempanaliseocorrencias 
WHERE idsolicitacaoservico
		in (SELECT distinct idsolicitacaoservico
		FROM  tempanaliseocorrencias 
		WHERE  agrupamentoregistrosporarea is null)
order by idsolicitacaoservico, idocorrencia;
*/



/*
--VERIFICA COMBINAÇÕES DE ATIVIDADES E TRANSAÇÕES PARA AVALIAR CONSISTÊNCIA
SELECT  atividade, transicao, situacaosolicitacao, categoriaocorrencia, count(*)
FROM tempanaliseocorrencias
GROUP BY situacaosolicitacao, categoriaocorrencia, atividade, transicao
ORDER BY  atividade, transicao, situacaosolicitacao, categoriaocorrencia;


SELECT  atividade, transicao, arearesponsavel, areaoc ,count(*)
FROM tempanaliseocorrencias 
GROUP BY atividade, transicao, arearesponsavel, areaoc
ORDER BY  atividade, transicao, count(*) DESC ,arearesponsavel, areaoc


SELECT DISTINCT TOC.*, STIT.IDGRUPOEXECUTOR
FROM temporocorrenciasselecionadas  AS  toc
	JOIN (
		SELECT idsolicitacaoservico, datahora , COUNT(DISTINCT categoria )  AS  categorias,
		COUNT(CASE WHEN categoria = 'Encerramento' THEN 1 ELSE NULL END)  AS  "Encerramento",
		COUNT(CASE WHEN categoria = 'Execucao' THEN 1 ELSE NULL END)   AS  "Execucao",
		COUNT(*) 
		FROM temporocorrenciasselecionadas
		GROUP BY idsolicitacaoservico, datahora 
		HAVING COUNT(*)  >= 2
		AND COUNT(DISTINCT categoria ) =2
		AND COUNT(CASE WHEN categoria = 'Encerramento' THEN 1 ELSE NULL END)>= 1
		AND COUNT(CASE WHEN categoria = 'Execucao' THEN 1 ELSE NULL END)>= 1
		AND COUNT(*)  = COUNT(CASE WHEN categoria = 'Encerramento' THEN 1 ELSE NULL END) 
				+ COUNT(CASE WHEN categoria = 'Execucao' THEN 1 ELSE NULL END)		
	     )  AS  un ON  un.idsolicitacaoservico = toc.idsolicitacaoservico
	     AND un.datahora = toc.datahora
left JOIN tempOcorrenciaItemTrabalho tit ON tit.idocorrencia = TOC.idocorrencia	
left JOIN tempSolicitacaoItemTrabalho stit ON stit.idsolicitacaoservico = TOC .idsolicitacaoservico 
	AND stit.iditemtrabalho = tit.iditemtrabalho	     
	WHERE TOC.categoria IN ( 'Execucao','Encerramento')
ORDER BY TOC.idsolicitacaoservico, TOC.datahora	

SELECT  atividade, arearesponsavel ,count(*)
FROM tempanaliseocorrencias 
GROUP BY atividade,  arearesponsavel
ORDER BY  count(*) DESC , atividade,  arearesponsavel

SELECT  atividade, transicao, areaoc ,count(*)
FROM tempanaliseocorrencias 
GROUP BY atividade, transicao, areaoc
ORDER BY  atividade, transicao, areaoc
*/

--VALIDAÇÃO SE OS TEMPOS DAS OCORRENCIA ESTÁ COERENTE COM AS DURAÇÕES DOS CHAMADOS

drop table TEMP_VERIFICACONSISTENCIADOTEMPOATIVIDADES;

SELECT idsolicitacaoservico, INICIO, FIM , (FIM - INICIO) AS INTERVALOS, 
ROUND(CAST(EXTRACT(EPOCH FROM (FIM - INICIO))/(60*60) AS NUMERIC(10,4)) ,2) AS DURACAOTOTAL,
DURACAO AS DURACAOATIVIDADES
INTO TEMP_VERIFICACONSISTENCIADOTEMPOATIVIDADES
FROM (
	SELECT idsolicitacaoservico, MIN(datainicio) AS INICIO, MAX(datafim) AS  FIM,  SUM(ROUND(CAST(EXTRACT(EPOCH FROM (datafim - datainicio))/(60*60) AS NUMERIC(10,4)) ,2)) AS DURACAO
	FROM tempanaliseocorrencias 
	GROUP BY idsolicitacaoservico
) AS T
ORDER BY idsolicitacaoservico

SELECT *, DURACAOTOTAL - DURACAOATIVIDADES AS DIFERENCA
FROM TEMP_VERIFICACONSISTENCIADOTEMPOATIVIDADES
--WHERE DURACAOTOTAL >= DURACAOATIVIDADES + 0.1
ORDER BY DURACAOTOTAL - DURACAOATIVIDADES  DESC





/*
LIMPA TABELA DE LOGS
*/
TRUNCATE TABLE tempEventLogforProcessMiningbyArea;

/*
POPULA A TABELA PARA MINERAÇÃO DE PROCESSOS APENAS POR AREA ATUANTE NO CHAMADO
*/
INSERT INTO tempEventLogforProcessMiningbyArea 
(nomefluxo, situacaosolicitacao, case_id,  agrupamento, activityInstance_Name, event_Transition, org_group,role_name, resource_name, event_timeStamp)
SELECT nomefluxo, situacaosolicitacao, case_id,  agrupamento, activityInstance_Name, event_Transition, org_group, role_name, resource_name, event_timeStamp
FROM (

/*
TODAS AS  ATIVIDADES ATOMICAS QUE DURAM APENAS O TEMPO DE OPERAÇÃO NO SISTEMA JA CRIADAS COM A TRANSAÇÃO COMPLETE)
*/

SELECT nomefluxo, situacaosolicitacao, idsolicitacaoservico AS  case_id,  
agrupamentoregistrosporarea AS  agrupamento,
atividade AS  activityInstance_Name, 
--transicao AS 
'complete' as event_Transition, 
arearesponsavel AS  org_group, 
'--'  AS  role_name,
'--' AS  resource_name, 
min(datainicio) event_timeStamp
FROM tempanaliseocorrencias
WHERE atividade not IN ('ATENDIMENTO','FECHAMENTO') 
GROUP BY nomefluxo, situacaosolicitacao, idsolicitacaoservico,   agrupamentoregistrosporarea,atividade,
transicao, arearesponsavel 

UNION

/* DECIDI SMPLIFICAR OS CASOS DE ATIVIDADES ATOMICAS PARA APENAS A TRANSAÇÃO COMPLETE
CRIA ATIVIDADE DE ESPERA PARA O INTERVALOR ENTRE A ATIVIDADE ATOMICA A  PROXIMA ATIVIDADE DESENVOLVIDA
*/
--START IGUAL AO INICIO DA ATOMICA MAIS 5 SEGUNDOS
SELECT nomefluxo, situacaosolicitacao, idsolicitacaoservico AS  case_id,  
 agrupamentoregistrosporarea AS  agrupamento,
--atividade 
'FILA DE ESPERA' AS  activityInstance_Name, 
'start' AS  event_Transition, 
arearesponsavel AS  org_group, 
'--'  AS  role_name,
'--' AS  resource_name, 
min(datainicio)  + interval '5 sec' event_timeStamp
FROM tempanaliseocorrencias
WHERE atividade not IN ('ATENDIMENTO','FECHAMENTO') 
GROUP BY nomefluxo, situacaosolicitacao, idsolicitacaoservico,   agrupamentoregistrosporarea,atividade, 
transicao, arearesponsavel 
UNION

--COMPLETE IGUAL AO FIM DA ATOMICA
SELECT nomefluxo, situacaosolicitacao, idsolicitacaoservico AS  case_id,  
 agrupamentoregistrosporarea AS  agrupamento,
--atividade 
'FILA DE ESPERA' AS  activityInstance_Name, 
'complete' AS  event_Transition, 
arearesponsavel AS  org_group, 
'--'  AS  role_name,
'--' AS  resource_name, 
max(datafim)  event_timeStamp
FROM tempanaliseocorrencias
WHERE atividade not IN ('ATENDIMENTO','FECHAMENTO') 
GROUP BY nomefluxo, situacaosolicitacao, idsolicitacaoservico,   agrupamentoregistrosporarea,atividade, 
transicao, arearesponsavel 


UNION


/*
TRANSIÇÕES DE SUSPENSÃO E REATIVAÇÃO DOS CHAMADOS
*/
SELECT nomefluxo,  situacaosolicitacao, idsolicitacaoservico AS  case_id,  
 agrupamentoregistrosporarea AS  agrupamento,
atividade AS  activityInstance_Name, 
transicao AS  event_Transition, 
arearesponsavel AS  org_group, 
'--'  AS  role_name,
'--' AS  resource_name, 
min(datainicio) event_timeStamp
FROM tempanaliseocorrencias
WHERE  atividade IN ('ATENDIMENTO')
AND transicao IN ('suspend','resume') 
GROUP BY nomefluxo, situacaosolicitacao, idsolicitacaoservico,   agrupamentoregistrosporarea,atividade,
 transicao, arearesponsavel 

UNION

/*
CRIA TRANSIÇÃO START PARA ATIVIDADES DE ATENDIMENTO COM A MENOR DATA DE INICIO DO AGRUPAMENTO
*/

SELECT nomefluxo, situacaosolicitacao,  idsolicitacaoservico AS  case_id,  
 agrupamentoregistrosporarea AS  agrupamento,
atividade AS  activityInstance_Name, 
transicao AS  event_Transition, 
arearesponsavel AS  org_group, 
'--'  AS  role_name,
'--' AS  resource_name, 
min(datainicio) event_timeStamp
FROM tempanaliseocorrencias
WHERE  atividade IN ('ATENDIMENTO','FECHAMENTO') 
AND transicao NOT IN ('suspend','resume') 
GROUP BY nomefluxo, situacaosolicitacao, idsolicitacaoservico,   agrupamentoregistrosporarea,atividade,
 transicao, arearesponsavel 

UNION

/*
CRIA TRANSIÇÃO COMPLETA PARA ATIVIDADES DE ATENDIMENTO COM A MAIOR DATA DE FIM DO AGRUPAMENTO
*/

SELECT nomefluxo,situacaosolicitacao,  idsolicitacaoservico AS  case_id,  
 agrupamentoregistrosporarea AS  agrupamento,
atividade AS  activityInstance_Name, 
'complete' AS  event_Transition, 
arearesponsavel AS  org_group, 
'--'  AS  role_name,
'--' AS  resource_name, 
max(datafim) event_timeStamp
FROM tempanaliseocorrencias
WHERE  atividade IN ('ATENDIMENTO','FECHAMENTO') 
AND transicao NOT IN ('suspend','resume') 
GROUP BY nomefluxo, situacaosolicitacao, idsolicitacaoservico,   agrupamentoregistrosporarea,atividade,
 transicao, arearesponsavel 

) AS  t
ORDER BY case_id,  event_timeStamp;



-- AJUSTA A ÁREA DA ATIVIDADE DE ESPERA PARA A ÁREA DA PRÓXIMA ATIVIDADE

UPDATE tempEventLogforProcessMiningbyArea AS EV SET org_group = T.org_group
FROM (
SELECT ATUALESPERA.event_id, PROXIMO.org_group
FROM (
	SELECT E.activityInstance_Name, E.case_id, E.event_id, min(P.event_id) as proxevent_id 
	FROM tempEventLogforProcessMiningbyArea E
	JOIN tempEventLogforProcessMiningbyArea P
		ON P.case_id = e.case_id
		and P.event_id > e.event_id
	WHERE E.activityInstance_Name = 'FILA DE ESPERA'
	AND  P.activityInstance_Name <> 'FILA DE ESPERA'
	GROUP BY  E.activityInstance_Name, E.case_id, E.event_id
	) ATUALESPERA 
JOIN tempEventLogforProcessMiningbyArea PROXIMO	
	ON ATUALESPERA.proxevent_id = PROXIMO.event_id  
) AS T 
WHERE T.event_id = EV.event_id;




SELECT case_id, COUNT(*) 
FROM tempEventLogforProcessMiningbyArea 
GROUP BY case_id
ORDER BY COUNT(*) DESC





/*
--ANÁLISE DOS LOGOS GERADOS
SELECT activityInstance_Name,org_group, count(*), count(distinct case_id)
FROM tempEventLogforProcessMiningbyArea
WHERE case_id IN (
		SELECT case_id
		FROM tempEventLogforProcessMiningbyArea 
		GROUP BY case_id
		having min(event_timeStamp)>= '2014-10-01 00:00:00' 
   )
GROUP BY activityInstance_Name,org_group   
ORDER BY activityInstance_Name, count(distinct case_id)desc;


SELECT ori.descricao, activityInstance_Name,org_group, count(distinct case_id)
FROM tempEventLogforProcessMiningbyArea a
JOIN solicitacaoservico s ON s.idsolicitacaoservico = a.case_id
JOIN origematendimento ori ON ori.idorigem = s.idorigem
GROUP BY ori.descricao, activityInstance_Name,org_group
order by activityInstance_Name, ori.descricao,  count(distinct case_id)desc




*/


/*
--VERIFICA A QUANTIDADE DE REGISTROS POR MÊS
SELECT  date_part('year'::text, event_timeStamp) AS  ANO,  date_part('month'::text, event_timeStamp) AS  MES, COUNT(*) 
FROM tempEventLogforProcessMiningbyArea 
WHERE event_timeStamp between '2014-09-01 00:00:00' AND '2015-02-01 00:00:00'  
GROUP BY  date_part('year'::text, event_timeStamp),  date_part('month'::text, event_timeStamp)
ORDER BY date_part('year'::text, event_timeStamp),  date_part('month'::text, event_timeStamp);
*/


/*
CONSULTA PARA GERAÇÃO DO ARQUIVO DE LOG - GERA ARQUIVO DE LOG DOS CHAMADOS 
ABERTOS A PARTIR DE OUTUBRO DE 2014 A JANEIRO DE 2015
*/

SELECT distinct pm.nomefluxo, pm.situacaosolicitacao , to_char(case_id, '0000000') AS  idSolicitacao , pm.agrupamento, to_char(event_Id, '000000000') AS  idEventolog ,  
activityInstance_Name as atividade, event_Transition transicaoAtividade, 
org_group as areaExecucaoAtividade, role_name as  papelExecucaoAtividade, 
resource_name as papelExecucaoAtividade, to_char(event_timeStamp, 'dd-mm-yyyy HH24:MI:SS') AS  dataHoraEventoLog,
split_part(S.NOMESERVICO,' - ',1) as grupoServico, split_part(S.NOMESERVICO,' - ',2) as servico, split_part(S.NOMESERVICO,' - ',3) as operacaoServico,
btrim(upper(td.nometipodemandaservico::text), ' '::text) AS tipoSolicitacao,
btrim(upper(prd.nomeprioridade::text), ' '::text) AS prioridade,
btrim(upper(org.descricao::text), ' '::text) AS origemSolicitacao,
round(tans.tempohh + ( tans.tempomm/60),2) as TempoAtendimentoSLAServico,
round(ss.prazohh + ( ss.prazomm/60),2) as TempoAtendimentoSLAChamado,  
SPLIT_PART(SPLIT_PART(ge.descricao, 'AREA=', 2),']',1)  AS  areaResponsavelServico
FROM tempEventLogforProcessMiningbyArea pm
JOIN solicitacaoServico ss ON ss.idsolicitacaoservico = pm.case_id
JOIN servicocontrato sc ON sc.idservicocontrato = ss.idservicocontrato
JOIN servico s on s.idservico = sc.idservico
LEFT JOIN prioridade prd ON prd.idprioridade = ss.idprioridade
LEFT JOIN origematendimento org ON org.idorigem = ss.idorigem
LEFT JOIN tipodemandaservico td ON td.idtipodemandaservico = ss.idtipodemandaservico
join acordoservicocontrato asct on asct.idservicocontrato = sc.idservicocontrato
join acordonivelservico ans on ans.idacordonivelservico = asct.idacordonivelservico
join tempoacordonivelservico tans on tans.idacordonivelservico = ans.idacordonivelservico 
	and tans.idfase = 2 and  tans.idprioridade = 3
join grupo ge on ge.idgrupo = sc.idgrupoexecutor
WHERE upper(ss.situacao) =  'FECHADA' and 
 case_id IN (
		SELECT case_id
		FROM tempEventLogforProcessMiningbyArea 
		where nomefluxo = 'SOLICITACAOSERVICOCOMQUALIDADE'
		GROUP BY case_id
		having min(event_timeStamp)>= '2014-10-01 00:00:00' 
		order by case_id
   )
ORDER BY idSolicitacao,dataHoraEventoLog;


/*
GRAVAR O ARQUIVO EM: D:\Pesquisa de Mestrado\Mineração de Processos\Arquivos de Logs
*/


select COUNT(*) from tempEventLogforProcessMiningbyArea 
order by event_Id desc limit 1000


/*
***************************************************************************************************
       FIM DA GERAÇÃO DE ARQUIVOS DE LOGS DOS CHAMADOS POR ATIVIDADE E ÁREA RESPONSÁVEL
***************************************************************************************************
*/
