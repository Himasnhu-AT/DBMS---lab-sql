Create Database University;
use Database University;
CREATE TABLE STUDENT (
    Roll_No INT PRIMARY KEY,
    Name VARCHAR(100),
    Father_Name VARCHAR(100),
    Mother_Name VARCHAR(100),
    City VARCHAR(100),
    Dept_Code INT
);

CREATE TABLE DEPARTMENT (
    Dept_Code INT PRIMARY KEY,
    Dept_Name VARCHAR(100),
    Dept_Head VARCHAR(100)
);

CREATE TABLE PROGRAM (
    Degree_Name VARCHAR(100),
    Discipline_Name VARCHAR(100),
    PRIMARY KEY (Degree_Name, Discipline_Name)
);

CREATE TABLE ENROLLED (
    Roll_No INT,
    Degree_Name VARCHAR(100),
    FOREIGN KEY (Roll_No) REFERENCES STUDENT(Roll_No),
    FOREIGN KEY (Degree_Name) REFERENCES PROGRAM(Degree_Name),
    PRIMARY KEY (Roll_No, Degree_Name)
);

INSERT INTO STUDENT (Roll_No, Name, Father_Name, Mother_Name, City, Dept_Code)
VALUES (101, 'Rohan', 'Jai', 'xyz', 'abc', 1);

INSERT INTO DEPARTMENT (Dept_Code, Dept_Name, Dept_Head)
VALUES (1, 'Computer Science', 'Dr. ppp');

INSERT INTO PROGRAM (Degree_Name, Discipline_Name)
VALUES ('Bachelor of technology', 'Computer Science');

INSERT INTO ENROLLED (Roll_No, Degree_Name)
VALUES (101, 'Bachelor of technology');
