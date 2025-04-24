use BD_Mathmatic_01
GO
--1. Vista de Estudiantes con sus Órdenes Activas
CREATE VIEW Vista_EstudiantesOrdenesActivas AS
SELECT 
    E.IdEstudiante,
    E.NombreS AS NombreEstudiante,
    C.NombreCurso,
    O.FechaOrden
FROM Estudiantes E
INNER JOIN Orden O ON E.IdEstudiante = O.IdEstudiante
INNER JOIN Cursos C ON O.IdCurso = C.IdCurso
WHERE O.Estado = 1;

--2. Vista de Profesores con los Cursos que Imparten
CREATE VIEW Vista_ProfesoresCursos AS
SELECT 
    P.IdProfesor,
    P.NombreS AS NombreProfesor,
    C.IdCurso,
    C.NombreCurso,
    C.Precio
FROM Profesores P
INNER JOIN Imparte I ON P.IdProfesor = I.IdProfesor
INNER JOIN Cursos C ON I.IdCurso = C.IdCurso;

--3. Vista de Salones Asignados a Órdenes
CREATE VIEW Vista_SalonesAsignados AS
SELECT 
    S.IdSalon,
    S.CodigoSalon,
    C.NombreCurso,
    E.Nombres AS NombreEstudiante,
    O.FechaOrden
FROM Salones S
INNER JOIN Orden O ON S.IdSalon = O.IdSalon
INNER JOIN Cursos C ON O.IdCurso = C.IdCurso
INNER JOIN Estudiantes E ON O.IdEstudiante = E.IdEstudiante;


--4. Vista de Cursos Solicitados por Estudiantes
CREATE VIEW Vista_CursosSolicitados AS
SELECT 
    E.IdEstudiante,
    E.Nombres AS NombreEstudiante,
    C.IdCurso,
    C.NombreCurso,
    C.Precio
FROM Estudiantes E
INNER JOIN Solicita S ON E.IdEstudiante = S.IdEstudiante
INNER JOIN Cursos C ON S.IdCurso = C.IdCurso;


--5. Vista de Horarios de Cursos con Órdenes Activas

CREATE VIEW Vista_HorariosCursosActivos AS
SELECT 
    H.IdHorario,
    H.HoraInicio,
    H.HoraFin,
    C.NombreCurso,
    E.Nombres AS NombreEstudiante,
    O.FechaOrden
FROM Horario H
INNER JOIN Orden O ON H.IdHorario = O.IdHorario
INNER JOIN Cursos C ON O.IdCurso = C.IdCurso
INNER JOIN Estudiantes E ON O.IdEstudiante = E.IdEstudiante
WHERE O.Estado = 1;


SELECT * FROM Vista_EstudiantesOrdenesActivas;
SELECT * FROM Vista_ProfesoresCursos;
SELECT * FROM Vista_SalonesAsignados;
SELECT * FROM Vista_CursosSolicitados;
SELECT * FROM Vista_HorariosCursosActivos;
