-- Group By
Select * 
From employee_demographics;

Select gender,round(AVG(age)),Max(age),Min(age),Count(age)
From employee_demographics
Group by gender;

-- Order by
Select *
From employee_demographics
Order by first_name DESC; -- or ASC

Select *
From employee_demographics
Order by age;

-- Having vs Where
Select gender, AVG(age)
From employee_demographics
Group By gender
Having AVG(age) >40
;

Select occupation, AVG(salary)
From employee_salary
Where occupation Like '%manager%'
Group By occupation
Having AVG(salary)> 1700
;

-- Limit & Aliasing
Select *
From employee_demographics
Order by age desc
Limit 4; -- or 3,1

-- Aliasing
Select gender, AVG(age) as avg_age
From employee_demographics
Group by gender
Having avg_age>40
;

-- joint
Select *
From employee_demographics;

Select * 
From employee_salary as sal
Inner Join employee_demographics as dem
On dem.employee_id = sal.employee_id
;

Select dem. employee_id, age , occupation
From employee_salary as sal
Inner Join employee_demographics as dem
On dem.employee_id = sal.employee_id
;
-- Outer joints
Select *
From employee_salary as sal
Left Join employee_demographics as dem
On dem.employee_id = sal.employee_id
;

-- Self join

Select *
From employee_salary emp1
Join employee_salary emp2
On emp1.employee_id + 1 = emp2.employee_id
 ;
 
 -- joining multiple tables together

Select *
From employee_salary as sal
Inner Join employee_demographics as dem
On dem.employee_id = sal.employee_id
Left Join parks_departments pd
On sal.dept_id = pd.department_id
;

Select *
From parks_departments;
