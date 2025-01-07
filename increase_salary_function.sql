--The purpose of this function is to estimate the increased salary of a promoted employee.
--The promoted salary will either be 1.5 * the original salary or the equivalent or the average salary of all employees within the new job.
CREATE OR REPLACE FUNCTION increase_salary(
   -- The input varialbes will be the employee_id to receive their original salary along with their potential new job id.
 employee_id_variable IN NUMBER,
 new_job_id_variable IN VARCHAR2
) RETURN NUMBER AS
 old_salary_variable NUMBER;
 new_salary_variable NUMBER;
 new_job_avg_salary_variable NUMBER;
BEGIN
 -- This will get the old salary.
 SELECT salary
 INTO old_salary_variable
 FROM employees
 WHERE employee_id = employee_id_variable;


 -- This will calculate the average salary for the new job
 SELECT AVG(salary) INTO new_job_avg_salary_variable
FROM employees
WHERE job_id = new_job_id_variable;




 -- The purpose of this if or else statement is to calculate the new salary.
 -- Based on this conditions. if the old salary increased by 15 percent will be higher than the new job average salary, this salary will be fixed.
IF old_salary_variable * 1.15 > new_job_avg_salary_variable THEN
 new_salary_variable := old_salary_variable * 1.15;
ELSE
  -- Based on this condition. If the average salary for the new job is higher than an increased old salary, then this will be the fixed salary.
 new_salary_variable := new_job_avg_salary_variable;
END IF;




 -- This will the new salary
 RETURN new_salary_variable;
END increase_salary;
/


DECLARE
 employee_id_variable NUMBER := 149;
 new_job_id_variable VARCHAR2(10) := 'AD_VP';
 old_salary_variable NUMBER;
 new_salary_variable NUMBER;
BEGIN
 -- This will call the increase_salary function
 new_salary_variable := increase_salary(employee_id_variable => employee_id_variable, new_job_id_variable => new_job_id_variable);


 -- This will retrieve the old salary for comparison
 SELECT salary
 INTO old_salary_variableg
 FROM employees
 WHERE employee_id = employee_id_variable;


 --This will print out the results.
 DBMS_OUTPUT.PUT_LINE('Old Salary: ' || TO_CHAR(old_salary_variable));
 DBMS_OUTPUT.PUT_LINE('New Salary: ' || TO_CHAR(new_salary_variable));
END;
/
