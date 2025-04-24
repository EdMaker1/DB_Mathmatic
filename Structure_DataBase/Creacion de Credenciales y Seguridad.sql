USE BD_Mathmatic_01;
GO

-- Crear login para user_administrator con una contraseña
CREATE LOGIN user_administratorLogin 
WITH PASSWORD = 'tevogliobene1.';
GO

-- Crear login para user_invitado con una contraseña
CREATE LOGIN user_invitadoLogin 
WITH PASSWORD = 'tevoglio1.';
GO


USE BD_Mathmatic_01;
GO

-- Crear usuario user_administrator con privilegios de lectura y escritura
CREATE USER user_administrator FOR LOGIN user_administratorLogin;
GO

-- Asignar roles de base de datos (db_datareader y db_datawriter)
ALTER ROLE db_datareader ADD MEMBER user_administrator;
ALTER ROLE db_datawriter ADD MEMBER user_administrator;
GO

-- Crear usuario user_invitado con privilegios solo de lectura
CREATE USER user_invitado FOR LOGIN user_invitadoLogin;
GO

-- Asignar solo el rol de lectura (db_datareader)
ALTER ROLE db_datareader ADD MEMBER user_invitado;
GO
