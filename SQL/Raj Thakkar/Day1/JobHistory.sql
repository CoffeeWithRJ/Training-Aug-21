CREATE TABLE JobHistory
(
EmployeeId int PRIMARY KEY identity(1,1),
StartDate date NOT NULL,
End_Date varchar(50) CONSTRAINT chkFormat CHECK(End_Date LIKE '__/__/____') ,
Job_Id int NOT NULL,
Department_Id int NOT NULL,
)

INSERT INTO JobHistory VALUES('2020/02/02','02/08/2021',1,2)

SELECT * FROM JobHistory