SELECT *
FROM employees
WHERE manager_id IN (SELECT DISTINCT manager_id FROM employees WHERE department_id=20);

SELECT first_name
FROM employees
WHERE salary = (SELECT MAX(salary) from employees);
