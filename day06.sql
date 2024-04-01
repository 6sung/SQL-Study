-----6일차
SELECT * FROM user_sys_privs;
SELECT * FROM user_role_privs; 

CREATE VIEW emp_view_dept60
AS SELECT employee_id, first_name, last_name, job_id, salary
FROM employees
WHERE department_id=60;

DESC emp_view_dept60;

CREATE VIEW emp_dept60_salary
AS SELECT
    employee_id AS empno,
    first_name || ' ' || last_name AS name,
    salary AS monthly_salary
FROM employees
WHERE department_id=60;

CREATE OR REPLACE VIEW emp_dept60_salary
AS SELECT
    employee_id AS empno,
    first_name || ' ' || last_name AS name,
    job_id AS job,
    salary
FROM employees
WHERE department_id=60;

CREATE VIEW emp_view
AS SELECT
    e.employee_id AS id,
    e.first_name AS name,
    d.department_name AS department,
    j.job_title AS job
FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id
JOIN jobs j ON e.job_id = j.job_id;

DROP VIEW emp_dept60_salary;

CREATE TABLE emps AS SELECT * FROM employees;
CREATE OR REPLACE VIEW emp_dept60
AS SELECT * FROM emps WHERE department_id=60;

DELETE FROM emp_dept60 WHERE employee_id=104;
SELECT * FROM emps WHERE employee_id=104;

CREATE OR REPLACE VIEW emp_dept60
AS SELECT DISTINCT * FROM emps WHERE department_id=60;

DELETE FROM emp_dept60 WHERE employee_id=106;

CREATE OR REPLACE VIEW emp_dept60
AS SELECT
    employee_id,
    first_name || ', ' || last_name AS name,
    salary*12 AS annual_salary
FROM emps WHERE department_id=60;

UPDATE emp_dept60 SET annual_salary=annual_salary*1.1
WHERE employee_id=106;

DELETE FROM emp dept60 WHERE employee_id=106;

CREATE OR REPLACE VIEW emp_dept60
AS SELECT
    employee_id,
    first_name,
    last_name,
    email,
    salary
FROM emps WHERE department_id=60;

INSER INTO emp_dept60
VALUES (500,'jk','h','hjk',8000);

CREATE	OR	REPLACE	VIEW	emp_dept60
AS	SELECT	employee_id,	first_name,	hire_date,	salary,	department_id
FROM emps
WHERE department_id=60
WITH CHECK OPTION;

UPDATE	emp_dept60
SET	department_id=10
WHERE employee_id=105;

CREATE OR REPLACE VIEW emp_dept60
AS SELECT employee_id, first_name, hire_date, salary, department_id
FROM emps
WHERE department_id=60
WITH READ ONLY;

SELECT row_number, first_name, salary
FROM (SELECT first_name, salary,
        row_number() OVER (ORDER BY salary DESC) AS row_number
        FROM employees)
WHERE row_number BETWEEN 1 AND 10;

CREATE TABLE depts(
    deptno NUMBER(2),
    dname VARCHAR2(14),
    loc VARCHAR2(13),
    CONSTRAINT depts_deptno_pk PRIMARY KEY(deptno),
    CONSTRAINT depts_dname_uk UNIQUE(dname)
);

--시퀀스 생성
CREATE SEQUENCE depts_seq
    INCREMENT BY 1
    START WITH 91
    MAXVALUE 100
    NOCACHE
    NOCYCLE;
--시퀀스 확인
SELECT sequence_name, min_value, max_value,
        increment_by, last_number
FROM USER_SEQUENCES;

SELECT object_name
FROM user_objects
WHERE object_type='SEQUENCE';
--시퀀스 사용
INSERT INTO depts(deptno, dname, loc)
VALUES (depts_seq.NEXTVAL, 'MARKETING', 'SAN DIEGO');

SELECT * FROM depts;

SELECT depts_seq.CURRVAL
FROM dual;
--시퀀스 변경
ALTER SEQUENCE depts_seq
            MAXVALUE 99999;
--시퀀스 삭제
DROP SEQUENCE depts_seq;
DROP TABLE depts;
--IDENTITY COLUMN
CREATE TABLE depts(
    deptno NUMBER(2) GENERATED ALWAYS AS IDENTITY
                    (START WITH 10 INCREMENT BY 10),
    dname VARCHAR2(14),
    loc   VARCHAR2(13) UNIQUE,
    CONSTRAINT depts_deptno_pk PRIMARY KEY(deptno)
);
INSERT INTO depts(dname, loc)
VALUES('MARKETING','SAN DIEGO');

--인덱스 생성 전 실행계획
SELECT * FROM emps WHERE first_name='David';
--인덱스 실행 후 실행계획
CREATE INDEX emps_first_name_idx
ON          emps(first_name);
--인덱스 삭제
DROP INDEX emps_first_name_idx;
--인덱스 확인
SELECT ic.index_name, ic.column_name,
        ix.uniqueness
FROM USER_INDEXES ix, USER_IND_COLUMNS ic
WHERE ic.index_name = ix.index_name
AND ic.table_name = 'EMPLOYEES';
--비트맵 인덱스
CREATE BITMAP INDEX emps_comm_idx ON emps(commission_pct);
--Unique 인덱스
CREATE UNIQUE INDEX emps_email_idx ON emps(email);
--함수기반 인덱스
CREATE INDEX emps_annsal_idx
ON emps(COALESCE(salary+salary*commission_pct,salary));
--복합 인덱스
CREATE UNIQUE INDEX emps_name_indx
ON emps(first_name, last_name);

--동의어 생성
CREATE SYNONYM emp60
FOR emp_dept60;
--동의어 삭제
DROP SYNONYM emp60;
--13장 연습문제
CREATE SEQUENCE bbs_seq
    START WITH 1
    INCREMENT BY 1
    CACHE 20
    NOCYCLE;

CREATE INDEX idx_emp_realsal
ON emp(COALESCE(salary+salary*commission_pct,salary));
