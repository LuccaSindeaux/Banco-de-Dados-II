select * from cliente inner join produto p on (c.cod_cli = p.cod_cli) where idade >= 20

--trazendo os "nulos", usase-se o left join

select c.cod_cli, nome, nro_ped from cliente c left join pedido p on(c.cod_cli = p.cod_cli) --Vai mostrar o cliente c3 que nunca pediu

--DCL Linguagem de Controle de Dados, são as permissões de quem pode mexer nas tabelas e realizar consultas
--As ferramentas VIEWS criam esquemas para visualização do usuário, elas NÃO CRIAM TABELAS, portando NÃO POSSUEM DADOS; Elas são somente janelas que representam os dados
select * from cliente

create OR replace view vcliente as 
    select cod_cli, nome, cidade, uf, telefone, status from cliente
    where limite > 500


select * from vcliente