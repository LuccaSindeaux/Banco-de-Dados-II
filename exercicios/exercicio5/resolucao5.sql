-- 1 – Criar tabela de acumpagamento com a seguinte estrutura: 
-- codtppagamento int not null  
-- mes            int not null 
-- ano            int not null 
-- valor        float not null 
-- pk – codtppagamento, mes, ano 

-- Criar trigger’s de insert, update e delete da tabela de Xvenda com a finalidade de armazenar o valor de venda para cada tipo de pagamento, mês e ano na tabela de acumpagamento.  
create table acumpagamento(
    codtppagamento int not null,
    mes int not null,
    ano int not null,
    valor float not null,
    CONSTRAINT pk_acumpagamento PRIMARY KEY (codtppagamento, mes, ano)
)

create or replace trigger inserir_data_pagamento
before INSERT or DELETE or UPDATE on Xvenda
for each row
    declare
        v_mes INT; 
        v_ano INT;
        v_exists INT;
    begin
        if INSERTING then
            v_mes := EXTRACT(MONTH FROM :NEW.dtvenda);
            v_ano := EXTRACT(YEAR FROM :NEW.dtvenda);

            select COUNT(*) into v_exists
            from acumpagamento
            where codtppagamento = :NEW.codtppagamento
              and mes = v_mes
              and ano = v_ano;

            IF v_exists > 0 then
                UPDATE acumpagamento
                set valor = valor + :NEW.vlvenda
                where codtppagamento = :NEW.codtppagamento
                  and mes = v_mes
                  and ano = v_ano;
            ELSE
                INSERT into acumpagamento (codtppagamento, mes, ano, valor)
                values (:NEW.codtppagamento, v_mes, v_ano, :NEW.vlvenda);
            END if;

        elsif UPDATING then
            v_mes := EXTRACT(MONTH FROM :OLD.dtvenda);
            v_ano := EXTRACT(YEAR FROM :OLD.dtvenda);
            
            UPDATE acumpagamento set valor = valor - :OLD.vlvenda
            where codtppagamento = :OLD.codtppagamento
                and mes = v_mes
                and ano = v_ano;

            v_mes := EXTRACT(MONTH FROM :NEW.dtvenda);
            v_ano := EXTRACT(YEAR FROM :NEW.dtvenda);

            select COUNT(*) into v_exists
            from acumpagamento
            where codtppagamento = :NEW.codtppagamento
              and mes = v_mes
              and ano = v_ano;

            IF v_exists > 0 THEN
                UPDATE acumpagamento
                SET valor = valor + :NEW.vlvenda
                WHERE codtppagamento = :NEW.codtppagamento
                  AND mes = v_mes
                  AND ano = v_ano;
            ELSE
                INSERT INTO acumpagamento (codtppagamento, mes, ano, valor)
                VALUES (:NEW.codtppagamento, v_mes, v_ano, :NEW.vlvenda);
            END IF;

        elsif DELETING then
            v_mes := EXTRACT(MONTH FROM :OLD.dtvenda);
            v_ano := EXTRACT(YEAR FROM :OLD.dtvenda);

            UPDATE acumpagamento
            set valor = valor - :OLD.vlvenda
            where codtppagamento = :OLD.codtppagamento
                and mes = v_mes
                and ano = v_ano;
        
        END if;
    end;

-- 2 – Criar tabela de acumproduto com a seguinte estrutura: 
-- codproduto int not null  
-- qtde       int not null  
-- pk - codproduto 
-- Criar trigger’s de insert, update e delete da tabela de Xitensvenda, com a finalidade de inserir na 
-- tabela de acumproduto.  
-- 1) Ao inserir na tabela de Xitensvenda, caso exista o produto na tabela de acumproduto atualizar a coluna qtde; 
-- 2) Ao atualizar a coluna qtde na tabela de Xitensvenda atualizar a tabela de acumproduto; 
-- 3) Ao deletar da tabela de Xitensvenda diminuir da coluna qtde da tabela acumproduto. 

create table acumproduto(
    codproduto int not null,
    qtde int not null,
    PRIMARY KEY(codproduto)
)

