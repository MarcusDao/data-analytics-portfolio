-- Triggers and Events

Select *
From employee_demographics;

Select *
From employee_salary;


Delimiter $$
Create trigger employee_insert
       After insert on employee_salary
       For each Row
Begin
    Insert into employee_demographics (employee_id, first_name, last_name)
    Values (NEW.employee_id, NEW.first_name, NEW.last_name);
End $$
Delimiter ;

Insert into employee_salary (employee_id, first_name, last_name, occupation, salary, dept_id)
Values(13, 'Jean-Ralphio', 'Saperstein', 'Entertainment 720 CEO', 1000000, Null);



-- Events
Select *
From employee_demographics;

Delimiter $$
Create Event delete_retirees
On schedule every 30 second
Do
Begin
    Delete
    From employee_demographics
    Where age >= 60;
End $$
Delimiter ;

Show variables like 'event%'
