SELECT * FROM BOOKS;
SELECT * FROM BRANCH;
SELECT * FROM EMPLOYEES;
SELECT * FROM ISSUED_STATUS;
SELECT * FROM MEMBERS;
SELECT * FROM  RETURN_STATUS;

#----PROJECT TASKS-----

# Task 1)  --Create a New Book Record -- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"

INSERT INTO BOOKS (isbn, book_title, category, rental_price, status, author, publisher)
VALUES ('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');

# Task 2) --Update an Existing Member's Address

UPDATE members
SET member_address= "345 puk gt"
WHERE member_id= "c101";

# --Task 3) Delete a Record from the Issued Status Table -- Objective: Delete the record with issued_id = 'IS121' from the issued_status table.

DELETE FROM Issued_Status
WHERE issued_id = 'IS121';

#  ---Task 4) Retrieve All Books Issued by a Specific Employee -- Objective: Select all books issued by the employee with emp_id = 'E101'.

SELECT * FROM issued_status
WHERE issued_emp_id = 'E101';

#  ---Task 5) List Members Who Have Issued More Than One Book -- Objective: Use GROUP BY to find members who have issued more than one book.

SELECT 
issued_emp_id,COUNT(*) 
FROM issued_status
GROUP BY issued_emp_id
HAVING COUNT(*) >1;

#---CTAS---
 
#Task 6) ---Create Summary Tables: Used CTAS to generate new tables based on query results - each book and total book_issued_cnt*

CREATE TABLE book_counts
AS 
SELECT b.isbn,b.book_title,count(ist.issued_id) 
FROM books AS b
JOIN
issued_status AS ist
ON ist.issued_book_isbn = b.isbn
GROUP BY b.isbn,b.book_title;

SELECT * FROM book_counts;

#----Task 7) Retrieve All Books in a Specific Category:

SELECT * FROM books
WHERE category = "children";

#----Task 8) Find Total Rental Income by Category:

SELECT 
category,
sum(rental_price),
count(*)
FROM books AS b
JOIN
issued_status AS ist
ON ist.issued_book_isbn = b.isbn
GROUP BY category;

#----Task 9)List Members Who Registered in the Last 180 Days:

SELECT *
FROM members
WHERE reg_date >= DATE_SUB(CURRENT_DATE, INTERVAL 180 DAY);

#---Task 10)List Employees with Their Branch Manager's Name and their branch details:

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

#----Task 11) Create a Table of Books with Rental Price Above a Certain Threshold 10 usd:

CREATE TABLE book_price_greater_than_seven
AS
SELECT isbn,book_title,rental_price
FROM books
WHERE rental_price > 7;

select * from book_price_greater_than_seven;

#----Task 12: Retrieve the List of Books Not Yet Returned

SELECT DISTINCT ist.issued_book_name
FROM issued_status AS ist
LEFT JOIN
return_status as rs
ON ist.issued_id=rs.issued_id
WHERE return_id IS NULL











