# Instruction Manual: How to Run the Project

Welcome to the Travel Management System. This guide will walk you through setting up the database, importing the project, running queries, and validating outputs locally on your machine.

---

## Step 1: Set Up MySQL Environment
1. Ensure you have **MySQL Server** installed. You can download it from the [official MySQL Website](https://dev.mysql.com/downloads/).
2. You will also need a GUI tool to interact with your databases, such as **MySQL Workbench** (often bundled with MySQL Installer) or **phpMyAdmin** (if using XAMPP/WAMP).
3. Start your MySQL Server. If using XAMPP, open the XAMPP Control Panel and start the "MySQL" module.

---

## Step 2: Import the SQL File
1. Open your MySQL Client (e.g., MySQL Workbench).
2. Connect to your local database using your username (usually `root`) and password.
3. Once connected, go to **File > Open SQL Script...** in the top menu.
4. Locate and select the `Travel_Management_System.sql` file provided with this project.
5. In the script window that opens, you will see all the database creation, table structures, and data inserts.

---

## Step 3: Execute the Project
1. To run the entire script at once, click the **Lightning Bolt icon** ⚡ (Execute) at the top of the SQL Editor.
2. The script will automatically:
   - Create a database called `Travel_Management_Miniproject_Collage`.
   - Set it up to be the active database using `USE`.
   - Create 4 normalized tables (`Customer`, `Package`, `Booking`, `Payment`).
   - Insert 5 sample rows into each active table for demonstration.
3. Check the **Output Console** at the bottom of Workbench. You should see a series of green checkmarks indicating success.

---

## Step 4: Run Queries and Verify Outputs
At the bottom of the SQL script, you will find a section labelled:
`-- 4. Sample Queries for Project Demonstration`

1. Highlight any single query (e.g., `SELECT * FROM Booking WHERE status = 'Confirmed';`).
2. Click the **Lightning Bolt with Cursor icon** ⚡ to execute just that specific block of code.
3. Ensure the results match logical expectations:
   - *Example:* The "total successful revenue" query should sum only those payments marked as "Successful", ignoring "Failed" ones.
   - *Example:* The JOIN query should cleanly display Rahul Sharma and the "Goa Beach Holiday" text in the same row.

## Troubleshooting
- **Error 1046: No database selected:** Ensure the very top lines `CREATE DATABASE...` and `USE Travel_Management_Miniproject_Collage;` actually executed successfully.
- **Foreign Key constraint failure:** Make sure tables are executed in order (Customer & Package FIRST, Booking SECOND, Payment LAST) as programmed in the original script.
