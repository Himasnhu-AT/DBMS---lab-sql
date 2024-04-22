CREATE TABLE Department (
    DeptName VARCHAR(50) PRIMARY KEY,
    Manager VARCHAR(100)
);

CREATE TABLE Employee (
    EmpID INT PRIMARY KEY,
    Name VARCHAR(50),
    DeptName VARCHAR(50)
);

INSERT INTO Department (DeptName, Manager) VALUES ('Sales', 'Ram'), ('Finance', 'Sita'), ('Accounts', 'Rohit'), ('Inventory', 'Gargy'), ('Office', 'Mohit');

INSERT INTO Employee (EmpID, Name, DeptName) VALUES
(1101, 'Ramesh', 'Sales'),
(2241, 'Suresh', 'Finance'),
(2242, 'Kamal', 'Sales'),
(2243, 'ankur', 'Inventory'),
(2244, 'Vikas', 'Office'),
(2225, 'Amir', 'Sales');

SELECT * 
FROM Employee, Department;

SELECT *
FROM Employee NATURAL JOIN Department;

SELECT *
FROM Department LEFT OUTER JOIN Employee ON  Employee.DeptName = Department.DeptName;

SELECT *
FROM Department RIGHT OUTER JOIN Employee ON  Employee.DeptName = Department.DeptName;

SELECT *
FROM Department FULL OUTER JOIN Employee ON  Employee.DeptName = Department.DeptName;

SELECT * 
FROM Employee 
WHERE EXISTS (SELECT 1 FROM Department WHERE Employee.DeptName = Department.DeptName);

SELECT * 
FROM Department 
WHERE EXISTS (SELECT 1 FROM Employee WHERE Employee.DeptName = Department.DeptName);
