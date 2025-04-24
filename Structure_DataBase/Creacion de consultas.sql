use BD_Mathmatic_01
GO

--1. Hallar el máximo (Máximo ID del Estudiante)
SELECT MAX(IdEstudiante) AS MaximoEstudiante
FROM Estudiantes;

--2. Hallar el promedio (Promedio de IdCurso en la tabla Orden)

SELECT AVG(IdCurso) AS PromedioIdCurso
FROM Orden;

--3.Cursos cuyo nombre contiene la palabra 'Matemática'
SELECT IdCurso, NombreCurso 
FROM Cursos
WHERE NombreCurso LIKE '%Matem%';

--4.Estudiantes que solicitan un curso en particular (por ejemplo, IdCurso = 3)
SELECT E.IdEstudiante, E.Nombres, S.IdCurso 
FROM Solicita S
INNER JOIN Estudiantes E ON S.IdEstudiante = E.IdEstudiante
WHERE S.IdCurso = 3;

--5.Profesores que dictan más de un curso
SELECT I.IdProfesor, P.Nombres AS NombreProfesor, COUNT(I.IdCurso) AS CursosImpartidos
FROM Imparte I
INNER JOIN Profesores P ON I.IdProfesor = P.IdProfesor
GROUP BY I.IdProfesor, P.Nombres
HAVING COUNT(I.IdCurso) > 5;

--6. Consulta con INNER JOIN (Estudiantes y los cursos que solicitan)
SELECT 
    E.IdEstudiante,
    E.Nombres AS NombreEstudiante,
    C.IdCurso,
    C.NombreCurso
FROM Solicita S
INNER JOIN Estudiantes E ON S.IdEstudiante = E.IdEstudiante
INNER JOIN Cursos C ON S.IdCurso = C.IdCurso;

--7. Consulta con BETWEEN (Órdenes realizadas en un rango de fechas
SELECT *
FROM Orden
WHERE FechaOrden BETWEEN '2024-11-01' AND '2024-11-05';

--8. Consulta con WHERE (Cursos impartidos por un profesor específico)
SELECT 
    P.Nombres AS NombreProfesor,
    C.NombreCurso
FROM Imparte I
INNER JOIN Profesores P ON I.IdProfesor = P.IdProfesor
INNER JOIN Cursos C ON I.IdCurso = C.IdCurso
WHERE P.Nombres = 'Juan';

--9. Consulta con GROUP BY (Cantidad de órdenes por estado)
SELECT 
    Estado,
    COUNT(*) AS CantidadOrdenes
FROM Orden
GROUP BY Estado;

--10. Consulta con LIKE (Buscar estudiantes con nombres que comiencen con 'A')
SELECT *
FROM Estudiantes
WHERE Nombres LIKE 'A%';