-- subqueries

Select *
From employee_demographics
Where employee_id 
              IN ( Select employee_id
				From employee_salary
                Where dept_id = 1)
;


Select first_name, salary, 
(Select AVG(salary)
From employee_salary)
From employee_salary
;

Select gender, AVG(age), Max(age), Min(age), Count(age)
From employee_demographics
Group by gender;

Select AVG(max_age)
From 
(Select gender, 
AVG(age) as avg_age, 
Max(age) as max_age, 
Min(age) as min_age, 
Count(age) as count_age
From employee_demographics
Group by gender) as Agg_table
;

