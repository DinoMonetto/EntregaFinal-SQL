-- Función: Calcular Precio con Descuento
DELIMITER //

CREATE FUNCTION CalcularPrecioDescuento(
    precio_original DECIMAL(10,2),
    porcentaje_descuento DECIMAL(5,2)
) RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE precio_descuento DECIMAL(10,2);
    SET precio_descuento = precio_original - (precio_original * porcentaje_descuento / 100);
    IF precio_descuento < 0 THEN
        SET precio_descuento = 0;
    END IF;
    RETURN precio_descuento;
END //

DELIMITER ;