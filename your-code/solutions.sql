-- Challenge 1

select sub2.au_id, sum(sub2.sumry+sub2.advance) as profit
from (select sub.au_id, sub.title_id, sum(sales_royalty) as sumry, sub.advance
from (select titleauthor.au_id, titles.title_id, titles.advance,
 (titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100 )
as sales_royalty
from titleauthor
left join titles
on titleauthor.title_id=titles.title_id
left join sales
on sales.title_id=titles.title_id
order by titleauthor.au_id) as sub
group by sub.au_id,  sub.title_id
order by sub.title_id) as sub2
group by sub2.au_id
order by sub2.au_id

-- Challenge 2

CREATE TEMPORARY TABLE temp1
select titleauthor.au_id, titles.title_id, titles.advance,
 (titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100 )
as sales_royalty
from titleauthor
left join titles
on titleauthor.title_id=titles.title_id
left join sales
on sales.title_id=titles.title_id
order by titleauthor.au_id;

CREATE TEMPORARY TABLE temp2
select temp1.au_id, temp1.title_id, sum(sales_royalty) as sumry, temp1.advance
from temp1
group by temp1.au_id,  temp1.title_id
order by temp1.title_id;


select temp2.au_id, sum(temp2.sumry+temp2.advance) as profit
from temp2
group by temp2.au_id
order by temp2.au_id;

-- Challenge 3

CREATE TABLE most_profiting_authors AS
select sub2.au_id, sum(sub2.sumry+sub2.advance) as profit
from (select sub.au_id, sub.title_id, sum(sales_royalty) as sumry, sub.advance
from (select titleauthor.au_id, titles.title_id, titles.advance,
 (titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100 )
as sales_royalty
from titleauthor
left join titles
on titleauthor.title_id=titles.title_id
left join sales
on sales.title_id=titles.title_id
order by titleauthor.au_id) as sub
group by sub.au_id,  sub.title_id
order by sub.title_id) as sub2
group by sub2.au_id
order by sub2.au_id

