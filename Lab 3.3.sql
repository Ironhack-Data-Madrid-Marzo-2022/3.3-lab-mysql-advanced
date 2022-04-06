-- Challenge 1 - Most Profiting Authors
-- Step 1: Calculate the royalties of each sales for each author

SELECT titles.title_id, authors.au_id as Author_ID, (titles.price*sales.qty*titles.royalty/100*titleauthor.royaltyper/100) as Sales_royalty
FROM authors
INNER JOIN titleauthor                            
ON authors.au_id=titleauthor.au_id            
INNER JOIN titles                            
ON titles.title_id=titleauthor.title_id      
INNER JOIN publishers
ON titles.pub_id=publishers.pub_id
INNER JOIN sales
ON titles.title_id=sales.title_id
GROUP BY authors.au_id;

