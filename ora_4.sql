CREATE TABLE logs AS
SELECT level log_id, dbms_random.string('a',100) cookie,
round(dbms_random.value() * (5000 - 1000) + 1000) nums,
round(dbms_random.value() * (206 - 100) + 100) employee_id
FROM dual CONNECT BY LEVEL <= 50000;

ALTER TABLE logs ADD CONSTRAINT log_pk PRIMARY KEY (log_id);
ALTER TABLE logs ADD CONSTRAINT log_fk
FOREIGN KEY (employee_id) REFERENCES employees (employee_id);

SELECT department_id, nums
FROM logs l INNER JOIN employees e ON l.employee_id = e.employee_id
WHERE nums > 3000;

SELECT department_name, SUM(salary)
FROM departments d INNER JOIN employees e
ON e.department_id = d.department_id
GROUP BY department_name HAVING SUM(salary) > 10000;