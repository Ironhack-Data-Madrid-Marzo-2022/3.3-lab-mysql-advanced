#create temporary table T1
select T.title_id, a.au_id, (T.price * s.qty * T.royalty / 100 * ta.royaltyper / 100) as sales_royalty
from authors as a
inner join titleauthor as ta
on a.au_id = ta.au_id
inner join titles as T
on ta.title_id = T.title_id
inner join publishers as p
on T.pub_id = p.pub_id
inner join roysched as r
on r.title_id = T.title_id
inner join sales as s
on s.title_id = T.title_id;

create temporary table advance 
select titles.title_id, au_id, (royaltyper*titles.advance) as advance_per_author
from titles
inner join titleauthor
on titles.title_id = titleauthor.title_id;

create temporary table T2
SELECT title_id, au_id, sum(sales_royalty) as total_royalty_title
from T1
group by title_id, au_id;

select T2.au_id, (total_royalty_title+titles.advance/100*ta.royaltyper) as total_royal
from T2
left join titles
on titles.title_id = T2.title_id
left join titleauthor as ta
on ta.title_id= titles.title_id
order by total_royal desc
limit 3;

#create table most_profiting_authors
select T2.au_id, (total_royalty_title + advance.title_id)as profits
from T2
left join titles
on titles.title_id = T2.title_id
left join advance
on T2.title_id= advance.title_id
order by profits desc
limit 3;

------ derivadas--------
select der.title_id, der.au_id ,round((sales_royalty),0)
from (select T.title_id, a.au_id, (T.price * s.qty * T.royalty / 100 * ta.royaltyper / 100) as sales_royalty
from authors as a
inner join titleauthor as ta
on a.au_id = ta.au_id
inner join titles as T
on ta.title_id = T.title_id
inner join publishers as p
on T.pub_id = p.pub_id
inner join roysched as r
on r.title_id = T.title_id
inner join sales as s
on s.title_id = T.title_id) as der
group by title_id, au_id;

select der.title_id, der.au_id , (sum(round(der.sales_royalty,0))) as total_royal
from (select T.title_id, a.au_id, (T.price * s.qty * T.royalty / 100 * ta.royaltyper / 100) as sales_royalty
from authors as a
inner join titleauthor as ta
on a.au_id = ta.au_id
inner join titles as T
on ta.title_id = T.title_id
inner join publishers as p
on T.pub_id = p.pub_id
inner join roysched as r
on r.title_id = T.title_id
inner join sales as s
on s.title_id = T.title_id) as der
group by title_id, au_id;

select der.au_id, (sum(round(der.sales_royalty,0)))+ advance.title_id as profit
from (select T.title_id, a.au_id, (T.price * s.qty * T.royalty / 100 * ta.royaltyper / 100) as sales_royalty
from authors as a
inner join titleauthor as ta
on a.au_id = ta.au_id
inner join titles as T
on ta.title_id = T.title_id
inner join publishers as p
on T.pub_id = p.pub_id
inner join roysched as r
on r.title_id = T.title_id
inner join sales as s
on s.title_id = T.title_id) as der
left join advance
on der.title_id= advance.title_id
group by der.au_id
order by profit asc
limit 3;