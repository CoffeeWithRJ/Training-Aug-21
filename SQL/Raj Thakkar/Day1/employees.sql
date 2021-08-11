CREATE TABLE Department
(
DepartmentId int NOT NULL PRIMARY KEY,
DptName varchar(50) NOT NULL,
Location varchar(50),
)

CREATE TABLE employees
(
Employee_Id int NOT NULL PRIMARY KEY,
FirstName varchar(50) NOT NULL,
LastName varchar(50) NOT NULL,
Email varchar(100) NOT NULL,
PhoneNumber varchar(10) NOT NULL CONSTRAINT chkLength CHECK(PhoneNumber LIKE '[1-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
Hire_Date datetime NOT NULL,
Job_Id int CONSTRAINT fkid1 FOREIGN KEY REFERENCES dbo.jobs(JobId),
Salary money,
Commission money,
Manager_Id int NOT NULL,
Department_Id int CONSTRAINT fkid2 FOREIGN KEY REFERENCES dbo.Department(DepartmentId) ,
)

SELECT * FROM employees