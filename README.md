# 🗄️ SQL Employee Database

![SQL](https://img.shields.io/badge/SQL-PostgreSQL%20%7C%20MySQL%20%7C%20SQLite-blue)
![Status](https://img.shields.io/badge/status-active-brightgreen)

A relational database project modelling a company's workforce — covering schema design, data integrity constraints, indexes, and a library of practical SQL queries.

---

## 📁 Project Structure

```
SQL-EMPLOYEE-DATABASE/
├── schema.sql   # CREATE TABLE statements, constraints, indexes, and seed data
├── queries.sql  # 13 categorised SELECT queries (basic → window functions)
└── README.md
```

---

## 🏗️ Database Schema

### Tables

| Table        | Primary Key    | Description                                      |
|--------------|----------------|--------------------------------------------------|
| `DEPARTMENT` | `DepartmentID` | Company departments and their office locations   |
| `JOB`        | `JobID`        | Job titles with salary bands (min / max)         |
| `EMPLOYEE`   | `EmployeeID`   | Staff records, linked to department, job, manager|

### Relationships

```
DEPARTMENT ──< EMPLOYEE >── JOB
                  │
                  └── (self-reference) ManagerID → EmployeeID
```

- One **Department** → Many **Employees**
- One **Job** → Many **Employees**
- One **Employee** can manage many other **Employees** (recursive FK)

### Constraints & Data Quality

| Constraint | Purpose |
|---|---|
| `NOT NULL` on name, email, hire date, salary | Prevents incomplete records |
| `UNIQUE` on `Email` and `PhoneNumber` | No duplicate contact info |
| `CHECK (MaxSalary >= MinSalary)` | Salary band must be valid |
| `CHECK (Salary >= 0)` | No negative salaries |
| `CHECK (ManagerID <> EmployeeID)` | An employee cannot manage themselves |

### Indexes

`idx_employee_department`, `idx_employee_job`, `idx_employee_manager` — added on foreign key columns to speed up JOINs and filtered lookups.

---

## 🗺 ER Diagram

👉 [![ER Diagram](https://img.shields.io/badge/ER%20Diagram-Interactive-blue)](https://lechguer.github.io/SQL-EMPLOYEE-DATABASE/er-diagram.html)

> Drag the tables to reposition them · Scroll to zoom · Pan by dragging the canvas

---

## 🚀 Quick Start

### SQLite
```bash
sqlite3 company.db < schema.sql
sqlite3 company.db < queries.sql
```

### PostgreSQL
```bash
psql -U postgres -d your_db -f schema.sql
psql -U postgres -d your_db -f queries.sql
```

### MySQL / MariaDB
```bash
mysql -u root -p your_db < schema.sql
mysql -u root -p your_db < queries.sql
```

> **Note for MySQL users:** Replace `||` string concatenation with `CONCAT()`, and `JULIANDAY()` with `DATEDIFF()` in the tenure query.

---

## 📊 Query Overview

| # | Category | What it answers |
|---|---|---|
| 1 | Basic retrieval | All employee records |
| 2 | JOIN | Employee names with job titles |
| 3 | JOIN | Employees with department & location |
| 4 | GROUP BY | Headcount per department |
| 5 | Aggregation | Max / min / avg / total payroll per department |
| 6 | Filter | Employees earning above 6 000 |
| 7 | Data quality | Employees paid outside their job band |
| 8 | Self-JOIN | Employee ↔ manager name pairs |
| 9 | Filter | Top-level employees (no manager) |
| 10 | Self-JOIN + GROUP | Direct reports per manager |
| 11 | Window function | Salary rank within each department |
| 12 | Subquery | Employees above their department average |
| 13 | Date math | Tenure in years, ordered by seniority |

---

## 💡 Skills Demonstrated

- Relational schema design (1-to-many, self-referencing FK)
- Data integrity via `NOT NULL`, `UNIQUE`, and `CHECK` constraints
- Performance optimisation with indexes on FK columns
- Multi-table `JOIN`, `LEFT JOIN`, and self-`JOIN`
- `GROUP BY` with aggregate functions (`COUNT`, `MAX`, `MIN`, `AVG`, `SUM`)
- Window functions (`RANK() OVER`, `AVG() OVER PARTITION BY`)
- Subqueries and `COALESCE` for null handling
- Date arithmetic for tenure calculation

---

## 🌍 Sample Data

13 employees across 5 Moroccan cities (Casablanca, Rabat, Marrakech, Tangier, Agadir), 5 departments, and 5 job roles.
