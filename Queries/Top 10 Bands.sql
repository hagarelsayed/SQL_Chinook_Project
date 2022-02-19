/* Query 3 */

Select  A.ArtistId ,  A.name , count(t.name)  as Songs -- * -- count(*)--A.ArtistId , A.name , count(t.track)
From artist A                                    -- Album & Album ID branch
join Album Al On A.ArtistId = Al.ArtistId
join Track t On Al.AlbumId = T.AlbumId         
Join Genre G On g.GenreId = t.GenreId
where g.name = 'Rock'
group by 1
order by 3  Desc 
Limit 10


