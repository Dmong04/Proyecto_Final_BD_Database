USE coco_tours_db
GO

CREATE PROCEDURE pa_client_delete(
 @user_id INT
)AS
BEGIN
BEGIN TRY
 
 --validation
 IF NOT EXISTS(SELECT 1 FROM [user] WHERE id = @user_id AND [role] = 'CLIENT')
 BEGIN
  RAISERROR('El cliente no existe', 16, 1)
  RETURN
 END
 --
 BEGIN TRANSACTION
 DECLARE @client_id INT
 SELECT @client_id = c.id FROM client AS c INNER JOIN [user] AS u ON C.id = u.client_id
 WHERE u.id = @user_id
  DELETE FROM client_phones WHERE client_id = @client_id;

  DELETE FROM [user] WHERE id = @user_id;

  DELETE FROM client WHERE id = @client_id;

 COMMIT TRANSACTION

END TRY
BEGIN CATCH
 DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE()
 RAISERROR(@ErrorMessage, 16, 1)
 RETURN
END CATCH
END
GO