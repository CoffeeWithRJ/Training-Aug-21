CREATE DATABASE BUS_RESERVATION

USE BUS_RESERVATION

--CREATE QUEARY

CREATE TABLE OBJECT_MASTER
(
[Type_Id] INT PRIMARY KEY IDENTITY(1,1),
[Type_Name] VARCHAR(20) NOT NULL
)

INSERT INTO OBJECT_MASTER VALUES ('Gender'),
                                 ('Deck_Type'),
                                 ('Seat_Type'),
                                 ('Bus_Type'),
                                 ('Payment_Type'),
                                 ('Cities')
----------------------------------------------------------------------------------------------------------- 

CREATE TABLE [OBJECT]
(
Obj_Id INT PRIMARY KEY IDENTITY(1,1),
[Type_Id] INT NOT NULL,
Obj_Name VARCHAR(30) NOT NULL,
CONSTRAINT FK_Type_Id FOREIGN KEY([Type_Id]) REFERENCES OBJECT_MASTER([Type_Id])
)


INSERT INTO [OBJECT] VALUES (1,'Male'),
                            (1,'Female'),
                            (1,'Others'),
                            (2,'Upper'),
                            (2,'Lower'),
                            (3,'Sleeper'),
                            (3,'Seat'),
                            (4,'Express'),
                            (4,'Gsrtc'),
                            (4,'Volvo'),
                            (4,'Intercity Express'),
                            (5,'Debit-Card'),
                            (5,'Credit-Card'),
                            (5,'NetBanking'),
                            (5,'UPI'),
                            (6,'Ahmedabad'),
                            (6,'Surat'),
                            (6,'Rajkot'),
                            (6,'Vadodara'),
                            (6,'Bhavnagar'),
                            (6,'Junagadh'),
                            (6,'Bhuj'),
                            (6,'Amreli')

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
CREATE TABLE TRAVEL_SCHEDULE(
Schedule_Id INT PRIMARY KEY IDENTITY(1,1),
Bus_Id INT NOT NULL,
DRIVER_Id INT NOT NULL,
[Source] TINYINT NOT NULL,
Starting_Point TINYINT NOT NULL,
Destination TINYINT NOT NULL,
Destination_Point TINYINT NOT NULL,
Departure_Time TIME NOT NULL,
Departure_Date DATE NOT NULL,
Ticket_Price DECIMAL(8,2) NOT NULL,
Available_Seats TINYINT,
Rating DECIMAL(2,1),
Travel_Status BIT NOT NULL,
[User_Id] INT NOT NULL,
CONSTRAINT Bus_Id_FK FOREIGN KEY (Bus_Id) REFERENCES BUS(Bus_Id) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT Chk_Source CHECK([Source] BETWEEN 16 AND 23),
CONSTRAINT Chk_Starting_Point CHECK(Starting_Point BETWEEN 1 AND 61),
CONSTRAINT Chk_Destination CHECK(Destination BETWEEN 16 AND 23),
CONSTRAINT Chk_Destination_Point CHECK(Destination_Point BETWEEN 1 AND 61),
CONSTRAINT DriverID_FK FOREIGN KEY (DRIVER_Id) REFERENCES DRIVER(Driver_Id) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT UserId_FK FOREIGN KEY ([User_Id]) REFERENCES USER_INFO([User_Id])
)

