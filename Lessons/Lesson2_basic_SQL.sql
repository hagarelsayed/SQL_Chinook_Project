
/**/
SELECT occurred_at, account_id, channel
FROM web_events
order by /* to order from big to low or use DESC for vice versa */
LIMIT 15; /*better to add it always*/


SELECT *
FROM orders
ORDER BY occurred_at /* should be after from and before limit*/
LIMIT 1000;

/*Write a query to return the 10 earliest orders in the orders table. Include the id, occurred_at, and total_amt_usd.*/
SELECT id, occurred_at,  total_amt_usd
From orders
Order by  occurred_at
limit 10 ;
/*Write a query to return the top 5 orders in terms of the largest total_amt_usd. Include the id, account_id, and total_amt_usd.*/

SELECT id, account_id,  total_amt_usd
FROM orders
order by total_amt_usd DESC
limit 5;
/*Write a query to return the lowest 20 orders in terms of the smallest 
total_amt_usd. Include the id, account_id, and total_amt_usd.*/


SELECT id, account_id,  total_amt_usd
From orders
order by total_amt_usd 
limit 20 ;

/*Write a query that displays the order ID, account ID, and total dollar amount
 for all the orders, sorted first by the account ID (in ascending order), 
 and then by the total dollar amount (in descending order). */

 SELECT id, account_id, total_amt_usd
 from orders
 order by account_id, total_amt_usd DESC ;

 /*Now write a query that again displays order ID, account ID, and 
 total dollar amount for each order, but this time sorted first by
  total dollar amount (in descending order), and then by account ID 
  (in ascending order).*/

  SELECT id, account_id, total_amt_usd
 from orders
 order by total_amt_usd  DESC, account_id ;
 

 /*Pulls the first 5 rows and all columns from the orders table that have a dollar
  amount of gloss_amt_usd greater than or equal to 1000. */
  SELECT *
  FROM orders
  Where gloss_amt_usd >= 1000
  limit 5;

/*Pulls the first 10 rows and all columns from the orders table that have a
 total_amt_usd less than 500. */

  SELECT *
  FROM orders
  Where total_amt_usd < 500
  limit 10;

  /* You will notice when using these WHERE statements, we do not need to ORDER BY unless we want to actually order our data. Our condition will work without having to do any sorting of the data.*/

  SELECT  name, website,primary_poc
FROM accounts 
Where primary_poc = 'Sung Shields' ; 

 /*remember that SQL requires single-quotes, not double-quotes, around text values like 'Exxon Mobil.'


 Create a column that divides the standard_amt_usd by the standard_qty
  to find the unit price for standard paper for each order.
   Limit the results to the first 10 orders, and include the id and account_id 
   fields.*/

   Select id,account_id, standard_amt_usd/standard_qty as unit_price
   From orders
   limit 10

   /*Write a query that finds the percentage of revenue that comes from
    poster paper for each order. You will need to use only the columns that 
    end with _usd. .*/

Select id, account_id, (poster_amt_usd*100)/total_amt_usd
From orders

/*Try to do this without using the total column.) Display 
    the id and account_id fields also. NOTE - you will receive an error with
     the correct solution to this question. This occurs because at least one 
     of the values in the data creates a division by zero in your formula.
      There are ways to better handle this. For now, you can just limit your 
      calculations to the first 10 orders, as we did in question #1, and you'll
       avoid that set of data that causes the problem */
Select id, account_id, (poster_amt_usd*100)/(standard_amt_usd+gloss_amt_usd+poster_amt_usd) as post_per
From orders

/* ## Questions using the LIKE operator
SELECT *
FROM accounts
WHERE website LIKE '%google%';
Use the accounts table to find

  1. All the companies whose names start with 'C'.*/
select *
From accounts
where name like 'c%' 

/*
  2. All companies whose names contain the string 'one' somewhere in the name.*/
select *
From accounts
where name like '%one%' 

/*  3. All companies whose names end with 's'.*/
select *
From accounts
where name like '%s' 

/*Questions using IN operator
Example:
SELECT *
FROM orders
WHERE account_id IN (1001,1021); */

/*Use the accounts table to find the account name, primary_poc,
 and sales_rep_id for Walmart, Target, and Nordstrom.*/

Select name, primary_poc, sales_rep_id
From accounts
where name in ('Walmart', 'Target',  'Nordstrom')

/*Use the web_events table to find all information regarding 
individuals who were contacted via the channel of organic or adwords.*/
Select *
From web_events 
where channel in ('organic', 'adwords') 

