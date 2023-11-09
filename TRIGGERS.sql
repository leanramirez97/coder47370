USE PREMIER3;

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

INSERT INTO EQUIPOS VALUES (23, 'RACING', 2002);

SELECT * 
FROM AUDITORIAS;


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

INSERT INTO PARTIDOS (ID_EQUIPO_LOCAL, ID_EQUIPO_VISITANTE, FECHA, ID_ARBITRO, ID_ESTADIO)
VALUES (1, 2, curdate(), 20, 3);

SELECT * FROM PARTIDOS;