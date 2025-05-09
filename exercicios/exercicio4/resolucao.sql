-- 1 – Criar uma tabela de acumproduto com a seguinte estrutura 
-- codproduto         int         not null 
-- descricaoproduto   varchar(50) not null 
-- qtde               float       not null 
-- pk – codproduto           
-- Criar um cursor com o código do produto, descrição do produto e quantidade de produto vendido 
-- (coluna qtde da tabela xitensvenda). Inserir na tabela de acumproduto.
create table acumproduto(
    codproduto int not null PRIMARY KEY,
    descricaoproduto varchar(50) not null,
    qtde float not null
)

create or repçace procedure gerar_acumproduto IS
    cursor cursor_acumproduto IS
        select p.codproduto, p.descricaoproduto, SUM(iv.qtde) AS quantidade_total
        from xproduto p, xitensvenda iv
        where p.codproduto = iv.codproduto
        group by p.codproduto, p.descricaoproduto
        order by p.codproduto;
begin
   delete from acumproduto;
    for rec in cursor_acumproduto loop
        insert into acumproduto (codproduto, descricaoproduto, qtde)
        values (rec.codproduto, rec.descricaoproduto, rec.quantidade_total);
    end loop;
end;

begin
    gerar_acumproduto;
end;

select * from acumproduto

-- 2 – Criar uma tabela de produto_novo com a seguinte estrutura 
-- descricaoproduto   varchar(50)  not null
-- preco              float        not null 
-- preco_aumento      float        not null 
-- pk – descricaoproduto 

-- Criar um cursor para inserir o nome e preço do produto. Caso o preço do produto seja inferior a R$ 
-- 2,00, inserir na tabela produto_novo o nome do produto, preço atual e preço com 10% de aumento. Se 
-- o preço do produto for superior a R$ 2,00 aumentar o preço do produto para 15% na tabela de 
-- produto.
create table produto_novo(
    descricaoproduto varchar(50) not null PRIMARY KEY,
    preco float not null,
    preco_aumento float not null
)


create or replace procedure alterar_preco_prod IS
    cursor cursor_alterar_preco IS
    select preco, descricaoproduto from xproduto;

    valor_novo FLOAT; 
    begin
        for valor in cursor_alterar_preco loop
            if valor.preco < 2.00 then
            valor_novo:= ROUND(valor.preco *1.10,2);
            else
            valor_novo := ROUND(valor.preco *1.15,2);
            end if;    
                insert into produto_novo (descricaoproduto, preco, preco_aumento)
                values (valor.descricaoproduto, valor.preco, valor_novo);
        end loop;
    end;
--delete from produto_novo
begin
    alterar_preco_prod;
end;

select * from produto_novo
-- 3 – Criar uma tabela de nova_venda com a seguinte estrutura 
-- nnf                 integer  not null
-- dtvenda             date     not null 
-- vlvenda             float    not null  
-- vlvenda_desconto    float    not null
-- pk - nnf, dtvenda 


-- Criar um cursor para selecionar o número da nota fiscal (nnf) da venda, a data e valor das vendas. 
-- Caso o valor da venda seja superior a R$ 10,00, inserir o número da nota fiscal (nnf) da venda, data, 
-- valor da venda e valor com 10% de desconto. Se o valor da venda for inferior a R$ 10,00 inserir todos 
-- os dados, mas com valor de desconto de 8% (inserir na tabela nova_venda).

create table nova_venda(
    nnf INTEGER not null,
    dtvenda DATE not null,
    vlvenda FLOAT not null,
    vlvenda_desconto FLOAT not null,
    PRIMARY KEY(nnf, dtvenda)
)

create or replace procedure procedure_desconto; IS
    cursor desconto_cursor IS
    select nnf, dtvenda, vlvenda from xvenda;
    valor_comdesconto FLOAT;
    begin
        for valor in desconto_cursor loop
            if valor.vlvenda > 10.00 then
                valor_comdesconto := ROUND(valor.vlvenda * 0.90,2);
            else
                valor_comdesconto := ROUND(valor.vlvenda *0.92,2);
            end if;
            insert into nova_venda(nnf, dtvenda, vlvenda, vlvenda_desconto)
                values(valor.nnf, valor.dtvenda, valor.vlvenda, valor_comdesconto);
        end loop;
    end;

begin
    procedure_desconto;
end;

select * from nova_venda;
  
 


   
   


