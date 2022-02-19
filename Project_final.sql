
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
-----------------------------------------------------------------------------------------------------------------------------

/* Query 2 */
Select c.firstname , c.lastname , c.email, G.Name 
FROM Genre G 
JOIN Track T 
ON G.GenreId = T.GenreId
Join InvoiceLine Il
on Il.trackId = T.trackId
Join Invoice I 
On I.InvoiceId = il.InvoiceId
join customer c
ON c.CustomerId = I.CustomerId
where G.name = 'Rock' 
group by c.Email
order by c.email

-- There is an error as it yield 36 meanwhile it supposed to show 59

--another trial ,worked fine 
Select Distinct  c.firstname , c.lastname , c.email, G.Name 
FROM Genre G 
JOIN Track T 
ON G.GenreId = T.GenreId
Join InvoiceLine Il
on Il.trackId = T.trackId
Join Invoice I 
On I.InvoiceId = il.InvoiceId
join customer c
ON c.CustomerId = I.CustomerId
where G.name = 'Rock' 
--group by c.Email
order by c.email



-- More insight for the chart
Select Distinct  c.firstname , c.lastname , c.email, G.Name , count (G.Name) as preferred 
FROM Genre G 
JOIN Track T 
ON G.GenreId = T.GenreId
Join InvoiceLine Il
on Il.trackId = T.trackId
Join Invoice I 
On I.InvoiceId = il.InvoiceId
join customer c
ON c.CustomerId = I.CustomerId
group by (g.name)



---------------------------------------------------------------------------------------------------------------------------------------




-- Draw ERD
Select *
        From artist A                                    -- Album & Album ID branch
        join Album Al On A.ArtistId = Al.ArtistId

join Track t On Al.AlbumId = T.AlbumId             -- From Track it can go multiple ways
        -- To playlist
        Join playlistTrack plt On plt.trackId = t.trackId
        Join playlist pl on pl.playlistId = plt.playlistId 

        -- To Genre 
        Join Genre G On g.GenreId = t.GenreId

        --MediaType (to track not genre)
        Join MediaType Md On md.MediaTypeid = t.MediaTypeid

    -- Invoice Line (to track not mediatype)
    Join InvoiceLine Il On il.trackId = t.trackId       -- I believe it can thus be linked to (playlist track table on plt.trackID)
    
    -- Invoice
    Join Invoice I  On I.InvoiceId = il.InvoiceId

    --Customer
    join customer c ON c.CustomerId = I.CustomerId

    -- Employee
    Join Employee e  On c.supportRepId = E.EmployeeId

-- TRACK is SONG  , Album is multiple Songs



--------------------------------------------------------------------------------------------------------------------------------------
--Question 3: Who is writing the rock music?
--Now that we know that our customers love rock music, we can decide which musicians to invite to play at the concert.
-- Let's invite the artists who have written the most rock music in our dataset.
-- Write a query that returns the Artist name and total track count of the top 10 rock bands.
-- You will need to use the Genre, Track , Album, and Artist tables.

/*Query 3*/

Select  A.ArtistId ,  A.name , count(t.name)  as Songs 
From artist A                                    
join Album Al On A.ArtistId = Al.ArtistId
join Track t On Al.AlbumId = T.AlbumId         
Join Genre G On g.GenreId = t.GenreId
where g.name = 'Rock'
group by 1
order by 3  Desc 
Limit 10

/*Query 4*/

-- Question 3
-- First, find which artist has earned the most according to the InvoiceLines?

-- Now use this artist to find which customer spent the most on this artist.

-- For this query, you will need to use the Invoice, InvoiceLine, Track, Customer, Album, and Artist tables.

-- Notice, this one is tricky because the Total spent in the Invoice table might not be on a single product, 
--so you need to use the InvoiceLine table to find out how many of each product was purchased,
-- and then multiply this by the price for each artist.

-- Check Your Solution
-- The top artists according to invoice amounts are shown in the table below. The very top being Iron Maiden.

