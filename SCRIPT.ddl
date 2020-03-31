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

--OPERADORES DE CONJUNTOS
/*
O operador union retorna resultados das duas consultas
após eliminar os valores duplicados (pra selecionar
valores duplicados usase union all)
    Select employee_id, job_id
    from employees
    UNION 
    Select employee_id, job_id
    from job_history:
*/
/*
O operador intersect retorna linhas comuns as duas consultas
    Select employee_id, job_id
    from employees
    INTERSECT
    Select employee_id, job_id
    from job_history:
*/
/*
O operador minus retorna as linhas da primeira consultas
que não estão presentes na segunda consulta
    Select employee_id, job_id
    from employees
    MINUS
    Select employee_id, job_id
    from job_history:
*/

--CRIAÇAO DE VIEW
/*
    CREATE VIEW empvu80
    as SELECT employee_id, last_name, salary
    from employees
    WHERE department_id=80;
*/
/*
    View complexa
    CREATE VIEW DEPT_SUM_VU
    (NAME,MINSAL, MAXSAL,AVGSAL)
    AS SELECT d.department_name, MIN(e.salary),
            MAX(e.salary),AVG(e.salary)
    FROM employees e, departments d
    WHERE e.department_id = d.department_id
    GROUP BY d.department_name;
*/
/*
CREATE OR REPLACE VIEW EMPVU10
AS SELECT * 
FROM EMPLOYEES
WHERE DEPARTMENT_ID=20
with read only constraint empvu_ck;

SELECT * FROM .EMPVU10;

update empvu20
set department_id=10
where employee_id=201;
rollback;
desc EMPVU20;
insert into empvu20
values (9123,null,'Clarisvertino','claris@xpto',null,sysdate,'IT_PROG',null,null,null,20);
--Graças ao with check option o dominio nao pode ser alocado, pode deletar e inserir
*/
