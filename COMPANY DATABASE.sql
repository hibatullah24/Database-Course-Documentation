CREATE TABLE Dept (
    Dnum INT  PRIMARY KEY,
    DName VARCHAR(50) NOT NULL UNIQUE,
    MgrSSN CHAR(9) NULL,
    Hiredate DATE NULL
);


CREATE TABLE EMP (
    SSN CHAR(9) PRIMARY KEY,
    BD DATE NOT NULL,
    Gender CHAR(1) NOT NULL,
    First VARCHAR(30) NOT NULL,
    Last VARCHAR(30) NOT NULL,
    Dnum INT NOT NULL,
    Superid CHAR(9) NULL,

    CONSTRAINT CHK_EMP_GENDER
        CHECK (Gender IN ('M','F'))
);

CREATE TABLE Locations (
    Dnum INT NOT NULL,
    Loc VARCHAR(50) NOT NULL,
    PRIMARY KEY (Dnum, Loc),

    CONSTRAINT FK_LOC_DEPT
        FOREIGN KEY (Dnum) REFERENCES Dept(Dnum)
        ON DELETE CASCADE
        ON UPDATE NO ACTION
);

CREATE TABLE Project (
    Pnum INT PRIMARY KEY,
    Pname VARCHAR(60) NOT NULL,
    City VARCHAR(50) NOT NULL,
    Loc VARCHAR(50) NOT NULL,
    Dnum INT NOT NULL,

    CONSTRAINT FK_PROJECT_DEPT
        FOREIGN KEY (Dnum) REFERENCES Dept(Dnum)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
);


CREATE TABLE Dependent (
    SSN CHAR(9) NOT NULL,
    DepName VARCHAR(60) NOT NULL,
    Gender CHAR(1) NOT NULL,
    BD DATE NOT NULL,

    PRIMARY KEY (SSN, DepName),

    CONSTRAINT FK_DEP_EMP
        FOREIGN KEY (SSN) REFERENCES EMP(SSN)
        ON DELETE CASCADE
        ON UPDATE NO ACTION,

    CONSTRAINT CHK_DEP_GENDER
        CHECK (Gender IN ('M','F'))
);

CREATE TABLE MyWork (
    SSN CHAR(9) NOT NULL,
    Pnum INT NOT NULL,
    Hours DECIMAL(5,2) NOT NULL,

    PRIMARY KEY (SSN, Pnum),

    CONSTRAINT FK_WORK_EMP
        FOREIGN KEY (SSN) REFERENCES EMP(SSN)
        ON DELETE CASCADE
        ON UPDATE NO ACTION,

    CONSTRAINT FK_WORK_PROJECT
        FOREIGN KEY (Pnum) REFERENCES Project(Pnum)
        ON DELETE CASCADE
        ON UPDATE NO ACTION,

    CONSTRAINT CHK_WORK_HOURS
        CHECK (Hours >= 0 AND Hours <= 168)
);


ALTER TABLE EMP
ADD CONSTRAINT FK_EMP_DEPT
FOREIGN KEY (Dnum) REFERENCES Dept(Dnum)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE EMP
ADD CONSTRAINT FK_EMP_SUPER
FOREIGN KEY (Superid) REFERENCES EMP(SSN)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE Dept
ADD CONSTRAINT FK_DEPT_MANAGER
FOREIGN KEY (MgrSSN) REFERENCES EMP(SSN)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

INSERT INTO Dept (Dnum, DName, MgrSSN, Hiredate) VALUES (10, 'IT',  NULL, NULL);
INSERT INTO Dept (Dnum, DName, MgrSSN, Hiredate) VALUES (20, 'HR',  NULL, NULL);
INSERT INTO Dept (Dnum, DName, MgrSSN, Hiredate) VALUES (30, 'FIN', NULL, NULL);

INSERT INTO EMP (SSN, BD, Gender, First, Last, Dnum, Superid)
VALUES ('100000001', '1990-05-10', 'M', 'Ahmed', 'Ali', 10, NULL);

INSERT INTO EMP (SSN, BD, Gender, First, Last, Dnum, Superid)
VALUES ('100000003', '1988-11-02', 'M', 'Khalid', 'Hassan', 20, NULL);

INSERT INTO EMP (SSN, BD, Gender, First, Last, Dnum, Superid)
VALUES ('100000004', '1995-07-15', 'F', 'Mona', 'Yahya', 30, NULL);

INSERT INTO EMP (SSN, BD, Gender, First, Last, Dnum, Superid)
VALUES ('100000002', '1992-03-22', 'F', 'Sara', 'Salem', 10, '100000001');

INSERT INTO EMP (SSN, BD, Gender, First, Last, Dnum, Superid)
VALUES ('100000005', '1997-01-09', 'M', 'Saif', 'Nasser', 20, '100000003');

UPDATE Dept SET MgrSSN='100000001', Hiredate='2020-01-01' WHERE Dnum=10;
UPDATE Dept SET MgrSSN='100000003', Hiredate='2019-06-01' WHERE Dnum=20;
UPDATE Dept SET MgrSSN='100000004', Hiredate='2021-09-10' WHERE Dnum=30;

INSERT INTO Locations (Dnum, Loc) VALUES (10, 'Muscat HQ');
INSERT INTO Locations (Dnum, Loc) VALUES (10, 'Seeb Office');
INSERT INTO Locations (Dnum, Loc) VALUES (20, 'Muscat HQ');
INSERT INTO Locations (Dnum, Loc) VALUES (30, 'Ruwi Office');
SELECT * FROM Locations;


INSERT INTO Project (Pnum, Pname, City, Loc, Dnum)
VALUES (1, 'Rain Dashboard', 'Muscat', 'Muscat HQ', 10);

INSERT INTO Project (Pnum, Pname, City, Loc, Dnum)
VALUES (2, 'HR Portal', 'Muscat', 'Muscat HQ', 20);

INSERT INTO Project (Pnum, Pname, City, Loc, Dnum)
VALUES (3, 'Finance ERP', 'Muscat', 'Ruwi Office', 30);

INSERT INTO Project (Pnum, Pname, City, Loc, Dnum)
VALUES (4, 'Network Upgrade', 'Seeb', 'Seeb Office', 10);
SELECT * FROM Project;


INSERT INTO Dependent (SSN, DepName, Gender, BD)
VALUES ('100000001', 'Omar', 'M', '2015-02-11');

INSERT INTO Dependent (SSN, DepName, Gender, BD)
VALUES ('100000001', 'Noor', 'F', '2019-04-17');

INSERT INTO Dependent (SSN, DepName, Gender, BD)
VALUES ('100000002', 'Layan', 'F', '2018-08-30');

INSERT INTO Dependent (SSN, DepName, Gender, BD)
VALUES ('100000005', 'Saad', 'M', '2020-12-01');
SELECT * FROM Dependent;

INSERT INTO MyWork (SSN, Pnum, Hours) VALUES ('100000001', 1, 20.00);
INSERT INTO MyWork (SSN, Pnum, Hours) VALUES ('100000002', 1, 15.50);
INSERT INTO MyWork (SSN, Pnum, Hours) VALUES ('100000003', 2, 25.00);
INSERT INTO MyWork (SSN, Pnum, Hours) VALUES ('100000004', 3, 30.00);
INSERT INTO MyWork (SSN, Pnum, Hours) VALUES ('100000001', 3, 10.00);
INSERT INTO MyWork (SSN, Pnum, Hours) VALUES ('100000005', 2, 12.00);
INSERT INTO MyWork (SSN, Pnum, Hours) VALUES ('100000002', 4, 18.00);
SELECT * FROM MyWork;