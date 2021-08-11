--Assignment1
ALTER TABLE Employees DROP CONSTRAINT ukEmail
UPDATE Employees SET Email='not available'

--Assignment2
UPDATE Employees SET Email='not available', CommissionPct=0.10

--Assignment3
UPDATE Employees SET Email='not available', CommissionPct=0.10 WHERE DepartmentID=110

--Assignment4
UPDATE Employees SET Email='not available' WHERE DepartmentID=80 AND CommissionPct<0.20

--Assignment5
UPDATE Employees SET Email='not available' FROM Employees e join Departments d ON d.DepartmentID=e.DepartmentID WHERE D.DepartmentName='Accounting'

--Assignment6
UPDATE Employees SET Salary = CASE WHEN Salary<5000 THEN 8000 ELSE Salary END WHERE EmployeeID=105

--Assignment7
UPDATE Employees SET JobId='SH_CLERK' WHERE EmployeeID=118 AND DepartmentID=30 AND JobId<>'SH%'

--Assignment8
UPDATE Employees SET Salary = CASE WHEN DepartmentID=40 THEN Salary+(Salary*0.25) WHEN DepartmentID=90 THEN Salary+(Salary*0.15) WHEN DepartmentID=110 THEN Salary+(Salary*0.10) ELSE Salary END