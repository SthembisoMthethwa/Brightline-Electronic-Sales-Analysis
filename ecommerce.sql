/*
Business Problem
Brightline Electronics is a mid-sized e-commerce company selling laptops, mobiles, headphones, and other electronic devices across major South African cities. Leadership doesn't have a clear picture of how the business is actually performing — they can see sales are happening, but not which products or customers are driving revenue, whether growth is steady or seasonal, or where the biggest opportunities are.
As the data analyst, you've been asked to build a database from the raw sales records and answer the following using SQL:
1.Total Revenue?
2.Total orders and Average order value?
3.Top-Selling products by revenue?
4.Top customers by revenue?
5.Revenue by category?
6.Monthly Revenue trend
7.Customers who bought more than once
The goal: turn raw transactional data into answers leadership can act on.
*/
CREATE DATABASE Ecommerce_Sales_Analysis;

USE Ecommerce_Sales_Analysis;

CREATE table Customer(
Customer_id INT IDENTITY(1,1) PRIMARY KEY,
Customer_Name VARCHAR(100) NOT NULL,
City VARCHAR(100),
Province VARCHAR(50)
);

Create table Products(
Product_id INT IDENTITY(100,1) PRIMARY KEY,
Product_name VARCHAR(100),
Category VARCHAR(50) CHECK ( Category IN ('Electronics', 'Furniture', 'Accessories')),
Price DECIMAL(10,2)
);


Create table Orders(
Order_id INT IDENTITY (100,1) PRIMARY KEY,
Customer_id INT NOT NULL,
Order_date DATE NOT NULL,
Total_amount DECIMAL(14,2)
FOREIGN KEY (Customer_id) REFERENCES  Customer(Customer_id)
);

CREATE table Order_items (
Order_item_id INT IDENTITY(1,1) PRIMARY KEY,
Order_id INT NOT NULL,
Product_id INT NOT NULL,
Quantity INT NOT NULL,
Price DECIMAL(10,2) NOT NULL,
Total_price DECIMAL(12,2),
FOREIGN KEY (Order_id) REFERENCES Orders(Order_id),
FOREIGN KEY (Product_id) REFERENCES Products(Product_id)
);

--inserting data

