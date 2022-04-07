-- challenge 1
-- stp1

select 
	titles.title_id,
    authors.au_id,
    titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100 as sales_royalty

from authors

left join titleauthor 
on authors.au_id = titleauthor.au_id

left join titles     
on titleauthor.title_id = titles.title_id

left join sales
on titles.title_id = sales.title_id;


-- stp2
select 
	titles.title_id,
    authors.au_id,
    sum(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) as sales_royalty,
    advance


from authors

left join titleauthor 
on authors.au_id = titleauthor.au_id

left join titles     
on titleauthor.title_id = titles.title_id

left join sales
on titles.title_id = sales.title_id

group by authors.au_id, titles.title_id;

-- stp3


select
	b as "Author ID",
    sum(c + d) as profits

from (select 
	titles.title_id as a,
    authors.au_id as b,
    sum(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) as c,
    advance as d

from authors

left join titleauthor 
on authors.au_id = titleauthor.au_id

left join titles     
on titleauthor.title_id = titles.title_id

left join sales
on titles.title_id = sales.title_id

group by authors.au_id, titles.title_id) as tb1

group by b
order by profits desc
limit 3
;

-- challenge 2

CREATE TEMPORARY TABLE IF NOT EXISTS table2 AS
(select 
	titles.title_id as a,
    authors.au_id as b,
    sum(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) as c,
    advance as d

from authors

left join titleauthor 
on authors.au_id = titleauthor.au_id

left join titles     
on titleauthor.title_id = titles.title_id

left join sales
on titles.title_id = sales.title_id

group by authors.au_id, titles.title_id
);

select
	b as "Author ID",
    sum(c + d) as profits

from table2

group by b
order by profits desc
limit 3
;
-- chalenge 3
create table if not exists most_profiting_authorsba as
(
select
	b as "Author ID",
    sum(c + d) as profits

from table2

group by b
order by profits desc
);
select * 
from most_profiting_authorsba;


select * 
from titles;









    
    
    
    
