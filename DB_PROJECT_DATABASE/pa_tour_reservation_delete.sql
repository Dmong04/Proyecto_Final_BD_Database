USE coco_tours_db
GO

CREATE PROCEDURE pa_tour_details_reservation_delete (
	@tour_detail_id INT
) AS
BEGIN
	SET NOCOUNT ON
	BEGIN TRY

		IF NOT EXISTS (SELECT 1 FROM tour_detail WHERE id = @tour_detail_id)
		BEGIN
			RAISERROR('El detalle de tour no existe', 16, 1)
			RETURN
		END

		DELETE FROM tour_detail WHERE id = @tour_detail_id
	END TRY
	BEGIN CATCH
		DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
		RAISERROR(@ErrorMessage,16,1);
	END CATCH
END
GO