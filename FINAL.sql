-- USE PREMIER3;

-- CREACION DE TABLAS
CREATE TABLE EQUIPOS (
    ID_EQUIPO INT PRIMARY KEY,
    NOMBRE VARCHAR(255),
	AÑO_FUNDACION INT
);

CREATE TABLE JUGADORES (
	ID_JUGADOR INT PRIMARY KEY,
    NOMBRE VARCHAR(255),
    APELLIDO VARCHAR(255),
    NACIMIENTO DATE,
    NACIONALIDAD VARCHAR(255),
    POSICION VARCHAR(50),
	ID_EQUIPO INT,
    FOREIGN KEY (ID_EQUIPO) REFERENCES EQUIPOS (ID_EQUIPO)
);

CREATE TABLE ESTADIOS (
    ID_ESTADIO INT PRIMARY KEY,
    NOMBRE VARCHAR(255),
    CAPACIDAD INT,
    CIUDAD VARCHAR(255),
    ID_EQUIPO INT,
    FOREIGN KEY (ID_EQUIPO) REFERENCES EQUIPOS (ID_EQUIPO)
);

CREATE TABLE ARBITROS (
    ID_ARBITRO INT PRIMARY KEY,
    NOMBRE VARCHAR(255),
    APELLIDO VARCHAR(255),
    NACIONALIDAD VARCHAR(255)
);

CREATE TABLE PARTIDOS (
    ID_PARTIDO INT PRIMARY KEY AUTO_INCREMENT,
	ID_EQUIPO_LOCAL INT,
    ID_EQUIPO_VISITANTE INT,
	FECHA DATE, 
    ID_ARBITRO INT,
    ID_ESTADIO INT,
    FOREIGN KEY (ID_ESTADIO) REFERENCES ESTADIOS (ID_ESTADIO),
	FOREIGN key (ID_ARBITRO) REFERENCES ARBITROS (ID_ARBITRO),
    FOREIGN key (ID_EQUIPO_LOCAL) REFERENCES EQUIPOS (ID_EQUIPO),
    FOREIGN key (ID_EQUIPO_VISITANTE) REFERENCES EQUIPOS (ID_EQUIPO)
);

CREATE TABLE ENTRENADORES (
    NOMBRE VARCHAR(255),
    APELLIDO VARCHAR(255),
    ID_EQUIPO INT,
    ID_ENTRENADOR INT,
    FOREIGN KEY (ID_EQUIPO) REFERENCES EQUIPOS (ID_EQUIPO)
)

-- INSERCION DE DATOS
-- ORDEN DE LOS CSV: EQUIPOS, ESTADIOS, JUGADORES, ENTRENADORES, PARTIDOS Y ARBITROS

-- VISTAS 

CREATE VIEW VW_JUGADORES_CRYSTAL_PALACE AS
SELECT CONCAT(A.NOMBRE,' ',A.APELLIDO) AS JUGADOR, A.POSICION
FROM JUGADORES A
INNER JOIN EQUIPOS B
ON A.ID_EQUIPO = B.ID_EQUIPO
WHERE B.NOMBRE = 'CRYSTAL PALACE';

CREATE VIEW VW_ARBITROS_PARTIDOS_LONDRES AS
SELECT A.NOMBRE, A.APELLIDO, B.ID_PARTIDO, B.FECHA
FROM ARBITROS A
INNER JOIN PARTIDOS B
ON A.ID_ARBITRO = B.ID_ARBITRO
INNER JOIN ESTADIOS C
ON B.ID_ESTADIO = C.ID_ESTADIO
WHERE C.CIUDAD = 'LONDRES';

CREATE VIEW VW_CLUBES_DETALLE AS
SELECT	A.NOMBRE AS CLUB,
		A.AÑO_FUNDACION,
        B.NOMBRE AS ESTADIO,
        B.CIUDAD,
        B.CAPACIDAD
FROM	EQUIPOS A
INNER JOIN ESTADIOS B
ON A.ID_EQUIPO = B.ID_EQUIPO;

CREATE VIEW VW_PARTIDOS_DETALLE AS
SELECT 	A.ID_PARTIDO,
		A.FECHA AS FECHA_PARTIDO,
		B.NOMBRE AS ESTADIO,
        `NOMBRE_EQUIPO` (ID_EQUIPO_LOCAL) AS EQUIPO_LOCAL,
        `NOMBRE_EQUIPO` (ID_EQUIPO_VISITANTE) AS EQUIPO_VISITANTE,
		CONCAT(C.NOMBRE,' ',C.APELLIDO) AS ARBITRO
