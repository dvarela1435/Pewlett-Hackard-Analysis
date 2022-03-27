select e.emp_no,
	e.first_name,
	e.last_name,
	titles.title,
	titles.from_date,
	titles.to_date
into retirement_titles
FROM employees as e
inner join titles
on(e.emp_no = titles.emp_no)
where(e.birth_date between '1952-01-01' and '1955-12-31')
order by e.emp_no;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
rt.first_name,
rt.last_name,
rt.title
INTO unique_titles
FROM retirement_titles as rt
WHERE rt.to_date = '9999-01-01'
ORDER BY rt.emp_no , rt.to_date DESC;

--  Count Retiring Titles
SELECT count(ut.emp_no), ut.title
Into retiring_titles
from unique_titles as ut
Group by ut.title
order by ut.count desc;

--  Create Mentorship Elgibility
SELECT DISTINCT ON (emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
INTO mentor
From employees as e
	LEFT JOIN dept_emp as de
		on(e.emp_no = de.emp_no)
	LEFT JOIN titles as t
		on(e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
	AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no;