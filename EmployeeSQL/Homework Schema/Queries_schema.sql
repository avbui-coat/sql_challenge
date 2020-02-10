----- list employees
CREATE VIEW employee_salary AS
SELECT e.emp_no, e.last_name, e.first_name, e.gender, s.salary
FROM employees AS e
JOIN salaries AS s
ON e.emp_no = s.emp_no;

-----List employees who were hired in 1986

CREATE VIEW employee_1986 AS
SELECT emp_no, first_name, last_name
FROM employees
WHERE hire_date >= '1986-01-01' AND hire_date <= '1986-12-31';

------- list manager
-- --department number, department name, the manager's employee number, last name, first name, and start and end employment dates.
CREATE VIEW list_mananger AS
SELECT m.dept_no, d.dept_name, m.emp_no, e.first_name, e.last_name, m.from_date, m.to_date
FROM dept_manager as m
LEFT JOIN employees as e
	ON m.emp_no = e.emp_no
	JOIN departments as d
	ON m.dept_no = d.dept_no;



------List the department of each employee

CREATE VIEW employees_department_list AS
SELECT de.emp_no, e.last_name, e.first_name, d.dept_name
FROM dept_emp as de
LEFT JOIN employees as e
ON de.emp_no = e.emp_no
	JOIN departments as d
	ON de.dept_no = d.dept_no;
	
----------- List all employees whose first name is "Hercules" and last names begin with "B."

CREATE VIEW employee_Hercules AS
SELECT emp_no, first_name, last_name
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';


---list all employees in Sales including their employee number, last name, first name, and department name
CREATE VIEW sales_emp AS
SELECT emp_no, last_name, first_name
FROM employees
WHERE emp_no IN
(	SELECT emp_no
	FROM dept_emp
	WHERE dept_no IN 
	(	SELECT dept_no
	 	FROM departments
	 	WHERE dept_name = 'Sales'
	)
);

---List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.

SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees AS e
INNER JOIN dept_emp AS de ON e.emp_no = de.emp_no
INNER JOIN departments AS d ON de.dept_no = d.dept_no
WHERE d.dept_no IN 
		(	SELECT d.dept_no
	 		FROM departments AS d
	 		WHERE d.dept_name = 'Sales' OR d.dept_name = 'Development'
		);

---In descending order, list the frequency count of employee last names, i.e., how many employees share each last name
SELECT last_name, COUNT(last_name) AS "last_name_count"
FROM employees
GROUP BY last_name
ORDER BY "last_name_count" DESC;