
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

SELECT `NOMBRE_EQUIPO` (8)


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


SELECT PARTIDOS_POR_ARBITRO (3)
