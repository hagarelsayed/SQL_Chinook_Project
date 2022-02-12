/*As we've learned, the SELECT clause indicates which column(s) of data you'd like to see in the output
 (For Example, orders.* gives us all the columns in the orders table in the output). The FROM clause 
 indicates the first table from which we're pulling data, and the JOIN indicates the second table. 
 The ON clause specifies the column on which you'd like to merge the two tables together. Try running 
 this query yourself below. */

SELECT orders.*,
       accounts.*
FROM orders 
JOIN accounts
ON orders.account_id = accounts.id;

SELECT orders.*, accounts.*
FROM accounts
JOIN orders
ON accounts.id = orders.account_id;
/*Notice this result is the same as if you switched the tables in the FROM and JOIN. 
Additionally, which side of the = a column is listed doesn't matter.*/

SELECT orders.standard_qty, orders.gloss_qty, 
 orders.poster_qty,  accounts.website, 
 accounts.primary_poc
FROM orders
JOIN accounts
ON orders.account_id = accounts.id

/*Notice that we need to specify every table a column comes from in the SELECT statement. */                          

-- When we JOIN tables together, it is nice to give each table an alias. Frequently an alias is just the first letter of the table name. You actually saw something similar for column names in the Arithmetic Operators concept.

-- Example:

FROM tablename AS t1
JOIN tablename2 AS t2
-- Before, you saw something like:

SELECT col1 + col2 AS total, col3
-- Frequently, you might also see these statements without the AS statement. Each of the above could be written in the following way instead, and they would still produce the exact same results:

FROM tablename t1
JOIN tablename2 t2
-- and

SELECT col1 + col2 total, col3

-- Aliases for Columns in Resulting Table
-- While aliasing tables is the most common use case. It can also be used to alias the columns selected to have the resulting table reflect a more readable name.

-- Example:

Select t1.column1 aliasname, t2.column2 aliasname2
FROM tablename AS t1
JOIN tablename2 AS t2
-- The alias name fields will be what shows up in the returned table instead of t1.column1 and t2.column2

aliasname	aliasname2
example row	example row
example row	example row
-- If you have two or more columns in your SELECT that have the same name after the table name such as accounts.name and sales_reps.name you will need to alias them. Otherwise it will only show one of the columns. You can alias them like accounts.name AS AcountName, sales_rep.name AS SalesRepName

SELECT o.*, a.*
FROM orders o
JOIN accounts a
ON o.account_id = a.id

-- Questionssss
-- Provide a table for all web_events associated with the account name of Walmart.
--  There should be three columns. Be sure to include the primary_poc, time of the 
--  event, and the channel for each event. Additionally, you might choose to add a
--   fourth column to assure only Walmart events were chosen.

select acc.name, acc.primary_poc, w.channel, w.occurred_at
from accounts as acc
join web_events as w
on acc.id = w.account_id
where acc.name = 'Walmart'

-- Provide a table that provides the region for each sales_rep along with their
--  associated accounts. Your final table should include three columns: the region name, 
--  the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) 
--  according to the account name.
select  s.name, s.region_id
from accounts as acc
join sales_reps as s

on acc.sales_rep_id = s.id
order by acc.name   -- Please check this answer


--Provide the name for each region for every order, as well as the account name and 
-- the unit price they paid (total_amt_usd/total) for the order. Your final table should
--  have 3 columns: region name, account name, and unit price. A few accounts have 0 for 
--  total, so I divided by (total + 0.01) to assure not dividing by zero.

select *, (orders.total_amt_usd/(orders.total+0.01))
from orders
join region
on orders.account_id = region.id

SELECT r.name region, a.name account, 
    o.total_amt_usd/(o.total + 0.01) unit_price
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id;
-- my solution
select r.name as region, a.name as account, o.total_amt_usd/(o.total+0.01) as unit_price
from region r
join sales_reps s
on s.region_id = r.id
  join accounts a
    on a.sales_rep_id = s.id
      join orders o
       on o.account_id = a.id 

-- Expert Tip
-- You have had a bit of an introduction to these one-to-one and one-to-many relationships when we introduced PKs and FKs. Notice, traditional databases do not allow for many-to-many relationships, as these break the schema down pretty quickly. A very good answer is provided here.

-- The types of relationships that exist in a database matter less to analysts, but you do need to understand why you would perform different types of JOINs, and what data you are pulling from the database. These ideas will be expanded upon in the next concepts.

-- left Join

-- Notice each of these new JOIN statements pulls all the same rows as an INNER JOIN, which you saw by just using JOIN, but they also potentially pull some additional rows.

-- If there is not matching information in the JOINed table, then you will have columns with empty cells. These empty cells introduce a new data type called NULL. You will learn about NULLs in detail in the next lesson, but for now you have a quick introduction as you can consider any cell without data as NULL.

SELECT a.id, a.name, o.total
FROM orders o -- the table on the left with many rows to add
LEFT JOIN accounts a -- the table on the right
ON o.account_id = a.id

