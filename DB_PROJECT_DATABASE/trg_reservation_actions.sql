CREATE TRIGGER trg_auditing_reservations
ON reservations
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
 
 DECLARE @user VARCHAR(100) = SUSER_SNAME();

 INSERT INTO auditing (table_affected, action_taken, id_registration, user_)
 SELECT 'reservations', 'INSERT', CAST(I.id AS VARCHAR), @user 
 FROM inserted AS I

 INSERT INTO auditing (table_affected, action_taken, id_registration, user_)
 SELECT 'reservations', 'UPDATE', CAST(I.id AS VARCHAR), @user 
 FROM inserted AS I
 INNER JOIN deleted AS D ON I.id = D.id;

 INSERT INTO auditing (table_affected, action_taken, id_registration, user_)
 SELECT 'reservations', 'DELETE', CAST(D.id AS VARCHAR), @user 
 FROM deleted AS D

END;
GO