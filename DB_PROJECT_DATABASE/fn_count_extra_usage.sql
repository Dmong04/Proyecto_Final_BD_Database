CREATE FUNCTION fn_count_extra_usage()
RETURNS @Extras TABLE (
    id INT,
    name VARCHAR(40),
    times_used INT
)
AS
BEGIN
    INSERT INTO @Extras
    SELECT 
        e.id,
        e.name,
        COUNT(ed.id) AS times_used
    FROM extra AS e
    LEFT JOIN extra_detail AS ed ON e.id = ed.extra_id
    GROUP BY e.id, e.name;

    RETURN;
END;
GO

SELECT * FROM dbo.fn_count_extra_usage();