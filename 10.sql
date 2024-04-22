-- (1). Retrieve the total no male & female employee in the Organization
SELECT
    COUNT(CASE WHEN gender = 'Male' THEN 1 END) AS male_count,
    COUNT(CASE WHEN gender = 'Female' THEN 1 END) AS female_count
FROM employees;

-- (2). Retrieve the total no of employee working, for each of the department
SELECT
    department_id,
    COUNT(*) AS employee_count
FROM employees
GROUP BY department_id;

-- (3). For each department, retrieve the department name and the average salary of all employees working in that department.
SELECT
    d.department_name,
    AVG(e.salary) AS average_salary
FROM departments d
JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_name;

-- (4). For each project, retrieve the project number, the project name and the number of employees who work on that project
SELECT
    p.project_number,
    p.project_name,
    COUNT(*) AS employee_count
FROM projects p
JOIN project_employees pe ON p.project_id = pe.project_id
GROUP BY p.project_number, p.project_name;

-- (5). For each project, list the project name and total no of hours per week (by all employees) spent on the project.
SELECT
    p.project_name,
    SUM(e.hours_per_week) AS total_hours_per_week
FROM projects p
JOIN project_employees pe ON p.project_id = pe.project_id
JOIN employees e ON pe.employee_id = e.employee_id
GROUP BY p.project_name;

-- (6). Retrieve the Project name & no of employee,inwhich least number of employees are working.
SELECT
    p.project_name,
    COUNT(*) AS employee_count
FROM projects p
JOIN project_employees pe ON p.project_id = pe.project_id
GROUP BY p.project_name
ORDER BY employee_count ASC
LIMIT 1;

-- (7). Retrieve the name of department name & department No, number of projects, who are controlling highest no of projects.
SELECT
    d.department_name,
    d.department_number,
    COUNT(*) AS project_count
FROM departments d
JOIN projects p ON d.department_id = p.department_id
GROUP BY d.department_name, d.department_number
ORDER BY project_count DESC
LIMIT 1;

-- (8). For each project on which more than two employees work, retrieve the project number, the project name, and the number of employees who work on the project.
SELECT
    p.project_number,
    p.project_name,
    COUNT(*) AS employee_count
FROM projects p
JOIN project_employees pe ON p.project_id = pe.project_id
GROUP BY p.project_number, p.project_name
HAVING COUNT(*) > 2;

-- (9). For each project, retrieve the project number, the project name, and the number of employees from department 1 who work on the project.
SELECT
    p.project_number,
    p.project_name,
    COUNT(*) AS employee_count
FROM projects p
JOIN project_employees pe ON p.project_id = pe.project_id
JOIN employees e ON pe.employee_id = e.employee_id
WHERE e.department_id = 1
GROUP BY p.project_number, p.project_name;

-- (10). For each department that has more than five employees, retrieve the department number and the number of its employees who are making more than $40,000.
SELECT
    d.department_number,
    COUNT(*) AS employee_count
FROM departments d
JOIN employees e ON d.department_id = e.department_id
WHERE e.salary > 40000
GROUP BY d.department_number
HAVING COUNT(*) > 5;

-- (11). Retrieve the names of the employee who do not have supervisors.
SELECT
    e.employee_name
FROM employees e
LEFT JOIN employees s ON e.supervisor_id = s.employee_id
WHERE s.employee_id IS NULL;

-- (12). Retrieve the names of employees who work on all projects controlled by department No 05.
SELECT
    e.employee_name
FROM employees e
JOIN project_employees pe ON e.employee_id = pe.employee_id
JOIN projects p ON pe.project_id = p.project_id
WHERE p.department_id = 5
GROUP BY e.employee_name
HAVING COUNT(DISTINCT p.project_id) = (SELECT COUNT(*) FROM projects WHERE department_id = 5);

-- (13). Find the names of all employees who earn more than average salary of company.
SELECT
    employee_name
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

-- (14). Make a list of project numbers for projects that involve an employee whose last name is ‘Smith’, either as a worker or as a manager of the department that controls the project.
SELECT
    p.project_number
FROM projects p
JOIN project_employees pe ON p.project_id = pe.project_id
JOIN employees e ON pe.employee_id = e.employee_id
JOIN departments d ON e.department_id = d.department_id
WHERE e.last_name = 'Smith' OR d.manager_id = e.employee_id;