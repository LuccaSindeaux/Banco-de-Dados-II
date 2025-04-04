--Mostre o código dos clientes que NUNCA fizeram pedido consultas negativas
select cod_cli from cliente where cod_cli not in (select cod_cli from pedido)


--União de domínios comuns
select cod_cli from cliente UNION ALL select cod_cli from pedido

--Intersecção 
select cod_cli from cliente INTERSECT select cod_cli from pedido --equivale ao JOIN

--Subtração
select cod_cli from cliente MINUS select cod_cli from pedido --equivale ao NOT IN


--Comando EXIST
select nome from produto
    where exists
    ( select cod_prod
     from movimento
     where cod_prod = produto. cod_prod ); --EXIST é sempre usado no para juntar subqueries
 
--NOT EXIST
select nome, cod_cli from cliente 
    where not exists (select * from pedido where cliente.cod_cli = pedido.cod_cli) --nome e código de clientes que nunca fizeram pedido