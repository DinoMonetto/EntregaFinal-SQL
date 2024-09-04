-- Eliminar la base de datos si existe
DROP DATABASE IF EXISTS TiendaRopa;

-- Crear la base de datos
CREATE DATABASE TiendaRopa;

-- Usar la base de datos
USE TiendaRopa;

-- Tabla: Categoría de Producto
CREATE TABLE ProductCategory (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

-- Tabla: Descuentos y Cupones
CREATE TABLE Discount (
    discount_id INT AUTO_INCREMENT PRIMARY KEY,
    code VARCHAR(50) UNIQUE,
    description VARCHAR(255),
    discount_percentage DECIMAL(5, 2) NOT NULL CHECK (discount_percentage >= 0 AND discount_percentage <= 100),
    start_date DATETIME NOT NULL,
    end_date DATETIME NOT NULL,
    minimum_purchase_amount DECIMAL(10, 2),
    status VARCHAR(50) NOT NULL
);

-- Tabla: Producto
CREATE TABLE Product (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    stock INT NOT NULL,
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES ProductCategory(category_id) ON DELETE SET NULL
);
CREATE INDEX idx_product_category_id ON Product(category_id);

-- Tabla: Cliente
CREATE TABLE Customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
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
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id) ON DELETE CASCADE
);

-- Tabla: Pedido
CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATETIME NOT NULL,
    status VARCHAR(50) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id) ON DELETE CASCADE
);

-- Tabla: Detalle del Pedido
CREATE TABLE OrderDetail (
    order_detail_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES Product(product_id) ON DELETE CASCADE
);

-- Tabla: Método de Pago
CREATE TABLE PaymentMethod (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    method VARCHAR(255) NOT NULL
);

-- Tabla: Pago
CREATE TABLE Payment (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    payment_method_id INT,
    payment_date DATETIME NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (payment_method_id) REFERENCES PaymentMethod(payment_id)
);

-- Tabla: Envío
CREATE TABLE Shipping (
    shipping_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    shipping_date DATETIME NOT NULL,
    delivery_date DATETIME NOT NULL,
    carrier VARCHAR(255) NOT NULL,
    tracking_number VARCHAR(255) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE
);

-- Tabla: Reseñas de Productos
CREATE TABLE ProductReview (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    customer_id INT,
    rating INT NOT NULL CHECK (rating >= 1 AND rating <= 5),
    review TEXT,
    review_date DATETIME NOT NULL,
    FOREIGN KEY (product_id) REFERENCES Product(product_id) ON DELETE CASCADE,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id) ON DELETE CASCADE
);

-- Tabla: Inventario
CREATE TABLE Inventory (
    inventory_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    quantity INT NOT NULL,
    last_update DATETIME NOT NULL,
    FOREIGN KEY (product_id) REFERENCES Product(product_id) ON DELETE CASCADE
);

-- Tabla: Lista de deseos
CREATE TABLE Wishlist (
    wishlist_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    date_added DATETIME NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES Product(product_id) ON DELETE CASCADE
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
    FOREIGN KEY (product_id) REFERENCES Product(product_id) ON DELETE CASCADE,
    FOREIGN KEY (supplier_id) REFERENCES Supplier(supplier_id) ON DELETE CASCADE
);

-- Tabla: Programa de Lealtad
CREATE TABLE LoyaltyProgram (
    program_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    points_per_dollar DECIMAL(5, 2) NOT NULL CHECK (points_per_dollar >= 0),
    start_date DATE NOT NULL,
    end_date DATE
);

-- Tabla: Lealtad de Clientes
CREATE TABLE CustomerLoyalty (
    customer_loyalty_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    program_id INT,
    points INT NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id) ON DELETE CASCADE,
    FOREIGN KEY (program_id) REFERENCES LoyaltyProgram(program_id) ON DELETE CASCADE
);

-- Tabla: Tarjetas de Regalo
CREATE TABLE GiftCard (
    giftcard_id INT AUTO_INCREMENT PRIMARY KEY,
    code VARCHAR(50) UNIQUE NOT NULL,
    balance DECIMAL(10, 2) NOT NULL,
    expiration_date DATE NOT NULL
);

-- Tabla: Transacciones de Tarjetas de Regalo
CREATE TABLE GiftCardTransaction (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    giftcard_id INT,
    order_id INT,
    amount DECIMAL(10, 2) NOT NULL,
    transaction_date DATE NOT NULL,
    FOREIGN KEY (giftcard_id) REFERENCES GiftCard(giftcard_id) ON DELETE CASCADE,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE
);

