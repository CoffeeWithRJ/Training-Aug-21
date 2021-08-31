
--1. Write a query to find the names (first_name, last_name) and 
--salaries of the employees who have higher salary than the employee whose 
--last_name='Bull'. 

 SELECT (FirstName+' '+ LastName) AS Name,Salary 
 FROM Employees
 WHERE Salary > (
 SELECT Salary FROM Employees WHERE LastName = 'Bull')



--2. Find the names (first_name, last_name) of all employees who works in the IT department. 
SELECT (FirstName+' '+ LastName) AS Name
 FROM Employees
 WHERE DepartmentID IN (
 SELECT DepartmentID FROM Departments WHERE DepartmentName='IT')



--3. Find the names (first_name, last_name) of the employees who have a manager who works 
--for a department based in United States. 
SELECT (FirstName+' '+ LastName) AS Name 
 FROM Employees
 WHERE ManagerID IN (
 SELECT EmployeeID FROM Employees 
 Where DepartmentID IN (
 SELECT DepartmentID FROM Departments
 WHERE LocationID IN(
 SELECT LocationID FROM Locations WHERE CountryID='US' )))

--4. Find the names (first_name, last_name) of the employees who are managers. 

SELECT (FirstName+' '+ LastName) AS Name
FROM Employees
WHERE EmployeeID IN (
SELECT ManagerID FROM Employees)

--5. Find the names (first_name, last_name), salary of the employees whose salary is greater than the average salary. 
SELECT (FirstName+' '+ LastName) AS Name,Salary 
FROM Employees
WHERE Salary > (
SELECT AVG(Salary) FROM Employees)


--6. Find the names (first_name, last_name), salary of the employees whose salary is equal to the 
--minimum salary for their job grade. 
SELECT (FirstName+' '+ LastName) AS Name,Salary 
FROM Employees E
WHERE Salary = (
SELECT MIN(Salary) FROM Employees 
WHERE JobId IN (
SELECT JobID FROM JobHistory J
WHERE E.JobId= J.JobID ))


--7. Find the names (first_name, last_name), salary of the employees who earn more than the average salary 
--and who works in any of the IT departments. 
SELECT (FirstName+' '+ LastName) AS Name,Salary 
FROM Employees 			
WHERE Salary > (
SELECT AVG(Salary) FROM Employees 
WHERE DepartmentID IN (
SELECT DepartmentID FROM Departments 
WHERE DepartmentName='IT'))
			

--8. Find the names (first_name, last_name), salary of the employees who earn more than Mr. Bell.
SELECT (FirstName+' '+ LastName) AS Name,Salary 
FROM Employees 
WHERE Salary > (
SELECT Salary FROM Employees WHERE LastName='Bell')

--9. Find the names (first_name, last_name), salary of the employees who earn the same salary as the 
--minimum salary for all departments. 
SELECT (FirstName+' '+ LastName) AS Name,Salary 
FROM Employees 
WHERE Salary = (
SELECT MIN(Salary) FROM Employees )


--10. Find the names (first_name, last_name), salary of the employees whose salary greater than average salary of all department.
SELECT (FirstName+' '+ LastName) AS Name,Salary 
FROM Employees			
WHERE Salary > ALL (
SELECT AVG(Salary) FROM Employees GROUP BY DepartmentID)


--11. Write a query to find the names (first_name, last_name) and salary of the employees who earn a 
--salary that is higher than the salary of all the Shipping Clerk (JOB_ID = 'SH_CLERK'). 
--Sort the results on salary from the lowest to highest. 
SELECT (FirstName+' '+ LastName) AS Name,Salary 
FROM Employees
WHERE Salary >ALL(
SELECT Salary FROM Employees WHERE JobId ='SH_CLERK') 
ORDER BY Salary ASC
	

--12. Write a query to find the names (first_name, last_name) of the employees who are not supervisors. 
SELECT (FirstName+' '+ LastName) AS Name
FROM Employees E
WHERE EmployeeID  NOT IN (
SELECT M.ManagerID FROM Employees AS M
WHERE E.ManagerID = M.EmployeeID)


--13. Write a query to display the employee ID, first name, last names, and department names of all employees. 
SELECT (FirstName+' '+ LastName) AS Name, 
FROM Employees	
(Select DepartmentName from Departments as d where e.DepartmentID = d.DepartmentID ) as Department 
			From Employees as e
			




--14. Write a query to display the employee ID, first name, last names, salary of all employees 
--whose salary is above average for their departments. 

	Select EmployeeID, FirstName, LastName, Salary from Employees as e
			Where Salary > (Select Avg(Salary) From Employees Where DepartmentID = e.DepartmentID ) Order by Salary DESC





--15. Write a query to fetch even numbered records from employees table. 

	Select EmployeeID  from Employees
			Where (EmployeeID % 2)=0



--16. Write a query to find the 5th maximum salary in the employees table. 

	Select Salary from Employees e1
		Where 5 = (Select Count(Salary) from Employees e2
							Where e2.Salary >= e1.Salary )
					

--17. Write a query to find the 4th minimum salary in the employees table. 

		Select Distinct Salary From Employees e1
				Where 4 = (Select Count(Distinct Salary) From Employees e2
									Where e2.Salary <= e1.Salary)


--18. Write a query to select last 10 records from a table. 

	Select TOP(10) * from Employees ORDER BY EmployeeID DESC 
			



--19. Write a query to list department number, name for all the departments in which there are no employees in the department.

	Select DepartmentID, DepartmentName from Departments
			Where DepartmentID NOT IN (Select DepartmentID from Employees)
			



--20. Write a query to get 3 maximum salaries. 

	Select Distinct TOP(3) Salary from Employees Order By Salary DESC
				


--21. Write a query to get 3 minimum salaries. 

	Select Distinct TOP(3) Salary from Employees Order By Salary ASC

--22. Write a query to get nth max salaries of employees.

	Select Distinct Salary from Employees e1
				Where N = (Select Count(Distinct Salary) 
									from Employees e2
									Where e2.Salary >= e1.Salary)
							Order by e1.Salary
												





Select * from Employees
Select * from Departments
Select * from JobHistory

Select * from Locations


				