-- Customer
INSERT INTO Customer (Customer_Name, City, Province) VALUES
('Thabo Mokoena', 'Johannesburg', 'Gauteng'),
('Aisha Patel', 'Durban', 'KwaZulu-Natal'),
('Johan van der Merwe', 'Cape Town', 'Western Cape'),
('Nomvula Dlamini', 'Pretoria', 'Gauteng'),
('Sipho Nkosi', 'Durban', 'KwaZulu-Natal'),
('Lerato Mahlangu', 'Bloemfontein', 'Free State'),
('Pieter Botha', 'Port Elizabeth', 'Eastern Cape'),
('Zanele Khumalo', 'Polokwane', 'Limpopo'),
('Ryan Naidoo', 'Cape Town', 'Western Cape'),
('Kagiso Sithole', 'East London', 'Eastern Cape'),
('Naledi Molefe', 'Kimberley', 'Northern Cape'),
('Farah Adams', 'Cape Town', 'Western Cape'),
('Bongani Zulu', 'Durban', 'KwaZulu-Natal'),
('Chantelle Fischer', 'Johannesburg', 'Gauteng'),
('Tumi Radebe', 'Pretoria', 'Gauteng');
SELECT * FROM Customer;
-- Products
INSERT INTO Products (Product_name, Category, Price) VALUES
('Laptop Pro 15"', 'Electronics', 18999.00),
('Smartphone X', 'Electronics', 12499.00),
('Wireless Headphones', 'Accessories', 1299.00),
('Office Chair', 'Furniture', 2499.00),
('Standing Desk', 'Furniture', 4999.00),
('Wireless Mouse', 'Accessories', 499.00),
('Gaming Monitor', 'Electronics', 6999.00),
('Bookshelf', 'Furniture', 3299.00),
('USB-C Charger', 'Accessories', 349.00),
('4K Webcam', 'Electronics', 1899.00),
('Mechanical Keyboard', 'Accessories', 1199.00),
('Bookcase Unit', 'Furniture', 3799.00),
('Tablet 10"', 'Electronics', 8999.00),
('Filing Cabinet', 'Furniture', 2199.00);
SELECT * FROM Products;
-- Orders
INSERT INTO Orders (Customer_id, Order_date, Total_amount) VALUES
(1, '2026-01-05', 18999.00),
(2, '2026-01-12', 13798.00),
(3, '2026-02-03', 2499.00),
(1, '2026-02-20', 1299.00),
(4, '2026-03-01', 4999.00),
(2, '2026-03-15', 12499.00),
(6, '2026-04-02', 3299.00),
(7, '2026-04-10', 6999.00),
(3, '2026-04-15', 499.00),
(8, '2026-05-01', 12998.00),
(6, '2026-05-08', 499.00),
(9, '2026-05-20', 18999.00),
(11, '2026-02-01', 4698.00),
(11, '2026-02-19', 21198.00),
(4, '2026-01-18', 7598.00),
(4, '2026-08-19', 46997.00),
(6, '2026-05-05', 8999.00),
(2, '2026-02-13', 499.00),
(10, '2026-05-26', 7598.00),
(9, '2026-02-13', 349.00),
(14, '2026-06-19', 3799.00),
(1, '2026-04-25', 17497.00),
(5, '2026-08-21', 1798.00),
(11, '2026-05-23', 1899.00),
(9, '2026-04-06', 11998.00),
(14, '2026-01-08', 8999.00),
(7, '2026-05-03', 1899.00),
(4, '2026-08-13', 6298.00),
(12, '2026-05-24', 11097.00),
(9, '2026-08-03', 2199.00),
(3, '2026-03-26', 28796.00),
(10, '2026-08-17', 19348.00),
(13, '2026-06-04', 15297.00),
(12, '2026-05-17', 349.00),
(14, '2026-05-27', 5697.00),
(10, '2026-06-16', 12499.00),
(15, '2026-05-08', 2499.00),
(2, '2026-08-27', 8999.00),
(3, '2026-08-18', 9998.00),
(4, '2026-04-23', 9397.00),
(15, '2026-08-04', 2499.00),
(6, '2026-01-19', 6597.00),
(4, '2026-02-02', 12848.00),
(11, '2026-08-07', 10195.00),
(13, '2026-07-07', 24998.00),
(6, '2026-07-14', 5998.00),
(1, '2026-07-24', 21498.00),
(4, '2026-08-05', 7597.00),
(14, '2026-02-15', 32697.00),
(3, '2026-07-16', 9498.00),
(7, '2026-01-13', 20197.00),
(7, '2026-08-05', 4999.00);
SELECT * FROM Orders;

