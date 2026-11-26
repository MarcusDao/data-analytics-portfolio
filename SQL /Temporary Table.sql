-- Temporary Tables

CREATE TEMPORARY TABLE temp_table 
(first_name varchar(50),
last_name varchar(50), 
favorite_movie varchar(100)
);

Select *
From temp_table;

Insert into temp_table
Values('Alex', 'Freberg', 'Lord of the rings: The two towers');

Select *
From employee_salary;

Create temporary table salary_over_50k
Select * 
From employee_salary
Where salary >= 50000;
Select *
From salary_over_50k;



