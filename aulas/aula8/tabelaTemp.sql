CREATE OR REPLACE PROCEDURE criar_e_usar_tabela_temp AS
 -- Variável para armazenar o comando SQL de criação
 v_sql_create VARCHAR2(4000);
 -- Variável para armazenar o comando SQL de inserção
 v_sql_insert VARCHAR2(4000);
 vcodcli varchar(10);
 vnome varchar(40);
BEGIN
 -- Criando a tabela temporária dinamicamente
 v_sql_create := '
 CREATE GLOBAL TEMPORARY TABLE TMP_CLIENTE (COD_CLI VARCHAR2(10), NOME VARCHAR2(40))';
 EXECUTE IMMEDIATE v_sql_create;
 -- Inserindo dados na tabela temporária usando SELECT com WHERE
 v_sql_insert := '
 INSERT INTO TMP_CLIENTE (cod_cli, nome)
 SELECT cod_cli, nome FROM cliente WHERE cod_cli = ''c1''
 ';
 EXECUTE IMMEDIATE v_sql_insert;
 -- Opcional: limpar a tabela ao final (não obrigatório se ON COMMIT DELETE ROWS)
 EXECUTE IMMEDIATE 'DROP TABLE TMP_CLIENTE';
EXCEPTION
 WHEN OTHERS THEN
 DBMS_OUTPUT.PUT_LINE('Erro: ' || SQLERRM);
END;
