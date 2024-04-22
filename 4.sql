-- Create the CLASSROOM table
CREATE TABLE CLASSROOM (
    Building VARCHAR(50),
    Room_Number INT,
    Capacity INT,
    PRIMARY KEY (Building, Room_Number)
);

-- Create the DEPARTMENT table
CREATE TABLE DEPARTMENT (
    Dept_name VARCHAR(50),
    D_building VARCHAR(50),
    Budget DECIMAL(10, 2),
    PRIMARY KEY (Dept_name)
);

-- Create the COURSE table
CREATE TABLE COURSE (
    Course_id VARCHAR(10),
    Title VARCHAR(100),
    Dept_name VARCHAR(50),
    Credits INT,
    PRIMARY KEY (Course_id),
    FOREIGN KEY (Dept_name) REFERENCES DEPARTMENT (Dept_name)
);

-- Create the INSTRUCTOR table
CREATE TABLE INSTRUCTOR (
    I_ID INT,
    Name VARCHAR(100),
    Dept_name VARCHAR(50),
    Salary DECIMAL(10, 2),
    PRIMARY KEY (I_ID),
    FOREIGN KEY (Dept_name) REFERENCES DEPARTMENT (Dept_name)
);

-- Create the STUDENT table
CREATE TABLE STUDENT (
    S_ID INT,
    Name VARCHAR(100),
    Dept_name VARCHAR(50),
    Tot_Credit INT,
    I_ID INT,
    PRIMARY KEY (S_ID),
    FOREIGN KEY (Dept_name) REFERENCES DEPARTMENT (Dept_name),
    FOREIGN KEY (I_ID) REFERENCES INSTRUCTOR (I_ID)
);

-- Create the TIME_SLOT table
CREATE TABLE TIME_SLOT (
    Time_slot_id INT,
    Day VARCHAR(10),
    Start_time TIME,
    End_time TIME,
    PRIMARY KEY (Time_slot_id)
);

-- Create the SECTION table
CREATE TABLE SECTION (
    Course_id VARCHAR(10),
    Sec_id INT,
    Semester VARCHAR(10),
    Year INT,
    Building VARCHAR(50),
    Room_Number INT,
    Time_slot_id INT,
    Day VARCHAR(10),
    Start_time TIME,
    PRIMARY KEY (Course_id, Sec_id, Semester, Year),
    FOREIGN KEY (Course_id) REFERENCES COURSE (Course_id),
    FOREIGN KEY (Building, Room_Number) REFERENCES CLASSROOM (Building, Room_Number),
    FOREIGN KEY (Time_slot_id, Day, Start_time) REFERENCES TIME_SLOT (Time_slot_id, Day, Start_time)
);

-- Create the TEACHES table
CREATE TABLE TEACHES (
    I_ID INT,
    Course_id VARCHAR(10),
    Sec_id INT,
    Semester VARCHAR(10),
    Year INT,
    PRIMARY KEY (I_ID, Course_id, Sec_id, Semester, Year),
    FOREIGN KEY (I_ID) REFERENCES INSTRUCTOR (I_ID),
    FOREIGN KEY (Course_id, Sec_id, Semester, Year) REFERENCES SECTION (Course_id, Sec_id, Semester, Year)
);

-- Create the TAKES table
CREATE TABLE TAKES (
    S_ID INT,
    Course_id VARCHAR(10),
    Sec_id INT,
    Semester VARCHAR(10),
    Year INT,
    Grade VARCHAR(2),
    PRIMARY KEY (S_ID, Course_id, Sec_id, Semester, Year),
    FOREIGN KEY (S_ID) REFERENCES STUDENT (S_ID),
    FOREIGN KEY (Course_id, Sec_id, Semester, Year) REFERENCES SECTION (Course_id, Sec_id, Semester, Year)
);

-- Create the PREREQ table
CREATE TABLE PREREQ (
    Course_id VARCHAR(10),
    Prereq_id VARCHAR(10),
    PRIMARY KEY (Course_id, Prereq_id),
    FOREIGN KEY (Course_id) REFERENCES COURSE (Course_id),
    FOREIGN KEY (Prereq_id) REFERENCES COURSE (Course_id)
);

