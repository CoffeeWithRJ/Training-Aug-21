CREATE TABLE Employeess
(
EmployeeId int NOT NULL PRIMARY KEY,
FirstName varchar(50) NOT NULL,
LastName varchar(50) NOT NULL,
Email varchar(100) NOT NULL,
PhoneNumber varchar(10) NOT NULL CONSTRAINT chkLengthh CHECK(PhoneNumber LIKE '[1-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
Hire_Date date NOT NULL,
Salary money,
Commission int CONSTRAINT FK0 FOREIGN KEY REFERENCES Commission(commisionTab),
)

CREATE TABLE Inventoryy
(
Car_Id int NOT NULL PRIMARY KEY,
ModelName varchar(50),
Price money NOT NULL,
)

CREATE TABLE Sales
(
    SalesId int NOT NULL PRIMARY KEY IDENTITY(1,1),
	Employee_Id  int CONSTRAINT FK1 FOREIGN KEY REFERENCES Employeess(EmployeeId),
	CarId int CONSTRAINT FK2 FOREIGN KEY REFERENCES Inventoryy(Car_Id),
	Sales_date date NOT NULL,
	SalesQty int NOT NULL,

)



SELECT * INTO Comission FROM 
(SELECT sum(Sales.SalesQty) as Total_sale,Employee_Id ,comissionTab=sum(Sales.SalesQty)*0.10
FROM Sales)C

