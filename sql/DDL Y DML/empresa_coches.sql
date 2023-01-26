CREATE TABLE jugadores 
(
	cod_jugador varchar2 (4),
	nombre varchar2 (30) NOT NULL,
	fecha_nac DATE,
	demarcacion varchar2 (10),
	cod_equipo varchar2 (4),
	CONSTRAINT pk_jugadores PRIMARY KEY (cod_jugador),
	CONSTRAINT fk1_jugadores FOREIGN KEY (cod_equipo) REFERENCES equipos(cod_equipo)
);

CREATE TABLE equipos 
(
	cod_equipo varchar2 (4),
	nombre varchar2 (30) NOT NULL,
	localidad varchar2 (15),
	CONSTRAINT pk_equipos PRIMARY KEY (cod_equipo)
);

CREATE TABLE partidos 
(
	cod_partido varchar2 (4),
	cod_equipo_local varchar2 (4),
	cod_equipo_visitante varchar2 (4),
	fecha DATE,
	competicion varchar2 (4),
	jornada varchar2 (20),
	CONSTRAINT pk_partidos PRIMARY KEY (cod_partido),
	CONSTRAINT fk1_partidos FOREIGN KEY (cod_equipo_local) REFERENCES equipos(cod_equipo),
	CONSTRAINT fk2_partidos FOREIGN KEY (cod_equipo_visitante) REFERENCES equipos(cod_equipo)
);

CREATE TABLE incidencias 
(
	num_incidencia varchar2 (6),
	cod_partido varchar2 (4),
	cod_jugador varchar2 (4),
	minuto NUMBER (2),
	tipo varchar2 (20),
	CONSTRAINT pk_incidencias PRIMARY KEY (num_incidencia),
	CONSTRAINT fk1_incidencias FOREIGN KEY (cod_partido) REFERENCES partidos(cod_partido),
	CONSTRAINT fk2_incidencias FOREIGN KEY (cod_jugador) REFERENCES jugadores(cod_jugador)
);

ALTER TABLE JUGADORES 
ADD CONSTRAINT ck_inicial_mayuscula CHECK (LIKE upper(nombre);



