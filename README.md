# Library Management System using SQL Project -2

## Project Overview

**Project Title**: Library Management System  
**Level**: Intermediate  
**Database**: `library_db`

This project demonstrates the implementation of a Library Management System using SQL. It includes creating and managing tables, performing CRUD operations, and executing advanced SQL queries. The goal is to showcase skills in database design, manipulation, and querying.

## Objectives

1. **Set up the Library Management System Database**: Create and populate the database with tables for branches, employees, members, books, issued status, and return status.
2. **CRUD Operations**: Perform Create, Read, Update, and Delete operations on the data.
3. **CTAS (Create Table As Select)**: Utilize CTAS to create new tables based on query results.
4. **Advanced SQL Queries**: Develop complex queries to analyze and retrieve specific data.

## Project Structure

### 1. Database Setup

- **Database Creation**: Created a database named `library_db`.
- **Table Creation**: Created tables for branches, employees, members, books, issued status, and return status. Each table includes relevant columns and relationships.

```sql
CREATE TABLE BRANCH
(
branch_id VARCHAR(25) PRIMARY KEY,
manager_id VARCHAR(10),
branch_address VARCHAR(55),
contact_no VARCHAR(10)
);

CREATE TABLE EMPLOYEES
(
emp_id VARCHAR(10) PRIMARY KEY,
emp_name VARCHAR(25),
position VARCHAR(15),
salary INT,
branch_id VARCHAR(25)
);

CREATE TABLE BOOKS
(
isbn VARCHAR(25) PRIMARY KEY,
book_title VARCHAR(75),
category VARCHAR(20),
rental_price FLOAT,
status VARCHAR(15),
author VARCHAR(35),
publisher VARCHAR(55)
);

CREATE TABLE MEMBERS
(
member_id VARCHAR(20) PRIMARY KEY,
member_name VARCHAR(25),
member_address VARCHAR(75),
reg_date DATE
);

CREATE TABLE ISSUED_STATUS
(
issued_id VARCHAR(25) PRIMARY KEY,
issued_member_id VARCHAR(20),
issued_book_name VARCHAR(75),
issued_date DATE,
issued_book_isbn VARCHAR(25),
issued_emp_id VARCHAR(10)
);

CREATE TABLE RETURN_STATUS
(
return_id VARCHAR(10) PRIMARY KEY,
issued_id VARCHAR(25),
return_book_name VARCHAR(75),
return_date DATE,
return_book_isbn VARCHAR(25)
);

-- STEP 4: ADD ALL FOREIGN KEYS
ALTER TABLE ISSUED_STATUS
ADD CONSTRAINT FK_MEMBERS
FOREIGN KEY(issued_member_id)
REFERENCES MEMBERS(member_id);

ALTER TABLE ISSUED_STATUS
ADD CONSTRAINT FK_BOOKS
FOREIGN KEY(issued_book_isbn)
REFERENCES BOOKS(isbn);

ALTER TABLE ISSUED_STATUS
ADD CONSTRAINT FK_EMPLOYEES
FOREIGN KEY(issued_emp_id)
REFERENCES EMPLOYEES(emp_id);

ALTER TABLE EMPLOYEES
ADD CONSTRAINT FK_BRANCH
FOREIGN KEY(branch_id)
REFERENCES BRANCH(branch_id);

ALTER TABLE RETURN_STATUS
ADD CONSTRAINT FK_ISSUED_STATUS
FOREIGN KEY(issued_id)
REFERENCES ISSUED_STATUS(issued_id);

ALTER TABLE RETURN_STATUS
ADD CONSTRAINT FK_RETURN_BOOKS
FOREIGN KEY(return_book_isbn)
REFERENCES BOOKS(isbn);

ALTER TABLE BRANCH
ADD CONSTRAINT FK_MANAGER
FOREIGN KEY(manager_id)
REFERENCES EMPLOYEES(emp_id);

USE LIBRARY_PROJECT_2;

INSERT INTO MEMBERS(member_id, member_name, member_address, reg_date) 
VALUES
('C101', 'Alice Johnson', '123 Main St', '2021-05-15'),
('C102', 'Bob Smith', '456 Elm St', '2021-06-20'),
('C103', 'Carol Davis', '789 Oak St', '2021-07-10'),
('C104', 'Dave Wilson', '567 Pine St', '2021-08-05'),
('C105', 'Eve Brown', '890 Maple St', '2021-09-25'),
('C106', 'Frank Thomas', '234 Cedar St', '2021-10-15'),
('C107', 'Grace Taylor', '345 Walnut St', '2021-11-20'),
('C108', 'Henry Anderson', '456 Birch St', '2021-12-10'),
('C109', 'Ivy Martinez', '567 Oak St', '2022-01-05'),
('C110', 'Jack Wilson', '678 Pine St', '2022-02-25'),
('C118', 'Sam', '133 Pine St', '2024-06-01'),    
('C119', 'John', '143 Main St', '2024-05-01');
SELECT * FROM MEMBERS;


-- Insert values into each branch table
ALTER TABLE BRANCH CHECK CONSTRAINT FK_MANAGER;
INSERT INTO BRANCH(branch_id, manager_id, branch_address, contact_no) 
VALUES
('B001', 'E109', '123 Main St', '+919099988676'),
('B002', 'E109', '456 Elm St', '+919099988677'),
('B003', 'E109', '789 Oak St', '+919099988678'),
('B004', 'E110', '567 Pine St', '+919099988679'),
('B005', 'E110', '890 Maple St', '+919099988680');
SELECT * FROM BRANCH;


-- Insert values into each employees table
INSERT INTO EMPLOYEES(emp_id, emp_name, position, salary, branch_id) 
VALUES
('E101', 'John Doe', 'Clerk', 60000.00, 'B001'),
('E102', 'Jane Smith', 'Clerk', 45000.00, 'B002'),
('E103', 'Mike Johnson', 'Librarian', 55000.00, 'B001'),
('E104', 'Emily Davis', 'Assistant', 40000.00, 'B001'),
('E105', 'Sarah Brown', 'Assistant', 42000.00, 'B001'),
('E106', 'Michelle Ramirez', 'Assistant', 43000.00, 'B001'),
('E107', 'Michael Thompson', 'Clerk', 62000.00, 'B005'),
('E108', 'Jessica Taylor', 'Clerk', 46000.00, 'B004'),
('E109', 'Daniel Anderson', 'Manager', 57000.00, 'B003'),
('E110', 'Laura Martinez', 'Manager', 41000.00, 'B005'),
('E111', 'Christopher Lee', 'Assistant', 65000.00, 'B005');
SELECT * FROM EMPLOYEES;


-- Inserting into books table 
INSERT INTO BOOKS(isbn, book_title, category, rental_price, status, author, publisher) 
VALUES
('978-0-553-29698-2', 'The Catcher in the Rye', 'Classic', 7.00, 'yes', 'J.D. Salinger', 'Little, Brown and Company'),
('978-0-330-25864-8', 'Animal Farm', 'Classic', 5.50, 'yes', 'George Orwell', 'Penguin Books'),
('978-0-14-118776-1', 'One Hundred Years of Solitude', 'Literary Fiction', 6.50, 'yes', 'Gabriel Garcia Marquez', 'Penguin Books'),
('978-0-525-47535-5', 'The Great Gatsby', 'Classic', 8.00, 'yes', 'F. Scott Fitzgerald', 'Scribner'),
('978-0-141-44171-6', 'Jane Eyre', 'Classic', 4.00, 'yes', 'Charlotte Bronte', 'Penguin Classics'),
('978-0-307-37840-1', 'The Alchemist', 'Fiction', 2.50, 'yes', 'Paulo Coelho', 'HarperOne'),
('978-0-679-76489-8', 'Harry Potter and the Sorcerers Stone', 'Fantasy', 7.00, 'yes', 'J.K. Rowling', 'Scholastic'),
('978-0-7432-4722-4', 'The Da Vinci Code', 'Mystery', 8.00, 'yes', 'Dan Brown', 'Doubleday'),
('978-0-09-957807-9', 'A Game of Thrones', 'Fantasy', 7.50, 'yes', 'George R.R. Martin', 'Bantam'),
('978-0-393-05081-8', 'A Peoples History of the United States', 'History', 9.00, 'yes', 'Howard Zinn', 'Harper Perennial'),
('978-0-19-280551-1', 'The Guns of August', 'History', 7.00, 'yes', 'Barbara W. Tuchman', 'Oxford University Press'),
('978-0-307-58837-1', 'Sapiens: A Brief History of Humankind', 'History', 8.00, 'no', 'Yuval Noah Harari', 'Harper Perennial'),
('978-0-375-41398-8', 'The Diary of a Young Girl', 'History', 6.50, 'no', 'Anne Frank', 'Bantam'),
('978-0-14-044930-3', 'The Histories', 'History', 5.50, 'yes', 'Herodotus', 'Penguin Classics'),
('978-0-393-91257-8', 'Guns, Germs, and Steel: The Fates of Human Societies', 'History', 7.00, 'yes', 'Jared Diamond', 'W. W. Norton & Company'),
('978-0-7432-7357-1', '1491: New Revelations of the Americas Before Columbus', 'History', 6.50, 'no', 'Charles C. Mann', 'Vintage Books'),
('978-0-679-64115-3', '1984', 'Dystopian', 6.50, 'yes', 'George Orwell', 'Penguin Books'),
('978-0-14-143951-8', 'Pride and Prejudice', 'Classic', 5.00, 'yes', 'Jane Austen', 'Penguin Classics'),
('978-0-452-28240-7', 'Brave New World', 'Dystopian', 6.50, 'yes', 'Aldous Huxley', 'Harper Perennial'),
('978-0-670-81302-4', 'The Road', 'Dystopian', 7.00, 'yes', 'Cormac McCarthy', 'Knopf'),
('978-0-385-33312-0', 'The Shining', 'Horror', 6.00, 'yes', 'Stephen King', 'Doubleday'),
('978-0-451-52993-5', 'Fahrenheit 451', 'Dystopian', 5.50, 'yes', 'Ray Bradbury', 'Ballantine Books'),
('978-0-345-39180-3', 'Dune', 'Science Fiction', 8.50, 'yes', 'Frank Herbert', 'Ace'),
('978-0-375-50167-0', 'The Road', 'Dystopian', 7.00, 'yes', 'Cormac McCarthy', 'Vintage'),
('978-0-06-025492-6', 'Where the Wild Things Are', 'Children', 3.50, 'yes', 'Maurice Sendak', 'HarperCollins'),
('978-0-06-112241-5', 'The Kite Runner', 'Fiction', 5.50, 'yes', 'Khaled Hosseini', 'Riverhead Books'),
('978-0-06-440055-8', 'Charlotte''s Web', 'Children', 4.00, 'yes', 'E.B. White', 'Harper & Row'),
('978-0-679-77644-3', 'Beloved', 'Fiction', 6.50, 'yes', 'Toni Morrison', 'Knopf'),
('978-0-14-027526-3', 'A Tale of Two Cities', 'Classic', 4.50, 'yes', 'Charles Dickens', 'Penguin Books'),
('978-0-7434-7679-3', 'The Stand', 'Horror', 7.00, 'yes', 'Stephen King', 'Doubleday'),
('978-0-451-52994-2', 'Moby Dick', 'Classic', 6.50, 'yes', 'Herman Melville', 'Penguin Books'),
('978-0-06-112008-4', 'To Kill a Mockingbird', 'Classic', 5.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.'),
('978-0-553-57340-1', '1984', 'Dystopian', 6.50, 'yes', 'George Orwell', 'Penguin Books'),
('978-0-7432-4722-5', 'Angels & Demons', 'Mystery', 7.50, 'yes', 'Dan Brown', 'Doubleday'),
('978-0-7432-7356-4', 'The Hobbit', 'Fantasy', 7.00, 'yes', 'J.R.R. Tolkien', 'Houghton Mifflin Harcourt');
SELECT * FROM BOOKS;

-- inserting into issued table
INSERT INTO ISSUED_STATUS(issued_id, issued_member_id, issued_book_name, issued_date, issued_book_isbn, issued_emp_id) 
VALUES
('IS106', 'C106', 'Animal Farm', '2024-03-10', '978-0-330-25864-8', 'E104'),
('IS107', 'C107', 'One Hundred Years of Solitude', '2024-03-11', '978-0-14-118776-1', 'E104'),
('IS108', 'C108', 'The Great Gatsby', '2024-03-12', '978-0-525-47535-5', 'E104'),
('IS109', 'C109', 'Jane Eyre', '2024-03-13', '978-0-141-44171-6', 'E105'),
('IS110', 'C110', 'The Alchemist', '2024-03-14', '978-0-307-37840-1', 'E105'),
('IS111', 'C109', 'Harry Potter and the Sorcerers Stone', '2024-03-15', '978-0-679-76489-8', 'E105'),
('IS112', 'C109', 'A Game of Thrones', '2024-03-16', '978-0-09-957807-9', 'E106'),
('IS113', 'C109', 'A Peoples History of the United States', '2024-03-17', '978-0-393-05081-8', 'E106'),
('IS114', 'C109', 'The Guns of August', '2024-03-18', '978-0-19-280551-1', 'E106'),
('IS115', 'C109', 'The Histories', '2024-03-19', '978-0-14-044930-3', 'E107'),
('IS116', 'C110', 'Guns, Germs, and Steel: The Fates of Human Societies', '2024-03-20', '978-0-393-91257-8', 'E107'),
('IS117', 'C110', '1984', '2024-03-21', '978-0-679-64115-3', 'E107'),
('IS118', 'C101', 'Pride and Prejudice', '2024-03-22', '978-0-14-143951-8', 'E108'),
('IS119', 'C110', 'Brave New World', '2024-03-23', '978-0-452-28240-7', 'E108'),
('IS120', 'C110', 'The Road', '2024-03-24', '978-0-670-81302-4', 'E108'),
('IS121', 'C102', 'The Shining', '2024-03-25', '978-0-385-33312-0', 'E109'),
('IS122', 'C102', 'Fahrenheit 451', '2024-03-26', '978-0-451-52993-5', 'E109'),
('IS123', 'C103', 'Dune', '2024-03-27', '978-0-345-39180-3', 'E109'),
('IS124', 'C104', 'Where the Wild Things Are', '2024-03-28', '978-0-06-025492-6', 'E110'),
('IS125', 'C105', 'The Kite Runner', '2024-03-29', '978-0-06-112241-5', 'E110'),
('IS126', 'C105', 'Charlotte''s Web', '2024-03-30', '978-0-06-440055-8', 'E110'),
('IS127', 'C105', 'Beloved', '2024-03-31', '978-0-679-77644-3', 'E110'),
('IS128', 'C105', 'A Tale of Two Cities', '2024-04-01', '978-0-14-027526-3', 'E110'),
('IS129', 'C105', 'The Stand', '2024-04-02', '978-0-7434-7679-3', 'E110'),
('IS130', 'C106', 'Moby Dick', '2024-04-03', '978-0-451-52994-2', 'E101'),
('IS131', 'C106', 'To Kill a Mockingbird', '2024-04-04', '978-0-06-112008-4', 'E101'),
('IS132', 'C106', 'The Hobbit', '2024-04-05', '978-0-7432-7356-4', 'E106'),
('IS133', 'C107', 'Angels & Demons', '2024-04-06', '978-0-7432-4722-5', 'E106'),
('IS134', 'C107', 'The Diary of a Young Girl', '2024-04-07', '978-0-375-41398-8', 'E106'),
('IS135', 'C107', 'Sapiens: A Brief History of Humankind', '2024-04-08', '978-0-307-58837-1', 'E108'),
('IS136', 'C107', '1491: New Revelations of the Americas Before Columbus', '2024-04-09', '978-0-7432-7357-1', 'E102'),
('IS137', 'C107', 'The Catcher in the Rye', '2024-04-10', '978-0-553-29698-2', 'E103'),
('IS138', 'C108', 'The Great Gatsby', '2024-04-11', '978-0-525-47535-5', 'E104'),
('IS139', 'C109', 'Harry Potter and the Sorcerers Stone', '2024-04-12', '978-0-679-76489-8', 'E105'),
('IS140', 'C110', 'Animal Farm', '2024-04-13', '978-0-330-25864-8', 'E102');
SELECT * FROM ISSUED_STATUS;


-- inserting into return table
ALTER TABLE RETURN_STATUS NOCHECK CONSTRAINT FK_ISSUED_STATUS;
INSERT INTO RETURN_STATUS(return_id, issued_id, return_date) 
VALUES
('RS101', 'IS101', '2023-06-06'),
('RS102', 'IS105', '2023-06-07'),
('RS103', 'IS103', '2023-08-07'),
('RS104', 'IS106', '2024-05-01'),
('RS105', 'IS107', '2024-05-03'),
('RS106', 'IS108', '2024-05-05'),
('RS107', 'IS109', '2024-05-07'),
('RS108', 'IS110', '2024-05-09'),
('RS109', 'IS111', '2024-05-11'),
('RS110', 'IS112', '2024-05-13'),
('RS111', 'IS113', '2024-05-15'),
('RS112', 'IS114', '2024-05-17'),
('RS113', 'IS115', '2024-05-19'),
('RS114', 'IS116', '2024-05-21'),
('RS115', 'IS117', '2024-05-23'),
('RS116', 'IS118', '2024-05-25'),
('RS117', 'IS119', '2024-05-27'),
('RS118', 'IS120', '2024-05-29');
SELECT * FROM RETURN_STATUS;

ALTER TABLE BRANCH CHECK CONSTRAINT FK_MANAGER;
ALTER TABLE RETURN_STATUS CHECK CONSTRAINT FK_ISSUED_STATUS;
ALTER TABLE RETURN_STATUS CHECK CONSTRAINT FK_RETURN_BOOKS;
ALTER TABLE ISSUED_STATUS CHECK CONSTRAINT FK_MEMBERS;
ALTER TABLE ISSUED_STATUS CHECK CONSTRAINT FK_BOOKS;
ALTER TABLE ISSUED_STATUS CHECK CONSTRAINT FK_EMPLOYEES;
ALTER TABLE EMPLOYEES CHECK CONSTRAINT FK_BRANCH;

SELECT * FROM BRANCH;
SELECT * FROM EMPLOYEES;
SELECT * FROM BOOKS;
SELECT * FROM MEMBERS;
SELECT * FROM ISSUED_STATUS;
SELECT * FROM RETURN_STATUS;
```

