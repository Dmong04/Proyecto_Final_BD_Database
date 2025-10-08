use coco_tours_db
go

CREATE FUNCTION fn_classify_extras()
RETURNS @Extras TABLE (
    id INT,
    name VARCHAR(40),
    description VARCHAR(100),
    unit_price DECIMAL(10,2),
    categoria VARCHAR(20)
)
AS
BEGIN
    INSERT INTO @Extras
    SELECT 
        id,
        name,
        description,
        unit_price,
        CASE 
            WHEN unit_price < 50 THEN 'Barato'
            WHEN unit_price BETWEEN 50 AND 100 THEN 'Medio'
            ELSE 'Caro'
        END AS categoria
    FROM extra;

    RETURN;
END;
GO

SELECT * FROM dbo.fn_classify_extras();