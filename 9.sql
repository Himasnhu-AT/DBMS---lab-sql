-- Create Employee table
CREATE TABLE Employee (
    F_name VARCHAR(50),
    L_name VARCHAR(50),
    Emp_id INT PRIMARY KEY,
    Bdate DATE,
    Address VARCHAR(100),
    Gender VARCHAR(10),
    Salary DECIMAL(10, 2),
    Super_Emp_id INT,
    D_no INT,
    FOREIGN KEY (Super_Emp_id) REFERENCES Employee(Emp_id),
    FOREIGN KEY (D_no) REFERENCES Department(D_no)
);

-- Create Department table
CREATE TABLE Department (
    D_name VARCHAR(50),
    D_no INT PRIMARY KEY,
    D_Mgr_id INT,
    Mgr_start_date DATE,
    FOREIGN KEY (D_Mgr_id) REFERENCES Employee(Emp_id)
);

-- Create Dept_Location table
CREATE TABLE Dept_Location (
    D_no INT,
    D_location VARCHAR(100),
    PRIMARY KEY (D_no, D_location),
    FOREIGN KEY (D_no) REFERENCES Department(D_no)
);

-- Create Project table
CREATE TABLE Project (
    P_name VARCHAR(50),
    P_number INT PRIMARY KEY,
    P_location VARCHAR(100),
    D_no INT,
    FOREIGN KEY (D_no) REFERENCES Department(D_no)
);

-- Create Works_on table
CREATE TABLE Works_on (
    Emp_id INT,
    P_no INT,
    Hours INT,
    PRIMARY KEY (Emp_id, P_no),
    FOREIGN KEY (Emp_id) REFERENCES Employee(Emp_id),
    FOREIGN KEY (P_no) REFERENCES Project(P_number)
);

-- Create Dependent table
CREATE TABLE Dependent (
    Emp_id INT,
    Dependent_name VARCHAR(50),
    Gender VARCHAR(10),
    Bdate DATE,
    Relationship VARCHAR(50),
    PRIMARY KEY (Emp_id, Dependent_name),
    FOREIGN KEY (Emp_id) REFERENCES Employee(Emp_id)
);


-- (1) Company decided to give a raise on salaries of every employee, working on the ‘ProductX’ project by 10 percent.
UPDATE Employee
SET Salary = Salary * 1.1
WHERE Emp_id IN (
    SELECT Emp_id
    FROM Works_on
    WHERE P_no = (
        SELECT P_number
        FROM Project
        WHERE P_name = 'ProductX'
    )
);

-- (2) Find the names and address of all employees who work on the same department.
SELECT E.F_name, E.L_name, E.Address
FROM Employee E
JOIN Works_on W ON E.Emp_id = W.Emp_id
JOIN Project P ON W.P_no = P.P_number
WHERE P.D_no = E.D_no;

-- (3) Retrieve the name & employee no of employees, whose salary is between $30,000 and $40,000.
SELECT F_name, L_name, Emp_id
FROM Employee
WHERE Salary BETWEEN 30000 AND 40000;

-- (4) Find the names of all employees who are directly supervised by ‘Franklin’.
SELECT E.F_name, E.L_name
FROM Employee E
JOIN Employee S ON E.Super_Emp_id = S.Emp_id
WHERE S.F_name = 'Franklin';

-- (5) List the name and address of all employees who work for the ‘Research’ department.
SELECT E.F_name, E.L_name, E.Address
FROM Employee E
JOIN Department D ON E.D_no = D.D_no
WHERE D.D_name = 'Research';

-- (6) List the names of employees who work on all projects controlled by department number 5.
SELECT E.F_name, E.L_name
FROM Employee E
WHERE NOT EXISTS (
    SELECT P_number
    FROM Project
    WHERE D_no = 5
    EXCEPT
    SELECT P_no
    FROM Works_on
    WHERE Emp_id = E.Emp_id
);

-- (7) List the names of all employees who have a dependent with the same first name as themselves.
SELECT E.F_name, E.L_name
FROM Employee E
JOIN Dependent D ON E.Emp_id = D.Emp_id
WHERE E.F_name = D.Dependent_name;