### 2. CRUD Operations

- **Create**: Inserted sample records into the `books` table.
- **Read**: Retrieved and displayed data from various tables.
- **Update**: Updated records in the `employees` table.
- **Delete**: Removed records from the `members` table as needed.

**Task 1. Create a New Book Record**
-- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"

```sql
INSERT INTO BOOKS(isbn, book_title, category, rental_price, status, author, publisher)
VALUES
('978-1-60129-456-2', 'To Kill a Mockingbird', 
'Classic', 6.00, 'yes', 'Harper Lee', 
'J.B. Lippincott & Co.');
SELECT * FROM BOOKS;
```
**Task 2: Update an Existing Member's Address**

```sql
 UPDATE MEMBERS SET member_address ='203 Main St'
 WHERE member_id ='C101';
  SELECT * FROM MEMBERS;
```

**Task 3: Delete a Record from the Issued Status Table**
-- Objective: Delete the record with issued_id = 'IS121' from the issued_status table.

```sql
 DELETE FROM ISSUED_STATUS
WHERE   issued_id =   'IS121';

SELECT * FROM ISSUED_STATUS;
```

**Task 4: Retrieve All Books Issued by a Specific Employee**
-- Objective: Select all books issued by the employee with emp_id = 'E101'.
```sql
SELECT * FROM ISSUED_STATUS
WHERE issued_emp_id = 'E101'

SELECT * FROM ISSUED_STATUS;'
```


