USE LIBRARY_PROJECT_2;

--13)Write a query to identify members who have overdue books (assume a 30-day return period). Display the member's_id, member's name, book title, issue date, and days overdue.

--JOIN ISSUED_STATUS-MEMBERS-BOOKS-RETURN_STATUS
--FILTER BOOKS WHICH IS RETURN
--OVERDUE>30
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

--14)Write a query to update the status of books in the books table to "Yes" when they are returned (based on entries in the return_status table).

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

--15) Branch Performance Report
Create a query that generates a performance report for each branch, showing the number of books issued, the number of books returned, and the total revenue generated from book rentals.


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

--16) CTAS: Create a Table of Active Members
Use the CREATE TABLE AS (CTAS) statement to create a new table active_members containing members who have issued at least one book in the last 2 months.

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

--17)17: Find Employees with the Most Book Issues Processed
--Write a query to find the top 3 employees who have processed the most book issues. Display the employee name, number of books processed, and their branch.

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