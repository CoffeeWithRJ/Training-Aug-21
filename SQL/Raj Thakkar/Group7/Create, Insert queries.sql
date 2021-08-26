CREATE DATABASE BUS_RESERVATION

USE BUS_RESERVATION

--CREATE QUEARY

CREATE TABLE OBJECT_MASTER
(
[Type_Id] INT PRIMARY KEY IDENTITY(1,1),
[Type_Name] VARCHAR(20) NOT NULL
)

----------------------------------------------------------------------------------------------------------- 

CREATE TABLE [OBJECT]
(
Obj_Id INT PRIMARY KEY IDENTITY(1,1),
[Type_Id] INT NOT NULL,
Obj_Name VARCHAR(30) NOT NULL,
CONSTRAINT FK_Type_Id FOREIGN KEY([Type_Id]) REFERENCES OBJECT_MASTER([Type_Id])
)

-----------------------------------------------------------------------------------------------------------
CREATE TABLE SUB_LOCATION
(   
    Loc_Id INT PRIMARY KEY IDENTITY(1,1),
    Loc_Obj_Id INT NOT NULL,
    Loc_Name VARCHAR(30) NOT NULL,
    CONSTRAINT Chk_Loc_Obj_Id FOREIGN KEY (Loc_Obj_Id) REFERENCES OBJECT(Obj_Id)
)

------------------------------------------------------------------------------------------------------------

CREATE TABLE USER_INFO
(
[User_Id] INT PRIMARY KEY IDENTITY(1,1),
First_Name VARCHAR(15) NOT NULL,
Last_Name VARCHAR(15) NOT NULL,
Contact_No VARCHAR(10) NOT NULL CONSTRAINT Chk_Contact CHECK(Contact_No like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]') UNIQUE,
Email_Address VARCHAR(30) NULL CONSTRAINT Chk_Email CHECK(Email_Address like '%__@_%.com') UNIQUE,
User_Password VARCHAR(12) NOT NULL CONSTRAINT Chk_Password CHECK(LEN(User_Password)>5 AND LEN(User_Password)<=12),
Dob DATE NOT NULL,
Gender TINYINT NOT NULL,
City VARCHAR(15) NOT NULL,
CONSTRAINT Chk_Gender CHECK(Gender BETWEEN 1 AND 3)
)

---------------------------------------------------------------------------------------------------------------
CREATE TABLE BUS
(
    Bus_Id INT PRIMARY KEY IDENTITY(1,1),
    Bus_Plate_Number VARCHAR(15) CONSTRAINT chk_plateNumber_bus CHECK(Bus_Plate_Number LIKE 
    '[A-Z][A-Z][0-9][0-9][A-Z][A-Z][0-9][0-9][0-9][0-9]') UNIQUE NOT NULL,
    Bus_Type TINYINT NOT NULL,
    AC_Type VARCHAR(10) DEFAULT 'Non-AC',
    Total_Seat TINYINT NOT NULL,
	CONSTRAINT Chk_Bus_Type CHECK(Bus_Type BETWEEN 8 AND 11)
)

------------------------------------------------------------------------------------------------------------------
CREATE TABLE SEAT
(
Seat_No TINYINT PRIMARY KEY IDENTITY(1,1),
Seat_Type TINYINT NOT NULL ,
Seat_Status BIT NOT NULL DEFAULT 0,
Deck_Type TINYINT NOT NULL, 
Bus_Id INT CONSTRAINT chk_bus_seat FOREIGN KEY(Bus_Id) REFERENCES BUS(Bus_Id) ON DELETE CASCADE ON UPDATE CASCADE NOT NULL
)
------------------------------------------------------------------------------------------------------------------
CREATE TABLE DRIVER
(
    Driver_Id INT CONSTRAINT DRIVER_DriverId_PK PRIMARY KEY IDENTITY(1,1),
    First_Name varchar(15) NOT NULL,
    Last_Name varchar(15) NOT NULL,
    Contact_No varchar(10) CONSTRAINT  DRIVER_ContactNo CHECK(Contact_No LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]') NOT NULL,
    Bus_Id INT CONSTRAINT BusId_FK FOREIGN KEY REFERENCES BUS(Bus_Id) NOT NULL
)

------------------------------------------------------------------------------------------------------------------
