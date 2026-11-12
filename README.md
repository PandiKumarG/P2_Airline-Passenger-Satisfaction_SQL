# Airline Passenger Satisfaction Analysis using SQL

## 1. Project Overview

This project focuses on analyzing airline passenger data using PostgreSQL. The analysis explores passenger demographics, customer types, travel preferences, service quality ratings, and flight delay patterns.

The project uses practical business requirements to apply SQL fundamentals and intermediate-level concepts to real-world analytical scenarios.

## 2. Dataset Description

- **Dataset:** Airline Passenger Satisfaction
- **Source:** Kaggle
- **File Used:** `test.csv`
- **Total Records:** 25,976
- **Total Columns:** 19
- **Primary Key:** `ID`
- **Duplicate Records based on ID:** None
- **Missing Values:** 83 records in `Arrival Delay in Minutes`

The dataset contains passenger demographic information, travel details, service ratings, and flight delay information.

For detailed column descriptions and dataset observations, refer to `P2_Airline Passenger Satisfaction Analysis_Dataset.txt`.

## 3. Business Requirements and SQL Analysis

The project addresses the following seven business requirements:

**Q1. Passenger Travel Profile Analysis**

Analyze passenger distribution across customer types, travel categories, and travel classes. Calculate passenger counts, average age, flight distance, and flight delays.

**Q2. Service Quality Analysis by Travel Class**

Calculate and compare average passenger ratings across travel classes for the available airline services.

**Q3. Identifying Passengers with Above-Average Departure Delays**

Identify passengers whose departure delays exceed the average departure delay of their respective travel classes using correlated subqueries.

**Q4. Service Performance Analysis by Travel Class**

Calculate average service ratings, transform service-rating columns into rows, and rank travel classes independently for each service.

**Q5. Analysis of Flight Delay Patterns**

Classify passengers based on departure and arrival delay combinations and calculate the passenger count for each category.

**Q6. Class-wise Wi-Fi Service Target Achievement**

Compare actual average Wi-Fi service ratings against predefined targets for each travel class and classify target achievement.

**Q7. Identifying and Ranking High-Delay Travel Categories**

Identify travel category and class combinations with above-average arrival delays and rank them within each travel category.

## 4. SQL Concepts Applied

### SQL Fundamentals
- SELECT and WHERE
- Aggregate Functions (COUNT, AVG)
- GROUP BY and HAVING
- ORDER BY
- CASE WHEN
- NULL handling

### SQL Intermediate
- Single-row and Correlated Subqueries
- Common Table Expressions (CTEs)
- JOIN Operations (INNER JOIN)
- Set Operations (UNION, INTERSECT)
- Window Functions (DENSE_RANK)
- Conditional Filtering

## 5. Tools and Technologies

- **Database:** PostgreSQL
- **Database Management Tool:** pgAdmin 4
- **Version Control:** Git
- **Repository Hosting:** GitHub

## 6. Project Files

| File | Description |
|---|---|
| `project_2_Airline Passenger Satisfaction.sql` | SQL queries covering all seven business requirements and the supporting table creation. |
| `P2_Airline Passenger Satisfaction Analysis_Dataset.txt` | Dataset overview, column descriptions, and observations. |

## 7. Key Learning Outcomes

- Applied SQL fundamentals and intermediate concepts to practical business requirements.
- Practiced correlated subqueries, CTEs, and JOIN operations.
- Used window functions to rank service performance.
- Applied set operations to analyze passenger delay patterns.
- Worked with missing values and aggregate calculations in PostgreSQL.
