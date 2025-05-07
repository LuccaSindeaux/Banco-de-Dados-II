create or replace procedure PrcTesteCursor_WHILE is
--Declarando as variáveis que serão manipuladas
    vCod_cli varchar2(10);
    vNome varchar2(40);
    vID int := 1;
--Criando o cursor que fará um select na tabela de clientes...
cursor cC1 is
    SELECT cod_cli, nome FROM CLIENTE ORDER BY cod_cli;
    begin
    dbms_output.put_line('*****EXEMPLO DE LAÇO USANDO WHILE LOOP- END LOOP*****');
--Exemplo de Laço do tipo WHILE LOOP - END LOOP
--Abrindo o cursor
open cC1;
-- 1-) Instrução de início do loop
--Este loop será executado enquanto a variável vID for menor que 3
WHILE vID <= 3 LOOP
dbms_output.put_line('********************************************************');
--2-) Atribuindo o retorno da consulta, às variáveis
fetch cC1
into vCod_cli, vNome;
--3-) Escrevendo o valor das variáveis somente...
dbms_output.put_line('ID: ' || vCod_cli);
dbms_output.put_line('Nome: ' || vNome);
 vID:= vID + 1;
--4-) instrução para finalizar o loop
end loop;
--5-)Fechando o cursor para disponibilizar os recursos que estavam sendo utilizados
close cC1;
end ;


--- Testando
begin
PrcTesteCursor_WHILE;
end;


--Para Executar:
-- Procedure prctestecursor_while:
begin
    prctestecursor_while;
end;