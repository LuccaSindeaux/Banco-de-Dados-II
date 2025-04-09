--Uso do HAVING, quando queremos fazer uma qualificação pós SELECT
select categoria, sum(preco) from produto
    group by categoria
    having sum(preco) > 2


select categoria, sum(preco) from produto
    group by categoria
    having sum(preco) = 
   
     (select max(maior) from
        (select categoria, sum(preco) as maior from produto
        group by categoria))
