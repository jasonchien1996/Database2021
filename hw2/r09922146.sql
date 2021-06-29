/* create and use database */
CREATE DATABASE Gym;
USE Gym;


/* info */
CREATE TABLE self (
    StuID varchar(10) NOT NULL,
    Department varchar(10) NOT NULL,
    SchoolYear smallint unsigned DEFAULT 1,
    FirstName varchar(15) NOT NULL,
    LastName varchar(15) NOT NULL,
    Lab varchar(10),
    PRIMARY KEY (StuID),
    CONSTRAINT CHK_ID CHECK(NOT StuID = ''),
    CONSTRAINT CHK_DEPARTMENT CHECK(NOT Department = ''),
    CONSTRAINT CHK_YEAR CHECK(SchoolYear < 5),
    CONSTRAINT CHK_NAME CHECK(NOT FirstName = '' OR NOT LastName = ''),
    CONSTRAINT CHK_LAB CHECK(NOT Lab = '')
);

INSERT INTO self
VALUES ('r09922146', '資訊工程研究所', 1, '辰哲', '簡', 'PAS Lab');

SELECT DATABASE();
SELECT * FROM self;


/* create table */
CREATE TABLE Equipment (
    ID int unsigned AUTO_INCREMENT,
    Brand varchar(6) NOT NULL,
    Category varchar(11) NOT NULL,
    Quantity smallint DEFAULT 1,
    PRIMARY KEY(ID),
    CONSTRAINT CHK_BRAND CHECK(Brand = 'Hammer' OR Brand = 'HOIST' OR Brand = 'MATRIX' OR Brand = 'ZIVA'),
    CONSTRAINT CHK_CAT CHECK(Category = 'Machine' OR Category = 'Free Weight' OR Category = 'Plate'),
    CONSTRAINT CHK_QUANTITY CHECK(Quantity > 0)
);

CREATE TABLE Staff (
    ID int unsigned AUTO_INCREMENT,
    FirstName varchar(15) NOT NULL,
    LastName varchar(15) NOT NULL,
    Age smallint unsigned NOT NULL,
    Sex varchar(1) DEFAULT 'M',
    Salary smallint unsigned DEFAULT 24000,
    Supervisor int unsigned,
    PRIMARY KEY(ID),
    FOREIGN KEY (Supervisor) REFERENCES Staff(ID),
    CONSTRAINT STAFF_NAME CHECK(NOT LastName = '' OR NOT FirstName = ''),
    CONSTRAINT STAFF_AGE CHECK(Age > 15),
    CONSTRAINT STAFF_SEX CHECK(Sex = 'M' OR Sex = 'F'),
    CONSTRAINT STAFF_SALARY CHECK(Salary >= 24000)
);

CREATE TABLE Sales (
    ID int unsigned PRIMARY KEY,
    Number_of_Serving_Members smallint NOT NULL,
    Quota int unsigned DEFAULT 5000,
    Outstanding_Achievement int DEFAULT 0,
    FOREIGN KEY (ID) REFERENCES Staff(ID),
    CONSTRAINT CHK_MEMBER CHECK(Number_of_Serving_Members >= 0),
    CONSTRAINT CHK_QUOTA CHECK(Quota >= 5000 AND Quota <= 100000),
    CONSTRAINT CHK_ACHIEVEMENT CHECK(Outstanding_Achievement >= 0)
);

CREATE TABLE Trainer (
    ID int unsigned PRIMARY KEY,
    Number_of_Students smallint NOT NULL,
    Price smallint unsigned DEFAULT 1500,
    Skill varchar(20),
    FOREIGN KEY (ID) REFERENCES Staff(ID),
    CONSTRAINT CHK_STUDENT CHECK(Number_of_Students >= 0),
    CONSTRAINT CHK_PRICE CHECK(Price >= 1000 AND Price <= 3000),
    CONSTRAINT CHK_SKILL CHECK(NOT Skill = '')    
);

CREATE TABLE Member (
    ID int unsigned AUTO_INCREMENT,
    FirstName varchar(15) NOT NULL,
    LastName varchar(15) NOT NULL,
    Age smallint NOT NULL,
    Sex varchar(1) DEFAULT 'M',
    Sales int unsigned NOT NULL,
    PRIMARY KEY(ID),
    FOREIGN KEY (Sales) REFERENCES Sales(ID),
    CONSTRAINT MEMBER_NAME CHECK(NOT LastName = '' OR NOT FirstName = ''),
    CONSTRAINT MEMBER_AGE CHECK(Age > 17),
    CONSTRAINT MEMBER_SEX CHECK(Sex = 'M' OR Sex = 'F')
);

