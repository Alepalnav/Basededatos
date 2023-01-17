
DROP TABLE TEMA
DROP TABLE AUTOR
DROP TABLE LIBRO
DROP TABLE LIBRO_AUTOR
DROP TABLE EDITORIAL
DROP TABLE PUBLICACIONES


CREATE TABLE TEMA 
(
	COD_TEMA NUMBER(20),
	DENOMINACION VARCHAR2(50),
	COD_TEMA_PADRE NUMBER(20) NOT NULL,
CONSTRAINT PK_TABLE PRIMARY KEY (COD_TEMA),
CONSTRAINT FK1_TABLE FOREIGN KEY (COD_TEMA_PADRE) REFERENCES TEMA(COD_TEMA),
CONSTRAINT CK_codTema CHECK ([0-9] AND COD_TEMA < COD_TEMA_PADRE)
);

CREATE TABLE AUTOR
(
	COD_AUTOR NUMBER(20),
	NOMBRE VARCHAR2(20),
	F_NACIMIENTO DATE,
	LIBRO_PRINCIPAL VARCHAR2(20) NOT NULL,
CONSTRAINT PK_AUTOR PRIMARY KEY (COD_AUTOR)
);

CREATE TABLE LIBRO
(
	COD_LIBRO NUMBER(20),
	TITULO VARCHAR2(20),
	F_CREACION DATE,
	COD_TEMA NUMBER(20) NOT NULL,
	AUTOR_PRINCIPAL VARCHAR2(20),
CONSTRAINT PK_LIBRO PRIMARY KEY (COD_LIBRO),
CONSTRAINT FK1_LIBRO FOREIGN KEY (COD_TEMA) REFERENCES TEMA(COD_TEMA)
);

CREATE TABLE LIBRO_AUTOR
(
	COD_LIBRO NUMBER(20),
	COD_AUTOR NUMBER(20),
	ORDEN NUMBER(20),
CONSTRAINT PK_LIBRO_AUTOR PRIMARY KEY (COD_LIBRO, COD_AUTOR),
CONSTRAINT FK1_LIBRO_AUTOR FOREIGN KEY (COD_LIBRO) REFERENCES LIBRO(COD_LIBRO),
CONSTRAINT FK2_LIBRO_AUTOR FOREIGN KEY (COD_AUTOR) REFERENCES AUTOR(COD_AUTOR),
CONSTRAINT CK_orden CHECK (1<= orden <= 5)
);

CREATE TABLE EDITORIAL 
(
	COD_EDITORIAL NUMBER(20),
	DENOMINACION VARCHAR2(30),
CONSTRAINT PK1_EDITORIAL PRIMARY KEY (COD_EDITORIAL),
CONSTRAINT CK_editorial CHECK (DELETE ON CASCADE) 
);

CREATE TABLE PUBLICACIONES 
(
	COD_EDITORIAL NUMBER(30),
	COD_LIBRO NUMBER(20),
	PRECIO NUMBER(5,2),
	F_PUBLICACION DATE,
CONSTRAINT PK_PUBLICACIONES PRIMARY KEY (COD_EDITORIAL, COD_LIBRO),
CONSTRAINT FK1_PUBLICACIONES FOREIGN KEY (COD_LIBRO) REFERENCES LIBRO(COD_LIBRO),
CONSTRAINT FK2_PUBLICACIONES FOREIGN KEY (COD_EDITORIAL) REFERENCES EDITORIAL(COD_EDITORIAL),
CONSTRAINT CK_precio CHECK (NOT NULL AND precio > 0)
);


ALTER TABLE LIBRO ADD CONSTRAINT FK2_LIBRO FOREIGN KEY (AUTOR_PRINCIPAL) REFERENCES AUTOR(COD_AUTOR);
ALTER TABLE AUTOR ADD CONSTRAINT FK1_AUTOR FOREIGN KEY (LIBRO_PRINCIPAL) REFERENCES LIBRO(COD_LIBRO);


