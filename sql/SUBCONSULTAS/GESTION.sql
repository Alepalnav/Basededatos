-- 1.	Número de clientes que tienen alguna factura con IVA 16%.

SELECT COUNT(F2.CODCLI)
FROM FACTURAS f2 
WHERE F2.CODFAC IN 
	(SELECT F.CODFAC
	FROM FACTURAS f 
	WHERE IVA = 16);
	
-- 2.	Número de clientes que no tienen ninguna factura con un 16% de IVA.

SELECT COUNT(F2.CODCLI)
FROM FACTURAS f2 
WHERE F2.CODFAC NOT IN 
	(SELECT F.CODFAC
	FROM FACTURAS f 
	WHERE IVA = 16);
	
-- 3.	Número de clientes que en todas sus facturas tienen un 16% de IVA
-- (los clientes deben tener al menos una factura).

SELECT COUNT(F2.CODCLI)
FROM FACTURAS f2 
WHERE F2.CODFAC = ALL
	(SELECT F.CODFAC
	FROM FACTURAS f 
	WHERE IVA = 16);
	
-- 4.	Fecha de la factura con mayor importe (sin tener en cuenta descuentos ni impuestos).

SELECT F.FECHA
FROM FACTURAS f, LINEAS_FAC lf 
WHERE F.CODFAC = LF.CODFAC 
AND LF.PRECIO = (SELECT MAX(LF2.PRECIO)
				FROM LINEAS_FAC lf2);
			
-- 5.	Número de pueblos en los que no tenemos clientes.
			
SELECT COUNT(P.CODPUE)
FROM PUEBLOS p 
WHERE P.CODPUE NOT IN (SELECT C.CODPUE 
				FROM CLIENTES c);
			
-- 6.	Número de artículos cuyo stock supera las 20 unidades, con precio superior a 15 euros y
-- de los que no hay ninguna factura en el último trimestre del año pasado.

SELECT COUNT(A.CODART)
FROM ARTICULOS a 
WHERE STOCK > 20
AND A.PRECIO > 15
AND A.CODART NOT IN (SELECT LF.CODART
					FROM LINEAS_FAC lf, FACTURAS f 
					WHERE EXTRACT(MONTH FROM F.FECHA) > 9
					AND EXTRACT(YEAR FROM F.FECHA)= EXTRACT(YEAR FROM SYSDATE)-1); 

-- 7.	Obtener el número de clientes que en todas las facturas del 
-- año pasado han pagado IVA (no se ha pagado IVA si es cero o nulo).

SELECT COUNT(F.CODCLI)
FROM FACTURAS f 
WHERE F.CODCLI NOT IN (SELECT F.CODCLI
						FROM FACTURAS f2
						WHERE (IVA IS NULL
						OR IVA = 0))
AND EXTRACT(YEAR FROM F.FECHA)=EXTRACT(YEAR FROM SYSDATE)-1;

-- 8.	Clientes (código y nombre) que fueron preferentes durante el mes de noviembre 
-- del año pasado y que en diciembre de ese mismo año no tienen ninguna factura. 
-- Son clientes preferentes de un mes aquellos que han solicitado más de 60,50 euros en 
-- facturas durante ese mes, sin tener en cuenta descuentos ni impuestos.
				
SELECT C.CODCLI, C.NOMBRE
FROM CLIENTES c 

				

					
					
					
					