**Task 5: List Members Who Have Issued More Than One Book**
-- Objective: Use GROUP BY to find members who have issued more than one book.

```sql
SELECT 
    issued_member_id,
    COUNT(issued_id) AS total_books_issued
FROM ISSUED_STATUS
GROUP BY issued_member_id
HAVING COUNT(issued_id) > 1
ORDER BY total_books_issued DESC;
```

### 3. CTAS (Create Table As Select)

- **Task 6: Create Summary Tables**: Used CTAS to generate new tables based on query results - each book and total book_issued_cnt**

```sql
SELECT 
    b.isbn,
    b.book_title,
    COUNT(i.issued_id) AS total_book_issued_cnt
INTO BOOK_ISSUED_CNT  -- this creates new table
FROM BOOKS AS b
JOIN ISSUED_STATUS AS i
ON b.isbn = i.issued_book_isbn
GROUP BY b.isbn, b.book_title;

SELECT * FROM BOOK_ISSUED_CNT;
```


### 4. Data Analysis & Findings

The following SQL queries were used to address specific questions:

Task 7. **Retrieve All Books in a Specific Category**:

```sql
SELECT * FROM BOOKS
WHERE category = 'Classic';
```

8. **Task 8: Find Total Rental Income by Category**:

```sql
SELECT
b.category,
SUM(b.rental_price) as Total_price
FROM BOOKS AS b
JOIN ISSUED_STATUS AS i
ON b.isbn = i.issued_book_isbn
GROUP BY b.category

```