create or replace trigger inserindo_acumproduto
after INSERT or DELETE or UPDATE on Xitensvenda
    for each row
    declare
        valor_existente NUMBER; 
    begin
        if INSERTING then
             select COUNT(*) into valor_existente from acumproduto where codproduto = :NEW.codproduto;
             if valor_existente > 0 then
                UPDATE acumproduto
                SET qtde = qtde + :NEW.qtde
                WHERE codproduto = :NEW.codproduto;
             else
                INSERT into acumproduto (codproduto, qtde)
                values (:NEW.codproduto, :NEW.qtde);
            END if;

        elsif UPDATING then
            UPDATE acumproduto
            set qtde = qtde - :OLD.qtde + :NEW.qtde
            where codproduto = :NEW.codproduto;

        elsif DELETING then
            UPDATE acumproduto
            set qtde = qtde - :OLD.qtde
            where codproduto = :OLD.codproduto;
        END IF;
    end;


-- 3 – Executar o comando abaixo para criar uma nova coluna na tabela de Xcliente 
-- alter table Xcliente add sitcliente varchar2(1) null; 

-- Criar uma procedure atualiza_sitcliente: 
-- Esta procedure recebe como parâmetro uma data e tem como finalidade atualizar a coluna sitcliente 
-- para “I” (Inativo) para todos os clientes que não compram a partir da data informada. 

-- Criar a trigger de insert da tabela de Xvenda, com a finalidade de atualizar a coluna sitcliente = “A” 
-- (Ativo) a partir das compras dos clientes. 
alter table Xcliente add sitcliente varchar2(1) null;

create or replace procedure atualiza_sitcliente( data_param IN DATE)
    IS
    begin
        UPDATE Xcliente set sitcliente = 'I'
        where codcliente NOT in (
            select distinct codcliente from Xvenda
            where dtvenda >= data_param
        );
    end;

create or replace trigger trigger_ativa_cliente
after INSERT on Xvenda
    for each row
        begin
            UPDATE Xcliente set sitcliente = 'A'
            where codcliente = :NEW.codcliente;
        end;

-- testes
BEGIN
  atualiza_sitcliente(TO_DATE('01-05-2002', 'DD-MM-YYYY'));
END;

INSERT INTO Xvenda (nnf, dtvenda, codcliente, codtppagamento, vlvenda)
VALUES (2, TO_DATE('21-05-2002', 'DD-MM-YYYY'), 2, 2, 50.00);


-- 4 – Criar tabela de acumproduto2 com a seguinte estrutura: 
-- unidade char(2) not null  
-- qtde        int not null 
-- pk – unidade 

-- Criar trigger’s de insert, update e delete da tabela de Xproduto com a finalidade de armazenar a 
-- quantidade de produtos de cada unidade na tabela de acumproduto2. 

create table acumproduto2(
    unidade char(2) not null,
    qtde int not null,
    PRIMARY KEY(unidade)
)

create or replace trigger armazena_acumproduto2
AFTER INSERT or DELETE or UPDATE on Xproduto
    for each row
    declare
        unidade_prod NUMBER;
    begin
        if INSERTING then
             select COUNT(*) into unidade_prod FROM acumproduto2
                where unidade = :NEW.unidade;
                if unidade_prod > 0 then --Se a unidade já existe → soma 1... 
                    UPDATE acumproduto2
                    set qtde = qtde + 1
                    where unidade = :NEW.unidade; -- O :NEW.unidade é do Xproduto, o primeiro unidade é da tabela acumproduto2
                else -- ...Senão insere com 1
                    INSERT into acumproduto2(unidade, qtde)
                    values (:NEW.unidade, 1);
                end if;

        elsif UPDATING then
            UPDATE acumproduto2
            set qtde = qtde - 1 -- Subtrai 1 da unidade antiga... 
            where unidade = :OLD.unidade;

            select COUNT(*) into unidade_prod FROM acumproduto2
                where unidade = :NEW.unidade;

            if unidade_prod > 0 then
                UPDATE acumproduto2
                set qtde = qtde + 1 -- ...E soma 1 na nova
                where unidade = :NEW.unidade;
            else
                INSERT into acumproduto2(unidade, qtde)    
                values (:NEW.unidade, 1);
            end if;

        elsif DELETING then
            UPDATE acumproduto2 
            set qtde = qtde - 1 -- subtrai 1 da unidade
            where unidade = :OLD.unidade;
        end if;
    end;