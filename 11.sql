-- (1). Retrieve the names of all employees who work on every project.
SELECT e.name
FROM employees e
WHERE NOT EXISTS (
    SELECT p.project_id
    FROM projects p
    WHERE NOT EXISTS (
        SELECT *
        FROM works_on w
        WHERE w.employee_id = e.employee_id
        AND w.project_id = p.project_id
    )
);

-- (2). List the last name of all department managers who have no dependent.
SELECT e.last_name
FROM employees e
WHERE e.employee_id IN (
    SELECT d.manager_id
    FROM departments d
    LEFT JOIN dependents dep ON d.manager_id = dep.employee_id
    WHERE dep.employee_id IS NULL
);

-- (3). List the names of managers who have at least one dependent.
SELECT e.name
FROM employees e
WHERE e.employee_id IN (
    SELECT d.manager_id
    FROM departments d
    INNER JOIN dependents dep ON d.manager_id = dep.employee_id
);

-- (4). Retrieve the names of employees who do not work on any project.
SELECT e.name
FROM employees e
WHERE e.employee_id NOT IN (
    SELECT w.employee_id
    FROM works_on w
);

-- (5). Retrieve the names of employees who work on all projects.
SELECT e.name
FROM employees e
WHERE NOT EXISTS (
    SELECT p.project_id
    FROM projects p
    WHERE NOT EXISTS (
        SELECT *
        FROM works_on w
        WHERE w.employee_id = e.employee_id
        AND w.project_id = p.project_id
    )
);

-- (6). Retrieve the name of department name & department No, number of employees, Number of projects, who is controlling the highest number of projects.
SELECT d.name, d.department_no, COUNT(e.employee_id) AS num_employees, COUNT(p.project_id) AS num_projects, e.name AS controlling_manager
FROM departments d
LEFT JOIN employees e ON d.manager_id = e.employee_id
LEFT JOIN projects p ON d.department_no = p.department_no
GROUP BY d.name, d.department_no, e.name
HAVING COUNT(p.project_id) = (
    SELECT MAX(project_count)
    FROM (
        SELECT COUNT(project_id) AS project_count
        FROM projects
        GROUP BY department_no
    ) AS project_counts
);

-- (7). List the name of each employee who works on some project controlled by department number 5.
SELECT e.name
FROM employees e
INNER JOIN works_on w ON e.employee_id = w.employee_id
INNER JOIN projects p ON w.project_id = p.project_id
WHERE p.department_no = 5;

-- (8). Retrieve the name of department name & department No, number of employees, Number of projects, who is controlling the highest number of projects.
SELECT d.name, d.department_no, COUNT(e.employee_id) AS num_employees, COUNT(p.project_id) AS num_projects, e.name AS controlling_manager
FROM departments d
LEFT JOIN employees e ON d.manager_id = e.employee_id
LEFT JOIN projects p ON d.department_no = p.department_no
GROUP BY d.name, d.department_no, e.name
HAVING COUNT(p.project_id) = (
    SELECT MAX(project_count)
    FROM (
        SELECT COUNT(project_id) AS project_count
        FROM projects
        GROUP BY department_no
    ) AS project_counts
);

-- (9). A view that has the department name, manager name, and manager salary for every department.
CREATE VIEW department_manager_info AS
SELECT d.name AS department_name, e.name AS manager_name, e.salary AS manager_salary
FROM departments d
INNER JOIN employees e ON d.manager_id = e.employee_id;

-- (10). A view that has the project name, controlling department, number of employees, and total hours worked per week for each project.
CREATE VIEW project_info AS
SELECT p.name AS project_name, d.name AS controlling_department, COUNT(w.employee_id) AS num_employees, SUM(w.hours_worked) AS total_hours_worked
FROM projects p
INNER JOIN departments d ON p.department_no = d.department_no
LEFT JOIN works_on w ON p.project_id = w.project_id
GROUP BY p.name, d.name;

-- (11). A view that has the project name, controlling department name, number of employees, total hours per week on the project for each project with more than one employee working on it.
CREATE VIEW project_multiple_employees_info AS
SELECT p.name AS project_name, d.name AS controlling_department, COUNT(w.employee_id) AS num_employees, SUM(w.hours_worked) AS total_hours_worked
FROM projects p
INNER JOIN departments d ON p.department_no = d.department_no
LEFT JOIN works_on w ON p.project_id = w.project_id
GROUP BY p.name, d.name
HAVING COUNT(w.employee_id) > 1;