--Order_items
INSERT INTO Order_items (Order_id, Product_id, Quantity, Price, Total_price) VALUES
(100, 100, 1, 18999.00, 18999.00),
(101, 101, 1, 12499.00, 12499.00),
(101, 102, 1, 1299.00, 1299.00),
(102, 103, 1, 2499.00, 2499.00),
(103, 102, 1, 1299.00, 1299.00),
(104, 104, 1, 4999.00, 4999.00),
(105, 101, 1, 12499.00, 12499.00),
(106, 107, 1, 3299.00, 3299.00),   -- Lerato bought Bookshelf
(107, 106, 1, 6999.00, 6999.00),   -- Pieter bought Gaming Monitor
(108, 105, 1, 499.00, 499.00),     -- Johan bought Wireless Mouse
(109, 101, 1, 12499.00, 12499.00), -- Ryan/Zanele's order: Smartphone X
(109, 105, 1, 499.00, 499.00),     -- same order: Wireless Mouse
(110, 105, 1, 499.00, 499.00),     -- Lerato's 2nd order: Wireless Mouse
(111, 100, 1, 18999.00, 18999.00), -- Zanele bought Laptop Pro
(112, 103, 1, 2499.00, 2499.00),
(112, 113, 1, 2199.00, 2199.00),
(113, 100, 1, 18999.00, 18999.00),
(113, 113, 1, 2199.00, 2199.00),
(114, 111, 2, 3799.00, 7598.00),
(115, 112, 1, 8999.00, 8999.00),
(115, 100, 2, 18999.00, 37998.00),
(116, 112, 1, 8999.00, 8999.00),
(117, 105, 1, 499.00, 499.00),
(118, 111, 2, 3799.00, 7598.00),
(119, 108, 1, 349.00, 349.00),
(120, 111, 1, 3799.00, 3799.00),
(121, 101, 1, 12499.00, 12499.00),
(121, 103, 2, 2499.00, 4998.00),
(122, 102, 1, 1299.00, 1299.00),
(122, 105, 1, 499.00, 499.00),
(123, 109, 1, 1899.00, 1899.00),
(124, 106, 1, 6999.00, 6999.00),
(124, 104, 1, 4999.00, 4999.00),
(125, 112, 1, 8999.00, 8999.00),
(126, 109, 1, 1899.00, 1899.00),
(127, 102, 1, 1299.00, 1299.00),
(127, 104, 1, 4999.00, 4999.00),
(128, 106, 1, 6999.00, 6999.00),
(128, 109, 1, 1899.00, 1899.00),
(128, 113, 1, 2199.00, 2199.00),
(129, 113, 1, 2199.00, 2199.00),
(130, 109, 2, 1899.00, 3798.00),
(130, 101, 2, 12499.00, 24998.00),
(131, 108, 1, 349.00, 349.00),
(131, 100, 1, 18999.00, 18999.00),
(132, 106, 2, 6999.00, 13998.00),
(132, 102, 1, 1299.00, 1299.00),
(133, 108, 1, 349.00, 349.00),
(134, 109, 1, 1899.00, 1899.00),
(134, 103, 1, 2499.00, 2499.00),
(134, 102, 1, 1299.00, 1299.00),
(135, 101, 1, 12499.00, 12499.00),
(136, 103, 1, 2499.00, 2499.00),
(137, 112, 1, 8999.00, 8999.00),
(138, 104, 2, 4999.00, 9998.00),
(139, 106, 1, 6999.00, 6999.00),
(139, 110, 2, 1199.00, 2398.00),
(140, 103, 1, 2499.00, 2499.00),
(141, 103, 1, 2499.00, 2499.00),
(141, 109, 1, 1899.00, 1899.00),
(141, 113, 1, 2199.00, 2199.00),
(142, 101, 1, 12499.00, 12499.00),
(142, 108, 1, 349.00, 349.00),
(143, 102, 2, 1299.00, 2598.00),
(143, 111, 1, 3799.00, 3799.00),
(143, 109, 2, 1899.00, 3798.00),
(144, 101, 2, 12499.00, 24998.00),
(145, 113, 1, 2199.00, 2199.00),
(145, 111, 1, 3799.00, 3799.00),
(146, 112, 1, 8999.00, 8999.00),
(146, 101, 1, 12499.00, 12499.00),
(147, 102, 2, 1299.00, 2598.00),
(147, 104, 1, 4999.00, 4999.00),
(148, 101, 1, 12499.00, 12499.00),
(148, 100, 1, 18999.00, 18999.00),
(148, 110, 1, 1199.00, 1199.00),
(149, 103, 1, 2499.00, 2499.00),
(149, 106, 1, 6999.00, 6999.00),
(150, 112, 2, 8999.00, 17998.00),
(150, 113, 1, 2199.00, 2199.00),
(151, 104, 1, 4999.00, 4999.00);
SELECT * FROM Order_items;

--Verification that everything is linked using join operator
SELECT
o.Order_id,  -- Order number (from Orders table)
c.Customer_Name, --Name of the customer who placed the Order
p.Product_name, -- Name of the product purchased
oi.Quantity, -- Number of products ordered
oi.Price,    --  Price per item ordered
oi.Total_price,  --Quantinty * Price
o.Order_date     -- Date order was placed

FROM Order_items oi                                --Start from Order_items
JOIN Orders o ON oi.Order_id = o.Order_id          --link each item back to its parent order
JOIN Customer c ON o.Customer_id = c.Customer_id   --Link Order to Customer who Ordered it 
JOIN Products p ON oi.Product_id = p.Product_id    --Link the item to the product it is refered to
ORDER BY o.Order_id;                               --Sorts the results by order number for its readability


