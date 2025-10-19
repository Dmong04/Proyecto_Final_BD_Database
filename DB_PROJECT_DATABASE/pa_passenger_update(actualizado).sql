USE [coco_tours_db]
GO

/****** Object:  StoredProcedure [dbo].[pa_passenger_update]    Script Date: 8/10/2025 00:12:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[pa_passenger_update](
 @passenger_id INT,
 @name VARCHAR(50),
 @age INT,
 @tour_detail_id INT
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

  IF NOT EXISTS (SELECT 1 FROM tour_detail WHERE id = @tour_detail_id)
 BEGIN
    RAISERROR ('El detalle de tour no existe',16, 1)
   RETURN
 END

 UPDATE passengers
 SET [name] = @name,
     age = @age,
     tour_detail_id = @tour_detail_id
 WHERE id = @passenger_id;

END TRY
BEGIN CATCH
    DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
    RAISERROR(@ErrorMessage,16,1);
END CATCH
END
GO

