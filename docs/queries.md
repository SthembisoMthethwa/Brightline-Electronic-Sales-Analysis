# SQL Queries — Brightline Electronics Sales Analysis

All 7 business questions, with the T-SQL used to answer each one. Full script (schema + data + queries) lives in [`sql/brightline_ecommerce.sql`](../sql/brightline_ecommerce.sql).

---

### 1. Total Revenue

```sql
SELECT SUM(Total_price) AS Total_Revenue
FROM Order_items;
```
Sums the `Total_price` column across every line item in `Order_items`, since that's where per-item revenue is stored.

---

### 2. Total Orders & Average Order Value

```sql
SELECT 
    COUNT(*) AS Total_Orders,
    AVG(Total_amount) AS Avg_Order_Value
FROM Orders;
```
`Orders` has one row per order, so `COUNT(*)` gives total orders directly, and `AVG(Total_amount)` gives the average order value.

---

### 3. Top-Selling Products by Revenue

```sql
SELECT TOP 3
    p.Product_name,
    SUM(oi.Total_price) AS Revenue
FROM Order_items oi
JOIN Products p ON oi.Product_id = p.Product_id
GROUP BY p.Product_name
ORDER BY Revenue DESC;
```
Joins `Order_items` to `Products` to bring in product names, groups by product, sums revenue per product, and returns the top 3 by revenue.

---

### 4. Top Customers by Revenue

```sql
SELECT 
    c.Customer_Name,
    SUM(oi.Total_price) AS Revenue
FROM Order_items oi
JOIN Orders o ON oi.Order_id = o.Order_id
JOIN Customer c ON o.Customer_id = c.Customer_id
GROUP BY c.Customer_Name
ORDER BY Revenue DESC;
```
Chains through `Order_items → Orders → Customer` (since `Order_items` doesn't know the customer directly, only the order does), groups by customer, and ranks by total revenue.

---

### 5. Revenue by Category

```sql
SELECT 
    p.Category,
    SUM(oi.Total_price) AS Revenue
FROM Order_items oi
JOIN Products p ON oi.Product_id = p.Product_id
GROUP BY p.Category
ORDER BY Revenue DESC;
```
Joins in product category, groups revenue by category instead of by individual product.

---

### 6. Monthly Revenue Trend

```sql
SELECT 
    FORMAT(Order_date, 'yyyy-MM') AS Month,
    SUM(Total_amount) AS Monthly_Revenue
FROM Orders
GROUP BY FORMAT(Order_date, 'yyyy-MM')
ORDER BY Month;
```
Converts each order's date into a `yyyy-MM` label, groups orders by month, and sums revenue — giving a month-over-month trend.

---

### 7. Customers Who Bought More Than Once (Repeat Customers)

```sql
SELECT 
    c.Customer_Name,
    COUNT(*) AS Order_Count,
    SUM(o.Total_amount) AS Total_Spent
FROM Orders o
JOIN Customer c ON o.Customer_id = c.Customer_id
GROUP BY c.Customer_Name
HAVING COUNT(*) > 1
ORDER BY Order_Count DESC;
```
Groups orders by customer, counts how many orders each placed, and uses `HAVING COUNT(*) > 1` to filter down to repeat buyers only — one row per customer, sorted by order frequency.

---

## Notes on Approach

- All monetary joins run through `Order_items`, since that's where line-item revenue (`Total_price`) actually lives — `Orders.Total_amount` is a stored order-level total, kept in sync with the sum of its line items.
- `IDENTITY` columns (`Customer_id`, `Product_id`, `Order_id`, `Order_item_id`) are never included in `INSERT` statements — SQL Server assigns them automatically.
- Foreign keys (`Orders.Customer_id`, `Order_items.Order_id`, `Order_items.Product_id`) enforce that every order/item always references a valid customer/order/product, preventing orphaned records.

