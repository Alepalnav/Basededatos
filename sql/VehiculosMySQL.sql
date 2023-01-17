create database vehiculos;
user vehiculos;

CREATE TABLE VEHICULOS 
(
	matricula VARCHAR (7),
	marca VARCHAR (10) NOT NULL ,
	modelo VARCHAR (10) NOT NULL ,
	fecha_compra DATE,
	precio NUMBER(5,2),
	CONSTRAINT Pk_VEHICULOS PRIMARY KEY (matricula)
	CONSTRAINT chk_vehiculos CHECK [EXTRACT(YEAR FROM fecha_compra)>2001],
	CONSTRAINT chk1_vehiculos CHECK (precio>0) 
);

CREATE TABLE CLIENTES 
(
	dni VARCHAR (9), 
	nombre varchar (30) NOT NULL,
	nacionalidad varchar (30),
	fechaNac DATE,
	direccion varchar (50),
	CONSTRAINT Pk_CLIENTES PRIMARY KEY (dni)
);


CREATE TABLE ALQUILERES 
(
	matricula varchar (7) NOT NULL,
	dni varchar (10) NOT NULL,
	fechaHora DATE,
	numDias integer(2) NOT NULL,
	kilometros integer(4) DEFAULT (0),
	CONSTRAINT Pk_ALQUILERES PRIMARY KEY (matricula,dni,fechaHora)
	
);

ALTER TABLE CLIENTES ADD CONSTRAINT chk_clientes CHECK (regexp_like(dni,'^[0-9]{8}-[A-Z|[a-z]{1}$');
ALTER TABLE VEHICULOS ADD totalKM integer(7);