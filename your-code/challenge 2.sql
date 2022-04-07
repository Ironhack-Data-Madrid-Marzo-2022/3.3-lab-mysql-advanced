create temporary table publications.royalty_by_author2
select authors.au_id as authorid,


sum(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) as royalty,
sum(titles.advance*titleauthor.royaltyper / 100) as adv
from sales

left join titles
on titles.title_id=sales.title_id

left join titleauthor
on titleauthor.title_id=titles.title_id

left join authors
on titleauthor.au_id=authors.au_id

group by authors.au_id, titles.title_id

order by authors.au_id desc





-- challenge 2------------------------------------------------------------------------------
select 
authorid,
sum(adv + royalty) as profit

from royalty_by_author2

group by authorid
order by profit desc
limit 3;



-- challenge 3 ...........................

create temporary table publications.royalty_by_author2(
select authors.au_id as authorid,


 (royalty+adv) as profit
 
 from royalty_by_author2 as d
 group by authorid
 order by profit
 limit 3);
 
 create table most_profitable_authors
select * from most_profitable_authors