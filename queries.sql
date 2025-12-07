-- 1. Show all employees
SELECT * FROM EMPLOYEE;

-- 2. Employees with their job title
SELECT e.FirstName, e.LastName, j.JobTitle
FROM EMPLOYEE e
JOIN JOB j ON e.JobID = j.JobID;

-- 3. Employees per department
SELECT d.DepartmentName, COUNT(*) AS TotalEmployees
FROM EMPLOYEE e
JOIN DEPARTMENT d ON e.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentName;

-- 4. Employees earning more than 6000
SELECT * FROM EMPLOYEE WHERE Salary > 6000;

-- 5. Highest salary in each department
SELECT DepartmentID, MAX(Salary) AS MaxSalary
FROM EMPLOYEE
GROUP BY DepartmentID;

-- 6. Employee and Manager name
SELECT e.FirstName || ' ' || e.LastName AS Employee,
       m.FirstName || ' ' || m.LastName AS Manager
FROM EMPLOYEE e
LEFT JOIN EMPLOYEE m ON e.ManagerID = m.EmployeeID;
