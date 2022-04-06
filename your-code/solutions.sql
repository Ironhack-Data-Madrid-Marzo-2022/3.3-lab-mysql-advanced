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