FROM	PARTIDOS A
INNER JOIN ESTADIOS B
ON A.ID_ESTADIO = B.ID_ESTADIO
INNER JOIN	ARBITROS C
ON	A.ID_ARBITRO = C.ID_ARBITRO
WHERE	B.CIUDAD = 'Londres'
ORDER	BY 1 ASC;

CREATE VIEW VW_ESTADIOS_MUNDIALISTAS AS
SELECT A.NOMBRE AS CLUB, B.NOMBRE AS ESTADIO, B.CIUDAD
FROM EQUIPOS A
INNER JOIN ESTADIOS B
ON A.ID_EQUIPO = B.ID_EQUIPO
WHERE B.CAPACIDAD >= 50000;

-- FUNCIONES

DELIMITER $$

CREATE FUNCTION `NOMBRE_EQUIPO` (A INT)
RETURNS VARCHAR(50)
READS SQL DATA
BEGIN

DECLARE VEQUIPO VARCHAR(50);
    
SELECT NOMBRE
INTO VEQUIPO
FROM EQUIPOS
WHERE ID_EQUIPO = A;
    
RETURN VEQUIPO;
    
END $$ 

-- SELECT `NOMBRE_EQUIPO` (8)

DELIMITER $$

CREATE FUNCTION `PARTIDOS_POR_ARBITRO` (IARBITRO INT)
RETURNS INT (5)
READS SQL DATA
BEGIN

DECLARE SPARTIDOS INT (5);
    
SELECT COUNT(*)
INTO SPARTIDOS
FROM PARTIDOS
WHERE ID_ARBITRO = IARBITRO;

RETURN SPARTIDOS;
    
END $$ 

-- SELECT PARTIDOS_POR_ARBITRO (3)
 
-- STORED PROCEDURES

DELIMITER $$
CREATE PROCEDURE `SP_INSERTAR_EQUIPO` 
(IN ID_EQUIPO INT, IN NOMBRE VARCHAR (255), IN AÑO_FUNDACION INT)

BEGIN
INSERT INTO EQUIPOS VALUES (ID_EQUIPO, NOMBRE, AÑO_FUNDACION);
END;
$$ 

-- CALL SP_INSERTAR_EQUIPO (21, 'RIVER PLATE', 2023);
-- CALL SP_INSERTAR_EQUIPO (22, 'BOCA JUNIORS', 2022);
-- SELECT * FROM EQUIPOS;

DELIMITER $$
CREATE PROCEDURE `SP_INSERTAR_EQUIPO_VALIDACION`
(IN ID_EQUIPO INT, IN NOMBRE VARCHAR (255), IN AÑO_FUNDACION INT)

BEGIN
	IF (ID_EQUIPO = 0 OR NOMBRE = NULL OR AÑO_FUNDACION = 0) 
    THEN
		SET @MAL = 'LOS DATOS INGRESADOS SON INCORRECTOS';
        SELECT @MAL;
	ELSE
		INSERT INTO EQUIPOS VALUES (ID_EQUIPO, NOMBRE, AÑO_FUNDACION);
		END IF;
END
$$

-- CALL SP_INSERTAR_EQUIPO_VALIDACION (23, 'RACING', 0);
-- SELECT * FROM EQUIPOS;

-- TRIGGERS

CREATE TABLE AUDITORIAS (
	ID_LOG INT PRIMARY KEY auto_increment,
    ENTIDAD varchar(100),
    ID_ENTIDAD int,
    OPERACION varchar(50),
    INSERCION datetime,
    CREACION varchar(100)
);

CREATE TRIGGER `TR_INSERCION_EQUIPOS_AUDITORIA`
AFTER INSERT ON `EQUIPOS`
FOR EACH ROW
INSERT INTO `AUDITORIAS`(ENTIDAD, ID_ENTIDAD, OPERACION, INSERCION, CREACION) 
VALUES ('NOMBRE', NEW.ID_EQUIPO, 'INSERCION', CURRENT_TIMESTAMP(), USER());

-- INSERT INTO EQUIPOS VALUES (23, 'RACING', 2002);

-- SELECT * FROM AUDITORIAS; 

DELIMITER //
CREATE TRIGGER ASIGNACION_ARBITRO
BEFORE INSERT ON PARTIDOS
FOR EACH ROW
BEGIN
  DECLARE ID_ARBITRO INT;

  SELECT ID_ARBITRO 
  INTO ID_ARBITRO 
  FROM ARBITROS 
  ORDER BY RAND() LIMIT 1;
  SET NEW.ID_ARBITRO = ID_ARBITRO;
END;
//
DELIMITER ;

-- INSERT INTO PARTIDOS (ID_EQUIPO_LOCAL, ID_EQUIPO_VISITANTE, FECHA, ID_ARBITRO, ID_ESTADIO) VALUES (1, 2, curdate(), 20, 3); 

-- SELECT * FROM PARTIDOS; 


