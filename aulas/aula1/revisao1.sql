--Revisando Funções agregadoras em SQL

--Soma das tabelas
SUM 

--Média dos valores de um campo
AVG

--Pega o valor máximo
MAX

--Pega o valor mínimo
MIN

--Conta o número de linha na tabela
SELECT * FROM cliente;
SELECT COUNT(*) FROM cliente; 
SELECT COUNT(*) FROM cliente WHERE limite > 500; --afunilando a busca com qualificação, usando WHERE e nome da coluna.
SELECT COUNT (*) FROM cliente WHERE upper(status) = 'BOM'; --usando função upper para convereter todas os acmpos da coluna para upper e comparando com o valor que defini.
--EVITAR usar funções em consultas para diminuir o consumo de memória. 

select count(*), sum(limite), avg(limite), max(limite), min(limite) from cliente; --faz os cálculos dos operadores usando os valores da coluna limite da tabela cliente.

--Usando o AS
select count(*) AS "Total", sum(limite) "Soma de todos os limites", avg(limite) "Média de todos os limites", max(limite) "Limite máximo", min(limite) "Menor limite" from cliente; 
--A formatção reconhece o as apas duplas sem o AS

--OBS Lembrar que aspas simples é uma comparaçaõ em string, e duplas é formatação com o uso de AS.


--AGRUPANDO
select cidade, status, count(*) Total from cliente group by cidade, status;

