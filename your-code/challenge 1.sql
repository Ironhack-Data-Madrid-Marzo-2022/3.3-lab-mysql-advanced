select 
authorid as "author id",
sum(d +royalty) as "profit"




from (select
titles.title_id as "title id",
authors.au_id as authorid,
sum(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) as royalty,
sum(titles.advance* titleauthor.royaltyper / 100) as d
from sales

left join titles
on titles.title_id=sales.title_id

left join titleauthor
on titleauthor.title_id=titles.title_id

left join authors
on titleauthor.au_id=authors.au_id

group by authors.au_id, titles.title_id

order by authors.au_id desc) as t

group by authorid

order by profit desc 	
limit 3;

