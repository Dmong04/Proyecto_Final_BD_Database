CREATE PROCEDURE pa_backup_db
AS
BEGIN
  DECLARE @file_name NVARCHAR(200);
  SET @file_name = 'C:\Backup\coco_tours_' + 
                       CONVERT(VARCHAR(20), GETDATE(), 112) + '.bak';

  BACKUP DATABASE coco_tours_db
  TO DISK = @file_name
  WITH INIT;

  PRINT 'Respaldo completado: ' + @file_name;
END;
GO