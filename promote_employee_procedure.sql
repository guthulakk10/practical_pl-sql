CREATE OR REPLACE PROCEDURE promote_employee(
  employee_id_v IN NUMBER,
  new_job_id_v IN VARCHAR2
) AS
  new_salary NUMBER;
  start_date_variable DATE;
  department_id_variable NUMBER; -- Declare department_id_variable here
BEGIN
  -- Get the current date
  start_date_variable := SYSDATE;


SELECT department_id
INTO department_id_variable
FROM JOB_HISTORY
WHERE job_id = new_job_id_v
  AND ROWNUM = 1;


  -- Invoke the increase_salary function to get the new salary
  new_salary := increase_salary(employee_id_v, new_job_id_v);


  -- Update the job and salary in the employees table
  UPDATE employees
  SET job_id = new_job_id_v, salary = new_salary
  WHERE employee_id = employee_id_v;


  -- Update the job_history table
  INSERT INTO job_history(employee_id, start_date, end_date, job_id, department_id)
  VALUES (employee_id_v, start_date_variable - 5, start_date_variable, new_job_id_v, department_id_variable);


  COMMIT; -- Commit the transaction
END promote_employee;
/


DECLARE
  v_employee_id NUMBER := 
  v_new_job_id VARCHAR2(10) := 
BEGIN
  promote_employee(v_employee_id, v_new_job_id);
END;
/
