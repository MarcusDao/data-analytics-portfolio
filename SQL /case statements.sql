-- case statements

Select first_name, last_name,
Case
    When age <= 30 Then 'Young'
    When age between 30 and 50 Then 'Old'
    When age >= 50 Then 'Too old'
    
End AS Age_Bracket
From employee_demographics;

-- Pay Increase and Bonus
-- < 50000 = 5%
-- > 50000 = 7%
-- Finance = 10% bonus

Select Concat(first_name,' ', last_name) as Employee, salary,
Case
  When salary < 50000 Then salary + (salary*0.05)
  When salary > 50000 Then salary + (salary*0.07)
  When dept_id = 6 Then salary * 1.1
End as New_salary
From employee_salary;