-- Insert en tablas
INSERT INTO ProductCategory (name) VALUES ('Ropa');
INSERT INTO ProductCategory (name) VALUES ('Electrónica');
INSERT INTO ProductCategory (name) VALUES ('Hogar');
INSERT INTO ProductCategory (name) VALUES ('Juguetes');
INSERT INTO ProductCategory (name) VALUES ('Deportes');
INSERT INTO ProductCategory (name) VALUES ('Salud');
INSERT INTO ProductCategory (name) VALUES ('Belleza');
INSERT INTO ProductCategory (name) VALUES ('Accesorios');
INSERT INTO ProductCategory (name) VALUES ('Libros');
INSERT INTO ProductCategory (name) VALUES ('Oficina');

INSERT INTO Discount (code, description, discount_percentage, start_date, end_date, minimum_purchase_amount, status) 
VALUES ('PROMO10', 'Descuento del 10%', 10.00, '2024-01-01 00:00:00', '2024-12-31 23:59:59', 100.00, 'Activo');
INSERT INTO Discount (code, description, discount_percentage, start_date, end_date, minimum_purchase_amount, status) 
VALUES ('SUMMER20', 'Descuento del 20% en verano', 20.00, '2024-06-01 00:00:00', '2024-08-31 23:59:59', 50.00, 'Activo');
INSERT INTO Discount (code, description, discount_percentage, start_date, end_date, minimum_purchase_amount, status) 
VALUES ('WINTER15', 'Descuento del 15% en invierno', 15.00, '2024-12-01 00:00:00', '2024-12-31 23:59:59', 75.00, 'Activo');
INSERT INTO Discount (code, description, discount_percentage, start_date, end_date, minimum_purchase_amount, status) 
VALUES ('NEWYEAR25', 'Descuento del 25% en Año Nuevo', 25.00, '2024-12-25 00:00:00', '2025-01-01 23:59:59', 150.00, 'Activo');
INSERT INTO Discount (code, description, discount_percentage, start_date, end_date, minimum_purchase_amount, status) 
VALUES ('BLACKFRIDAY30', 'Descuento del 30% en Black Friday', 30.00, '2024-11-29 00:00:00', '2024-11-29 23:59:59', 200.00, 'Activo');
INSERT INTO Discount (code, description, discount_percentage, start_date, end_date, minimum_purchase_amount, status) 
VALUES ('FALL10', 'Descuento del 10% en otoño', 10.00, '2024-09-01 00:00:00', '2024-11-30 23:59:59', 60.00, 'Activo');
INSERT INTO Discount (code, description, discount_percentage, start_date, end_date, minimum_purchase_amount, status) 
VALUES ('SPRING5', 'Descuento del 5% en primavera', 5.00, '2024-03-01 00:00:00', '2024-05-31 23:59:59', 40.00, 'Activo');
INSERT INTO Discount (code, description, discount_percentage, start_date, end_date, minimum_purchase_amount, status) 
VALUES ('HOLIDAY15', 'Descuento del 15% en vacaciones', 15.00, '2024-07-01 00:00:00', '2024-08-31 23:59:59', 80.00, 'Activo');
INSERT INTO Discount (code, description, discount_percentage, start_date, end_date, minimum_purchase_amount, status) 
VALUES ('EASTER20', 'Descuento del 20% en Pascua', 20.00, '2024-04-01 00:00:00', '2024-04-30 23:59:59', 90.00, 'Activo');
INSERT INTO Discount (code, description, discount_percentage, start_date, end_date, minimum_purchase_amount, status) 
VALUES ('MOTHERSDAY10', 'Descuento del 10% en Día de la Madre', 10.00, '2024-05-01 00:00:00', '2024-05-12 23:59:59', 70.00, 'Activo');

