-- Challenge 1

-- STEP 1

select	t.title_id as 'TITLE ID',
        a.au_id as 'AUTHOR ID',
        (t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) as 'ROYALTY'
from authors a

left join titleauthor ta
on ta.au_id = a.au_id

left join titles t
on ta.title_id = t.title_id

left join sales s
on t.title_id = s.title_id

group by a.au_id
order by sum(s.qty) desc

-- STEP 2

select	t.title_id as 'TITLE ID',
        a.au_id as 'AUTHOR ID',
        sum(t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) as 'ROYALTY'
from authors a

left join titleauthor ta
on ta.au_id = a.au_id

left join titles t
on ta.title_id = t.title_id

left join sales s
on t.title_id = s.title_id

group by a.au_id, t.title_id

order by sum(t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) desc

-- STEP 3

select	a.au_id as 'AUTHOR ID',
        sum(t.advance + (t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100)) as 'PROFIT'
from authors a

left join titleauthor ta
on ta.au_id = a.au_id

left join titles t
on ta.title_id = t.title_id

left join sales s
on t.title_id = s.title_id

group by a.au_id, t.title_id

order by sum(t.advance + (t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100)) desc

limit 3;

----------------------------------

-- Challenge 2

create temporary table t7
(select	t.title_id,
        a.au_id,
        sum(t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) as royalty
from authors a

left join titleauthor ta
on ta.au_id = a.au_id

left join titles t
on ta.title_id = t.title_id

left join sales s
on t.title_id = s.title_id
);

select t7.au_id as 'AUTHOR ID',
	   sum(t7.royalty) as 'PROFIT'
from t7

group by t7.title_id, t7.au_id
order by t7.royalty desc

limit 3;

----------------------------------

-- Challenge 3

create table most_profiting_table
select	a.au_id as 'AUTHOR ID',
        sum(t.advance + (t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100)) as 'PROFIT'
from authors a

left join titleauthor ta
on ta.au_id = a.au_id

left join titles t
on ta.title_id = t.title_id

left join sales s
on t.title_id = s.title_id
group by a.au_id, t.title_id

order by sum(t.advance + (t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100)) desc

limit 3;