------------------------------------------------------------------------------------------------------------------
CREATE TABLE PASSENGER
(
Passenger_Id INT PRIMARY KEY IDENTITY(1,1),
Passenger_Name VARCHAR(25) NOT NULL,
Age TINYINT NOT NULL,
Gender TINYINT NOT NULL,
Seat_No TINYINT UNIQUE NOT NULL,
[User_Id] INT NOT NULL,
Bus_Id INT NOT NULL,
Vaccination_status BIT NOT NULL,
CONSTRAINT FK_Seat_No FOREIGN KEY (Seat_No) REFERENCES SEAT(Seat_No) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT Chk_Gender_ CHECK(Gender BETWEEN 1 AND 3),
CONSTRAINT FK_User_Id FOREIGN KEY ([User_Id]) REFERENCES USER_INFO([User_Id]) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT chk_bus_seat_ FOREIGN KEY(Bus_Id) REFERENCES BUS(Bus_Id)
)
------------------------------------------------------------------------------------------------------------------
CREATE TABLE TICKETS
(
Ticket_Id INT PRIMARY KEY IDENTITY(1,1),
Schedule_Id INT NOT NULL,
Booked_Seat TINYINT NOT NULL,
Ticket_Price DECIMAL(8,2) NOT NULL,
Insurance Bit DEFAULT 0,
Total_Cost  AS ( (Ticket_Price* Booked_Seat) +(Insurance * Booked_Seat * 5) + 5 ),
[User_Id] INT NOT NULL,
CONSTRAINT Schedule_FK FOREIGN KEY (Schedule_Id) REFERENCES TRAVEL_SCHEDULE(Schedule_Id),
CONSTRAINT User_fk1 FOREIGN KEY ([User_Id]) REFERENCES USER_INFO([User_Id])
)
------------------------------------------------------------------------------------------------------------------
CREATE TABLE PAYMENT
(
    Payment_ID INT CONSTRAINT PAYMENT_PymentId_PK PRIMARY KEY IDENTITY(1,1),
    Payment_type TINYINT NOT NULL,
    Ticket_Id INT CONSTRAINT PAYMENT_TicketId_FK FOREIGN KEY REFERENCES TICKETS(Ticket_Id) NOT NULL,
    Payment_Number VARCHAR(30) NOT NULL,
    [User_Id] INT NOT NULL CONSTRAINT PAYMENT_UserId_FK FOREIGN KEY ([User_Id]) REFERENCES USER_INFO([User_Id]),
	CONSTRAINT Chk_Payment_type CHECK(Payment_type BETWEEN 12 AND 15)
)
------------------------------------------------------------------------------------------------------------------

 CREATE TABLE BOOKING_DETAILS
(
Bd_Id INT IDENTITY PRIMARY KEY,
Booking_Date DATE NOT NULL,
Booking_Status BIT NOT NULL,
Payment_ID INT NOT NULL UNIQUE CONSTRAINT FK_Payment FOREIGN KEY (Payment_Id) REFERENCES PAYMENT(Payment_Id)  ON DELETE CASCADE ON UPDATE CASCADE,
Schedule_Id INT NOT NULL CONSTRAINT Schedule_FK0 FOREIGN KEY (Schedule_Id) REFERENCES TRAVEL_SCHEDULE(Schedule_Id) ON DELETE CASCADE ON UPDATE CASCADE,
[User_Id] INT NOT NULL CONSTRAINT User_Fk11 FOREIGN KEY ([User_Id]) REFERENCES USER_INFO([User_Id]) ON DELETE CASCADE ON UPDATE CASCADE
)
 
 
INSERT INTO BOOKING_DETAILS VALUES ('2021-08-19',1,1,1,1),
                           ('2021-08-20',0,2,2,2),
                           ('2021-08-21',0,3,3,3),
                           ('2021-08-22',1,4,4,4),
                           ('2021-08-23',1,5,5,5),
                           ('2021-08-25',1,6,6,6),
                           ('2021-08-24',0,7,7,7),
                           ('2021-08-24',1,8,8,8),
                           ('2021-08-25',1,9,9,9),
                           ('2021-08-20',1,10,10,10) 
						   
 
-------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE CANCELLATION
(
    Cancellation_Id INT PRIMARY KEY IDENTITY(1,1),
    Ticket_Id INT CONSTRAINT chk_ticket_cancel UNIQUE FOREIGN KEY (Ticket_Id) REFERENCES TICKETS(Ticket_Id) ON DELETE CASCADE ON UPDATE CASCADE NOT NULL,
    Bd_Id INT CONSTRAINT chk_bd_cancel UNIQUE FOREIGN KEY (Bd_Id) REFERENCES BOOKING_DETAILS(Bd_Id) ON DELETE CASCADE ON UPDATE CASCADE NOT NULL
)
              

INSERT INTO CANCELLATION VALUES (2,2),                                                                                                                                    
				(3,3),
				(7,7)