/*## Not Operqtor */
SELECT sales_rep_id, 
       name
FROM accounts
WHERE sales_rep_id NOT IN (321500,321570)
ORDER BY sales_rep_id

SELECT *
FROM accounts
WHERE website NOT LIKE '%com%';

/*Questions using the NOT operator
We can pull all of the rows that were excluded from the queries in the previous
 two concepts with our new operator. 

Use the accounts table to find the account name, primary poc, and sales rep id
 for all stores except Walmart, Target, and Nordstrom.*/
Select  name, primary_poc, sales_rep
from accounts
where name not in ('walmart', 'target', 'Nordstrom')


/*Use the web_events table to find all information regarding individuals 
who were contacted via any method except using organic or adwords methods.*/
select *
from web_events
where method not in ('organic', 'adwords')

/*Use the accounts table to find:

All the companies whose names do not start with 'C'.
All companies whose names do not contain the string 'one' somewhere in the name.
All companies whose names do not end with 's'.*/

select name
from accounts
where name not like '%s' 

/* And & Between
Code from the Video
Query 1 */

SELECT *
FROM orders
WHERE occurred_at >= '2016-04-01' AND occurred_at <= '2016-10-01'
ORDER BY occurred_at
Query 2

/*This query has been modified to properly include BETWEEN*/

SELECT *
FROM orders
WHERE occurred_at BETWEEN '2016-04-01' AND '2016-10-01'
ORDER BY occurred_at

/*Questions using AND and BETWEEN operators
Write a query that returns all the orders where the standard_qty is over 1000,
 the poster_qty is 0, and the gloss_qty is 0.*/
 select *
 from orders
 where standard_qty >1000 and poster_qty = 0 and gloss_qty = 0
 
 /*
Using the accounts table, find all the companies whose names do not start with 'C'
 and end with 's'.*/
 select name
 from accounts
 where name not like 'c%' and like '%s'
 /*
When you use the BETWEEN operator in SQL, do the results include the values of 
your endpoints, or not? Figure out the answer to this important question by 
writing a query that displays the order date and gloss_qty data for all orders 
where gloss_qty is between 24 and 29. */
select date , gloss_qty
from orders
where gloss_qty Between 24 and 29
/*
Then look at your output to see if the BETWEEN operator included the 
begin and end values or not. yes , all included*/

/*
Use the web_events table to find all information regarding individuals 
who were contacted via the organic or adwords channels, and started their
 account at any point in 2016, sorted from newest to oldest.*/
 select *
 from web_events
 where channel in ('organic', 'adwords') and occurred_at >= '2016-01-01' 
 order by occurred_at DESC

 SELECT *
FROM web_events
WHERE channel IN ('organic', 'adwords') AND occurred_at BETWEEN '2016-01-01' AND '2017-01-01'
ORDER BY occurred_at DESC;

/*Code from Video1*/
SELECT account_id,
       occurred_at,
       standard_qty,
       gloss_qty,
       poster_qty
FROM orders
WHERE standard_qty = 0 OR gloss_qty = 0 OR poster_qty = 0

/*Code from Video 2*/
SELECT account_id,
       occurred_at,
       standard_qty,
       gloss_qty,
       poster_qty
FROM orders
WHERE (standard_qty = 0 OR gloss_qty = 0 OR poster_qty = 0)
AND occurred_at = '2016-10-01'

/*Questions using the OR operator
Find list of orders ids where either gloss_qty or poster_qty is greater than 4000.
 Only include the id field in the resulting table.*/
select ID
from orders
where gloss_qty > 4000 or poster_qty > 4000;

/*Write a query that returns a list of orders where the standard_qty is zero 
and either the gloss_qty or poster_qty is over 1000.*/
select *
from orders
where standard_qty = 0 and (gloss_qty> 1000 or poster_qty> 1000)

/*Find all the company names that start with a 'C' or 'W', and the primary contact
 contains 'ana' or 'Ana', but it doesn't contain 'eana'. */

 select name
 from accounts
 where name like 'C%' or name like 'W%'
 and primary_poc like '%ana%' and primary_poc not like '%eana%'

 /* Correct Answer */
 SELECT *
FROM accounts
WHERE (name LIKE 'C%' OR name LIKE 'W%') 
           AND ((primary_poc LIKE '%ana%' OR primary_poc LIKE '%Ana%') 
           AND primary_poc NOT LIKE '%eana%');