-- Criação da tabela
create table depto (coddepto integer not null,
departamento varchar(30) not null,
capacidade number,
primary key (coddepto));
-- Inserções da tabela
begin
    insert into depto values (1,'Recursos Humanos');
    insert into depto values (2,'Informatica');
    insert into depto values (3,'Contabilidade');
end;

-- Criação de uma tabela auxiliar, que é igual a primeira, mas SEM PRIMARY KEY
create table deptoAux (coddepto integer not null,
departamento varchar(30) not null);

-- Usando query para fazer o insert na auxiliar sem precisar fazer linha a linha.
insert into deptoAux select * from depto

-- com uma auxiliar criada eu poderia apagar a minha original e fazer o processo reverso para popular ela insert into depto select * from deptoAux
drop table depto
-- Neste caso como eu adicionei a coluna capacidade eu tenho que prever estes erros com  -> colunas originais que tinham na tabela antes de ser dropada
insert into depto select coddepto, departamento, null from deptoAux

select coddepto, departamento, capacidade, nvl(capacidade, 0) as Tratada from depto

--TABELA DE EMPREGADOS 

create table empregado (codemp integer not null,
nome varchar (30) not null,
salario float not null,
salario_ant float null,
coddepto integer not null,
primary key (codemp), 
foreign key (coddepto) references depto);

    --Inserção empregados
begin
    insert into empregado values (1, 'Pedro', 1200, null, 1);
    insert into empregado values (2, 'Marta', 1500, null, 2);
    insert into empregado values (3, 'Paulo', 2200, null, 2);
    insert into empregado values (4, 'Mauro', 2700, null, 2);
end;


-- Tabela de ERROS
create table tabela_erros (
descricao
varchar(50) not null);
-- Tratamento de erros com EXCEPTION
declare
 v_salario_ant float;
begin
    select salario_ant into v_salario_ant
    from empregado
    where codemp = 1;
    if v_salario_ant is null then
        update empregado
        set salario_ant = salario
        where codemp = 1;
        commit;
    end if;
    exception
     when NO_DATA_FOUND then
     insert into tabela_erros
     values ('Empregado não encontrado.');
end;