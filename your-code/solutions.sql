-- ------------
-- Challenge 1
-- ------------

select r.au_id, SUM(r.sales_royalty) as royalties

from (select s.title_id, ta.au_id,
		(t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100 + t.advance) AS sales_royalty

FROM sales as s
LEFT JOIN titles AS t
ON s.title_id = t.title_id

LEFT JOIN titleauthor as ta
ON t.title_id  = ta.title_id) as r
GROUP BY r.title_id, r.au_id
ORDER BY r.sales_royalty desc
LIMIT 3;

-- -----------
-- Challenge 2
-- -----------

CREATE TEMPORARY TABLE c2
(select s.title_id, ta.au_id,
		(t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100 + t.advance) AS sales_royalty

FROM sales as s
LEFT JOIN titles AS t
ON s.title_id = t.title_id

LEFT JOIN titleauthor as ta
ON t.title_id  = ta.title_id);

select c2.au_id, SUM(c2.sales_royalty) as royalties

from c2
GROUP BY c2.title_id, c2.au_id
ORDER BY c2.sales_royalty desc
LIMIT 3;

-- -----------
-- Challenge 3
-- -----------

CREATE TABLE most_profiting_authors
SELECT *
from c2
GROUP BY c2.title_id, c2.au_id
ORDER BY c2.sales_royalty desc
LIMIT 3;

-- ---------------------------------
-- Challenge 1 con advance por autor
-- ---------------------------------

CREATE TEMPORARY TABLE apa4
select t.title_id as title_id_apa,
		count(ta.au_id),
        t.advance as advance_apa,
		ifnull((t.advance / count(ta.au_id)), 0) AS advance_per_author
from titles as t
left join titleauthor as ta
on t.title_id = ta.title_id
group by t.title_id;

CREATE TEMPORARY TABLE titles_upd2
(select * 
from titles as t
left join apa4 as apaN
on t.title_id = apaN.title_id_apa);

select r.au_id, SUM(r.sales_royalty) as royalties

from (select s.title_id, ta.au_id,
		(t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100 + t.advance_per_author) AS sales_royalty

FROM sales as s
LEFT JOIN titles_upd2 AS t
ON s.title_id = t.title_id

LEFT JOIN titleauthor as ta
ON t.title_id  = ta.title_id) as r
GROUP BY r.title_id, r.au_id
ORDER BY r.sales_royalty desc
LIMIT 3;