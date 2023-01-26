ALTER SESSION SET "_oracle_script"=TRUE;
CREATE USER PALMANAVARROALEJANDRO IDENTIFIED BY PALMANAVARROALEJANDRO;
GRANT CONNECT, resource, DBA TO PALMANAVARROALEJANDRO;

CREATE TABLE MEDICO
(
	COD_MEDICO NUMBER(10),
	NOMBRE VARCHAR2(20),
	ESPECIALIDAD VARCHAR2(20) DEFAULT 'FAM',
	COD_DIRECTOR NUMBER(10),
CONSTRAINT PK_MEDICO PRIMARY KEY (COD_MEDICO)
);

CREATE TABLE ENFERMO
(
	COD_INSCRIPCION NUMBER(10),
	NSS VARCHAR2(10),
	NOMBRE VARCHAR2(10),
	SEXO VARCHAR(1),
CONSTRAINT PK_ENFERMO PRIMARY KEY (COD_INSCRIPCION) 
);

CREATE TABLE HABITACION
(
	NUM_HAB NUMBER(10),
	NUMERO_CAMAS NUMBER(10),
CONSTRAINT PK_HABITACION PRIMARY KEY (NUM_HAB),
CONSTRAINT CHK1_HABITACION CHECK(NUM_HAB>=100 AND NUM_HAB<=399),
CONSTRAINT CHK2_HABITACION CHECK (NUMERO_CAMAS<3)
);

CREATE TABLE INGRESO
(
	COD_INGRESO NUMBER(10),
	COD_INSCRIPCION NUMBER(10),
	FECHA_INGRESO DATE DEFAULT SYSDATE,
	FECHA_ALTA DATE,
	NUM_HAB NUMBER(10),
CONSTRAINT PK_INGRESO PRIMARY KEY (COD_INGRESO),
CONSTRAINT FK1_INGRESO  FOREIGN KEY (NUM_HAB) REFERENCES HABITACION(NUM_HAB),
CONSTRAINT FK2_INGRESO FOREIGN KEY (COD_INSCRIPCION) REFERENCES ENFERMO(COD_INSCRIPCION),
CONSTRAINT CHK1_INGRESO CHECK (FECHA_ALTA > FECHA_INGRESO)
);

CREATE TABLE VISITA 
(
	COD_MEDICO NUMBER(10),
	COD_INSCRIPCION NUMBER(10),
	FECHA DATE,
	DIAGNOSTICO VARCHAR2(10),
CONSTRAINT PK_VISITA PRIMARY KEY (COD_MEDICO, COD_INSCRIPCION),
CONSTRAINT FK1_VISITA FOREIGN KEY (COD_MEDICO) REFERENCES MEDICO(COD_MEDICO),
CONSTRAINT FK2_VISITA FOREIGN KEY (COD_INSCRIPCION) REFERENCES ENFERMO(COD_INSCRIPCION)
);

DELETE FROM HABITACION WHERE NUM_HAB NOT IN (SELECT NUM_HAB FROM INGRESO);

COMMIT;

DROP TABLE HABITACION;

