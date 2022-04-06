# Challenge 1

## Step 1: Calculate the royalties of each sales for each author

select sales.title_id, titleauthor.au_id,  (titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) as sales_royalty from sales 
join titleauthor on sales.title_id = titleauthor.title_id
join titles on titleauthor.title_id = titles.title_id

## Step 2: Aggregate the total royalties for each title for each author

CREATE TEMPORARY TABLE temp_table
as
(select sales.title_id, titleauthor.au_id,  (titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) as sales_royalty 
from sales 
join titleauthor on sales.title_id = titleauthor.title_id
join titles on titleauthor.title_id = titles.title_id)

select title_id, au_id, sum(sales_royalty) as Agg_royalties  from temp_table
group by title_id, au_id

## Step 3: Calculate the total profits of each author

CREATE TEMPORARY TABLE temp_table2
as
(select title_id, au_id, sum(sales_royalty) as Agg_royalties  from temp_table
group by title_id, au_id)

select a.*, b.advance, (Agg_royalties+advance) as Profits from temp2 a
join titles b on a.title_id=b.title_id
order by Profits desc
limit 3

# Challenge 2

## Step 1: Calculate the royalties of each sales for each author

select sales.title_id, titleauthor.au_id,  (titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) as sales_royalty from sales 
join titleauthor on sales.title_id = titleauthor.title_id
join titles on titleauthor.title_id = titles.title_id

## Step 2: Aggregate the total royalties for each title for each author

select title_id, au_id, sum(sales_royalty) as Agg_royalties  
from 
(select sales.title_id, titleauthor.au_id,  (titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) as sales_royalty 
from sales 
join titleauthor on sales.title_id = titleauthor.title_id
join titles on titleauthor.title_id = titles.title_id) as derived1
group by title_id, au_id

## Step 3: Calculate the total profits of each author

select derived2.title_id, derived2.au_id, b.advance, (Agg_royalties+advance) as Profits from 
	(select title_id, au_id, sum(sales_royalty) as Agg_royalties  
	from 
		(select sales.title_id, titleauthor.au_id,  (titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) as sales_royalty 
		from sales 
		join titleauthor on sales.title_id = titleauthor.title_id
		join titles on titleauthor.title_id = titles.title_id) as derived1
	group by title_id, au_id) as derived2
join titles b on derived2.title_id=b.title_id
order by Profits desc
limit 3

# Challenge 3

CREATE TEMPORARY TABLE temp3
as
(select a.*, b.advance, (Agg_royalties+advance) as Profits 
from temp2 a
join titles b on a.title_id=b.title_id) 

create table most_profiting_authors
select au_id, Profits 
from temp3

select * from most_profiting_authors