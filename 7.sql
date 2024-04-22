
-- 1. Find courses taught in Fall 2015 or in Spring 2016. (use union operation)
SELECT Course_id
FROM SECTION
WHERE Semester = 'Fall' AND Year = 2015
UNION
SELECT Course_id
FROM SECTION
WHERE Semester = 'Spring' AND Year = 2016;

-- 2. Find courses taught in Fall 2015 and in Spring 2016. (use intersect operation)
SELECT Course_id
FROM SECTION
WHERE Semester = 'Fall' AND Year = 2015
INTERSECT
SELECT Course_id
FROM SECTION
WHERE Semester = 'Spring' AND Year = 2016;

-- 3. Find courses taught in Fall 2015 but not in Spring 2016. (use except operation)
SELECT Course_id
FROM SECTION
WHERE Semester = 'Fall' AND Year = 2015
EXCEPT
SELECT Course_id
FROM SECTION
WHERE Semester = 'Spring' AND Year = 2016;

-- 4. Find courses taught/offered by Computer Engg. department in Fall 2015 or ECE department in Spring 2016. (use union operation)
SELECT Course_id
FROM SECTION
WHERE Dept_name = 'Computer Engg.' AND Semester = 'Fall' AND Year = 2015
UNION
SELECT Course_id
FROM SECTION
WHERE Dept_name = 'ECE' AND Semester = 'Spring' AND Year = 2016;

-- 5. Find courses taught/offered by Computer Engg. department in Fall 2015 and ECE department in Spring 2016. (use intersect operation)
SELECT Course_id
FROM SECTION
WHERE Dept_name = 'Computer Engg.' AND Semester = 'Fall' AND Year = 2015
INTERSECT
SELECT Course_id
FROM SECTION
WHERE Dept_name = 'ECE' AND Semester = 'Spring' AND Year = 2016;

-- 6. Find courses taught/offered by Computer Engg. department in Fall 2015 but not by ECE department in Spring 2016. (use except operation)
SELECT Course_id
FROM SECTION
WHERE Dept_name = 'Computer Engg.' AND Semester = 'Fall' AND Year = 2015
EXCEPT
SELECT Course_id
FROM SECTION
WHERE Dept_name = 'ECE' AND Semester = 'Spring' AND Year = 2016;

-- 7. List all instructors of the Physics department in alphabetic order.
SELECT Name
FROM INSTRUCTOR
WHERE Dept_name = 'Physics'
ORDER BY Name;

-- 8. List all coursed offered by Physics department in alphabetic order.
SELECT Title
FROM COURSE
WHERE Dept_name = 'Physics'
ORDER BY Title;

-- 9. Find courses taught in Fall 2015 and in Spring 2016. (sub-query, in)
SELECT Course_id
FROM SECTION
WHERE Course_id IN (
    SELECT Course_id
    FROM SECTION
    WHERE Semester = 'Fall' AND Year = 2015
) AND Course_id IN (
    SELECT Course_id
    FROM SECTION
    WHERE Semester = 'Spring' AND Year = 2016
);

-- 10. Find courses taught in Fall 2015 but not in Spring 2016. (sub-query, not in)
SELECT Course_id
FROM SECTION
WHERE Course_id IN (
    SELECT Course_id
    FROM SECTION
    WHERE Semester = 'Fall' AND Year = 2015
) AND Course_id NOT IN (
    SELECT Course_id
    FROM SECTION
    WHERE Semester = 'Spring' AND Year = 2016
);

-- 11. Find courses taught/offered by Computer Engg. department in Fall 2015 and ECE department in Spring 2016. (sub-query, in)
SELECT Course_id
FROM SECTION
WHERE Dept_name = 'Computer Engg.' AND Semester = 'Fall' AND Year = 2015
AND Course_id IN (
    SELECT Course_id
    FROM SECTION
    WHERE Dept_name = 'ECE' AND Semester = 'Spring' AND Year = 2016
);

-- 12. Find courses taught/offered by Computer Engg. department in Fall 2015 but not by ECE department in Spring 2016. (sub-query, not in)
SELECT Course_id
FROM SECTION
WHERE Dept_name = 'Computer Engg.' AND Semester = 'Fall' AND Year = 2015
AND Course_id NOT IN (
    SELECT Course_id
    FROM SECTION
    WHERE Dept_name = 'ECE' AND Semester = 'Spring' AND Year = 2016
);

