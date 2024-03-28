
VALUES(280, 'Data Analytics', 1700);

SELECT * FROM departments WHERE department_id=280;

ROLLBACK;

CREATE TABLE managers AS
SELECT employee_id, first_name, job_id, salary, hire_date
FROM employees
WHERE 1=2;

INSERT INTO managers
(employee_id, first_name, job_id, salary, hire_date)
SELECT employee_id, first_name, job_id, salary, hire_date
FROM employees
WHERE job_id LIKE '%MAN';

CREATE TABLE emps AS SELECT * FROM employees;

ALTER TABLE emps
ADD(CONSTRAINT emps_emp_id_pk PRIMARY KEY(employee_id),
    CONSTRAINT emps_manager_fk FOREIGN KEY(manager_id)
                REFERENCES emps(employee_id)
);

SELECT employee_id, first_name, salary
FROM emps
WHERE employee_id=103;

UPDATE emps
SET salary=salary*1.1
WHERE employee_id=103;

UPDATE emps
SET(job_id, salary, manager_id) = 
    (SELECT job_id, salary, manager_id
    FROM emps
    WHERE employee_id = 108)
WHERE employee_id=109;

DELETE FROM emps
WHERE employee_id=104;

DELETE FROM emps
WHERE employee_id=103;

CREATE TABLE depts AS
    SELECT * FROM departments;
    
DELETE FROM emps
WHERE department_id=
                    (SELECT department_id
                    FROM depts
                    WHERE department_name='Shipping');
                    
CREATE TABLE emps_it AS SELECT * FROM employees WHERE 1=2;

INSERT INTO emps_it
    (employee_id, first_name, last_name, email, hire_date, job_id)
VALUES
    (105, 'David', 'Kim', 'DAVIDKIM', '06/03/04', 'IT_PROG');
    
MERGE INTO emps_it a
    USING (SELECT * FROM employees WHERE job_id='IT_PROG') b
    ON(a.employee_id = b.employee_id)
WHEN MATCHED THEN
    UPDATE SET
        a.phone_number = b.phone_number,
        a.hire_date = b.hire_date,
        a.job_id = b.job_id,
        a.salary = b.salary,
        a.commission_pct = b.commission_pct,
        a.manager_id = b.manager_id,
        a.department_id = b.department_id
    WHEN NOT MATCHED THEN
        INSERT VALUES
            (b.employee_id, b.first_name, b.last_name, b.email,
            b.phone_number, b.hire_date, b.job_id, b.salary,
            b.commission_pct, b.manager_id, b.department_id);

SELECT * FROM emps_it;

INSERT ALL
    INTO emp_salary VALUES
        (employee_id, first_name, salary, commission_pct)
    INTO emp_hire_date VALUES
        (employee_id, first_name, hire_date, department_id)
    SELECT * FROM employees;
    
SELECT * FROM emp_salary;
SELECT * FROM emp_hire_date;

CREATE TABLE emp_10 AS SELECT * FROM employees WHERE 1=2;
CREATE TABLE emp_20 AS SELECT * FROM employees WHERE 1=2;

INSERT ALL
    WHEN department_id=10 THEN
        INTO emp_10 VALUES
            (employee_id, first_name, last_name, email, phone_number,
            hire_date, job_id, salary, commission_pct, manager_id,
            department_id)
        WHEN department_id=20 THEN
            INTO emp_20 VALUES
                (employee_id, first_name, last_name, email, phone_number,
                hire_date, job_id, salary, commission_pct, manager_id,
                department_id)
        SELECT * FROM employees;
        
SELECT * FROM emp_10;
SELECT * FROM emp_20;

CREATE TABLE emp_sal5000 AS 
SELECT	employee_id,	first_name,	salary	FROM	employees	WHERE	1=2;
CREATE TABLE emp_sal10000 AS
SELECT	employee_id,	first_name,	salary	FROM	employees	WHERE	1=2;
CREATE TABLE emp_sal15000 AS
SELECT	employee_id,	first_name,	salary	FROM	employees	WHERE	1=2;
CREATE	TABLE	emp_sal20000	AS	
SELECT	employee_id,	first_name,	salary	FROM	employees	WHERE	1=2;
CREATE	TABLE	emp_sal25000	AS	
SELECT	employee_id,	first_name,	salary	FROM	employees	WHERE	1=2;



INSERT FIRST
    WHEN salary <= 5000 THEN
        INTO emp_sal5000 VALUES(employee_id, first_name, salary)
    WHEN salary <= 10000 THEN
        INTO emp_sal10000 VALUES(employee_id, first_name, salary)
    WHEN salary <= 15000 THEN
        INTO emp_sal15000 VALUES(employee_id, first_name, salary)
    WHEN salary <= 20000 THEN
        INTO emp_sal20000 VALUES(employee_id, first_name, salary)
    WHEN salary <= 25000 THEN
        INTO emp_sal25000 VALUES(employee_id, first_name, salary)
    SELECT employee_id, first_name, salary FROM employees;
    
SELECT	COUNT(*)	FROM	emp_sal5000;

DELETE FROM emps WHERE department_id=20;

SAVEPOINT delete_20;

DELETE FROM emps WHERE department_id=30;

ROLLBACK TO SAVEPOINT delete_20;
