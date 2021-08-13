--Assignment1
SELECT FirstName,len(FirstName) AS NameLen FROM Employees WHERE FirstName LIKE 'A%' OR FirstName LIKE 'J%' OR FirstName LIKE 'M%'

--Assignment2
SELECT FirstName,REPLICATE('$', 10-LEN(Salary))+LEFT(Salary,10) AS SALARY FROM Employees

--Assignment3
SELECT EmployeeID,FirstName,LastName,HireDate FROM Employees WHERE DATEPART (day,HireDate) LIKE 07 OR DATEPART (mm,HireDate) LIKE 07

--Assignment4
SELECT LEN(FirstName) FROM Employees WHERE LastName LIKE '__c%'

--Assignment5
SELECT RIGHT(PhoneNumber,4) AS Digits FROM Employees

--Assignment6
UPDATE Employees SET PhoneNumber = REPLACE(PhoneNumber,'124','999')

--Assignment7
SELECT DATEDIFF(year,HireDate, GETDATE()) FROM Employees

--Assignment8
SELECT HireDate FROM Employees WHERE DATEPART(dw,HireDate) LIKE 1

--Assignment9
SELECT FirstName,HireDate FROM Employees WHERE CAST(HireDate AS varchar(10)) BETWEEN '1987-06-01' AND '1987--07-30'

--Assignment10
DECLARE @d varchar()
SET @d=CONVERT(varchar(50),GETDATE(),100)
SELECT RIGHT(@d,6)+' '+LEFT(@d,11)

--Assignment12
SELECT FirstName,LastName FROM Employees WHERE DATENAME(mm,HireDate) LIKE 'JUNE'

--Assignment13
SELECT FirstName, HireDate, DATEDIFF(year,HireDate,GETDATE()) AS experience FROM Employees

--Assignment14
SELECT FirstName FROM Employees WHERE DATEPART(year,HireDate) LIKE '1987'