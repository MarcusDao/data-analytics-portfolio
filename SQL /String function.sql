-- String functions

Select Length('skyfall');

Select first_name, length(first_name)
From employee_demographics
Order by 2
;

Select first_name, Upper(first_name)
From employee_demographics;

Select rtrim('        sky     ');

Select first_name, 
Left(first_name, 4),
Substring(birth_date,6,2) as birth_month
From employee_demographics;

-- replace
Select first_name, Replace(first_name,'a','z')
From employee_demographics;

Select locate('x','Alexander');

Select first_name, Locate('AN',first_name)
From employee_demographics;

Select first_name, last_name, 
Concat( first_name,' ', last_name)
From employee_demographics;


