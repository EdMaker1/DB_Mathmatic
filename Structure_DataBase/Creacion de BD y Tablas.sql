-- Crear la base de datos
CREATE DATABASE BD_Mathmatic_01;
GO

-- Usar la base de datos creada
USE BD_Mathmatic_01;
GO

-- Crear la tabla Estudiantes
CREATE TABLE Estudiantes (
    IdEstudiante INT PRIMARY KEY IDENTITY(1,1),
    Nombres NVARCHAR(100) NOT NULL,
    ApellidoPaterno NVARCHAR(100) NOT NULL,
    ApellidoMaterno NVARCHAR(100) NOT NULL,
    TelefonoEstudiante NVARCHAR(15) NOT NULL,
    FechaNacimiento DATE NOT NULL,
    Email NVARCHAR(150),
    Direccion NVARCHAR(200)
);

-- Crear la tabla Profesores
CREATE TABLE Profesores (
    IdProfesor INT PRIMARY KEY IDENTITY(1,1),
    Nombres NVARCHAR(100) NOT NULL,
    ApellidoPaterno NVARCHAR(100) NOT NULL,
    ApellidoMaterno NVARCHAR(100) NOT NULL,
    TelefonoProfesor NVARCHAR(15) NOT NULL
);

-- Crear la tabla DisponibilidadSalon
CREATE TABLE DisponibilidadSalon (
    IdDisponibilidadSalon INT PRIMARY KEY IDENTITY(1,1),
    Disponibilidad BIT NOT NULL
);

-- Crear la tabla Salones
CREATE TABLE Salones (
    IdSalon INT PRIMARY KEY IDENTITY(1,1),
    CodigoSalon NVARCHAR(50) NOT NULL,
    AforoSalon INT NOT NULL,
    IdDisponibilidad INT NOT NULL,
    FOREIGN KEY (IdDisponibilidad) REFERENCES DisponibilidadSalon(IdDisponibilidadSalon)
);

-- Crear la tabla DisponibilidadCurso
CREATE TABLE DisponibilidadCurso (
    IdDisponibilidadCurso INT PRIMARY KEY IDENTITY(1,1),
    Disponibilidad BIT NOT NULL
);

-- Crear la tabla Cursos
CREATE TABLE Cursos (
    IdCurso INT PRIMARY KEY IDENTITY(1,1),
    NombreCurso NVARCHAR(100) NOT NULL,
    Precio DECIMAL(10,2) NOT NULL,
    IdDisponibilidadCurso INT NOT NULL,
    IdProfesor INT NOT NULL,
    FOREIGN KEY (IdDisponibilidadCurso) REFERENCES DisponibilidadCurso(IdDisponibilidadCurso),
    FOREIGN KEY (IdProfesor) REFERENCES Profesores(IdProfesor)
);

-- Crear la tabla Dia
CREATE TABLE Dia (
    IdDia INT PRIMARY KEY IDENTITY(1,1),
    NombreDia NVARCHAR(50) NOT NULL
);

-- Crear la tabla DisponibilidadHorario
CREATE TABLE DisponibilidadHorario (
    IdDisponibilidadHorario INT PRIMARY KEY IDENTITY(1,1),
    Disponibilidad BIT NOT NULL
);

-- Crear la tabla Horario
CREATE TABLE Horario (
    IdHorario INT PRIMARY KEY IDENTITY(1,1),
    Descripcion NVARCHAR(200),
    HoraInicio TIME NOT NULL,
    HoraFin TIME NOT NULL,
    IdDia INT NOT NULL,
    IdDisponibilidad INT NOT NULL,
    FOREIGN KEY (IdDia) REFERENCES Dia(IdDia),
    FOREIGN KEY (IdDisponibilidad) REFERENCES DisponibilidadHorario(IdDisponibilidadHorario)
);

-- Crear la tabla Orden
CREATE TABLE Orden (
    IdOrden INT PRIMARY KEY IDENTITY(1,1),
    FechaOrden DATE NOT NULL,
    IdEstudiante INT NOT NULL,
    IdCurso INT NOT NULL,
    IdSalon INT NOT NULL,
    IdHorario INT NOT NULL,
    Estado BIT NOT NULL,
    FOREIGN KEY (IdEstudiante) REFERENCES Estudiantes(IdEstudiante),
    FOREIGN KEY (IdCurso) REFERENCES Cursos(IdCurso),
    FOREIGN KEY (IdSalon) REFERENCES Salones(IdSalon),
    FOREIGN KEY (IdHorario) REFERENCES Horario(IdHorario)
);

-- Crear la tabla Solicita (relación entre Estudiantes y Cursos)
CREATE TABLE Solicita (
    IdEstudiante INT NOT NULL,
    IdCurso INT NOT NULL,
    PRIMARY KEY (IdEstudiante, IdCurso),
    FOREIGN KEY (IdEstudiante) REFERENCES Estudiantes(IdEstudiante),
    FOREIGN KEY (IdCurso) REFERENCES Cursos(IdCurso)
);

-- Crear la tabla Imparte (relación entre Profesores y Cursos)
CREATE TABLE Imparte (
    IdProfesor INT NOT NULL,
    IdCurso INT NOT NULL,
    PRIMARY KEY (IdProfesor, IdCurso),
    FOREIGN KEY (IdProfesor) REFERENCES Profesores(IdProfesor),
    FOREIGN KEY (IdCurso) REFERENCES Cursos(IdCurso)
);
GO
