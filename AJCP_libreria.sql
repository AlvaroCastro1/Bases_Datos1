CREATE DATABASE libreria;
USE libreria;
CREATE TABLE stock (
	idStock bigint (20),
	idLibro bigint (20),
	totalStock int (20),
	Notas varchar (255),
	FechaActualizacionInv date,
	primary key (idStock)
) ENGINE = InnoDB;

CREATE TABLE libro (
	idLibro bigint (20),
	titulo varchar (255),
	Descripcion varchar (255),
	anioPublicacion year (4),
	idAutor bigint (20),
	idGenero bigint (20),
	primary key (idLibro)
) ENGINE = InnoDB;

CREATE TABLE autor (
	idAutor bigint (20),
	nombreCompleto varchar (20),
	fechaNacimiento date,
	fechademuerte date,
	primary key (idAutor)
) ENGINE = InnoDB;

CREATE TABLE genero(
	idGenero bigint(20),
	nombre varchar (20),
	primary key (idGenero)
) ENGINE = InnoDB;

CREATE TABLE Asignacion (
	Autor bigint,
	Genero bigint,
	Libro bigint,
	primary key (Autor, Genero, Libro),
	foreign key (Genero) REFERENCES genero (idGenero),
    foreign key (Libro) REFERENCES Libro (idLibro)
) ENGINE = InnoDB;
