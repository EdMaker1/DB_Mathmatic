--Cursores 01

DECLARE @Nombres NVARCHAR(100),
        @ApellidoPaterno NVARCHAR(100),
        @NombreCurso NVARCHAR(100);

DECLARE cursor_solicitudes CURSOR FOR
SELECT E.Nombres, E.ApellidoPaterno, C.NombreCurso
FROM Estudiantes E
INNER JOIN Solicita S ON E.IdEstudiante = S.IdEstudiante
INNER JOIN Cursos C ON S.IdCurso = C.IdCurso;

OPEN cursor_solicitudes;

FETCH NEXT FROM cursor_solicitudes INTO @Nombres, @ApellidoPaterno, @NombreCurso;

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'Estudiante: ' + @Nombres + ' ' + @ApellidoPaterno + ' - Curso: ' + @NombreCurso;
    FETCH NEXT FROM cursor_solicitudes INTO @Nombres, @ApellidoPaterno, @NombreCurso;
END

CLOSE cursor_solicitudes;
DEALLOCATE cursor_solicitudes;

--Cursores 02

DECLARE @NombreProf NVARCHAR(100),
        @ApellidoProf NVARCHAR(100),
        @CantidadCursos INT;

DECLARE cursor_profesores CURSOR FOR
SELECT P.Nombres, P.ApellidoPaterno
FROM Profesores P;

OPEN cursor_profesores;

FETCH NEXT FROM cursor_profesores INTO @NombreProf, @ApellidoProf;

WHILE @@FETCH_STATUS = 0
BEGIN
    SELECT @CantidadCursos = COUNT(*)
    FROM Imparte I
    INNER JOIN Profesores P ON I.IdProfesor = P.IdProfesor
    WHERE P.Nombres = @NombreProf AND P.ApellidoPaterno = @ApellidoProf;

    PRINT 'Profesor: ' + @NombreProf + ' ' + @ApellidoProf + ' - Cursos impartidos: ' + CAST(@CantidadCursos AS NVARCHAR);

    FETCH NEXT FROM cursor_profesores INTO @NombreProf, @ApellidoProf;
END

CLOSE cursor_profesores;
DEALLOCATE cursor_profesores;

--Cursores 03
DECLARE @CodigoSalon NVARCHAR(50),
        @Aforo INT,
        @Disponibilidad BIT;

DECLARE cursor_salones CURSOR FOR
SELECT S.CodigoSalon, S.AforoSalon, DS.Disponibilidad
FROM Salones S
INNER JOIN DisponibilidadSalon DS ON S.IdDisponibilidad = DS.IdDisponibilidadSalon;

OPEN cursor_salones;

FETCH NEXT FROM cursor_salones INTO @CodigoSalon, @Aforo, @Disponibilidad;

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'Salón: ' + @CodigoSalon + ' - Aforo: ' + CAST(@Aforo AS NVARCHAR) + 
          ' - Disponible: ' + CASE WHEN @Disponibilidad = 1 THEN 'Sí' ELSE 'No' END;

    FETCH NEXT FROM cursor_salones INTO @CodigoSalon, @Aforo, @Disponibilidad;
END

CLOSE cursor_salones;
DEALLOCATE cursor_salones;
