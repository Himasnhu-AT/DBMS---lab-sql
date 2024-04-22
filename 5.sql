-- (1). Increase Salary by 20 percent of all instructors who are working in Department IT.
UPDATE INSTRUCTOR
SET Salary = Salary * 1.2
WHERE Dept_name = 'IT';

-- (2). Retrieve names of all instructors along with their department names.
SELECT Name, Dept_name
FROM INSTRUCTOR;

-- (3). Retrieve names of all instructors along with their department names and building names in which the departments are housed.
SELECT I.Name, I.Dept_name, D.D_building
FROM INSTRUCTOR I
JOIN DEPARTMENT D ON I.Dept_name = D.Dept_name;

-- (4). Retrieve names of all departments along with names of the buildings in which they are situated.
SELECT D.Dept_name, D.D_building
FROM DEPARTMENT D;

-- (5). Change name of the building "Lecture Hall Complex" to "Lecture Theatre Complex".
UPDATE DEPARTMENT
SET D_building = 'Lecture Theatre Complex'
WHERE D_building = 'Lecture Hall Complex';

-- (6). Find name of the department of a student with ID _____. (Take a valid ID value of a student)
SELECT D.Dept_name
FROM STUDENT S
JOIN DEPARTMENT D ON S.Dept_name = D.Dept_name
WHERE S.S_ID = _____; -- Replace _____ with the valid student ID

-- (7). Retrieve names of all instructors along with the Course IDs of the courses they teach.
SELECT I.Name, T.Course_id
FROM INSTRUCTOR I
JOIN TEACHES T ON I.I_ID = T.I_ID;

-- (8). Retrieve Course ID, semester, year and title of each course being taught by "Computer Engg." department.
SELECT C.Course_id, S.Semester, S.Year, C.Title
FROM COURSE C
JOIN SECTION S ON C.Course_id = S.Course_id
JOIN DEPARTMENT D ON C.Dept_name = D.Dept_name
WHERE D.Dept_name = 'Computer Engg.';

-- (9). Compute monthly salary of all instructors and display it as 'monthly salary' attribute in place of attribute 'salary'.
SELECT I.Name, I.Salary/12 AS 'monthly salary'
FROM INSTRUCTOR I;

-- (10). Retrieve names of all departments housed in the building named _______. (Consider a valid Building name)
SELECT D.Dept_name
FROM DEPARTMENT D
WHERE D.D_building = '_______'; -- Replace _______ with the valid building name

-- (11). Find the names of all instructors belonging to Computer Engg. department who have salary greater than Rs. 70,000.
SELECT I.Name
FROM INSTRUCTOR I
JOIN DEPARTMENT D ON I.Dept_name = D.Dept_name
WHERE D.Dept_name = 'Computer Engg.' AND I.Salary > 70000;

-- (12). Find titles of the courses that have credits 3 and offered by the department IT.
SELECT C.Title
FROM COURSE C
JOIN DEPARTMENT D ON C.Dept_name = D.Dept_name
WHERE C.Credits = 3 AND D.Dept_name = 'IT';

-- (13). Find course names and their credits running in semester 4.
SELECT C.Title, C.Credits
FROM COURSE C
JOIN SECTION S ON C.Course_id = S.Course_id
WHERE S.Semester = '4';

-- (14). List classes as year and semester wise engaged in room no. LHC-102.
SELECT S.Year, S.Semester
FROM SECTION S
JOIN CLASSROOM C ON S.Building = C.Building AND S.Room_Number = C.Room_Number
WHERE C.Room_Number = 'LHC-102';

-- (15). List classes as year, semester and section wise engaged in room no. LHC-102.
SELECT S.Year, S.Semester, S.Sec_id
FROM SECTION S
JOIN CLASSROOM C ON S.Building = C.Building AND S.Room_Number = C.Room_Number
WHERE C.Room_Number = 'LHC-102';

-- (16). List classes as year, semester and section wise engaged in room no. LHC-101.
SELECT S.Year, S.Semester, S.Sec_id
FROM SECTION S
JOIN CLASSROOM C ON S.Building = C.Building AND S.Room_Number = C.Room_Number
WHERE C.Room_Number = 'LHC-101';

-- (17). Retrieve list of room number & time slot where all classes of Computer Engg.. Semester 7th are scheduled.
SELECT C.Room_Number, T.Time_slot_id
FROM SECTION S
JOIN CLASSROOM C ON S.Building = C.Building AND S.Room_Number = C.Room_Number
JOIN TIME_SLOT T ON S.Time_slot_id = T.Time_slot_id
JOIN DEPARTMENT D ON S.Dept_name = D.Dept_name
WHERE D.Dept_name = 'Computer Engg.' AND S.Semester = '7th';

-- (18). Retrieve Course titles taught by instructor _______. (Take a valid instructor ID or name)
SELECT C.Title
FROM COURSE C
JOIN TEACHES T ON C.Course_id = T.Course_id
JOIN INSTRUCTOR I ON T.I_ID = I.I_ID
WHERE I.Name = '_______'; -- Replace _______ with the valid instructor name

-- (19). For all instructors in the university who have taught some course, display their names along with their department names.
SELECT I.Name, D.Dept_name
FROM INSTRUCTOR I
JOIN TEACHES T ON I.I_ID = T.I_ID
JOIN DEPARTMENT D ON I.Dept_name = D.Dept_name;

-- (20). Find the names of all instructors who have a higher salary than some instructor in "Computer Engg." department.
SELECT I1.Name
FROM INSTRUCTOR I1
JOIN INSTRUCTOR I2 ON I1.Salary > I2.Salary
JOIN DEPARTMENT D ON I2.Dept_name = D.Dept_name
WHERE D.Dept_name = 'Computer Engg.';
