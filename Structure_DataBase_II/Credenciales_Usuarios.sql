-- Cambiar al contexto de la base de datos
USE BD_Mathmatic_01;
GO

-- =============================
-- 1. CREAR O VERIFICAR LOGIN: usuario_admin
-- =============================
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = 'usuario_admin')
BEGIN
    CREATE LOGIN usuario_admin WITH PASSWORD = 'Admin123!';
    PRINT 'Login usuario_admin creado.';
END
ELSE
BEGIN
    PRINT 'Login usuario_admin ya existe.';
END
GO

-- =============================
-- 2. CREAR O VERIFICAR LOGIN: usuario_lector
-- =============================
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = 'usuario_lector')
BEGIN
    CREATE LOGIN usuario_lector WITH PASSWORD = 'Lector123!';
    PRINT 'Login usuario_lector creado.';
END
ELSE
BEGIN
    PRINT 'Login usuario_lector ya existe.';
END
GO

-- =============================
-- 3. CREAR O VERIFICAR USUARIO EN LA BD: usuario_admin
-- =============================
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = 'usuario_admin')
BEGIN
    CREATE USER usuario_admin FOR LOGIN usuario_admin;
    PRINT 'Usuario usuario_admin creado en la base de datos.';
END
ELSE
BEGIN
    PRINT 'Usuario usuario_admin ya existe en la base de datos.';
END
GO

-- =============================
-- 4. CREAR O VERIFICAR USUARIO EN LA BD: usuario_lector
-- =============================
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = 'usuario_lector')
BEGIN
    CREATE USER usuario_lector FOR LOGIN usuario_lector;
    PRINT 'Usuario usuario_lector creado en la base de datos.';
END
ELSE
BEGIN
    PRINT 'Usuario usuario_lector ya existe en la base de datos.';
END
GO

-- =============================
-- 5. ASIGNAR PERMISOS
-- =============================

-- Agregar usuario_admin al rol db_owner si no está
IF NOT EXISTS (
    SELECT * 
    FROM sys.database_role_members rm
    JOIN sys.database_principals r ON rm.role_principal_id = r.principal_id
    JOIN sys.database_principals u ON rm.member_principal_id = u.principal_id
    WHERE r.name = 'db_owner' AND u.name = 'usuario_admin'
)
BEGIN
    ALTER ROLE db_owner ADD MEMBER usuario_admin;
    PRINT 'usuario_admin agregado al rol db_owner.';
END
ELSE
BEGIN
    PRINT 'usuario_admin ya pertenece al rol db_owner.';
END
GO

-- Otorgar permiso SELECT a usuario_lector sobre la tabla Estudiantes
GRANT SELECT ON dbo.Estudiantes TO usuario_lector;
PRINT 'Permiso SELECT otorgado a usuario_lector sobre la tabla Estudiantes.';
GO