CREATE TABLE Contract (
    ID int unsigned PRIMARY KEY,
    Contract_Date date NOT NULL,
    Length smallint DEFAULT 1,
    Fee smallint NOT NULL,
    Prepaid ENUM('0','1','2','3','4','5','6','7','8','9','10','11','12') NOT NULL,
    CONSTRAINT CHK_DATE CHECK(Contract_Date < '2021-04-01'),
    CONSTRAINT CHK_LENGTH CHECK(Length > 0),
    CONSTRAINT CHK_FEE CHECK(Fee >= 900),
    FOREIGN KEY (ID) REFERENCES Member(ID)
);

CREATE TABLE Minute (
    ID int unsigned PRIMARY KEY,
    Balance smallint NOT NULL,
    Entering_Time time NOT NULL,
    Accumulated_Time int DEFAULT 0,
    CONSTRAINT CHK_BALANCE CHECK(Balance >= 0),
    CONSTRAINT CHK_ENTER CHECK(Entering_Time <= '23:00:00' AND Entering_Time >= '08:00:00'),
    CONSTRAINT CHK_ACCU CHECK(Accumulated_Time >= 0),
    FOREIGN KEY (ID) REFERENCES Member(ID)
);

CREATE TABLE Trains (
    TrainerID int unsigned NOT NULL,
    StudentID int unsigned NOT NULL,
    Frequency_per_Week smallint DEFAULT 1,
    PRIMARY KEY (TrainerID, StudentID),
    FOREIGN KEY (TrainerID) REFERENCES Trainer(ID),
    FOREIGN KEY (StudentID) REFERENCES Member(ID),
    CONSTRAINT CHK_FREQUENCY CHECK(Frequency_per_Week > 0)
);


/* insert */
INSERT INTO Equipment (Brand, Category, Quantity)
VALUES 
('Hammer', 'Machine', 2),
('HOIST', 'Machine', 1),
('ZIVA', 'Free Weight',4);

INSERT INTO Staff (ID, FirstName, LastName, Age, Salary, Supervisor)
VALUES
(1, 'John', 'Haack', 30, 50000, NULL),
(2, 'Larry', 'Williams', 25, 40000, 1),
(3, 'Cailer', 'Woolam', 27, 35000, 1),
(4, 'Tom', 'Cruise', 35, 55000, NULL),
(5, 'John', 'Wick', 32, 50000, 4),
(6, 'Dwayen', 'Johnson', 40, 40000,4);

INSERT INTO Sales (ID, Number_of_Serving_Members, Quota, Outstanding_Achievement)
VALUES
(1, 1, 10000, 100000),
(2, 3, 5000, 10000),
(3, 2, 80000, 30000);

INSERT INTO Trainer (ID, Number_of_Students, Price, Skill)
VALUES
(3, 0, 1000, 'Boxing'),
(4, 3, 2500, 'Bodybuilding'),
(5, 1, 1500, 'Posing'),
(6, 4, 2000, 'Powerlifting');

INSERT INTO Member (FirstName, LastName, Age, Sales)
VALUES
('Peter', 'Parker', 20, 1),
('Lebron', 'James', 36, 2),
('Jeremy', 'Lin', 35, 3),
('杰倫', '周', 43, 2),
('Jeremy', 'Buendia', 28, 2),
('Phil', 'Heath', 38, 3);

INSERT INTO Contract (ID, Contract_Date, Length, Fee, Prepaid)
VALUES
(1, '2019-11-30', 2, 1300, '6'),
(2, '2020-03-14', 3, 1200, '12'),
(3, '2021-03-27', 5, 900, '0');

INSERT INTO Minute (ID , Balance, Entering_Time, Accumulated_Time)
VALUES
(4, 1035, '09:25:48', 1894),
(5,  300, '18:03:20', 3975);
INSERT INTO Minute (ID , Balance, Entering_Time)
VALUES
(6, 2000, '20:27:33');

INSERT INTO Trains(TrainerID, StudentID, Frequency_per_Week)
VALUES
(4,1,2),
(4,4,1),
(4,5,1),
(5,1,1),
(6,2,2),
(6,3,3),
(6,5,1),
(6,4,1);


/* create two views (Each view should be based on two tables.)*/
CREATE VIEW Student_Frequency AS
SELECT SUM(Frequency_per_Week) AS Sessions_per_Week, FirstName, LastName
FROM Trains, Member
WHERE Trains.StudentID=Member.ID
GROUP BY FirstName, LastName;

CREATE VIEW Trainer_Frequency AS
SELECT SUM(Frequency_per_Week) AS Sessions_per_Week, FirstName, LastName
FROM Trains, Staff
WHERE Trains.TrainerID=Staff.ID
GROUP BY FirstName, LastName;


/* select from all tables and views */
SELECT * FROM Equipment;
SELECT * FROM Staff;
SELECT * FROM Sales;
SELECT * FROM Trainer;
SELECT * FROM Member;
SELECT * FROM Contract;
SELECT * FROM Minute;
SELECT * FROM Trains;
SELECT * FROM Student_Frequency;
SELECT * FROM Trainer_Frequency;


/* drop database */
DROP DATABASE Gym;