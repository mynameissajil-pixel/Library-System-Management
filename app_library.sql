-- Library System Management SQL Project

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


-- Project TASK


-- ### 2. CRUD Operations


-- Task 1. Create a New Book Record
-- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"

-- Task 2: Update an Existing Member's Address


-- Task 3: Delete a Record from the Issued Status Table
-- Objective: Delete the record with issued_id = 'IS104' from the issued_status table.

-- Task 4: Retrieve All Books Issued by a Specific Employee
-- Objective: Select all books issued by the employee with emp_id = 'E101'.


-- Task 5: List Members Who Have Issued More Than One Book
-- Objective: Use GROUP BY to find members who have issued more than one book.


-- ### 3. CTAS (Create Table As Select)

-- Task 6: Create Summary Tables**: Used CTAS to generate new tables based on query results - each book and total book_issued_cnt


-- ### 4. Data Analysis & Findings

-- Task 7. **Retrieve All Books in a Specific Category:


-- Task 8: Find Total Rental Income by Category:


-- Task 9. **List Members Who Registered in the Last 180 Days**:

-- Task 10: List Employees with Their Branch Manager's Name and their branch details**:


-- Task 11. Create a Table of Books with Rental Price Above a Certain Threshold

-- Task 12: Retrieve the List of Books Not Yet Returned

    

