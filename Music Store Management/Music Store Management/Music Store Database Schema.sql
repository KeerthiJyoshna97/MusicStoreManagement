CREATE DATABASE MUSIC_STORE;
USE MUSIC_STORE;

-- 1. Genre and MediaType
CREATE TABLE Genre (
    GenreId INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(120)
);

CREATE TABLE MediaType (
    MediaTypeId INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(120)
);

-- 2. Employee
CREATE TABLE Employee (
    EmployeeId INT PRIMARY KEY AUTO_INCREMENT,
    LastName VARCHAR(120),
    FirstName VARCHAR(120),
    Title VARCHAR(120),
    ReportsTo INT,
    Levels VARCHAR(10),
    BirthDate DATE,
    HireDate DATE,
    Address VARCHAR(255),
    City VARCHAR(100),
    State VARCHAR(100),
    Country VARCHAR(100),
    PostalCode VARCHAR(20),
    Phone VARCHAR(50),
    Fax VARCHAR(50),
    Email VARCHAR(100)
);

-- 3. Customer
CREATE TABLE Customer (
    CustomerId INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(120),
    LastName VARCHAR(120),
    Company VARCHAR(120),
    Address VARCHAR(255),
    City VARCHAR(100),
    State VARCHAR(100),
    Country VARCHAR(100),
    PostalCode VARCHAR(20),
    Phone VARCHAR(50),
    Fax VARCHAR(50),
    Email VARCHAR(100),
    SupportRepId INT,
    FOREIGN KEY (SupportRepId) REFERENCES Employee(EmployeeId) ON DELETE CASCADE ON UPDATE CASCADE
);

-- 4. Artist
CREATE TABLE Artist (
    ArtistId INT PRIMARY KEY  AUTO_INCREMENT,
    Name VARCHAR(120)
);

-- 5. Album
CREATE TABLE Album (
    AlbumId INT PRIMARY KEY AUTO_INCREMENT,
    Title VARCHAR(160),
    ArtistId INT,
    FOREIGN KEY (ArtistId) REFERENCES Artist(ArtistId) ON DELETE CASCADE ON UPDATE CASCADE
);

-- 6. Track
CREATE TABLE Track (
    TrackId INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(200),
    AlbumId INT,
    MediaTypeId INT,
    GenreId INT,
    Composer VARCHAR(220),
    Milliseconds INT,
    Bytes INT,
    UnitPrice DECIMAL(10,2),
    FOREIGN KEY (AlbumId) REFERENCES Album(AlbumId) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (MediaTypeId) REFERENCES MediaType(MediaTypeId) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (GenreId) REFERENCES Genre(GenreId) ON DELETE CASCADE ON UPDATE CASCADE
);

-- 7. Invoice
CREATE TABLE Invoice (
    InvoiceId INT PRIMARY KEY AUTO_INCREMENT,
    CustomerId INT,
    InvoiceDate DATE,
    BillingAddress VARCHAR(255),
    BillingCity VARCHAR(100),
    BillingState VARCHAR(100),
    BillingCountry VARCHAR(100),
    BillingPostalCode VARCHAR(20),
    Total DECIMAL(10,2),
    FOREIGN KEY (CustomerId) REFERENCES Customer(CustomerId) ON DELETE CASCADE ON UPDATE CASCADE
);

-- 8. InvoiceLine
CREATE TABLE InvoiceLine (
    InvoiceLineId INT PRIMARY KEY AUTO_INCREMENT,
    InvoiceId INT,
    TrackId INT,
    UnitPrice DECIMAL(10,2),
    Quantity INT,
    FOREIGN KEY (InvoiceId) REFERENCES Invoice(InvoiceId) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (TrackId) REFERENCES Track(TrackId) ON DELETE CASCADE ON UPDATE CASCADE
);

-- 9. Playlist
CREATE TABLE Playlist (
    PlaylistId INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(255)
);

-- 10. PlaylistTrack
CREATE TABLE PlaylistTrack (
    PlaylistId INT,
    TrackId INT,
    PRIMARY KEY (PlaylistId, TrackId),
    FOREIGN KEY (PlaylistId) REFERENCES Playlist(PlaylistId) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (TrackId) REFERENCES Track(TrackId) ON DELETE CASCADE ON UPDATE CASCADE
);










