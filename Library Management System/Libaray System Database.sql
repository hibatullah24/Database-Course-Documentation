CREATE DATABASE LibararyDB;
USE LibararyDB;


-- ADD ALL TABLES:

CREATE TABLE Libarary(
LibararyID INT IDENTITY(1,1) PRIMARY KEY,
Name NVARCHAR(50) NOT NULL UNIQUE,
Location VARCHAR(150) NOT NULL,
ContactNumber NVARCHAR(30) NOT NULL,
EstablishedYear INT NULL,
);


CREATE TABLE Member(
MemberID INT IDENTITY (1,1) PRIMARY KEY,
FullName NVARCHAR(120) NULL,
Email NVARCHAR (90) NOT NULL UNIQUE,
PhoneNumber NVARCHAR(30) NULL,
MembershipStartDate DATE NOT NULL

);

CREATE TABLE Book(
BookID INT IDENTITY (1,1) PRIMARY KEY,
ISBN NVARCHAR(50) NOT NULL UNIQUE,
Title NVARCHAR(200) NOT NULL,
Genre NVARCHAR(20) NOT NULL  CHECK (Genre IN ('Faction', 'Non-fiction','Reference','Children')),
Price DECIMAL (10,2) NOT NULL CHECK (Price>0),
IsAvailable BIT NOT NULL DEFAULT (1),
ShelfLocation NVARCHAR(50) NOT NULL,
LibraryID INT NOT NULL REFERENCES Libarary(LibararyID)
ON DELETE CASCADE
ON UPDATE CASCADE
);

CREATE TABLE Staff(
StaffID INT IDENTITY (1,1) PRIMARY KEY,
FullName NVARCHAR(120) NULL,
Position NVARCHAR(80) NULL,
ContactNumber NVARCHAR(30) NOT NULL,
LibararyID INT NOT NULL REFERENCES Libarary( LibararyID)
ON DELETE CASCADE
ON UPDATE CASCADE

);

CREATE TABLE Loan(
LoanID INT IDENTITY(1,1) PRIMARY KEY,
LoanDate DATE NOT NULL,
DueDate DATE NOT NULL,
ReturnDate DATE NULL,
Status NVARCHAR(20) NOT NULL DEFAULT ('Issued')
CHECK (Status IN ('Issued', 'Returned', 'Overdue')),

MemberID INT NOT NULL REFERENCES Member(MemberID)
ON DELETE CASCADE
ON UPDATE CASCADE,

BookID INT  NOT NULL REFERENCES Book(BookID)
ON DELETE CASCADE
ON UPDATE CASCADE

);

CREATE TABLE Payment(
PaymentID INT IDENTITY(1,1) PRIMARY KEY,
PaymentDate DATE NOT NULL,
Amount DECIMAL(10,2) NOT NULL CHECK(Amount>0),
Method NVARCHAR(30) NULL,
LoanID INT NOT NULL
 REFERENCES .Loan(LoanID)
 ON DELETE CASCADE
 ON UPDATE CASCADE

);

CREATE TABLE Review(
ReviewID INT IDENTITY (1,1) PRIMARY KEY,
Rating INT NOT NULL CHECK (Rating BETWEEN 1 AND 5),
Comments NVARCHAR(500) NOT NULL DEFAULT ('No comments'),
ReviewDate DATE NOT NULL,
MemberID INT NOT NULL
 REFERENCES Member(MemberID)
 ON DELETE CASCADE
 ON UPDATE CASCADE,
 BookID     INT NOT NULL
  REFERENCES Book(BookID)
  ON DELETE CASCADE
  ON UPDATE CASCADE
);

ALTER TABLE Loan
ADD CHECK (ReturnDate IS NULL OR ReturnDate >= LoanDate);

-- INSERT DATA 

INSERT INTO Libarary (Name, Location, ContactNumber, EstablishedYear)
VALUES
('Central Libarary', 'Muscat', '24567890', 2005),
('City Libaray', 'Salalah', '23234567', 2010);



INSERT INTO  Member (FullName, Email, PhoneNumber, MembershipStartDate)
VALUES
('Ali Ahmed', 'ali@gmail.com', '91672576', '2023-01-15'),
('Fatma Said', 'fatma@gmail.com', '92345678', '2023-03-10');


INSERT INTO Book (ISBN, Title, Genre, Price, ShelfLocation, LibraryID)
VALUES
('978-1111111111', 'Database Systems', 'Reference', 25.00, 'A1', 1),
('978-2222222222', 'Python Basics', 'Non-fiction', 18.50, 'B2', 1),
('978-3333333333', 'Children Stories', 'Children', 12.00, 'C3', 2);


INSERT INTO Staff (FullName, Position, ContactNumber, LibararyID)
VALUES
('Ahmed Salim', 'Librarian', '91112233', 1),
('Sara Khalid', 'Assistant', '92223344', 2);

INSERT INTO Loan (LoanDate, DueDate, Status, MemberID, BookID)
VALUES
('2024-05-01', '2024-05-15', 'Issued', 1, 1),
('2024-05-03', '2024-05-17', 'Returned', 2, 2);

INSERT INTO Payment (PaymentDate, Amount, Method, LoanID)
VALUES
('2024-05-20', 5.00, 'Cash', 2);

INSERT INTO Review (Rating, ReviewDate, MemberID, BookID)
VALUES
(5, '2024-05-10', 1, 1),
(4, '2024-05-12', 2, 2);

--CHECK DATA 
SELECT * FROM Libarary;
SELECT * FROM Member;
SELECT * FROM Book;
SELECT * FROM Staff;
SELECT * FROM Loan;
SELECT * FROM Payment;
SELECT * FROM Review;

