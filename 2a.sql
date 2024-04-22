Create Database CarRental;
use Database CarRental;

CREATE TABLE CAR (
    Registration_No INT PRIMARY KEY,
    Chassis_No VARCHAR(50),
    Engine_No VARCHAR(50),
    Company_Name VARCHAR(100),
    Model VARCHAR(100),
    Year_Model INT,
    Price DECIMAL(10, 2)
);

CREATE TABLE PERSON (
    Aadhar_No VARCHAR(20) PRIMARY KEY,
    Name VARCHAR(100),
    Address VARCHAR(255),
    City VARCHAR(100)
);

CREATE TABLE OWN_BY (
    Registration_No INT,
    Aadhar_No VARCHAR(20),
    FOREIGN KEY (Registration_No) REFERENCES CAR(Registration_No),
    FOREIGN KEY (Aadhar_No) REFERENCES PERSON(Aadhar_No),
    PRIMARY KEY (Registration_No, Aadhar_No)
);

CREATE TABLE DRIVER (
    License_No VARCHAR(50) PRIMARY KEY,
    Date_of_Issue DATE,
    Valid_up_to DATE,
    Aadhar_No VARCHAR(20),
    FOREIGN KEY (Aadhar_No) REFERENCES PERSON(Aadhar_No)
);

INSERT INTO CAR (Registration_No, Chassis_No, Engine_No, Company_Name, Model, Year_Model, Price)
VALUES (1, 'CHS123', 'ENG456', 'Toyota', 'Camry', 2022, 25000.00);

INSERT INTO PERSON (Aadhar_No, Name, Address, City)
VALUES ('123456789012', 'John Doe', '123 Main St', 'New York');

INSERT INTO OWN_BY (Registration_No, Aadhar_No)
VALUES (1, '123456789012');

INSERT INTO DRIVER (License_No, Date_of_Issue, Valid_up_to, Aadhar_No)
VALUES ('DL123', '2020-01-01', '2025-01-01', '123456789012');
