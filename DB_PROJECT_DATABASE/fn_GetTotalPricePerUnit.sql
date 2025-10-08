USE coco_tours_db
GO

CREATE FUNCTION fn_GetTotalPrice
(
    @unit_price DECIMAL(10,2), 
    @quantity INT
)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @total DECIMAL(10,2);

    SET @total = @unit_price * @quantity;

    RETURN @total;
END;
GO


SELECT 
    name,
    unit_price,
    dbo.fn_GetTotalPrice(unit_price, 3) AS total_por_3
FROM extra;