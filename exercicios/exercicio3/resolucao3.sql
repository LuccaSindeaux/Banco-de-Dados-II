--1– Criar uma procedure Aumenta_Produto: Esta procedure recebe como parâmetro o percentual de aumento dos produtos. Essa procedure deve atualizar os preços dos produtos no percentual informado
create or replace procedure aumenta_produto (percentual IN float) --> Estou falando que o valor é um decimal que possui 5 inteiros com duas caasas deciemais.
    IS
    BEGIN
        update Xproduto set preco = (preco * percentual)/100 + preco; --> o aumento percentual + o próprio preço
    END;
--2 – Criar a função percdesconto, que recebe como parâmetro o código do cliente e deve retornar o percentual de desconto conforme a tabela abaixo:
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

--3 – Criar uma procedure media_vendas: Esta procedure recebe como parâmetro o código do cliente e deve retornar o valor médio das vendas do cliente 
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


