# **PreEntrega1-SQL**
**Primer entregable curso CoderHouse comisión 57190  
Profesor Anderson Ocaña**

# **Descripción:**
Esta base de datos está diseñada para gestionar una tienda de ropa en línea. La base de datos almacenará información sobre los productos disponibles, los clientes que compran en la tienda, los pedidos realizados por los clientes, y los detalles de cada pedido.

# **Diagrama de entidad relación de la base de datos** (dejo un pdf con el diagrama hecho en dbdiagram.io)

```plaintext
+-------------------+       +-----------------+        +------------------------+
|      Product      |       |   ProductCategory |      |         Customer       |
+-------------------+       +-----------------+        +------------------------+
| product_id        |       | category_id     |        | customer_id            |
| name              |  +--->| name            |        | first_name             |
| description       |       +-----------------+        | last_name              |
| price             |                                  | email                  |
| stock             |                                  | phone                  |
| category_id  -----+                                  +------------------------+

+------------------------+      +------------------+      +------------------------+
|   CustomerAddress      |      |      Order       |      |     OrderDetail        |
+------------------------+      +------------------+      +------------------------+
| address_id             |      | order_id         |      | order_detail_id        |
| customer_id   ---------+--->  | customer_id      |      | order_id               |
| address                |      | order_date       |      | product_id             |
| city                   |      | status           |      | quantity               |
| state                  |      +------------------+      | price                  |
| postal_code            |                                +------------------------+
| country                |                               
                                                         
+------------------------+      +-------------------+     +------------------------+
|     PaymentMethod      |      |     Shipping      |     |      ProductReview      |
+------------------------+      +-------------------+     +------------------------+
| payment_id             |      | shipping_id       |     | review_id               |
| method                 |      | order_id          |     | product_id              |
+------------------------+      | shipping_date     |     | customer_id             |
                                | delivery_date     |     | rating                  |
                                | carrier           |     | review                  |
                                | tracking_number   |     | review_date             |
                                +-------------------+     +------------------------+

+------------------------+      +------------------------+      +------------------------+ 
|       Discount         |      |       Inventory        |      |       Supplier         |
+------------------------+      +------------------------+      +------------------------+ 
| discount_id            |      | inventory_id           |      | supplier_id            |
| code                   |      | product_id             |      | name                   |
| description            |      | quantity               |      | contact_name           |
| discount_percentage    |      | last_update            |      | contact_phone          |
| start_date             |      +------------------------+      | address                |
| end_date               |                                      | city                   |
+------------------------+                                      | postal_code            |
                                                                | country                |
                                                                +------------------------+

+------------------------+      +------------------------+  
|     ProductSupplier    |      |       Wishlist         |  
+------------------------+      +------------------------+  
| product_supplier_id    |      | wishlist_id            |  
| product_id             |      | customer_id            |  
| supplier_id            |      | product_id             |  
| supply_price           |      +------------------------+  
| supply_date            |  
+------------------------+  

# Listado de las tablas que comprenden la base de datos

## Tabla: Categoría de Producto (ProductCategory)
- **Descripción:** Almacena información sobre las categorías de los productos.
- **Campos:**
  - `category_id` (ID de la categoría, tipo: INT, clave primaria)
  - `name` (Nombre de la categoría, tipo: VARCHAR(255))

## Tabla: Producto (Product)
- **Descripción:** Almacena información sobre los productos de la tienda.
- **Campos:**
  - `product_id` (ID del producto, tipo: INT, clave primaria)
  - `name` (Nombre del producto, tipo: VARCHAR(255))
  - `description` (Descripción del producto, tipo: TEXT)
  - `price` (Precio del producto, tipo: DECIMAL(10, 2))
  - `stock` (Stock del producto, tipo: INT)
  - `category_id` (ID de la categoría, tipo: INT, clave foránea)

## Tabla: Cliente (Customer)
- **Descripción:** Almacena información sobre los clientes de la tienda.
- **Campos:**
  - `customer_id` (ID del cliente, tipo: INT, clave primaria)
  - `first_name` (Nombre del cliente, tipo: VARCHAR(255))
  - `last_name` (Apellido del cliente, tipo: VARCHAR(255))
  - `email` (Email del cliente, tipo: VARCHAR(255))
  - `phone` (Teléfono del cliente, tipo: VARCHAR(20))

## Tabla: Dirección del Cliente (CustomerAddress)
- **Descripción:** Almacena las direcciones de los clientes.
- **Campos:**
  - `address_id` (ID de la dirección, tipo: INT, clave primaria)
  - `customer_id` (ID del cliente, tipo: INT, clave foránea)
  - `address` (Dirección, tipo: VARCHAR(255))
  - `city` (Ciudad, tipo: VARCHAR(100))
  - `state` (Estado, tipo: VARCHAR(100))
  - `postal_code` (Código postal, tipo: VARCHAR(20))
  - `country` (País, tipo: VARCHAR(100))

## Tabla: Pedido (Order)
- **Descripción:** Almacena información sobre los pedidos realizados por los clientes.
- **Campos:**
  - `order_id` (ID del pedido, tipo: INT, clave primaria)
  - `customer_id` (ID del cliente, tipo: INT, clave foránea)
  - `order_date` (Fecha del pedido, tipo: DATETIME)
  - `status` (Estado del pedido, tipo: VARCHAR(50))

## Tabla: Detalle del Pedido (OrderDetail)
- **Descripción:** Almacena información sobre los productos incluidos en los pedidos.
- **Campos:**
  - `order_detail_id` (ID del detalle del pedido, tipo: INT, clave primaria)
  - `order_id` (ID del pedido, tipo: INT, clave foránea)
  - `product_id` (ID del producto, tipo: INT, clave foránea)
  - `quantity` (Cantidad del producto, tipo: INT)
  - `price` (Precio del producto, tipo: DECIMAL(10, 2))

## Tabla: Método de Pago (PaymentMethod)
- **Descripción:** Almacena información sobre los métodos de pago.
- **Campos:**
  - `payment_id` (ID del método de pago, tipo: INT, clave primaria)
  - `method` (Método de pago, tipo: VARCHAR(255))

## Tabla: Envío (Shipping)
- **Descripción:** Almacena información sobre los envíos de los pedidos.
- **Campos:**
  - `shipping_id` (ID del envío, tipo: INT, clave primaria)
  - `order_id` (ID del pedido, tipo: INT, clave foránea)
  - `shipping_date` (Fecha de envío, tipo: DATETIME)
  - `delivery_date` (Fecha de entrega, tipo: DATETIME)
  - `carrier` (Transportista, tipo: VARCHAR(255))
  - `tracking_number` (Número de seguimiento, tipo: VARCHAR(255))

## Tabla: Descuentos y Promociones (Discount)
- **Descripción:** Almacena información sobre los descuentos y promociones.
- **Campos:**
  - `discount_id` (ID del descuento, tipo: INT, clave primaria)
  - `code` (Código de descuento, tipo: VARCHAR(50))
  - `description` (Descripción del descuento, tipo: VARCHAR(255))
  - `discount_percentage` (Porcentaje de descuento, tipo: DECIMAL(5, 2))
  - `start_date` (Fecha de inicio, tipo: DATETIME)
  - `end_date` (Fecha de finalización, tipo: DATETIME)

## Tabla: Reseñas de Productos (ProductReview)
- **Descripción:** Almacena las reseñas de los productos hechas por los clientes.
- **Campos:**
  - `review_id` (ID de la reseña, tipo: INT, clave primaria)
  - `product_id` (ID del producto, tipo: INT, clave foránea)
  - `customer_id` (ID del cliente, tipo: INT, clave foránea)
  - `rating` (Calificación, tipo: INT)
  - `review` (Reseña, tipo: TEXT)
  - `review_date` (Fecha de la reseña, tipo: DATETIME)

## Tabla: Inventario (Inventory)
- **Descripción:** Almacena información sobre el inventario de los productos.
- **Campos:**
  - `inventory_id` (ID del inventario, tipo: INT, clave primaria)
  - `product_id` (ID del producto, tipo: INT, clave foránea)
  - `quantity` (Cantidad en inventario, tipo: INT)
  - `last_update` (Fecha de la última actualización, tipo: DATETIME)

## Tabla: Proveedor (Supplier)
- **Descripción:** Almacena información sobre los proveedores de los productos.
- **Campos:**
  - `supplier_id` (ID del proveedor, tipo: INT, clave primaria)
  - `name` (Nombre del proveedor, tipo: VARCHAR(255))
  - `contact_name` (Nombre del contacto, tipo: VARCHAR(255))
  - `contact_phone` (Teléfono de contacto, tipo: VARCHAR(20))
  - `address` (Dirección, tipo: VARCHAR(255))
  - `city` (Ciudad, tipo: VARCHAR(100))
  - `postal_code` (Código postal, tipo: VARCHAR(20))
  - `country` (País, tipo: VARCHAR(100))

## Tabla: Proveedor de Producto (ProductSupplier)
- **Descripción:** Almacena información sobre los proveedores de productos.
- **Campos:**
  - `product_supplier_id` (ID del proveedor de producto, tipo: INT, clave primaria)
  - `product_id` (ID del producto, tipo: INT, clave foránea)
  - `supplier_id` (ID del proveedor, tipo: INT, clave foránea)
  - `supply_price` (Precio de suministro, tipo: DECIMAL(10, 2))
  - `supply_date` (Fecha de suministro, tipo: DATETIME)

## Tabla: Lista de Deseos (Wishlist)
- **Descripción:** Almacena información sobre las listas de deseos de los clientes.
- **Campos:**
  - `wishlist_id` (ID de la lista de deseos, tipo: INT, clave primaria)
  - `customer_id` (ID del cliente, tipo: INT, clave foránea)
  - `product_id` (ID del producto, tipo: INT, clave foránea)

