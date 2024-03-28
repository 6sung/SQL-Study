SELECT *
FROM employees
WHERE manager_id IN (SELECT DISTINCT manager_id FROM employees WHERE department_id=20);
-------------------------------------------------------------------------------------------------
SELECT first_name
FROM employees
WHERE salary = (SELECT MAX(salary) from employees);
-------------------------------------------------------------------------------------------------
SELECT rnum, first_name, salary
FROM(SELECT first_name, salary, rownum AS rnum
        FROM (SELECT first_name, salary
            FROM employees
            ORDER BY salary DESC)
        )
WHERE rnum between 3 and 5;
-------------------------------------------------------------------------------------------------
SELECT
    department_id, first_name, salary, 
        (SELECT ROUND(AVG(salary))
            FROM employees c
            WHERE c.department_id=a.department_id) AS avg_sal
FROM employees a
WHERE salary >= (SELECT AVG(salary)
                    FROM employees b
                    WHERE b.department_id=a.department_id)
ORDER BY department_id;
