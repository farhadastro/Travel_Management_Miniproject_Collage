# PROJECT REPORT: Travel Management System

---

## 1. Cover Page

**Course Name:** Relational Database Management Systems (RDBMS)
**Project Title:** Travel_Management_Miniproject_Collage
**Submitted By:** [Your Name/Roll Number Here]
**Date:** [Submission Date]

---

## 2. Abstract
The "Travel Management System" is a database-centric academic project developed to streamline operations within a travel agency. The core objective is to digitally maintain and trace records related to customers, tour packages, ticket bookings, and payment status. By leveraging Relational Database Management System (RDBMS) concepts such as Normalization, Foreign Key constraints, and optimized SQL Queries, this project ensures high data integrity and reliability, eradicating manual redundant records typical of traditional travel agencies.

---

## 3. Introduction
Managing travel itineraries manually is tedious and prone to data redundancy and inconsistencies. The Travel Management System database resolves these issues by mapping customized databases to real-world scenarios. It allows agencies to track who booked what, the status of the ongoing booking, and financial insights regarding payment settlements. This mini-project incorporates DDL, DML, and robust queries via MySQL to provide an end-to-end perspective on database structuring.

---

## 4. Objectives
- To design a reliable database schema free from insertion, deletion, and update anomalies.
- To enforce Domain and Referential Integrity using Primary/Foreign Keys constraints.
- To demonstrate efficient cross-referencing between customers, packages, bookings, and payments.
- To execute complex joins, subqueries, and grouping techniques for robust data retrieval.

---

## 5. System Overview
The backend is entirely engineered using **MySQL**. Four main entities construct the system:
1. **Customer**: Stores agency client profiles.
2. **Package**: Catalog of available trips, locations, pricing, and duration.
3. **Booking**: The functional bridge mapping a customer to a package along with logistical timelines.
4. **Payment**: Financial transactions bounded perfectly to precise bookings.

---

## 6. ER Diagram (Entity-Relationship Textual Representation)

The mathematical map of the database relates as follows:

- **Entities & Attributes:**
  - **CUSTOMER**: customer_id, first_name, last_name, email, phone, address.
  - **PACKAGE**: package_id, package_name, destination, duration_days, price, description.
  - **BOOKING**: booking_id, booking_date, travel_date, status, total_amount.
  - **PAYMENT**: payment_id, payment_date, amount, payment_method, transaction_status.

- **Relationships & Cardinality:**
  - `CUSTOMER` to `BOOKING`: A customer can make multiple bookings; **(1-to-Many - 1:N)**.
  - `PACKAGE` to `BOOKING`: A package can be booked by many customers; **(1-to-Many - 1:N)**.
  - `BOOKING` to `PAYMENT`: A single booking generally correlates to one finalized payment receipt; **(1-to-1 - 1:1)** *or handled as 1:N if installments exist*.

---

## 7. Relational Schema

- **Customer** (<u>customer_id</u>, first_name, last_name, email, phone, address)
- **Package** (<u>package_id</u>, package_name, destination, duration_days, price, description)
- **Booking** (<u>booking_id</u>, customer_id(FK), package_id(FK), booking_date, travel_date, status, total_amount)
- **Payment** (<u>payment_id</u>, booking_id(FK), payment_date, amount, payment_method, transaction_status)

*(Keys underlined designate PRIMARY KEY)*

---

## 8. Table Structure & Data Dictionary

### Table: Customer
| Attribute | Data Type | Key Type | Description |
| :--- | :--- | :--- | :--- |
| customer_id | INT (Auto Increment) | Primary Key | Unique ID for each customer. |
| first_name | VARCHAR(50) | None | Customer's first name. |
| last_name | VARCHAR(50) | None | Customer's surname. |
| email | VARCHAR(100) | UNIQUE | Contact email (no duplicates). |
| phone | VARCHAR(15) | None | Mobile number. |
| address | TEXT | None | Residential contact location. |

