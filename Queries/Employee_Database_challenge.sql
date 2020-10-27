SELECT e.emp_no, e.first_name, e.last_name
FROM employees as e

SELECT ti.title, ti.from_date, ti.to_date
FROM titles as ti

CREATE TABLE title_table (
	emp_no INT NOT NULL,
	first_name VARCHAR (12) NOT NULL,
	last_name VARCHAR (12) NOT NULL,
	birth_date DATE NOT NULL,
	title VARCHAR (20) NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
    PRIMARY KEY (emp_no),
    UNIQUE (title)
);

SELECT employees.emp_no,
	employees.first_name,
	employees.last_name,
	employees.birth_date,
	titles.title,
	titles.from_date,
	titles.to_date
INTO title_table
FROM employees
INNER JOIN titles
ON employees.emp_no = titles.emp_no
WHERE (employees.birth_date BETWEEN '1952-01-01' AND '1955-12-31');

drop table new_title_table
select * FROM title_table
drop table title_table

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) title_table.emp_no,
title_table.first_name,
title_table.last_name,
title_table.title
INTO unique_title_table
FROM title_table
ORDER BY emp_no, to_date DESC, title;

drop table unique_title_table
SELECT COUNT(u.title)
FROM unique_title_table as u


-----

--create table retirement titles
SELECT (COUNT(u.title)), u.title
INTO retirement_titles
FROM unique_title_table as u
GROUP BY u.title
ORDER BY (COUNT(u.title)) DESC;


SELECT * from retirement_titles

drop table retirement_titles

--mentorship eligibilty table
SELECT DISTINCT ON (employees.emp_no)
	employees.first_name,
	employees.last_name,
	employees.birth_date,
	dept_emp.dept_no,
	dept_emp.from_date,
	dept_emp.to_date,
	titles.title,
	titles.emp_no
INTO mentorship_eligibility
FROM employees
	INNER JOIN dept_emp
	ON employees.emp_no = dept_emp.emp_no
	INNER JOIN titles
	ON employees.emp_no = titles.emp_no
WHERE (employees.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY employees.emp_no;

drop table mentorship_eligibility
select * from mentorship_eligibility