9. **List Members Who Registered in the Last 180 Days**:
```sql
INSERT INTO MEMBERS(member_id,member_name,member_address,reg_date)
VALUES
('C220','SAM','145 MAIN ST', '2026-02-25'),
('C221','RITA','177 MAIN ST', '2026-02-23');
SELECT * FROM MEMBERS
WHERE reg_date >= DATEADD(DAY, -180, GETDATE());
```

10. **List Employees with Their Branch Manager's Name and their branch details**:

```sql
 SELECT 
    E1.emp_id,
    E1.emp_name,
    E1.position,
    E1.salary,
    E1.branch_id,
  B.manager_id,
  E2.emp_name AS MANAGER
  FROM EMPLOYEES AS E1
  JOIN BRANCH AS B
  ON B.branch_id =E1.branch_id
  JOIN EMPLOYEES AS E2
  ON B.manager_id= E2.emp_id 
```

Task 11. **Create a Table of Books with Rental Price Above a Certain Threshold**:
```sql

  SELECT * 
INTO EXPENSIVE_BOOKS
FROM BOOKS
WHERE rental_price > 7;

SELECT * FROM EXPENSIVE_BOOKS;
```

Task 12: **Retrieve the List of Books Not Yet Returned**
```sql
SELECT 
DISTINCT IST.issued_book_name
FROM ISSUED_STATUS AS IST
LEFT JOIN
RETURN_STATUS RS
ON
IST.issued_id =RS.issued_id
WHERE RS.return_id IS NULL 

```