INSERT INTO Product (name, description, price, stock, category_id) VALUES ('Camiseta Roja', 'Camiseta de algodón rojo', 19.99, 50, 1);
INSERT INTO Product (name, description, price, stock, category_id) VALUES ('Laptop Gaming', 'Laptop con gráficos potentes', 1299.99, 20, 2);
INSERT INTO Product (name, description, price, stock, category_id) VALUES ('Sofá Cama', 'Sofá que se convierte en cama', 499.99, 15, 3);
INSERT INTO Product (name, description, price, stock, category_id) VALUES ('Juguete de Construcción', 'Bloques de construcción para niños', 29.99, 100, 4);
INSERT INTO Product (name, description, price, stock, category_id) VALUES ('Zapatillas Deportivas', 'Zapatillas para correr', 79.99, 30, 5);
INSERT INTO Product (name, description, price, stock, category_id) VALUES ('Crema Facial', 'Crema para el cuidado de la piel', 24.99, 40, 6);
INSERT INTO Product (name, description, price, stock, category_id) VALUES ('Perfume Floral', 'Perfume con aroma floral', 59.99, 25, 7);
INSERT INTO Product (name, description, price, stock, category_id) VALUES ('Bolso de Mano', 'Bolso de cuero para mujeres', 89.99, 35, 8);
INSERT INTO Product (name, description, price, stock, category_id) VALUES ('Novela de Ciencia Ficción', 'Una novela emocionante', 14.99, 60, 9);
INSERT INTO Product (name, description, price, stock, category_id) VALUES ('Silla de Oficina', 'Silla ergonómica para oficina', 149.99, 10, 10);

INSERT INTO Customer (first_name, last_name, email, phone) VALUES ('Juan', 'Pérez', 'juan.perez@example.com', '555-1234');
INSERT INTO Customer (first_name, last_name, email, phone) VALUES ('Ana', 'Gómez', 'ana.gomez@example.com', '555-5678');
INSERT INTO Customer (first_name, last_name, email, phone) VALUES ('Carlos', 'Martínez', 'carlos.martinez@example.com', '555-8765');
INSERT INTO Customer (first_name, last_name, email, phone) VALUES ('Laura', 'Rodríguez', 'laura.rodriguez@example.com', '555-4321');
INSERT INTO Customer (first_name, last_name, email, phone) VALUES ('Marta', 'López', 'marta.lopez@example.com', '555-1357');
INSERT INTO Customer (first_name, last_name, email, phone) VALUES ('Luis', 'Hernández', 'luis.hernandez@example.com', '555-2468');
INSERT INTO Customer (first_name, last_name, email, phone) VALUES ('Sofía', 'Mendoza', 'sofia.mendoza@example.com', '555-8642');
INSERT INTO Customer (first_name, last_name, email, phone) VALUES ('Pedro', 'Fernández', 'pedro.fernandez@example.com', '555-7531');
INSERT INTO Customer (first_name, last_name, email, phone) VALUES ('Isabel', 'García', 'isabel.garcia@example.com', '555-9512');
INSERT INTO Customer (first_name, last_name, email, phone) VALUES ('Javier', 'Vega', 'javier.vega@example.com', '555-6789');

INSERT INTO CustomerAddress (customer_id, address, city, postal_code, country) VALUES (1, 'Calle Falsa 123', 'Madrid', '28001', 'España');
INSERT INTO CustomerAddress (customer_id, address, city, postal_code, country) VALUES (2, 'Avenida del Prado 456', 'Barcelona', '08001', 'España');
INSERT INTO CustomerAddress (customer_id, address, city, postal_code, country) VALUES (3, 'Plaza Mayor 789', 'Valencia', '46001', 'España');
INSERT INTO CustomerAddress (customer_id, address, city, postal_code, country) VALUES (4, 'Calle de Alcalá 101', 'Sevilla', '41001', 'España');
INSERT INTO CustomerAddress (customer_id, address, city, postal_code, country) VALUES (5, 'Paseo de la Castellana 202', 'Bilbao', '48001', 'España');
INSERT INTO CustomerAddress (customer_id, address, city, postal_code, country) VALUES (6, 'Calle del Carmen 303', 'Granada', '18001', 'España');
INSERT INTO CustomerAddress (customer_id, address, city, postal_code, country) VALUES (7, 'Avenida de la Constitución 404', 'Zaragoza', '50001', 'España');
INSERT INTO CustomerAddress (customer_id, address, city, postal_code, country) VALUES (8, 'Calle de Vallehermoso 505', 'Murcia', '30001', 'España');
INSERT INTO CustomerAddress (customer_id, address, city, postal_code, country) VALUES (9, 'Calle de la Princesa 606', 'San Sebastián', '20001', 'España');
INSERT INTO CustomerAddress (customer_id, address, city, postal_code, country) VALUES (10, 'Calle del Sol 707', 'A Coruña', '15001', 'España');

