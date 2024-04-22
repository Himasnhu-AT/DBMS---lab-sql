CREATE TABLE PROGRAMME (
    Program_name VARCHAR(50) PRIMARY KEY
);

CREATE TABLE DISCIPLINE (
    Discipline_name VARCHAR(50) PRIMARY KEY
);

CREATE TABLE DEPARTMENT (
    Dept_name VARCHAR(50) PRIMARY KEY,
    Dept_code VARCHAR(10),
    Building_name VARCHAR(50)
);

CREATE TABLE TEACHER (
    T_ID INT PRIMARY KEY,
    Name VARCHAR(50),
    Designation VARCHAR(50),
    Specialization_area VARCHAR(50)
);

CREATE TABLE STUDENT (
    Roll_No INT PRIMARY KEY,
    Name VARCHAR(50),
    Father_name VARCHAR(50),
    Native_place VARCHAR(50),
    Mobile_no VARCHAR(15)
);

CREATE TABLE COURSE (
    Course_id INT PRIMARY KEY,
    Title VARCHAR(100),
    Credits INT
);

CREATE TABLE SECTION (
    Section_code VARCHAR(10) PRIMARY KEY,
    Year INT,
    Semester INT
);

CREATE TABLE TIME_TABLE_SLOT (
    Period_No INT PRIMARY KEY,
    Start_time TIME,
    End_time TIME
);

CREATE TABLE DAYS (
    Day_no INT PRIMARY KEY,
    Day_name VARCHAR(20)
);