## Advanced SQL Operations

**Task 13: Identify Members with Overdue Books**  
Write a query to identify members who have overdue books (assume a 30-day return period). Display the member's_id, member's name, book title, issue date, and days overdue.

```sql
SELECT 
    IST.issued_member_id,
    M.member_name,
    B.book_title,
    IST.issued_date,
    DATEDIFF(DAY, IST.issued_date, GETDATE()) AS days_overdue
FROM ISSUED_STATUS AS IST
JOIN MEMBERS AS M
ON M.member_id = IST.issued_member_id
JOIN BOOKS AS B
ON B.isbn = IST.issued_book_isbn
LEFT JOIN RETURN_STATUS AS RS
ON RS.issued_id = IST.issued_id
WHERE RS.return_date IS NULL
AND DATEDIFF(DAY, IST.issued_date, GETDATE()) > 30
ORDER BY days_overdue DESC;
```


**Task 14: Update Book Status on Return**  
Write a query to update the status of books in the books table to "Yes" when they are returned (based on entries in the return_status table).


```sql

ALTER TABLE RETURN_STATUS
ADD book_quality VARCHAR(10);
GO

 CREATE OR ALTER PROCEDURE add_return_records
    @p_return_id VARCHAR(10),
    @p_issued_id VARCHAR(10),
    @p_book_quality VARCHAR(10)
AS
BEGIN
    DECLARE @v_isbn VARCHAR(50);
    DECLARE @v_book_name VARCHAR(80);

    -- INSERT INTO RETURN_STATUS
    INSERT INTO RETURN_STATUS(return_id, issued_id, return_date, book_quality)
    VALUES (@p_return_id, @p_issued_id, GETDATE(), @p_book_quality);

    -- GET ISBN AND BOOK NAME
    SELECT 
        @v_isbn = issued_book_isbn,
        @v_book_name = issued_book_name
    FROM ISSUED_STATUS
    WHERE issued_id = @p_issued_id;

    -- UPDATE BOOK STATUS
    UPDATE BOOKS
    SET status = 'yes'
    WHERE isbn = @v_isbn;

    PRINT 'Thank you for returning the book: ' + @v_book_name;
END;

-- CALL PROCEDURE
EXEC add_return_records 'RS138', 'IS135', 'Good';
EXEC add_return_records 'RS148', 'IS140', 'Good';

-- CHECK RESULTS
SELECT * FROM BOOKS
WHERE isbn = '978-0-307-58837-1';

SELECT * FROM ISSUED_STATUS
WHERE issued_book_isbn = '978-0-307-58837-1';

SELECT * FROM RETURN_STATUS
WHERE issued_id = 'IS135';
```




