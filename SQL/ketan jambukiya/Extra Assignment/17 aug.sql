USE AUG

QUERY 1

--List Names of CUSTOMER who are Deposit_Tableors and have Same Branch City as that of SUNIL

SELECT Cname,Bname  FROM DEPOSITE 
WHERE Bname IN (SELECT BNAME FROM BRANCH 
WHERE CITY= (SELECT CITY FROM BRANCH 
WHERE BNAME=(SELECT  Bname FROM DEPOSITE WHERE CNAME='SUNIL')))


SELECT d.Cname as customer,b.BNAME  
FROM DEPOSITE d JOIN BRANCH b on d.Bname=B.BNAME 
WHERE CITY= (SELECT CITY FROM BRANCH 
WHERE BNAME=(SELECT  Bname FROM DEPOSITE WHERE CNAME='SUNIL'))

QUERY 2

--List All the Depositors Having Depositors Having Deposit in All the Branches WHERE SUNIL is Having Account

SELECT * FROM DEPOSITE WHERE Bname IN 
(SELECT Bname FROM DEPOSITE WHERE Cname='sunil' UNION 
SELECT BNAME FROM BORROW WHERE CNAME='SUNIL')


SELECT * FROM DEPOSITE D JOIN BRANCH B ON D.Bname=B.BNAME 
WHERE Cname=( SELECT Cname FROM DEPOSITE 
WHERE Bname = (SELECT Bname FROM DEPOSITE WHERE Cname='sunil' ))

QUERY 3

--List the Names of Customers Living in the City WHERE the Maximum Number of Depositors are Located

SELECT CNAME FROM CUSTOMER WHERE CITY IN 
(SELECT CITY FROM (SELECT TOP(1) CITY,COUNT(CITY) AS  COUNT FROM CUSTOMER
  WHERE CNAME IN( SELECT Cname FROM DEPOSITE) GROUP BY CITY  ORDER BY COUNT DESC )tmp)

QUERY 4

--List Names of Borrowers Having DeposiT Amount Greater than 1000 and Loan Amount Greater than 2000

SELECT CNAME FROM BORROW WHERE AMOUNT>2000 and CNAME IN
 (SELECT Cname FROM DEPOSITE WHERE Amount>1000)  

QUERY 5

--List All the Customers Living in NAGPUR and Having the Branch City as MUMBAI or DELHI

SELECT CNAME FROM CUSTOMER WHERE CITY='NAGPUR' AND CNAME IN
(SELECT Cname FROM DEPOSITE WHERE Bname IN
 (SELECT BNAME FROM BRANCH WHERE CITY IN('MUMBAI','DELHI')))

QUERY 6

--Count the Number of Customers Living in the City WHERE Branch is Located

SELECT CNAME,CITY FROM CUSTOMER WHERE CITY IN (SELECT CITY FROM BRANCH) 