-- 13. Find total no. of distinct students who have taken courses taught in different sections by an instructor. (Take a valid instructor ID or name)
SELECT COUNT(DISTINCT S_ID) AS TotalStudents
FROM TAKES
WHERE Course_id IN (
    SELECT Course_id
    FROM TEACHES
    WHERE I_ID = $INSTRUCTOR_ID$
);

-- 14. Find names of instructors with salary greater than that of some (at least one) instructors of the Physics department.
SELECT Name
FROM INSTRUCTOR
WHERE Salary > ANY (
    SELECT Salary
    FROM INSTRUCTOR
    WHERE Dept_name = 'Physics'
);

-- 15. Implement the following query and observe the results
-- select name
-- from instructor
-- where salary > some (select salary
-- from instructor
-- where Dept name ="Physics")
-- Based on the observations of the result, write the query in English language. Give your opinion on any different version of the above query.
SELECT Name
FROM INSTRUCTOR
WHERE Salary > ANY (
    SELECT Salary
    FROM INSTRUCTOR
    WHERE Dept_name = 'Physics'
);

-- 16. Find names of all the instructors whose salaries are greater than that of the salaries of all instructors belonging to the Physics department. (sub-query, "all")
SELECT Name
FROM INSTRUCTOR
WHERE Salary > ALL (
    SELECT Salary
    FROM INSTRUCTOR
    WHERE Dept_name = 'Physics'
);

-- 17. Using update statement and set keyword
-- "increase salaries of the instructors whose salaries are greater than 50000" by 15%"
UPDATE INSTRUCTOR
SET Salary = Salary * 1.15
WHERE Salary > 50000;

-- "decrease salaries of the instructors whose salaries are greater than 50000" by 5%"
UPDATE INSTRUCTOR
SET Salary = Salary * 0.95
WHERE Salary > 50000;

-- 18. List all departments along with no. of instructors in each department.
SELECT Dept_name, COUNT(*) AS TotalInstructors
FROM INSTRUCTOR
GROUP BY Dept_name;

-- 19. List all departments along with no. of students in each department.
SELECT Dept_name, COUNT(*) AS TotalStudents
FROM STUDENT
GROUP BY Dept_name;

-- 20. Use a sub-query to derive a relation in "from" clause and write query for the following:
-- "Find department names along with average salaries of the instructors of that department where average salaries are greater than Rs. 45000"
SELECT Dept_name, AVG(Salary) AS AverageSalary
FROM (
    SELECT I.Dept_name, I.Salary
    FROM INSTRUCTOR I
) AS SubQuery
GROUP BY Dept_name
HAVING AVG(Salary) > 45000;

-- "Retrieve name of department along with no. of students who have earned total credits more than 7"
SELECT D.Dept_name, COUNT(*) AS TotalStudents
FROM DEPARTMENT D
JOIN STUDENT S ON D.Dept_name = S.Dept_name
WHERE S.Tot_Credit > 7
GROUP BY D.Dept_name;

-- "Find name of department along with no. of instructors belonging to the department"
SELECT D.Dept_name, COUNT(*) AS TotalInstructors
FROM DEPARTMENT D
JOIN INSTRUCTOR I ON D.Dept_name = I.Dept_name
GROUP BY D.Dept_name;

-- 21. List instructor name, dept name, and no. of courses taught by the instructor in Sprint 2016.
SELECT I.Name, I.Dept_name, COUNT(T.Course_id) AS TotalCourses
FROM INSTRUCTOR I
JOIN TEACHES T ON I.I_ID = T.I_ID
JOIN SECTION S ON T.Course_id = S.Course_id
WHERE S.Semester = 'Spring' AND S.Year = 2016
GROUP BY I.Name, I.Dept_name;

-- 22. Retrieve departments that have budget amount more than 5 lacs.
SELECT Dept_name
FROM DEPARTMENT
WHERE Budget > 500000;

-- 23. Find the names of all students who have taken at least one course taught by Computer Engg. department; make sure there are no duplicate names in the result.
SELECT DISTINCT S.Name
FROM STUDENT S
JOIN TAKES T ON S.S_ID = T.S_ID
JOIN TEACHES TE ON T.Course_id = TE.Course_id
JOIN INSTRUCTOR I ON TE.I_ID = I.I_ID
WHERE I.Dept_name = 'Computer Engg.';


