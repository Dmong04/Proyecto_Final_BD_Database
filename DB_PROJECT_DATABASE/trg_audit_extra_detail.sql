USE coco_tours_db
GO

CREATE TRIGGER trg_audit_extra_detail
ON extra_detail
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
  INSERT INTO auditing_operation_management(table_name,type_action,record_id,old_data,new_data)
  SELECT
    'extra_detail',
     CASE
            WHEN i.id IS NOT NULL AND d.id IS NOT NULL THEN 'UPDATE'
            WHEN i.id IS NOT NULL THEN 'INSERT'
            ELSE 'DELETE'
     END,
     COALESCE (I.id, D.id),
     CAST(D.total_price AS nvarchar),
     CAST(I.total_price AS nvarchar)
  FROM inserted AS I
  FULL JOIN deleted AS D ON I.id = D.id;
END;
GO