--1.Total Revenue?
SELECT SUM (Total_price) AS Total_Revenue  --Add up Total_price for all prices
FROM Order_items;                          --Order_items holds all the all the prices for all items

--2.Total number of orders and Average order value?
SELECT 
COUNT(*) AS Total_Orders,               --Count every row = count every order
AVG(Total_amount) AS Avg_Order_Value    --Average of each order's total amount 
FROM Orders;                            --Orders table has one row per order

--3.Top-Selling products by revenue?
SELECT TOP 3
p.Product_name,                                  --Product name from Products table
SUM(oi.Total_price) AS Revenue                   --Sum all line-item revenue for this product
FROM Order_items oi                              --Start from Order_items
JOIN Products p ON oi.Product_id = p.Product_id  --Link item to its products name
GROUP BY p.Product_name                          --Group rows so SUM totals per product
ORDER BY REVENUE DESC;                           --Show highest-revenue products first

--4.Top customers by revenue?
SELECT 
c.Customer_Name,                                   --Customer name (from Customer table)
SUM(oi.Total_price) AS Revenue                     --Sum all their purchases
FROM Order_items oi                                --Start from Order_items (Revenue is on Order_items)
JOIN Orders o ON oi.Order_id = o.Order_id          --Link item to its order
JOIN Customer c ON o.Customer_id = c.Customer_id   --Link order to customer who placed it
GROUP BY c.Customer_Name                           --Group by per Customer
ORDER BY Revenue DESC;                             --Show highest spending customers first

--5.Revenue by category?
SELECT 
 p.Category,                                        --Product category (from Products table)
 SUM(oi.Total_price) AS Revenue                    --Sum revenue of all items in the category
 FROM Order_items oi                               --start from Order_items
 JOIN Products p ON oi.Product_id = p.Product_id   --Link each item to its product/category
 GROUP BY p.Category                               --Group Sum totals per category
 ORDER BY Revenue DESC;                            -- Show highest-earning categories first

 --6.Monthly Revenue trend
 SELECT 
 FORMAT(Order_date, 'yyyy-MM') AS Month,           ---Convert date to a "Year-Month" label
 SUM(Total_amount) AS Monthly_Revenue              ---SUM order totals within that month
 FROM Orders                                       ---Orders has order_date and Total_amount
 GROUP BY FORMAT(Order_date, 'yyyy-MM')            ---Group rows by month
 ORDER BY MONTH;                                   ---Show months in chronological order

 --7.Customers who bought more than once
 SELECT 
c.Customer_Name,                                 --- Name of the repeat buyer
p.Product_name,                                  ---Product the bought
SUM(oi.Quantity) AS Total_Quantity,               ---Combine quantities in matching rows
SUM(oi.Total_price) AS Amount_spent               ---Combine the Amount they spent
 FROM order_items oi                              ---Start from Order_items
 JOIN Orders o ON oi.Order_id = o.Order_id        ---link item to its order
 JOIN Customer c ON o.Customer_id = c.Customer_id ---Link order to customer
Join Products p ON oi.Product_id = p.Product_id  --Link item to the product name
WHERE o.Customer_id IN (                          ---Only keep customers who qualify as repeat buyers               
       SELECT Customer_id                        ---Look at each customer's orders
	   FROM Orders                               ---Orders table has one row per order
	   GROUP BY Customer_id                       ---Group rows by customer
	   HAVING COUNT(*) > 2                       ---Repeat buyer = more than 1 order
)
GROUP BY c.Customer_Name, p.Product_name        --Merge rows with same customer + product
ORDER BY c.Customer_Name, p.Product_name;        ---Group by Customer, then product

 
 SELECT @@SERVERNAME;


SELECT 
    c.Customer_Name,                     -- Customer name
    COUNT(*) AS Order_Count,             -- How many separate orders this customer placed
    SUM(o.Total_amount) AS Total_Spent   -- Total money spent across all their orders
FROM Orders o                            -- Start from Orders (one row per order)
JOIN Customer c ON o.Customer_id = c.Customer_id  -- Link order to customer
GROUP BY c.Customer_Name                 -- One row per customer
HAVING COUNT(*) > 1                      -- Only keep repeat buyers (more than 1 order)
ORDER BY Order_Count DESC;               -- Highest order count first
