-- 1. Cuantos costes básicos hay.
SELECT COUNT(A.COSTEBASICO)
FROM ASIGNATURA A;

-- 2.	Para cada titulación mostrar el número de asignaturas que hay junto con el nombre de la titulación.
SELECT COUNT(A.NOMBRE), T.NOMBRE
FROM ASIGNATURA A, TITULACION T
WHERE A.IDTITULACION = T.IDTITULACION
GROUP BY T.NOMBRE;

-- 3.	Para cada titulación mostrar el nombre de la titulación junto con el precio total de todas sus asignaturas.
SELECT T.NOMBRE, SUM(A.COSTEBASICO*A.CREDITOS)
FROM ASIGNATURA A, TITULACION T
WHERE A.IDTITULACION = T.IDTITULACION
GROUP BY T.NOMBRE;

-- 4.	Cual sería el coste global de cursar la titulación de Matemáticas si el coste de cada asignatura fuera incrementado en un 7%. 
SELECT SUM(A.COSTEBASICO+(A.COSTEBASICO*7)/100)
FROM ASIGNATURA A, TITULACION T
WHERE A.IDTITULACION = T.IDTITULACION AND T.NOMBRE LIKE 'Matematicas';

-- 5.	Cuantos alumnos hay matriculados en cada asignatura, junto al id de la asignatura. 
SELECT COUNT(AA.IDALUMNO), AA.IDASIGNATURA
FROM ALUMNO_ASIGNATURA AA
GROUP BY AA.IDASIGNATURA;

-- 6.	Igual que el anterior pero mostrando el nombre de la asignatura.
SELECT COUNT(AA.IDALUMNO), AA.IDASIGNATURA, A.NOMBRE
FROM ALUMNO_ASIGNATURA AA, ASIGNATURA A
WHERE AA.IDASIGNATURA = A.IDASIGNATURA 
GROUP BY AA.IDASIGNATURA, A.NOMBRE;

-- 7.	Mostrar para cada alumno, el nombre del alumno junto con lo que tendría que pagar por el total de todas las asignaturas en las 
--que está matriculada. 
-- Recuerda que el precio de la matrícula tiene un incremento de un 10% por cada año en el que esté matriculado. 
SELECT P.NOMBRE,
	SUM (DECODE (ALA.NUMEROMATRICULA,   1, ASS.COSTEBASICO,
								    ASS.COSTEBASICO+(ASS.COSTEBASICO*(ALA.NUMEROMATRICULA*0.10))))
FROM PERSONA P, ALUMNO AL, ALUMNO_ASIGNATURA ALA, ASIGNATURA ASS
WHERE P.DNI = AL.DNI
AND AL.IDALUMNO = ALA.IDALUMNO 
AND ALA.IDASIGNATURA = ASS.IDASIGNATURA
GROUP BY P.NOMBRE;


-- 8.	Coste medio de las asignaturas de cada titulación, para aquellas titulaciones en el que el coste total de la 1ª matrícula sea mayor que 60 euros. 

--sin terminar
SELECT AVG(A.COSTEBASICO) AS COSTEMEDIO
FROM ASIGNATURA A, TITULACION T, ALUMNO_ASIGNATURA AA
WHERE A.IDTITULACION = T.IDTITULACION AND A.IDASIGNATURA = AA.IDASIGNATURA AND AA.NUMEROMATRICULA LIKE '1' AND A.COSTEBASICO > 60;

-- 9.	Nombre de las titulaciones  que tengan más de tres alumnos. 
SELECT T.NOMBRE, COUNT(AA.IDALUMNO)
FROM TITULACION t , ASIGNATURA a , ALUMNO_ASIGNATURA aa 
WHERE T.IDTITULACION = A.IDTITULACION 
AND A.IDASIGNATURA = AA.IDASIGNATURA 
GROUP BY T.NOMBRE 
HAVING COUNT(AA.IDALUMNO)>3;

-- 10.	Nombre de cada ciudad junto con el número de personas que viven en ella.
SELECT COUNT(P.NOMBRE), P.CIUDAD
FROM PERSONA P
GROUP BY P.CIUDAD;

-- 11.	Nombre de cada profesor junto con el número de asignaturas que imparte.
SELECT P.NOMBRE, COUNT(A.NOMBRE)
FROM PERSONA P, PROFESOR P2, ASIGNATURA A
WHERE P2.DNI = P.DNI AND A.IDPROFESOR = P2.IDPROFESOR 
GROUP BY P.NOMBRE;