INSERT INTO Orders (customer_id, order_date, status) VALUES (1, '2024-08-01 12:00:00', 'Pendiente');
INSERT INTO Orders (customer_id, order_date, status) VALUES (2, '2024-08-02 14:30:00', 'Enviado');
INSERT INTO Orders (customer_id, order_date, status) VALUES (3, '2024-08-03 16:45:00', 'Entregado');
INSERT INTO Orders (customer_id, order_date, status) VALUES (4, '2024-08-04 09:00:00', 'Cancelado');
INSERT INTO Orders (customer_id, order_date, status) VALUES (5, '2024-08-05 11:15:00', 'Pendiente');
INSERT INTO Orders (customer_id, order_date, status) VALUES (6, '2024-08-06 13:30:00', 'Enviado');
INSERT INTO Orders (customer_id, order_date, status) VALUES (7, '2024-08-07 15:45:00', 'Entregado');
INSERT INTO Orders (customer_id, order_date, status) VALUES (8, '2024-08-08 17:00:00', 'Cancelado');
INSERT INTO Orders (customer_id, order_date, status) VALUES (9, '2024-08-09 18:15:00', 'Pendiente');
INSERT INTO Orders (customer_id, order_date, status) VALUES (10, '2024-08-10 19:30:00', 'Enviado');

INSERT INTO OrderDetail (order_id, product_id, quantity, price) VALUES (1, 1, 2, 19.99);
INSERT INTO OrderDetail (order_id, product_id, quantity, price) VALUES (2, 2, 1, 1299.99);
INSERT INTO OrderDetail (order_id, product_id, quantity, price) VALUES (3, 3, 1, 499.99);
INSERT INTO OrderDetail (order_id, product_id, quantity, price) VALUES (4, 4, 5, 29.99);
INSERT INTO OrderDetail (order_id, product_id, quantity, price) VALUES (5, 5, 1, 79.99);
INSERT INTO OrderDetail (order_id, product_id, quantity, price) VALUES (6, 6, 3, 24.99);
INSERT INTO OrderDetail (order_id, product_id, quantity, price) VALUES (7, 7, 2, 59.99);
INSERT INTO OrderDetail (order_id, product_id, quantity, price) VALUES (8, 8, 1, 89.99);
INSERT INTO OrderDetail (order_id, product_id, quantity, price) VALUES (9, 9, 4, 14.99);
INSERT INTO OrderDetail (order_id, product_id, quantity, price) VALUES (10, 10, 1, 149.99);

INSERT INTO PaymentMethod (method) VALUES ('Tarjeta de Crédito');
INSERT INTO PaymentMethod (method) VALUES ('Tarjeta de Débito');
INSERT INTO PaymentMethod (method) VALUES ('PayPal');
INSERT INTO PaymentMethod (method) VALUES ('Transferencia Bancaria');
INSERT INTO PaymentMethod (method) VALUES ('Contra Reembolso');
INSERT INTO PaymentMethod (method) VALUES ('Bitcoin');
INSERT INTO PaymentMethod (method) VALUES ('Efectivo');
INSERT INTO PaymentMethod (method) VALUES ('Cheque');
INSERT INTO PaymentMethod (method) VALUES ('Apple Pay');
INSERT INTO PaymentMethod (method) VALUES ('Google Pay');

INSERT INTO Payment (order_id, payment_method_id, payment_date, amount) VALUES (1, 1, '2024-08-01 12:30:00', 39.98);
INSERT INTO Payment (order_id, payment_method_id, payment_date, amount) VALUES (2, 2, '2024-08-02 14:45:00', 1299.99);
INSERT INTO Payment (order_id, payment_method_id, payment_date, amount) VALUES (3, 3, '2024-08-03 16:50:00', 499.99);
INSERT INTO Payment (order_id, payment_method_id, payment_date, amount) VALUES (4, 4, '2024-08-04 09:15:00', 149.95);
INSERT INTO Payment (order_id, payment_method_id, payment_date, amount) VALUES (5, 5, '2024-08-05 11:20:00', 79.99);
INSERT INTO Payment (order_id, payment_method_id, payment_date, amount) VALUES (6, 6, '2024-08-06 13:35:00', 74.97);
INSERT INTO Payment (order_id, payment_method_id, payment_date, amount) VALUES (7, 7, '2024-08-07 15:50:00', 119.98);
INSERT INTO Payment (order_id, payment_method_id, payment_date, amount) VALUES (8, 8, '2024-08-08 17:05:00', 89.99);
INSERT INTO Payment (order_id, payment_method_id, payment_date, amount) VALUES (9, 9, '2024-08-09 18:20:00', 59.99);
INSERT INTO Payment (order_id, payment_method_id, payment_date, amount) VALUES (10, 10, '2024-08-10 19:35:00', 149.99);

