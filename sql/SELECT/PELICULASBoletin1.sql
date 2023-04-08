-- 1. Obtén las diferentes ciudades donde hay cines

SELECT DISTINCT CIUDAD_CINE
FROM CINE c;

-- 2. Obtener las películas con un presupuesto mayor de 2000 o cuya duración sea superior a 100.

SELECT TITULO_P 
FROM PELICULA p 
WHERE PRESUPUESTO > 2000
OR DURACION > 100;

-- 3. Obtener las películas cuyo título (da igual el original o el español) contenga la cadena la sin
-- importar que esté en mayúsculas o minúsculas.

SELECT TITULO_P
FROM PELICULA p 
WHERE UPPER(TITULO_P) LIKE '%LA%';

-- 4. Obtener el nombre y la nacionalidad de los personajes que sean hombres ordenado por
-- nacionalidad y nombre.

SELECT NOMBRE_PERSONA, NACIONALIDAD_PERSONA
FROM PERSONAJE p 
WHERE SEXO_PERSONA LIKE 'H'
ORDER BY NACIONALIDAD_PERSONA, SEXO_PERSONA ;

-- 5. Obtener las películas estrenadas en el mes de septiembre

SELECT P2.FECHA_ESTRENO 
FROM PROYECCION p , PROYECCION p2 
WHERE P.CIP = P2.CIP 
AND EXTRACT(MONTH FROM P2.FECHA_ESTRENO)=9;


-- 6. Obtener las diferentes tareas que ha desempeñado alguna persona alguna vez.

SELECT DISTINCT TAREA 
FROM TRABAJO t, PERSONAJE p 
WHERE T.NOMBRE_PERSONA = P.NOMBRE_PERSONA ;

-- 7. Obtener el numero de sala y el aforo de todas las salas de los cines que terminen en vocal.

SELECT SALA, AFORO
FROM SALA s 
WHERE UPPER(CINE) LIKE '%A'
OR UPPER(CINE) LIKE '%E'
OR UPPER(CINE) LIKE '%I'
OR UPPER(CINE) LIKE '%O'
OR UPPER(CINE) LIKE '%U';

-- 8. Obtener las distintas ciudades que tienen cines con alguna sala con aforo superior a 100
-- ordenadas por el nombre de la ciudad de la z a la a.

SELECT DISTINCT CIUDAD_CINE
FROM CINE c , SALA s 
WHERE C.CINE = S.CINE 
AND S.AFORO > 100
ORDER BY C.CIUDAD_CINE DESC;

-- 9. Obtener los títulos (ambos) y la nacionalidad de las películas que hayan obtenido una
-- recaudación en alguna sala 10000 mayor que su presupuesto ordenadas de mayor a menor
-- beneficio.

SELECT TITULO_P, TITULO_S, NACIONALIDAD
FROM PELICULA p , PROYECCION p2 
WHERE P.CIP = P2.CIP 
AND P2.RECAUDACION > P.PRESUPUESTO + 10000
ORDER BY P2.RECAUDACION ASC;

-- 10. Obtener el nombre de los actores hombres que participen en la película Viaje al centro de la
-- tierra.

SELECT P2.NOMBRE_PERSONA
FROM TRABAJO t , PELICULA p , PERSONAJE p2 
WHERE t.CIP = P.CIP 
AND T.NOMBRE_PERSONA = P2.NOMBRE_PERSONA 
AND P.TITULO_P LIKE 'Viaje al centro de la tierra'
AND UPPER(T.TAREA) LIKE '%ACTOR%'
AND P2.SEXO_PERSONA LIKE 'H';

-- 11. Obtener el nombre del cine y el número de películas diferentes estrenadas por cada cine
-- ordenadas por el número de películas ordenadas de mayor a menor. 

SELECT C.CINE, COUNT(DISTINCT P.CIP)
FROM PROYECCION p , SALA s , CINE c 
WHERE C.CINE = S.CINE 
AND S.CINE = P.CINE 
GROUP BY C.CINE
ORDER BY COUNT(P.CIP) DESC;

-- 12. Obtener el nombre y nacionalidad de las personas que hayan trabajado en alguna película de
-- diferente nacionalidad a la suya.

SELECT P.NOMBRE_PERSONA, P.NACIONALIDAD_PERSONA
FROM PERSONAJE p, TRABAJO t , PELICULA p2 
WHERE P.NOMBRE_PERSONA = T.NOMBRE_PERSONA 
AND T.CIP = P2.CIP 
AND P.NACIONALIDAD_PERSONA != P2.NACIONALIDAD ;

--13. Obtener por cada cine, el nombre, las salas y el nombre de la películA
SELECT P.CIP, P.CINE, P.SALA , P2.TITULO_P
FROM PROYECCION p , PELICULA p2 
WHERE P.CIP = P2.CIP ;

-- 14. Obtener la recaudación total de cada cine ordenada de mayor a menor recaudación total.

SELECT CINE, SUM(RECAUDACION)
FROM PROYECCION
GROUP BY CINE
ORDER BY SUM(RECAUDACION) DESC;

-- 15. Obtener aquellas personas que hayan realizado una tarea cuyo sexo sea diferente al suyo,
-- teniendo en cuenta que para productor y director no hay un sexo definido.

SELECT P.NOMBRE_PERSONA  
FROM PERSONAJE p , TRABAJO t , TAREA t2 
WHERE P.NOMBRE_PERSONA = T.NOMBRE_PERSONA 
AND T.TAREA = T2.TAREA 
AND P.SEXO_PERSONA != T2.SEXO_TAREA;

-- 16. Obtener el título, al año de producción, el presupuesto y la recaudación total de las películas
-- que han sido proyectadas en algún cine de la ciudad de Córdoba.

SELECT P.TITULO_P , P.ANO_PRODUCCION , P.PRESUPUESTO , SUM(P2.RECAUDACION) 
FROM PELICULA p , PROYECCION p2 , SALA s , CINE c 
WHERE P.CIP = P2.CIP 
AND P2.SALA = S.SALA 
AND S.CINE = C.CINE 
AND C.CIUDAD_CINE LIKE 'Cordoba'
GROUP BY P.TITULO_P , P.ANO_PRODUCCION , P.PRESUPUESTO ;

-- 17. Obtener el título de las películas cuya recaudación por espectador (con 2 decimales) sea
-- mayor de 700.

SELECT P.TITULO_P,ROUND(P2.RECAUDACION / P2.ESPECTADORES , 2) AS RECAUDACION_POR_ESPEC
FROM PELICULA p , PROYECCION p2 
WHERE P.CIP =P2.CIP 
 AND (P2.RECAUDACION / P2.ESPECTADORES )>700;

-- 18. Obtener el nombre de los actores que han participado en más de 2 películas.

SELECT P.NOMBRE_PERSONA 
FROM PERSONAJE p , TRABAJO t 
WHERE P.NOMBRE_PERSONA = T.NOMBRE_PERSONA 
GROUP BY P.NOMBRE_PERSONA 
HAVING COUNT(T.CIP)>2;









