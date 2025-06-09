-- 1b) Escrever procedimento para inserir registros na tabela ATENDENTE
-- -> Receber por parâmetro a quantidade de atendentes que deverão ser gerados - Fixar
-- que o atendente 1 é superior de todos os demais

-- DICAS para as questões a e b:
-- • As cidades deverão ser obtidas aleatoriamente de uma tabela CIDADE.
-- • Para compor o nome do hospede, montar aleatoriamente NOME + SOBRENOME,
-- buscando de duas tabelas as quais se tenham nomes e sobrenomes. 

-- Criação das tabelas com nomes e sobrenomes aleatórios, inserção dos dados logo em seguida
CREATE TABLE NOMES (
    id_nome INT PRIMARY KEY,
    nome VARCHAR2(50)
);

CREATE TABLE SOBRENOMES (
    id_sobrenome INT PRIMARY KEY,
    sobrenome VARCHAR2(50)
);

begin
    INSERT INTO NOMES (id_nome, nome) VALUES (1, 'Ana');
    INSERT INTO NOMES (id_nome, nome) VALUES (2, 'Bruno');
    INSERT INTO NOMES (id_nome, nome) VALUES (3, 'Carlos');
    INSERT INTO NOMES (id_nome, nome) VALUES (4, 'Daniela');
    INSERT INTO NOMES (id_nome, nome) VALUES (5, 'Eduardo');
    INSERT INTO NOMES (id_nome, nome) VALUES (6, 'Lisiane');
    INSERT INTO NOMES (id_nome, nome) VALUES (7, 'Butiá');
    INSERT INTO NOMES (id_nome, nome) VALUES (8, 'Lorenzo');
END;

begin
    INSERT INTO SOBRENOMES (id_sobrenome, sobrenome) VALUES (1, 'Silva');
    INSERT INTO SOBRENOMES (id_sobrenome, sobrenome) VALUES (2, 'Santos');
    INSERT INTO SOBRENOMES (id_sobrenome, sobrenome) VALUES (3, 'Oliveira');
    INSERT INTO SOBRENOMES (id_sobrenome, sobrenome) VALUES (4, 'Pereira');
    INSERT INTO SOBRENOMES (id_sobrenome, sobrenome) VALUES (5, 'Costa');
    INSERT INTO SOBRENOMES (id_sobrenome, sobrenome) VALUES (6, 'Hoffmeister');
    INSERT INTO SOBRENOMES (id_sobrenome, sobrenome) VALUES (7, 'Raguse');
    INSERT INTO SOBRENOMES (id_sobrenome, sobrenome) VALUES (8, 'Pandolfo');
END;

-- Mesma lógica, mas com cidades
CREATE TABLE CIDADE (
    id_cidade INT PRIMARY KEY,
    nome_cidade VARCHAR2(100)
);

-- Inserindo algumas cidades de exemplo
begin
    INSERT INTO CIDADE (id_cidade, nome_cidade) VALUES (1, 'Porto Alegre');
    INSERT INTO CIDADE (id_cidade, nome_cidade) VALUES (2, 'Canoas');
    INSERT INTO CIDADE (id_cidade, nome_cidade) VALUES (3, 'Viamão');
end;


begin
    INSERT INTO NOMES (id_nome, nome) VALUES (1, 'Lucca');
    INSERT INTO NOMES (id_nome, nome) VALUES (2, 'Lisiane');
    INSERT INTO NOMES (id_nome, nome) VALUES (3, 'Butiá');
    INSERT INTO NOMES (id_nome, nome) VALUES (4, 'Gustavo');
    INSERT INTO NOMES (id_nome, nome) VALUES (5, 'Lorenzo');
    INSERT INTO NOMES (id_nome, nome) VALUES (6, 'Murilo');
    INSERT INTO NOMES (id_nome, nome) VALUES (7, 'Yasmin');
    INSERT INTO NOMES (id_nome, nome) VALUES (8, 'Thiago');
    INSERT INTO NOMES (id_nome, nome) VALUES (9, 'Vitor');
    INSERT INTO NOMES (id_nome, nome) VALUES (10, 'Rafael');
    INSERT INTO NOMES (id_nome, nome) VALUES (11, 'Yanni');
    INSERT INTO NOMES (id_nome, nome) VALUES (12, 'Wylliam');
    INSERT INTO NOMES (id_nome, nome) VALUES (13, 'Nico');
    INSERT INTO NOMES (id_nome, nome) VALUES (14, 'Davi');
    INSERT INTO NOMES (id_nome, nome) VALUES (15, 'Robierto');
END;

