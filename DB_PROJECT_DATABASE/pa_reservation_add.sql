USE coco_tours_db
GO

CREATE PROCEDURE pa_reservation_insert (
    @date DATE = NULL,
    @time TIME = NULL,
    @description VARCHAR(100) = NULL,
    @user_id INT = NULL
) AS BEGIN
SET NOCOUNT ON
BEGIN TRY
    DECLARE @reservation_datetime DATETIME2 = DATETIMEFROMPARTS(
        YEAR(@date), MONTH(@date), DAY(@date),
        DATEPART(HOUR, @time), DATEPART(MINUTE, @time), DATEPART(SECOND, @time), 0
    )

    IF (@reservation_datetime < SYSDATETIME())
    BEGIN
        RAISERROR('La fecha y la hora que se ingresaron no son válidas', 16, 1)
        RETURN
    END

    INSERT INTO reservations ([date], [time], [description], [user_id])
    VALUES (@date, @time, @description, @user_id)

    SELECT SCOPE_IDENTITY() AS reservation_id
END TRY
BEGIN CATCH
SELECT NULL AS reservation_id
    RAISERROR('Ha ocurrido un error en el proceso, revise los datos nuevamente', 16, 1)
    RETURN
END CATCH
END
