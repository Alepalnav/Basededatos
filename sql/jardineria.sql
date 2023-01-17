CREATE TABLE jugadores 
(
	codigo_producto varchar(15)
	nombre varchar(70)
	gama varchar(50)
	dimensiones varchar(25)
	proveedor varchar(50)
	descripcion TEXT 
	cantidad_en_stock smallint(6)
	precio_venta DECIMAL(15,2)
	precio_proveedor DECIMAL(15,2)
);

CREATE table gama_producto 
(
	gama varchar(50)
	descripcion_texto text 
	descripcion_html text
	imagen varchar(256)

)