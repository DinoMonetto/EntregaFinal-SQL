CREATE VIEW ProductsWithCategory AS
SELECT p.product_id, p.name AS product_name, p.description, p.price, p.stock, c.name AS category_name
FROM Product p
JOIN ProductCategory c ON p.category_id = c.category_id;

CREATE VIEW OrdersWithDetails AS
SELECT o.order_id, o.order_date, o.status, c.first_name, c.last_name, od.product_id, od.quantity, od.price
FROM Orders o
JOIN Customer c ON o.customer_id = c.customer_id
JOIN OrderDetail od ON o.order_id = od.order_id;
