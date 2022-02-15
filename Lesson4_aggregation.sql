/*Notice that NULLs are different than a zero - they are cells where data does not exist.

When identifying NULLs in a WHERE clause, we write IS NULL or IS NOT NULL. We don't use =, because NULL isn't considered a value in SQL. Rather, it is a property of the data.

NULLs - Expert Tip
There are two common ways in which you are likely to encounter NULLs:

NULLs frequently occur when performing a LEFT or RIGHT JOIN. You saw in the last lesson - when some rows in the left table of a left join are not matched with rows in the right table, those rows will contain some NULL values in the result set.
NULLs can also occur from simply missing data in our database.

Query 1*/
SELECT *
FROM accounts
WHERE id > 1500 and id < 1600

/*Query 2*/
SELECT *
FROM accounts
WHERE primary_poc = NULL

/*Query 3*/
SELECT *
FROM accounts
WHERE primary_poc IS NOT NULL

/* ##COUNT the Number of Rows in a Table

Try your hand at finding the number of rows in each table. Here is an example of finding all the rows 
in the accounts table. */

SELECT COUNT(*)
FROM accounts;
/*But we could have just as easily chosen a column to drop into the aggregation function:*/

SELECT COUNT(accounts.id)
FROM accounts;
/*These two statements are equivalent, but this isn't always the case, which we will see in the next 
video.

Query 2*/
SELECT COUNT(*)
FROM orders
WHERE occurred_at >= '2016-12-01'
AND occurred_at < '2017-01-01'
-- Query 3
SELECT COUNT(*) AS order_count
FROM orders
WHERE occurred_at >= '2016-12-01'
AND occurred_at < '2017-01-01'

-- Notice that COUNT does not consider rows that have NULL values. 
-- Therefore, this can be useful for quickly identifying which rows have missing data. 
-- You will learn GROUP BY in an upcoming concept, and then each of these aggregators will become much
--  more useful.

-- Query 2
SELECT COUNT (id) AS account_id_count
FROM accounts
-- Query 3
SELECT COUNT(primary_poc) AS account_primary_poc_count
FROM accounts
-- Query 4
-- Example: there will not be any NULL values in the workspace.

SELECT *
FROM accounts
WHERE primary_poc IS NULL

-- ## Sum
-- Unlike COUNT, you can only use SUM on numeric columns. However, SUM will ignore NULL values, as do the
--  other aggregation functions you will see in the upcoming lessons.

-- Aggregation Reminder
-- An important thing to remember: aggregators only aggregate vertically - the values of a column. If you 
-- want to perform a calculation across rows, you would do this with simple arithmetic.

-- Query 1
SELECT SUM(standard_qty) AS standard,
       SUM(gloss_qty) AS gloss,
       SUM(poster_qty) AS poster
FROM orders

-- Aggregation Questions
-- Use the SQL environment below to find the solution for each of the following questions. 

-- Find the total amount of poster_qty paper ordered in the orders table.
select sum(poster_qty)  as poster_qty_total
from orders

-- Find the total amount of standard_qty paper ordered in the orders table.
select sum(standard_qty)  as standard_qty_total
from orders
-- Find the total dollar amount of sales using the total_amt_usd in the orders table.
select sum(total_amt_usd)  as total_amt_usd_total
from orders
-- Find the total amount spent on standard_amt_usd and gloss_amt_usd paper 
-- for each order in the orders table. This should give a dollar amount for each order in the table.
select standard_amt_usd+gloss_amt_usd as total_amount
from orders
-- or to show the summed columns
select standard_amt_usd, gloss_amt_usd, standard_amt_usd+gloss_amt_usd as total_amount
from orders

-- Find the standard_amt_usd per unit of standard_qty paper. 
-- Your solution should use both aggregation and a mathematical operator.
-- My solution
select standard_amt_usd,
standard_qty,from orders
where standard_qty > 0

-- right answer
SELECT SUM(standard_amt_usd)/SUM(standard_qty) AS standard_price_per_unit
FROM orders;

--min & max
-- Functionally, MIN and MAX are similar to COUNT in that they can be used on non-numerical 
-- columns. Depending on the column type, MIN will return the lowest number, earliest date, or 
-- non-numerical value as early in the alphabet as possible. As you might suspect, MAX does the
--  opposite—it returns the highest number, the latest date, or the non-numerical value closest
--   alphabetically to “Z.”
SELECT MIN(standard_qty) AS standard_min,
       MIN(gloss_qty) AS gloss_min,
       MIN(poster_qty) AS poster_min,
       MAX(standard_qty) AS standard_max,
       MAX(gloss_qty) AS gloss_max,
       MAX(poster_qty) AS poster_max
FROM   orders

Questions: MIN, MAX, & AVERAGE
Use the SQL environment below to assist with answering the following questions. Whether you get stuck or you just want to double-check your solutions, my answers can be found at the top of the next concept.

-- When was the earliest order ever placed? You only need to return the date.

select min(o.occurred_at) as earliest_order
from orders o

-- Try performing the same query as in question 1 without using an aggregation function.
select o.occurred_at as , o.id
from orders o
order by o.occurred_at 
limit 1
-- When did the most recent (latest) web_event occur?
select max(w.occurred_at) as latest_order
from web_events w
-- Try to perform the result of the previous query without using an aggregation function.
select w.occurred_at as earliest, w.id
from web_events w
order by w.occurred_at Desc
limit 1
-- Find the mean (AVERAGE) amount spent per order on each paper type, as well as the mean amount of each paper type
--  purchased per order. Your final answer should have 6 values - one for each paper type for the average number of 
--  sales, as well as the average amount.
select avg(o.gloss_qty) as gq, 
avg(o.standard_qty) as sq,
avg(o.poster_qty) as pq, 
avg(o.gloss_amt_usd) as ga,
avg(o.standard_amt_usd) as sa,
avg(o.poster_amt_usd) as pa

from orders o

-- udacity solution (more organized)
SELECT AVG(standard_qty) mean_standard, AVG(gloss_qty) mean_gloss, 
        AVG(poster_qty) mean_poster, AVG(standard_amt_usd) mean_standard_usd, 
        AVG(gloss_amt_usd) mean_gloss_usd, AVG(poster_amt_usd) mean_poster_usd
FROM orders;

-- Via the video, you might be interested in how to calculate the MEDIAN. Though this is more advanced than what we 
-- have covered so far try finding - what is the MEDIAN total_usd spent on all orders?

--my incomplete solutions (i continued later on calc :D)
select o.total_amt_usd
from orders o 
order by o.total_amt_usd Desc
limit 3457
-- answer 172541
-- Congrats, you solved half of it 

--udacity Solution

SELECT *
FROM (SELECT total_amt_usd
   FROM orders
   ORDER BY total_amt_usd
   LIMIT 3457) AS Table1
ORDER BY total_amt_usd DESC
LIMIT 2;


-- Since there are 6912 orders - we want the average of the 3457 and 3456 order amounts when ordered.
--  This is the average of 2483.16 and 2482.55. This gives the median of 2482.855. This obviously isn't an ideal way
--   to compute. If we obtain new orders, we would have to change the limit. SQL didn't even calculate the median for us.
--    The above used a SUBQUERY, but you could use any method to find the two necessary values, and then 
--    you just need the average of them.

