select	titles.title_id as 'TITLE ID',
		authors.au_id as 'AUTHOR ID',
        titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100 as 'SALES ROYALTY'
from sales

inner join titles
on sales.title_id = titles.title_id

inner join titleauthor
on titles.title_id = titleauthor.title_id

inner join authors
on titleauthor.au_id = authors.au_id
where 'SALES ROYALTY' in (

	select 'SALES ROYALTY' from sales
    inner join titles on sales.title_id = titles.title_id
)
group by authors.au_id;