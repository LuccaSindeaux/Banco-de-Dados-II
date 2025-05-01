--1 Criar uma procedure Aumenta_Produto: Esta procedure recebe como parâmetro o percentual de aumento dos produtos. Essa procedure deve atualizar os preços dos produtos no percentual informado
create or replace procedure aumenta_produto (percentual IN float) --> Estou falando que o valor é um decimal que possui 5 inteiros com duas caasas deciemais.
    IS
    BEGIN
        update Xproduto set preco = (preco * percentual)/100 + preco; --> o aumento percentual + o próprio preço
    END;
--2 Criar a função percdesconto, que recebe como parâmetro o código do cliente e deve retornar o percentual de desconto conforme a tabela abaixo:
--      Qtd de Itens Comprados  % Desconto
--                        = 1   5
--                 > 1 e <= 9   7.5
--                      >= 10   12.5
create or replace procedure percdesconto(pCodCli IN number, pDesconto OUT float)
    is 
    totalItens number := 0;
    begin
        -- codar as regras para ofercer o desconto
        -- Calcular a quantidade de itens do cliente
        select count(*) INTO totalItens from xvenda a, xitensvenda b --> O comando INTO indica que minha query tem um DESTINO, uma variável (totalItens); pois dentro da procedure o programa não sabe o que fazer com o resultset de uma query
            where a.nnf = b.nnf and a.dtvenda = b.dtvenda
            and codcliente = pCodCli; --> a join é feita onde p codcliente de Xvenda é o MESMO do código declarado no meu parâmetro (pCodCi)
        -- Testar o desconto a ser aplicado
        if totalItens = 1 then
            pDesconto := 5; --> jogando valores para o parâmetro de acordo com as condições (quantiodade de itens para o desconto)
        elsif totalItens > 1 and totalItens <= 9 then
            pDesconto := 7.5;
        elsif totalItens >= 10 then 
            pDesconto := 12.5;
        end if;
    end;

--3 Criar uma procedure media_vendas: Esta procedure recebe como parâmetro o código do cliente e deve retornar o valor médio das vendas do cliente 
--e a quantidade de vendas do cliente. 
create or replace procedure media_vendas(mCodCli IN NUMBER, valorMedia OUT FLOAT, quantiVenda OUT NUMBER)
    is
    totalValor FLOAT; --> Variável totalValor será um Float
    begin
    --pegar o código do cliente 
    select avg(v.vlvenda), sum(iv.qtde) INTO totalValor, quantiVenda from xvenda v, xitensvenda iv
        where codcliente = mCodCli  --> "jogo" o valor da média de vlvenda para totalValor e a soma de quantifade de produtos para quantiVenda
        and v.nnf = iv.nnf 
        and v.dtvenda = iv.dtvenda;
    -- Condicional
        if quantiVenda > 0 then --> Para que o cálculo de média seja feito a quantiVenda tem de ser maior que 0
            valorMedia := totalValor / quantiVenda; --> valorMedia, que celarei na minha função, recebrá o resultado de totalValor dividido por quantiVenda.
        else
            valorMedia := 0;
        end if;
    end;
-- Teste da questão 3
declare
    media float;
    totalItens number;
begin
    media_vendas(1, media, totalItens); --> usando minha função, usei o codcliente 1 eas variáveis de declare
    dbms_output.put_line('Valor médio: ' || media);
    dbms_output.put_line('Total de itens: ' || totalItens);
end;


--4 Criar uma procedure media_produto: Esta procedure recebe como parâmetro duas datas, uma de início e uma de fim e deve retornar o valor 
-- médio dos produtos vendidos no período e a soma das quantidades de produto vendido no período.
create or replace procedure media_produto(beginDate IN DATE, finalDate IN DATE, mediaVenda OUT FLOAT, sumVenda OUT NUMBER)
    is
    begin
        select avg(v.vlvenda), sum(iv.qtde) INTO mediaVenda, sumVenda from xvenda v, xitensvenda iv
            where v.dtvenda = iv.dtvenda
            and v.nnf = iv.nnf;
        
    end


