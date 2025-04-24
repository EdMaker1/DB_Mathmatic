Use BD_Mathmatic_01
go

CREATE TRIGGER trg_Valtlf_Estudiant
ON Estudiantes
AFTER INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM inserted 
        WHERE TelefonoEstudiante NOT LIKE '[0-9]%'
    )
    BEGIN
        ROLLBACK TRANSACTION;
        THROW 50001, 'El teléfono del estudiante debe contener solo números.', 1;
    END
END;
GO

INSERT INTO Estudiantes (Nombres, ApellidoPaterno, ApellidoMaterno, TelefonoEstudiante, FechaNacimiento, Email, Direccion)
VALUES ('Juan', 'Perez', 'Gomez', '957780397', '2000-01-01', 'juan.perez@example.com', 'Calle Falsa 123');
GO

INSERT INTO Estudiantes (Nombres, ApellidoPaterno, ApellidoMaterno, TelefonoEstudiante, FechaNacimiento, Email, Direccion)
VALUES ('Mario', 'Lopez', 'Martinez', '95778O397', '1998-05-15', 'maria.lopez@example.com', 'Avenida Principal 456');
GO

CREATE TRIGGER trg_ValFecha_Nacimiento
ON Estudiantes
AFTER INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM inserted 
        WHERE TRY_CAST(FechaNacimiento AS DATE) IS NULL
    )
    BEGIN
        ROLLBACK TRANSACTION;
        THROW 50002, 'La Fecha de Nacimiento debe ser una fecha válida (formato AAAA-MM-DD).', 1;
    END
END;
GO

INSERT INTO Estudiantes (Nombres, ApellidoPaterno, ApellidoMaterno, TelefonoEstudiante, FechaNacimiento, Email, Direccion)
VALUES ('Ana', 'Santos', 'Ruiz', '123456789', '2001-04-22', 'ana.santos@example.com', 'Av. Siempre Viva 742');
GO

INSERT INTO Estudiantes (Nombres, ApellidoPaterno, ApellidoMaterno, TelefonoEstudiante, FechaNacimiento, Email, Direccion)
VALUES ('Carlos', 'Garcia', 'Lopez', '987654321', '22-04-2001', 'carlos.garcia@example.com', 'Calle Sin Nombre 99');
GO