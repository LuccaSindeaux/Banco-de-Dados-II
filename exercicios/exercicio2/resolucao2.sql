--1 – Selecionar o nome do cliente e quantidade de produtos comprados, somente para clientes que compraram Coca Cola.
desc Xcliente --descreve todas as características da tabela
desc xitensvenda
select c.cliente, iv.qtde from xcliente c, xitensvenda iv, xvenda v 
    where c.codcliente = v.codcliente --código do cliente é domínio comum entre cliente e venda 
        and v.nnf = iv.nnf --primeira parte da PK composta das tabelas venda e itensvenda
        and v.dtvenda = iv.dtvenda --segunda parte da PK composta das tabelas venda e itensvenda
        and iv.codproduto = 1 --qualificador da busca (define coca cola) e última PK da tabela itensvenda

--2 – Selecionar o nome do cliente e o valor total comprado por ele. 
desc xvenda
select c.cliente, sum(v.vlvenda) from xcliente c, xvenda v where c.codcliente = v.codcliente group by c.cliente order by c.cliente asc--domínio comum
select 8.5 + 7.9 from dual

--3 – Selecionar a descrição e o maior preço de produto vendido.  ORDEM NÃO É A MESMA QUE A DO GABARITO, MAS OS DADOS SÃO
desc Xproduto
desc xvenda
desc xitensvenda
select p.descricaoproduto, MAX(p.preco) from xproduto p, xvenda v, xitensvenda iv 
    where iv.nnf = v.nnf
    and iv.dtvenda = v.dtvenda
    and iv.codproduto = p.codproduto
    group by p.descricaoproduto order by  p.descricaoproduto asc, max(p.preco) desc

--4 – Selecionar o nome do cliente e descrição do tipo de pagamento utilizado nas vendas. 
desc xtipospagamento
select c.cliente, tp.descricaotppagamento from xcliente c, xtipospagamento tp, xvenda v 
    where v.codtppagamento = tp.codtppagamento
    and v.codcliente = c.codcliente 

--5 – Selecionar o nome do cliente, nnf, data da venda, descrição do tipo de pagamento, descrição do produto e quantidade vendida dos itens vendidos. 
desc xvenda
select c.cliente, v.nnf, v.dtvenda, tp.descricaotppagamento, p.descricaoproduto, iv.qtde 
    from xcliente c, xvenda v, xtipospagamento tp, xproduto p, xitensvenda iv --número de tables - 1 == quantidade de join (4 neste caso)
    where c.codcliente = v.codcliente 
    and tp.codtppagamento = v.codtppagamento
    and v.nnf = iv.nnf
    and iv.codproduto = p.codproduto --tabela está vindo com mais linhas do que a do gabarito
    and iv.dtvenda = v.dtvenda
        order by v.dtvenda asc, c.cliente, p.descricaoproduto asc

--6 – Selecionar a média de preço dos produtos vendidos. 
select avg(p.preco) from xproduto p

--7 – Selecionar o nome do cliente e a descrição dos produtos comprados por ele. Não repetir os dados (distinct) ORDEM NÃO É A MESMA QUE A DO GABARITO, MAS OS DADOS SÃO
desc xvenda
desc xitensvenda
select distinct c.cliente, p.descricaoproduto from xcliente c, xproduto p, xitensvenda iv, xvenda v 
    where c.codcliente = v.codcliente
    and iv.nnf = v.nnf
    and iv.dtvenda = v.dtvenda
    and iv.codproduto = p.codproduto
        order by c.cliente asc, p.descricaoproduto desc

--8 – Selecionar a descrição do tipo de pagamento, e a maior data de venda que utilizou esse tipo de pagamento. Ordenar a consulta pela descrição do tipo de pagamento.
desc Xtipospagamento
desc xvenda
select tp.descricaotppagamento, MAX(v.dtvenda) from Xtipospagamento tp, xvenda v, xitensvenda iv
    where iv.dtvenda = v.dtvenda
    and iv.nnf = v.nnf
    and v.codtppagamento = tp.codtppagamento --domínio comum 
    group by tp.descricaotppagamento
        order by tp.descricaotppagamento asc

--9 – Selecionar a data da venda e a média da quantidade de produtos vendidos. Ordenar pela data da venda decrescente
select v.dtvenda, AVG(iv.qtde) from Xvenda v, xitensvenda iv 
    where v.nnf = iv.nnf --parte 1 da pk composta -> domínio comum 
    and v.dtvenda = iv.dtvenda  --parte 2 da pk composta -> domínio comum 
        group by v.dtvenda
        order by v.dtvenda desc

--10 – Selecionar a descrição do produto e a média de quantidades vendidas do produto. Somente se a média for superior a 4
desc xitensvenda
desc xproduto
select p.descricaoproduto, 
       (select AVG(iv.qtde) 
        from xitensvenda iv 
        where iv.codproduto = p.codproduto)
from xproduto p
     where (select AVG(iv.qtde) 
        from xitensvenda iv 
        where iv.codproduto = p.codproduto) > 4


