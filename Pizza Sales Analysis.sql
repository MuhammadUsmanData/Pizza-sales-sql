USE [Dataset]
GO

/* ============================================================
   PIZZA SALES ANALYSIS
   TABLES: orders, order_details, pizzas, pizza_types
   ============================================================ */


/* ---------------------- BASIC ---------------------- */

-- Q1. Retrieve the total number of orders placed.

SELECT COUNT(*)
AS Total_orders
FROM orders;


-- Q2. Calculate the total revenue generated from pizza sales.

SELECT
    ROUND(SUM(Od.quantity * P.price), 2) AS Total_revenue
FROM order_details Od
JOIN pizzas P
    ON Od.pizza_id = P.pizza_id;


-- Q3. Identify the highest-priced pizza.

SELECT TOP 1
    Pt.name,
    P.size,
    P.price
FROM pizzas P
    JOIN pizza_types Pt
        ON P.pizza_type_id = Pt.pizza_type_id
ORDER BY P.price DESC;


-- Q4. Identify the most common pizza size ordered.

SELECT TOP 1
    P.Size,
    SUM(Od.quantity) AS Total_ordered
FROM order_details Od
    JOIN pizzas P
        ON Od.pizza_id = P.pizza_id
GROUP BY P.size
ORDER BY Total_ordered DESC;


-- Q5. List the top 5 most ordered pizza types along with their quantities.

SELECT TOP 5
    Pt.Name,
    SUM(Od.quantity) AS Total_quantity
FROM order_details Od
    JOIN pizzas P
        ON Od.pizza_id = P.pizza_id
    JOIN pizza_types Pt
        ON P.pizza_type_id = Pt.pizza_type_id
GROUP BY Pt.name
ORDER BY Total_quantity DESC;


/* ---------------------- INTERMEDIATE ---------------------- */

-- Q6. Join the necessary tables to find the total quantity of each pizza category ordered.

SELECT
    Pt.category,
    SUM(Od.quantity) AS Total_quantity
FROM order_details Od
    JOIN pizzas P
        ON Od.pizza_id = P.pizza_id
    JOIN pizza_types Pt
        ON P.pizza_type_id = Pt.pizza_type_id
GROUP BY Pt.category
ORDER BY Total_quantity DESC;


-- Q7. Determine the distribution of orders by hour of the day.

SELECT
    DATEPART(HOUR, O.time) AS Order_hour,
    COUNT(DISTINCT O.order_id) AS Total_orders
FROM orders O
GROUP BY DATEPART(HOUR, O.time)
ORDER BY Order_hour;


-- Q8. Join relevant tables to find the category-wise distribution of pizzas.

SELECT
    Pt.category,
    COUNT(DISTINCT P.pizza_id) AS Pizza_count
FROM pizzas P
    JOIN pizza_types Pt
        ON P.pizza_type_id = Pt.pizza_type_id
GROUP BY Pt.category
ORDER BY Pizza_count DESC;


-- Q9. Group the orders by date and calculate the average number of pizzas ordered per day.

WITH Daily_totals AS (
    SELECT O.date, SUM(Od.quantity) AS Pizzas_per_day
    FROM orders O
    JOIN order_details Od ON O.order_id = Od.order_id
    GROUP BY O.date
)
SELECT ROUND(AVG(Pizzas_per_day * 1.0), 2) AS Avg_pizzas_per_day
FROM Daily_totals;


-- Q10. Determine the top 3 most ordered pizza types based on revenue.

SELECT TOP 3
    Pt.name,
    ROUND(SUM(Od.quantity * P.price), 2) AS Revenue
FROM order_details Od
    JOIN pizzas P
        ON Od.pizza_id = P.pizza_id
    JOIN pizza_types Pt
        ON P.pizza_type_id = Pt.pizza_type_id
GROUP BY Pt.name
ORDER BY Revenue DESC;


/* ---------------------- ADVANCED ---------------------- */

-- Q11. Calculate the percentage contribution of each pizza type to total revenue.

SELECT
    Pt.name,
    ROUND(SUM(Od.quantity * P.price), 2) AS Revenue,
    ROUND(
        SUM(Od.quantity * P.price) * 100.0
        / (SELECT SUM(Od2.quantity * P2.price)
           FROM order_details Od2
           JOIN pizzas P2 ON Od2.pizza_id = P2.pizza_id), 2
    ) AS Pct_of_total_revenue
FROM order_details Od
    JOIN pizzas P
        ON Od.pizza_id = P.pizza_id
    JOIN pizza_types Pt
        ON P.pizza_type_id = Pt.pizza_type_id
GROUP BY Pt.name
ORDER BY Pct_of_total_revenue DESC;


-- Q12. Analyze the cumulative revenue generated over time.

WITH Daily_revenue AS (
    SELECT O.date, SUM(Od.quantity * P.price) AS Revenue
    FROM orders O
        JOIN order_details Od
            ON O.order_id = Od.order_id
        JOIN pizzas P
            ON Od.pizza_id = P.pizza_id
    GROUP BY O.date
)
SELECT
    date,
    Revenue,
    SUM(Revenue) OVER (ORDER BY date) AS Cumulative_revenue
FROM Daily_revenue
ORDER BY date;


-- Q13. Determine the top 3 most ordered pizza types based on revenue for each pizza category.

WITH Category_revenue AS (
    SELECT
        Pt.category,
        Pt.name,
        SUM(Od.quantity * P.price) AS Revenue,
        RANK() OVER (PARTITION BY Pt.category ORDER BY SUM(Od.quantity * P.price) DESC) AS Rnk
    FROM order_details Od
        JOIN pizzas P
            ON Od.pizza_id = P.pizza_id
        JOIN pizza_types Pt
            ON P.pizza_type_id = Pt.pizza_type_id
    GROUP BY Pt.category, Pt.name
)
SELECT category, name, ROUND(Revenue, 2) AS Revenue
FROM Category_revenue
WHERE Rnk <= 3
ORDER BY category, Rnk;