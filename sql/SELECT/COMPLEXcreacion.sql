CREATE TABLE FABRICANTE
(
	ID_FAB INTEGER(1),
	NOMBRE VARCHAR(12),
	PAIS VARCHAR(15),
	CONSTRAINT PK_FABRICANTE PRIMARY KEY (ID_FAB)
);

CREATE TABLE PROGRAMA
(
	CODIGO INTEGER(2),
	NOMBRE VARCHAR(30),
	VERSION_PROG VARCHAR(15),
	CONSTRAINT PK_PROGRAMA PRIMARY KEY (CODIGO)
);

CREATE TABLE COMERCIO
(
	CIF INTEGER(1),
	NOMBRE VARCHAR(20),
	CIUDAD VARCHAR(10),
	CONSTRAINT PK_COMERCIO PRIMARY KEY (CIF)
);

CREATE TABLE CLIENTE
(
	DNI INTEGER(1),
	NOMBRE VARCHAR(20),
	EDAD INTEGER(2),
	CONSTRAINT PK_CLIENTE PRIMARY KEY (DNI)
);

CREATE TABLE DESARROLLA
(
	ID_FAB INTEGER(1),
	CODIGO INTEGER(2),
	CONSTRAINT PK_DESARROLLA PRIMARY KEY (ID_FAB, CODIGO),
	CONSTRAINT FK1_DESARROLLA FOREIGN KEY (ID_FAB) REFERENCES FABRICANTE(ID_FAB),
	CONSTRAINT FK2_DESARROLLA FOREIGN KEY (CODIGO) REFERENCES PROGRAMA(CODIGO)
);

CREATE TABLE DISTRIBUYE
(
	CIF INTEGER(1),
	CODIGO INTEGER(2),
	CANTIDAD INTEGER(2),
	CONSTRAINT PK_DISTRIBUYE PRIMARY KEY (CIF, CODIGO),
	CONSTRAINT FK1_DISTRIBUYE FOREIGN KEY (CIF) REFERENCES COMERCIO(CIF),
	CONSTRAINT FK2_DISTRIBUYE FOREIGN KEY (CODIGO) REFERENCES PROGRAMA(CODIGO)
);

CREATE TABLE REGISTRA
(
	CIF INTEGER(1),
	DNI INTEGER(1),
	CODIGO INTEGER(2),
	MEDIO VARCHAR(15),
	CONSTRAINT PK_REGISTRA PRIMARY KEY (CIF, DNI, CODIGO),
	CONSTRAINT FK1_REGISTRA FOREIGN KEY (CIF) REFERENCES COMERCIO(CIF),
	CONSTRAINT FK2_REGISTRA FOREIGN KEY (DNI) REFERENCES CLIENTE(DNI),
	CONSTRAINT FK3_REGISTRA FOREIGN KEY (CODIGO) REFERENCES PROGRAMA(CODIGO)
);

INSERT INTO FABRICANTE VALUES (1, 'ORACLE', 'ESTADOS UNIDOS');
INSERT INTO FABRICANTE VALUES (2, 'MICROSOFT', 'ESTADOS UNIDOS');
INSERT INTO FABRICANTE VALUES (3, 'IBM', 'ESTADOS UNIDOS');
INSERT INTO FABRICANTE VALUES (4, 'DINAMIC', 'ESPAÑA');
INSERT INTO FABRICANTE VALUES (5, 'BORLAND', 'ESTADOS UNIDOS');
INSERT INTO FABRICANTE VALUES (6, 'SYMANTEC', 'ESTADOS UNIDOS');

INSERT INTO PROGRAMA VALUES (1, 'APPLICATION SERVER', '9i');
INSERT INTO PROGRAMA VALUES (2, 'DATABASE', '8i');
INSERT INTO PROGRAMA VALUES (3, 'DATABASE', '9i');
INSERT INTO PROGRAMA VALUES (4, 'DATABASE', '10g');
INSERT INTO PROGRAMA VALUES (5, 'DEVELOPER', '6i');
INSERT INTO PROGRAMA VALUES (6, 'ACCESS', '97');
INSERT INTO PROGRAMA VALUES (7, 'ACCESS', '2000');
INSERT INTO PROGRAMA VALUES (8, 'ACCESS', 'XP');
INSERT INTO PROGRAMA VALUES (9, 'WINDOWS', '98');
INSERT INTO PROGRAMA VALUES (10, 'WINDOWS', 'XP PROFESIONAL');
INSERT INTO PROGRAMA VALUES (11, 'WINDOWS', 'XP HOME EDITION');
INSERT INTO PROGRAMA VALUES (12, 'WINDOWS', '2003 SERVER');
INSERT INTO PROGRAMA VALUES (13, 'NORTON INTERNET SECURITY', '2004');
INSERT INTO PROGRAMA VALUES (14, 'FREDDY HARDEST', '-');
INSERT INTO PROGRAMA VALUES (15, 'PARADOX', '2');
INSERT INTO PROGRAMA VALUES (16, 'C++ BUILDER', '55');
INSERT INTO PROGRAMA VALUES (17, 'DB/2', '20');
INSERT INTO PROGRAMA VALUES (18, 'OS/2', '10');
INSERT INTO PROGRAMA VALUES (19, 'JBUILDER', 'X');
INSERT INTO PROGRAMA VALUES (20, 'LA PRISION', '10');

