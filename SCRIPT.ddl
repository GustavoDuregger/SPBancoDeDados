--AUTOR: GUSTAVO DUREGGER
CREATE TABLE sp_carros (
    placa_id              VARCHAR2(7) NOT NULL,
    veiculo               VARCHAR2(55),
    obs                   CLOB,
    classe                VARCHAR2(55),
    cor                   VARCHAR2(55),
    contrato_contrato_id  NUMBER NOT NULL
);

ALTER TABLE sp_carros ADD CONSTRAINT carros_pk PRIMARY KEY ( contrato_contrato_id );

CREATE TABLE sp_cartoes (
    numero_id             NUMBER NOT NULL,
    nome                  VARCHAR2(55) NOT NULL,
    cvv                   NUMBER NOT NULL,
    validade              DATE NOT NULL,
    contrato_contrato_id  NUMBER NOT NULL
);

ALTER TABLE sp_cartoes ADD CONSTRAINT cartoes_pk PRIMARY KEY ( numero_id );

CREATE TABLE sp_contrato (
    contrato_id  NUMBER NOT NULL,
    tipo         NUMBER NOT NULL
);

ALTER TABLE sp_contrato ADD CONSTRAINT contrato_pk PRIMARY KEY ( contrato_id );

CREATE TABLE sp_login (
    email_id  VARCHAR2(55) NOT NULL,
    senha     NVARCHAR2(55) NOT NULL
);

ALTER TABLE sp_login ADD CONSTRAINT login_pk PRIMARY KEY ( email_id );

CREATE TABLE sp_usuarios (
    cpf_id                VARCHAR2(11 CHAR) NOT NULL,
    nome                  VARCHAR2(55) NOT NULL,
    sobrenome             VARCHAR2(50) NOT NULL,
    telefone              VARCHAR2(11),
    qrcode                VARCHAR2(8),
    login_email_id        VARCHAR2(55) NOT NULL,
    email_id              VARCHAR2(55) NOT NULL,
    contrato_contrato_id  NUMBER NOT NULL
);

ALTER TABLE sp_usuarios ADD CONSTRAINT usuarios_pk PRIMARY KEY ( email_id,
                                                                 contrato_contrato_id );

ALTER TABLE sp_carros
    ADD CONSTRAINT carros_contrato_fk FOREIGN KEY ( contrato_contrato_id )
        REFERENCES sp_contrato ( contrato_id );

ALTER TABLE sp_cartoes
    ADD CONSTRAINT cartoes_contrato_fk FOREIGN KEY ( contrato_contrato_id )
        REFERENCES sp_contrato ( contrato_id );

ALTER TABLE sp_usuarios
    ADD CONSTRAINT usuarios_contrato_fk FOREIGN KEY ( contrato_contrato_id )
        REFERENCES sp_contrato ( contrato_id );

ALTER TABLE sp_usuarios
    ADD CONSTRAINT usuarios_login_fk FOREIGN KEY ( login_email_id )
        REFERENCES sp_login ( email_id );

--INSERÇÃO DE DADOS NA TABELA
/*INSERT INTO SP_USUARIOS(CPF_ID, NOME, SOBRENOME, TELEFONE, QRCODE)
VALUES ("000000000","GUSTAVO","DUREGGER","11900000000","YYY0405");*/

--VISUALIZAÇÃO DE DADOS  REFERENTE AO USUARIO
/*SELECT CPF_ID, NOME, SOBRENOME
FROM SP_USUARIOS;*/

--UPDATE E DELETE
/*  UPDATE SP_USUARIOS SET TELEFONE="12900000000" WHERE SOBRENOME="DUREGGER";
    DELETE FROM SP_USUARIOS WHERE CPF_ID="000000000";
*/

--DINSTINÇÃO
/*  SELECT DISTINCT VEICULO
    FROM   SP_CARROS;
*/

--DADOS ORDENADOS
/*  SELECT NOME, SOBRENOME
    FROM SP_USUARIOS
    WHERE CONTRATO_CONTRATO_ID = 1
    ORDER BY NOME;
*/

--BUSCA EM DUAS TABELAS (PODE SE UTILIZAR JOIN)
/*  SELECT  U.CPF_ID, U.NOME, U.SOBRENOME, C.PLACA_ID
    FROM SP_USUARIOS U JOIN SP_CARROS C
    ON (U.CPF_ID = C.PLACA_ID)
*/

--SUBCONSULTAS
/*  SELECT NOME, SOBRENOME 
    FROM SP_USUARIOS
    WHERE PLACA_ID = (SELECT PLACA_ID 
                    FROM SP_CARROS
                    WHERE VEICULO='CITROEN');
*/

--FUNÇÕES DE UNICA LINHA NA DUAL
/*
    SELECT 
        CONCAT('Hello', 'World'), --Une valores (Você está limitado a usar dois parâmetros com CONCAT.)
        SUBSTR('HelloWorld',1,5), --Extrai uma string de tamanho determinado
        LENGTH('HelloWorld'), --Mostra o tamanho de uma string como um valor numérico
        INSTR('HelloWorld', 'W'), --Localiza a posição numérica de um caractere nomeado
        REPLACE('JACK and JUE','J','BL'), --Preenche o valor do caractere à direita
        TRIM('H' FROM 'HelloWorld') --Reduz os caracteres à direita ou à esquerda (ou nas duas direções) 
        --de uma string de caracteres 
    FROM DUAL;

    Select to_char(sysdate,'dd'),
           to_char(sysdate,'dd-mm-rrrr'),
           to_char(sysdate,'dy-mm-rrrr')
    from dual;
    
    SELECT TO_CHAR(SYSDATE,'HH24:MI:SS AM'),
       TO_CHAR(SYSDATE,'DD/MM/RRRR HH24:MI:SS')
    FROM DUAL;
*/
