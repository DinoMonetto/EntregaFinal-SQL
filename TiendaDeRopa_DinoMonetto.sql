-- Dropeo por las dudas que exista una base con el mismo nombre
DROP DATABASE IF EXISTS TiendaRopa;

-- Crear base de datos
CREATE DATABASE TiendaRopa;

-- Usar base de datos
USE TiendaRopa;

-- Tabla: Categoría de Producto
CREATE TABLE ProductCategory (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);
-- Tabla: Producto
CREATE TABLE Product (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    stock INT NOT NULL,
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES ProductCategory(category_id)
);

-- Tabla: Cliente
CREATE TABLE Customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    phone VARCHAR(20)
);

-- Tabla: Dirección del Cliente
CREATE TABLE CustomerAddress (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    address VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL,
    postal_code VARCHAR(20) NOT NULL,
    country VARCHAR(100) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

-- Tabla: Pedido
CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATETIME NOT NULL,
    status VARCHAR(50) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

-- Tabla: Detalle del Pedido
CREATE TABLE OrderDetail (
    order_detail_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

-- Tabla: Método de Pago
CREATE TABLE PaymentMethod (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    method VARCHAR(255) NOT NULL
);

-- Tabla: Envío
CREATE TABLE Shipping (
    shipping_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    shipping_date DATETIME NOT NULL,
    delivery_date DATETIME NOT NULL,
    carrier VARCHAR(255) NOT NULL,
    tracking_number VARCHAR(255) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

-- Tabla: Descuentos y Promociones
CREATE TABLE Discount (
    discount_id INT AUTO_INCREMENT PRIMARY KEY,
    code VARCHAR(50) NOT NULL,
    description VARCHAR(255),
    discount_percentage DECIMAL(5, 2) NOT NULL,
    start_date DATETIME NOT NULL,
    end_date DATETIME NOT NULL
);

-- Tabla: Reseñas de Productos
CREATE TABLE ProductReview (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    customer_id INT,
    rating INT NOT NULL,
    review TEXT,
    review_date DATETIME NOT NULL,
    FOREIGN KEY (product_id) REFERENCES Product(product_id),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

-- Tabla: Inventario
CREATE TABLE Inventory (
    inventory_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    quantity INT NOT NULL,
    last_update DATETIME NOT NULL,
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

-- Tabla: Lista de deseos (para futuras compras)
CREATE TABLE Wishlist (
    wishlist_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    date_added DATETIME NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

-- Tabla: Pago (detalles de pagos)
CREATE TABLE Payment (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    payment_method_id INT,
    payment_date DATETIME NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (payment_method_id) REFERENCES PaymentMethod(payment_id)
);

-- Tabla: Proveedores
CREATE TABLE Supplier (
    supplier_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    contact_name VARCHAR(255),
    phone VARCHAR(20),
    email VARCHAR(255),
    address VARCHAR(255),
    city VARCHAR(100),
    country VARCHAR(100)
);

-- Tabla: Productos-Proveedor 
CREATE TABLE ProductSupplier (
    product_supplier_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    supplier_id INT,
    supply_price DECIMAL(10, 2) NOT NULL,
    supply_date DATETIME NOT NULL,
    FOREIGN KEY (product_id) REFERENCES Product(product_id),
    FOREIGN KEY (supplier_id) REFERENCES Supplier(supplier_id)
);

-- Script de Inserción de Datos

-- Insertar datos en ProductCategory
INSERT INTO ProductCategory (name) VALUES ('Electronics');
INSERT INTO ProductCategory (name) VALUES ('Clothing');
INSERT INTO ProductCategory (name) VALUES ('Home Appliances');
INSERT INTO ProductCategory (name) VALUES ('Books');
INSERT INTO ProductCategory (name) VALUES ('Sports');
INSERT INTO ProductCategory (name) VALUES ('Toys');
INSERT INTO ProductCategory (name) VALUES ('Beauty');
INSERT INTO ProductCategory (name) VALUES ('Automotive');
INSERT INTO ProductCategory (name) VALUES ('Furniture');
INSERT INTO ProductCategory (name) VALUES ('Jewelry');
INSERT INTO ProductCategory (name) VALUES ('Grocery');
INSERT INTO ProductCategory (name) VALUES ('Health');
INSERT INTO ProductCategory (name) VALUES ('Office Supplies');
INSERT INTO ProductCategory (name) VALUES ('Music');
INSERT INTO ProductCategory (name) VALUES ('Video Games');
INSERT INTO ProductCategory (name) VALUES ('Pet Supplies');
INSERT INTO ProductCategory (name) VALUES ('Garden');
INSERT INTO ProductCategory (name) VALUES ('Shoes');
INSERT INTO ProductCategory (name) VALUES ('Kitchen');
INSERT INTO ProductCategory (name) VALUES ('Stationery');


-- Insertar datos en Product
INSERT INTO Product (name, description, price, stock, category_id) VALUES ('Smartphone', 'Latest model with high-resolution camera', 699.99, 50, 1);
INSERT INTO Product (name, description, price, stock, category_id) VALUES ('Laptop', 'Powerful laptop for gaming and work', 1299.99, 30, 1);
INSERT INTO Product (name, description, price, stock, category_id) VALUES ('T-Shirt', 'Comfortable cotton t-shirt', 19.99, 100, 2);
INSERT INTO Product (name, description, price, stock, category_id) VALUES ('Blender', 'High-speed kitchen blender', 89.99, 20, 3);
INSERT INTO Product (name, description, price, stock, category_id) VALUES ('Novel', 'Bestselling novel of the year', 14.99, 150, 4);
INSERT INTO Product (name, description, price, stock, category_id) VALUES ('Yoga Mat', 'Non-slip yoga mat', 25.99, 60, 5);
INSERT INTO Product (name, description, price, stock, category_id) VALUES ('Stuffed Animal', 'Cute and soft stuffed animal', 12.99, 80, 6);
INSERT INTO Product (name, description, price, stock, category_id) VALUES ('Lipstick', 'Long-lasting lipstick', 21.99, 70, 7);
INSERT INTO Product (name, description, price, stock, category_id) VALUES ('Car Battery', 'High-performance car battery', 119.99, 25, 8);
INSERT INTO Product (name, description, price, stock, category_id) VALUES ('Sofa', 'Comfortable 3-seater sofa', 499.99, 10, 9);
INSERT INTO Product (name, description, price, stock, category_id) VALUES ('Necklace', 'Elegant diamond necklace', 299.99, 15, 10);
INSERT INTO Product (name, description, price, stock, category_id) VALUES ('Cereal', 'Healthy breakfast cereal', 5.99, 200, 11);
INSERT INTO Product (name, description, price, stock, category_id) VALUES ('Vitamins', 'Daily multivitamins', 29.99, 90, 12);
INSERT INTO Product (name, description, price, stock, category_id) VALUES ('Pen', 'High-quality ballpoint pen', 2.99, 500, 13);
INSERT INTO Product (name, description, price, stock, category_id) VALUES ('CD Album', 'Latest music album', 14.99, 40, 14);
INSERT INTO Product (name, description, price, stock, category_id) VALUES ('Game Console', 'Next-gen gaming console', 499.99, 20, 15);
INSERT INTO Product (name, description, price, stock, category_id) VALUES ('Dog Food', 'Nutritional dog food', 34.99, 60, 16);
INSERT INTO Product (name, description, price, stock, category_id) VALUES ('Garden Hose', 'Durable garden hose', 45.99, 35, 17);
INSERT INTO Product (name, description, price, stock, category_id) VALUES ('Running Shoes', 'Comfortable running shoes', 69.99, 80, 18);
INSERT INTO Product (name, description, price, stock, category_id) VALUES ('Cooking Pan', 'Non-stick cooking pan', 39.99, 40, 19);
INSERT INTO Product (name, description, price, stock, category_id) VALUES ('Notebook', 'Spiral-bound notebook', 7.99, 150, 20);


-- Insertar datos en Customer
INSERT INTO Customer (first_name, last_name, email, phone) VALUES ('John', 'Doe', 'john.doe@example.com', '555-1234');
INSERT INTO Customer (first_name, last_name, email, phone) VALUES ('Jane', 'Smith', 'jane.smith@example.com', '555-5678');
INSERT INTO Customer (first_name, last_name, email, phone) VALUES ('Emily', 'Jones', 'emily.jones@example.com', '555-8765');
INSERT INTO Customer (first_name, last_name, email, phone) VALUES ('Michael', 'Brown', 'michael.brown@example.com', '555-4321');
INSERT INTO Customer (first_name, last_name, email, phone) VALUES ('Sarah', 'Davis', 'sarah.davis@example.com', '555-6789');
INSERT INTO Customer (first_name, last_name, email, phone) VALUES ('David', 'Wilson', 'david.wilson@example.com', '555-3456');
INSERT INTO Customer (first_name, last_name, email, phone) VALUES ('Olivia', 'Miller', 'olivia.miller@example.com', '555-9876');
INSERT INTO Customer (first_name, last_name, email, phone) VALUES ('Daniel', 'Taylor', 'daniel.taylor@example.com', '555-6543');
INSERT INTO Customer (first_name, last_name, email, phone) VALUES ('Sophia', 'Anderson', 'sophia.anderson@example.com', '555-3210');
INSERT INTO Customer (first_name, last_name, email, phone) VALUES ('James', 'Thomas', 'james.thomas@example.com', '555-7890');
INSERT INTO Customer (first_name, last_name, email, phone) VALUES ('Ava', 'Jackson', 'ava.jackson@example.com', '555-1122');
INSERT INTO Customer (first_name, last_name, email, phone) VALUES ('Benjamin', 'White', 'benjamin.white@example.com', '555-3344');
INSERT INTO Customer (first_name, last_name, email, phone) VALUES ('Mia', 'Harris', 'mia.harris@example.com', '555-5566');
INSERT INTO Customer (first_name, last_name, email, phone) VALUES ('Lucas', 'Martin', 'lucas.martin@example.com', '555-7788');
INSERT INTO Customer (first_name, last_name, email, phone) VALUES ('Charlotte', 'Thompson', 'charlotte.thompson@example.com', '555-9900');
INSERT INTO Customer (first_name, last_name, email, phone) VALUES ('Henry', 'Garcia', 'henry.garcia@example.com', '555-1230');
INSERT INTO Customer (first_name, last_name, email, phone) VALUES ('Amelia', 'Martinez', 'amelia.martinez@example.com', '555-4567');
INSERT INTO Customer (first_name, last_name, email, phone) VALUES ('Alexander', 'Rodriguez', 'alexander.rodriguez@example.com', '555-7891');
INSERT INTO Customer (first_name, last_name, email, phone) VALUES ('Ella', 'Lee', 'ella.lee@example.com', '555-2345');


-- Insertar datos en CustomerAddress
INSERT INTO CustomerAddress (customer_id, address, city, postal_code, country) VALUES (1, '123 Elm Street', 'Springfield', '62701', 'USA');
INSERT INTO CustomerAddress (customer_id, address, city, postal_code, country) VALUES (2, '456 Oak Avenue', 'Riverside', '92501', 'USA');
INSERT INTO CustomerAddress (customer_id, address, city, postal_code, country) VALUES (3, '789 Maple Road', 'Lakeside', '60030', 'USA');
INSERT INTO CustomerAddress (customer_id, address, city, postal_code, country) VALUES (4, '101 Pine Street', 'Downtown', '30301', 'USA');
INSERT INTO CustomerAddress (customer_id, address, city, postal_code, country) VALUES (5, '202 Birch Lane', 'Midtown', '75201', 'USA');
INSERT INTO CustomerAddress (customer_id, address, city, postal_code, country) VALUES (6, '303 Cedar Drive', 'Uptown', '60601', 'USA');
INSERT INTO CustomerAddress (customer_id, address, city, postal_code, country) VALUES (7, '404 Spruce Court', 'Suburbia', '94101', 'USA');
INSERT INTO CustomerAddress (customer_id, address, city, postal_code, country) VALUES (8, '505 Fir Street', 'Hillside', '48001', 'USA');
INSERT INTO CustomerAddress (customer_id, address, city, postal_code, country) VALUES (9, '606 Redwood Way', 'City Center', '10001', 'USA');
INSERT INTO CustomerAddress (customer_id, address, city, postal_code, country) VALUES (10, '707 Sequoia Avenue', 'West End', '90210', 'USA');
INSERT INTO CustomerAddress (customer_id, address, city, postal_code, country) VALUES (11, '808 Elmwood Boulevard', 'Northside', '73101', 'USA');
INSERT INTO CustomerAddress (customer_id, address, city, postal_code, country) VALUES (12, '909 Willow Drive', 'Southside', '84001', 'USA');
INSERT INTO CustomerAddress (customer_id, address, city, postal_code, country) VALUES (13, '1010 Maplewood Lane', 'Eastside', '92001', 'USA');
INSERT INTO CustomerAddress (customer_id, address, city, postal_code, country) VALUES (14, '1111 Oakwood Road', 'Westfield', '30310', 'USA');
INSERT INTO CustomerAddress (customer_id, address, city, postal_code, country) VALUES (15, '1212 Pinewood Street', 'Bay Area', '94001', 'USA');
INSERT INTO CustomerAddress (customer_id, address, city, postal_code, country) VALUES (16, '1313 Birchwood Court', 'River City', '73120', 'USA');
INSERT INTO CustomerAddress (customer_id, address, city, postal_code, country) VALUES (17, '1414 Cedarwood Lane', 'Greenfield', '92010', 'USA');
INSERT INTO CustomerAddress (customer_id, address, city, postal_code, country) VALUES (18, '1515 Firwood Boulevard', 'Sunnyvale', '60010', 'USA');
INSERT INTO CustomerAddress (customer_id, address, city, postal_code, country) VALUES (19, '1616 Redwood Lane', 'Mapleton', '84010', 'USA');
INSERT INTO CustomerAddress (customer_id, address, city, postal_code, country) VALUES (20, '1717 Sequoia Road', 'Pleasantville', '30320', 'USA');


-- Insertar datos en Orders
INSERT INTO Orders (customer_id, order_date, status) VALUES (1, '2024-08-01 10:00:00', 'Processing');
INSERT INTO Orders (customer_id, order_date, status) VALUES (2, '2024-08-02 11:30:00', 'Shipped');
INSERT INTO Orders (customer_id, order_date, status) VALUES (3, '2024-08-03 12:45:00', 'Delivered');
INSERT INTO Orders (customer_id, order_date, status) VALUES (4, '2024-08-04 13:00:00', 'Cancelled');
INSERT INTO Orders (customer_id, order_date, status) VALUES (5, '2024-08-05 14:15:00', 'Processing');
INSERT INTO Orders (customer_id, order_date, status) VALUES (6, '2024-08-06 15:30:00', 'Shipped');
INSERT INTO Orders (customer_id, order_date, status) VALUES (7, '2024-08-07 16:45:00', 'Delivered');
INSERT INTO Orders (customer_id, order_date, status) VALUES (8, '2024-08-08 17:00:00', 'Processing');
INSERT INTO Orders (customer_id, order_date, status) VALUES (9, '2024-08-09 18:15:00', 'Cancelled');
INSERT INTO Orders (customer_id, order_date, status) VALUES (10, '2024-08-10 19:30:00', 'Shipped');
INSERT INTO Orders (customer_id, order_date, status) VALUES (11, '2024-08-11 20:00:00', 'Delivered');
INSERT INTO Orders (customer_id, order_date, status) VALUES (12, '2024-08-12 10:30:00', 'Processing');
INSERT INTO Orders (customer_id, order_date, status) VALUES (13, '2024-08-13 11:45:00', 'Shipped');
INSERT INTO Orders (customer_id, order_date, status) VALUES (14, '2024-08-14 12:00:00', 'Cancelled');
INSERT INTO Orders (customer_id, order_date, status) VALUES (15, '2024-08-15 13:15:00', 'Delivered');
INSERT INTO Orders (customer_id, order_date, status) VALUES (16, '2024-08-16 14:30:00', 'Processing');
INSERT INTO Orders (customer_id, order_date, status) VALUES (17, '2024-08-17 15:45:00', 'Shipped');
INSERT INTO Orders (customer_id, order_date, status) VALUES (18, '2024-08-18 16:00:00', 'Delivered');
INSERT INTO Orders (customer_id, order_date, status) VALUES (19, '2024-08-19 17:15:00', 'Cancelled');
INSERT INTO Orders (customer_id, order_date, status) VALUES (20, '2024-08-20 18:30:00', 'Processing');


-- Insertar datos en OrderDetail
INSERT INTO OrderDetail (order_id, product_id, quantity, price) VALUES (1, 1, 2, 1399.98);
INSERT INTO OrderDetail (order_id, product_id, quantity, price) VALUES (2, 2, 1, 1299.99);
INSERT INTO OrderDetail (order_id, product_id, quantity, price) VALUES (3, 3, 5, 99.95);
INSERT INTO OrderDetail (order_id, product_id, quantity, price) VALUES (4, 4, 3, 269.97);
INSERT INTO OrderDetail (order_id, product_id, quantity, price) VALUES (5, 5, 4, 59.96);
INSERT INTO OrderDetail (order_id, product_id, quantity, price) VALUES (6, 6, 2, 51.98);
INSERT INTO OrderDetail (order_id, product_id, quantity, price) VALUES (7, 7, 6, 77.94);
INSERT INTO OrderDetail (order_id, product_id, quantity, price) VALUES (8, 8, 1, 21.99);
INSERT INTO OrderDetail (order_id, product_id, quantity, price) VALUES (9, 9, 1, 119.99);
INSERT INTO OrderDetail (order_id, product_id, quantity, price) VALUES (10, 10, 2, 599.98);
INSERT INTO OrderDetail (order_id, product_id, quantity, price) VALUES (11, 11, 7, 179.93);
INSERT INTO OrderDetail (order_id, product_id, quantity, price) VALUES (12, 12, 3, 89.97);
INSERT INTO OrderDetail (order_id, product_id, quantity, price) VALUES (13, 13, 1, 29.99);
INSERT INTO OrderDetail (order_id, product_id, quantity, price) VALUES (14, 14, 2, 29.98);
INSERT INTO OrderDetail (order_id, product_id, quantity, price) VALUES (15, 15, 1, 34.99);
INSERT INTO OrderDetail (order_id, product_id, quantity, price) VALUES (16, 16, 4, 103.96);
INSERT INTO OrderDetail (order_id, product_id, quantity, price) VALUES (17, 17, 2, 69.98);
INSERT INTO OrderDetail (order_id, product_id, quantity, price) VALUES (18, 18, 1, 39.99);
INSERT INTO OrderDetail (order_id, product_id, quantity, price) VALUES (19, 19, 3, 207.00);
INSERT INTO OrderDetail (order_id, product_id, quantity, price) VALUES (20, 20, 5, 39.95);


-- Insertar datos en PaymentMethod
INSERT INTO PaymentMethod (method) VALUES ('Credit Card');
INSERT INTO PaymentMethod (method) VALUES ('PayPal');
INSERT INTO PaymentMethod (method) VALUES ('Bank Transfer');
INSERT INTO PaymentMethod (method) VALUES ('Bitcoin');
INSERT INTO PaymentMethod (method) VALUES ('Apple Pay');
INSERT INTO PaymentMethod (method) VALUES ('Google Pay');
INSERT INTO PaymentMethod (method) VALUES ('Gift Card');
INSERT INTO PaymentMethod (method) VALUES ('Cash on Delivery');
INSERT INTO PaymentMethod (method) VALUES ('Amazon Pay');
INSERT INTO PaymentMethod (method) VALUES ('Stripe');
INSERT INTO PaymentMethod (method) VALUES ('Square');
INSERT INTO PaymentMethod (method) VALUES ('Direct Debit');
INSERT INTO PaymentMethod (method) VALUES ('Wire Transfer');
INSERT INTO PaymentMethod (method) VALUES ('Check');
INSERT INTO PaymentMethod (method) VALUES ('Crypto');
INSERT INTO PaymentMethod (method) VALUES ('Debit Card');
INSERT INTO PaymentMethod (method) VALUES ('Alipay');
INSERT INTO PaymentMethod (method) VALUES ('WeChat Pay');
INSERT INTO PaymentMethod (method) VALUES ('Prepaid Card');
INSERT INTO PaymentMethod (method) VALUES ('Bank Draft');


-- Insertar datos en Shipping
INSERT INTO Shipping (order_id, shipping_date, delivery_date, carrier, tracking_number) VALUES (1, '2024-08-02 10:00:00', '2024-08-05 10:00:00', 'FedEx', 'FDX123456');
INSERT INTO Shipping (order_id, shipping_date, delivery_date, carrier, tracking_number) VALUES (2, '2024-08-03 11:00:00', '2024-08-06 11:00:00', 'UPS', 'UPS234567');
INSERT INTO Shipping (order_id, shipping_date, delivery_date, carrier, tracking_number) VALUES (3, '2024-08-04 12:00:00', '2024-08-07 12:00:00', 'DHL', 'DHL345678');
INSERT INTO Shipping (order_id, shipping_date, delivery_date, carrier, tracking_number) VALUES (4, '2024-08-05 13:00:00', '2024-08-08 13:00:00', 'USPS', 'USPS456789');
INSERT INTO Shipping (order_id, shipping_date, delivery_date, carrier, tracking_number) VALUES (5, '2024-08-06 14:00:00', '2024-08-09 14:00:00', 'FedEx', 'FDX567890');
INSERT INTO Shipping (order_id, shipping_date, delivery_date, carrier, tracking_number) VALUES (6, '2024-08-07 15:00:00', '2024-08-10 15:00:00', 'UPS', 'UPS678901');
INSERT INTO Shipping (order_id, shipping_date, delivery_date, carrier, tracking_number) VALUES (7, '2024-08-08 16:00:00', '2024-08-11 16:00:00', 'DHL', 'DHL789012');
INSERT INTO Shipping (order_id, shipping_date, delivery_date, carrier, tracking_number) VALUES (8, '2024-08-09 17:00:00', '2024-08-12 17:00:00', 'USPS', 'USPS890123');
INSERT INTO Shipping (order_id, shipping_date, delivery_date, carrier, tracking_number) VALUES (9, '2024-08-10 18:00:00', '2024-08-13 18:00:00', 'FedEx', 'FDX901234');
INSERT INTO Shipping (order_id, shipping_date, delivery_date, carrier, tracking_number) VALUES (10, '2024-08-11 19:00:00', '2024-08-14 19:00:00', 'UPS', 'UPS012345');
INSERT INTO Shipping (order_id, shipping_date, delivery_date, carrier, tracking_number) VALUES (11, '2024-08-12 20:00:00', '2024-08-15 20:00:00', 'DHL', 'DHL123456');
INSERT INTO Shipping (order_id, shipping_date, delivery_date, carrier, tracking_number) VALUES (12, '2024-08-13 10:00:00', '2024-08-16 10:00:00', 'USPS', 'USPS234567');
INSERT INTO Shipping (order_id, shipping_date, delivery_date, carrier, tracking_number) VALUES (13, '2024-08-14 11:00:00', '2024-08-17 11:00:00', 'FedEx', 'FDX345678');
INSERT INTO Shipping (order_id, shipping_date, delivery_date, carrier, tracking_number) VALUES (14, '2024-08-15 12:00:00', '2024-08-18 12:00:00', 'UPS', 'UPS456789');
INSERT INTO Shipping (order_id, shipping_date, delivery_date, carrier, tracking_number) VALUES (15, '2024-08-16 13:00:00', '2024-08-19 13:00:00', 'DHL', 'DHL567890');
INSERT INTO Shipping (order_id, shipping_date, delivery_date, carrier, tracking_number) VALUES (16, '2024-08-17 14:00:00', '2024-08-20 14:00:00', 'USPS', 'USPS678901');
INSERT INTO Shipping (order_id, shipping_date, delivery_date, carrier, tracking_number) VALUES (17, '2024-08-18 15:00:00', '2024-08-21 15:00:00', 'FedEx', 'FDX789012');
INSERT INTO Shipping (order_id, shipping_date, delivery_date, carrier, tracking_number) VALUES (18, '2024-08-19 16:00:00', '2024-08-22 16:00:00', 'UPS', 'UPS890123');
INSERT INTO Shipping (order_id, shipping_date, delivery_date, carrier, tracking_number) VALUES (19, '2024-08-20 17:00:00', '2024-08-23 17:00:00', 'DHL', 'DHL901234');
INSERT INTO Shipping (order_id, shipping_date, delivery_date, carrier, tracking_number) VALUES (20, '2024-08-21 18:00:00', '2024-08-24 18:00:00', 'USPS', 'USPS012345');


-- Insertar datos en Discount
INSERT INTO Discount (code, description, discount_percentage, start_date, end_date) VALUES ('SUMMER2024', 'Summer Sale 2024', 15.00, '2024-06-01 00:00:00', '2024-08-31 23:59:59');
INSERT INTO Discount (code, description, discount_percentage, start_date, end_date) VALUES ('WINTER2024', 'Winter Sale 2024', 20.00, '2024-12-01 00:00:00', '2024-12-31 23:59:59');
INSERT INTO Discount (code, description, discount_percentage, start_date, end_date) VALUES ('BLACKFRIDAY', 'Black Friday Sale', 25.00, '2024-11-24 00:00:00', '2024-11-30 23:59:59');
INSERT INTO Discount (code, description, discount_percentage, start_date, end_date) VALUES ('NEWYEAR2024', 'New Year Sale 2024', 10.00, '2024-12-30 00:00:00', '2025-01-02 23:59:59');
INSERT INTO Discount (code, description, discount_percentage, start_date, end_date) VALUES ('FALL2024', 'Fall Sale 2024', 30.00, '2024-09-01 00:00:00', '2024-11-30 23:59:59');
INSERT INTO Discount (code, description, discount_percentage, start_date, end_date) VALUES ('EASTER2024', 'Easter Sale 2024', 20.00, '2024-03-20 00:00:00', '2024-04-05 23:59:59');
INSERT INTO Discount (code, description, discount_percentage, start_date, end_date) VALUES ('MOTHERSDAY', "Mother's Day Sale", 15.00, '2024-05-01 00:00:00', '2024-05-12 23:59:59');
INSERT INTO Discount (code, description, discount_percentage, start_date, end_date) VALUES ('FATHERSDAY', "Father's Day Sale", 15.00, '2024-06-01 00:00:00', '2024-06-16 23:59:59');
INSERT INTO Discount (code, description, discount_percentage, start_date, end_date) VALUES ('VALENTINES', "Valentine's Day Sale", 25.00, '2024-02-01 00:00:00', '2024-02-14 23:59:59');
INSERT INTO Discount (code, description, discount_percentage, start_date, end_date) VALUES ('LABORDAY', 'Labor Day Sale', 20.00, '2024-08-01 00:00:00', '2024-08-31 23:59:59');
INSERT INTO Discount (code, description, discount_percentage, start_date, end_date) VALUES ('HALLOWEEN', 'Halloween Sale', 10.00, '2024-10-01 00:00:00', '2024-10-31 23:59:59');
INSERT INTO Discount (code, description, discount_percentage, start_date, end_date) VALUES ('CYBERMONDAY', 'Cyber Monday Sale', 30.00, '2024-12-02 00:00:00', '2024-12-02 23:59:59');
INSERT INTO Discount (code, description, discount_percentage, start_date, end_date) VALUES ('BOXINGDAY', 'Boxing Day Sale', 20.00, '2024-12-26 00:00:00', '2024-12-26 23:59:59');
INSERT INTO Discount (code, description, discount_percentage, start_date, end_date) VALUES ('SPRING2024', 'Spring Sale 2024', 10.00, '2024-03-01 00:00:00', '2024-05-31 23:59:59');
INSERT INTO Discount (code, description, discount_percentage, start_date, end_date) VALUES ('VIP2024', 'VIP Discount 2024', 5.00, '2024-01-01 00:00:00', '2024-12-31 23:59:59');
INSERT INTO Discount (code, description, discount_percentage, start_date, end_date) VALUES ('FLASHSALE', 'Flash Sale', 50.00, '2024-07-01 00:00:00', '2024-07-01 23:59:59');


-- Insertar datos en ProductReview
INSERT INTO ProductReview (product_id, customer_id, rating, review, review_date) VALUES (1, 1, 5, 'Excellent product, highly recommend!', '2024-08-01 10:00:00');
INSERT INTO ProductReview (product_id, customer_id, rating, review, review_date) VALUES (2, 2, 4, 'Very good, but could be improved.', '2024-08-02 11:00:00');
INSERT INTO ProductReview (product_id, customer_id, rating, review, review_date) VALUES (3, 3, 3, 'Average quality, not what I expected.', '2024-08-03 12:00:00');
INSERT INTO ProductReview (product_id, customer_id, rating, review, review_date) VALUES (4, 4, 2, 'Not satisfied with the product.', '2024-08-04 13:00:00');
INSERT INTO ProductReview (product_id, customer_id, rating, review, review_date) VALUES (5, 5, 1, 'Terrible experience, would not recommend.', '2024-08-05 14:00:00');
INSERT INTO ProductReview (product_id, customer_id, rating, review, review_date) VALUES (6, 6, 5, 'Absolutely love it, will buy again.', '2024-08-06 15:00:00');
INSERT INTO ProductReview (product_id, customer_id, rating, review, review_date) VALUES (7, 7, 4, 'Good quality, fair price.', '2024-08-07 16:00:00');
INSERT INTO ProductReview (product_id, customer_id, rating, review, review_date) VALUES (8, 8, 3, 'It’s okay, but could use some improvements.', '2024-08-08 17:00:00');
INSERT INTO ProductReview (product_id, customer_id, rating, review, review_date) VALUES (9, 9, 2, 'Disappointing, doesn’t match the description.', '2024-08-09 18:00:00');
INSERT INTO ProductReview (product_id, customer_id, rating, review, review_date) VALUES (10, 10, 5, 'Perfect in every way, will buy more.', '2024-08-10 19:00:00');
INSERT INTO ProductReview (product_id, customer_id, rating, review, review_date) VALUES (11, 11, 4, 'Very good, but delivery was slow.', '2024-08-11 20:00:00');
INSERT INTO ProductReview (product_id, customer_id, rating, review, review_date) VALUES (12, 12, 3, 'Satisfactory, but I expected better quality.', '2024-08-12 10:00:00');
INSERT INTO ProductReview (product_id, customer_id, rating, review, review_date) VALUES (13, 13, 2, 'Not great, had issues with the product.', '2024-08-13 11:00:00');
INSERT INTO ProductReview (product_id, customer_id, rating, review, review_date) VALUES (14, 14, 1, 'Worst purchase ever.', '2024-08-14 12:00:00');
INSERT INTO ProductReview (product_id, customer_id, rating, review, review_date) VALUES (15, 15, 5, 'Exceeded my expectations, great buy!', '2024-08-15 13:00:00');
INSERT INTO ProductReview (product_id, customer_id, rating, review, review_date) VALUES (16, 16, 4, 'Good product, would recommend.', '2024-08-16 14:00:00');
INSERT INTO ProductReview (product_id, customer_id, rating, review, review_date) VALUES (17, 17, 3, 'It’s decent, but not as good as advertised.', '2024-08-17 15:00:00');
INSERT INTO ProductReview (product_id, customer_id, rating, review, review_date) VALUES (18, 18, 2, 'Below average, didn’t meet my expectations.', '2024-08-18 16:00:00');
INSERT INTO ProductReview (product_id, customer_id, rating, review, review_date) VALUES (19, 19, 1, 'Very poor quality, not worth the money.', '2024-08-19 17:00:00');
INSERT INTO ProductReview (product_id, customer_id, rating, review, review_date) VALUES (20, 20, 5, 'Fantastic product, would buy again.', '2024-08-20 18:00:00');


-- Insertar datos en Inventory
INSERT INTO Inventory (product_id, quantity, last_update) VALUES (1, 100, '2024-08-01 10:00:00');
INSERT INTO Inventory (product_id, quantity, last_update) VALUES (2, 150, '2024-08-02 11:00:00');
INSERT INTO Inventory (product_id, quantity, last_update) VALUES (3, 200, '2024-08-03 12:00:00');
INSERT INTO Inventory (product_id, quantity, last_update) VALUES (4, 250, '2024-08-04 13:00:00');
INSERT INTO Inventory (product_id, quantity, last_update) VALUES (5, 300, '2024-08-05 14:00:00');
INSERT INTO Inventory (product_id, quantity, last_update) VALUES (6, 350, '2024-08-06 15:00:00');
INSERT INTO Inventory (product_id, quantity, last_update) VALUES (7, 400, '2024-08-07 16:00:00');
INSERT INTO Inventory (product_id, quantity, last_update) VALUES (8, 450, '2024-08-08 17:00:00');
INSERT INTO Inventory (product_id, quantity, last_update) VALUES (9, 500, '2024-08-09 18:00:00');
INSERT INTO Inventory (product_id, quantity, last_update) VALUES (10, 550, '2024-08-10 19:00:00');
INSERT INTO Inventory (product_id, quantity, last_update) VALUES (11, 600, '2024-08-11 20:00:00');
INSERT INTO Inventory (product_id, quantity, last_update) VALUES (12, 650, '2024-08-12 10:00:00');
INSERT INTO Inventory (product_id, quantity, last_update) VALUES (13, 700, '2024-08-13 11:00:00');
INSERT INTO Inventory (product_id, quantity, last_update) VALUES (14, 750, '2024-08-14 12:00:00');
INSERT INTO Inventory (product_id, quantity, last_update) VALUES (15, 800, '2024-08-15 13:00:00');
INSERT INTO Inventory (product_id, quantity, last_update) VALUES (16, 850, '2024-08-16 14:00:00');
INSERT INTO Inventory (product_id, quantity, last_update) VALUES (17, 900, '2024-08-17 15:00:00');
INSERT INTO Inventory (product_id, quantity, last_update) VALUES (18, 950, '2024-08-18 16:00:00');
INSERT INTO Inventory (product_id, quantity, last_update) VALUES (19, 1000, '2024-08-19 17:00:00');
INSERT INTO Inventory (product_id, quantity, last_update) VALUES (20, 1050, '2024-08-20 18:00:00');

-- Insertar datos en ProductReview
INSERT INTO ProductReview (product_id, customer_id, rating, review, review_date) VALUES (1, 1, 5, 'Excellent product, highly recommend!', '2024-08-01 10:00:00');
INSERT INTO ProductReview (product_id, customer_id, rating, review, review_date) VALUES (2, 2, 4, 'Very good, but could be improved.', '2024-08-02 11:00:00');
INSERT INTO ProductReview (product_id, customer_id, rating, review, review_date) VALUES (3, 3, 3, 'Average quality, not what I expected.', '2024-08-03 12:00:00');
INSERT INTO ProductReview (product_id, customer_id, rating, review, review_date) VALUES (4, 4, 2, 'Not satisfied with the product.', '2024-08-04 13:00:00');
INSERT INTO ProductReview (product_id, customer_id, rating, review, review_date) VALUES (5, 5, 1, 'Terrible experience, would not recommend.', '2024-08-05 14:00:00');
INSERT INTO ProductReview (product_id, customer_id, rating, review, review_date) VALUES (6, 6, 5, 'Absolutely love it, will buy again.', '2024-08-06 15:00:00');
INSERT INTO ProductReview (product_id, customer_id, rating, review, review_date) VALUES (7, 7, 4, 'Good quality, fair price.', '2024-08-07 16:00:00');
INSERT INTO ProductReview (product_id, customer_id, rating, review, review_date) VALUES (8, 8, 3, 'It’s okay, but could use some improvements.', '2024-08-08 17:00:00');
INSERT INTO ProductReview (product_id, customer_id, rating, review, review_date) VALUES (9, 9, 2, 'Disappointing, doesn’t match the description.', '2024-08-09 18:00:00');
INSERT INTO ProductReview (product_id, customer_id, rating, review, review_date) VALUES (10, 10, 5, 'Perfect in every way, will buy more.', '2024-08-10 19:00:00');
INSERT INTO ProductReview (product_id, customer_id, rating, review, review_date) VALUES (11, 11, 4, 'Very good, but delivery was slow.', '2024-08-11 20:00:00');
INSERT INTO ProductReview (product_id, customer_id, rating, review, review_date) VALUES (12, 12, 3, 'Satisfactory, but I expected better quality.', '2024-08-12 10:00:00');
INSERT INTO ProductReview (product_id, customer_id, rating, review, review_date) VALUES (13, 13, 2, 'Not great, had issues with the product.', '2024-08-13 11:00:00');
INSERT INTO ProductReview (product_id, customer_id, rating, review, review_date) VALUES (14, 14, 1, 'Worst purchase ever.', '2024-08-14 12:00:00');
INSERT INTO ProductReview (product_id, customer_id, rating, review, review_date) VALUES (15, 15, 5, 'Exceeded my expectations, great buy!', '2024-08-15 13:00:00');
INSERT INTO ProductReview (product_id, customer_id, rating, review, review_date) VALUES (16, 16, 4, 'Good product, would recommend.', '2024-08-16 14:00:00');
INSERT INTO ProductReview (product_id, customer_id, rating, review, review_date) VALUES (17, 17, 3, 'It’s decent, but not as good as advertised.', '2024-08-17 15:00:00');
INSERT INTO ProductReview (product_id, customer_id, rating, review, review_date) VALUES (18, 18, 2, 'Below average, didn’t meet my expectations.', '2024-08-18 16:00:00');
INSERT INTO ProductReview (product_id, customer_id, rating, review, review_date) VALUES (19, 19, 1, 'Very poor quality, not worth the money.', '2024-08-19 17:00:00');
INSERT INTO ProductReview (product_id, customer_id, rating, review, review_date) VALUES (20, 20, 5, 'Fantastic product, would buy again.', '2024-08-20 18:00:00');

-- Insertar datos en Inventory
INSERT INTO Inventory (product_id, quantity, last_update) VALUES (1, 100, '2024-08-01 10:00:00');
INSERT INTO Inventory (product_id, quantity, last_update) VALUES (2, 150, '2024-08-02 11:00:00');
INSERT INTO Inventory (product_id, quantity, last_update) VALUES (3, 200, '2024-08-03 12:00:00');
INSERT INTO Inventory (product_id, quantity, last_update) VALUES (4, 250, '2024-08-04 13:00:00');
INSERT INTO Inventory (product_id, quantity, last_update) VALUES (5, 300, '2024-08-05 14:00:00');
INSERT INTO Inventory (product_id, quantity, last_update) VALUES (6, 350, '2024-08-06 15:00:00');
INSERT INTO Inventory (product_id, quantity, last_update) VALUES (7, 400, '2024-08-07 16:00:00');
INSERT INTO Inventory (product_id, quantity, last_update) VALUES (8, 450, '2024-08-08 17:00:00');
INSERT INTO Inventory (product_id, quantity, last_update) VALUES (9, 500, '2024-08-09 18:00:00');
INSERT INTO Inventory (product_id, quantity, last_update) VALUES (10, 550, '2024-08-10 19:00:00');
INSERT INTO Inventory (product_id, quantity, last_update) VALUES (11, 600, '2024-08-11 20:00:00');
INSERT INTO Inventory (product_id, quantity, last_update) VALUES (12, 650, '2024-08-12 10:00:00');
INSERT INTO Inventory (product_id, quantity, last_update) VALUES (13, 700, '2024-08-13 11:00:00');
INSERT INTO Inventory (product_id, quantity, last_update) VALUES (14, 750, '2024-08-14 12:00:00');
INSERT INTO Inventory (product_id, quantity, last_update) VALUES (15, 800, '2024-08-15 13:00:00');
INSERT INTO Inventory (product_id, quantity, last_update) VALUES (16, 850, '2024-08-16 14:00:00');
INSERT INTO Inventory (product_id, quantity, last_update) VALUES (17, 900, '2024-08-17 15:00:00');
INSERT INTO Inventory (product_id, quantity, last_update) VALUES (18, 950, '2024-08-18 16:00:00');
INSERT INTO Inventory (product_id, quantity, last_update) VALUES (19, 1000, '2024-08-19 17:00:00');
INSERT INTO Inventory (product_id, quantity, last_update) VALUES (20, 1050, '2024-08-20 18:00:00');

-- Insertar datos en Wishlist
INSERT INTO Wishlist (customer_id, product_id, date_added) VALUES (1, 1, '2024-08-01 10:00:00');
INSERT INTO Wishlist (customer_id, product_id, date_added) VALUES (2, 2, '2024-08-02 11:00:00');
INSERT INTO Wishlist (customer_id, product_id, date_added) VALUES (3, 3, '2024-08-03 12:00:00');
INSERT INTO Wishlist (customer_id, product_id, date_added) VALUES (4, 4, '2024-08-04 13:00:00');
INSERT INTO Wishlist (customer_id, product_id, date_added) VALUES (5, 5, '2024-08-05 14:00:00');
INSERT INTO Wishlist (customer_id, product_id, date_added) VALUES (6, 6, '2024-08-06 15:00:00');
INSERT INTO Wishlist (customer_id, product_id, date_added) VALUES (7, 7, '2024-08-07 16:00:00');
INSERT INTO Wishlist (customer_id, product_id, date_added) VALUES (8, 8, '2024-08-08 17:00:00');
INSERT INTO Wishlist (customer_id, product_id, date_added) VALUES (9, 9, '2024-08-09 18:00:00');
INSERT INTO Wishlist (customer_id, product_id, date_added) VALUES (10, 10, '2024-08-10 19:00:00');
INSERT INTO Wishlist (customer_id, product_id, date_added) VALUES (11, 11, '2024-08-11 20:00:00');
INSERT INTO Wishlist (customer_id, product_id, date_added) VALUES (12, 12, '2024-08-12 10:00:00');
INSERT INTO Wishlist (customer_id, product_id, date_added) VALUES (13, 13, '2024-08-13 11:00:00');
INSERT INTO Wishlist (customer_id, product_id, date_added) VALUES (14, 14, '2024-08-14 12:00:00');
INSERT INTO Wishlist (customer_id, product_id, date_added) VALUES (15, 15, '2024-08-15 13:00:00');
INSERT INTO Wishlist (customer_id, product_id, date_added) VALUES (16, 16, '2024-08-16 14:00:00');
INSERT INTO Wishlist (customer_id, product_id, date_added) VALUES (17, 17, '2024-08-17 15:00:00');
INSERT INTO Wishlist (customer_id, product_id, date_added) VALUES (18, 18, '2024-08-18 16:00:00');
INSERT INTO Wishlist (customer_id, product_id, date_added) VALUES (19, 19, '2024-08-19 17:00:00');
INSERT INTO Wishlist (customer_id, product_id, date_added) VALUES (20, 20, '2024-08-20 18:00:00');

-- Insertar datos en Payment 
INSERT INTO Payment (order_id, payment_method_id, payment_date, amount) VALUES (1, 1, '2024-08-01 10:00:00', 100.00);
INSERT INTO Payment (order_id, payment_method_id, payment_date, amount) VALUES (2, 2, '2024-08-02 11:00:00', 150.00);
INSERT INTO Payment (order_id, payment_method_id, payment_date, amount) VALUES (3, 1, '2024-08-03 12:00:00', 200.00);
INSERT INTO Payment (order_id, payment_method_id, payment_date, amount) VALUES (4, 2, '2024-08-04 13:00:00', 250.00);
INSERT INTO Payment (order_id, payment_method_id, payment_date, amount) VALUES (5, 3, '2024-08-05 14:00:00', 300.00);
INSERT INTO Payment (order_id, payment_method_id, payment_date, amount) VALUES (6, 1, '2024-08-06 15:00:00', 350.00);
INSERT INTO Payment (order_id, payment_method_id, payment_date, amount) VALUES (7, 2, '2024-08-07 16:00:00', 400.00);
INSERT INTO Payment (order_id, payment_method_id, payment_date, amount) VALUES (8, 3, '2024-08-08 17:00:00', 450.00);
INSERT INTO Payment (order_id, payment_method_id, payment_date, amount) VALUES (9, 1, '2024-08-09 18:00:00', 500.00);
INSERT INTO Payment (order_id, payment_method_id, payment_date, amount) VALUES (10, 2, '2024-08-10 19:00:00', 550.00);
INSERT INTO Payment (order_id, payment_method_id, payment_date, amount) VALUES (11, 3, '2024-08-11 20:00:00', 600.00);
INSERT INTO Payment (order_id, payment_method_id, payment_date, amount) VALUES (12, 1, '2024-08-12 10:00:00', 650.00);
INSERT INTO Payment (order_id, payment_method_id, payment_date, amount) VALUES (13, 2, '2024-08-13 11:00:00', 700.00);
INSERT INTO Payment (order_id, payment_method_id, payment_date, amount) VALUES (14, 3, '2024-08-14 12:00:00', 750.00);
INSERT INTO Payment (order_id, payment_method_id, payment_date, amount) VALUES (15, 1, '2024-08-15 13:00:00', 800.00);
INSERT INTO Payment (order_id, payment_method_id, payment_date, amount) VALUES (16, 2, '2024-08-16 14:00:00', 850.00);
INSERT INTO Payment (order_id, payment_method_id, payment_date, amount) VALUES (17, 3, '2024-08-17 15:00:00', 900.00);
INSERT INTO Payment (order_id, payment_method_id, payment_date, amount) VALUES (18, 1, '2024-08-18 16:00:00', 950.00);
INSERT INTO Payment (order_id, payment_method_id, payment_date, amount) VALUES (19, 2, '2024-08-19 17:00:00', 1000.00);
INSERT INTO Payment (order_id, payment_method_id, payment_date, amount) VALUES (20, 3, '2024-08-20 18:00:00', 1050.00);

-- Insertar datos en Supplier
INSERT INTO Supplier (name, contact_name, phone, email, address, city, country) VALUES ('Supplier One', 'John Doe', '123-456-7890', 'john.doe@example.com', '123 Elm Street', 'Springfield', 'USA');
INSERT INTO Supplier (name, contact_name, phone, email, address, city, country) VALUES ('Supplier Two', 'Jane Smith', '234-567-8901', 'jane.smith@example.com', '456 Oak Avenue', 'Shelbyville', 'USA');
INSERT INTO Supplier (name, contact_name, phone, email, address, city, country) VALUES ('Supplier Three', 'Michael Johnson', '345-678-9012', 'michael.johnson@example.com', '789 Pine Road', 'Capital City', 'USA');
INSERT INTO Supplier (name, contact_name, phone, email, address, city, country) VALUES ('Supplier Four', 'Emily Davis', '456-789-0123', 'emily.davis@example.com', '101 Maple Lane', 'Riverdale', 'USA');
INSERT INTO Supplier (name, contact_name, phone, email, address, city, country) VALUES ('Supplier Five', 'David Wilson', '567-890-1234', 'david.wilson@example.com', '202 Birch Boulevard', 'Greenwood', 'USA');
INSERT INTO Supplier (name, contact_name, phone, email, address, city, country) VALUES ('Supplier Six', 'Sophia Martinez', '678-901-2345', 'sophia.martinez@example.com', '303 Cedar Street', 'Elmwood', 'USA');
INSERT INTO Supplier (name, contact_name, phone, email, address, city, country) VALUES ('Supplier Seven', 'Daniel Anderson', '789-012-3456', 'daniel.anderson@example.com', '404 Cherry Court', 'Harrison', 'USA');
INSERT INTO Supplier (name, contact_name, phone, email, address, city, country) VALUES ('Supplier Eight', 'Olivia Thomas', '890-123-4567', 'olivia.thomas@example.com', '505 Walnut Drive', 'Brookside', 'USA');
INSERT INTO Supplier (name, contact_name, phone, email, address, city, country) VALUES ('Supplier Nine', 'James Lee', '901-234-5678', 'james.lee@example.com', '606 Fir Street', 'Maplewood', 'USA');
INSERT INTO Supplier (name, contact_name, phone, email, address, city, country) VALUES ('Supplier Ten', 'Ava Harris', '012-345-6789', 'ava.harris@example.com', '707 Pine Avenue', 'Westfield', 'USA');
INSERT INTO Supplier (name, contact_name, phone, email, address, city, country) VALUES ('Supplier Eleven', 'William Clark', '123-456-7891', 'william.clark@example.com', '808 Oak Lane', 'Easttown', 'USA');
INSERT INTO Supplier (name, contact_name, phone, email, address, city, country) VALUES ('Supplier Twelve', 'Isabella Lewis', '234-567-8902', 'isabella.lewis@example.com', '909 Elm Street', 'Southport', 'USA');
INSERT INTO Supplier (name, contact_name, phone, email, address, city, country) VALUES ('Supplier Thirteen', 'Ethan Walker', '345-678-9013', 'ethan.walker@example.com', '1010 Maple Avenue', 'Northfield', 'USA');
INSERT INTO Supplier (name, contact_name, phone, email, address, city, country) VALUES ('Supplier Fourteen', 'Mia Scott', '456-789-0124', 'mia.scott@example.com', '1111 Birch Road', 'Lakeview', 'USA');
INSERT INTO Supplier (name, contact_name, phone, email, address, city, country) VALUES ('Supplier Fifteen', 'Alexander Young', '567-890-1235', 'alexander.young@example.com', '1212 Pine Street', 'Riverside', 'USA');
INSERT INTO Supplier (name, contact_name, phone, email, address, city, country) VALUES ('Supplier Sixteen', 'Charlotte King', '678-901-2346', 'charlotte.king@example.com', '1313 Oak Avenue', 'Baytown', 'USA');
INSERT INTO Supplier (name, contact_name, phone, email, address, city, country) VALUES ('Supplier Seventeen', 'Liam Wright', '789-012-3457', 'liam.wright@example.com', '1414 Cedar Lane', 'Glenwood', 'USA');
INSERT INTO Supplier (name, contact_name, phone, email, address, city, country) VALUES ('Supplier Eighteen', 'Amelia Harris', '890-123-4568', 'amelia.harris@example.com', '1515 Walnut Road', 'Riverbank', 'USA');
INSERT INTO Supplier (name, contact_name, phone, email, address, city, country) VALUES ('Supplier Nineteen', 'Noah Robinson', '901-234-5679', 'noah.robinson@example.com', '1616 Fir Avenue', 'Springdale', 'USA');
INSERT INTO Supplier (name, contact_name, phone, email, address, city, country) VALUES ('Supplier Twenty', 'Harper Carter', '012-345-6780', 'harper.carter@example.com', '1717 Cherry Drive', 'Fairview', 'USA');

-- Script de Creación de Vistas

CREATE VIEW ProductsWithCategory AS
SELECT p.product_id, p.name AS product_name, p.description, p.price, p.stock, c.name AS category_name
FROM Product p
JOIN ProductCategory c ON p.category_id = c.category_id;

CREATE VIEW OrdersWithDetails AS
SELECT o.order_id, o.order_date, o.status, c.first_name, c.last_name, od.product_id, od.quantity, od.price
FROM Orders o
JOIN Customer c ON o.customer_id = c.customer_id
JOIN OrderDetail od ON o.order_id = od.order_id;

-- Script de Creación de Funciones

DELIMITER //

CREATE FUNCTION CalcularPrecioDescuento(
    precio_original DECIMAL(10,2),
    porcentaje_descuento DECIMAL(5,2)
) RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE precio_descuento DECIMAL(10,2);
    SET precio_descuento = precio_original - (precio_original * porcentaje_descuento / 100);
    RETURN precio_descuento;
END //

DELIMITER ;


-- Script de Creación de Stored Procedures

DELIMITER //

CREATE PROCEDURE UpdateOrderStatus(
    IN p_order_id INT,
    IN p_new_status VARCHAR(50)
)
BEGIN
    UPDATE Orders
    SET status = p_new_status
    WHERE order_id = p_order_id;
END //

DELIMITER ;

-- Script de Creación de Triggers

DELIMITER //

CREATE TRIGGER UpdateStockAfterOrder
AFTER INSERT ON OrderDetail
FOR EACH ROW
BEGIN
    UPDATE Product
    SET stock = stock - NEW.quantity
    WHERE product_id = NEW.product_id;
END //

DELIMITER ;




