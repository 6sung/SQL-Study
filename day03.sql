SELECT first_name, salary, rownum
FROM (
    SELECT first_name, salary
    FROM employees
    ORDER BY salary DESC
);

SELECT first_name, salary, ROW_NUMBER() OVER (ORDER BY salary DESC) AS rnum
FROM employees;

SELECT employee_id, department_id, salary,
    RANK() OVER(ORDER BY salary DESC) sal_rank,
    DENSE_RANK() OVER (ORDER BY salary DESC) sal_dense_rank,
    ROW_NUMBER() OVER (ORDER BY salary DESC) sal_number
    FROM employees
    ORDER BY sal_number;
    
SELECT employee_id, department_id, salary,
CUME_DIST() OVER (ORDER BY salary DESC) sal_cume_dist,
PERCENT_RANK() OVER(ORDER BY salary DESC) sal_pct_rank
FROM employees;

SELECT first_name, salary,
ROUND(RATIO_TO_REPORT(salary) OVER (), 4) AS salary_ratio
FROM employees
WHERE job_id = 'IT_PROG';

SELECT employee_id, department_id, salary,
NTILE(10) OVER (ORDER BY salary DESC) sal_quart_tile
FROM employees
WHERE department_id=50;

SELECT employee_id,
LAG(salary,1,0) OVER (ORDER BY salary) AS lower_sal,
salary,
LEAD(salary, 1,0) OVER (ORDER BY salary) AS higher_sal
FROM employees
ORDER BY salary;

SELECT department_id,
LISTAGG(first_name,', ') WITHIN GROUP(ORDER BY hire_date) AS names
FROM employees
GROUP BY department_id;

SELECT department_id, first_name, salary,
    SUM(salary) OVER(PARTITION BY department_id
                    ORDER BY salary
                    ROWS BETWEEN UNBOUNDED PRECEDING
                        AND CURRENT ROW) AS sum_rows
FROM employees;

SELECT 
    AVG(salary),
    REGR_AVGX(commission_pct, salary)
FROM employees;

SELECT
    DISTINCT
        department_id,
        REGR_COUNT(manager_id, department_id)
            OVER(partition by department_id) "REGR_COUNT"
FROM employees;

SELECT
    job_id, employee_id, salary,
    ROUND(SYSDATE-hire_date) "WORKING_DAY",
    ROUND(REGR_SLOPE(salary, SYSDATE-hire_date)
        OVER(PARTITION BY job_id), 2) "REGR_SLOPE",
    ROUND(REGR_INTERCEPT(salary, SYSDATE-hire_date)
        OVER(PARTITION BY job_id), 2) "REGR_INTERCEPT"
FROM employees
WHERE department_id = 80
ORDER BY job_id, employee_id;

SELECT
    DISTINCT
    job_id,
    ROUND(REGR_SLOPE(salary, SYSDATE-hire_date)
        OVER(PARTITION BY job_id), 2) "REGR_SLOPE",
    ROUND(REGR_INTERCEPT(salary, SYSDATE-hire_date)
        OVER(PARTITION BY job_id), 2) "REGR_INTERCEPT",
    ROUND(REGR_R2(salary, SYSDATE-hire_date)
        OVER(PARTITION BY job_id), 2) "REGR_R2"
FROM employees
WHERE department_id = 80;

CREATE TABLE sales_data(
employee_id NUMBER(6),
week_id NUMBER(2),
week_day VARCHAR2(10),
sales NUMBER(8,2)
);

INSERT INTO sales_data values(1101, 4, 'SALES_MON', 100);
INSERT INTO sales_data values(1101, 4, 'SALES_TUE', 150);
INSERT INTO sales_data values(1101, 4, 'SALES_WED', 80);
INSERT INTO sales_data values(1101, 4, 'SALES_THU', 60);
INSERT INTO sales_data values(1101, 4, 'SALES_FRI', 120);
INSERT INTO sales_data values(1102, 5, 'SALES_MON', 300);
INSERT INTO sales_data values(1102, 5, 'SALES_TUE', 300);
INSERT INTO sales_data values(1102, 5, 'SALES_WED', 230);
INSERT INTO sales_data values(1102, 5, 'SALES_THU', 120);
INSERT INTO sales_data values(1102, 5, 'SALES_FRI', 150);

commit;
select * from sales_data;

CREATE TABLE sales(
employee_id NUMBER(6),
week_id NUMBER(2),
sales_mon NUMBER(8,2),
sales_tue NUMBER(8,2),
sales_wed NUMBER(8,2),
sales_thu NUMBER(8,2),
sales_fri NUMBER(8,2)
);