INSERT INTO Shipping (order_id, shipping_date, delivery_date, carrier, tracking_number) VALUES (1, '2024-08-01 13:00:00', '2024-08-03 15:00:00', 'SEUR', 'SEUR123456');
INSERT INTO Shipping (order_id, shipping_date, delivery_date, carrier, tracking_number) VALUES (2, '2024-08-02 15:00:00', '2024-08-05 17:00:00', 'Correos', 'CORREOS654321');
INSERT INTO Shipping (order_id, shipping_date, delivery_date, carrier, tracking_number) VALUES (3, '2024-08-03 16:00:00', '2024-08-06 18:00:00', 'DHL', 'DHL789012');
INSERT INTO Shipping (order_id, shipping_date, delivery_date, carrier, tracking_number) VALUES (4, '2024-08-04 09:30:00', '2024-08-07 11:30:00', 'MRW', 'MRW345678');
INSERT INTO Shipping (order_id, shipping_date, delivery_date, carrier, tracking_number) VALUES (5, '2024-08-05 11:45:00', '2024-08-08 13:45:00', 'GLS', 'GLS901234');
INSERT INTO Shipping (order_id, shipping_date, delivery_date, carrier, tracking_number) VALUES (6, '2024-08-06 13:00:00', '2024-08-09 15:00:00', 'SEUR', 'SEUR567890');
INSERT INTO Shipping (order_id, shipping_date, delivery_date, carrier, tracking_number) VALUES (7, '2024-08-07 15:15:00', '2024-08-10 17:15:00', 'Correos', 'CORREOS098765');
INSERT INTO Shipping (order_id, shipping_date, delivery_date, carrier, tracking_number) VALUES (8, '2024-08-08 17:30:00', '2024-08-11 19:30:00', 'DHL', 'DHL432109');
INSERT INTO Shipping (order_id, shipping_date, delivery_date, carrier, tracking_number) VALUES (9, '2024-08-09 18:45:00', '2024-08-12 20:45:00', 'MRW', 'MRW876543');
INSERT INTO Shipping (order_id, shipping_date, delivery_date, carrier, tracking_number) VALUES (10, '2024-08-10 19:00:00', '2024-08-13 21:00:00', 'GLS', 'GLS210987');

INSERT INTO Shipping (order_id, shipping_date, delivery_date, carrier, tracking_number) VALUES (1, '2024-08-01 13:00:00', '2024-08-03 15:00:00', 'SEUR', 'SEUR123456');
INSERT INTO Shipping (order_id, shipping_date, delivery_date, carrier, tracking_number) VALUES (2, '2024-08-02 15:00:00', '2024-08-05 17:00:00', 'Correos', 'CORREOS654321');
INSERT INTO Shipping (order_id, shipping_date, delivery_date, carrier, tracking_number) VALUES (3, '2024-08-03 16:00:00', '2024-08-06 18:00:00', 'DHL', 'DHL789012');
INSERT INTO Shipping (order_id, shipping_date, delivery_date, carrier, tracking_number) VALUES (4, '2024-08-04 09:30:00', '2024-08-07 11:30:00', 'MRW', 'MRW345678');
INSERT INTO Shipping (order_id, shipping_date, delivery_date, carrier, tracking_number) VALUES (5, '2024-08-05 11:45:00', '2024-08-08 13:45:00', 'GLS', 'GLS901234');
INSERT INTO Shipping (order_id, shipping_date, delivery_date, carrier, tracking_number) VALUES (6, '2024-08-06 13:00:00', '2024-08-09 15:00:00', 'SEUR', 'SEUR567890');
INSERT INTO Shipping (order_id, shipping_date, delivery_date, carrier, tracking_number) VALUES (7, '2024-08-07 15:15:00', '2024-08-10 17:15:00', 'Correos', 'CORREOS098765');
INSERT INTO Shipping (order_id, shipping_date, delivery_date, carrier, tracking_number) VALUES (8, '2024-08-08 17:30:00', '2024-08-11 19:30:00', 'DHL', 'DHL432109');
INSERT INTO Shipping (order_id, shipping_date, delivery_date, carrier, tracking_number) VALUES (9, '2024-08-09 18:45:00', '2024-08-12 20:45:00', 'MRW', 'MRW876543');
INSERT INTO Shipping (order_id, shipping_date, delivery_date, carrier, tracking_number) VALUES (10, '2024-08-10 19:00:00', '2024-08-13 21:00:00', 'GLS', 'GLS210987');

