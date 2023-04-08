-- 1.	Teniendo en cuenta los residuos generados por todas las empresas, 
-- mostrar el código del residuo que más se ha generado por todas ellas.

SELECT RE.COD_RESIDUO 
FROM RESIDUO_EMPRESA re
WHERE CANTIDAD = (SELECT MAX(RE2.CANTIDAD)
				FROM RESIDUO_EMPRESA re2);

-- 2.	Mostrar el nombre dela empresa transportista que sólo trabajó para la empresa 
-- con nif R-12356711-Q

SELECT E.NOMBRE_EMPTRANSPORTE 
FROM TRASLADO t, EMPRESATRANSPORTISTA e  
WHERE T.NIF_EMPTRANSPORTE IN (SELECT T2.NIF_EMPTRANSPORTE 
						FROM TRASLADO t2
						WHERE T2.NIF_EMPRESA LIKE 'R-12356711-Q');
					
SELECT DISTINCT E.NOMBRE_EMPTRANSPORTE 
FROM TRASLADO t , EMPRESATRANSPORTISTA e 
WHERE E.NIF_EMPTRANSPORTE = T.NIF_EMPTRANSPORTE                 --ESTE ESTA BIEN
 AND T.NIF_EMPTRANSPORTE IN (SELECT DISTINCT NIF_EMPTRANSPORTE  
								FROM TRASLADO t 
								WHERE NIF_EMPRESA  LIKE 'R-12356711-Q');

-- 3.	Mostrar el nombre de la empresa transportitas que realizó el primer transporte que está registrado 
-- en la base de datos.

SELECT E.NOMBRE_EMPTRANSPORTE 
FROM EMPRESATRANSPORTISTA e,
	(SELECT NIF_EMPTRANSPORTE 
	FROM TRASLADO t
	ORDER BY FECHA_ENVIO)
WHERE ROWNUM=1;

SELECT EMPRESATRANSPORTISTA.NOMBRE_EMPTRANSPORTE
FROM EMPRESATRANSPORTISTA, TRASLADO
WHERE EMPRESATRANSPORTISTA.NIF_EMPTRANSPORTE = TRASLADO.NIF_EMPTRANSPORTE
AND TRASLADO.FECHA_ENVIO = (SELECT MIN(FECHA_ENVIO)
  						  FROM TRASLADO);

-- 4.	Mostrar todas las características de los traslados, para aquellos traslados cuyo coste sea superior 
-- a la media de todos los traslados.

SELECT *
FROM TRASLADO t2 
WHERE COSTE > (SELECT AVG(COSTE)
		FROM TRASLADO t);

-- 5.	Obtener el nombre de las ciudades más cercanas entre las que se ha realizado un envío.

SELECT E2.CIUDAD_EMPRESA , E2.CIUDAD_EMPRESA 
FROM EMPRESATRANSPORTISTA e , EMPRESAPRODUCTORA e2 , TRASLADO t  --ESTA MAL
WHERE T.KMS = (SELECT MIN(T2.KMS)
				FROM TRASLADO t2);
			
SELECT EMPRESAPRODUCTORA.CIUDAD_EMPRESA, DESTINO.CIUDAD_DESTINO
FROM EMPRESAPRODUCTORA, TRASLADO, DESTINO
WHERE EMPRESAPRODUCTORA.NIF_EMPRESA = TRASLADO.NIF_EMPRESA
AND TRASLADO.COD_DESTINO = DESTINO.COD_DESTINO
AND TRASLADO.KMS =(SELECT MIN(KMS)
  				  FROM TRASLADO);

-- 6.	Obtener el nombre de las empresas que nunca han utilizado el Ferrocarril como 
-- medio de transporte.

SELECT E.NOMBRE_EMPTRANSPORTE  
FROM  EMPRESATRANSPORTISTA e  
WHERE  E.NIF_EMPTRANSPORTE NOT IN (SELECT t.NIF_EMPTRANSPORTE  
			FROM TRASLADO t
			WHERE TIPO_TRANSPORTE LIKE 'Ferrocarril');
		
SELECT DISTINCT E.NOMBRE_EMPRESA 
FROM EMPRESAPRODUCTORA e , TRASLADO t 
WHERE E.NIF_EMPRESA = T.NIF_EMPRESA  
 AND T.NIF_EMPRESA  NOT IN (SELECT NIF_EMPRESA   
									FROM TRASLADO t 
									WHERE TIPO_TRANSPORTE LIKE 'Ferrocarril');
								

--
-- 7.	Obtener el nombre de la empresa que ha realizado más envíos a Madrid.

SELECT E.NOMBRE_EMPTRANSPORTE, COUNT(T.NIF_EMPRESA)
FROM EMPRESATRANSPORTISTA e , TRASLADO t 
WHERE T.COD_DESTINO IN (SELECT D.COD_DESTINO 
						FROM DESTINO d
						WHERE D.CIUDAD_DESTINO LIKE 'Madrid') -- SIN TERMINAR
GROUP BY E.NOMBRE_EMPTRANSPORTE
ORDER BY COUNT(T.NIF_EMPRESA);

SELECT NOMBRE_EMPRESA
FROM EMPRESAPRODUCTORA,
	(SELECT COUNT(D.COD_DESTINO), T.NIF_EMPRESA
	FROM TRASLADO T, DESTINO D
	WHERE T.COD_DESTINO = D.COD_DESTINO AND D.CIUDAD_DESTINO LIKE 'Madrid'
	GROUP BY T.NIF_EMPRESA
	ORDER BY COUNT(D.COD_DESTINO)DESC)
WHERE ROWNUM=1;

