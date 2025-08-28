USE coco_tours_db
GO

CREATE PROCEDURE pa_passenger_update(
 @passenger_id INT,
 @name VARCHAR(50),
 @age INT
)AS
BEGIN
BEGIN TRY

 IF NOT EXISTS (SELECT 1 FROM passengers WHERE id = @passenger_id)
 BEGIN
    RAISERROR ('El pasajero no existe',16,1)
    RETURN
 END


 IF @name IS NULL OR @name = ''
 BEGIN
  RAISERROR ('El nombre no puede ser un valor vacío',16, 1)
  RETURN
 END

 IF @age <= 0
 BEGIN
   RAISERROR ('La edad debe ser un número válido',16, 1)
   RETURN
 END

 UPDATE passengers
 SET [name] = @name,
     age = @age
 WHERE id = @passenger_id;

END TRY
BEGIN CATCH
    DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
    RAISERROR(@ErrorMessage,16,1);
END CATCH
END
GO