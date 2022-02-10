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
