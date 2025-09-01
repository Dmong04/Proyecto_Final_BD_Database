USE coco_tours_db
GO

CREATE PROCEDURE pa_admin_delete(
 @user_id INT
)AS
BEGIN
BEGIN TRY
 

 IF NOT EXISTS(SELECT 1 FROM [user] WHERE id = @user_id AND [role] = 'ADMIN')
 BEGIN
  RAISERROR('El usuario administrador no existe', 16, 1)
  RETURN
 END
 --
 BEGIN TRANSACTION
 DECLARE @admin_id INT
 SELECT @admin_id = a.id FROM administrator AS a INNER JOIN [user] AS u ON a.id = u.admin_id
		WHERE u.id = @user_id
DELETE FROM [user] WHERE id = @user_id
DELETE FROM administrator WHERE id = @admin_id
 COMMIT TRANSACTION
 --

END TRY
BEGIN CATCH
 DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE()
 RAISERROR(@ErrorMessage, 16, 1)
 RETURN
END CATCH
END
GO