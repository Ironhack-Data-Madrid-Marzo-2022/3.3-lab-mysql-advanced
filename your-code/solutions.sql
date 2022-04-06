-- solución challenge 1:

create temporary table roy_per_title4
select titles.title_id as Title_ID, authors.au_id as Author_ID, sum((advance+titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100)) as Royalty 
from authors
left join titleauthor
on titleauthor.au_id=authors.au_id
left join titles
on titles.title_id=titleauthor.title_id
left join sales
on sales.title_id=titles.title_id
group by authors.au_id, titles.title_id;

select Author_ID,roy.Royalty as profits_author
from roy_per_title4 as roy 
left join titles
on titles.title_id=roy.title_id
group by titles.title_id,Author_ID
order by profits_author desc limit 3;

-- Solución challenge dos:

select Author_ID,roy.Royalty as profits_author
from (select titles.title_id as Title_ID, authors.au_id as Author_ID, sum((advance+titles.price * sales.qty * titles.royalty / 100 * ta.royaltyper / 100)) as Royalty
from authors
left join titleauthor as ta
on ta.au_id=authors.au_id
left join titles
on titles.title_id=ta.title_id
left join sales
on titles.title_id=sales.title_id
group by authors.au_id, titles.title_id) as roy
 
left join titles 
on titles.title_id=roy.title_id
group by Author_ID
order by profits_author desc limit 3;

-- Solución challenge 3:

create table challenge3 
select Author_ID,roy.Royalty as profits_author
from (select titles.title_id as Title_ID, authors.au_id as Author_ID, sum((advance+titles.price * sales.qty * titles.royalty / 100 * ta.royaltyper / 100)) as Royalty
from authors
left join titleauthor as ta
on ta.au_id=authors.au_id
left join titles
on titles.title_id=ta.title_id
left join sales
on titles.title_id=sales.title_id
group by authors.au_id, titles.title_id) as roy
 
left join titles 
on titles.title_id=roy.title_id
group by Author_ID
order by profits_author desc limit 3;

select *
from challenge3;


