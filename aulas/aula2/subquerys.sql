--O GROSSO DA AULA 2 ESTÁ NA RESOLUÇÃO DO EXERCÍCIO 2

select (10 + 2) * 5 from dual --Operações matemáticas no APEX Oracle

--duas formas de mostrar tudo que foi movimentado
select nome from produto where cod_prod in (select cod_prod from movimento)

select nome from produto p, movimento m where p.cod_prod = m.cod_prod

--mostrando produtos que nunca foram movimentados
select nome from produto p where cod_prod not in (select cod_prod from movimento)

--O GROSSO DA AULA 2 ESTÁ NA RESOLUÇÃO DO EXERCÍCIO 2