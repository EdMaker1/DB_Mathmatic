CREATE PROCEDURE RegistrarOrden
    @IdEstudiante INT,
    @IdCurso INT,
    @IdSalon INT,
    @IdHorario INT,
    @FechaOrden DATE
AS
BEGIN
    BEGIN TRY
        BEGIN TRAN;

        -- Validar que el estudiante no tenga otra orden en el mismo horario
        IF EXISTS (
            SELECT 1
            FROM Orden
            WHERE IdEstudiante = @IdEstudiante
              AND IdHorario = @IdHorario
              AND Estado = 1
        )
        BEGIN
            RAISERROR('El estudiante ya tiene una orden activa en ese horario.', 16, 1);
        END

        -- Verificar disponibilidad del curso
        DECLARE @DispCurso BIT;
        SELECT @DispCurso = dc.Disponibilidad
        FROM Cursos c
        JOIN DisponibilidadCurso dc ON c.IdDisponibilidadCurso = dc.IdDisponibilidadCurso
        WHERE c.IdCurso = @IdCurso;

        IF @DispCurso = 0
        BEGIN
            RAISERROR('El curso no está disponible.', 16, 1);
        END

        -- Verificar disponibilidad del salón
        DECLARE @DispSalon BIT;
        SELECT @DispSalon = ds.Disponibilidad
        FROM Salones s
        JOIN DisponibilidadSalon ds ON s.IdDisponibilidad = ds.IdDisponibilidadSalon
        WHERE s.IdSalon = @IdSalon;

        IF @DispSalon = 0
        BEGIN
            RAISERROR('El salón no está disponible.', 16, 1);
        END

        -- Verificar disponibilidad del horario
        DECLARE @DispHorario BIT;
        SELECT @DispHorario = dh.Disponibilidad
        FROM Horario h
        JOIN DisponibilidadHorario dh ON h.IdDisponibilidad = dh.IdDisponibilidadHorario
        WHERE h.IdHorario = @IdHorario;

        IF @DispHorario = 0
        BEGIN
            RAISERROR('El horario no está disponible.', 16, 1);
        END

        -- Insertar la nueva orden
        INSERT INTO Orden (FechaOrden, IdEstudiante, IdCurso, IdSalon, IdHorario, Estado)
        VALUES (@FechaOrden, @IdEstudiante, @IdCurso, @IdSalon, @IdHorario, 1);

        COMMIT;
        PRINT 'Orden registrada con éxito.';
    END TRY
    BEGIN CATCH
        ROLLBACK;
        PRINT 'Error al registrar la orden: ' + ERROR_MESSAGE();
    END CATCH
END;
GO

---------------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE CancelarOrden
    @IdOrden INT
AS
BEGIN
    BEGIN TRY
        BEGIN TRAN;

        -- Cambiar estado a 0 (cancelado) para la orden
        UPDATE Orden
        SET Estado = 0
        WHERE IdOrden = @IdOrden
          AND Estado = 1;

        COMMIT;
        PRINT 'Orden cancelada correctamente.';
    END TRY
    BEGIN CATCH
        ROLLBACK;
        PRINT 'Error al cancelar la orden: ' + ERROR_MESSAGE();
    END CATCH
END;
GO


----------------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE ActualizarDisponibilidadSalon
    @IdSalon INT,
    @NuevaDisponibilidad BIT
AS
BEGIN
    BEGIN TRY
        BEGIN TRAN;

        -- Actualizar la disponibilidad del salón
        UPDATE DisponibilidadSalon
        SET Disponibilidad = @NuevaDisponibilidad
        WHERE IdDisponibilidadSalon = (SELECT IdDisponibilidad FROM Salones WHERE IdSalon = @IdSalon);

        COMMIT;
        PRINT 'Disponibilidad del salón actualizada correctamente.';
    END TRY
    BEGIN CATCH
        ROLLBACK;
        PRINT 'Error al actualizar la disponibilidad del salón: ' + ERROR_MESSAGE();
    END CATCH
END;
GO


----------------------------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE VerificarInscripcion
    @IdEstudiante INT,
    @IdCurso INT
AS
BEGIN
    BEGIN TRY
        DECLARE @Inscrito BIT;

        -- Verificar si el estudiante está inscrito en el curso
        SELECT @Inscrito = CASE WHEN EXISTS (
                SELECT 1
                FROM Solicita
                WHERE IdEstudiante = @IdEstudiante
                  AND IdCurso = @IdCurso
            ) THEN 1 ELSE 0 END;

        IF @Inscrito = 1
        BEGIN
            PRINT 'El estudiante ya está inscrito en este curso.';
        END
        ELSE
        BEGIN
            PRINT 'El estudiante NO está inscrito en este curso.';
        END
    END TRY
    BEGIN CATCH
        PRINT 'Error al verificar la inscripción: ' + ERROR_MESSAGE();
    END CATCH
END;
GO


-----------------------------------------------------------------------------------------------

EXEC RegistrarOrden
    @IdEstudiante = 1,        -- ID del estudiante
    @IdCurso = 4,             -- ID del curso
    @IdSalon = 2,             -- ID del salón
    @IdHorario = 3,           -- ID del horario
    @FechaOrden = GETDATE();  -- Fecha actual

EXEC CancelarOrden
    @IdOrden = 2;  -- ID de la orden que deseas cancelar


EXEC ActualizarDisponibilidadSalon
    @IdSalon = 2,              -- ID del salón que deseas actualizar
    @NuevaDisponibilidad = 0;  -- 0 para no disponible, 1 para disponible


EXEC VerificarInscripcion
    @IdEstudiante = 1,    -- ID del estudiante
    @IdCurso = 4;         -- ID del curso


