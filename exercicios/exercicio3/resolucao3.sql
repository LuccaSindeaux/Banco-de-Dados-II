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

