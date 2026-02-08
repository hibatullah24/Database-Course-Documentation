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
('City Libaray', 'Salalah', '23234567', 2010),
('North Library', 'Sohar', '26891234', 2008),
('South Library', 'Nizwa', '25431298', 2012),
('East Library', 'Sur', '25561234', 2015),
('West Library', 'Ibri', '25678901', 2007),
('University Library', 'Muscat', '24123456', 2000),
('Public Library', 'Barka', '24567891', 2018),
('Children Library', 'Rustaq', '26677889', 2016),
('Digital Library', 'Muscat', '24445566', 2020);



INSERT INTO  Member (FullName, Email, PhoneNumber, MembershipStartDate)
VALUES
('Ali Ahmed', 'ali@gmail.com', '91672576', '2023-01-15'),
('Fatma Said', 'fatma@gmail.com', '92345678', '2023-03-10'),
('Salim Noor', 'salim@gmail.com', '91112233', '2023-02-20'),
('Aisha Khalid', 'aisha@gmail.com', '92223344', '2023-04-05'),
('Hassan Omar', 'hassan@gmail.com', '93334455', '2023-05-01'),
('Muna Rashid', 'muna@gmail.com', '94445566', '2023-06-12'),
('Yousef Ali', 'yousef@gmail.com', '95556677', '2023-07-18'),
('Sara Mohammed', 'sara@gmail.com', '96667788', '2023-08-22'),
('Khalid Salem', 'khalid@gmail.com', '97778899', '2023-09-30'),
('Noor Hamad', 'noor@gmail.com', '98889900', '2023-10-10');


INSERT INTO Book (ISBN, Title, Genre, Price, ShelfLocation, LibraryId)
VALUES
('978-1111111112', 'Database Systems Vol 2', 'Reference', 27.00, 'A1-2', 1),
('978-2222222223', 'Advanced Python', 'Non-fiction', 21.00, 'B2-2', 1),
('978-3333333334', 'More Children Stories', 'Children', 13.00, 'C3-2', 2),
('978-4444444445', 'SQL Guide Advanced', 'Reference', 33.00, 'A2-2', 3),
('978-5555555556', 'Web Development Pro', 'Non-fiction', 25.00, 'B3-2', 4),
('978-6666666667', 'Fairy Tales 2', 'Children', 11.00, 'C1-2', 5),
('978-7777777778', 'Data Science Advanced', 'Non-fiction', 30.00, 'B1-2', 6),
('978-8888888889', 'Algorithms II', 'Reference', 38.00, 'A3-2', 7),
('978-9999999998', 'Story Book 2', 'Children', 10.00, 'C2-2', 8),
('978-1010101011', 'AI Basics Advanced', 'Non-fiction', 29.00, 'B4-2', 9),
 SELECT * FROM Book;



INSERT INTO Staff (FullName, Position, ContactNumber, LibararyID)
VALUES
('Ahmed Salim', 'Librarian', '91112233', 1),
('Sara Khalid', 'Assistant', '92223344', 2),
('Mohammed Ali', 'Manager', '93334455', 3),
('Huda Said', 'Assistant', '94445566', 4),
('Khalid Noor', 'Librarian', '95556677', 5),
('Amina Rashid', 'Assistant', '96667788', 6),
('Salem Ahmed', 'Manager', '97778899', 7),
('Noor Ali', 'Assistant', '98889900', 8),
('Faisal Omar', 'Librarian', '99990011', 9),
('Maha Hassan', 'Assistant', '90001122', 10);

INSERT INTO Loan (LoanDate, DueDate, Status, MemberID, BookID)
VALUES
('2024-05-01', '2024-05-15', 'Issued', 1, 1),
('2024-05-03', '2024-05-17', 'Returned', 2, 2),
('2024-05-05', '2024-05-19', 'Overdue', 3, 3),
('2024-05-06', '2024-05-20', 'Issued', 4, 4),
('2024-05-07', '2024-05-21', 'Returned', 5, 5),
('2024-05-08', '2024-05-22', 'Issued', 6, 6),
('2024-05-09', '2024-05-23', 'Overdue', 7, 7),
('2024-05-10', '2024-05-24', 'Issued', 8, 8),
('2024-05-11', '2024-05-25', 'Returned', 9, 9),
('2024-05-12', '2024-05-26', 'Issued', 10, 10);