### Table: Package
| Attribute | Data Type | Key Type | Description |
| :--- | :--- | :--- | :--- |
| package_id | INT (Auto Increment) | Primary Key | Unique package identifier. |
| package_name | VARCHAR(100) | None | Title of the tour. |
| destination | VARCHAR(100) | None | Physical location. |
| duration_days | INT | None | Length of trip in days. |
| price | DECIMAL(10,2) | None | Base cost of package. |
| description | TEXT | None | Details about itinerary. |

### Table: Booking
| Attribute | Data Type | Key Type | Description |
| :--- | :--- | :--- | :--- |
| booking_id | INT (Auto Increment) | Primary Key | Unique reservation ID. |
| customer_id | INT | Foreign Key | Ref: Customer(customer_id). |
| package_id | INT | Foreign Key | Ref: Package(package_id). |
| booking_date | DATE | None | Date stamp of reservation. |
| travel_date | DATE | None | Date of expected departure. |
| status | ENUM | None | 'Pending', 'Confirmed', 'Cancelled'. |
| total_amount | DECIMAL(10,2) | None | Locked price at time of booking. |

### Table: Payment
| Attribute | Data Type | Key Type | Description |
| :--- | :--- | :--- | :--- |
| payment_id | INT (Auto Increment) | Primary Key | Unique receipt number. |
| booking_id | INT | Foreign Key | Ref: Booking(booking_id). |
| payment_date | DATE | None | Date payment recorded. |
| amount | DECIMAL(10,2) | None | Value charged. |
| payment_method | ENUM | None | Card, Net Banking, UPI, Cash. |
| transaction_status| ENUM | None | 'Successful', 'Failed', 'Pending'. |

---

## 9. Normalization Applied

The resulting schema is meticulously structured across Normal Forms:

### First Normal Form (1NF)
Every attribute within our tables is atomic and holds a single, indivisible value. For example, `first_name` and `last_name` are separated rather than a singular bulk `Name` field, allowing simpler sorting queries. No repetitive groups exist.

### Second Normal Form (2NF)
The schema satisfies 1NF, and all non-key attributes are fully functionally dependent on the Primary Key. For instance, in the `Booking` table, variables like `travel_date` exclusively rely on the wholly unique primary key `booking_id`, and not on partial components of composite keys. 

### Third Normal Form (3NF)
There are no transitive dependencies. Non-key attributes rely only on the primary key, avoiding dependency on other non-key attributes. Initially, putting `customer_email` explicitly inside the `Booking` table alongside `customer_id` would trigger a transitive dependency; hence they are correctly decoupled to just utilize a Foreign Key reference.

---

## 10. Selected SQL Queries and Expected Outputs

**Query 1: JOIN (Fetching Complete Booking View)**
```sql
SELECT c.first_name, c.last_name, p.package_name, b.booking_date
FROM Customer c
JOIN Booking b ON c.customer_id = b.customer_id
JOIN Package p ON b.package_id = p.package_id;
```
*Expected Output:* Displays tabular data with `Rahul | Sharma | Goa Beach Holiday | 2023-10-01` ensuring we can decode foreign keys mapped against the raw integers.

**Query 2: GROUP BY (Total Booking Demand)**
```sql
SELECT p.package_name, COUNT(b.booking_id) as total_bookings
FROM Package p
LEFT JOIN Booking b ON p.package_id = b.package_id
GROUP BY p.package_id, p.package_name;
```
*Expected Output:* Returns a statistical breakdown of how many bookings belong to each respective package name, displaying `0` if left joined with no recorded sales.

**Query 3: Subqueries (Higher-Value Customers)**
```sql
SELECT first_name, last_name, email
FROM Customer
WHERE customer_id IN (
    SELECT b.customer_id 
    FROM Booking b
    JOIN Payment p ON b.booking_id = p.booking_id 
    WHERE p.amount > 20000 AND p.transaction_status = 'Successful'
);
```
*Expected Output:* Isolates the customers dynamically by inner-evaluating successful payments greater than ₹20,000, ultimately outputting the raw contact information of those premium buyers.

---

## 11. Conclusion
The Travel Management project perfectly aligns raw RDBMS concepts with industrial applicability. Constraints, normalization, and relational structuring ensure data never collapses under anomalous behaviors. The system guarantees that scaling it from fifty records to a million records won't compromise its organizational integrity across queries and aggregation tracking.