**Task 15: Branch Performance Report**  
Create a query that generates a performance report for each branch, showing the number of books issued, the number of books returned, and the total revenue generated from book rentals.

```sql
SELECT 
B.branch_id,
B.manager_id,
COUNT(IST.issued_id) AS NUMBER_BOOK_ISSUED ,
COUNT(RS.return_id) AS NUMBER_OF_BOOK_RETURN,
SUM (BK.rental_price) AS TOTAL_REVENUE
INTO BRANCH_REPORTS
FROM ISSUED_STATUS AS IST
JOIN EMPLOYEES AS E
ON E.emp_id= IST.issued_emp_id
JOIN
BRANCH AS B
ON E.branch_id= B.branch_id
LEFT JOIN
RETURN_STATUS AS RS
ON RS.issued_id= IST.issued_id
JOIN 
BOOKS AS BK
ON IST.issued_book_isbn=BK.isbn
GROUP BY B.branch_id,
B.manager_id

SELECT * FROM BRANCH_REPORTS
```

**Task 16: CTAS: Create a Table of Active Members**  
Use the CREATE TABLE AS (CTAS) statement to create a new table active_members containing members who have issued at least one book in the last 2 months.

```sql

SELECT * 
INTO ACTIVE_MEMBERS
FROM MEMBERS
WHERE member_id IN (
         SELECT 
            DISTINCT issued_member_id   
               FROM ISSUED_STATUS
                 WHERE 
           issued_date >= DATEADD(MONTH, -2, GETDATE())
                    );


SELECT * FROM ACTIVE_MEMBERS;

```


