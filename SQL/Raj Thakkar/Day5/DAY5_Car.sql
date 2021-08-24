CREATE TABLE car
(
carid INT PRIMARY KEY IDENTITY(1,1),
vin INT NOT NULL UNIQUE,
make VARCHAR(30) NOT NULL,
model VARCHAR(30),
[year] DATE,
mileage DECIMAL(10,2) NOT NULL,
askprice MONEY NOT NULL,
invoiceprice MONEY NOT NULL
)

SELECT * FROM car
INSERT INTO car VALUES (1,'Toyota','Camry','2021',4,3700000,3600000),
                       (2,'Toyota','Yaris','2021',18,1400000,900000),
                       (3,'Toyota','Glanza','2021',20,900000,700000),
                       (4,'Toyota','Innova','2021',11,1800000,1600000),
                       (5,'Honda','City','2021',18,1400000,1200000),
                       (6,'Ferrari','Roma','2021',8.93,38000000,37000000)

CREATE TABLE dealership
(
dealershipid INT PRIMARY KEY IDENTITY(1,1),
name VARCHAR(30) NOT NULL,
address VARCHAR(50) NOT NULL,
city VARCHAR(30) NOT NULL,
state VARCHAR(30) NOT NULL
)

INSERT INTO dealership VALUES('Hero Honda Car World','Ranip','Ahmedabad','Gujarat'),
                              ('Concept Hyundai','Dharavi','Mumbai','Maharashtra'),
							  ('Toyota Performance','Ranip','Ahmedabad','Gujarat'),
							  ('Ferrari Sale','Dugh','Palampur','Himachal')

CREATE TABLE salesperson
(
salespersonid INT PRIMARY KEY IDENTITY(1,1), 
name VARCHAR(30) NOT NULL
)

INSERT INTO salesperson VALUES('Adam Smith'),
                               ('John Smith'),
							   ('Ben Smith')

CREATE TABLE Car_Customer
(
customerid INT PRIMARY KEY IDENTITY(1,1), 
name VARCHAR(30) NOT NULL,
address VARCHAR(100) NOT NULL,
city VARCHAR(30) NOT NULL,
state VARCHAR(30) NOT NULL
)

INSERT INTO Car_Customer Values('Jay','Ranip','Ahmedabad','Gujarat'),
                               ('Ann','Laban','Shillong','Meghalaya'),
							   ('Ashi','Malan','Palampur','Himachal'),
							   ('Sanvi','Ranip','Ahmedabad','Gujarat')

CREATE TABLE reportsto
(
reportstoid INT PRIMARY KEY IDENTITY(1,1),
salespersonid  INT CONSTRAINT fk_SALESPERSON FOREIGN KEY (salespersonid) REFERENCES salesperson(salespersonid) ON DELETE CASCADE ON UPDATE CASCADE,
managingsalespersonid INT
)

INSERT INTO reportsto VALUES(1,NULL),
                            (2,1),
							(3,1)
							

CREATE TABLE worksat
(
worksatid INT PRIMARY KEY IDENTITY(1,1),
salespersonid  INT CONSTRAINT FK1_SALESPERSON FOREIGN KEY (salespersonid) REFERENCES salesperson(salespersonid) ON DELETE CASCADE ON UPDATE CASCADE,
managingsalespersonid INT,
dealershipid INT CONSTRAINT FK_dealershipid FOREIGN KEY (dealershipid) REFERENCES dealership(dealershipid) ON DELETE CASCADE ON UPDATE CASCADE,
monthworked DATE,
basesalaryformonth MONEY NOT NULL
)

INSERT INTO worksat VALUES(1,1,4,'January 2010',20000),
                          (2,2,2,'Feb 2010',20000),
						  (3,3,3,'Mar 2010',20000),
						  (1,1,4,'Apr 2010',20000),
						  (2,2,1,'June 2010',20000)
						  TRUNCATE TABLE worksat
