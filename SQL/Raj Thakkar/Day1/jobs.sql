CREATE TABLE jobs (
JobId int PRIMARY KEY IDENTITY(1,1),
JobTitle VARCHAR(50) DEFAULT '',
MinSalary int DEFAULT'8000',
MaxSalary int DEFAULT NULL
)
select * FROM jobs
INSERT INTO jobs(MinSalary) VALUES ('9000')