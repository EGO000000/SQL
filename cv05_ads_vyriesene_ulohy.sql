--A
CREATE TABLE zamestnanci AS SELECT * FROM hr.employees;

-- B
ALTER TABLE zamestnanci 
    ADD CONSTRAINT employees_pk PRIMARY KEY (employee_id);

-- C
DESC zamestnanci; 

INSERT INTO zamestnanci (employee_id,last_name,email,hire_date,job_id)
    VALUES(98,'Rybansky','rybansky',sysdate,'HR_REP');

INSERT INTO zamestnanci (employee_id,last_name,email,hire_date,job_id)
    VALUES(99,'Dodatocny','dodatocny',sysdate,'HR_REP');

-- D
UPDATE zamestnanci
    SET salary = salary + 0.1 * salary;

-- E
DELETE FROM zamestnanci
    WHERE employee_id > 190;

-- F
SELECT * FROM zamestnanci
    WHERE salary > 500;

-- G
SELECT * FROM zamestnanci
    WHERE department_id = (select department_id from hr.departments where department_name = 'IT');

-- H
SELECT * FROM zamestnanci
    WHERE extract(month from hire_date) = 6;

-- I 
SELECT first_name, last_name, CONCAT(email,'@tuke.sk') from zamestnanci;