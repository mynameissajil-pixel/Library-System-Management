# Library Management System using SQL Project --P2

## Project Overview

**Project Title**: Library Management System   
**Database**: `library_db`

This project demonstrates the implementation of a Library Management System using SQL. It includes creating and managing tables, performing CRUD operations, and executing advanced SQL queries. The goal is to showcase skills in database design, manipulation, and querying.

![Library_project](https://github.com/mynameissajil-pixel/Library-System-Management/blob/5e2936ee1bf1e8b63fde2a37e9100dffcd4fcf25/library.jpg)

## Objectives

1. **Set up the Library Management System Database**: Create and populate the database with tables for branches, employees, members, books, issued status, and return status.
2. **CRUD Operations**: Perform Create, Read, Update, and Delete operations on the data.
3. **CTAS (Create Table As Select)**: Utilize CTAS to create new tables based on query results.

## Project Structure

### 1. Database Setup
![](https://github.com/mynameissajil-pixel/Library-System-Management/blob/5593644624efd71084e2a0065cb15d7a2f0c4704/Screenshot%202026-03-09%20220229.png)

- **Database Creation**: Created a database named `library_project_2`.
- **Table Creation**: Created tables for branches, employees, members, books, issued status, and return status. Each table includes relevant columns and relationships.

```sql
create database library_project_2;
use library_project_2;

#------library management system project 2------

CREATE TABLE branch
         (branch_id VARCHAR(10) PRIMARY KEY,
	      manager_id VARCHAR (20),
          branch_address VARCHAR (55),
          contact_no VARCHAR (10));
ALTER TABLE branch
MODIFY contact_no VARCHAR(20);
select * from branch;

CREATE TABLE employees
		(emp_id VARCHAR(10) PRIMARY KEY,
         emp_name VARCHAR(25),
         position VARCHAR(15),
         salary int,
         branch_id VARCHAR(25));

delete from employees;
	
CREATE TABLE books
	   (isbn VARCHAR(20) PRIMARY KEY,
        book_title VARCHAR(75),
        category VARCHAR(10),
        rental_price FLOAT,
        status VARCHAR(15),
        author VARCHAR(35),
        publisher VARCHAR(55));
        
ALTER TABLE books
MODIFY category VARCHAR(20);
DELETE FROM books;
select * from books;

CREATE TABLE members
       (member_id VARCHAR(10)PRIMARY KEY,
        member_name VARCHAR(25),
        member_address VARCHAR(75),
        reg_date DATE);
        
CREATE TABLE issued_status
       (issued_id VARCHAR(10)PRIMARY KEY,	
        issued_member_id VARCHAR(10),	
        issued_book_name VARCHAR(75),	
        issued_date	DATE, 
        issued_book_isbn VARCHAR(25),	
        issued_emp_id VARCHAR(10));
        
CREATE TABLE return_status
       (return_id VARCHAR(10)PRIMARY KEY,	
        issued_id VARCHAR(10),	
        return_book_name VARCHAR(10),	
        return_date DATE,	
        return_book_isbn VARCHAR(20));

delete from return_status;
        
#---FOREIGN KEY----

ALTER TABLE issued_status
ADD constraint fk_members
foreign key (issued_member_id)
REFERENCES members(member_id);

ALTER TABLE issued_status
ADD constraint fk_books
foreign key (issued_book_isbn)
REFERENCES books(isbn);

ALTER TABLE issued_status
ADD constraint fk_employees
foreign key (issued_emp_id)
REFERENCES employees(emp_id);

ALTER TABLE employees
ADD constraint fk_branch
foreign key (branch_id)
REFERENCES branch(branch_id);

ALTER TABLE return_status
ADD constraint fk_issued_status
foreign key (issued_id)
REFERENCES issued_status(issued_id);

DELETE FROM return_status;
DELETE FROM issued_status;
DELETE FROM employees;
DELETE FROM books;
DELETE FROM members;
DELETE FROM branch;

```

### 2. CRUD Operations

- **Create**: Inserted sample records into the `books` table.
- **Read**: Retrieved and displayed data from various tables.
- **Update**: Updated records in the `employees` table.
- **Delete**: Removed records from the `members` table as needed.

**Task 1. Create a New Book Record**
-- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"

```sql
INSERT INTO BOOKS (isbn, book_title, category, rental_price, status, author, publisher)
VALUES ('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');
```
**Task 2: Update an Existing Member's Address**

```sql
UPDATE members
SET member_address= "345 puk gt"
WHERE member_id= "c101";
```

**Task 3: Delete a Record from the Issued Status Table**
-- Objective: Delete the record with issued_id = 'IS121' from the issued_status table.

```sql
DELETE FROM Issued_Status
WHERE issued_id = 'IS121';
```

**Task 4: Retrieve All Books Issued by a Specific Employee**
-- Objective: Select all books issued by the employee with emp_id = 'E101'.
```sql
SELECT * FROM issued_status
WHERE issued_emp_id = 'E101';
```


**Task 5: List Members Who Have Issued More Than One Book**
-- Objective: Use GROUP BY to find members who have issued more than one book.

```sql
SELECT 
issued_emp_id,COUNT(*) 
FROM issued_status
GROUP BY issued_emp_id
HAVING COUNT(*) >1;
```

### 3. CTAS (Create Table As Select)

- **Task 6: Create Summary Tables**: Used CTAS to generate new tables based on query results - each book and total book_issued_cnt**

```sql
CREATE TABLE book_counts
AS 
SELECT b.isbn,b.book_title,count(ist.issued_id) 
FROM books AS b
JOIN
issued_status AS ist
ON ist.issued_book_isbn = b.isbn
GROUP BY b.isbn,b.book_title;

SELECT * FROM book_counts;
```


### 4. Data Analysis & Findings

The following SQL queries were used to address specific questions:

Task 7. **Retrieve All Books in a Specific Category**:

```sql
SELECT * FROM books
WHERE category = "children";
```

8. **Task 8: Find Total Rental Income by Category**:

```sql
SELECT 
category,
sum(rental_price),
count(*)
FROM books AS b
JOIN
issued_status AS ist
ON ist.issued_book_isbn = b.isbn
GROUP BY category;
```

9. **List Members Who Registered in the Last 180 Days**:
```sql
SELECT *
FROM members
WHERE reg_date >= DATE_SUB(CURRENT_DATE, INTERVAL 180 DAY);
```

10. **List Employees with Their Branch Manager's Name and their branch details**:

```sql
SELECT 
E1.*,
b.branch_id,
e2.emp_name as manager
FROM 
employees as e1
JOIN
branch as b
ON b.branch_id = e1.branch_id
JOIN employees AS e2
ON b.manager_id= e2.emp_id;
```

Task 11. **Create a Table of Books with Rental Price Above a Certain Threshold**:
```sql
CREATE TABLE book_price_greater_than_seven
AS
SELECT isbn,book_title,rental_price
FROM books
WHERE rental_price > 7;

select * from book_price_greater_than_seven;
```

Task 12: **Retrieve the List of Books Not Yet Returned**
```sql
SELECT DISTINCT ist.issued_book_name
FROM issued_status AS ist
LEFT JOIN
return_status as rs
ON ist.issued_id=rs.issued_id
WHERE return_id IS NULL
```



## Reports

- **Database Schema**: Detailed table structures and relationships.
- **Data Analysis**: Insights into book categories, employee salaries, member registration trends, and issued books.
- **Summary Reports**: Aggregated data on high-demand books and employee performance.

## Conclusion

This project demonstrates the application of SQL skills in creating and managing a library management system. It includes database setup, data manipulation, and advanced querying, providing a solid foundation for data management and analysis.








