CREATE FUNCTION fn_search_extras_by_name (
    @Search NVARCHAR(50)
)
RETURNS TABLE
AS
RETURN (
    SELECT id, name, description, unit_price
    FROM extra
    WHERE name LIKE '%' + @Search + '%'
);
GO

SELECT * FROM dbo.fn_search_extras_by_name('Asiento de cuero');