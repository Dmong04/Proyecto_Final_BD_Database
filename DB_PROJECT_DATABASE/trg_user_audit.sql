CREATE TRIGGER trg_user_audit
ON [user]
AFTER INSERT, UPDATE, DELETE
AS
BEGIN

 DECLARE @operation VARCHAR(10);

 IF EXISTS(SELECT * FROM inserted) AND EXISTS(SELECT * FROM deleted)
  SET @operation = 'UPDATE';
 ELSE IF EXISTS(SELECT * FROM inserted)
  SET @operation = 'INSERT'
 ELSE 

END;
GO