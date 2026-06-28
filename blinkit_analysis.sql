USE blinkit_db;

-- Q1 Total Revenue
SELECT ROUND(SUM(order_total), 2) AS total_revenue
FROM blinkit_orders;

-- Q2 Revenue by Category
SELECT p.category,
       ROUND(SUM(oi.quantity * oi.unit_price), 2) AS revenue
FROM blinkit_order_items oi
JOIN blinkit_products p ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY revenue DESC;

-- Q3 Top 10 Products by Revenue
SELECT p.product_name,
       p.category,
       ROUND(SUM(oi.quantity * oi.unit_price), 2) AS revenue
FROM blinkit_order_items oi
JOIN blinkit_products p ON oi.product_id = p.product_id
GROUP BY p.product_name, p.category
ORDER BY revenue DESC
LIMIT 10;

-- Q4 Delivery Status Breakdown
SELECT delivery_status,
       COUNT(*) AS total_orders,
       ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS percentage
FROM blinkit_orders
GROUP BY delivery_status
ORDER BY total_orders DESC;

-- Q6 Payment Method Analysis
SELECT payment_method,
       COUNT(*) AS total_orders,
       ROUND(AVG(order_total), 2) AS avg_order_value,
       ROUND(SUM(order_total), 2) AS total_revenue
FROM blinkit_orders
GROUP BY payment_method
ORDER BY total_revenue DESC;

-- Q7 Pareto Analysis
SELECT p.product_name,
       p.category,
       ROUND(SUM(oi.quantity * oi.unit_price), 2) AS product_revenue,
       ROUND(SUM(SUM(oi.quantity * oi.unit_price)) OVER 
       (ORDER BY SUM(oi.quantity * oi.unit_price) DESC) * 100.0 / 
       SUM(SUM(oi.quantity * oi.unit_price)) OVER(), 2) AS cumulative_percentage
FROM blinkit_order_items oi
JOIN blinkit_products p ON oi.product_id = p.product_id
GROUP BY p.product_name, p.category
ORDER BY product_revenue DESC;

-- Q8 Revenue and Margin by Category
SELECT p.category,
       ROUND(SUM(oi.quantity * oi.unit_price), 2) AS revenue,
       ROUND(AVG(p.margin_percentage), 2) AS avg_margin,
       ROUND(SUM(oi.quantity * oi.unit_price) * AVG(p.margin_percentage) / 100, 2) AS estimated_profit
FROM blinkit_order_items oi
JOIN blinkit_products p ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY estimated_profit DESC;

-- Q9 Monthly Revenue Trend
SELECT DATE_FORMAT(order_date, '%Y-%m') AS month,
       COUNT(*) AS total_orders,
       ROUND(SUM(order_total), 2) AS monthly_revenue
FROM blinkit_orders
GROUP BY month
ORDER BY month;

-- Q10 Rank Products Within Each Category
SELECT p.category,
       p.product_name,
       ROUND(SUM(oi.quantity * oi.unit_price), 2) AS revenue,
       RANK() OVER (PARTITION BY p.category 
                    ORDER BY SUM(oi.quantity * oi.unit_price) DESC) AS rank_in_category
FROM blinkit_order_items oi
JOIN blinkit_products p ON oi.product_id = p.product_id
GROUP BY p.category, p.product_name
ORDER BY p.category, rank_in_category;

-- customer segment analysis
SELECT customer_segment,
       COUNT(*) AS total_customers,
       ROUND(AVG(avg_order_value), 2) AS avg_order_value,
       ROUND(SUM(total_orders), 0) AS total_orders
FROM blinkit_customers
GROUP BY customer_segment
ORDER BY avg_order_value DESC;

-- top 10 areas by nummber of customers
SELECT area,
       COUNT(*) AS total_customers,
       ROUND(AVG(avg_order_value), 2) AS avg_order_value
FROM blinkit_customers
GROUP BY area
ORDER BY total_customers DESC
LIMIT 10;

-- window function on customer segments
SELECT customer_segment,
       COUNT(*) AS total_customers,
       ROUND(AVG(avg_order_value), 2) AS avg_order_value,
       ROUND(AVG(avg_order_value) * 100.0 / 
       SUM(AVG(avg_order_value)) OVER(), 2) AS pct_of_avg_value
FROM blinkit_customers
GROUP BY customer_segment
ORDER BY avg_order_value DESC;