-- 8.	Vamos a crear una nueva tabla llamada envios, que tendrá un campo llamdo Ciudad_destino, otro
--llamado ciudad_origen, y otro cantidad_total, en la que guardaremos donde van los residuos. 
--La primary key de la tabla debe ser ciudad_destino y ciudad_origen, así podremos evitar que metan
--  dos registros con la misma ciudad destino y origen.
--Cargar dicha tabla con los registros oportunos según nuestra base de datos, teniendo en cuenta 
--que en cantidad total se debe guardar el total de las cantidades que se ha enviado desde 
--ciudad_origen a ciudad_destino

CREATE TABLE envios(
	ciudad_destino VARCHAR(30),
	ciudad_origen VARCHAR(30),
	cantidad_total NUMBER(10),
	CONSTRAINT pk_envios PRIMARY KEY (ciudad_destino, ciudad_origen)
);

INSERT INTO envios(ciudad_destino, ciudad_origen, cantidad_total)
SELECT ciudad_destino, ciudad_empresa , SUM(cantidad)
FROM DESTINO d , TRASLADO t , EMPRESAPRODUCTORA e 
WHERE D.COD_DESTINO = T.COD_DESTINO 
AND T.NIF_EMPRESA = E.NIF_EMPRESA 
GROUP BY D.CIUDAD_DESTINO , E.CIUDAD_EMPRESA;

SELECT * FROM ENVIOS;

-- 9.	Vamos a modificar la tabla residuo para añadir un nuevo campo llamado num_constituyentes.
-- Una vez hayas añadido el nuevo campo crea la sentencia sql necesaria para que este campo tomen 
--los valores adecuados.

ALTER TABLE RESIDUO ADD NUM_CONSTITUYENTES NUMBER(5);

SELECT COUNT(COD_CONSTITUYENTE), COD_RESIDUO
FROM RESIDUO_CONSTITUYENTE rc 
GROUP BY COD_RESIDUO;

UPDATE RESIDUO R 
SET NUM_CONSTITUYENTES = (SELECT COUNT(COD_CONSTITUYENTE)
						  FROM RESIDUO_CONSTITUYENTE rc, RESIDUO r2  
						  WHERE RC.COD_RESIDUO = R2.COD_RESIDUO);
						 
---
						 
SELECT COUNT(D.COD_DESTINO), T.NIF_EMPRESA
FROM TRASLADO t NATURAL JOIN DESTINO d 
WHERE D.CIUDAD_DESTINO LIKE 'Madrid'
GROUP BY T.NIF_EMPRESA 
ORDER BY COUNT(D.COD_DESTINO)DESC;

SELECT COUNT(D.COD_DESTINO), T.NIF_EMPRESA
	FROM TRASLADO T JOIN DESTINO D
	ON T.COD_DESTINO = D.COD_DESTINO 
	WHERE D.CIUDAD_DESTINO LIKE 'Madrid'
	GROUP BY T.NIF_EMPRESA
	ORDER BY COUNT(D.COD_DESTINO)DESC;

SELECT D.COD_DESTINO, T.COD_RESIDUO, R.TOXICIDAD
FROM DESTINO d JOIN TRASLADO t ON D.COD_DESTINO = T.COD_DESTINO 
JOIN RESIDUO r ON T.COD_RESIDUO = R.COD_RESIDUO 
WHERE R.TOXICIDAD = 10;

---

-- 10.	Modifica la tabla empresaproductora añadiendo un campo nuevo llamado nif, 
--que es el nif de la empresa matriz, es decir, de la que depende, por lo que este nuevo 
--campo será una fk sobre el campo nif_empresa. Mostrar un listado en donde salga el nombre 
--de la empresa matriz y el nombre de la empresa de la que depende ordenado por empresa matriz. 
--El nuevo campo llamado nif tomará valores nulos cuando se trate de una empresa que no depende 
--de nadie. No es necesario hacer los cambios, sólo la consulta.

ALTER TABLE EMPRESAPRODUCTORA ADD NIF VARCHAR2(12);
ALTER TABLE EMPRESAPRODUCTORA ADD CONSTRAINT FK_EMPRESAPRODUCTORA FOREIGN KEY (NIF) REFERENCES EMPRESAPRODUCTORA(NIF_EMPRESA);

UPDATE EMPRESAPRODUCTORA
SET NIF='A-98989998-Q'
WHERE NIF_EMPRESA LIKE 'R-12356711-Q';

UPDATE EMPRESAPRODUCTORA
SET NIF='A-98989998-Q'
WHERE NIF_EMPRESA LIKE 'A-98988898-Q';

UPDATE EMPRESAPRODUCTORA
SET NIF='A-17655551-Q'
WHERE NIF_EMPRESA LIKE 'A-11111111-R';

SELECT MATRIZ.NOMBRE_EMPRESA EMPRESA_MATRIZ, EMPRESA.NOMBRE_EMPRESA
FROM EMPRESAPRODUCTORA MATRIZ LEFT JOIN EMPRESAPRODUCTORA EMPRESA ON MATRIZ.NIF_EMPRESA = EMPRESA.NIF
ORDER BY MATRIZ.NOMBRE_EMPRESA ;
						 
						 
---

CREATE OR REPLACE VIEW RESUMEN
(NOMBRE_EMPRESA, FECHA, NOMBRE_EMPTRANSPORTE)
AS 
SELECT T.NIF_EMPRESA, T.FECHA_ENVIO, T.NIF_EMPTRANSPORTE 
FROM TRASLADO t
WHERE T.NIF_EMPRESA LIKE '%A%';

SELECT NOMBRE_EMPTRANSPORTE
FROM RESUMEN;

SELECT * FROM RESUMEN r;

CREATE INDEX INDICE ON TRASLADO(NIF_EMPRESA);



