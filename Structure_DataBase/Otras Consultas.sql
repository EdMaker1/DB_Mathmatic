use BD_Mathmatic_01
go
select*from Orden
where FechaOrden between '2024-11-01' and '2024-12-03'

select*from 

USE BD_Mathmatic_01;
GO

SELECT 
    e.Nombres + ' ' + e.ApellidoPaterno + ' ' + e.ApellidoMaterno AS NombreAlumno,
    SUM(c.Precio) AS TotalPagado
FROM 
    Orden o
INNER JOIN 
    Cursos c ON o.IdCurso = c.IdCurso
INNER JOIN 
    Estudiantes e ON o.IdEstudiante = e.IdEstudiante
WHERE 
    o.Estado = 1 -- Considerando que Estado=1 significa que la orden está pagada
GROUP BY 
    e.Nombres, e.ApellidoPaterno, e.ApellidoMaterno
ORDER BY 
    TotalPagado DESC;

	USE BD_Mathmatic_01;
GO

SELECT TOP 1
    c.NombreCurso,
    COUNT(i.IdCurso) AS TotalVecesImpartido
FROM 
    Imparte i
INNER JOIN 
    Cursos c ON i.IdCurso = c.IdCurso
GROUP BY 
    c.NombreCurso
ORDER BY 
    TotalVecesImpartido DESC;


SELECT TOP 1
    e.Nombres + ' ' + e.ApellidoPaterno + ' ' + e.ApellidoMaterno AS NombreAlumno,
    COUNT(s.IdCurso) AS TotalCursos
FROM 
    Solicita s
INNER JOIN 
    Estudiantes e ON s.IdEstudiante = e.IdEstudiante
GROUP BY 
    e.Nombres, e.ApellidoPaterno, e.ApellidoMaterno
ORDER BY 
    TotalCursos DESC;

SELECT 
    c.NombreCurso,
    COUNT(i.IdCurso) AS TotalVecesImpartido
FROM 
    Cursos c
LEFT JOIN 
    Imparte i ON c.IdCurso = i.IdCurso
GROUP BY 
    c.NombreCurso
ORDER BY 
    TotalVecesImpartido ASC;

CREATE TRIGGER trg_ValidarPrecioCurso
ON Cursos
AFTER INSERT, UPDATE
AS
BEGIN
    -- Verifica si hay algún registro que no cumpla con el formato numérico del precio
    IF EXISTS (
        SELECT 1
        FROM inserted
        WHERE Precio IS NULL OR Precio < 0
    )
    BEGIN
        ROLLBACK TRANSACTION;
        THROW 50003, 'El campo Precio en la tabla Cursos debe ser un valor numérico mayor o igual a 0.', 1;
    END
END;
GO
Use BD_Mathmatic_01
GO
INSERT INTO Cursos (NombreCurso, Precio, IdDisponibilidadCurso, IdProfesor)
VALUES ('Filantropia', 100.0, 1, 1);
GO

INSERT INTO Cursos (NombreCurso, Precio, IdDisponibilidadCurso, IdProfesor)
VALUES ('Física2222', -50, 1, 1);
GO

Create database BD_Mathmatic_01_BK

USE BD_Mathmatic_01_BK;
GO

-- Crear las tablas en la base de datos de respaldo
CREATE TABLE Estudiantes (
    IdEstudiante INT PRIMARY KEY,
    Nombres NVARCHAR(100) NOT NULL,
    ApellidoPaterno NVARCHAR(100) NOT NULL,
    ApellidoMaterno NVARCHAR(100) NOT NULL,
    TelefonoEstudiante NVARCHAR(15) NOT NULL,
    FechaNacimiento DATE NOT NULL,
    Email NVARCHAR(150),
    Direccion NVARCHAR(200)
);

CREATE TABLE Profesores (
    IdProfesor INT PRIMARY KEY,
    Nombres NVARCHAR(100) NOT NULL,
    ApellidoPaterno NVARCHAR(100) NOT NULL,
    ApellidoMaterno NVARCHAR(100) NOT NULL,
    TelefonoProfesor NVARCHAR(15) NOT NULL
);

CREATE TABLE Cursos (
    IdCurso INT PRIMARY KEY,
    NombreCurso NVARCHAR(100) NOT NULL,
    Precio DECIMAL(10,2) NOT NULL,
    IdDisponibilidadCurso INT NOT NULL,
    IdProfesor INT NOT NULL
);

CREATE TABLE Orden (
    IdOrden INT PRIMARY KEY,
    FechaOrden DATE NOT NULL,
    IdEstudiante INT NOT NULL,
    IdCurso INT NOT NULL,
    IdSalon INT NOT NULL,
    IdHorario INT NOT NULL,
    Estado BIT NOT NULL
);
GO

CREATE PROCEDURE BD_Mathmatic_01_Replica
AS
BEGIN
    -- Insertar datos en la tabla Estudiantes de respaldo
    INSERT INTO BD_Mathmatic_01_BK.dbo.Estudiantes
    SELECT * FROM BD_Mathmatic_01.dbo.Estudiantes;

    -- Insertar datos en la tabla Profesores de respaldo
    INSERT INTO BD_Mathmatic_01_BK.dbo.Profesores
    SELECT * FROM BD_Mathmatic_01.dbo.Profesores;

    -- Insertar datos en la tabla Cursos de respaldo
    INSERT INTO BD_Mathmatic_01_BK.dbo.Cursos
    SELECT * FROM BD_Mathmatic_01.dbo.Cursos;

    -- Insertar datos en la tabla Orden de respaldo
    INSERT INTO BD_Mathmatic_01_BK.dbo.Orden
    SELECT * FROM BD_Mathmatic_01.dbo.Orden;

    PRINT 'Datos copiados exitosamente a la base de datos de respaldo.';
END;
GO

EXEC BD_Mathmatic_01_Replica;
GO

Use BD_Mathmatic_01_BK
go
Drop table Estudiantes
Drop table Cursos
Drop table Profesores
Drop table Orden