INSERT INTO ProductReview (product_id, customer_id, rating, review, review_date) VALUES (1, 1, 5, 'Excelente producto, muy recomendable.', '2024-08-01 10:00:00');
INSERT INTO ProductReview (product_id, customer_id, rating, review, review_date) VALUES (2, 2, 4, 'Buen producto, aunque el envío fue algo lento.', '2024-08-02 11:00:00');
INSERT INTO ProductReview (product_id, customer_id, rating, review, review_date) VALUES (3, 3, 3, 'Producto aceptable, cumple su función.', '2024-08-03 12:00:00');
INSERT INTO ProductReview (product_id, customer_id, rating, review, review_date) VALUES (4, 4, 2, 'No cumplió con mis expectativas.', '2024-08-04 13:00:00');
INSERT INTO ProductReview (product_id, customer_id, rating, review, review_date) VALUES (5, 5, 5, 'Me encanta, lo volveré a comprar.', '2024-08-05 14:00:00');
INSERT INTO ProductReview (product_id, customer_id, rating, review, review_date) VALUES (6, 6, 4, 'Buen producto por el precio.', '2024-08-06 15:00:00');
INSERT INTO ProductReview (product_id, customer_id, rating, review, review_date) VALUES (7, 7, 5, 'Excelente calidad y atención.', '2024-08-07 16:00:00');
INSERT INTO ProductReview (product_id, customer_id, rating, review, review_date) VALUES (8, 8, 3, 'Está bien, pero podría mejorar.', '2024-08-08 17:00:00');
INSERT INTO ProductReview (product_id, customer_id, rating, review, review_date) VALUES (9, 9, 4, 'Bueno en general, aunque el embalaje fue deficiente.', '2024-08-09 18:00:00');
INSERT INTO ProductReview (product_id, customer_id, rating, review, review_date) VALUES (10, 10, 5, 'Súper satisfecho con la compra.', '2024-08-10 19:00:00');

INSERT INTO Inventory (product_id, quantity, last_update) VALUES (1, 100, '2024-08-01 10:00:00');
INSERT INTO Inventory (product_id, quantity, last_update) VALUES (2, 50, '2024-08-02 11:00:00');
INSERT INTO Inventory (product_id, quantity, last_update) VALUES (3, 75, '2024-08-03 12:00:00');
INSERT INTO Inventory (product_id, quantity, last_update) VALUES (4, 200, '2024-08-04 13:00:00');
INSERT INTO Inventory (product_id, quantity, last_update) VALUES (5, 30, '2024-08-05 14:00:00');
INSERT INTO Inventory (product_id, quantity, last_update) VALUES (6, 60, '2024-08-06 15:00:00');
INSERT INTO Inventory (product_id, quantity, last_update) VALUES (7, 90, '2024-08-07 16:00:00');
INSERT INTO Inventory (product_id, quantity, last_update) VALUES (8, 120, '2024-08-08 17:00:00');
INSERT INTO Inventory (product_id, quantity, last_update) VALUES (9, 80, '2024-08-09 18:00:00');
INSERT INTO Inventory (product_id, quantity, last_update) VALUES (10, 40, '2024-08-10 19:00:00');

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

INSERT INTO Supplier (name, contact_name, phone, email, address, city, country) VALUES ('Proveedor A', 'Ana López', '123456789', 'ana@proveedora.com', 'Calle A 1', 'Madrid', 'España');
INSERT INTO Supplier (name, contact_name, phone, email, address, city, country) VALUES ('Proveedor B', 'Luis García', '987654321', 'luis@proveedorb.com', 'Calle B 2', 'Barcelona', 'España');
INSERT INTO Supplier (name, contact_name, phone, email, address, city, country) VALUES ('Proveedor C', 'Carlos Martínez', '555555555', 'carlos@proveedorc.com', 'Calle C 3', 'Valencia', 'España');
INSERT INTO Supplier (name, contact_name, phone, email, address, city, country) VALUES ('Proveedor D', 'Marta Sánchez', '666666666', 'marta@proveedord.com', 'Calle D 4', 'Sevilla', 'España');
INSERT INTO Supplier (name, contact_name, phone, email, address, city, country) VALUES ('Proveedor E', 'Javier Fernández', '777777777', 'javier@proveedore.com', 'Calle E 5', 'Bilbao', 'España');
INSERT INTO Supplier (name, contact_name, phone, email, address, city, country) VALUES ('Proveedor F', 'Laura Ruiz', '888888888', 'laura@proveedorf.com', 'Calle F 6', 'Murcia', 'España');
INSERT INTO Supplier (name, contact_name, phone, email, address, city, country) VALUES ('Proveedor G', 'Pedro Gómez', '999999999', 'pedro@proveedorg.com', 'Calle G 7', 'Alicante', 'España');
INSERT INTO Supplier (name, contact_name, phone, email, address, city, country) VALUES ('Proveedor H', 'Elena González', '101010101', 'elena@proveedorh.com', 'Calle H 8', 'Palma', 'España');
INSERT INTO Supplier (name, contact_name, phone, email, address, city, country) VALUES ('Proveedor I', 'Miguel Pérez', '202020202', 'miguel@proveedori.com', 'Calle I 9', 'Granada', 'España');
INSERT INTO Supplier (name, contact_name, phone, email, address, city, country) VALUES ('Proveedor J', 'Sofía Martínez', '303030303', 'sofia@proveedorj.com', 'Calle J 10', 'Zaragoza', 'España');

