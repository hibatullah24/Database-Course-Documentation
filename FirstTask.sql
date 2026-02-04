CREATE DATABASE TrainingCenterDB
USE TrainingCenterDB

CREATE TABLE Trainee(
T_ID INT IDENTITY(1,1)  PRIMARY KEY,
Full_Name VARCHAR(100) NOT NULL,
Email VARCHAR(1000) UNIQUE,
Phone NVARCHAR(20),
DateBirth DATE,
Gender CHAR(1),
RegestrationDate DATE DEFAULT GETDATE()

);
SELECT *FROM Trainee;

CREATE TABLE Cources(
C_ID INT IDENTITY (100,1) PRIMARY KEY,
C_Name VARCHAR (20),
Duration INT CHECK (Duration > 0),
Fees DECIMAL (10,2)
);

SELECT *FROM Cources;

CREATE TABLE Trainers(
Trainer_ID INT IDENTITY (1,1) PRIMARY KEY,
Trainer_Name VARCHAR(20) NOT NULL,
Specialty VARCHAR(20),
Phone VARCHAR(20)
);

SELECT *FROM Trainers;

INSERT INTO Trainee(Full_Name, Email, Phone, DateBirth, Gender)
VALUES 
('Ali Hassan', 'ali.hassan@email.com', '91234567', '1998-05-12', 'M'),
('Fatma Ahmed', 'fatma.ahmed@email.com', '92345678', '1999-08-21', 'F'),
('Mohammed Salim', 'mohammed.salim@email.com', '93456789', '1997-02-10', 'M'),
('Aisha Khalid', 'aisha.khalid@email.com', '94567890', '2000-11-30', 'F'),
('Khalid Nasser', 'khalid.nasser@email.com', '95678901', '1996-07-18', 'M');
SELECT *FROM Trainee;

INSERT INTO Cources( C_Name, Duration, Fees)
VALUES
('SQL Fundamentals', 3, 150.00),
('Advanced SQL Server', 4, 220.50),
('Python Programming', 5, 300.00),
('Data Analysis', 4, 275.75),
('Web Development', 6, 350.00);
SELECT *FROM Cources;

INSERT INTO Trainers(Trainer_Name, Specialty, Phone)
VALUES
('Ahmed Ali', 'Database Systems', '91234567'),
('Sara Mohammed', 'Web Development', '92345678'),
('Khalid Salim', 'Python Programming', '93456789'),
('Noor Hassan', 'Data Analysis', '94567890'),
('Yousef Nasser', 'Cyber Security', '95678901');
SELECT *FROM Trainers;

ALTER TABLE Trainee
ADD TrainingStatus VARCHAR(20)
CHECK(TrainingStatus IN('Active', 'Completed', 'Dropped'));
SELECT * FROM Trainee;

ALTER TABLE Cources
ADD StartDate DATE;

ALTER TABLE Trainers 
ALTER COLUMN Trainer_Name NVARCHAR (200) NOT NULL;

SELECT T_ID , Full_Name, TrainingStatus
FROM Trainee;

UPDATE Trainee
SET TrainingStatus = 'Active';

SELECT T_ID , Full_Name, TrainingStatus
FROM Trainee;

SELECT T_ID, Full_Name, Email, TrainingStatus
FROM Trainee
WHERE Email= 'ali.hassan@email.com';

UPDATE Trainee
SET TrainingStatus = 'Completed'
WHERE Email = 'ali.hassan@email.com';

SELECT T_ID, Full_Name, Email, TrainingStatus
FROM Trainee
WHERE Email = 'ali.hassan@email.com';

UPDATE Cources
SET Fees = Fees* 1.10;

SELECT C_ID, C_Name, Fees
FROM Cources;

SELECT Trainer_ID, Trainer_Name, Phone
FROM Trainers
WHERE Trainer_Name = 'Ahmed Ali';

UPDATE Trainers
SET Phone = '98887766'
WHERE Trainer_Name = 'Ahmed Ali';

SELECT Trainer_ID, Trainer_Name, Phone
FROM Trainers
WHERE Trainer_Name = 'Ahmed Ali';

SELECT T_ID, Full_Name, Email, TrainingStatus
FROM Trainee;

SELECT C_ID, C_Name, Fees
FROM Cources;

SELECT Trainer_ID, Trainer_Name, Phone
FROM Trainers;

SELECT T_ID, Full_Name, Email
FROM Trainee
WHERE Email = 'test.user@email.com';

DELETE FROM Trainee
WHERE Email = 'test.user@email.com';

SELECT C_ID, C_Name, Duration
FROM Cources
WHERE Duration < 4;

DELETE FROM Cources
WHERE Duration < 4;

SELECT C_ID, C_Name, Duration
FROM Cources
WHERE Duration < 4;

SELECT * FROM Trainers;

DELETE FROM Trainers;

SELECT * FROM Trainers;

SELECT * FROM Trainee;

SELECT * FROM Cources;

DROP TABLE Trainers;

USE master;

DROP DATABASE TrainingCenterDB;

SELECT name
FROM sys.databases
WHERE name = 'TrainingCenterDB';

 --- Answer Questions :
 ----  1. Difference between DDL and DML
 --DDL (Data Definition Language) is used to define and 
 --modify the structure of database objects such as tables 
 --and databases(CREATE, ALTER, DROP) .

 --DML (Data Manipulation Language) is used to work with the
 --data stored inside tables(INSERT, UPDATE, DELETE, SELECT).

 ----- 2. Difference between DELETE and DROP
 -- DELETE: removes data from a table, but the table itself
 --remains in the database.

--DROP: removes the entire database object, such as a table 
--or database, including its structure and data.

-----3. Why is WHERE dangerous if forgotten?
--If the WHERE clause is forgotten in an UPDATE or DELETE 
--statement, the operation will affect all rows in the table, 
--which can cause serious data loss.

-----4. Why should SELECT be used before DELETE?
--Using SELECT before DELETE helps verify which rows will be 
--affected and ensures that the correct data is being removed.

-----5. What does auto-increment solve?

--Auto-increment automatically generates a unique ID for each new 
--record, preventing duplicate IDs and reducing manual input errors.

----6. What happens if constraints are violated?

--When constraints are violated, SQL Server rejects the operation 
--and returns an error, and the data is not inserted or updated.

----7. Why do online tools limit some SQL commands?

--Online SQL tools limit commands like DROP DATABASE to protect the
--system, prevent accidental damage, and avoid affecting other users
--on shared servers.




