**Task 17: Find Employees with the Most Book Issues Processed**  
Write a query to find the top 3 employees who have processed the most book issues. Display the employee name, number of books processed, and their branch.

```sql
SELECT 
    e.emp_name,
    b.branch_id,
    b.manager_id,
    b.branch_address,
    b.contact_no,
    COUNT(ist.issued_id) AS no_book_issued
FROM ISSUED_STATUS AS ist
JOIN EMPLOYEES AS e
ON e.emp_id = ist.issued_emp_id
JOIN BRANCH AS b
ON e.branch_id = b.branch_id
GROUP BY 
    e.emp_name,
    b.branch_id,
    b.manager_id,
    b.branch_address,
    b.contact_no;
```


   


## Reports

- **Database Schema**: Detailed table structures and relationships.
- **Data Analysis**: Insights into book categories, employee salaries, member registration trends, and issued books.
- **Summary Reports**: Aggregated data on high-demand books and employee performance.

## Conclusion

This project demonstrates the application of SQL skills in creating and managing a library management system. It includes database setup, data manipulation, and advanced querying, providing a solid foundation for data management and analysis.

## How to Use

1. **Clone the Repository**: Clone this repository to your local machine.
   ```sh
2. **Set Up the Database**: Execute the SQL scripts in the `database_setup.sql` file to create and populate the database.
3. **Run the Queries**: Use the SQL queries in the `analysis_queries.sql` file to perform the analysis.
4. **Explore and Modify**: Customize the queries as needed to explore different aspects of the data or answer additional questions.
