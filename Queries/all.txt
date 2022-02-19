/*Query 1*/

SELECT c.CustomerId,
       c.FirstName,
       sum(i.total) Total,
       sum(il.unitprice) Price
FROM customer c
JOIN Invoice I ON c.CustomerId = I.CustomerId
JOIN InvoiceLine Il ON I.InvoiceId = il.InvoiceId
GROUP BY I.CustomerId
ORDER BY price DESC
LIMIT 10


/* Query 2 */

SELECT A.ArtistId,
       A.name,
       count(t.name) AS Songs
FROM artist A
JOIN Album Al ON A.ArtistId = Al.ArtistId
JOIN Track t ON Al.AlbumId = T.AlbumId
JOIN Genre G ON g.GenreId = t.GenreId
WHERE g.name = 'Rock'
GROUP BY 1
ORDER BY 3 DESC
LIMIT 10

/* Query 3 */

SELECT A.artistid,
       A.name ,
       count(il.Quantity) AS Il_quantity,
       sum(il.UnitPrice) AS Amount_Spent,
       (sum(il.UnitPrice) * count(il.Quantity)) AS Purchased_songs
FROM artist A
JOIN Album Al ON A.ArtistId = Al.ArtistId
JOIN Track t ON Al.AlbumId = T.AlbumId
JOIN InvoiceLine Il ON il.trackId = t.trackId
JOIN Invoice I ON I.InvoiceId = il.InvoiceId
GROUP BY A.artistId
ORDER BY purchased_songs DESC
LIMIT 10

/* Query 4 */

SELECT c.Country,
       sum(il.UnitPrice) Purchasing_Amount,
       c.CustomerId CustomerId
FROM artist A
JOIN Album Al ON A.ArtistId = Al.ArtistId
JOIN Track t ON Al.AlbumId = T.AlbumId
JOIN InvoiceLine Il ON il.trackId = t.trackId
JOIN Invoice I ON I.InvoiceId = il.InvoiceId
JOIN customer c ON c.CustomerId = I.CustomerId
GROUP BY c.country
ORDER BY Purchasing_Amount DESC
LIMIT 10