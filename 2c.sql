Create Database Company;
use Database Company;
CREATE TABLE COMPANY (
    C_Registration_No INT PRIMARY KEY,
    C_Name VARCHAR(100),
    Address VARCHAR(255)
);

CREATE TABLE PERSON (
    Aadhar_No VARCHAR(20) PRIMARY KEY,
    Name VARCHAR(100),
    Father_Name VARCHAR(100),
    Date_of_Birth DATE,
    Address VARCHAR(255)
);

CREATE TABLE OWNED_BY (
    C_Registration_No INT,
    Aadhar_No VARCHAR(20),
    FOREIGN KEY (C_Registration_No) REFERENCES COMPANY(C_Registration_No),
    FOREIGN KEY (Aadhar_No) REFERENCES PERSON(Aadhar_No),
    PRIMARY KEY (C_Registration_No, Aadhar_No)
);

-- Insert tuples
INSERT INTO COMPANY (C_Registration_No, C_Name, Address)
VALUES (1, 'ABC Corporation', '123 Business St');

INSERT INTO PERSON (Aadhar_No, Name, Father_Name, Date_of_Birth, Address)
VALUES ('123456789012', 'John Doe', 'John Doe Sr.', '1990-01-01', '456 Oak St');

INSERT INTO OWNED_BY (C_Registration_No, Aadhar_No)
VALUES (1, '123456789012');