INSERT INTO sales VALUES(1101, 4, 100, 150, 80, 60, 120);
INSERT INTO sales VALUES(1102, 5, 300, 300, 230, 120, 150);

COMMIT;
SELECT * FROM sales;

SELECT *
FROM sales_data
PIVOT
(
    sum(sales)
    FOR week_day IN('SALES_MON' AS sales_mon,
                    'SALES_TUE' AS sales_tue,
                    'SALES_WED' AS sales_wed,
                    'SALES_THU' AS sales_thu,
                    'SALES_FRI' AS sales_fri)
)
ORDER BY employee_id, week_id;

SELECT employee_id, week_id, week_day, quantity
FROM sales
UNPIVOT
(
    quantity
    FOR week_day
    IN(sales_mon, sales_tue,sales_wed,sales_thu, sales_fri)
);

SELECT e.first_name, e.department_id, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id;

SELECT e.first_name, e.salary, j.job_title
FROM employees e, jobs j
WHERE e.salary
BETWEEN j.min_salary AND j.max_salary;

SELECT e.first_name AS employee_name,
m.first_name AS manager_name
FROM employees e, employees m
WHERE e.manager_id = m.employee_id AND e.employee_id=103;

SELECT e.employee_id, e.first_name, e.hire_date,
        j.start_date, j.end_date, j.job_id, j.department_id
FROM employees e, job_history j
WHERE e.employee_id = j.employee_id(+)
ORDER BY j.employee_id;

SELECT first_name, department_name
FROM employees
NATURAL JOIN departments;

SELECT first_name, department_name
FROM employees
JOIN departments
USING(department_id);

SELECT department_name, street_address, city, state_province
FROM departments d
JOIN locations l
ON d.location_id=l.location_id;

SELECT e.first_name, d.department_name,
l.street_address || ', ' || l.city || ', ' || l.state_province
AS address
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN locations l ON d.location_id=l.location_id;

SELECT e.first_name AS name, d.department_name AS department
FROM employees e
JOIN departments d
ON e.department_id=d.department_id
WHERE employee_id = 103;

SELECT e.first_name AS name, d.department_name AS department,
l.street_address || ', ' || l.city || ', ' || l.state_province
AS address
FROM employees e
JOIN departments d
ON e.department_id=d.department_id
JOIN locations l
ON d.location_id=l.location_id
WHERE employee_id = 103;

SELECT e.first_name AS name,
d.department_name AS department
FROM employees e
JOIN departments d
ON e.department_id=d.department_id AND employee_id=103;

SELECT e.employee_id, e.first_name, e.hire_date,
j.start_date, j.end_date, j.job_id, j.department_id
FROM employees e
LEFT OUTER JOIN job_history j
ON e.employee_id = j.employee_id
ORDER BY j.employee_id;

SELECT first_name, department_name
FROM employees JOIN departments on employees.department_id=departments.department_id
ORDER BY first_name;
--스칼라 사용시
SELECT first_name, (SELECT department_name from departments d WHERE d.department_id=e.department_id) dept_name
FROM employees e
ORDER BY first_name;

SELECT first_name, salary, ROWNUM FROM employees
ORDER BY salary desc;
--인라인뷰
SELECT first_name, salary, rnum
FROM(    SELECT first_name, salary, ROWNUM AS rnum
    FROM(SELECT first_name, salary from employees 
        ORDER BY salary desc
    ) 
)
WHERE rnum BETWEEN 5 and 10;

SELECT first_name, salary
FROM employees
WHERE salary > (SELECT salary FROM employees WHERE first_name='Nancy');

SELECT first_name, job_id, hire_date
FROM employees
WHERE job_id = (SELECT job_id
                FROM employees
                WHERE employee_id=103);
                
SELECT first_name, salary
FROM employees
WHERE salary > (SELECT salary FROM employees WHERE first_name = 'David');

SELECT first_name ,salary
FROM employees
WHERE salary > ANY (SELECT salary FROM employees WHERE first_name='David');

SELECT first_name, department_id, job_id
FROM employees
WHERE department_id IN (SELECT department_id
                        FROM employees
                        WHERE first_name='David');
                        
SELECT first_name, department_id, job_id
FROM employees e
WHERE EXISTS(SELECT * FROM departments d WHERE d.manager_id=e.employee_id);

SELECT first_name, salary
FROM employees a
WHERE salary > (SELECT avg(salary)
                FROM employees b
                WHERE b.department_id=a.department_id);
