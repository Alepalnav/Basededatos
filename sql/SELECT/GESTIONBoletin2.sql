--1.	Mostrar el nombre de los clientes junto al nombre de su pueblo.
SELECT C.NOMBRE, P.NOMBRE 
FROM CLIENTES C, PUEBLOS P
WHERE C.CODPUE = P.CODPUE ;

--2.	Mostrar el nombre de los pueblos junto con el nombre de la provincia correspondiente.

SELECT P.NOMBRE, P2.NOMBRE 
FROM PUEBLOS P, PROVINCIAS P2
WHERE P.CODPRO = P2.CODPRO ;

--3.	Mostrar el nombre de los clientes junto al nombre de su pueblo y el de su provincia.

SELECT C.NOMBRE , P.NOMBRE , P2.NOMBRE 
FROM CLIENTES C, PUEBLOS P, PROVINCIAS P2
WHERE C.CODPUE = P.CODPUE 
AND P.CODPRO = P2.CODPRO ;

--4.	Nombre de las provincias donde residen clientes sin que salgan valores repetidos.

SELECT DISTINCT P2.NOMBRE 
FROM CLIENTES C, PUEBLOS P, PROVINCIAS P2
WHERE C.CODPUE = P.CODPUE 
AND P.CODPRO = P2.CODPRO ;

--5.	Mostrar la descripción de los artículos que se han vendido en una cantidad superior a 10 unidades. 
--Si un artículo se ha vendido más de una vez en una cantidad superior a 10 sólo debe salir una vez.

SELECT DISTINCT A.DESCRIP 
FROM ARTICULOS A, LINEAS_FAC LF
WHERE A.CODART = LF.CODART 
AND LF.CANT > 10;

--6.	Mostrar la fecha de factura junto con el código del artículo y la cantidad vendida por cada artículo vendido en alguna factura.
-- Los datos deben salir ordenado por fecha, primero las más reciente, luego por el código del artículos, 
-- y si el mismo artículo se ha vendido varias veces en la misma fecha los más vendidos primero.

SELECT LF.CODART ,F.FECHA , LF.CANT 
FROM LINEAS_FAC LF, FACTURAS F
WHERE LF.CODFAC = F.CODFAC 
ORDER BY F.FECHA DESC , LF.CODART , LF.CANT DESC ;

--7.	Mostrar el código de factura y la fecha de las mismas de las facturas que se han facturado a un cliente que tenga en su código postal un 7.

SELECT F.CODFAC , F.FECHA 
FROM FACTURAS F, CLIENTES C
WHERE C.CODCLI = F.CODCLI 
AND C.CODPOSTAL LIKE '%7%';

--8.	Mostrar el código de factura, la fecha y el nombre del cliente de todas las facturas existentes en la base de datos.

SELECT F.CODFAC , F.FECHA , C.NOMBRE 
FROM FACTURAS F, CLIENTES C
WHERE C.CODCLI = F.CODCLI ;

--9.	Mostrar un listado con el código de la factura, la fecha, el iva, el dto y el nombre del cliente para aquellas facturas que o bien no se le ha cobrado iva 
--(no se ha cobrado iva si el iva es nulo o cero), o bien el descuento es nulo.

SELECT F.CODFAC , F.FECHA , F.IVA , F.DTO , C.NOMBRE 
FROM FACTURAS F, CLIENTES C
WHERE F.CODCLI = C.CODCLI 
AND (F.IVA IS NULL OR F.IVA = 0) OR F.DTO IS NULL;

--10.	Se quiere saber que artículos se han vendido más baratos que el precio que actualmente tenemos almacenados en la tabla de artículos, 
--para ello se necesita mostrar la descripción de los artículos junto con el precio actual. 
--Además deberá aparecer el precio en que se vendió si este precio es inferior al precio original.

SELECT A.DESCRIP , A.PRECIO , LF.PRECIO AS PRECIO_VENDIDO
FROM ARTICULOS A, LINEAS_FAC LF
WHERE A.CODART = LF.CODART 
AND A.PRECIO > LF.PRECIO ;

--11.	Mostrar el código de las facturas, junto a la fecha, iva y descuento. 
--También debe aparecer la descripción de los artículos vendido junto al precio de venta, la cantidad y el descuento de ese artículo,
-- para todos los artículos que se han vendido.

SELECT F.CODFAC, F.FECHA, F.IVA ,F.DTO , A.DESCRIP  
FROM ARTICULOS A, LINEAS_FAC LF, FACTURAS F
WHERE A.CODART = LF.CODART 
AND LF.CODFAC = F.CODFAC ;

--12.	Igual que el anterior, pero mostrando también el nombre del cliente al que se le ha vendido el artículo.

SELECT F.CODFAC, F.FECHA, F.IVA ,F.DTO , A.DESCRIP, C.NOMBRE 
FROM ARTICULOS A, LINEAS_FAC LF, FACTURAS F, CLIENTES C
WHERE A.CODART = LF.CODART 
AND LF.CODFAC = F.CODFAC 
AND F.CODCLI = C.CODCLI ;

--13.	Mostrar los nombres de los clientes que viven en una provincia que contenga la letra ma.

SELECT C.NOMBRE 
FROM CLIENTES C, PUEBLOS P, PROVINCIAS P2
WHERE C.CODPUE = P.CODPUE 
AND P.CODPRO = P2.CODPRO 
AND UPPER(P2.NOMBRE) LIKE '%MA%';

--14.	Mostrar el código del cliente al que se le ha vendido un artículo que tienen un stock menor al stock mínimo.

SELECT F.CODCLI 
FROM ARTICULOS A, LINEAS_FAC LF, FACTURAS F
WHERE A.CODART = LF.CODART 
AND LF.CODFAC = F.CODFAC 
AND A.STOCK < A.STOCK_MIN ;

--15.	Mostrar el nombre de todos los artículos que se han vendido alguna vez. (no deben salir valores repetidos)

SELECT DISTINCT A.DESCRIP  
FROM ARTICULOS A, LINEAS_FAC LF
WHERE A.CODART = LF.CODART;

--16.	Se quiere saber el precio real al que se ha vendido cada vez los artículos. 
--Para ello es necesario mostrar el nombre del artículo, junto con el precio de venta (no el que está almacenado en la tabla de artículos) 
--menos el descuento aplicado en la línea de descuento.

SELECT 



