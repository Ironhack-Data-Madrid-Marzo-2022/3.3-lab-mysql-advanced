create temporary table publications.royalty_by_author2(
select authors.au_id as authorid,


 (royalty+adv) as profit
 
 from royalty_by_author2 as d
 group by authorid
 order by profit
 limit 3);
 
 create table most_profitable_authors
select * from most_profitable_authors
 
 
 

