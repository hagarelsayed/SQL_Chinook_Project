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


select BillingCountry , sum(total) 
from invoice
group by BillingCountry
order by BillingCountry  
