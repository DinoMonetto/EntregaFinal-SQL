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