INSERT INTO ProductSupplier (product_id, supplier_id, supply_price, supply_date) VALUES (1, 1, 10.00, '2024-08-01 10:00:00');
INSERT INTO ProductSupplier (product_id, supplier_id, supply_price, supply_date) VALUES (2, 2, 15.00, '2024-08-02 11:00:00');
INSERT INTO ProductSupplier (product_id, supplier_id, supply_price, supply_date) VALUES (3, 3, 12.00, '2024-08-03 12:00:00');
INSERT INTO ProductSupplier (product_id, supplier_id, supply_price, supply_date) VALUES (4, 4, 20.00, '2024-08-04 13:00:00');
INSERT INTO ProductSupplier (product_id, supplier_id, supply_price, supply_date) VALUES (5, 5, 25.00, '2024-08-05 14:00:00');
INSERT INTO ProductSupplier (product_id, supplier_id, supply_price, supply_date) VALUES (6, 6, 18.00, '2024-08-06 15:00:00');
INSERT INTO ProductSupplier (product_id, supplier_id, supply_price, supply_date) VALUES (7, 7, 22.00, '2024-08-07 16:00:00');
INSERT INTO ProductSupplier (product_id, supplier_id, supply_price, supply_date) VALUES (8, 8, 17.00, '2024-08-08 17:00:00');
INSERT INTO ProductSupplier (product_id, supplier_id, supply_price, supply_date) VALUES (9, 9, 19.00, '2024-08-09 18:00:00');
INSERT INTO ProductSupplier (product_id, supplier_id, supply_price, supply_date) VALUES (10, 10, 30.00, '2024-08-10 19:00:00');


INSERT INTO LoyaltyProgram (name, description, points_per_dollar, start_date, end_date) VALUES ('Programa Oro', 'Programa de lealtad premium con mayores beneficios.', 1.50, '2024-01-01', '2024-12-31');
INSERT INTO LoyaltyProgram (name, description, points_per_dollar, start_date, end_date) VALUES ('Programa Plata', 'Programa de lealtad estándar con beneficios regulares.', 1.00, '2024-01-01', '2024-12-31');
INSERT INTO LoyaltyProgram (name, description, points_per_dollar, start_date, end_date) VALUES ('Programa Bronce', 'Programa de lealtad básico para nuevos clientes.', 0.75, '2024-01-01', '2024-12-31');
INSERT INTO LoyaltyProgram (name, description, points_per_dollar, start_date, end_date) VALUES ('Programa Especial', 'Programa temporal con puntos adicionales.', 2.00, '2024-05-01', '2024-08-31');
INSERT INTO LoyaltyProgram (name, description, points_per_dollar, start_date, end_date) VALUES ('Programa Verano', 'Programa de verano con beneficios estacionales.', 1.25, '2024-06-01', '2024-08-31');
INSERT INTO LoyaltyProgram (name, description, points_per_dollar, start_date, end_date) VALUES ('Programa Invierno', 'Programa de invierno con beneficios especiales.', 1.30, '2024-12-01', '2024-02-28');
INSERT INTO LoyaltyProgram (name, description, points_per_dollar, start_date, end_date) VALUES ('Programa Festivo', 'Programa de lealtad para la temporada navideña.', 1.40, '2024-11-01', '2024-12-31');
INSERT INTO LoyaltyProgram (name, description, points_per_dollar, start_date, end_date) VALUES ('Programa Aniversario', 'Programa para celebrar el aniversario de la tienda.', 1.20, '2024-09-01', '2024-10-31');
INSERT INTO LoyaltyProgram (name, description, points_per_dollar, start_date, end_date) VALUES ('Programa Exclusivo', 'Programa exclusivo para clientes VIP.', 2.50, '2024-07-01', '2024-12-31');
INSERT INTO LoyaltyProgram (name, description, points_per_dollar, start_date, end_date) VALUES ('Programa Acceso Anticipado', 'Programa con acceso anticipado a nuevos productos.', 1.75, '2024-03-01', '2024-06-30');