Select  A.artistid, A.name, Il.InvoiceId Il_InvoiceId , I.InvoiceId  I_InvoiceId,
		count(T.name) total_Songs, sum(T.unitprice) Songs_Price, (count(T.name) * sum(T.unitprice)) total_Songs_produced,
		count(il.Quantity) as Il_quantity,sum(il.UnitPrice) as Il_UnitPrice ,
	    (sum(il.UnitPrice) * count(il.Quantity)) as purchased_songs
       
		
		From artist A                                    
        join Album Al On A.ArtistId = Al.ArtistId
        join Track t On Al.AlbumId = T.AlbumId              
        Join InvoiceLine Il On il.trackId = t.trackId   
        Join Invoice I  On I.InvoiceId = il.InvoiceId
		group by A.artistId -- , Il.InvoiceId
		order by purchased_songs Desc

-----------------------------------------
-- Part 1
Select  A.artistid, A.name, Il.InvoiceId Il_InvoiceId , I.InvoiceId  I_InvoiceId,
		count(il.Quantity) as Il_quantity,sum(il.UnitPrice) as amount_Spent ,
	    (sum(il.UnitPrice) * count(il.Quantity)) as purchased_songs
       
		
		From artist A                                    
        join Album Al On A.ArtistId = Al.ArtistId
        join Track t On Al.AlbumId = T.AlbumId              
        Join InvoiceLine Il On il.trackId = t.trackId   
        Join Invoice I  On I.InvoiceId = il.InvoiceId
		group by A.artistId -- , Il.InvoiceId
		order by purchased_songs Desc
		limit 1


        90	Iron Maiden	39	39	140	138.6	19404.0

        
--ArtistId	Name	  Il_InvoiceId	I_InvoiceId 	Il_quantity	amount_Spent	purchased_songs

-- 90	   Iron Maiden	39	             39	        140	        138.6	        19404.0
---------------------------------------------

Select A.name Name, sum(il.UnitPrice) Amount, c.CustomerId CustomerId, c.firstname FirstName ,  c.LastName LastName -- il.InvoiceId, il.InvoiceLineId, count(il.InvoiceLineId),

		From artist A                                     
        join Album Al On A.ArtistId = Al.ArtistId
        join Track t On Al.AlbumId = T.AlbumId              
        Join InvoiceLine Il On il.trackId = t.trackId   
        Join Invoice I  On I.InvoiceId = il.InvoiceId
		join customer c ON c.CustomerId = I.CustomerId
	--where A.ArtistId = 90
	--	group by A.artistId -- , Il.InvoiceId
	--	order by purchased_songs Desc
	--	limit 1
	Where  A.ArtistId = 90
	group by  c.CustomerId
	order by Amount Desc

----------------------------------------------------------------
-- part 2
Select A.name Name, sum(il.UnitPrice) Amount, c.CustomerId CustomerId, c.firstname FirstName ,  c.LastName LastName -- il.InvoiceId, il.InvoiceLineId, count(il.InvoiceLineId),

		From artist A                                     
        join Album Al On A.ArtistId = Al.ArtistId
        join Track t On Al.AlbumId = T.AlbumId              
        Join InvoiceLine Il On il.trackId = t.trackId   
        Join Invoice I  On I.InvoiceId = il.InvoiceId
		join customer c ON c.CustomerId = I.CustomerId
	--where A.ArtistId = 90
	--	group by A.artistId -- , Il.InvoiceId
	--	order by purchased_songs Desc
	--	limit 1
	Having   A.ArtistId in ( Select  A.artistid, A.name, Il.InvoiceId Il_InvoiceId , I.InvoiceId  I_InvoiceId,
		count(il.Quantity) as Il_quantity,sum(il.UnitPrice) as amount_Spent ,
	    (sum(il.UnitPrice) * count(il.Quantity)) as purchased_songs
       
		
		From artist A                                    
        join Album Al On A.ArtistId = Al.ArtistId
        join Track t On Al.AlbumId = T.AlbumId              
        Join InvoiceLine Il On il.trackId = t.trackId   
        Join Invoice I  On I.InvoiceId = il.InvoiceId
		group by A.artistId -- , Il.InvoiceId
		order by purchased_songs Desc
		limit 1)
	group by  c.CustomerId
	order by Amount Desc

    ---------------------------

    --trial with with
    WITH average_price as
