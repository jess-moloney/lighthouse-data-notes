/* SQL Exercise
====================================================================
We will be working with database chinook.db
You can download it here: https://drive.google.com/file/d/0Bz9_0VdXvv9bWUtqM0NBYzhKZ3c/view?usp=sharing&resourcekey=0-7zGUhDz0APEfX58SA8UKog

 The Chinook Database is about an imaginary video and music store. Each track is stored using one of the digital formats and has a genre. The store has also some playlists, where a single track can be part of several playlists. Orders are recorded for customers, but are called invoices. Every customer is assigned a support employee, and Employees report to other employees.
*/


-- MAKE YOURSELF FAIMLIAR WITH THE DATABASE AND TABLES HERE





--==================================================================
/* TASK I
Which artists did not make any albums at all? Include their names in your answer.
*/
SELECT Name from artists
LEFT OUTER JOIN albums
ON artists.Artistid = albums.Artistid
GROUP BY Name
HAVING Count(albums.Title) = 0;

/*SELECT Count(Name) from artists
LEFT OUTER JOIN albums
ON artists.ArtistId = albums.ArtistId
WHERE albums.AlbumId IS NULL;*/


/* TASK II
Which artists recorded any tracks of the Latin genre?
*/
SELECT artists.Name from artists
JOIN albums
ON artists.ArtistId = albums.ArtistId
JOIN tracks
ON albums.AlbumId = tracks.AlbumId
JOIN genres
ON tracks.GenreId = genres.GenreId
WHERE tracks.GenreId IN (SELECT GenreId FROM genres WHERE genres.Name = 'Latin')
GROUP BY artists.Name;

/* TASK III
Which video track has the longest length? Occupation / Precipice
*/
SELECT * FROM media_types;

SELECT Name, Milliseconds FROM tracks
WHERE MediaTypeId = 3
ORDER BY Milliseconds DESC
LIMIT 1;

/* TASK IV
Find the names of customers who live in the same city as the top employee (The one not managed by anyone).
*/

SELECT customers.FirstName, customers.LastName FROM customers
JOIN employees
ON customers.SupportRepId = employees.EmployeeId
WHERE customers.City IN
(SELECT employees.City FROM employees
WHERE employees.EmployeeId in
(SELECT employees.EmployeeId FROM employees
WHERE employees.ReportsTo IS NULL));

/* TASK V
Find the managers of employees supporting Brazilian customers.
*/

SELECT employees.FirstName, employees.LastName FROM employees
JOIN customers
ON employees.EmployeeId = customers.CustomerId
WHERE ReportsTo IN (SELECT ReportsTo FROM employees
WHERE customers.Country = 'Brazil');

/*SELECT employees.FirstName, employees.LastName, ReportsTo FROM employees
LEFT OUTER JOIN customers
ON employees.EmployeeId = customers.CustomerId
WHERE customers.Country = 'Brazil';*/

/* TASK VI
Which playlists have no Latin tracks?
*/

SELECT playlists.Name FROM playlists
JOIN playlist_track
ON playlists.PlaylistId = playlist_track.PlaylistId
JOIN tracks
ON playlist_track.TrackId = tracks.TrackId
WHERE playlist_track.TrackId NOT IN
(SELECT tracks.TrackId FROM tracks
LEFT OUTER JOIN genres
ON tracks.GenreId = genres.GenreId
WHERE genres.Name = 'Latin')
GROUP BY playlists.Name;


