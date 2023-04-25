-- A
SELECT first_name || ' ' || last_name as name, concat(email,'@tuke.sk') as email, job_title, hire_date FROM HR.employees
    JOIN HR.jobs ON HR.employees.job_id = HR.jobs.job_id;

-- B
SELECT first_name || ' ' || last_name as name, phone_number, hire_date FROM HR.employees
    JOIN HR.departments ON HR.employees.department_id = HR.departments.department_id
    WHERE department_name = 'IT' AND months_between(sysdate,hire_date)/12 > 14;

-- Ca
SElECT first_name || ' ' || last_name as name, phone_number, job_title, hire_date FROM hr.employees
    NATURAL JOIN hr.jobs
    WHERE salary between 2000 and 7000;

-- Cb
SELECT * FROM HR.employees
    JOIN HR.departments ON HR.employees.department_id = HR.departments.department_id   
    WHERE department_name = 'IT' and months_between(sysdate,hire_date)/12 > 14
    ORDER BY (last_name || ' ' || first_name),hire_date;

-- D
SELECT department_name FROM hr.departments
--where is not null -> kvolli oraclu kedze vracia false ak je v liste niekde null
    WHERE hr.departments.department_id not in (select department_id from hr.employees where department_id IS NOT NULL);  

-- E  
SELECT HR.employees.first_name, HR.employees.last_name , (managers.first_name || ' ' || managers.last_name) as manager FROM HR.employees
    LEFT OUTER JOIN HR.employees managers on HR.employees.manager_id = managers.employee_id;
--rekurzivne
with empl(employee_id,first_name,last_name,manager_id) as (
   select employee_id, first_name, last_name, manager_id
   from HR.employees where manager_id is NULL
   union all
   select child.employee_id, child.first_name, child.last_name, child.manager_id
   from HR.employees child join empl parent ON parent.employee_id = child.manager_id
)
select first_name,last_name, (select HR.employees.first_name || ' ' || HR.employees.last_name as name from HR.employees where HR.employees.employee_id = empl.manager_id) as manager
from empl;

-- F
SELECT first_name || ' ' || last_name as name, job_title, department_name FROM hr.employees
    JOIN hr.departments on HR.departments.department_id = hr.employees.department_id
    JOIN hr.jobs on HR.jobs.job_id = hr.employees.job_id;

-- G
SELECT first_name, last_name, concat(email,concat('@tuke.',decode(HR.locations.country_id, 'US', 'us',
                                                                    'UK', 'co.uk',
                                                                    'CA', 'ca',
                                                                    'DE', 'de'))) as email,
street_address, department_name, city, country_name FROM hr.employees
    JOIN hr.departments on HR.departments.department_id = hr.employees.department_id
    JOIN HR.locations on HR.departments.location_id = hr.locations.location_id
    JOIN hr.countries on HR.locations.country_id = hr.countries.country_id;