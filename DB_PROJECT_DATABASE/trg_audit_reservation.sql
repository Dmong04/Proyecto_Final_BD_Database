USE coco_tours_db
GO

CREATE TRIGGER trg_audit_reservations
ON reservations
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
  INSERT INTO auditing_operation_management(table_name,type_action,record_id,old_data,new_data)
  SELECT
    'reservations',
     CASE
            WHEN i.id IS NOT NULL AND d.id IS NOT NULL THEN 'UPDATE'
            WHEN i.id IS NOT NULL THEN 'INSERT'
            ELSE 'DELETE'
     END,
     COALESCE (I.id, D.id),
     CAST(D.total AS nvarchar),
     CAST(I.total AS nvarchar)
  FROM inserted AS I
  FULL JOIN deleted AS D ON I.id = D.id;
END;
GO