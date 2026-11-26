-- Unions

Select first_name, last_name
From employee_demographics
Union distinct -- or Union all
Select first_name, last_name
From employee_salary
;

Select first_name, last_name, 'Old' as label
From employee_demographics
Where age > 40
Union
Select first_name, last_name, 'Highly paid' as label
From employee_salary
Where salary > 70000
Order by first_name, last_name
;
