-- Create STUDENT table
CREATE TABLE STUDENT (
    Roll-No INT PRIMARY KEY,
    Name VARCHAR(50),
    Gender VARCHAR(10),
    Degree VARCHAR(50),
    Semester INT,
    Contact-no VARCHAR(20),
    Email-id VARCHAR(50),
    Guide-No INT,
    Group-Code VARCHAR(10),
    Project-No INT
);

-- Create GUIDE table
CREATE TABLE GUIDE (
    Guide-No INT PRIMARY KEY,
    Guide-name VARCHAR(50),
    Guide-research-area VARCHAR(50),
    Email-id VARCHAR(50)
);

-- Create PROJECT table
CREATE TABLE PROJECT (
    Project-No INT PRIMARY KEY,
    Project-title VARCHAR(50),
    Project-area VARCHAR(50),
    Project-Year-Month VARCHAR(20),
    Guide-No INT,
    Group-Code VARCHAR(10)
);

-- Create GROUPS table
CREATE TABLE GROUPS (
    Group-Code VARCHAR(10) PRIMARY KEY,
    No-of-Students INT
);

-- Seed data for STUDENT table
INSERT INTO STUDENT (Roll-No, Name, Gender, Degree, Semester, Contact-no, Email-id, Guide-No, Group-Code, Project-No)
VALUES
    (110011, 'John Doe', 'Male', 'Computer Science', 5, '1234567890', 'john.doe@example.com', 1, 'G1', 1),
    (110012, 'Jane Smith', 'Female', 'Information Technology', 4, '9876543210', 'jane.smith@example.com', 2, 'G2', 2),
    (110013, 'David Johnson', 'Male', 'Computer Engineering', 6, '5555555555', 'david.johnson@example.com', 1, 'G1', 3);

-- Seed data for GUIDE table
INSERT INTO GUIDE (Guide-No, Guide-name, Guide-research-area, Email-id)
VALUES
    (15, 'Dr. S K Jain', 'Database', 'sk.jain@example.com'),
    (2, 'Dr. Ram Mohan', 'Artificial Intelligence', 'ram.mohan@example.com');

-- Seed data for PROJECT table
INSERT INTO PROJECT (Project-No, Project-title, Project-area, Project-Year-Month, Guide-No, Group-Code)
VALUES
    (1, 'Database Management System', 'Database', 'June 2019', 1, 'G1'),
    (2, 'Machine Learning', 'Artificial Intelligence', 'July 2019', 2, 'G2'),
    (3, 'Web Development', 'Programming', 'August 2019', 1, 'G1');

-- Seed data for GROUPS table
INSERT INTO GROUPS (Group-Code, No-of-Students)
VALUES
    ('G1', 3),
    ('G2', 2);

-- (1). Update details of the guide of the student whose Roll-no is ‘110011’. The details of the new guide are as Guide-name =‘Ram Mohan’ & Guide-No = ‘11’.
UPDATE STUDENT
SET Guide-No = '11'
WHERE Roll-No = '110011';

-- (2). Remove Guide details where Guide-No is ‘15’ and assign a new guide with Guide-No '10' to all the students who were earlier assigned to the guide with Guide-No '15'.
DELETE FROM GUIDE
WHERE Guide-No = '15';

UPDATE STUDENT
SET Guide-No = '10'
WHERE Guide-No = '15';

-- (3). Get a list of guides who are guiding more than two projects.
SELECT GUIDE.Guide-No, GUIDE.Guide-name
FROM GUIDE
INNER JOIN PROJECT ON GUIDE.Guide-No = PROJECT.Guide-No
GROUP BY GUIDE.Guide-No, GUIDE.Guide-name
HAVING COUNT(PROJECT.Project-No) > 2;

-- (4). Get a list of Project-No, Project-title, and names of guides who are guiding projects in the Project area 'Database'.
SELECT PROJECT.Project-No, PROJECT.Project-title, GUIDE.Guide-name
FROM PROJECT
INNER JOIN GUIDE ON PROJECT.Guide-No = GUIDE.Guide-No
WHERE PROJECT.Project-area = 'Database';

