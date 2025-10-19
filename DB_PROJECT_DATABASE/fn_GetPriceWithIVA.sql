CREATE FUNCTION fn_GetPriceWithIVA (@unit_price DECIMAL(10,2))
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @priceWithIVA DECIMAL(10,2);
    SET @priceWithIVA = @unit_price * 1.13;
    RETURN @priceWithIVA;
END;
GO