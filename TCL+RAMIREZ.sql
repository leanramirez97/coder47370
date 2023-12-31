START TRANSACTION;

-- Obtener ID del equipo a eliminar.
SET @ELIMINAR = (SELECT ID_EQUIPO FROM EQUIPOS WHERE nombre = 'West Ham');
SELECT @ELIMINAR;

SELECT * 
FROM EQUIPOS;

-- Eliminar jugadores del equipo.
DELETE FROM JUGADORES WHERE ID_EQUIPO = @ELIMINAR;
SELECT *
FROM EQUIPOS;
-- ROLLBACK;

-- COMMIT;

START TRANSACTION;

INSERT INTO EQUIPOS VALUES (24,'CHACARITA', 1973);
INSERT INTO EQUIPOS VALUES (25,'ALDOSIVI', 1987);
INSERT INTO EQUIPOS VALUES (26,'QUILMES', 1974);
INSERT INTO EQUIPOS VALUES (27,'COLEGIALES', 1993);
SAVEPOINT SV_1;
INSERT INTO EQUIPOS VALUES (28,'OLIMPO', 1979);
INSERT INTO EQUIPOS VALUES (29,'TALLERES', 1997);
INSERT INTO EQUIPOS VALUES (30,'BELGRANO', 1982);
INSERT INTO EQUIPOS VALUES (31,'FERRO', 1976);
SAVEPOINT SV_2;

SELECT * 
FROM EQUIPOS;
ROLLBACK TO SV_1;
SELECT * 
FROM EQUIPOS
-- RELEASE SAVEPOINT SV_2;
