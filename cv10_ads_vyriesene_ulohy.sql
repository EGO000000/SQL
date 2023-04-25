-- A
CREATE TABLE orders AS SELECT * FROM oe.orders;
CREATE TABLE order_items AS SELECT * FROM oe.order_items;
CREATE TABLE employees AS SELECT * FROM hr.employees;
CREATE TABLE departments AS SELECT * FROM hr.departments;
CREATE TABLE customers AS SELECT CUSTOMER_ID, CUST_FIRST_NAME, CUST_LAST_NAME, CREDIT_LIMIT, CUST_EMAIL, ACCOUNT_MGR_ID FROM oe.customers;

-- B
CREATE OR REPLACE TRIGGER remove_orders
BEFORE DELETE ON orders
FOR EACH ROW
BEGIN
  DELETE FROM order_items WHERE order_id = :old.order_id ;
END;
/

-- C
CREATE OR REPLACE VIEW department_list AS SELECT department_name, count(*) AS employees_count FROM departments JOIN employees USING(department_id) GROUP BY department_name;

-- D + E
CREATE OR REPLACE TRIGGER update_department_list
INSTEAD OF UPDATE ON department_list
FOR EACH ROW
BEGIN
    IF updating('employees_count') THEN
        raise_application_error(-20000, 'Count of employees cannot be modified');
    ELSIF updating('department_name') THEN
        UPDATE departments SET department_name = :new.department_name WHERE department_name = :old.department_name;
    END IF;
END;
/