INSERT INTO COMERCIO VALUES (1, 'EL CORTE INGLÉS', 'SEVILLA');
INSERT INTO COMERCIO VALUES (2, 'EL CORTE INGLÉS', 'MADRID');
INSERT INTO COMERCIO VALUES (3, 'JUMP', 'VALENCIA');
INSERT INTO COMERCIO VALUES (4, 'CENTRO MAIL', 'SEVILLA');
INSERT INTO COMERCIO VALUES (5, 'FNAC', 'BARCELONA');

INSERT INTO CLIENTE VALUES (1, 'PEPE PÉREZ', 45);
INSERT INTO CLIENTE VALUES (2, 'JUAN GONZÁLEZ', 45);
INSERT INTO CLIENTE VALUES (3, 'MARÍA GÓMEZ', 33);
INSERT INTO CLIENTE VALUES (4, 'JAVIER CASADO', 18);
INSERT INTO CLIENTE VALUES (5, 'NURIA SÁNCHEZ', 29);
INSERT INTO CLIENTE VALUES (6, 'ANTONIO NAVARRO', 58);

INSERT INTO DESARROLLA VALUES (1, 1);
INSERT INTO DESARROLLA VALUES (1, 2);
INSERT INTO DESARROLLA VALUES (1, 3);
INSERT INTO DESARROLLA VALUES (1, 4);
INSERT INTO DESARROLLA VALUES (1, 5);
INSERT INTO DESARROLLA VALUES (2, 6);
INSERT INTO DESARROLLA VALUES (2, 7);
INSERT INTO DESARROLLA VALUES (2, 8);
INSERT INTO DESARROLLA VALUES (2, 9);
INSERT INTO DESARROLLA VALUES (2, 10);
INSERT INTO DESARROLLA VALUES (2, 11);
INSERT INTO DESARROLLA VALUES (2, 12);
INSERT INTO DESARROLLA VALUES (6, 13);
INSERT INTO DESARROLLA VALUES (4, 14);
INSERT INTO DESARROLLA VALUES (5, 15);
INSERT INTO DESARROLLA VALUES (5, 16);
INSERT INTO DESARROLLA VALUES (3, 17);
INSERT INTO DESARROLLA VALUES (3, 18);
INSERT INTO DESARROLLA VALUES (5, 19);
INSERT INTO DESARROLLA VALUES (4, 20);

INSERT INTO DISTRIBUYE VALUES (1, 1, 10);
INSERT INTO DISTRIBUYE VALUES (1, 2, 11);
INSERT INTO DISTRIBUYE VALUES (1, 6, 5);
INSERT INTO DISTRIBUYE VALUES (1, 7, 3);
INSERT INTO DISTRIBUYE VALUES (1, 10, 5);
INSERT INTO DISTRIBUYE VALUES (1, 13, 7);
INSERT INTO DISTRIBUYE VALUES (2, 1, 6);
INSERT INTO DISTRIBUYE VALUES (2, 2, 6);
INSERT INTO DISTRIBUYE VALUES (2, 6, 4);
INSERT INTO DISTRIBUYE VALUES (2, 7, 7);
INSERT INTO DISTRIBUYE VALUES (3, 10, 8);
INSERT INTO DISTRIBUYE VALUES (3, 13, 5);
INSERT INTO DISTRIBUYE VALUES (4, 14, 3);
INSERT INTO DISTRIBUYE VALUES (4, 20, 6);
INSERT INTO DISTRIBUYE VALUES (5, 15, 8);
INSERT INTO DISTRIBUYE VALUES (5, 16, 2);
INSERT INTO DISTRIBUYE VALUES (5, 17, 3);
INSERT INTO DISTRIBUYE VALUES (5, 19, 6);
INSERT INTO DISTRIBUYE VALUES (5, 8, 8);

INSERT INTO REGISTRA VALUES (1, 1, 1, 'INTERNET');
INSERT INTO REGISTRA VALUES (1, 3, 4, 'TARJETA POSTAL');
INSERT INTO REGISTRA VALUES (4, 2, 10, 'TELÉFONO');
INSERT INTO REGISTRA VALUES (4, 1, 10, 'TARJETA POSTAL');
INSERT INTO REGISTRA VALUES (5, 2, 12, 'INTERNET');
INSERT INTO REGISTRA VALUES (2, 4, 15, 'INTERNET');