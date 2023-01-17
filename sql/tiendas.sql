CREATE TABLE fabricantes 
(
	cod_fabricante number(3),
	nombre varchar2(15),
	pais varchar2(15),
CONSTRAINT pk_table PRIMARY KEY (cod_fabricante),
CONSTRAINT ck1_table CHECK (upper(nombre)=nombre),
CONSTRAINT ck2_table CHECK (upper(pais)=pais)
);

CREATE TABLE articulos (
	articulo varchar2(20),
	cod_fabricante number(3),
	peso NUMBER(3),
	categoria varchar2 (10), 
	precio_venta NUMBER (4,2),
	precio_costo NUMBER (4,2),
	existencias NUMBER (5),
CONSTRAINT pk_articulos PRIMARY KEY (articulo, cod_fabricante, peso, categoria),
CONSTRAINT fk_articulos FOREIGN KEY (cod_fabricante) REFERENCES fabricantes(cod_fabricante),

CONSTRAINT ck1_articulo CHECK (precio_venta > 0),
CONSTRAINT ck2_articulo CHECK (precio_costo > 0),
CONSTRAINT ck3_articulo CHECK (peso >= 1),
CONSTRAINT ck4_articulo CHECK (categoria IN ('PRIMERA', 'SEGUNDA', 'TERCERA'))

);

CREATE TABLE tiendas (
	nif varchar2(10),
	nombre varchar2(20),
	direccion varchar2(20),
	
	poblacion varchar2(20),
	provincia varchar2(20),
	codpostal number(5),
CONSTRAINT pk_tiendas PRIMARY KEY (nif),
CONSTRAINT ck1_tiendas CHECK (upper(provincia)=provincia))

);

CREATE TABLE pedidos (
	nif varchar2(10),
	articulo varchar2(20),
	cod_fabricante NUMBER(3),
	peso number(3),
	categoria varchar2(10),
	fecha_pedido DATE,
	unidades_pedidas number(4),
CONSTRAINT pk1_table PRIMARY KEY (nif, articulo, cod_fabricante, peso, categoria, fecha_pedido),
CONSTRAINT fk1_table FOREIGN KEY (cod_fabricante) REFERENCES fabricantes(cod_fabricante),
CONSTRAINT fk2_table FOREIGN KEY (articulo, cod_fabricante, peso, categoria) REFERENCES articulos (articulo, cod_fabricante, peso, categoria) ON DELETE CASCADE,
CONSTRAINT fk3_table FOREIGN KEY (nif) REFERENCES tiendas(nif),

CONSTRAINT ck_table CHECK (unidades_pedidas > 0)


);

CREATE TABLE ventas (
	nif varchar2(10),
	articulo varchar2(20),
	cod_fabricante number(3),
	peso number(3),
	categoria varchar2(10),
	fecha_venta DATE DEFAULT sysdate,
	unidades_vendidas number(4),
CONSTRAINT pk1_ventas PRIMARY KEY (nif, articulo, cod_fabricante, peso, categoria, fecha_venta),
CONSTRAINT fk1_ventas FOREIGN KEY (cod_fabricante) REFERENCES fabricantes(cod_fabricante),
CONSTRAINT fk2_ventas FOREIGN KEY (articulo,cod_fabricante, peso, categoria) REFERENCES articulos (articulo, cod_fabricante, peso, categoria) ON DELETE CASCADE,
CONSTRAINT fk3_ventas FOREIGN KEY (nif) REFERENCES tiendas(nif),

CONSTRAINT ck_ventas CHECK (unidades_vendidas > 0)

);

/* añadir a las tablas pedidos y ventas una nueva columna para que almacenen el pvp del articulo */

ALTER TABLE pedidos ADD pvp NUMBER(6,2);

ALTER TABLE ventas ADD pvp NUMBER(6,2);

/*borra ña columna pais de la tabla fabricante */

ALTER TABLE fabricantes DROP COLUMN pais;

/*añade una restriccion que indique que las unidades vendidas son como minimo 100 */

ALTER TABLE ventas ADD CONSTRAINT ch2_ventas CHECK (unidades_vendidas >= 100);

/*Borrar la anterior */ 

ALTER TABLE ventas DROP CONSTRAINT ch2_ventas;

/*Borra todas las tablas creadas */ 

DROP TABLE ventas CASCADE CONSTRAINTS;
