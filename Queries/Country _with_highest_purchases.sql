Select  c.Country , sum(il.UnitPrice) Purchasing_Amount, c.CustomerId CustomerId 
		From artist A                                     
        join Album Al On A.ArtistId = Al.ArtistId
        join Track t On Al.AlbumId = T.AlbumId              
        Join InvoiceLine Il On il.trackId = t.trackId   
        Join Invoice I  On I.InvoiceId = il.InvoiceId
		join customer c ON c.CustomerId = I.CustomerId
	group by  c.country
	order by Purchasing_Amount Desc
  Limit 10