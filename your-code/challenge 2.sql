create temporary table publications.royalty_by_author
select authors.au_id as authorid,


sum(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) as royalty

from sales

left join titles
on titles.title_id=sales.title_id

left join titleauthor
on titleauthor.title_id=titles.title_id

left join authors
on titleauthor.au_id=authors.au_id

group by authors.au_id, titles.title_id

order by authors.au_id desc



-----------Llamada a temporarytable

select 
author.au_id as authorid,
sum(advance*titleauthor.royaltyper/100 + royalty) as profit

from royalty_by_author

group by author.au_id
order by profit
limit 3;