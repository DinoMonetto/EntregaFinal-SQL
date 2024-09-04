# **EntregaFinal-SQL**
**Entrega Final del curso CoderHouse comisión 57190  
Profesor Anderson Ocaña**

# **Descripción:**
Esta base de datos está diseñada para gestionar una tienda de ropa en línea. La base de datos almacenará información sobre los productos disponibles, los clientes que compran en la tienda, los pedidos realizados por los clientes, y los detalles de cada pedido.

# **Introducción**
Este documento proporciona una descripción detallada del esquema de la base de datos para la gestión de una tienda de ropa en línea. Incluye un diagrama de entidad-relación (ER), una lista de tablas con sus respectivos campos y una guía para la instalación y configuración de la base de datos. Este proyecto tiene como objetivo gestionar de manera eficiente productos, clientes, pedidos, y otros aspectos clave de la tienda, permitiendo una administración efectiva de inventarios, ventas y clientes.

# **Objetivo**
El objetivo de este proyecto es implementar una base de datos relacional que permita gestionar todos los aspectos relacionados con una tienda de ropa en línea. Esto incluye la administración de productos, categorías, clientes, pedidos, direcciones de envío, métodos de pago, y otros componentes relevantes. La base de datos está diseñada para facilitar la gestión eficiente de inventarios, realizar un seguimiento de los pedidos y proporcionar una base sólida para futuras integraciones y funcionalidades adicionales.


# **Diagrama de entidad relación de la base de datos** (dejo un pdf con el diagrama hecho en dbdiagram.io)

```
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
|     Discount           |      |       Inventory        |      |       Supplier         |
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

+------------------------+      +------------------------+      +------------------------+  
|  CustomerLoyalty       |      |       GiftCard         |      |   LoyaltyProgram       |  
+------------------------+      +------------------------+      +------------------------+  
| loyalty_id             |      | gift_card_id           |      | loyalty_program_id     |  
| customer_id            |      | code                   |      | name                   |  
| loyalty_points         |      | balance                |      | description            |  
| last_update            |      | issue_date             |      | points_required        |  
+------------------------+      | expiration_date        |      +------------------------+  
                                 | customer_id            |  
                                 +------------------------+  

+------------------------+  
| GiftCardTransaction    |  
+------------------------+  
| transaction_id         |  
| gift_card_id           |  
| transaction_date       |  
| amount                 |  
| transaction_type       |  
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
  - `minimum_purchase_amount` (Monto mínimo de compra requerido, tipo: DECIMAL(10, 2))
  - `status` (Estado del descuento, tipo VARCHAR(50) NOT NULL)
  
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

## Tabla: Lealtad del Cliente (CustomerLoyalty)
- **Descripción:** Almacena información sobre los puntos de lealtad de los clientes.
- **Campos:**
  - `loyalty_id` (ID de lealtad, tipo: INT, clave primaria)
  - `customer_id` (ID del cliente, tipo: INT, clave foránea)
  - `loyalty_points` (Puntos de lealtad, tipo: INT)
  - `last_update` (Última actualización, tipo: DATETIME)

## Tabla: Tarjeta de Regalo (GiftCard)
- **Descripción:** Almacena información sobre las tarjetas de regalo.
- **Campos:**
  - `gift_card_id` (ID de la tarjeta de regalo, tipo: INT, clave primaria)
  - `code` (Código de la tarjeta, tipo: VARCHAR(50))
  - `balance` (Saldo de la tarjeta, tipo: DECIMAL(10, 2))
  - `issue_date` (Fecha de emisión, tipo: DATETIME)
  - `expiration_date` (Fecha de vencimiento, tipo: DATETIME)
  - `customer_id` (ID del cliente, tipo: INT, clave foránea)

## Tabla: Programa de Lealtad (LoyaltyProgram)
- **Descripción:** Almacena información sobre los programas de lealtad.
- **Campos:**
  - `loyalty_program_id` (ID del programa de lealtad, tipo: INT, clave primaria)
  - `name` (Nombre del programa, tipo: VARCHAR(255))
  - `description` (Descripción del programa, tipo: VARCHAR(255))
  - `points_required` (Puntos requeridos, tipo: INT)

## Tabla: Transacción de Tarjeta de Regalo (GiftCardTransaction)
- **Descripción:** Almacena información sobre las transacciones realizadas con tarjetas de regalo.
- **Campos:**
  - `transaction_id` (ID de la transacción, tipo: INT, clave primaria)
  - `gift_card_id` (ID de la tarjeta de regalo, tipo: INT, clave foránea)
  - `transaction_date` (Fecha de la transacción, tipo: DATETIME)
  - `amount` (Monto de la transacción, tipo: DECIMAL(10, 2))
  - `transaction_type` (Tipo de transacción, tipo: VARCHAR(50))



## **Instrucciones de Ejecución**

1. **Instalación y Configuración**:
   - Asegúrate de tener MySQL instalado en tu sistema.
   - Crea una base de datos llamada `TiendaRopa` si no existe.
   - Conéctate a tu servidor MySQL usando un cliente como MySQL Workbench o la línea de comandos.

2. **Ejecución de Scripts SQL**:
   - Descarga el archivo `Tables-Database.sql` proporcionado.
   - Ejecuta el script SQL en el cliente de base de datos.
     ```sql
     source path/to/your/Tables-Database.sql;
     ```

3. **Estructura del Proyecto**:
   - Asegúrate de que todos los scripts SQL estén organizados en carpetas según su función (e.g., `tables`, `views`, `procedures`, etc.).
   - La estructura modular del proyecto ayuda a evitar un código "espagueti" y facilita el mantenimiento y actualización.

4. **Archivos CSV y SQL**:
   - Si tenes archivos CSV con datos iniciales, asegúrate de que coincidan con el esquema de la base de datos antes de importarlos (en mi caso no pude hacerlo de ninguna forma, tuve que hacerlo manual uno por uno).
   - Utiliza comandos de MySQL como `LOAD DATA INFILE` para importar datos desde CSV si es necesario.

5. **Documentación Adicional**:
   - Consulta el diagrama ER en formato PDF para una visualización gráfica de las relaciones entre tablas.
   - Lee el archivo `README.md` y `Tables-Database.sql` para detalles adicionales sobre el esquema y las relaciones.

## Módulos y Organización del Código

Para garantizar una estructura modular, los siguientes módulos deben ser implementados y organizados adecuadamente:

- **Módulos de Datos**: Scripts para la creación de tablas, vistas, procedimientos almacenados y triggers.
- **Módulos de Importación**: Scripts para importar datos desde archivos CSV u otros formatos (en mi caso no pude hacerlo de ninguna forma, tuve que hacerlo manual uno por uno).
- **Módulos de Funcionalidad**: Scripts y procedimientos que gestionan la lógica del negocio (e.g., cálculos de descuento, actualizaciones de stock).

---