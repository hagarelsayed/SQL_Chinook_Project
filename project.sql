/* The following is the SQL project

Question 1: Which countries have the most Invoices?
Use the Invoice table to determine the countries that have the most invoices. 
Provide a table of BillingCountry and Invoices ordered by the number of invoices for each country. 
The country with the most invoices should appear first.

Check Your Solution
Your solution should have 2 columns and 24 rows. The below image shows a header of your ending table.
 The Invoices columns in a count of the number of invoices for each country. It should be sorted from
  most to least. */ 
select  BillingCountry, count(InvoiceDate) as Invoices
from invoice
group by BillingCountry
order by Invoices Desc;

/*Question 2: Which city has the best customers?
We want to throw a promotional Music Festival in the city we made the most money. 
Write a query that returns the 1 city that has the highest sum of invoice totals. 
Return both the city name and the sum of all invoice totals.*/

-- The top city for Invoice dollars was Prague, with an amount of 90.24.



select BillingCountry , sum(total) 
from invoice
group by BillingCountry
order by BillingCountry  


-- Question 3: Who is the best customer?
-- The customer who has spent the most money will be declared the best customer.
--  Build a query that returns the person who has spent the most money.



-----------------
-- My Questions--
-----------------
--Question 1 , part a
-- -- Who is the most recent fresh employee? 
select e.EmployeeId, e.LastName, e.FirstName,  max(e.hiredate ) as latest_joined_empl
from Employee e

-- Answer: 3	Peacock	Jane	2002-04-01 00:00:00

-- another Solution without aggregation function
select e.EmployeeId, e.LastName, e.FirstName,  e.hiredate 
from Employee e
order by e.hiredate 
limit 1 

--Question 1 , part b

-- Who is the latest?
select e.EmployeeId, e.LastName, e.FirstName,  min(e.hiredate ) as earliest_joined_empl
from Employee e

-- another Solution without aggregation function
select e.EmployeeId, e.LastName, e.FirstName,  e.hiredate 
from Employee e
order by e.hiredate Desc
limit 1 

--Answer:  8	Callahan	Laura	2004-03-04 00:00:00
--###############################################


-- find the total albums for each artist. You should include two columns - the total albums for each
--  artist and the artist name.

select ar.name, count(al.)
from album al
JOIN artist ar 
on ar.id = al.ArtistID
group by ar.name

-- Find the top three atristis with the highest number of albums. Your results should have two columns , one for the 
--artist name and the other for the total number of albums, as well as three rows for the highest number of albums.

select ar.name, count(al.Title) Album_Number
from album al
JOIN artist ar 
on ar.ArtistID = al.ArtistID
group by ar.name
order by Album_number DESC
limit 3




-- So the key for this question is understanding that one country could have multiple values if more than one customer in this country have the maximum value in this country. To solve it:
--  Calculate the maximum value for a customer for each country
--  Calculate the total for each user in each country
--  Check if the total for the customer in the country is equal to the max for the country.

-- Please not that the code below can be done in a more efficient way bit this is a detailed code with the steps above fore clarity.
 WITH max_val AS
 (SELECT t.country, MAX(mVal) AS maxim
 FROM
 (SELECT c.country, c.CustomerId, SUM(i.Total) as mVal
 FROM Customer c
 JOIN Invoice i
 ON c.CustomerId = i.CustomerId
 GROUP BY 1, 2) AS t
 GROUP BY 1)
 
 
 SELECT *
 FROM max_val m
 JOIN
 (SELECT c.country, SUM(i.Total) as tVal, c.FirstName, c.LastName, c.CustomerId
 FROM Customer c
 JOIN Invoice i
 ON c.CustomerId = i.CustomerId
 GROUP BY 1, 5) AS table_val
 ON table_val.country = m.Country
 WHERE tVal = m.maxim
