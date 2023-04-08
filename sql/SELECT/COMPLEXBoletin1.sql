
-- 1 Averigua el DNI de todos los clientes

SELECT DNI
FROM CLIENTE;


-- 2 Consulta todos los datos de todos los programas.

SELECT * 
FROM PROGRAMA p ;


-- 3 Obtén un listado con los nombres de todos los programas

SELECT NOMBRE 
FROM PROGRAMA p ;


-- 4 Genera una lista con todos los comercios.

SELECT * 
FROM COMERCIO;


-- 5 Genera una lista de las ciudades con establecimientos donde se venden
-- programas, sin que aparezcan valores duplicados (utiliza DISTINCT).

SELECT DISTINCT CIUDAD
FROM COMERCIO c ;

-- 6 Obtén una lista con los nombres de programas, sin que aparezcan valores
-- duplicados (utiliza DISTINCT).

SELECT DISTINCT NOMBRE
FROM PROGRAMA p ;


-- 7 Obtén el DNI más 4 de todos los clientes. 

SELECT DNI + 4
FROM CLIENTE;


-- 8 Haz un listado con los códigos de los programas multiplicados por 7.

SELECT *, CODIGO*7
FROM PROGRAMA p;


-- 9 ¿Cuáles son los programas cuyo código es inferior o igual a 10?

SELECT * 
FROM PROGRAMA p 
WHERE CODIGO <= 10;


-- 10 ¿Cuál es el programa cuyo código es 11?

SELECT * 
FROM PROGRAMA p 
WHERE CODIGO LIKE '11';


-- 11 ¿Qué fabricantes son de Estados Unidos?

SELECT NOMBRE 
FROM FABRICANTE f 
WHERE PAIS LIKE 'ESTADOS UNIDOS';


-- 12 ¿Cuáles son los fabricantes no españoles? Utilizar el operador IN.

SELECT * 
FROM FABRICANTE f 
WHERE PAIS NOT IN ('ESPAÑA');


-- 13 Obtén un listado con los códigos de las distintas versiones de Windows

SELECT CODIGO 
FROM PROGRAMA 
WHERE NOMBRE LIKE 'WINDOWS';


-- 14 ¿En qué ciudades comercializa programas El Corte Inglés?

SELECT CIUDAD
FROM COMERCIO 
WHERE NOMBRE LIKE 'EL CORTE INGLÉS';


-- 15 ¿Qué otros comercios hay, además de El Corte Inglés? Utilizar el operador
-- IN.

SELECT * 
FROM COMERCIO c 
WHERE NOMBRE NOT IN ('EL CORTE INGLÉS');


-- 16 Genera una lista con los códigos de las distintas versiones de Windows y
-- Access. Utilizar el operador IN.

SELECT CODIGO
FROM PROGRAMA 
WHERE NOMBRE LIKE 'ACCESS'
OR NOMBRE LIKE 'WINDOWS';


-- 17 Obtén un listado que incluya los nombres de los clientes de edades
-- comprendidas entre 10 y 25 y de los mayores de 50 años. Da una solución con
-- BETWEEN y otra sin BETWEEN.

SELECT NOMBRE, EDAD 
FROM CLIENTE 
WHERE (EDAD BETWEEN 10 AND 25)
OR (EDAD > 50);


-- 18 Saca un listado con los comercios de Sevilla y Madrid. No se admiten
-- valores duplicados.

SELECT DISTINCT *
FROM COMERCIO 
WHERE CIUDAD LIKE 'SEVILLA' 
OR CIUDAD LIKE 'MADRID';


-- 19 ¿Qué clientes terminan su nombre en la letra “o”?

SELECT * 
FROM CLIENTE 
WHERE NOMBRE LIKE '%O';


-- 20 ¿Qué clientes terminan su nombre en la letra “o” y, además, son mayores de
-- 30 años?

SELECT * 
FROM CLIENTE 
WHERE NOMBRE LIKE '%O'
AND EDAD > 30;


-- 21 Obtén un listado en el que aparezcan los programas cuya versión finalice
-- por una letra i, o cuyo nombre comience por una A o por una W.

SELECT * 
FROM PROGRAMA 
WHERE VERSION_PROG LIKE '%I'
AND (NOMBRE LIKE 'A%'
OR NOMBRE LIKE 'W%');


-- 22 Obtén un listado en el que aparezcan los programas cuya versión finalice
-- por una letra i, o cuyo nombre comience por una A y termine por una S.

SELECT * 
FROM PROGRAMA 
WHERE VERSION_PROG LIKE '%I'
AND NOMBRE LIKE 'A%S';


-- 23 Obtén un listado en el que aparezcan los programas cuya versión finalice
-- por una letra i, y cuyo nombre no comience por una A.

SELECT *
FROM PROGRAMA 
WHERE VERSION_PROG LIKE '%I'
AND NOMBRE LIKE 'A%';


--  24 Obtén una lista de empresas por orden alfabético ascendente.

SELECT *
FROM COMERCIO c 
ORDER BY NOMBRE ASC;


-- 25 Genera un listado de empresas por orden alfabético descendente

SELECT *
FROM COMERCIO c 
ORDER BY NOMBRE DESC;