--A
select * from hr.employees
WHERE salary = (select max(salary) from hr.employees);


--B
select * from hr.employees 
where department_id = (select department_id from hr.departments where department_name = 'IT')
and salary = (select max(salary) from hr.employees 
    WHERE department_id = (select department_id from hr.departments where department_name = 'IT'));
 
-- C
select * from hr.jobs
where job_id not in (select job_id from hr.employees);

-- alebo takto 
select * from hr.jobs
where job_id not in (select job_id from hr.employees
    where employee_id not in (select employee_id from hr.job_history where end_date > sysdate));
 
 
-- D
select * from hr.employees
where department_id in (select department_id from hr.departments
    where location_id in (select location_id from hr.locations where city != 'Seattle'));


-- E
select * from hr.employees
where (manager_id, department_id) in (select manager_id, department_id from hr.departments);


-- F
select * from hr.employees 
where department_id in (select department_id from hr.departments
    where location_id in (select location_id from hr.locations 
        where country_id in (select country_id from hr.countries 
            where country_name = 'United States of America')))
and rownum <= 10;


-- G
select first_name, last_name, department_name, salary from hr.employees 
join hr.departments on hr.employees.department_id = hr.departments.department_id 
where salary = (select min(salary) from hr.employees where hr.employees.department_id = hr.departments.department_id);

-- alebo takto 
select e.*
from (select e.*, min(salary) over (partition by department_id) as minSalary, department_id as department
      from hr.employees e
     ) e
where e.salary = e.minSalary and e.department_id = e.department;


-- H
--kopia tabulky
create table employees as (select * from hr.employees);
--update platu
update employees set salary = salary * 1.1 where employee_id in (select employee_id from employees where salary < (select avg(salary) from employees));