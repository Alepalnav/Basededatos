
--1.	Descuento medio aplicado en las facturas.

SELECT AVG(DTO)
FROM FACTURAS f ;

--2.	Descuento medio aplicado en las facturas sin considerar los valores nulos.

SELECT AVG(DTO)
FROM FACTURAS ;

--3.	Descuento medio aplicado en las facturas considerando los
-- valores nulos como cero.

SELECT AVG(NVL(DTO,0))
FROM FACTURAS ;

--4.	Número de facturas.

SELECT COUNT(CODFAC)
FROM FACTURAS;

--5.	Número de pueblos de la Comunidad de Valencia.

SELECT COUNT(CODPUE)
FROM PUEBLOS P, PROVINCIAS P2
WHERE P.CODPRO = P2.CODPRO 
AND P2.NOMBRE IN('VALENCIA','ALICANTE','CASTELLON');

--6.	Importe total de los artículos que tenemos en el almacén.
-- Este importe se calcula sumando el producto de las unidades en stock por 
--el precio de cada unidad

SELECT SUM(STOCK*PRECIO)
FROM ARTICULOS;

--7.	Número de pueblos en los que residen clientes cuyo código postal empieza por ‘12’.

SELECT COUNT(P.CODPUE)
FROM PUEBLOS p , CLIENTES c 
WHERE C.CODPUE = P.CODPUE 
AND C.CODPOSTAL LIKE '12%';

--8.	Valores máximo y mínimo del stock de los artículos cuyo precio oscila entre 9 y 12 € 
--y diferencia entre ambos valores

SELECT MAX(A.STOCK), MIN(A.STOCK), MAX(A.STOCK)-MIN(A.STOCK) AS DIFERENCIA
FROM ARTICULOS a 
WHERE PRECIO BETWEEN 9 AND 12;

--9.	Precio medio de los artículos cuyo stock supera las 10 unidades.

SELECT AVG(A.PRECIO)
FROM ARTICULOS a 
WHERE A.STOCK > 10;

--10.	Fecha de la primera y la última factura del cliente con código 210.

SELECT MIN(F.FECHA), MAX(F.FECHA)
FROM FACTURAS f 
WHERE F.CODCLI LIKE '219';

--11.	Número de artículos cuyo stock es nulo.

SELECT COUNT(A.CODART)
FROM ARTICULOS a 
WHERE A.STOCK IS NULL;

--12.	Número de líneas cuyo descuento es nulo (con un decimal)

SELECT TO_NUMBER(COUNT(LF.DTO),'99.9')
FROM LINEAS_FAC lf 
WHERE LF.DTO IS NULL;

--13.	Obtener cuántas facturas tiene cada cliente.

SELECT COUNT(F.CODFAC)
FROM FACTURAS f , CLIENTES c 
WHERE F.CODCLI = C.CODCLI ;

--14.	Obtener cuántas facturas tiene cada cliente, pero sólo si tiene dos o más  facturas.

SELECT COUNT(F.CODFAC)
FROM FACTURAS f , CLIENTES c 
WHERE F.CODCLI = C.CODCLI
HAVING COUNT(F.CODFAC)>=2;

--15.	Importe de la facturación (suma del producto de la cantidad por el precio de las líneas de factura) 
-- de los  artículos

SELECT SUM(CANT*PRECIO)
FROM LINEAS_FAC lf;

--16.	Importe de la facturación (suma del producto de la cantidad por el precio de las líneas de factura)
-- de aquellos artículos cuyo código contiene la letra “A” (bien mayúscula o minúscula).

SELECT SUM(CANT*PRECIO)
FROM LINEAS_FAC lf 
WHERE UPPER(CODART) LIKE '%A%';

--17.	Número de facturas para cada fecha, junto con la fecha

SELECT COUNT(CODFAC), FECHA 
FROM FACTURAS f 
GROUP BY FECHA;

--18.	Obtener el número de clientes del pueblo junto con el nombre del pueblo mostrando primero los 
--pueblos que más clientes tengan.

SELECT COUNT(C.CODCLI), P.NOMBRE
FROM CLIENTES c , PUEBLOS p 
GROUP BY P.NOMBRE
ORDER BY COUNT(C.CODCLI) DESC; 

--19.	Obtener el número de clientes del pueblo junto con el nombre del pueblo mostrando primero los pueblos 
-- que más clientes tengan, siempre y cuando tengan más de dos clientes.

SELECT COUNT(C.CODCLI), P.NOMBRE
FROM CLIENTES c , PUEBLOS p 
WHERE P.CODPUE = C.CODPUE 
GROUP BY P.NOMBRE 
HAVING COUNT(C.CODCLI)>2
ORDER BY COUNT(C.CODCLI) DESC;

--20.	Cantidades totales vendidas para cada artículo cuyo código empieza por “P", mostrando también
-- la descripción de dicho artículo.

SELECT SUM(LF.CANT), A.CODART, A.DESCRIP
FROM ARTICULOS a , LINEAS_FAC lf 
WHERE LF.CODART = A.CODART 
AND A.CODART LIKE 'P%'
GROUP BY A.DESCRIP ;
 


--22.	Nombre de aquellos artículos de los que se ha facturado más de 10000 euros.

SELECT A.DESCRIP
FROM ARTICULOS a , LINEAS_FAC lf 
WHERE A.CODART = LF.CODART 
AND (LF.CANT*A.PRECIO)>10000;

--23.	Número de facturas de cada uno de los clientes cuyo código está entre 150 y 300 
--(se debe mostrar este código), con cada IVA distinto que se les ha aplicado.

SELECT COUNT(F.CODFAC), C.CODCLI, F.IVA 
FROM FACTURAS f , CLIENTES c 
WHERE C.CODCLI BETWEEN 150 AND 300
GROUP BY C.CODCLI, F.IVA;

--24.	Media del importe de las facturas, sin tener en cuenta impuestos ni descuentos

SELECT AVG(NVL(LF.CANT,0)*NVL(A.PRECIO,O)
FROM ARTICULOS a , LINEAS_FAC lf 
WHERE A.CODART = LF.CODART ;




