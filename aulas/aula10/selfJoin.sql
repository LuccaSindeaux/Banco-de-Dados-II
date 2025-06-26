CREATE TABLE empregados(
    id_emp VARCHAR2(5) PRIMARY KEY NOT NULL,
    nome VARCHAR2(200),
    id_emp_gerente VARCHAR(100)
);



begin
    insert into empregados values ('E01', 'Lisiane', NULL);
    insert into empregados values ('E02', 'Butiá', 'E01');
    insert into empregados values ('E03', 'Gustavo', 'E01');
    insert into empregados values ('E04', 'Lucca', NULL);
    insert into empregados values ('E05', 'Lorenzo','E04');
end;

-- Self join (autorelacionamento) Mostre o nome do empregado e do seu gerente.

-- com join
select emp.nome as empregado, ger.nome as gerente 
    from empregados emp
    join empregados ger
        on emp.id_emp_gerente = ger.id_emp;

-- com where
select emp.nome as empregado, ger.nome as gerente from empregados emp, empregados ger
    where ger.id_emp = emp.id_emp_gerente


-- Inserir novo funcionário que será gerente de Lucca
insert into empregados values ('E06', 'Rene', NULL);
update empregados set id_emp_gerente = 'E06' where id_emp = 'E04';


-- Inserir novo funcionário que será grenete de Lisiane e Rene
insert into empregados values ('E07', 'Vitor', NULL);

begin
    update empregados set id_emp_gerente = 'E07' where id_emp = 'E01';
    update empregados set id_emp_gerente = 'E07' where id_emp = 'E06';
end;


-- Inserir novo funcionário que será funça do Rene, mas será TAMBÉM será chefe do Lorenzo
insert into empregados values ('E08', 'Gastão', NULL);

begin
    update empregados set id_emp_gerente = 'E04' where id_emp = 'E05';
    update empregados set id_emp_gerente = 'E06' where id_emp = 'E08';
end;

create table empregados_AUX( --Faz backup da tabela para pode apagar a original e criar a nova coluna 
    id_emp varchar(10) not null,
    nome varchar(100) not null,
    id_emp_gerente varchar(10)
);

insert into empregados_AUX select * from empregados;

drop table empregados
CREATE TABLE empregados(
    id_emp VARCHAR2(10) PRIMARY KEY NOT NULL,
    nome VARCHAR2(200),
    id_emp_gerente VARCHAR(10),
    id_segundo_gerente varchar(10)
);

insert into empregados
    select id_emp, nome, id_emp_gerente, null from empregados_AUX;


-- Agora faz o segundo upddate para dar o segundo gerente ao Lorenzo
update empregados set id_segundo_gerente  = 'E08' where id_emp = 'E05';
select * from empregados

-- A consulta também deverá ser modificada
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
