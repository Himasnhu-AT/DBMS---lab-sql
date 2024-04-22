Create Database Library;
use Database Library;

CREATE TABLE BOOK (
    Access_No INT PRIMARY KEY,
    Title VARCHAR(255),
    Author VARCHAR(100),
    Subject_Code VARCHAR(50)
);

CREATE TABLE MEMBER (
    Membership_No INT PRIMARY KEY,
    Type VARCHAR(50)
);

CREATE TABLE EMPLOYEE (
    Emp_Code INT PRIMARY KEY,
    Name VARCHAR(100),
    Designation VARCHAR(100),
    Dept_Name VARCHAR(100)
);

CREATE TABLE STUDENT (
    Roll_No INT PRIMARY KEY,
    Dept_Name VARCHAR(100),
    Program VARCHAR(100)
);

CREATE TABLE BOOKS_ISSUE (
    Register_Entry_No INT PRIMARY KEY,
    Access_No INT,
    Membership_No INT,
    Date_of_Issue DATE,
    FOREIGN KEY (Access_No) REFERENCES BOOK(Access_No),
    FOREIGN KEY (Membership_No) REFERENCES MEMBER(Membership_No)
);

CREATE TABLE BOOKS_RETURN (
    Access_No INT PRIMARY KEY,
    Return_Date DATE,
    Comment VARCHAR(255),
    FOREIGN KEY (Access_No) REFERENCES BOOK(Access_No)
);

-- Insert tuples
INSERT INTO BOOK (Access_No, Title, Author, Subject_Code)
VALUES (1, 'The Great Gatsby', 'F. Scott Fitzgerald', 'LIT001');

INSERT INTO MEMBER (Membership_No, Type)
VALUES (1, 'Student');

INSERT INTO EMPLOYEE (Emp_Code, Name, Designation, Dept_Name)
VALUES (101, 'John Smith', 'Librarian', 'Library');

INSERT INTO STUDENT (Roll_No, Dept_Name, Program)
VALUES (201, 'Computer Science', 'Bachelor of Science');

INSERT INTO BOOKS_ISSUE (Register_Entry_No, Access_No, Membership_No, Date_of_Issue)
VALUES (1, 1, 1, '2024-02-25');

INSERT INTO BOOKS_RETURN (Access_No, Return_Date, Comment)
VALUES (1, '2024-03-25', 'Book returned in good condition');
