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
    ID int unsigned AUTO_INCREMENT PRIMARY KEY,
    Brand varchar(6) NOT NULL,
    Category varchar(11) NOT NULL,
    Quantity smallint unsigned DEFAULT 1,    
    CONSTRAINT CHK_BRAND CHECK(Brand = 'Hammer' OR Brand = 'HOIST' OR Brand = 'MATRIX' OR Brand = 'ZIVA'),
    CONSTRAINT CHK_CAT CHECK(Category = 'Machine' OR Category = 'Free Weight' OR Category = 'Plate')
);

CREATE TABLE Staff (
    ID int unsigned AUTO_INCREMENT PRIMARY KEY,
    FirstName varchar(15) NOT NULL,
    LastName varchar(15) NOT NULL,
    Age smallint unsigned NOT NULL,
    Sex varchar(1) DEFAULT 'M',
    Salary smallint unsigned DEFAULT 24000,
    Supervisor int unsigned,
    FOREIGN KEY (Supervisor) REFERENCES Staff(ID),
    CONSTRAINT STAFF_NAME CHECK(NOT LastName = '' OR NOT FirstName = ''),
    CONSTRAINT STAFF_AGE CHECK(Age > 15),
    CONSTRAINT STAFF_SEX CHECK(Sex = 'M' OR Sex = 'F'),
    CONSTRAINT STAFF_SALARY CHECK(Salary >= 24000)
);

CREATE TABLE Sales (
    ID int unsigned PRIMARY KEY,
    Number_of_Serving_Members smallint unsigned NOT NULL,
    Quota int unsigned DEFAULT 5000,
    Outstanding_Achievement int unsigned DEFAULT 0,
    FOREIGN KEY (ID) REFERENCES Staff(ID),
    CONSTRAINT CHK_QUOTA CHECK(Quota >= 5000 AND Quota <= 100000)
);

CREATE TABLE Trainer (
    ID int unsigned PRIMARY KEY,
    Number_of_Students smallint unsigned NOT NULL,
    Price smallint unsigned DEFAULT 1500,
    Skill varchar(20),
    FOREIGN KEY (ID) REFERENCES Staff(ID),
    CONSTRAINT CHK_PRICE CHECK(Price >= 1000 AND Price <= 3000),
    CONSTRAINT CHK_SKILL CHECK(NOT Skill = '')    
);

CREATE TABLE Member (
    ID int unsigned AUTO_INCREMENT PRIMARY KEY,
    FirstName varchar(15) NOT NULL,
    LastName varchar(15) NOT NULL,
    Age smallint NOT NULL,
    Sex varchar(1) DEFAULT 'M',
    Sales int unsigned NOT NULL,
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
    CONSTRAINT CHK_LENGTH CHECK(Length > 0),
    CONSTRAINT CHK_FEE CHECK(Fee >= 900),
    FOREIGN KEY (ID) REFERENCES Member(ID)
);

CREATE TABLE Minute (
    ID int unsigned PRIMARY KEY,
    Balance smallint unsigned NOT NULL,
    Entering_Time time NOT NULL,
    Accumulated_Time int unsigned DEFAULT 0,
    CONSTRAINT CHK_ENTER CHECK(Entering_Time <= '23:00:00' AND Entering_Time >= '08:00:00'),
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

CREATE TABLE Plate(
    ID int unsigned AUTO_INCREMENT PRIMARY KEY,
    Brand varchar(6) NOT NULL,
    Category varchar(11) NOT NULL,
    Quantity smallint unsigned DEFAULT 1
);

/* insert */
INSERT INTO Plate (Brand, Category, Quantity)
VALUES 
('MATRIX', 'Bumper', 2),
('HOIST', 'Steel', 1),
('MATRIX', 'Olympic',4);

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

/***** homework 3 commands *****/

/* basic select */
SELECT *
FROM Staff
WHERE (LastName='Hacck' OR (NOT Age<30) ) AND Supervisor IS NOT NULL;

/* basic projection */
SELECT Brand
FROM Equipment;

/* basic rename */
SELECT ID AS 編號, FirstName AS 名, LastName AS 姓, Sex AS 性別, Sales AS 業務員編號
FROM Member
WHERE Age>30;

/* union */
SELECT * FROM Equipment
union
SELECT * FROM Plate;

/* equijoin */
SELECT
ID, Number_of_Students, Price, Skill,
TrainerID, StudentID, Frequency_per_Week
FROM Trainer, Trains
WHERE ID = TrainerID;

/* natural join */
SELECT
ID, Number_of_Students, Price, Skill,
StudentID, Frequency_per_Week
FROM Trainer, Trains
WHERE ID = TrainerID;

/* theta join */
SELECT
T.ID AS TrainerID, T.Number_of_Students, T.Price, T.Skill,
S.ID AS SalesID, S.Number_of_Serving_Members, S.Quota, S.Outstanding_Achievement
FROM Trainer AS T, Sales AS S
WHERE T.ID > S.ID;

/* three table join */
SELECT M.ID AS MemberID, M.FirstName, M.LastName, M.Sales AS SalesID, T.TrainerID
FROM ((Member AS M
INNER JOIN Sales AS S ON M.Sales = S.ID)
INNER JOIN Trains AS T ON StudentID = M.ID);

/* aggregate */
SELECT
TrainerID,
MIN(Frequency_per_Week),
MAX(Frequency_per_Week),
COUNT(Frequency_per_Week)  
FROM Trains
GROUP BY TrainerID;

/* aggregate 2 */
SELECT
StudentID,
COUNT(Frequency_per_Week),
AVG(Frequency_per_Week),
SUM(Frequency_per_Week)
FROM Trains
GROUP BY StudentID
HAVING StudentID>3;

/* in */
SELECT * FROM Member
WHERE LastName IN ('Parker', 'Lee', 'Lin', 'Chien');

/* in 2 */
SELECT * FROM Staff
WHERE ID IN (SELECT Sales FROM Member WHERE Age>20);

/* correlated nested query */
SELECT Quota From Sales AS S
WHERE S.ID IN (
    SELECT ID FROM Staff
    WHERE S.Outstanding_Achievement>50000
        AND S.ID = Supervisor OR Supervisor IS NULL);

/* correlated nested query 2 */
SELECT Quota From Sales AS S
WHERE EXISTS (
    SELECT ID FROM Staff
    WHERE S.ID = Supervisor OR Supervisor IS NULL);

/* bonus 1 */
SELECT FirstName, LastName, Salary, Number_of_Serving_Members, Quota, Outstanding_Achievement
FROM Staff
LEFT JOIN Sales
ON Staff.ID = Sales.ID;

/* bonus 2 */
SELECT
StudentID, SUM(Frequency_per_Week)
FROM Trains
GROUP BY StudentID
HAVING StudentID>2;

/* bonus 3 */
SELECT S.ID, Quota From Sales AS S
WHERE NOT EXISTS (
    SELECT ID FROM Staff
    WHERE (S.ID = Supervisor OR Supervisor IS NULL) AND Salary<30000);

/* drop database */
DROP DATABASE Gym;