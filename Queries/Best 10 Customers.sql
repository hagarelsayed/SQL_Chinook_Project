
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