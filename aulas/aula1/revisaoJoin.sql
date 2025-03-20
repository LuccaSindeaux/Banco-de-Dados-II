--Queries baseadas nas tabelas do exercicio 1

select * from cliente;

select * from pedido where rownum = 1; --pega a linha de número 1
--exclusivo do Oracle

select * from pedido fetch first 3 rows only; --pega todas as lihnhas que vão até 3, ideal para consultas em tabelas grandes, aí não é consumida muita memória

select nome, nro_ped from cliente c inner join pedido p on (c.cod_cli = p.cod_cli) --revisão de Join e alias. 


--Mostrar o nome o número dos pedidos para produtos da categoria sabão
select c.nome, p.nro_ped from cliente c, pedido p, produto prod, movimento m --como a coluna nome e nro_ped esté em mais d euma tabela, devo especificar de onde estou puxando
    where c.cod_cli = p.cod_cli --junção  de cliente com e pedido 
        and categoria = 'sabão' --qualifica a consulta
        and p.nro_ped = m.nro_ped --junção de pedido e movimento
        and m.cod_prod = prod.cod_prod --junção entre movimento e produto
-- a quantidade de junções da consulta é o número de tabelas do from -1; portanto 3 junções