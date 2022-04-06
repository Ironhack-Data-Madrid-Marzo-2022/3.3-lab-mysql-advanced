-- Challenge 1 - Most Profiting Authors --

-- Step 1: Calculate the royalties of each sales for each author
CREATE TEMPORARY TABLE royalties_author (SELECT
    a.au_id AS AUTHOR,
    t.title_id AS TITLE,
    t.advance AS ADVANCE,
    sum(t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) AS 'ROYALTY'
FROM sales AS s
JOIN titles t on s.title_id = t.title_id
JOIN titleauthor AS ta ON t.title_id = ta.title_id
JOIN authors a on ta.au_id = a.au_id
GROUP BY a.au_id);


-- select * from royalties_author;

-- Step 2: Aggregate the total royalties for each title for each author
CREATE TEMPORARY TABLE royalties_title (SELECT
    r.AUTHOR AS AUTHOR,
    r.TITLE AS TITLE,
    r.ADVANCE AS ADVANCE,
    sum(r.ROYALTY) AS 'ROYALTY_TOTAL'
FROM royalties_author as r
GROUP BY r.TITLE);

-- select * from royalties_title;

-- Step 3: Calculate the total profits of each author

SELECT
       r.AUTHOR,
       (r.ROYALTY_TOTAL + r.ADVANCE) AS TOTAL_PROFITS
FROM royalties_title AS r
GROUP BY r.AUTHOR
ORDER BY TOTAL_PROFITS DESC
LIMIT 3;

-- Challenge 2 - Alternative Solution --

SELECT
       rt.AUTHOR,
       (rt.ROYALTY_TOTAL + rt.ADVANCE) AS TOTAL_PROFITS
FROM (SELECT
    ra.AUTHOR AS AUTHOR,
    ra.ADVANCE AS ADVANCE,
    sum(ra.ROYALTY) AS 'ROYALTY_TOTAL'
FROM (SELECT
    a.au_id AS AUTHOR,
    t.title_id AS TITLE,
    t.advance AS ADVANCE,
    sum(t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) AS 'ROYALTY'
FROM sales AS s
JOIN titles t on s.title_id = t.title_id
JOIN titleauthor AS ta ON t.title_id = ta.title_id
JOIN authors a on ta.au_id = a.au_id
GROUP BY a.au_id) AS ra
GROUP BY ra.TITLE) as rt
GROUP BY rt.AUTHOR
ORDER BY TOTAL_PROFITS DESC
LIMIT 3;

-- Challenge 3 --
-- Create a temporary table from stept 3
-- And then save this table as permanent
CREATE TEMPORARY TABLE most_profiting_authors(SELECT
       r.AUTHOR AS AUTHOR,
       (r.ROYALTY_TOTAL + r.ADVANCE) AS TOTAL_PROFITS
FROM royalties_title AS r
GROUP BY r.AUTHOR
ORDER BY TOTAL_PROFITS DESC
LIMIT 3);
CREATE TABLE most_profiting_authors
SELECT * FROM most_profiting_authors;