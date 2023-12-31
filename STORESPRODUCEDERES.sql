-- REGISTRO NUEVO EQUIPO
DELIMITER $$
CREATE PROCEDURE `SP_INSERTAR_EQUIPO` 
(IN ID_EQUIPO INT, IN NOMBRE VARCHAR (255), IN AÑO_FUNDACION INT)

BEGIN
INSERT INTO EQUIPOS VALUES (ID_EQUIPO, NOMBRE, AÑO_FUNDACION);
END;
$$ 

CALL SP_INSERTAR_EQUIPO (21, 'RIVER PLATE', 2023);
CALL SP_INSERTAR_EQUIPO (22, 'BOCA JUNIORS', 2022);
SELECT * 
FROM EQUIPOS;

-- REGISTRO NUEVO EQUIPO CON VALIDACION

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

CALL SP_INSERTAR_EQUIPO_VALIDACION (23, 'RACING', 0);
SELECT * 
FROM EQUIPOS;




