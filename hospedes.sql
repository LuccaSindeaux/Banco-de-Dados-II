-- 1a) Escrever um procedimento para inserir registros na tabela de HÓSPEDES - Esse
-- procedimento deve receber por parâmetro a quantidade de hóspedes que deverão ser inseridos
-- e dois outros parâmetros indicando a idade mínima e máxima de cada hóspede. - A idade
-- mínima deverá ser menor que a máxima. Sendo que a idade mínima deverá ser superior a 18
-- e a máxima inferior a 65; 

CREATE OR REPLACE PROCEDURE P_INSERT_HOSPEDES (
    qtd_hospedes    IN INT,
    idade_min       IN INT,
    idade_max       IN INT
) AS
    v_nome              VARCHAR2( 50 );
    v_cidade            VARCHAR2( 50 );
    v_dataNascimento    DATE;
BEGIN
    -- Validação de faixa de idade
    IF idade_min < 18 OR idade_max > 65 OR idade_min >= idade_max THEN
        RAISE_APPLICATION_ERROR( -20001, 'Idades inválidas. Mínima é a partir de 18 anos, máxima é de 65 anos para reservas.' );
    END IF;

    -- Dados na variavel
    v_nomes( 'Ana', 'Carlos', 'Beatriz', 'Marcos', 'Lisiane', 'Pedro', 'Camila', 'Lucca', 'Juliana', 'Rafael', 'Fernanda', 'Gabriel' );
    v__sobrenomes( 'Silva', 'Oliveira', 'Hoffmeister', 'Pereira', 'Ferreira', 'Almeida', 'Sindeaux', 'Gomes', 'Ribeiro', 'Martins', 'Barbosa' );
    v_cidades( 'Porto Alegre', 'Canoas', 'Gravataí', 'Sapucaia', 'Novo Hamburgo', 'Gramado', 'Canela', 'Rolante', 'Dois Irmãos', 'Ivoti' );
    v_datasNascimentos( '01/01/2000', '02/02/2002', '03/03/2003', '04/04/2004', '05/05/2005', '06/06/2006', '07/07/2007', '08/08/2008', '09/09/1999', '10/10/1990', '11/11/1980', '12/12/1970' );

    FOR i IN 1..qtd_hospedes LOOP
        nome_random := v_nomes( TRUNC( DBMS_RANDOM.VALUE( 1, v_nomes.COUNT + 1) ) ) || ' ' || v__sobrenomes( TRUNC( DBMS_RANDOM.VALUE( 1, v__sobrenomes.COUNT + 1) ) );
        cidade_random := v_cidades( TRUNC( DBMS_RANDOM.VALUE( 1, v_cidades.COUNT + 1) ) );
        dataNascimento_random := v_datasNascimentos( TRUNC( DBMS_RANDOM.VALUE( 1, v_datasNascimentos.COUNT + 1) ) );

        -- Inserindo na tabela
        INSERT INTO HOSPEDE ( nome, cidade, dataNascimento )
        VALUES ( nome_random, cidade_random, dataNascimento_random );
    END LOOP;


END;

-- FUNCIONAL
BEGIN
    P_INSERT_HOSPEDES( 1, 18, 65 );
END;