CREATE TABLE inventory
(
inventoryid INT PRIMARY KEY IDENTITY(1,1),
vin INT CONSTRAINT FK_vin FOREIGN KEY (vin) REFERENCES car(vin) ON DELETE CASCADE ON UPDATE CASCADE,
dealershipid INT CONSTRAINT FK1_dealershipid FOREIGN KEY (dealershipid) REFERENCES dealership(dealershipid) ON DELETE CASCADE ON UPDATE CASCADE
)

INSERT INTO inventory VALUES(1,3),
                            (2,2),
							(1,3),
							(4,4),
							(5,1),
							(6,1)
TRUNCATE TABLE inventory 
SELECT * FROM inventory
CREATE TABLE sale
(saleid INT PRIMARY KEY IDENTITY(1,1),
vin INT CONSTRAINT FK1_vin FOREIGN KEY (vin) REFERENCES car(vin) ON DELETE CASCADE ON UPDATE CASCADE,
customerid INT CONSTRAINT FK_customerid FOREIGN KEY (customerid) REFERENCES Car_Customer(customerid) ON DELETE CASCADE ON UPDATE CASCADE,
salespersonid INT CONSTRAINT FK2_salespersonid FOREIGN KEY (salespersonid) REFERENCES salesperson(salespersonid) ON DELETE CASCADE ON UPDATE CASCADE,
dealershipid INT CONSTRAINT FK2_dealershipid FOREIGN KEY (dealershipid) REFERENCES dealership(dealershipid) ON DELETE CASCADE ON UPDATE CASCADE, 
saleprice MONEY not null, 
saledate  DATE,
)

INSERT INTO sale VALUES(6,4,3,4,900000,'January 1 2010'),
                       (5,3,3,3,1600000,'Mar 1 2010'),
					   (4,2,2,4,1200000,'January 1 2021'),
					   (3,1,2,3,37000000,'January 1 2021'),
					   (2,4,1,2,700000,'Mar 1 2021'),
					   (1,3,1,1,900000,'Mar 30 2021')
					   

--1. Find the names of all salespeople who have ever worked for the company at any dealership.
SELECT name FROM salesperson

--2. List the Name, Street Address, and City of each customer who lives in Ahmedabad.
SELECT name,address,city FROM Car_Customer WHERE city = 'Ahmedabad'

--3. List the VIN, make, model, year, and mileage of all cars in the inventory of the dealership named "Hero Honda Car World".
SELECT C.vin,C.make,C.model,C.[year],C.mileage FROM car C JOIN inventory I 
ON C.vin = I.vin JOIN dealership D  ON I.dealershipid = D.dealershipid WHERE D.name= 'Hero Honda Car World' 

--4. List names of all customers who have ever bought cars from the dealership named "Concept Hyundai".
SELECT C.name FROM Car_Customer C JOIN sale s  ON C.customerid = S.customerid 
JOIN dealership D ON S.dealershipid = D.dealershipid WHERE D.name= 'Concept Hyundai' 

--5. For each car in the inventory of any dealership, list the VIN, make, model, and year of the car, along with the name, city, and state of the dealership whose inventory contains the car.
SELECT C.vin,C.make,C.model,C.[year],D.name,D.city, D.state FROM car C JOIN inventory I ON C.vin = I.vin
JOIN dealership D ON  I.dealershipid = D.dealershipid 

--6. Find the names of all salespeople who are managed by a salesperson named "Adam Smith".
SELECT S.name FROM salesperson S JOIN reportsto R ON S.salespersonid = R.salespersonid
WHERE (SELECT salespersonid FROM salesperson WHERE name = 'Adam Smith') = R.managingsalespersonid 

--7. Find the names of all salespeople who do not have a manager.
SELECT S.name FROM salesperson S RIGHT JOIN reportsto R ON S.salespersonid = R.salespersonid
WHERE R.managingsalespersonid IS NULL

--8. Find the total number of dealerships.
SELECT COUNT(dealershipid) FROM dealership

