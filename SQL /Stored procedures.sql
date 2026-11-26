-- Stored Procedures
Select *
From employee_salary
Where salary >= 50000
;


Create procedure large_salary()
Select *
From employee_salary
Where salary >= 50000
;

Call large_salary();

Delimiter $$ 
Create procedure large_salary2()
Begin
Select *
From employee_salary
Where salary >= 50000;

Select *
From employee_salary
Where salary >= 10000;
End $$
Delimiter ;

Call large_salary2();


Delimiter $$ 
Create procedure large_salaries3(employee_id_output INT)
Begin
Select salary
From employee_salary
Where employee_id = employee_id_output
;

End $$
Delimiter ;

Call large_salaries3(1)


