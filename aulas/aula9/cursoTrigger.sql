-- cria tebala cursos
create table curso2 (codcurso integer not null,
curso varchar(30) not null,
carga_horaria integer not null,
carga_horaria_ant integer null,
primary key (codcurso));

-- inserções
begin
    insert into curso2 values (1, 'Android', 20, null);
    insert into curso2 values (2, 'PL/SQL', 12, null);
    insert into curso2 values (3, 'Java', 120, null);
    insert into curso2 values (4, 'Oratoria', 20, null);
end;


-- criação da trigger
create or replace trigger curso2_ch
before update of carga_horaria on curso2
for each row
    begin
        if nvl(:new.carga_horaria,0) < nvl(:old.carga_horaria,0) then --nvl testa se o valor é nulo
            raise_application_error(-20003,'A carga horária do curso nao pode ser diminuida.');
        end if;
        :new.carga_horaria_ant := :old.carga_horaria;
    end;
