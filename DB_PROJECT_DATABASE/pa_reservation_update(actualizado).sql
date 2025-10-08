USE [coco_tours_db]
GO

/****** Object:  StoredProcedure [dbo].[pa_reservation_update]    Script Date: 7/10/2025 21:08:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[pa_reservation_update] (
	@reservation_id INT,
	@date DATE = NULL,
	@time TIME = NULL,
	@description VARCHAR(100) = NULL,
	@user_id INT = NULL
) AS
BEGIN
SET NOCOUNT ON
BEGIN TRY

	IF NOT EXISTS (SELECT 1 FROM reservations WHERE id = @reservation_id)
	BEGIN
		RAISERROR('La reservación no existe', 16, 1)
		RETURN
	END

	IF @date IS NOT NULL AND @time IS NOT NULL
	BEGIN
		DECLARE @reservation_datetime DATETIME2 = CAST(@date AS DATETIME) + CAST(@time AS DATETIME)
		IF @reservation_datetime < SYSDATETIME()
		BEGIN
			RAISERROR('La fecha y la hora que se ingresaron no son válidas', 16, 1)
			RETURN
		END
	END


	UPDATE reservations
	SET [date] = ISNULL(@date, [date]),
		[time] = ISNULL(@time, [time]),
		[description] = ISNULL(@description, [description]),
		[user_id] = ISNULL(@user_id, [user_id])
	WHERE id = @reservation_id

END TRY
BEGIN CATCH
    DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
    DECLARE @ErrorNumber INT = ERROR_NUMBER();
    DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
    RAISERROR('Error %d: %s', @ErrorSeverity, 1, @ErrorNumber, @ErrorMessage);
	
	RETURN
END CATCH
END
GO

