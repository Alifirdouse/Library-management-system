-- Create the database
CREATE DATABASE library;

-- Use the newly created database
USE library;

-- Create the Branch table
CREATE TABLE Branch (
    Branch_no INT PRIMARY KEY,
    Manager_Id INT,
    Branch_address VARCHAR(255),
    Contact_no VARCHAR(15)
);

-- Create the Employee table
CREATE TABLE Employee (
    Emp_Id INT PRIMARY KEY,
    Emp_name VARCHAR(100),
    Position VARCHAR(50),
    Salary DECIMAL(10, 2),
    Branch_no INT,
    FOREIGN KEY (Branch_no) REFERENCES Branch(Branch_no)
);

-- Create the Books table
CREATE TABLE Books (
    ISBN VARCHAR(13) PRIMARY KEY,
    Book_title VARCHAR(255),
    Category VARCHAR(50),
    Rental_Price DECIMAL(10, 2),
    Status ENUM('yes', 'no'),
    Author VARCHAR(100),
    Publisher VARCHAR(100)
);

-- Create the Customer table
CREATE TABLE Customer (
    Customer_Id INT PRIMARY KEY,
    Customer_name VARCHAR(100),
    Customer_address VARCHAR(255),
    Reg_date DATE
);

-- Create the IssueStatus table
CREATE TABLE IssueStatus (
    Issue_Id INT PRIMARY KEY,
    Issued_cust_id INT,
    Issued_book_name VARCHAR(255),
    Issue_date DATE,
    Isbn_book VARCHAR(13),
    FOREIGN KEY (Issued_cust_id) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book) REFERENCES Books(ISBN)
);

-- Create the ReturnStatus table
CREATE TABLE ReturnStatus (
    Return_Id INT PRIMARY KEY,
    Return_cust INT,
    Return_book_name VARCHAR(255),
    Return_date DATE,
    Isbn_book2 VARCHAR(13),
    FOREIGN KEY (Return_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book2) REFERENCES Books(ISBN)
);
show tables;

-- Insert rows into the Branch table
INSERT INTO Branch (Branch_no, Manager_Id, Branch_address, Contact_no) VALUES
(1, 1001, '123 Main St, Cityville', '9874563221'),
(2, 1002, '456 Elm St, Townsville', '9638521470'),
(3, 1003, '789 Maple St, Villageburg', '8852524163'),
(4, 1004, '321 Oak St, Metropolis', '9895632121'),
(5, 1050, '654 Pine St, Ruralville', '8845127800');

-- Insert rows into the Employee table
INSERT INTO Employee (Emp_Id, Emp_name, Position, Salary, Branch_no) VALUES
(1, 'Alice Smith', 'Librarian', 45000.00, 1),
(2, 'Bob Johnson', 'Assistant Librarian', 35000.00, 1),
(3, 'Charlie Brown', 'Librarian', 48000.00, 2),
(4, 'Diana Prince', 'Assistant Librarian', 36000.00, 3),
(5, 'Edward Davis', 'Manager', 60000.00, 4);

-- Insert additional rows into the Employee table
INSERT INTO Employee (Emp_Id, Emp_name, Position, Salary, Branch_no) VALUES
(6, 'Liam ', 'Librarian', 46000.00, 1),
(7, 'Mia ', 'Assistant Librarian', 32000.00, 1),
(8, 'Noah ', 'Librarian', 54000.00, 2),
(9, 'Olivia ', 'Office staff', 72000.00, 3),
(10, 'Sophia ', 'Assistant Librarian', 35000.00, 4);
INSERT INTO Employee (Emp_Id, Emp_name, Position, Salary, Branch_no) VALUES
(11, 'samson ', 'Librarian', 46000.00, 1),
(12, 'virat ', 'Assistant Librarian', 32000.00, 1),
(13, 'ashwin ', 'Librarian', 54000.00, 1),
(14, 'nathon ', 'Office staff', 72000.00, 1),
(15, 'Theresa ', 'Assistant Librarian', 35000.00, 1);


-- Insert rows into the Books table
INSERT INTO Books (ISBN, Book_title, Category, Rental_Price, Status, Author, Publisher) VALUES
('251', 'A Brief History of Time', 'Science', 25.00, 'yes', 'Stephen Hawking', 'Bantam'),
('252', 'History: A Very Short Introduction', 'History', 30.00, 'yes', 'John H. Arnold', 'Oxford University Press'),
('253', 'Pride and Prejudice', 'Classic', 40.00, 'yes', 'Jane Austen', 'T. Egerton'),
('254', 'To Kill a Mockingbird', 'Fiction', 60.00, 'no', 'Harper Lee', 'J.B. Lippincott & Co.'),
('255', 'History of the Ancient World', 'History', 80.00, 'yes', 'Susan Wise Bauer', 'W.W. Norton & Company');


