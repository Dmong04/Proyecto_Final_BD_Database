CREATE FUNCTION fn_FinalPrice
(
    @unit_price DECIMAL(10,2), 
    @discount DECIMAL(5,2)
)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @priceWithIVA DECIMAL(10,2);
    DECLARE @finalPrice DECIMAL(10,2);

    -- Aca se aplica el IVA
    SET @priceWithIVA = @unit_price * 1.13;

    -- Aplicar descuento si se pide
    IF @discount > 0
        SET @finalPrice = @priceWithIVA - (@priceWithIVA * (@discount / 100));
    ELSE
        SET @finalPrice = @priceWithIVA;

    -- y por ultimo retorna el valor
    RETURN @finalPrice;
END;
GO
