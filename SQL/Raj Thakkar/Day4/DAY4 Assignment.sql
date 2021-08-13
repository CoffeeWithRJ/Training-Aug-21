--Assignment1
SELECT RANK() OVER(ORDER BY Salary DESC) AS SRank, Salary FROM Employees

--Assignment 2
SELECT * FROM (SELECT DENSE_RANK() OVER(ORDER BY Salary DESC) AS DRANK,* FROM Employees)T WHERE DRANK=4

--Assignment 3
SELECT DepartmentID, SUM(Salary) AS TotalSalary FROM Employees GROUP BY DepartmentID

--Assignment4
SELECT DepartmentID, SUM(Salary) AS TotalSalary FROM Employees GROUP BY DepartmentID ORDER BY TotalSalary DESC

--Assignment5
SELECT DepartmentID, MAX(Salary) AS MaxS FROM Employees GROUP BY DepartmentID ORDER BY MaxS ASC

--Assignment 6
SELECT DepartmentID, MIN(Salary) AS MinS FROM Employees GROUP BY DepartmentID ORDER BY MinS ASC

--Assignment 7
SELECT DepartmentID, SUM(Salary) AS TotSalary FROM Employees 
GROUP BY DepartmentID HAVING SUM(Salary) > 50000
ORDER BY TotSalary DESC
