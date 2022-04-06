
-- Challenge 1



select a as Author_ID, b as Name, sum(sales_royalty + adv) as Profit

from 
(select t.title_id, t.title, a.au_id as a, a.au_fname as b,

sum(t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) as sales_royalty,
advance as adv

from titles as t

join titleauthor as ta
on t.title_id=ta.title_id

join authors as a
on ta.au_id=a.au_id

join sales as s
on t.title_id=s.title_id
group by t.title_id, a.au_id) as sr

group by a
order by profit desc
limit 3;




-- Challenge 2

-- Crear un tabla provisional(incomes)

create temporary table if not exists ingresos as  

(select t.title_id, t.title, a.au_id as a, a.au_fname as b,

sum(t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) as sales_royalty,
advance as adv

from titles as t

join titleauthor as ta
on t.title_id=ta.title_id

join authors as a
on ta.au_id=a.au_id

join sales as s
on t.title_id=s.title_id
group by t.title_id, a.au_id);

-- Llamo a la tabla temporal(incomes)

select a as Author_ID, b as Name, sum(sales_royalty + adv) as Profit

from incomes

group by a
order by profit desc
limit 3;


-- Challenge 3


create table if not exists most_profiting_authors as 

(select a as Author_ID, b as Name, sum(sales_royalty + adv) as Profit

from incomes

group by a
order by profit desc);