INSERT INTO CustomerLoyalty (customer_id, program_id, points) VALUES (1, 1, 500);
INSERT INTO CustomerLoyalty (customer_id, program_id, points) VALUES (2, 2, 300);
INSERT INTO CustomerLoyalty (customer_id, program_id, points) VALUES (3, 3, 150);
INSERT INTO CustomerLoyalty (customer_id, program_id, points) VALUES (4, 4, 400);
INSERT INTO CustomerLoyalty (customer_id, program_id, points) VALUES (5, 5, 250);
INSERT INTO CustomerLoyalty (customer_id, program_id, points) VALUES (6, 6, 100);
INSERT INTO CustomerLoyalty (customer_id, program_id, points) VALUES (7, 7, 600);
INSERT INTO CustomerLoyalty (customer_id, program_id, points) VALUES (8, 8, 200);
INSERT INTO CustomerLoyalty (customer_id, program_id, points) VALUES (9, 9, 350);
INSERT INTO CustomerLoyalty (customer_id, program_id, points) VALUES (10, 10, 450);

INSERT INTO GiftCard (code, balance, expiration_date) VALUES ('GIFT123456', 100.00, '2025-12-31');
INSERT INTO GiftCard (code, balance, expiration_date) VALUES ('GIFT654321', 50.00, '2025-12-31');
INSERT INTO GiftCard (code, balance, expiration_date) VALUES ('GIFT789012', 75.00, '2025-12-31');
INSERT INTO GiftCard (code, balance, expiration_date) VALUES ('GIFT345678', 20.00, '2025-12-31');
INSERT INTO GiftCard (code, balance, expiration_date) VALUES ('GIFT901234', 150.00, '2025-12-31');
INSERT INTO GiftCard (code, balance, expiration_date) VALUES ('GIFT567890', 80.00, '2025-12-31');
INSERT INTO GiftCard (code, balance, expiration_date) VALUES ('GIFT098765', 60.00, '2025-12-31');
INSERT INTO GiftCard (code, balance, expiration_date) VALUES ('GIFT432109', 90.00, '2025-12-31');
INSERT INTO GiftCard (code, balance, expiration_date) VALUES ('GIFT876543', 110.00, '2025-12-31');
INSERT INTO GiftCard (code, balance, expiration_date) VALUES ('GIFT210987', 40.00, '2025-12-31');

INSERT INTO GiftCardTransaction (giftcard_id, order_id, amount, transaction_date) VALUES (1, 1, 20.00, '2024-08-01');
INSERT INTO GiftCardTransaction (giftcard_id, order_id, amount, transaction_date) VALUES (2, 2, 15.00, '2024-08-02');
INSERT INTO GiftCardTransaction (giftcard_id, order_id, amount, transaction_date) VALUES (3, 3, 30.00, '2024-08-03');
INSERT INTO GiftCardTransaction (giftcard_id, order_id, amount, transaction_date) VALUES (4, 4, 10.00, '2024-08-04');
INSERT INTO GiftCardTransaction (giftcard_id, order_id, amount, transaction_date) VALUES (5, 5, 50.00, '2024-08-05');
INSERT INTO GiftCardTransaction (giftcard_id, order_id, amount, transaction_date) VALUES (6, 6, 25.00, '2024-08-06');
INSERT INTO GiftCardTransaction (giftcard_id, order_id, amount, transaction_date) VALUES (7, 7, 35.00, '2024-08-07');
INSERT INTO GiftCardTransaction (giftcard_id, order_id, amount, transaction_date) VALUES (8, 8, 40.00, '2024-08-08');
INSERT INTO GiftCardTransaction (giftcard_id, order_id, amount, transaction_date) VALUES (9, 9, 45.00, '2024-08-09');
INSERT INTO GiftCardTransaction (giftcard_id, order_id, amount, transaction_date) VALUES (10, 10, 60.00, '2024-08-10');






