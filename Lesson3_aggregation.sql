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
standard_qty,
standard_amt_usd/standard_qty as amt_per_qty_unit
from orders
where standard_qty > 0

-- right answer
SELECT SUM(standard_amt_usd)/SUM(standard_qty) AS standard_price_per_unit
FROM orders;