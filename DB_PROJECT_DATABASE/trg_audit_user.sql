USE coco_tours_db
GO

CREATE TRIGGER trg_audit_user
ON [user]
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
  INSERT INTO auditing_users_management(table_name,type_action,record_id,old_data,new_data)
  SELECT
    'user',
     CASE
            WHEN i.id IS NOT NULL AND d.id IS NOT NULL THEN 'UPDATE'
            WHEN i.id IS NOT NULL THEN 'INSERT'
            ELSE 'DELETE'
     END,
     COALESCE (I.id, D.id),
     d.username,
     i.username
  FROM inserted AS I
  FULL JOIN deleted AS D ON I.id = D.id;
END;
GO