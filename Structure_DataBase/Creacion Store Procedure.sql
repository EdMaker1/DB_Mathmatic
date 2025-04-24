use BD_Mathmatic_01
go
-- Procedimiento almacenado para obtener estudiantes con órdenes activas
CREATE PROCEDURE ObtenerEstudiantesConOrdenesActivas
    @NombreCurso NVARCHAR(100)
AS
BEGIN
    SELECT E.Nombres, O.FechaOrden, C.NombreCurso
    FROM Estudiantes E
    INNER JOIN Orden O ON E.IdEstudiante = O.IdEstudiante
    INNER JOIN Cursos C ON O.IdCurso = C.IdCurso
    WHERE C.NombreCurso = @NombreCurso AND O.Estado = 1;
END;

EXEC ObtenerEstudiantesConOrdenesActivas @NombreCurso = 'Quimica';
EXEC ObtenerEstudiantesConOrdenesActivas @NombreCurso = 'Biologia';