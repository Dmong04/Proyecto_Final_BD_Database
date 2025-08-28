USE coco_tours_db
GO

CREATE PROCEDURE pa_tour_details_reservation_update (
	@tour_detail_id INT,
	@origin VARCHAR(40),
	@destination VARCHAR(40),
	@tour_id INT,
	@reservation_id INT
) AS
BEGIN
	SET NOCOUNT ON
	BEGIN TRY

		IF NOT EXISTS (SELECT 1 FROM tour_detail WHERE id = @tour_detail_id)
		BEGIN
			RAISERROR('El detalle de tour no existe', 16, 1)
			RETURN
		END

		IF @origin IS NULL OR LTRIM(RTRIM(@origin)) = ''
		BEGIN
			RAISERROR('El lugar de origen no puede estar vacío', 16, 1)
			RETURN
		END


		IF @destination IS NULL OR LTRIM(RTRIM(@destination)) = ''
		BEGIN
			RAISERROR('El lugar de destino no puede estar vacío', 16, 1)
			RETURN
		END


		IF NOT EXISTS (SELECT 1 FROM tour WHERE id = @tour_id)
		BEGIN
			RAISERROR('El tour no existe', 16, 1)
			RETURN
		END


		IF NOT EXISTS (SELECT 1 FROM reservations WHERE id = @reservation_id)
		BEGIN
			RAISERROR('La reservación no existe', 16, 1)
			RETURN
		END

		UPDATE tour_detail
		SET origin = @origin,
			destination = @destination,
			tour_id = @tour_id,
			reservation_id = @reservation_id
		WHERE id = @tour_detail_id
	END TRY
	BEGIN CATCH
		DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
		RAISERROR(@ErrorMessage,16,1);
	END CATCH
END
GO