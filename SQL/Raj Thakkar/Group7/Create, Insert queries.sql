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