--5 Criar uma procedure max_vltipopagto: Esta procedure recebe como parâmetro a descrição do tipo de pagamento e retorna o maior valor
--vendido para o tipo de pagamento informado no parâmetro.
CREATE OR REPLACE PROCEDURE max_vltipopagto (
    descPag IN VARCHAR2,
    maiorValor OUT FLOAT
)
    IS
    codPagamento NUMBER;
    BEGIN
        SELECT codtppagamento INTO codPagamento
        FROM Xtipospagamento
        WHERE UPPER(descricaotppagamento) = UPPER(descPag);

        SELECT MAX(vlvenda) INTO maiorValor
        FROM Xvenda
        WHERE codtppagamento = codPagamento;
    END;
    --testei
    DECLARE
    v_maior FLOAT;
    BEGIN
        max_vltipopagto('Dinheiro', v_maior);
        DBMS_OUTPUT.PUT_LINE('Maior venda com Dinheiro: ' || v_maior);
    END;


-- 6 Criar a função retorna_mediageral que retorna a média geral das vendas. 
create or replace function retorna_mediageral
    return float is
    v_media FLOAT;
    begin
        select avg(v.vlvenda) 
        into v_media 
        from xvenda v;
        return (v_media);
    end;

select retorna_mediageral from dual 

-- 7 Criar a função retorna_novo_preco, que recebe como parâmetro a descrição do produto e mediante a quantidade vendida retorna o novo preço do produto, conforme a tabela abaixo:

--Qtd vendida        % Aumento 
-- 1                    5
-- 2                    7
-- 3                    8
-- 4                    9
-- 5 ou mais            12

create or replace function retorna_novo_preco(
    descricaoproduto IN STRING,
    qtde_vendida IN NUMBER 
) RETURN FLOAT
    is
    precoAtual FLOAT;
    precoNovo FLOAT;
    begin
        SELECT p.preco into precoAtual 
            from xproduto p
            where p.descricaoproduto = descricaoproduto;
        if qtde_vendida = 1 then
            precoNovo := precoAtual * 1.05;
        elsif qtde_vendida = 2 then
            precoNovo := precoAtual * 1.07;
        elsif qtde_vendida = 3 then
            precoNovo := precoAtual * 1.08;
        elsif qtde_vendida = 4 then
            precoNovo := precoAtual * 1.09;
        elsif qtde_vendida >= 5 then
            precoNovo := precoAtual * 1.12;
        end if;
        return precoNovo;
    end;

--8 Criar a função retorna_valor_pagamento que recebe como parâmetro a descrição do tipo de pagamento 
--e retorna a quantidade de clientes que realizou venda com esse tipo de pagamento.
CREATE OR REPLACE FUNCTION retorna_valor_pagamento(
    descPag IN VARCHAR2)
    RETURN NUMBER
    IS
        qtdClientes NUMBER;
        CodPagamento NUMBER;
    BEGIN
        select tp.codtppagamento INTO CodPagamento from Xtipospagamento tp
        where descricaotppagamento = descPag;

        select COUNT(DISTINCT codcliente) INTO qtdClientes
        from Xvenda
        where codtppagamento = codPagamento;

        RETURN qtdClientes;
    END;

    -- testandpo
    SELECT retorna_valor_pagamento('Dinheiro') FROM dual;
-- 9 Criar a função retorna_ultimavenda que recebe como parâmetro a descrição do produto e retorna a última data que o produto foi vendido.
create or replace function retorna_ultimavenda( descProd IN VARCHAR2)
    RETURN DATE
    IS
        ultimaData DATE;
        codProd NUMBER;
    BEGIN
        select codproduto into codProd from xproduto
        where UPPER(descricaoproduto) = UPPER(descProd);

        select MAX(dtvenda) into ultimaData from xitensvenda
        where codproduto = codProd;

        return ultimaData;
    END;

    --testando
    SELECT retorna_ultimavenda('Sabonete Palmolive') FROM dual;

--10  Criar a função retorna_menorvenda que retorna o menor valor de venda realizada. 
create or replace function retorna_menorvenda
    return FLOAT 
    is
    menorValor FLOAT;
    begin
        select MIN(vlvenda) INTO menorValor from xvenda;

        return menorValor;
    end;
    -- testando
    SELECT retorna_menorvenda FROM dual;