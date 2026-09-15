# 🍕 Pizza Sales Data Analysis using SQL Server

## 📌 Project Overview

This project analyzes pizza sales data using Microsoft SQL Server to answer a series of business-focused questions related to revenue, sales performance, customer ordering patterns, and product performance.

The project covers SQL queries ranging from basic aggregations to more advanced techniques involving multi-table joins, subqueries, CTEs, .

---

## 🎯 Project Objective

The main objective of this project is to use SQL to transform raw pizza sales data into meaningful business insights.

The analysis focuses on questions such as:

- Which pizza types generate the most revenue?
- Which pizzas are ordered the most?
- What percentage of total revenue does each pizza type contribute?
- What is the average number of pizzas ordered per day?
- Which pizza categories perform the best?
- How do orders vary throughout the day?

---

## 🗂️ Dataset

The dataset contains information about pizza orders, pizza products, pizza types, and order details.

The main tables used in the analysis are:

- `orders`
- `order_details`
- `pizzas`
- `pizza_types`

These tables are connected through keys such as `order_id`, `pizza_id`, and `pizza_type_id`.

The dataset is included in this repository as `Dataset.zip`.

---

## 🛠️ Tools & Technologies

- Microsoft SQL Server
- SQL
- SQL Server Management Studio (SSMS)

---

## 🧠 SQL Concepts Used

The project includes the following SQL concepts:

- SELECT
- WHERE
- ORDER BY
- GROUP BY
- Aggregate Functions
- JOINs
- Subqueries
- CTEs
- Sorting and Filtering
- Revenue Calculations
- Ranking and Comparative Analysis

---

## 📊 Analysis & Key Insights

### 💰 Revenue Analysis

The analysis identified the pizza types generating the highest revenue.

**Thai Chicken Pizza** generated the highest revenue overall:

**$43,434.25**

It contributed approximately **5.31% of total revenue**.

Barbecue Chicken Pizza and California Chicken Pizza were also among the top revenue-generating pizzas.

### 📦 Order & Quantity Analysis

The analysis also examined:

- Total pizzas sold
- Pizza quantities by category
- Most frequently ordered pizzas
- Average pizzas ordered per day

The average number of pizzas ordered per day was:

**138.47 pizzas**

### 🕐 Time-Based Analysis

Order data was analyzed by time of day to identify patterns in customer ordering behavior.

---

## 🔍 Key Learning

One of the biggest takeaways from this project was understanding how relational data connects across multiple tables.

Many business questions cannot be answered from a single table. Revenue, rankings, percentages, and product performance often require combining information from multiple related tables using JOINs.

This project helped strengthen my understanding of SQL, relational databases, data analysis, and problem-solving.

---

## 📁 Repository Contents

```text
Pizza-sales-sql
│
├── README.md
├── pizza_sales_analysis.sql
├── problems.txt
└── Dataset.zip
