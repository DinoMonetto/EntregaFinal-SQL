-- Trigger: Actualizar Stock Después de un Pedido
DELIMITER //

CREATE TRIGGER UpdateStockAfterOrder
AFTER INSERT ON OrderDetail
FOR EACH ROW
BEGIN
    IF (SELECT stock FROM Product WHERE product_id = NEW.product_id) >= NEW.quantity THEN
        UPDATE Product
        SET stock = stock - NEW.quantity
        WHERE product_id = NEW.product_id;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Stock insuficiente';
    END IF;
END //

DELIMITER ;