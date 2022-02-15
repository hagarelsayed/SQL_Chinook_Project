
-----------------
-- Group By------
------------------

-- The key takeaways here:

-- GROUP BY can be used to aggregate data within subsets of the data. 
-- For example, grouping for different accounts, different regions, or different
--  sales representatives.
-- Any column in the SELECT statement that is not within an aggregator must be in
--  the GROUP BY clause.
-- The GROUP BY always goes between WHERE and ORDER BY.
-- ORDER BY works like SORT in spreadsheet software.

-- GROUP BY - Expert Tip
-- Before we dive deeper into aggregations using GROUP BY statements,
-- it is worth noting that SQL evaluates the aggregations before the LIMIT clause.
-- If you don’t group by any columns, you’ll get a 1-row result—no problem there.
-- If you group by a column with enough unique values that it exceeds the
-- LIMIT number, the aggregates will be calculated, and then some rows will 
-- simply be omitted from the results.
-- standard_amt_usd/standard_qty as amt_per_qty_unit


-- This is actually a nice way to do things because you know you’re going to get
--  the correct aggregates. If SQL cuts the table down to 100 rows, then performed
--   the aggregations, your results would be substantially different. The above 
--   query’s results exceed 100 rows, so it’s a perfect example.
--    In the next concept, use the SQL environment to try removing the LIMIT and 
--    running it again to see what changes.

-- Query 2:
SELECT account_id,
       SUM(standard_qty) AS standard,
       SUM(gloss_qty) AS gloss,
       SUM(poster_qty) AS poster
FROM orders
GROUP BY account_id
ORDER BY account_id

-- GROUP BY Note

-- One part that can be difficult to recognize is when it might be easiest to use 
-- an aggregate or one of the other SQL functionalities. Try some of the below to
--  see if you can differentiate to find the easiest solution.

-- Which account (by name) placed the earliest order? Your solution should have 
-- the account name and the date of the order.
select a.name, o.occurred_at
from orders o
join accounts a
on o.account_id = a.id
order by occurred_at
limit 1


-- Udacity Solution
SELECT a.name, o.occurred_at
FROM accounts a
JOIN orders o
ON a.id = o.account_id
ORDER BY occurred_at
LIMIT 1;

--DISH Network	2013-12-04T04:22:44.000Z

--2. Find the total sales in usd for each account. You should include two columns - the total sales for each company's
-- orders in usd and the company name.
select a.name , sum(o.total_amt_usd) as total_sales 
from orders o
join accounts a
on a.id = o.account_id
group by a.name


--3. Via what channel did the most recent (latest) web_event occur, which account was associated with this web_event?
--  Your query should return only three values - the date, channel, and account name.

select a.name, w.channel, max(w.occurred_at) latest_web_event
from web_events w
join accounts a
on w.account_id = a.id
group by a.name,w.channel
order by latest_web_event
limit 1   -- wrong answer

--right is : --udacity Solution
SELECT w.occurred_at, w.channel, a.name
FROM web_events w
JOIN accounts a
ON w.account_id = a.id 
ORDER BY w.occurred_at DESC
LIMIT 1;


-- Find the total number of times each type of channel from the web_events was used. Your final table should have 
-- two columns - the channel and the number of times the channel was used.
SELECT a.primary_poc
FROM web_events w
JOIN accounts a
ON a.id = w.account_id
ORDER BY w.occurred_at
LIMIT 1;

-- Who was the primary contact associated with the earliest web_event?
SELECT a.primary_poc
FROM web_events w
JOIN accounts a
ON a.id = w.account_id
ORDER BY w.occurred_at
LIMIT 1;

-- What was the smallest order placed by each account in terms of total usd. Provide only two columns - 
-- the account name and the total usd. Order from smallest dollar amounts to largest.
SELECT a.name, MIN(total_amt_usd) smallest_order
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name
ORDER BY smallest_order;

-- Find the number of sales reps in each region. Your final table should have two columns - the region and the number
--  of sales_reps. Order from the fewest reps to most reps.

--########################
-- Distinct
--########################
-- DISTINCT is always used in SELECT statements, and it provides the unique rows for all columns written in the SELECT statement. Therefore, you only use DISTINCT once in any particular SELECT statement.

-- You could write:

-- SELECT DISTINCT column1, column2, column3
-- FROM table1;
-- which would return the unique (or DISTINCT) rows across all three columns.

-- You would not write:

-- SELECT DISTINCT column1, DISTINCT column2, DISTINCT column3
-- FROM table1;
-- You can think of DISTINCT the same way you might think of the statement "unique".

-- DISTINCT - Expert Tip
-- It’s worth noting that using DISTINCT, particularly in aggregations, can slow your queries down quite a bit.


-- Query 1:
SELECT account_id,
       channel,
       COUNT(id) as events
FROM web_events
GROUP BY account_id, channel
ORDER BY account_id, channel DESC
-- Query 2:
SELECT account_id,
       channel
FROM web_events
GROUP BY account_id, channel
ORDER BY account_id
-- Query 3:
SELECT DISTINCT account_id,
       channel
FROM web_events
ORDER BY account_id

-- Use DISTINCT to test if there are any accounts associated with more than one region.

-- Have any sales reps worked on more than one account?
select distinct id, name
from accounts

-- Having
-- HAVING - Expert Tip
-- HAVING is the “clean” way to filter a query that has been aggregated, but this is also commonly done using a subquery. Essentially, any time you want to perform a WHERE on an element of your query that was created by an aggregate, you need to use HAVING instead.

-- Code from the Video
-- Query 1:
SELECT account_id,
       SUM(total_amt_usd) AS sum_total_amt_usd
FROM orders
GROUP BY 1
ORDER BY 2 DESC
-- Query 2: Results in an Error
SELECT account_id,
       SUM(total_amt_usd) AS sum_total_amt_usd
FROM orders
WHERE SUM(total_amt_usd) >= 250000
GROUP BY 1
ORDER BY 2 DESC
-- Query 3:
SELECT account_id,
       SUM(total_amt_usd) AS sum_total_amt_usd
FROM orders
GROUP BY 1
HAVING SUM(total_amt_usd) >= 250000


--Questions 

-- How many of the sales reps have more than 5 accounts that they manage?

-- How many accounts have more than 20 orders?

select account_id, sum(total)
from orders
group by account_id
having sum(total) > 20

-- Which account has the most orders?

-- Which accounts spent more than 30,000 usd total across all orders?

-- Which accounts spent less than 1,000 usd total across all orders?

-- Which account has spent the most with us?

-- Which account has spent the least with us?

-- Which accounts used facebook as a channel to contact customers more than 6 times?

-- Which account used facebook most as a channel?

-- Which channel was most frequently used by most accounts?
