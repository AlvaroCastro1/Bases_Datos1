--crear una base de datos nueva
CREATE DATABASE Inscripcion;
--usa la base de datos nueva
Use Inscripcion;
--crear una tabla Materias
CREATE TABLE Materias(
    idMateria int auto_increment,
    claveMateria varchar(5),
    nombre varchar(50),
    creditos int,
    primary key(idMateria)
)ENGINE=InnoDB;
--crear una tabla Profesor
 CREATE TABLE Profesor(
    idProfesor int auto_increment,
    claveProfesor VARCHAR(50),
    Nombre varchar(50),
    Apellidos varchar(20),
    email VARCHAR(64),
    PRIMARY KEY(idProfesor)
 ) ENGINE =InnoDB;
--crear una tabla Asignacion
CREATE TABLE Asignacion(
    Materia int,
    Profesor int,
    totalHoras int,
    PRIMARY KEY(Materia, Profesor),
    Foreign Key (Materia) REFERENCES Materias(idMateria),
    Foreign Key (Profesor) REFERENCES Profesor(idProfesor)
) ENGINE = InnoDB;