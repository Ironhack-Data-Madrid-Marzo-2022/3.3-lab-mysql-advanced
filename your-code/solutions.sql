
SELECT titleauthor.title_id as "Title ID", titleauthor.au_id as "Author ID",
       sales_royalty.salesroyalty as "Royalty of each sale for each author"
FROM titleauthor
INNER JOIN titles ON titleauthor.title_id = titles.title_id
INNER JOIN sales ON titleauthor.title_id = sales.title_id
INNER JOIN (
  SELECT sales.title_id, SUM(sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) AS salesroyalty
  FROM titleauthor
  INNER JOIN titles ON titleauthor.title_id = titles.title_id
  INNER JOIN sales ON titleauthor.title_id = sales.title_id
  GROUP BY sales.title_id
) AS sales_royalty ON titleauthor.title_id = sales_royalty.title_id
ORDER BY titleauthor.title_id, titleauthor.au_id;