-- Insert sample data into the tables
-- (You can modify or add more data as needed)
-- Insert sample data into the tables
-- (You can modify or add more data as needed)
INSERT INTO CLASSROOM (Building, Room_Number, Capacity) VALUES
    ('LHC-102', 101, 50),
    ('LHC-101', 201, 30),
    ('LHC-103', 301, 40),
    ('LHC-104', 401, 60);

INSERT INTO DEPARTMENT (Dept_name, D_building, Budget) VALUES
    ('Computer Engg.', 'Lecture Theatre Complex', 100000),
    ('IT', 'Building A', 90000)
    ('Mathematics', 'Building B', 80000),
    ('Physics', 'Building C', 60000),
    ('Chemistry', 'Building D', 70000);

INSERT INTO COURSE (Course_id, Title, Dept_name, Credits) VALUES
    ('CS101', 'Introduction to Computer Science', 'Computer Science', 3),
    ('MATH101', 'Calculus I', 'Mathematics', 4),
    ('PHYS101', 'Physics I', 'Physics', 4),
    ('CHEM101', 'Chemistry I', 'Chemistry', 3);

INSERT INTO INSTRUCTOR (I_ID, Name, Dept_name, Salary) VALUES
    (1, 'John Doe', 'Computer Science', 50000),
    (2, 'Jane Smith', 'Mathematics', 45000),
    (3, 'David Johnson', 'Physics', 40000),
    (4, 'Sarah Williams', 'Chemistry', 42000);

INSERT INTO STUDENT (S_ID, Name, Dept_name, Tot_Credit, I_ID) VALUES
    (1001, 'Alice Brown', 'Computer Science', 60, 1),
    (1002, 'Bob Smith', 'Mathematics', 45, 2),
    (1003, 'Charlie Davis', 'Physics', 30, 3),
    (1004, 'Emma Johnson', 'Chemistry', 55, 4);

INSERT INTO TIME_SLOT (Time_slot_id, Day, Start_time, End_time) VALUES
    (1, 'Monday', '09:00:00', '10:30:00'),
    (2, 'Wednesday', '13:00:00', '14:30:00'),
    (3, 'Friday', '10:00:00', '11:30:00'),
    (4, 'Tuesday', '11:00:00', '12:30:00');

INSERT INTO SECTION (Course_id, Sec_id, Semester, Year, Building, Room_Number, Time_slot_id, Day, Start_time) VALUES
    ('CS101', 1, 'Fall', 2022, 'Building A', 101, 1, 'Monday', '09:00:00'),
    ('MATH101', 1, 'Fall', 2022, 'Building B', 201, 2, 'Wednesday', '13:00:00'),
    ('PHYS101', 1, 'Fall', 2022, 'Building C', 301, 3, 'Friday', '10:00:00'),
    ('CHEM101', 1, 'Fall', 2022, 'Building D', 401, 4, 'Tuesday', '11:00:00');

INSERT INTO TEACHES (I_ID, Course_id, Sec_id, Semester, Year) VALUES
    (1, 'CS101', 1, 'Fall', 2022),
    (2, 'MATH101', 1, 'Fall', 2022),
    (3, 'PHYS101', 1, 'Fall', 2022),
    (4, 'CHEM101', 1, 'Fall', 2022);

INSERT INTO TAKES (S_ID, Course_id, Sec_id, Semester, Year, Grade) VALUES
    (1001, 'CS101', 1, 'Fall', 2022, 'A'),
    (1002, 'MATH101', 1, 'Fall', 2022, 'B'),
    (1003, 'PHYS101', 1, 'Fall', 2022, 'C'),
    (1004, 'CHEM101', 1, 'Fall', 2022, 'B');

INSERT INTO PREREQ (Course_id, Prereq_id) VALUES
    ('CS101', 'MATH101'),
    ('PHYS101', 'MATH101'),
    ('CHEM101', 'MATH101');
