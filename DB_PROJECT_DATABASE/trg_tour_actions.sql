CREATE TRIGGER trg_auditing_tour_detail
ON tour_detail
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
 
 DECLARE @user VARCHAR(100) = SUSER_SNAME();

 INSERT INTO auditing (table_affected, action_taken, id_registration, user_)
 SELECT 'tour_detail', 'INSERT', CAST(I.id AS VARCHAR), @user 
 FROM inserted AS I

 INSERT INTO auditing (table_affected, action_taken, id_registration, user_)
 SELECT 'tour_detail', 'UPDATE', CAST(I.id AS VARCHAR), @user 
 FROM inserted AS I
 INNER JOIN deleted AS D ON I.id = D.id;

 INSERT INTO auditing (table_affected, action_taken, id_registration, user_)
 SELECT 'tour_detail', 'DELETE', CAST(D.id AS VARCHAR), @user 
 FROM deleted AS D

END;
GO