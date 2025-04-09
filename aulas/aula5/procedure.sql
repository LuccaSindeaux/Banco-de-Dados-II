--EXEMPLO:
create or replace procedure formata_nomes (prim_nome IN OUT --> Tenho que falar que o dado está entrando (IN), se peço algo para sair (OUT); ou ambos para economizar tempo (IN OUT)
VARCHAR2, ult_nome IN OUT VARCHAR2, nome_comp OUT VARCHAR2, --> O dado que stou pedindo tem de ser definido, no caso prim_nome e ult_nome são strings, portanto tenho de sinalizar que é um VARCHAR
formato IN VARCHAR2 := 'ULTIMO PRIMEIRO') --> := é a definição do valor default, mas o operador := significa a ATRIBUIÇÃO de um valor.
-- O parâmetro formato não precisa obrigatoriamente ser informado
    IS
    BEGIN --> TENHO que indicar o início do bloco
     IF formato = 'ULTIMO PRIMEIRO' THEN
        nome_comp := ult_nome || ',' || prim_nome; --> Barras paralelas são concatenações, estou falando que os valores evem ser separados por vírgula ",". 
     ELSIF formato = 'PRIMEIRO ULTIMO' THEN
        nome_comp := prim_nome ||' '|| ult_nome; --> Estou atribuindo ao meu parâmetro OUT (nome_comp) o primeiro nome [espaço] último nome, que são meus parâmetros IN OUT. E isto ocorrerá SOMENTE se a primeira condição não for satisfeita
     END IF; --> TENHO que indicar o fim da condicional
    END; --> TENHO que indicar o fim do bloco

-- Declarando variáveis
declare prim_nome varchar2(20); --> declare é o comando que declarava uma ou várias variáveis
        ult_nome varchar2(20);
        nome_comp varchar2(20);
    begin
        prim_nome := 'Rafael';
        ult_nome := 'Gastão';
        formata_nomes (prim_nome, ult_nome, nome_comp, 'ULTIMO PRIMEIRO');
        DBMS_OUTPUT.put_line (prim_nome||' '|| ult_nome||' '||nome_comp); --> DBMS_OUTPUT é o "print()" do Pyhton
    end;
