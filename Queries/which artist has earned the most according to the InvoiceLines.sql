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

--ArtistId	Name	  Il_InvoiceId	I_InvoiceId 	Il_quantity	amount_Spent	purchased_songs

-- 90	   Iron Maiden	39	             39	        140	        138.6	        19404.0

Select c.CustomerId, il.InvoiceId, il.InvoiceLineId, count(il.InvoiceLineId),
        sum(il.UnitPrice) Amount 
		--(sum(il.UnitPrice) * count(il.Quantity) * ) purchased_songs,

		-- A.artistid, A.name, Il.InvoiceId Il_InvoiceId , I.InvoiceId  I_InvoiceId,
		--count(il.Quantity) as Il_quantity,sum(il.UnitPrice) as amount_Spent ,
	   -- (sum(il.UnitPrice) * count(il.Quantity)) as purchased_songs
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
	Where (c.CustomerId = 55 or c.CustomerId = 35 or c.CustomerId = 16 or c.CustomerId =36 or c.CustomerId = 5  ) and A.ArtistId = 90
	group by  1
	order by Amount Desc


------------------------------------------------------------------------------------------
    Select c.CustomerId, il.InvoiceId, il.InvoiceLineId, count(il.InvoiceLineId),
        sum(il.UnitPrice) Amount 

		From ( Select  A.artistid, A.name, Il.InvoiceId Il_InvoiceId , I.InvoiceId  I_InvoiceId,
		count(il.Quantity) as Il_quantity,sum(il.UnitPrice) as amount_Spent ,
	    (sum(il.UnitPrice) * count(il.Quantity)) as purchased_songs
       
		
		From artist A                                    
        join Album Al On A.ArtistId = Al.ArtistId
        join Track t On Al.AlbumId = T.AlbumId              
        Join InvoiceLine Il On il.trackId = t.trackId   
        Join Invoice I  On I.InvoiceId = il.InvoiceId
		group by A.artistId -- , Il.InvoiceId
		order by purchased_songs Desc
		limit 1) as artist A 
		Join artist A                                    
        join Album Al On A.ArtistId = Al.ArtistId
        join Track t On Al.AlbumId = T.AlbumId              
        Join InvoiceLine Il On il.trackId = t.trackId   
        Join Invoice I  On I.InvoiceId = il.InvoiceId
		join customer c ON c.CustomerId = I.CustomerId
	--where A.ArtistId = 90
	--	group by A.artistId -- , Il.InvoiceId
	--	order by purchased_songs Desc
	--	limit 1
	Where (c.CustomerId = 55 or c.CustomerId = 35 or c.CustomerId = 16 or c.CustomerId =36 or c.CustomerId = 5  ) and A.ArtistId = 90
	group by  1
	order by Amount Desc

