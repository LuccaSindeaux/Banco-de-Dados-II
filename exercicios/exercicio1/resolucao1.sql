-- 1) Mostre todos os dados de clientes  
SELECT * FROM cliente;

-- 2) Mostre todos os dados da tabela de movimento 
SELECT * FROM movimento;

-- 3) Mostre o nome de todos os produtos cadastrados 
SELECT nome FROM produto;

-- 4) Mostre o nome e cidade de todos os clientes 
SELECT cidade FROM cliente;

-- 5) Mostre o nome e cidade de clientes que possuem status bom 
SELECT nome, cidade FROM cliente WHERE status = 'bom';

-- 6) Mostre o nome e preço dos produtos com preço maior que R$1,00 e menor que R$ 2,00 da categoria Sabão 
SELECT nome, preco FROM produto WHERE preco >= 1.00 AND preco <= 2.00;

-- 7) Mostre os dados de todos os pedidos, do cliente C1, para pedidos realizados no período de 01/01/1997 a 31/12/1997.
SELECT * FROM pedido WHERE cod_cli = 'c1' AND data_elab BETWEEN '01/01/1997' AND '12/31/1997';
