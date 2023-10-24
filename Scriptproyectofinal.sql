USE premier_league;

CREATE TABLE Equipos (
    Id_equipo INT PRIMARY KEY,
    Nombre_equipo VARCHAR(255),
    Estadio VARCHAR(255),
    Ciudad VARCHAR(255),
	Año_fundacion INT

);

CREATE TABLE Jugadores (
    Id_jugador INT PRIMARY KEY,
    Nombre VARCHAR(255),
    Apellido VARCHAR(255),
    Id_equipo INT,
    Nacimiento DATE,
    Nacionalidad VARCHAR(255),
    Position VARCHAR(50),
    FOREIGN KEY (Id_equipo) REFERENCES Equipos(Id_equipo)
);


CREATE TABLE Partidos (
    Id_partido INT PRIMARY KEY,
    Id_equipo INT,
    Fecha DATE
);


CREATE TABLE Entrenadores (
    Id_entrenador INT PRIMARY KEY,
    Nombre VARCHAR(255),
    Apellido VARCHAR(255),
    Id_equipo INT,
    FOREIGN KEY (Id_equipo) REFERENCES Equipos(Id_equipo)
);


CREATE TABLE Estadios (
    Id_estadio INT PRIMARY KEY,
    Estadio_nombre VARCHAR(255),
    Capacidad INT,
    Ciudad VARCHAR(255)
);


CREATE TABLE Arbitros (
    Id_arbitro INT PRIMARY KEY,
    Nombre VARCHAR(255),
    LastName VARCHAR(255),
    Nacionalidad VARCHAR(255)
);


CREATE TABLE Tarjetas (
    Id_tarjeta INT PRIMARY KEY,
    Id_partido INT,
    Id_jugador INT,
    Tipo_tarjeta VARCHAR(10),
    FOREIGN KEY (Id_partido) REFERENCES Partidos (Id_partido),
    FOREIGN KEY (Id_jugador) REFERENCES Jugadores (Id_jugador)

);

CREATE TABLE Goles (
    Id_partido INT,
    Id_jugador INT,
    FOREIGN KEY (Id_partido) REFERENCES Partidos (Id_partido),
    FOREIGN KEY (Id_jugador) REFERENCES Jugadores (Id_jugador)
);

CREATE TABLE Temporada (
    Id_temporada INT PRIMARY KEY,
    Año_temporada INT(4)
);

ALTER TABLE Partidos 
	ADD FOREIGN KEY (Id_partido) REFERENCES estadios (Id_estadio),
    ADD foreign key  (Id_partido) REFERENCES arbitros (id_arbitro),
    ADD foreign key (Id_partido) REFERENCES Tarjetas (id_tarjeta)
    

DROP TABLE temporada;

CREATE TABLE Temporada (
    Id_temporada INT AUTO_INCREMENT PRIMARY KEY,
    Año_inicio INT NOT NULL,
    Año_fin INT NOT NULL,
    Campeon_id INT,
    Subcampeon_id INT
);

ALTER TABLE Temporada 
    ADD foreign key (Campeon_id) REFERENCES Equipos (Id_equipo),
	ADD foreign key (Subcampeon_id) REFERENCES Equipos (Id_equipo)
    
    
SET FOREIGN_KEY_CHECKS = 0; 
ALTER TABLE Equipos
MODIFY COLUMN Id_equipo INT NOT NULL AUTO_INCREMENT;
SET FOREIGN_KEY_CHECKS = 1;

