CREATE TABLE DEPARTMENT(
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50),
    Location VARCHAR(50)
);

CREATE TABLE JOB(
    JobID INT PRIMARY KEY,
    JobTitle VARCHAR(50),
    MinSalary INT,
    MaxSalary INT
);

CREATE TABLE EMPLOYEE(
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(50) UNIQUE,
    PhoneNumber VARCHAR(20) UNIQUE,
    HireDate DATE,
    JobID INT,
    Salary DECIMAL(10,2),
    ManagerID INT,
    DepartmentID INT,
    FOREIGN KEY (JobID) REFERENCES JOB(JobID),
    FOREIGN KEY (ManagerID) REFERENCES EMPLOYEE(EmployeeID),
    FOREIGN KEY (DepartmentID) REFERENCES DEPARTMENT(DepartmentID)
);


-- Insert Departments
INSERT INTO DEPARTMENT VALUES (1, 'Human Resources', 'Casablanca');
INSERT INTO DEPARTMENT VALUES (2, 'Finance', 'Rabat');
INSERT INTO DEPARTMENT VALUES (3, 'IT', 'Marrakech');
INSERT INTO DEPARTMENT VALUES (4, 'Marketing', 'Tangier');
INSERT INTO DEPARTMENT VALUES (5, 'Operations', 'Agadir');

-- Insert Jobs
INSERT INTO JOB VALUES (1, 'Software Engineer', 4000, 9000);
INSERT INTO JOB VALUES (2, 'Data Analyst', 3500, 8000);
INSERT INTO JOB VALUES (3, 'HR Manager', 5000, 10000);
INSERT INTO JOB VALUES (4, 'Accountant', 3000, 7500);
INSERT INTO JOB VALUES (5, 'Marketing Specialist', 3200, 7800);

-- Insert Employee
INSERT INTO EMPLOYEE VALUES (1, 'Zakaria', 'Elhadi', 'emp1@mail.com', '0610000001', '2021-01-15', 1, 5500, NULL, 1),
 (2, 'Ahmed', 'Baker', 'emp2@mail.com', '0610000002', '2021-02-20', 1, 5200, 1, 1),
 (3, 'Sara', 'Mansouri', 'emp3@mail.com', '0610000003', '2021-03-12', 2, 6000, 1, 2),
 (4, 'Youssef', 'Haddad', 'emp4@mail.com', '0610000004', '2021-04-10', 3, 4800, 1, 3),
 (5, 'Salma', 'Idrissi', 'emp5@mail.com', '0610000005', '2021-05-22', 2, 6200, NULL, 2),
 (6, 'Mounir', 'Fassi', 'emp6@mail.com', '0610000006', '2021-06-18', 4, 4500, 3, 2),
 (7, 'Hana', 'Othmani', 'emp7@mail.com', '0610000007', '2021-07-01', 5, 4700, 3, 4),
 (8, 'Khalid', 'Rahimi', 'emp8@mail.com', '0610000008', '2021-08-14', 1, 5900, 2, 3),
 (9, 'Nadia', 'Slaoui', 'emp9@mail.com', '0610000009', '2021-09-30', 4, 5300, 3, 1),
 (10, 'Imane', 'Jabiri', 'emp10@mail.com', '0610000010', '2021-10-11', 2, 6500, 1, 2),
 (11, 'Adam', 'Lotfi', 'emp11@mail.com', '0610000011', '2021-02-11', 1, 5200, 1, 3),
 (12, 'Aya', 'Benali', 'emp12@mail.com', '0610000012', '2021-04-01', 5, 4800, 1, 4),
 (13, 'Yassine', 'Tahiri', 'emp50@mail.com', '0610000050', '2022-12-10', 3, 7200, 1, 1)

