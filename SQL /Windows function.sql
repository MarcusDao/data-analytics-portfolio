-- windows function

Select gender, AVG(salary) as avg_salary
From employee_demographics dem
Join employee_salary sal
On dem.employee_id = sal.employee_id
Group by gender
;


Select dem.first_name, dem.last_name, gender, AVG(salary) over(Partition by gender)
From employee_demographics dem
Join employee_salary sal
On dem.employee_id = sal.employee_id;


Select dem.first_name, dem.last_name, gender, salary,
Sum(salary) over(Partition by gender Order by dem.employee_id) as Rolling_total
From employee_demographics dem
Join employee_salary sal
On dem.employee_id = sal.employee_id;


Select dem.first_name, dem.last_name, gender, salary,
Row_number() Over(partition by gender Order by salary desc) as row_num,
Rank() Over(partition by gender Order by salary desc) as rank_num,
Dense_Rank() Over(partition by gender Order by salary desc) as dense_rank_num
From employee_demographics dem
Join employee_salary sal
On dem.employee_id = sal.employee_id;



























