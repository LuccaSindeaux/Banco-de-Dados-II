--Subquerys são caracterizadas pelo uso do concatenador IN - linha 6 do código, queries baseadas nas tabelas do exercicio 1

select (10 + 2) * 5 from dual --criação de uma tabela imaginária em ORACLE para relizar contas matemáticas

--duas formas de mostrar tudo que foi movimentado
select nome from produto where cod_prod in (select cod_prod from movimento)
--Com o IN é criado uma query que realiza uma consulta dinâmica, ela é rezliada primeiro por estar entre parênteses, e o SELECT escrito primeiro, a bica em si, terá está subquery como qualificadora de sua busca.

select nome from produto p, movimento m where p.cod_prod = m.cod_prod

--mostrando produtos que nunca foram movimentados
select nome from produto p where cod_prod not in (select cod_prod from movimento)