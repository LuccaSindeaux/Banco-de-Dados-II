create table empregados (
    id_emp varchar(10) not null,
    nome varchar(30) not null,
    id_emp_gerente varchar(10),
    primary key (idEmp)
)
insert into empregados values ('E01', 'SEFORA', NULL)
insert into empregados values ('E02', 'ADAM', 'E01')
insert into empregados values ('E03', 'DEBORA', 'E01')
insert into empregados values ('E04', 'KAI', NULL)
insert into empregados values ('E05', 'LUCAS', 'E04')
insert into empregados values ('E06', 'GABRIEL', NULL)
insert into empregados values ('E07', 'VITOR', NULL)
insert into empregados values ('E08', 'ANTONIO', 'E06')
--Alterando as funções
UPDATE empregados set  id_emp_gerente = 'E06' where id_emp = 'E04'
UPDATE empregados set  id_emp_gerente = 'E07' where id_emp = 'E06';
UPDATE empregados set  id_emp_gerente = 'E07' where id_emp = 'E01';
-- Consultando: Mostre o nome do empregado e o nome do seu gerente
SELECT EMP.NOME, GER.NOME FROM EMPREGADOS EMP , EMPREGADOS GER
WHERE GER.id_emp = EMP.id_emp_gerente
-- Auxiliar
create table empregados_AUX (
    id_emp varchar(10) not null,
    nome varchar(30) not null,
    id_emp_gerente varchar(10)
)
-- Copia os dados da Original para a Auxiliar
insert into empregados_AUX
select * from empregados
-- Altera a estrutura da tabela Original
drop table empregados
create table empregados (
    id_emp varchar(10) not null,
    nome varchar(30) not null,
    id_emp_gerente varchar(10),
    id_segundo_gerente varchar(10),
      primary key (id_emp)
)
-- Volta os dados
insert into empregados
select id_emp, nome, id_emp_gerente, null from empregados_AUX
-- Vinculando novo gestor ao Lucas
UPDATE Empregados set id_segundo_gerente = 'E08' where id_emp = 'E05';
select * from empregados

-- Considerando as alterações na tabela Empregados, que um empregado poderá ter dois gerentes:
-- Faça uma consulta para que mostre o nome do empregado e do(s) seu(s) gerente(s)

select emp.nome as empregado, ger.nome as gerente, seg.nome as SegundoGerente 
    from empregados emp
    join empregados ger
        on emp.id_emp_gerente = ger.id_emp;

-- Com WHERE e AND
SELECT emp.nome AS empregado, 
       ger.nome AS gerente, 
       seg.nome AS Segundo_gerente 
       from empregados emp, empregados ger, empregados seg
        where ger.id_emp = emp.id_emp_gerente
        and seg.id_emp(+) = emp.id_segundo_gerente
            order by emp.id_emp;

SELECT emp.nome AS empregado, 
       ger.nome AS gerente, 
       seg.nome AS Segundo_gerente 
       from empregados emp, empregados ger, empregados seg
        where ger.id_emp = emp.id_emp_gerente
        OR seg.id_emp = emp.id_segundo_gerente
            order by emp.id_emp;


-- Com JOIN e LEFT JOIN
SELECT 
    emp.nome AS empregado,
    ger.nome AS gerente,
    seg.nome AS segundo_gerente
FROM 
    empregados emp
    JOIN empregados ger ON ger.id_emp = emp.id_emp_gerente
    LEFT JOIN empregados seg ON seg.id_emp = emp.id_segundo_gerente
    order by emp.id_emp;

-- Com Subquerys
SELECT 
    emp.nome AS empregado,
    (SELECT ger.nome 
     FROM empregados ger 
     WHERE ger.id_emp = emp.id_emp_gerente) AS gerente,
    
    (SELECT seg.nome 
     FROM empregados seg 
     WHERE seg.id_emp = emp.id_segundo_gerente) AS segundo_gerente
FROM 
    empregados emp
WHERE 
    emp.id_emp_gerente IS NOT NULL; 