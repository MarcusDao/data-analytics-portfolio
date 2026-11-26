-- Where Clause	

Select *
From employee_salary
Where salary >= 5000;
-- And or Not -- Logival operators
Select *
From employee_demographics
where (gender != 'Female' And age > 30)
Or birth_date > '1985-01-01';
-- Like statement
-- % and _
Select *
From employee_demographics
Where first_name LIKE '%a'
Or birth_date LIKE '1989%'

