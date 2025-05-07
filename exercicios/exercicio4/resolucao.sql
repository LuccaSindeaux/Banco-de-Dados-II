-- 1 – Criar uma tabela de acumproduto com a seguinte estrutura 
-- codproduto         int         not null 
-- descricaoproduto   varchar(50) not null 
-- qtde               float       not null 
-- pk – codproduto           
-- Criar um cursor com o código do produto, descrição do produto e quantidade de produto vendido 
-- (coluna qtde da tabela xitensvenda). Inserir na tabela de acumproduto.

create global temporary table acumproduto(
    codproduto int not null PRIMARY KEY,
    descricaoproduto varchar(50) not null,
    qtde float not null
)

CREATE OR REPLACE PROCEDURE gerar_acumproduto IS
    CURSOR cursor_acumproduto IS
        SELECT p.codproduto, p.descricaoproduto, SUM(iv.qtde) AS quantidade_total
        FROM xproduto p, xitensvenda iv
        WHERE p.codproduto = iv.codproduto
        GROUP BY p.codproduto, p.descricaoproduto;
BEGIN
    DELETE FROM acumproduto;

    FOR rec IN cursor_acumproduto LOOP
        INSERT INTO acumproduto (codproduto, descricaoproduto, qtde)
        VALUES (rec.codproduto, rec.descricaoproduto, rec.quantidade_total);
    END LOOP;
END;


begin
    gerar_acumproduto;
end;

-- 2 – Criar uma tabela de produto_novo com a seguinte estrutura 
-- descricaoproduto   varchar(50)  not null
-- preco              float        not null 
-- preco_aumento      float        not null 
-- pk – descricaoproduto 

-- Criar um cursor para inserir o nome e preço do produto. Caso o preço do produto seja inferior a R$ 
-- 2,00, inserir na tabela produto_novo o nome do produto, preço atual e preço com 10% de aumento. Se 
-- o preço do produto for superior a R$ 2,00 aumentar o preço do produto para 15% na tabela de 
-- produto.

create or replace procedure

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

create or replace procedure