( SELECT brand_id, AVG(product_price) as brand_avg_price
  FROM product_records
),
SELECT a.brand_id, a.total_brand_sales, b.brand_avg_price
FROM brand_table a
JOIN average_price b
ON b.brand_id = a.brand_id
ORDER BY a.total_brand_sales desc;
---------------------------------------------------------------------------
    With top_artist as
(
    Select   A.name, sum(il.UnitPrice) as amount_Spent	
    From artist A                                    
    join Album Al On A.ArtistId = Al.ArtistId
    join Track t On Al.AlbumId = T.AlbumId              
    Join InvoiceLine Il On il.trackId = t.trackId   
    Join Invoice I  On I.InvoiceId = il.InvoiceId
    group by A.artistId 
    order by amount_spent Desc
    limit 1
)
Select A.name Name, sum(il.UnitPrice) Amount, c.CustomerId CustomerId, c.firstname FirstName ,  c.LastName LastName -- il.InvoiceId, il.InvoiceLineId, count(il.InvoiceLineId),

		From artist A                                     
        join Album Al On A.ArtistId = Al.ArtistId
        join Track t On Al.AlbumId = T.AlbumId              
        Join InvoiceLine Il On il.trackId = t.trackId   
        Join Invoice I  On I.InvoiceId = il.InvoiceId
		join customer c ON c.CustomerId = I.CustomerId
        join top_artist ta on ta.artistId = A.ArtistID
	--where A.ArtistId = 90
	--	group by A.artistId -- , Il.InvoiceId
	--	order by purchased_songs Desc
	--	limit 1
	Where  A.ArtistId in top_artist
	group by  c.CustomerId
	order by Amount Desc




WITH BestSellingArtist AS
(
    Select   A.ArtistId id, A.name art_name, sum(il.UnitPrice) as amount_Spent	
    From artist A                                    
    join Album Al On A.ArtistId = Al.ArtistId
    join Track t On Al.AlbumId = T.AlbumId              
    Join InvoiceLine Il On il.trackId = t.trackId   
    Join Invoice I  On I.InvoiceId = il.InvoiceId
    group by A.artistId 
    order by amount_spent Desc
    limit 1
)

Select bsa.id, a.name Name, sum(il.UnitPrice) Amount, c.CustomerId CustomerId, c.firstname FirstName ,  c.LastName LastName -- il.InvoiceId, il.InvoiceLineId, count(il.InvoiceLineId),

		From artist A                                     
        join Album Al On A.ArtistId = Al.ArtistId
        join Track t On Al.AlbumId = T.AlbumId              
        Join InvoiceLine Il On il.trackId = t.trackId   
        Join Invoice I  On I.InvoiceId = il.InvoiceId
		join customer c ON c.CustomerId = I.CustomerId
        --join top_artist ta on ta.artistId = A.ArtistID
		JOIN BestSellingArtist bsa ON bsa.ArtistId = a.ArtistId

	having  A.ArtistId in bsa.ArtistId
	group by  c.CustomerId
	order by Amount Desc








































#############################
With top_artist as
(
    Select   A.ArtistId, A.name, sum(il.UnitPrice) as amount_Spent	
    From artist A                                    
    join Album Al On A.ArtistId = Al.ArtistId
    join Track t On Al.AlbumId = T.AlbumId              
    Join InvoiceLine Il On il.trackId = t.trackId   
    Join Invoice I  On I.InvoiceId = il.InvoiceId
    group by A.artistId 
    order by amount_spent Desc
    limit 1
)

Select ta.name Name, sum(il.UnitPrice) Amount, c.CustomerId CustomerId, c.firstname FirstName ,  c.LastName LastName -- il.InvoiceId, il.InvoiceLineId, count(il.InvoiceLineId),

		From artist A                                     
        join Album Al On A.ArtistId = Al.ArtistId
        join Track t On Al.AlbumId = T.AlbumId              
        Join InvoiceLine Il On il.trackId = t.trackId   
        Join Invoice I  On I.InvoiceId = il.InvoiceId
		join customer c ON c.CustomerId = I.CustomerId
        join top_artist ta on ta.artistId = A.ArtistID

	Where  A.ArtistId in ta.ArtistId
	group by  c.CustomerId
	order by Amount Desc