-- 12.	Nombre de cada profesor junto con el número de alumnos que tiene, para aquellos profesores que tengan dos o más de 2 alumnos.
SELECT P.NOMBRE, COUNT(AA.IDALUMNO)
FROM PERSONA P, PROFESOR P2, ASIGNATURA A, ALUMNO_ASIGNATURA aa 
WHERE P2.DNI = P.DNI
AND P2.IDPROFESOR = A.IDPROFESOR 
AND A.IDASIGNATURA = AA.IDASIGNATURA 
GROUP BY P.NOMBRE
HAVING COUNT(AA.IDALUMNO)>=2;

-- 13.	Obtener el máximo de las sumas de los costesbásicos de cada cuatrimestre

SELECT MAX(SUM(COSTEBASICO))
FROM ASIGNATURA a2 
GROUP BY CUATRIMESTRE;

-- 14.	Suma del coste de las asignaturas
SELECT SUM(A.COSTEBASICO*CREDITOS)
FROM ASIGNATURA A;

-- 15.	¿Cuántas asignaturas hay?
SELECT COUNT(A.IDASIGNATURA)
FROM ASIGNATURA A;

-- 16.	Coste de la asignatura más cara y de la más barata
SELECT MAX(A.COSTEBASICO), MIN(A.COSTEBASICO)
FROM ASIGNATURA A;

-- 17.	¿Cuántas posibilidades de créditos de asignatura hay?
SELECT COUNT(DISTINCT A.CREDITOS)
FROM ASIGNATURA A;

-- 18.	¿Cuántos cursos hay?
SELECT COUNT(A.CURSO)
FROM ASIGNATURA A;

-- 19.	¿Cuántas ciudades hau?
SELECT COUNT(P.CIUDAD)
FROM PERSONA P;

-- 20.	Nombre y número de horas de todas las asignaturas.
SELECT A.NOMBRE, SUM(A.CREDITOS*10) AS NUMEROHORAS
FROM ASIGNATURA A
GROUP BY NOMBRE;

-- 21.	Mostrar las asignaturas que no pertenecen a ninguna titulación.
SELECT DISTINCT A.NOMBRE
FROM ASIGNATURA A, TITULACION T
WHERE A.IDTITULACION IS NULL; 

-- 22.	Listado del nombre completo de las personas, sus teléfonos y sus direcciones, 
--llamando a la columna del nombre "NombreCompleto" y a la de direcciones "Direccion".
SELECT P.NOMBRE || ' ' || P.APELLIDO AS NOMBRECOMPLETO, P.TELEFONO, P.DIRECCIONCALLE || P.DIRECCIONNUM AS DIRECCION
FROM PERSONA P;

-- 23.	Cual es el día siguiente al día en que nacieron las personas de la B.D.
SELECT P.FECHA_NACIMIENTO
FROM PERSONA P
WHERE P.FECHA_NACIMIENTO (TO_DATE())

-- 24.	Años de las personas de la Base de Datos, esta consulta tiene que valor para cualquier momento
SELECT P.FECHANACIMIENTO AS EDAD
FROM PERSONA P
WHERE P.FECHA_NACIMIENTO (TO_DATE(YYYY)) - EXTRACT(YEAR FROM SYSDATE);

-- 25.	Listado de personas mayores de 25 años ordenadas por apellidos y nombre, esta consulta tiene 
-- que valor para cualquier momento



-- 26.	Nombres completos de los profesores que además son alumnos
SELECT P.NOMBRE||P.APELLIDO AS NOMBRECOMPLETO
FROM PERSONA P, PROFESOR P2, ALUMNO A
WHERE P.DNI = P2.DNI AND A.DNI = P.DNI AND P2.DNI = A.DNI;

-- 27.	Suma de los créditos de las asignaturas de la titulación de Matemáticas
SELECT SUM(A.CREDITOS)
FROM ASIGNATURA A, TITULACION T
WHERE A.IDTITULACION = T.IDTITULACION AND T.NOMBRE LIKE 'Matemáticas';

-- 28.	Número de asignaturas de la titulación de Matemáticas
SELECT COUNT(A.IDASIGNATURA)
FROM ASIGNATURA A, TITULACION T
WHERE A.IDTITULACION = T.IDTITULACION AND T.NOMBRE LIKE 'Matemáticas';

-- 29.	¿Cuánto paga cada alumno por su matrícula?



-- 30.	¿Cuántos alumnos hay matriculados en cada asignatura?
SELECT COUNT(AA.IDALUMNO)
FROM ALUMNO_ASIGNATURA AA;




