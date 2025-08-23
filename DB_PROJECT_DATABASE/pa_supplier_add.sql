CREATE PROCEDURE pa_supplier_insert (
    @name VARCHAR(50),
    @description VARCHAR(150),
    @email VARCHAR(70),
    @phone VARCHAR(20)
) AS
BEGIN
BEGIN TRY
    IF @name IS NULL OR @name = ' '
    BEGIN
        RAISERROR('El nombre no corresponde a un valor v�lido', 16, 1)
        RETURN
    END
    IF @email NOT LIKE '%_@_%._%'
    BEGIN
        RAISERROR('El formato de correo no es v�lido', 16, 1)
        RETURN
    END
    IF @phone IS NULL OR @phone LIKE '%[^0-9]%' OR LEN(@phone) <> 8
    BEGIN
        RAISERROR('El tel�fono no es v�lido (solo 8 d�gitos)', 16, 1)
        RETURN
    END

    INSERT INTO supplier ([name], [description], [email])
    VALUES (@name, @description, @email);

    DECLARE @supplier_id INT = SCOPE_IDENTITY();

    INSERT INTO supplier_phones (supplier_id, phone)
    VALUES (@supplier_id, @phone);
END TRY
BEGIN CATCH
    RAISERROR('Error al insertar proveedor', 16, 1)
END CATCH
END
GO