-- ==========================================================
-- Title: Travel_Management_Miniproject_Collage
-- Description: Database Schema, Sample Data, and Practical Queries
-- RDBMS: MySQL
-- ==========================================================

-- 1. Database Creation
CREATE DATABASE IF NOT EXISTS Travel_Management_Miniproject_Collage;
USE Travel_Management_Miniproject_Collage;

-- ==========================================================
-- 2. Table Creation
-- ==========================================================

-- Table: Customer
-- Stores information about clients who use the agency.
CREATE TABLE Customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15) NOT NULL,
    address TEXT
);

-- Table: Package
-- Stores details of various travel packages offered.
CREATE TABLE Package (
    package_id INT AUTO_INCREMENT PRIMARY KEY,
    package_name VARCHAR(100) NOT NULL,
    destination VARCHAR(100) NOT NULL,
    duration_days INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    description TEXT
);

-- Table: Booking
-- Stores booking transactions mapping customers to packages.
CREATE TABLE Booking (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    package_id INT NOT NULL,
    booking_date DATE NOT NULL,
    travel_date DATE NOT NULL,
    status ENUM('Pending', 'Confirmed', 'Cancelled') DEFAULT 'Pending',
    total_amount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id) ON DELETE CASCADE,
    FOREIGN KEY (package_id) REFERENCES Package(package_id) ON DELETE CASCADE
);

-- Table: Payment
-- Stores payment records linked to specific bookings.
CREATE TABLE Payment (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id INT NOT NULL,
    payment_date DATE NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    payment_method ENUM('Credit Card', 'Debit Card', 'UPI', 'Net Banking', 'Cash') NOT NULL,
    transaction_status ENUM('Successful', 'Failed', 'Pending') DEFAULT 'Pending',
    FOREIGN KEY (booking_id) REFERENCES Booking(booking_id) ON DELETE CASCADE
);

-- ==========================================================
-- 3. Insert Sample Data
-- ==========================================================

INSERT INTO Customer (first_name, last_name, email, phone, address) VALUES
('Rahul', 'Sharma', 'rahul.s@example.com', '9876543210', '123 MG Road, Bangalore'),
('Priya', 'Patel', 'priya.p@example.com', '8765432109', '456 SG Highway, Ahmedabad'),
('Amit', 'Singh', 'amit.s@example.com', '7654321098', '789 CP, New Delhi'),
('Sneha', 'Reddy', 'sneha.r@example.com', '6543210987', '321 Jubilee Hills, Hyderabad'),
('Vikram', 'Joshi', 'vikram.j@example.com', '5432109876', '654 FC Road, Pune');

INSERT INTO Package (package_name, destination, duration_days, price, description) VALUES
('Goa Beach Holiday', 'Goa', 5, 15000.00, 'Enjoy 5 days of sun, sand, and beaches in North Goa.'),
('Kerala Backwaters', 'Munnar', 6, 22000.00, 'Relaxing houseboats and tea gardens.'),
('Manali Adventure', 'Manali', 7, 18000.00, 'Snow peaks, trekking, and adventure sports.'),
('Rajasthan Royals', 'Jaipur', 4, 12000.00, 'Explore the forts and palaces of pink city.'),
('Andaman Scuba', 'Andaman', 6, 35000.00, 'Scuba diving, water sports, and pristine beaches.');

INSERT INTO Booking (customer_id, package_id, booking_date, travel_date, status, total_amount) VALUES
(1, 1, '2023-10-01', '2023-10-15', 'Confirmed', 15000.00),
(2, 3, '2023-10-02', '2023-10-20', 'Confirmed', 18000.00),
(3, 2, '2023-10-05', '2023-11-01', 'Pending', 22000.00),
(4, 5, '2023-10-10', '2023-11-15', 'Confirmed', 35000.00),
(5, 4, '2023-10-12', '2023-10-25', 'Cancelled', 12000.00);

INSERT INTO Payment (booking_id, payment_date, amount, payment_method, transaction_status) VALUES
(1, '2023-10-01', 15000.00, 'UPI', 'Successful'),
(2, '2023-10-02', 18000.00, 'Credit Card', 'Successful'),
(4, '2023-10-10', 35000.00, 'Net Banking', 'Successful'),
(5, '2023-10-12', 12000.00, 'Debit Card', 'Failed');

-- ==========================================================
-- 4. Sample Queries for Project Demonstration
-- ==========================================================

-- Query 1: Simple SELECT with filtering
-- Purpose: Retrieve all bookings that are currently confirmed.
SELECT * FROM Booking WHERE status = 'Confirmed';

-- Query 2: INNER JOIN
-- Purpose: Fetch customer details alongside the package name they booked.
SELECT c.first_name, c.last_name, p.package_name, b.travel_date, b.status
FROM Customer c
JOIN Booking b ON c.customer_id = b.customer_id
JOIN Package p ON b.package_id = p.package_id;

-- Query 3: AGGREGATE FUNCTION & GROUP BY
-- Purpose: Calculate total successful revenue generated.
SELECT SUM(amount) AS total_revenue 
FROM Payment 
WHERE transaction_status = 'Successful';

-- Query 4: GROUP BY with AGGREGATION & LEFT JOIN
-- Purpose: Count how many bookings each package has received.
SELECT p.package_name, COUNT(b.booking_id) as total_bookings
FROM Package p
LEFT JOIN Booking b ON p.package_id = b.package_id
GROUP BY p.package_id, p.package_name;

-- Query 5: SUBQUERY
-- Purpose: Find names of customers who have made payments exceeding 20,000.
SELECT first_name, last_name, email
FROM Customer
WHERE customer_id IN (
    SELECT b.customer_id 
    FROM Booking b
    JOIN Payment p ON b.booking_id = p.booking_id 
    WHERE p.amount > 20000 AND p.transaction_status = 'Successful'
);

-- Query 6: Filtering & Mathematical Operations
-- Purpose: Display packages that cost less than 20000 and calculate a 10% discount on them.
SELECT package_name, price, (price * 0.90) AS discounted_price 
FROM Package 
WHERE price < 20000;

-- Query 7: UPDATE Statement
-- Purpose: Update a specific booking status from 'Pending' to 'Confirmed'.
UPDATE Booking 
SET status = 'Confirmed' 
WHERE booking_id = 3;

-- Verification of Update
SELECT * FROM Booking WHERE booking_id = 3;