-- Insert rows into the Customer table
INSERT INTO Customer (Customer_Id, Customer_name, Customer_address, Reg_date) VALUES
(1, 'John Doe', '101 First St, Cityville', '2021-01-15'),
(2, 'Jane Smith', '202 Second St, Townsville', '2021-02-20'),
(3, 'Michael Brown', '303 Third St, Villageburg', '2021-03-10'),
(4, 'Emily Davis', '404 Fourth St, Metropolis', '2021-04-05'),
(5, 'William Johnson', '505 Fifth St, Ruralville', '2021-05-25');

-- Insert rows into the IssueStatus table
INSERT INTO IssueStatus (Issue_Id, Issued_cust_id, Issued_book_name, Issue_date, Isbn_book) VALUES
(1, 1, 'The Great Gatsby', '2023-06-01', '251'),
(2, 2, '1984', '2023-06-15', '252'),
(5, 5, 'The Catcher in the Rye', '2023-07-20', '255');

-- Insert rows into the ReturnStatus table
INSERT INTO ReturnStatus (Return_Id, Return_cust, Return_book_name, Return_date, Isbn_book2) VALUES
(1, 1, 'The Great Gatsby', '2023-06-10', '251'),
(2, 2, '1984', '2023-06-25', '252'),
(5, 5, 'The Catcher in the Rye', '2023-07-30', '255');

-- 1. Retrieve the book title, category, and rental price of all available books.
SELECT Book_title, Category, Rental_Price
FROM Books
WHERE Status = 'yes';

-- 2. List the employee names and their respective salaries in descending order of salary.
SELECT Emp_name, Salary
FROM Employee
ORDER BY Salary DESC;

-- 3. Retrieve the book titles and the corresponding customers who have issued those books.
SELECT b.Book_title, c.Customer_name
FROM IssueStatus i
JOIN Books b ON i.Isbn_book = b.ISBN
JOIN Customer c ON i.Issued_cust_id = c.Customer_Id;

-- 4. Display the total count of books in each category.
SELECT Category, COUNT(*) AS Total_Books
FROM Books
GROUP BY Category;

-- 5. Retrieve the employee names and their positions for the employees whose salaries are above Rs. 50,000.
SELECT Emp_name, Position
FROM Employee
WHERE Salary > 50000;

-- 6. List the customer names who registered before 2022-01-01 and have not issued any books yet.
SELECT c.Customer_name
FROM Customer c
LEFT JOIN IssueStatus i ON c.Customer_Id = i.Issued_cust_id
WHERE c.Reg_date < '2022-01-01' AND i.Issued_cust_id IS NULL;

-- 7. Display the branch numbers and the total count of employees in each branch.
SELECT Branch_no, COUNT(*) AS Total_Employees
FROM Employee
GROUP BY Branch_no;

-- 8. Display the names of customers who have issued books in the month of June 2023.
SELECT DISTINCT c.Customer_name
FROM IssueStatus i
JOIN Customer c ON i.Issued_cust_id = c.Customer_Id
WHERE i.Issue_date BETWEEN '2023-06-01' AND '2023-06-30';

-- 9. Retrieve book_title from the book table containing "history".
SELECT Book_title
FROM Books
WHERE Book_title LIKE '%history%';

-- 10. Retrieve the branch numbers along with the count of employees for branches having more than 5 employees.
SELECT Branch_no, COUNT(*) AS Total_Employees
FROM Employee
GROUP BY Branch_no
HAVING COUNT(*) > 5;

-- 11. Retrieve the names of employees who manage branches and their respective branch addresses.
SELECT e.Emp_name, b.Branch_address
FROM Employee e
JOIN Branch b ON e.Branch_no = b.Branch_no
WHERE e.Position = 'Manager';

-- 12. Display the names of customers who have issued books with a rental price higher than Rs. 25.
SELECT DISTINCT c.Customer_name
FROM IssueStatus i
JOIN Books b ON i.Isbn_book = b.ISBN
JOIN Customer c ON i.Issued_cust_id = c.Customer_Id
WHERE b.Rental_Price > 25;








