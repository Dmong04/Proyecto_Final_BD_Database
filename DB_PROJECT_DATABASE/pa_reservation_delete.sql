USE coco_tours_db
GO

CREATE PROCEDURE pa_reservation_delete (
	@reservation_id INT
) AS
BEGIN
SET NOCOUNT ON
BEGIN TRY

	IF NOT EXISTS (SELECT 1 FROM reservations WHERE id = @reservation_id)
	BEGIN
		RAISERROR('La reservación no existe', 16, 1)
		RETURN
	END

	DELETE FROM reservations WHERE id = @reservation_id

END TRY
BEGIN CATCH
	RAISERROR('Ha ocurrido un error al eliminar la reservación', 16, 1)
	RETURN
END CATCH
END
GO