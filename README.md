# SQL Employee Database Project

A comprehensive SQL project that showcases database design, table creation, foreign keys, sample data generation, and effective queries.  


---

## 📌 Project Structure

- **schema.sql** → Contains all CREATE TABLE + INSERT statements  
- **queries.sql** → Contains useful SELECT queries  
- **ER Diagram** → Designed with QuickDBD  

---

## 🏗 Database Schema

### **Tables:**
- **DEPARTMENT** (DepartmentID, Name, Location)
- **JOB** (JobID, Title, MinSalary, MaxSalary)
- **EMPLOYEE** (Employee details + ManagerID FK)

### **Relationships:**
- One Department → Many Employees  
- One Job → Many Employees  
- One Employee → Can manage others (self-reference)

---

## 🗺 ER Diagram

<img width="842" height="570" alt="ER DIAGRAM" src="https://github.com/user-attachments/assets/a6ac5d24-1957-48b9-968a-3f0ae3350131" />

---