-- (5). Get title of the Project-No ‘5’.
SELECT Project-title
FROM PROJECT
WHERE Project-No = '5';

-- (6). Get names of all the students of the project no. ‘5’.
SELECT STUDENT.Name
FROM STUDENT
INNER JOIN PROJECT ON STUDENT.Project-No = PROJECT.Project-No
WHERE PROJECT.Project-No = '5';

-- (7). List all the projects being guided by ‘Dr. S K Jain’.
SELECT PROJECT.Project-No, PROJECT.Project-title
FROM PROJECT
INNER JOIN GUIDE ON PROJECT.Guide-No = GUIDE.Guide-No
WHERE GUIDE.Guide-name = 'Dr. S K Jain';

-- (8). Get names of all the students being guided by ‘Dr. S K Jain’.
SELECT STUDENT.Name
FROM STUDENT
INNER JOIN GUIDE ON STUDENT.Guide-No = GUIDE.Guide-No
WHERE GUIDE.Guide-name = 'Dr. S K Jain';

-- (9). List all the projects completed on ‘June 2019’.
SELECT PROJECT.Project-No, PROJECT.Project-title
FROM PROJECT
WHERE PROJECT.Project-Year-Month = 'June 2019';

-- (10). List all the projects completed in year ‘2019’.
SELECT PROJECT.Project-No, PROJECT.Project-title
FROM PROJECT
WHERE PROJECT.Project-Year-Month LIKE '2019%';

-- (11). Lists roll numbers and names of all the students who have their projects in Project area “Programming”.
SELECT STUDENT.Roll-No, STUDENT.Name
FROM STUDENT
INNER JOIN PROJECT ON STUDENT.Project-No = PROJECT.Project-No
WHERE PROJECT.Project-area = 'Programming';

-- (12). List names of all the teachers who are guiding projects to the students in the Project area “Network”.
SELECT GUIDE.Guide-name
FROM GUIDE
INNER JOIN PROJECT ON GUIDE.Guide-No = PROJECT.Guide-No
WHERE PROJECT.Project-area = 'Network';

-- (13). List names of all the students who have their projects in the Project area “Artificial Intelligence”.
SELECT STUDENT.Name
FROM STUDENT
INNER JOIN PROJECT ON STUDENT.Project-No = PROJECT.Project-No
WHERE PROJECT.Project-area = 'Artificial Intelligence';

-- (14). List names of the guides with their Project areas.
SELECT GUIDE.Guide-name, PROJECT.Project-area
FROM GUIDE
INNER JOIN PROJECT ON GUIDE.Guide-No = PROJECT.Guide-No;

-- (15). Whether Project-No ‘7’ was guided by ‘Dr. S K Jain’ in ‘Dec 2020’.
SELECT CASE WHEN EXISTS (
    SELECT *
    FROM PROJECT
    INNER JOIN GUIDE ON PROJECT.Guide-No = GUIDE.Guide-No
    WHERE PROJECT.Project-No = '7' AND GUIDE.Guide-name = 'Dr. S K Jain' AND PROJECT.Project-Year-Month = 'Dec 2020'
) THEN 'Yes' ELSE 'No' END;

-- (16). List names of the students of the groups code ‘G3’.
SELECT STUDENT.Name
FROM STUDENT
INNER JOIN GROUPS ON STUDENT.Group-Code = GROUPS.Group-Code
WHERE GROUPS.Group-Code = 'G3';

-- (17). Retrieve name of the guide of the group ‘G5’.
SELECT GUIDE.Guide-name
FROM GUIDE
INNER JOIN GROUPS ON GUIDE.Guide-No = GROUPS.Guide-No
WHERE GROUPS.Group-Code = 'G5';

-- (18). Retrieve group-codes of the students whose guide is ‘Dr. S K Jain’.
SELECT GROUPS.Group-Code
FROM GROUPS
INNER JOIN STUDENT ON GROUPS.Group-Code = STUDENT.Group-Code
INNER JOIN GUIDE ON STUDENT.Guide-No = GUIDE.Guide-No
WHERE GUIDE.Guide-name = 'Dr. S K Jain';