-- (8) Retrieve the names of all employees in department 5 who work more than 10 hours per week on XYZ Project.
SELECT E.F_name, E.L_name
FROM Employee E
JOIN Works_on W ON E.Emp_id = W.Emp_id
JOIN Project P ON W.P_no = P.P_number
WHERE E.D_no = 5 AND P.P_name = 'XYZ' AND W.Hours > 10;

-- (9) Retrieve a list of employees and the projects they are working on, ordered by department and, within each department, ordered alphabetically by last name, then first name.
SELECT E.F_name, E.L_name, P.P_name
FROM Employee E
JOIN Works_on W ON E.Emp_id = W.Emp_id
JOIN Project P ON W.P_no = P.P_number
ORDER BY E.D_no, E.L_name, E.F_name;



-- (1) Retrieve the employee details, whose first name start with “AB”.
SELECT *
FROM Employee
WHERE F_name LIKE 'AB%';

-- (2) Retrieve the employee details, whose third character of first name “S”.
SELECT *
FROM Employee
WHERE SUBSTRING(F_name, 3, 1) = 'S';

-- (3) Retrieve all employees, whose address is in Houston, Texas.
SELECT *
FROM Employee
WHERE Address LIKE '%Houston, Texas%';

-- (4) Retrieve the employees, whose supervisor city name start name “NEW”.
SELECT E.*
FROM Employee E
JOIN Employee S ON E.Super_Emp_id = S.Emp_id
WHERE S.Address LIKE 'NEW%';

-- (5) Retrieve the project name, whose location pin code consists first 3 digits are “111”.
SELECT P.P_name
FROM Project P
WHERE SUBSTRING(P.P_location, 1, 3) = '111';

-- (6) Retrieve the employee name, Employee id, dept no, project no, whose were born during 1980 and working in a project located at “INDIA”.
SELECT E.F_name, E.L_name, E.Emp_id, E.D_no, W.P_no
FROM Employee E
JOIN Works_on W ON E.Emp_id = W.Emp_id
JOIN Project P ON W.P_no = P.P_number
WHERE YEAR(E.Bdate) = 1980 AND P.P_location = 'INDIA';

-- (7) Retrieve the total number of Employees in organization.
SELECT COUNT(*) AS TotalEmployees
FROM Employee;

-- (8) Count the number of distinct salary values in the Company.
SELECT COUNT(DISTINCT Salary) AS DistinctSalaries
FROM Employee;

-- (9) Retrieve the total number of Supervisor in organization.
SELECT COUNT(DISTINCT Super_Emp_id) AS TotalSupervisors
FROM Employee;

-- (10) Retrieve the total no of Female Employee in organization, whose salary is more than 25000.
SELECT COUNT(*) AS TotalFemaleEmployees
FROM Employee
WHERE Gender = 'Female' AND Salary > 25000;

-- (11) Retrieve the total number projects currently in company.
SELECT COUNT(*) AS TotalProjects
FROM Project;

-- (12) Find the sum of the salaries of all employees, the maximum salary, the minimum salary, and the average salary.
SELECT SUM(Salary) AS TotalSalary, MAX(Salary) AS MaxSalary, MIN(Salary) AS MinSalary, AVG(Salary) AS AvgSalary
FROM Employee;

-- (13) Retrieve the average salary of all female employees.
SELECT AVG(Salary) AS AvgSalary
FROM Employee
WHERE Gender = 'Female';

-- (14) Retrieve the Employee id & no of projects, employee is working on.
SELECT E.Emp_id, COUNT(W.P_no) AS NoOfProjects
FROM Employee E
JOIN Works_on W ON E.Emp_id = W.Emp_id
GROUP BY E.Emp_id;

-- (15) Retrieve employee id, employee name, total no of hours he works on project.
SELECT E.Emp_id, CONCAT(E.F_name, ' ', E.L_name) AS EmployeeName, SUM(W.Hours) AS TotalHours
FROM Employee E
JOIN Works_on W ON E.Emp_id = W.Emp_id
GROUP BY E.Emp_id, EmployeeName;
