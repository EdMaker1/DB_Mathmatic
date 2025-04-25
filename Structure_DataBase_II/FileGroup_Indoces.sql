-- ============================
-- 1. Crear FILEGROUPs y archivos físicos
-- ============================
USE master;
GO

ALTER DATABASE BD_Mathmatic_01
ADD FILEGROUP FG_Estudiantes;
ALTER DATABASE BD_Mathmatic_01
ADD FILEGROUP FG_Cursos;
ALTER DATABASE BD_Mathmatic_01
ADD FILEGROUP FG_Profesores;
ALTER DATABASE BD_Mathmatic_01
ADD FILEGROUP FG_Imparte;
ALTER DATABASE BD_Mathmatic_01
ADD FILEGROUP FG_Orden;
GO

ALTER DATABASE BD_Mathmatic_01
ADD FILE (
    NAME = N'Estudiantes_Data',
    FILENAME = N'C:\SQLData\BD_Mathmatic_01_Estudiantes.ndf',
    SIZE = 100MB,
    FILEGROWTH = 10MB
) TO FILEGROUP FG_Estudiantes;

ALTER DATABASE BD_Mathmatic_01
ADD FILE (
    NAME = N'Cursos_Data',
    FILENAME = N'C:\SQLData\BD_Mathmatic_01_Cursos.ndf',
    SIZE = 100MB,
    FILEGROWTH = 10MB
) TO FILEGROUP FG_Cursos;

ALTER DATABASE BD_Mathmatic_01
ADD FILE (
    NAME = N'Profesores_Data',
    FILENAME = N'C:\SQLData\BD_Mathmatic_01_Profesores.ndf',
    SIZE = 100MB,
    FILEGROWTH = 10MB
) TO FILEGROUP FG_Profesores;

ALTER DATABASE BD_Mathmatic_01
ADD FILE (
    NAME = N'Imparte_Data',
    FILENAME = N'C:\SQLData\BD_Mathmatic_01_Imparte.ndf',
    SIZE = 100MB,
    FILEGROWTH = 10MB
) TO FILEGROUP FG_Imparte;

ALTER DATABASE BD_Mathmatic_01
ADD FILE (
    NAME = N'Orden_Data',
    FILENAME = N'C:\SQLData\BD_Mathmatic_01_Orden.ndf',
    SIZE = 100MB,
    FILEGROWTH = 10MB
) TO FILEGROUP FG_Orden;
GO

-- ============================
-- 2. Mover las tablas existentes a los nuevos FILEGROUPs
-- ============================
USE BD_Mathmatic_01;
GO

-- Estudiantes
CREATE CLUSTERED INDEX IX_Estudiantes_IdEstudiante
ON Estudiantes(IdEstudiante)
WITH (DROP_EXISTING = ON)
ON FG_Estudiantes;

-- Cursos
CREATE CLUSTERED INDEX IX_Cursos_IdCurso
ON Cursos(IdCurso)
WITH (DROP_EXISTING = ON)
ON FG_Cursos;

-- Profesores
CREATE CLUSTERED INDEX IX_Profesores_IdProfesor
ON Profesores(IdProfesor)
WITH (DROP_EXISTING = ON)
ON FG_Profesores;

-- Imparte
CREATE CLUSTERED INDEX IX_Imparte_IdProfesor_IdCurso
ON Imparte(IdProfesor, IdCurso)
WITH (DROP_EXISTING = ON)
ON FG_Imparte;

-- Orden
CREATE CLUSTERED INDEX IX_Orden_IdOrden
ON Orden(IdOrden)
WITH (DROP_EXISTING = ON)
ON FG_Orden;
GO
