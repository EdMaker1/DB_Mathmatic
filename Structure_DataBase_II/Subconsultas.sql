USE BD_Mathmatic_01;
GO

-- ========================
-- SUBCONSULTAS BÁSICAS
-- ========================

-- 1. Obtener los nombres de estudiantes que están inscritos en algún curso
SELECT Nombres, ApellidoPaterno, ApellidoMaterno
FROM Estudiantes
WHERE IdEstudiante IN (
    SELECT IdEstudiante
    FROM Solicita
);
GO

-- 2. Listar los nombres de cursos que tienen profesores asignados
SELECT NombreCurso
FROM Cursos
WHERE IdProfesor IN (
    SELECT IdProfesor
    FROM Profesores
);
GO

-- ========================
-- SUBCONSULTAS COMPLEJAS
-- ========================

-- 3. Mostrar los estudiantes que tienen al menos un curso cuyo precio es mayor al promedio de todos los cursos
SELECT Nombres, ApellidoPaterno, ApellidoMaterno
FROM Estudiantes
WHERE IdEstudiante IN (
    SELECT IdEstudiante
    FROM Solicita
    WHERE IdCurso IN (
        SELECT IdCurso
        FROM Cursos
        WHERE Precio > (
            SELECT AVG(Precio)
            FROM Cursos
        )
    )
);
GO

-- 4. Mostrar los profesores que imparten más de un curso
SELECT IdProfesor, Nombres, ApellidoPaterno
FROM Profesores
WHERE IdProfesor IN (
    SELECT IdProfesor
    FROM Imparte
    GROUP BY IdProfesor
    HAVING COUNT(IdCurso) > 1
);
GO

-- 5. Mostrar los salones que han sido utilizados para cursos con estudiantes registrados
SELECT CodigoSalon, AforoSalon
FROM Salones
WHERE IdSalon IN (
    SELECT IdSalon
    FROM Orden
    WHERE IdCurso IN (
        SELECT IdCurso
        FROM Solicita
    )
);
GO

USE BD_Mathmatic_01;
GO


-- 6. Mostrar los cursos solicitados por un estudiante específico (por ejemplo, con Email 'ana@example.com')
SELECT NombreCurso
FROM Cursos
WHERE IdCurso IN (
    SELECT IdCurso
    FROM Solicita
    WHERE IdEstudiante = (
        SELECT IdEstudiante
        FROM Estudiantes
        WHERE Email = 'luis.gomez@gmail.com'
    )
);
GO

-- 7. Mostrar los cursos que tienen más de un estudiante inscrito
SELECT IdCurso, COUNT(*) AS CantidadEstudiantes
FROM Solicita
GROUP BY IdCurso
HAVING COUNT(*) > 1;
GO

