USE MUSIC_STORE;
-- 1. Who is the senior most employee based on job title? 
SELECT * FROM Employee
ORDER BY Levels DESC
LIMIT 1;

-- 2.Which countries have the most Invoices?
SELECT BillingCountry , COUNT(InvoiceId)
FROM Invoice
GROUP BY BillingCountry
ORDER BY COUNT(InvoiceId) DESC;

-- 3.What are the top 3 values of total invoice?
SELECT Total FROM Invoice 
ORDER BY Total DESC 
LIMIT 3;

-- 4.Which city has the best customers? - We would like to throw a promotional Music Festival in the city we made the most money. Write a query that returns one city that has the highest sum of invoice totals. Return both the city name & sum of all invoice totals
SELECT BillingCity ,SUM(TOTAL) AS INVOICE_TOTAL FROM invoice
GROUP BY BillingCity
ORDER BY SUM(TOTAL) DESC
LIMIT 1;

-- 5. Who is the best customer? - The customer who has spent the most money will be declared the best customer. Write a query that returns the person who has spent the most money
SELECT Customer.CustomerId, Customer.FirstName, Customer.LastName, SUM(Invoice.Total) AS TOTAL_SPENT
FROM Customer
INNER JOIN Invoice ON Customer.CustomerId = Invoice.CustomerId
GROUP BY Customer.CustomerId
ORDER BY SUM(Invoice.Total) DESC
LIMIT 1
;

-- 6.Write a query to return the email, first name, last name, & Genre of all Rock Music listeners. Return your list ordered alphabetically by email starting with A
SELECT DISTINCT Customer.Email, Customer.FirstName, Customer.LastName, Genre.Name AS GENRE
FROM Customer
INNER JOIN Invoice ON Customer.CustomerId = Invoice.CustomerId
INNER JOIN InvoiceLine ON Invoice.InvoiceId = InvoiceLine.InvoiceId
INNER JOIN Track ON InvoiceLine.TrackId = Track.TrackId
INNER JOIN Genre ON Track.GenreId = Genre.GenreId
WHERE Genre.Name = 'Rock'
ORDER BY Customer.email;

-- 7.  Let's invite the artists who have written the most rock music in our dataset. Write a query that returns the Artist name and total track count of the top 10 rock bands 
SELECT Artist.ArtistId, Artist.Name , COUNT(Track.TrackId) AS TRACK_COUNT
FROM Artist
INNER JOIN Album ON Artist.ArtistId = Album.ArtistId
INNER JOIN Track ON Album.AlbumId = Track.AlbumId
INNER JOIN Genre ON Track.GenreId = Genre.GenreId
WHERE Genre.Name = 'Rock'
GROUP BY Artist.ArtistId
ORDER BY TRACK_COUNT DESC
LIMIT 10;

-- 8. Return all the track names that have a song length longer than the average song length.- Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first
SELECT Name , Milliseconds
FROM Track
WHERE Milliseconds > (SELECT AVG(Milliseconds) FROM Track)
ORDER BY Milliseconds DESC;

-- 9. Find how much amount is spent by each customer on artists? Write a query to return customer name, artist name and total spent 
SELECT 
CONCAT(Customer.FirstName, ' ', Customer.LastName) AS CustomerName,
Artist.Name as ArtistName,
SUM(InvoiceLine.UnitPrice * InvoiceLine.Quantity) AS Expenditure
FROM Customer
JOIN Invoice ON Customer.CustomerId = Invoice.CustomerId
JOIN InvoiceLine ON Invoice.InvoiceId = InvoiceLine.InvoiceId
JOIN Track ON Track.TrackId = InvoiceLine.TrackId
JOIN Album ON Album.AlbumId = Track.AlbumId
JOIN Artist ON Artist.ArtistId = Album.ArtistId
GROUP BY Customer.CustomerId, Artist.ArtistId
ORDER BY CustomerName;


--  10.We want to find out the most popular music Genre for each country. We determine the most popular genre as the genre with the highest amount of purchases. Write a query that returns each country along with the top Genre. For countries where the maximum number of purchases is shared return all Genres
WITH Top_Genre_Per_Country AS (
SELECT 
Invoice.BillingCountry AS Country,
Genre.Name AS GenreName,
SUM(InvoiceLine.UnitPrice * InvoiceLine.Quantity) AS genre_total,
RANK() OVER (PARTITION BY Invoice.BillingCountry
ORDER BY SUM(InvoiceLine.UnitPrice * InvoiceLine.Quantity) DESC) AS rnk
FROM Genre
INNER JOIN Track ON Track.GenreId = Genre.GenreId
INNER JOIN InvoiceLine ON InvoiceLine.TrackId = Track.TrackId
INNER JOIN Invoice ON Invoice.InvoiceId = InvoiceLine.InvoiceId
GROUP BY Invoice.BillingCountry, Genre.Name
)
SELECT 
Country,
GenreName AS Most_Popular_Genre
FROM Top_Genre_Per_Country
WHERE rnk = 1
ORDER BY Country;


-- 11. Write a query that determines the customer that has spent the most on music for each country. Write a query that returns the country along with the top customer and how much they spent. For countries where the top amount spent is shared, provide all customers who spent this amount

WITH Top_Customers_by_Country AS (
SELECT 
CONCAT(Customer.FirstName, ' ', Customer.LastName) AS Customer, 
Invoice.BillingCountry AS Country, 
SUM(Invoice.Total) AS Expenditure,
RANK() OVER (PARTITION BY Invoice.BillingCountry
ORDER BY SUM(Invoice.Total) DESC) AS Rnk
FROM Invoice
INNER JOIN Customer ON Customer.CustomerId = Invoice.CustomerId
GROUP BY Invoice.BillingCountry, Customer.CustomerId, Customer
)
SELECT Country, Customer, Expenditure
FROM Top_Customers_by_Country
WHERE Rnk = 1
ORDER BY Country, Customer;


    




