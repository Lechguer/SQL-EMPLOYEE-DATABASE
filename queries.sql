-- =============================================================
--  SQL Employee Database — Query Collection
--  Each query is self-contained and labelled by category.
-- =============================================================

-- ─────────────────────────────────────────────
--  BASIC RETRIEVAL
-- ─────────────────────────────────────────────

-- 1. All employees (explicit columns — avoid SELECT *)
SELECT
    EmployeeID,
    FirstName,
    LastName,
    Email,
    PhoneNumber,
    HireDate,
    Salary,
    DepartmentID,
    ManagerID
FROM EMPLOYEE;


-- 2. Employee's full name with their job title
SELECT
    e.EmployeeID,
    e.FirstName || ' ' || e.LastName AS FullName,
    j.JobTitle,
    e.Salary
FROM EMPLOYEE e
JOIN JOB j ON e.JobID = j.JobID
ORDER BY e.LastName;


-- 3. Employee with their department name and location
SELECT
    e.EmployeeID,
    e.FirstName || ' ' || e.LastName AS FullName,
    d.DepartmentName,
    d.Location
FROM EMPLOYEE e
JOIN DEPARTMENT d ON e.DepartmentID = d.DepartmentID
ORDER BY d.DepartmentName;


-- ─────────────────────────────────────────────
--  AGGREGATION & GROUPING
-- ─────────────────────────────────────────────

-- 4. Number of employees per department
SELECT
    d.DepartmentName,
    COUNT(e.EmployeeID) AS TotalEmployees
FROM DEPARTMENT d
LEFT JOIN EMPLOYEE e ON d.DepartmentID = e.DepartmentID
GROUP BY d.DepartmentName
ORDER BY TotalEmployees DESC;


-- 5. Highest, lowest, and average salary per department
SELECT
    d.DepartmentName,
    MAX(e.Salary)              AS MaxSalary,
    MIN(e.Salary)              AS MinSalary,
    ROUND(AVG(e.Salary), 2)   AS AvgSalary,
    SUM(e.Salary)              AS TotalPayroll
FROM EMPLOYEE e
JOIN DEPARTMENT d ON e.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentName
ORDER BY TotalPayroll DESC;


-- ─────────────────────────────────────────────
--  FILTERING
-- ─────────────────────────────────────────────

-- 6. Employees earning above 6 000
SELECT
    e.EmployeeID,
    e.FirstName || ' ' || e.LastName AS FullName,
    j.JobTitle,
    e.Salary
FROM EMPLOYEE e
JOIN JOB j ON e.JobID = j.JobID
WHERE e.Salary > 6000
ORDER BY e.Salary DESC;


-- 7. Employees whose salary is outside their job band (data-quality check)
SELECT
    e.EmployeeID,
    e.FirstName || ' ' || e.LastName AS FullName,
    j.JobTitle,
    e.Salary,
    j.MinSalary,
    j.MaxSalary,
    CASE
        WHEN e.Salary < j.MinSalary THEN 'BELOW BAND'
        WHEN e.Salary > j.MaxSalary THEN 'ABOVE BAND'
    END AS BandStatus
FROM EMPLOYEE e
JOIN JOB j ON e.JobID = j.JobID
WHERE e.Salary NOT BETWEEN j.MinSalary AND j.MaxSalary;


-- ─────────────────────────────────────────────
--  SELF-JOIN — MANAGER HIERARCHY
-- ─────────────────────────────────────────────

-- 8. Employee alongside their manager's name (NULL = top-level)
SELECT
    e.EmployeeID,
    e.FirstName || ' ' || e.LastName         AS Employee,
    COALESCE(m.FirstName || ' ' || m.LastName, '— No Manager —') AS Manager
FROM EMPLOYEE e
LEFT JOIN EMPLOYEE m ON e.ManagerID = m.EmployeeID
ORDER BY Manager, Employee;


-- 9. Top-level employees (no manager assigned)
SELECT
    EmployeeID,
    FirstName || ' ' || LastName AS FullName
FROM EMPLOYEE
WHERE ManagerID IS NULL;


-- 10. Number of direct reports per manager
SELECT
    m.EmployeeID                             AS ManagerID,
    m.FirstName || ' ' || m.LastName         AS ManagerName,
    COUNT(e.EmployeeID)                      AS DirectReports
FROM EMPLOYEE m
JOIN EMPLOYEE e ON e.ManagerID = m.EmployeeID
GROUP BY m.EmployeeID, m.FirstName, m.LastName
ORDER BY DirectReports DESC;


-- ─────────────────────────────────────────────
--  WINDOW FUNCTIONS
-- ─────────────────────────────────────────────

-- 11. Salary rank within each department (1 = highest paid)
SELECT
    e.FirstName || ' ' || e.LastName AS FullName,
    d.DepartmentName,
    e.Salary,
    RANK() OVER (
        PARTITION BY e.DepartmentID
        ORDER BY e.Salary DESC
    ) AS SalaryRankInDept
FROM EMPLOYEE e
JOIN DEPARTMENT d ON e.DepartmentID = d.DepartmentID
ORDER BY d.DepartmentName, SalaryRankInDept;


-- 12. Employees earning above their department average
SELECT
    e.FirstName || ' ' || e.LastName         AS FullName,
    d.DepartmentName,
    e.Salary,
    ROUND(AVG(e.Salary) OVER (
        PARTITION BY e.DepartmentID
    ), 2)                                    AS DeptAvgSalary
FROM EMPLOYEE e
JOIN DEPARTMENT d ON e.DepartmentID = d.DepartmentID
WHERE e.Salary > (
    SELECT AVG(Salary)
    FROM   EMPLOYEE sub
    WHERE  sub.DepartmentID = e.DepartmentID
)
ORDER BY d.DepartmentName;


-- ─────────────────────────────────────────────
--  DATE / TENURE
-- ─────────────────────────────────────────────

-- 13. Employee tenure in years, ordered by most senior
--     (JULIANDAY is SQLite syntax; replace with DATEDIFF for MySQL,
--      or DATE_PART / AGE for PostgreSQL)
SELECT
    EmployeeID,
    FirstName || ' ' || LastName AS FullName,
    HireDate,
    ROUND((JULIANDAY('now') - JULIANDAY(HireDate)) / 365.25, 1) AS TenureYears
FROM EMPLOYEE
ORDER BY HireDate;
