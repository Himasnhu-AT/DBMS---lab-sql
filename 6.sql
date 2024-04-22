-- (1). Find names of all departments whose building name includes the substring “Hall”.
SELECT Dept_name
FROM DEPARTMENT
WHERE D_building LIKE '%Hall%';

-- (2). Find names of all instructors who have their salaries between Rs. 50,000 and Rs. 80,000.
SELECT Name
FROM INSTRUCTOR
WHERE Salary BETWEEN 50000 AND 80000;

-- (3). Find names of all students whose names begin with string "Sa":
SELECT Name
FROM STUDENT
WHERE Name LIKE 'Sa%';

-- (4). Find names of all students belonging to Computer Engg. department and their names begin with character "Sa":
SELECT Name
FROM STUDENT
WHERE Dept_name = 'Computer Engg.' AND Name LIKE 'Sa%';

-- (5). Retrieve list of courses taught by teachers whose names begin with character "S".
SELECT C.Title
FROM COURSE C
JOIN TEACHES T ON C.Course_id = T.Course_id
JOIN INSTRUCTOR I ON T.I_ID = I.I_ID
WHERE I.Name LIKE 'S%';

-- (6). Retrieve list of courses beginning their titles with word "Computer".
SELECT Title
FROM COURSE
WHERE Title LIKE 'Computer%';

-- (7). Retrieve list of courses containing the word "language" in their titles.
SELECT Title
FROM COURSE
WHERE Title LIKE '%language%';

-- (8). Retrieve names of the instructors who teach courses containing word "language" in their titles.
SELECT I.Name
FROM INSTRUCTOR I
JOIN TEACHES T ON I.I_ID = T.I_ID
JOIN COURSE C ON T.Course_id = C.Course_id
WHERE C.Title LIKE '%language%';

-- (9). Find IDs of all students whose names include "Kumari" and their department is IT.
SELECT S_ID
FROM STUDENT
WHERE Name LIKE '%Kumari%' AND Dept_name = 'IT';

-- (10). Find average salary of all instructors.
SELECT AVG(Salary) AS AverageSalary
FROM INSTRUCTOR;

-- (11). Find average salary of the instructors belonging to Computer Engg, department.
SELECT AVG(Salary) AS AverageSalary
FROM INSTRUCTOR
WHERE Dept_name = 'Computer Engg.';

-- (12). Find average salary of the instructors belonging to each department.
SELECT Dept_name, AVG(Salary) AS AverageSalary
FROM INSTRUCTOR
GROUP BY Dept_name;

-- (13). Find names and average salaries of all departments whose average salary is greater than Rs. 60000.
SELECT D.Dept_name, AVG(I.Salary) AS AverageSalary
FROM DEPARTMENT D
JOIN INSTRUCTOR I ON D.Dept_name = I.Dept_name
GROUP BY D.Dept_name
HAVING AVG(I.Salary) > 60000;

-- (14). Find total number of courses offered by the university.
SELECT COUNT(*) AS TotalCourses
FROM COURSE;

-- (15). Find total number of courses offered by the Computer Engg department.
SELECT COUNT(*) AS TotalCourses
FROM COURSE
WHERE Dept_name = 'Computer Engg.';

-- (16). Find total number of courses taught in the Spring 2016 semester.
SELECT COUNT(*) AS TotalCourses
FROM SECTION
WHERE Semester = 'Spring' AND Year = 2016;

-- (17). Find total number of instructors who teach a course in the Spring 2016 semester.
SELECT COUNT(DISTINCT I_ID) AS TotalInstructors
FROM TEACHES
WHERE Semester = 'Spring' AND Year = 2016;

-- (18). Find maximum salary of an instructor belonging to Computer Engg, department.
SELECT MAX(Salary) AS MaximumSalary
FROM INSTRUCTOR
WHERE Dept_name = 'Computer Engg.';

-- (19). Find minimum salary of an instructor belonging to Computer Engg, department.
SELECT MIN(Salary) AS MinimumSalary
FROM INSTRUCTOR
WHERE Dept_name = 'Computer Engg.';

-- (20). Find maximum salary of an instructor in the university.
SELECT MAX(Salary) AS MaximumSalary
FROM INSTRUCTOR;

-- (21). Find total number of students enrolled in the university.
SELECT COUNT(*) AS TotalStudents
FROM STUDENT;

-- (22). Find total number of students enrolled in each department of the university.
SELECT Dept_name, COUNT(*) AS TotalStudents
FROM STUDENT
GROUP BY Dept_name;

-- (23). Find instructors whose average salaries are greater than Rs. 42,000.
SELECT I.Name
FROM INSTRUCTOR I
JOIN (
    SELECT Dept_name, AVG(Salary) AS AverageSalary
    FROM INSTRUCTOR
    GROUP BY Dept_name
) AS AvgSalary ON I.Dept_name = AvgSalary.Dept_name
WHERE AvgSalary.AverageSalary > 42000;

-- (24). Find instructors whose average salaries are greater than that of the instructors belonging to the 'Physics' department.
SELECT I.Name
FROM INSTRUCTOR I
JOIN (
    SELECT Dept_name, AVG(Salary) AS AverageSalary
    FROM INSTRUCTOR
    WHERE Dept_name = 'Physics'
    GROUP BY Dept_name
) AS PhysicsAvgSalary ON I.Dept_name <> 'Physics' AND I.Salary > PhysicsAvgSalary.AverageSalary;

-- (25). Retrieve total no. of students in each department who earned total credits more than 8.
SELECT Dept_name, COUNT(*) AS TotalStudents
FROM STUDENT
WHERE Tot_Credit > 8
GROUP BY Dept_name;

