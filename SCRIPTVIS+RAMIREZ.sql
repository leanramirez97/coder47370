USE PREMIER3;

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
SELECT 	A.NOMBRE AS CLUB,
		A.AÑO_FUNDACION,
        B.NOMBRE AS ESTADIO,
        B.CIUDAD,
        B.CAPACIDAD
FROM   	EQUIPOS A
	INNER JOIN ESTADIOS B
		ON A.ID_EQUIPO = B.ID_EQUIPO;


CREATE VIEW VW_PARTIDOS_DETALLE AS
SELECT 	A.ID_PARTIDO,
		A.FECHA AS FECHA_PARTIDO,
		B.NOMBRE AS ESTADIO,
		CONCAT(C.NOMBRE,' ',C.APELLIDO) AS ARBITRO
FROM	PARTIDOS A
	INNER JOIN ESTADIOS B
		ON A.ID_ESTADIO = B.ID_ESTADIO
	INNER JOIN ARBITROS C
		ON A.ID_ARBITRO = C.ID_ARBITRO
WHERE	B.CIUDAD = 'Londres'
ORDER	BY 1 ASC;

CREATE VIEW VW_ESTADIOS_MUNDIALISTAS AS
SELECT A.NOMBRE AS CLUB, B.NOMBRE AS ESTADIO, B.CIUDAD
FROM EQUIPOS A
INNER JOIN ESTADIOS B
ON A.ID_EQUIPO = B.ID_EQUIPO
WHERE B.CAPACIDAD >= 50000;
