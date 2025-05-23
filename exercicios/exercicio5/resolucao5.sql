-- 1 – Criar tabela de acumpagamento com a seguinte estrutura: 
-- codtppagamento int not null  
-- mes            int not null 
-- ano            int not null 
-- valor        float not null 
-- pk – codtppagamento, mes, ano 

-- Criar trigger’s de insert, update e delete da tabela de Xvenda com a finalidade de armazenar o valor 
-- de venda para cada tipo de pagamento, mês e ano na tabela de acumpagamento.  
create table acumpagamento

-- 2 – Criar tabela de acumproduto com a seguinte estrutura: 
-- codproduto int not null  
-- qtde       int not null  
-- pk - codproduto 
-- Criar trigger’s de insert, update e delete da tabela de Xitensvenda, com a finalidade de inserir na 
-- tabela de acumproduto.  
-- 1) Ao inserir na tabela de Xitensvenda, caso exista o produto na tabela de acumproduto atualizar a coluna qtde; 
-- 2) Ao atualizar a coluna qtde na tabela de Xitensvenda atualizar a tabela de acumproduto; 
-- 3) Ao deletar da tabela de Xitensvenda diminuir da coluna qtde da tabela acumproduto. 


-- 3 – Executar o comando abaixo para criar uma nova coluna na tabela de Xcliente 
-- alter table Xcliente add sitcliente varchar2(1) null; 

-- Criar uma procedure atualiza_sitcliente: 
-- Esta procedure recebe como parâmetro uma data e tem como finalidade atualizar a coluna sitcliente 
-- para “I” (Inativo) para todos os clientes que não compram a partir da data informada. 

-- Criar a trigger de insert da tabela de Xvenda, com a finalidade de atualizar a coluna sitcliente = “A” 
-- (Ativo) a partir das compras dos clientes. 


-- 4 – Criar tabela de acumproduto2 com a seguinte estrutura: 
-- unidade char(2) not null  
-- qtde        int not null 
-- pk – unidade 

-- Criar trigger’s de insert, update e delete da tabela de Xproduto com a finalidade de armazenar a 
-- quantidade de produtos de cada unidade na tabela de acumproduto2. 