begin
    INSERT INTO SOBRENOMES (id_sobrenome, sobrenome) VALUES (1, 'Mota');
    INSERT INTO SOBRENOMES (id_sobrenome, sobrenome) VALUES (2, 'Hoffmeister');
    INSERT INTO SOBRENOMES (id_sobrenome, sobrenome) VALUES (3, 'Raguse');
    INSERT INTO SOBRENOMES (id_sobrenome, sobrenome) VALUES (4, 'Muller');
    INSERT INTO SOBRENOMES (id_sobrenome, sobrenome) VALUES (5, 'Pandolfo');
    INSERT INTO SOBRENOMES (id_sobrenome, sobrenome) VALUES (6, 'Sena');
    INSERT INTO SOBRENOMES (id_sobrenome, sobrenome) VALUES (7, 'Secondshirt');
    INSERT INTO SOBRENOMES (id_sobrenome, sobrenome) VALUES (8, 'Kernel');
    INSERT INTO SOBRENOMES (id_sobrenome, sobrenome) VALUES (9, 'Baldi');
    INSERT INTO SOBRENOMES (id_sobrenome, sobrenome) VALUES (10, 'Rafaellos');
    INSERT INTO SOBRENOMES (id_sobrenome, sobrenome) VALUES (11, 'Dufech');
    INSERT INTO SOBRENOMES (id_sobrenome, sobrenome) VALUES (12, 'Mestre');
    INSERT INTO SOBRENOMES (id_sobrenome, sobrenome) VALUES (13, 'Shadow');
    INSERT INTO SOBRENOMES (id_sobrenome, sobrenome) VALUES (14, 'Rubim');
    INSERT INTO SOBRENOMES (id_sobrenome, sobrenome) VALUES (15, 'Camilo');
END;

-- Mesma lógica, mas com cidades
CREATE TABLE CIDADE (
    id_cidade INT PRIMARY KEY,
    nome_cidade VARCHAR2(100)
);

begin
    INSERT INTO CIDADE (id_cidade, nome_cidade) VALUES (1, 'Porto Alegre');
    INSERT INTO CIDADE (id_cidade, nome_cidade) VALUES (2, 'Canoas');
    INSERT INTO CIDADE (id_cidade, nome_cidade) VALUES (3, 'Viamão');
end;


CREATE OR REPLACE PROCEDURE PRC_INSERE_ATENDENTES (
    p_quantidade IN NUMBER
) as
    v_nome_aleatorio VARCHAR2(50);
    v_sobrenome_aleatorio VARCHAR2(50);
    v_nome_completo VARCHAR2(100);
    v_cod_superior_geral ATENDENTE.codAtendente%TYPE;
begin
    SELECT nome into v_nome_aleatorio FROM (SELECT nome FROM NOMES ORDER BY DBMS_RANDOM.VALUE) WHERE ROWNUM = 1;
    SELECT sobrenome into v_sobrenome_aleatorio FROM (SELECT sobrenome FROM SOBRENOMES ORDER BY DBMS_RANDOM.VALUE) WHERE ROWNUM = 1;
    v_nome_completo := v_nome_aleatorio || ' ' || v_sobrenome_aleatorio;

    -- Pega o próximo ID da sequence e armazena na variável.
    SELECT sequencia.NEXTVAL INTO v_cod_superior_geral FROM DUAL;

    -- Insere o superior geral, informando explicitamente o seu codAtendente e codSuperior com o mesmo valor.
    INSERT INTO ATENDENTE (codAtendente, codSuperior, nome)
    VALUES (v_cod_superior_geral, v_cod_superior_geral, v_nome_completo);

    FOR i in 2..p_quantidade LOOP
        SELECT nome into v_nome_aleatorio FROM (SELECT nome FROM NOMES ORDER BY DBMS_RANDOM.VALUE) WHERE ROWNUM = 1;
        SELECT sobrenome into v_sobrenome_aleatorio FROM (SELECT sobrenome FROM SOBRENOMES ORDER BY DBMS_RANDOM.VALUE) WHERE ROWNUM = 1;
        v_nome_completo := v_nome_aleatorio || ' ' || v_sobrenome_aleatorio;

        INSERT into ATENDENTE (codSuperior, nome)
        VALUES (v_cod_superior_geral, v_nome_completo);
    END LOOP;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE(p_quantidade || ' atendentes inseridos com sucesso.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Erro ao inserir atendentes: ' || SQLERRM);
END PRC_INSERE_ATENDENTES;

begin
    PRC_INSERE_ATENDENTES(15);
END;

SELECT * from atendente