INSERT INTO Payment (PaymentDate, Amount, Method, LoanID)
VALUES
('2024-05-20', 5.00, 'Cash', 2),
('2024-05-21', 3.00, 'Card', 3),
('2024-05-22', 7.00, 'Cash', 3),
('2024-05-23', 2.50, 'Card', 5),
('2024-05-24', 6.00, 'Cash', 7),
('2024-05-25', 4.00, 'Card', 7),
('2024-05-26', 8.00, 'Cash', 9),
('2024-05-27', 1.50, 'Card', 9),
('2024-05-28', 5.50, 'Cash', 10),
('2024-05-29', 3.75, 'Card', 10);


INSERT INTO Review (Rating, ReviewDate, MemberID, BookID)
VALUES
(5, '2024-05-10', 1, 1),
(4, '2024-05-12', 2, 2),
(3, '2024-05-12', 3, 3),
(5, '2024-05-13', 4, 4),
(4, '2024-05-14', 5, 5),
(5, '2024-05-15', 6, 6),
(3, '2024-05-16', 7, 7),
(4, '2024-05-17', 8, 8),
(5, '2024-05-18', 9, 9),
(4, '2024-05-19', 10, 10);



-- Task 1.1
SELECT * FROM Libarary;

--Task1.2
SELECT * FROM Member;

--Task 1.3
SELECT * FROM Book;

-- Task 2.1
SELECT Name, Location FROM Libarary;

-- Task 2.2
SELECT Title, Genre, Price FROM Book;

-- Task 2.3
SELECT FullName, Email FROM Member;

--Task 2.4
SELECT StaffID, FullName, Position FROM Staff;

-- Task 3.1
SELECT * FROM Book
WHERE Genre = 'Non-Fiction';

--Task 3.2
SELECT * FROM Libarary
WHERE Location = 'Muscat';

-- Task 3.3
SELECT * FROM Book
WHERE IsAvailable = 1;

-- Task 3.4
SELECT * FROM Staff
WHERE Position = 'Librarian';

-- Task 3.5
SELECT * FROM Loan
WHERE Status = 'Overdue';

-- Task4.1
SELECT * FROM Book
WHERE Price>20;

-- Task 4.2
SELECT * FROM Libarary
WHERE EstablishedYear <2010;

-- Task 4.3
SELECT * FROM Payment
WHERE Amount >= 5;

-- Task 4.4
SELECT * FROM Book
WHERE Price <= 15;

-- Task 4.5
SELECT * FROM Review
WHERE Rating !=5;

-- Task 5.1: 
SELECT * FROM Book
WHERE IsAvailable =1 AND Genre = 'Non-Fiction';

-- Task 5.2
SELECT * FROM Book
WHERE Genre='Non-Fiction' OR Genre='Children';

-- Task 5.3
SELECT * FROM Libarary
WHERE EstablishedYear > 2010 AND Location = 'Muscat';

-- Task 5.4
SELECT * FROM Book
WHERE Price >= 10 AND Price <= 30;

-- Task 5.5
SELECT * FROM Loan
WHERE Status NOT IN ( 'returned'); 


-- Task 6.1
SELECT * FROM Book
ORDER BY Title ASC;

-- Task 6.2
SELECT * FROM Book
ORDER BY Price DESC;

-- Task 6.3
SELECT * FROM Member
ORDER BY MembershipStartDate DESC;

-- Task 6.4 
SELECT * FROM Libarary
ORDER BY EstablishedYear ASC;

-- Task 6.5
SELECT * FROM Review
ORDER BY Rating DESC , ReviewDate ASC;
