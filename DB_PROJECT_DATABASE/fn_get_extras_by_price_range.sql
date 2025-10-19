USE coco_tours_db
GO
CREATE FUNCTION fn_get_extras_by_price_range (
    @MinPrice DECIMAL(10,2),
    @MaxPrice DECIMAL(10,2)
)
RETURNS TABLE
AS
RETURN (
    SELECT id, name, description, unit_price
    FROM extra
    WHERE unit_price BETWEEN @MinPrice AND @MaxPrice
);
GO

SELECT * FROM dbo.fn_get_extras_by_price_range(10.00, 200.00);