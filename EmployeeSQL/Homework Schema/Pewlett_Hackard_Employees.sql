-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "departments" (
    "dept_no" VARCHAR   NOT NULL,
    "dept_name" VARCHAR   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "dept_emp" (
    "emp_no" INT   NOT NULL,
    "dept_no" VARCHAR   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);

CREATE TABLE "dept_manager" (
    "dept_no" VARCHAR   NOT NULL,
    "emp_no" INT   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);

CREATE TABLE "employees" (
    "emp_no" INT   NOT NULL,
    "birth_date" DATE   NOT NULL,
    "first_name" VARCHAR   NOT NULL,
    "last_name" VARCHAR   NOT NULL,
    "gender" VARCHAR(10)   NOT NULL,
    "hire_date" DATE   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "salaries" (
    "emp_no" INT   NOT NULL,
    "salary" INT   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);

CREATE TABLE "titles" (
    "emp_no" INT   NOT NULL,
    "title" VARCHAR   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "titles" ADD CONSTRAINT "fk_titles_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");



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