--9. List the VIN, year, and mileage of all "Toyota Camrys" in the inventory of the dealership named "Toyota Performance". 
SELECT C.vin,C.[year],C.mileage FROM car C JOIN inventory I  ON C.vin = I.vin JOIN dealership D  ON I.dealershipid = D.dealershipid
WHERE D.name= 'Toyota Performance' AND C.make = 'Toyota' AND C.model = 'Camry'

--10. Find the name of all customers who bought a car at a dealership located in a state other than the state in which they live.
SELECT DISTINCT(C.name) FROM Car_Customer C JOIN sale S  ON C.customerid = S.customerid JOIN dealership D  ON S.dealershipid = D.dealershipid
WHERE C.state <> D.state

--11. Find the name of the salesperson that made the largest base salary working at the dealership named "Ferrari Sales" during January 2010.
SELECT S.name,MAX(W.basesalaryformonth) FROM salesperson S JOIN worksat W ON S.salespersonid = W.salespersonid 
JOIN dealership D ON W.dealershipid = D.dealershipid 
WHERE D.name = 'Ferrari Sale' AND DATENAME(MONTH,W.monthworked) + ' '+ DATENAME(YEAR,W.monthworked) = 'January 2010' 
GROUP BY S.name
--12. List the name, street address, city, and state of any customer who has bought more than two cars from all dealerships combined since January 1, 2010.
SELECT C.name,C.address,C.city,C.state FROM Car_Customer C JOIN sale S ON C.customerid = S.customerid
WHERE S.customerid > 2 AND FORMAT(S.saledate,'MMMM dd, yyyy')  = 'January 1, 2010'

--13. List the name, salesperson ID, and total sales amount for each salesperson who has ever sold at least one car.The total sales amount for a salesperson is the sum of the sale prices of all cars ever sold by that salesperson.
SELECT S.name,S.salespersonid,SUM(A.saleprice) AS 'sales amount' FROM salesperson S JOIN sale A ON S.salespersonid = A.salespersonid 
GROUP BY S.name,S.salespersonid

--14. Find the names of all customers who bought cars during 2010 who were also salespeople during 2010.For the purpose of this query,assume that no two people have the same name.
SELECT C.name FROM Car_Customer C JOIN sale S ON C.customerid = S.customerid JOIN worksat W ON S.salespersonid = W.salespersonid
WHERE DATENAME(YYYY,S.saledate) = '2010' AND DATENAME(YYYY,W.monthworked) = '2010'

--15. Find the name and salesperson ID of the salesperson who sold the most cars for the company at dealerships located in Gujarat between March 1, 2010 and March 31, 2010.
SELECT A.name, A.salespersonid FROM salesperson A JOIN sale B ON A.salespersonid = A.salespersonid 
JOIN dealership D ON B.dealershipid = D.dealershipid 
WHERE D.state = 'Gujarat' AND B.saledate BETWEEN '01/03/2021' AND '31/03/2021'

/*16. Calculate the payroll for the month of March 2010.
 * The payroll consists of the name, salesperson ID, and gross pay for each salesperson who worked that month.
 * The gross pay is calculated as the base salary at each dealership employing the salesperson that month, along with the total commission for the salesperson that month.
 * The total commission for a salesperson in a month is calculated as 5% of the profit made on all cars sold by the salesperson that month.
 * The profit made on a car is the difference between the sale price and the invoice price of the car. (Assume, that cars are never sold for less than the invoice price.)*/

SELECT A.name,A.salespersonid, SUM(B.saleprice-C.invoiceprice*0.05) + D.basesalaryformonth 'Payroll' FROM salesperson A JOIN sale B ON A.salespersonid = B.salespersonid JOIN car C ON B.vin = C.vin 
JOIN worksat D ON B.salespersonid = D.salespersonid
WHERE  FORMAT(B.saledate,'MMMM yyyy') = 'March 2010' AND  FORMAT(D.monthworked,'MMMM yyyy') = 'March 2010' GROUP BY B.salespersonid


