
-- Question 3: Who is the top 10 customers?
-- The customer who has spent the most money will be declared the best customer.
--  Build a query that returns the person who has spent the most money.

/*Query 1*/
SELECT c.CustomerId, c.FirstName , sum(i.total) Total , sum(il.unitprice) Price
FROM customer c 
JOIN Invoice I
ON c.CustomerId = I.CustomerId
JOIN InvoiceLine Il 
on I.InvoiceId = il.InvoiceId
group by I.CustomerId
order by price DESC 
Limit 10

--It also can be solved with fewer tables by yielding the total, but be careful as this is not the needed at the end

-- Question Set 2 
-- Use your query to return the email, first name, last name, and Genre of all Rock Music listeners (Rock & Roll would be considered a 
-- different category for this exercise). Return your list ordered alphabetically by email address starting with A.
-- Check Your Solution

-- From my query, I found that all of the customers have a connection to Rock music (you could see this by looking at the original length
--  of the customers table). Your final table should have 59 rows and 4 columns (if you want to check the connection to 'Rock' music). 
--  The header of this table is provided below.

Select  c.firstname , c.lastname , c.email, G.Name
FROM Genre G 
JOIN Track T 
ON G.GenreId = T.GenreId
Join InvoiceLine Il
on Il.trackId = T.trackId
Join Invoice I 
On I.InvoiceId = il.InvoiceId
join customer c
ON c.CustomerId = I.InvoiceId
where G.name = 'Rock' or T.GenreId = 1 
group by c.Email
order by c.email

-- There is an error as it yield 36 meanwhile it supposed to show 59



