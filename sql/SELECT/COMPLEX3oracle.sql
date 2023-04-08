-- 1. Visualizar el número de empleados de cada departamento. Utilizar
-- GROUP BY para agrupar por departamento.

SELECT COUNT(E.EMP_NO), E.DEPT_NO 
FROM EMPLE e 
GROUP BY DEPT_NO;

--2. Visualizar los departamentos con más de 5 empleados. Utilizar GROUP
--BY para agrupar por departamento y HAVING para establecer la condición
--sobre los grupos.

SELECT E.DEPT_NO  
FROM EMPLE e 
GROUP BY E.DEPT_NO 
HAVING COUNT(E.EMP_NO)>5;

-- 3. Hallar la media de los salarios de cada departamento (utilizar la función
-- avg y GROUP BY).

SELECT AVG(E.SALARIO)
FROM EMPLE e 
GROUP BY E.EMP_NO ;

-- 4. Visualizar el nombre de los empleados vendedores del departamento
-- ʻVENTASʼ (Nombre del departamento=ʼVENTASʼ, oficio=ʼVENDEDORʼ).

SELECT E.APELLIDO 
FROM EMPLE e , DEPART d 
WHERE E.DEPT_NO = D.DEPT_NO 
AND E.OFICIO LIKE 'VENDEDOR'
AND D.DNOMBRE LIKE 'VENTAS';

-- 5. Visualizar el número de vendedores del departamento ʻVENTASʼ (utilizar
-- la función COUNT sobre la consulta anterior).

SELECT COUNT(E.APELLIDO)
FROM EMPLE e , DEPART d 
WHERE E.DEPT_NO = D.DEPT_NO 
AND E.OFICIO LIKE 'VENDEDOR'
AND D.DNOMBRE LIKE 'VENTAS';

-- 6. Visualizar los oficios de los empleados del departamento ʻVENTASʼ

SELECT E.OFICIO 
FROM EMPLE e , DEPART d 
WHERE E.DEPT_NO  = D.DEPT_NO
AND D.DNOMBRE LIKE 'VENTAS';

-- 7. A partir de la tabla EMPLE, visualizar el número de empleados de cada
-- departamento cuyo oficio sea ʻEMPLEADOʼ (utilizar GROUP BY para
-- agrupar por departamento. En la cláusula WHERE habrá que indicar que el
-- oficio es ʻEMPLEADOʼ).

SELECT COUNT(E.EMP_NO) 
FROM EMPLE e 
WHERE E.OFICIO LIKE 'EMPLEADO'
GROUP BY E.DEPT_NO ;

-- 8. Visualizar el departamento con más empleados.

select * from (SELECT COUNT(EMPLE.EMP_NO)
                FROM EMPLE
                GROUP BY EMPLE.DEPT_NO
                ORDER BY COUNT(EMPLE.EMP_NO) DESC)
where rownum=1;

-- 9. Mostrar los departamentos cuya suma de salarios sea mayor que la
-- media de salarios de todos los empleados. 

SELECT DEPART.DNOMBRE 
FROM DEPART, EMPLE
WHERE DEPART.DEPT_NO = EMPLE.DEPT_NO 
GROUP BY DEPART.DNOMBRE 
HAVING SUM(EMPLE.SALARIO)> AVG(EMPLE.SALARIO); 

-- 10. Para cada oficio obtener la suma de salarios.

SELECT SUM(E.SALARIO), E.OFICIO 
FROM EMPLE e 
GROUP BY E.OFICIO ;

-- 11. Visualizar la suma de salarios de cada oficio del departamento
-- ʻVENTASʼ

SELECT SUM(E.SALARIO), E.OFICIO 
FROM EMPLE e, DEPART d 
WHERE D.DNOMBRE LIKE 'VENTAS'
GROUP BY E.OFICIO ;

-- 12. Visualizar el número de departamento que tenga más empleados cuyo
-- oficio sea empleado.

SELECT * FROM(SELECT COUNT(E2.EMP_NO)
			FROM EMPLE e2 
			WHERE E2.OFICIO LIKE 'EMPLEADO'
			GROUP BY E2.DEPT_NO 
			ORDER BY COUNT(E2.EMP_NO)DESC)
WHERE ROWNUM=1;

-- 13. Mostrar el número de oficios distintos de cada departamento.

SELECT COUNT(DISTINCT E.OFICIO), E.DEPT_NO 
FROM EMPLE e 
GROUP BY E.DEPT_NO ;

-- 14. Mostrar los departamentos que tengan más de dos personas
-- trabajando en la misma profesión.

SELECT DEPART.DEPT_NO 
FROM DEPART, EMPLE
WHERE DEPART.DEPT_NO = EMPLE.DEPT_NO 
GROUP BY DEPART.DEPT_NO  , EMPLE.OFICIO 
HAVING COUNT(EMPLE.OFICIO)>2;

-- 15. Dada la tabla HERRAMIENTAS, visualizar por cada estantería la suma
-- de las unidades.

SELECT SUM(H.UNIDADES), H.ESTANTERIA 
FROM HERRAMIENTAS h 
GROUP BY H.ESTANTERIA ;

-- 16. Visualizar la estantería con más unidades de la tabla HERRAMIENTAS.

SELECT * FROM (SELECT H.ESTANTERIA, SUM(H.UNIDADES)
				FROM HERRAMIENTAS h
				GROUP BY H.ESTANTERIA
				ORDER BY SUM(H.UNIDADES)DESC)
WHERE ROWNUM= 1;

-- 17. Mostrar el número de médicos que pertenecen a cada hospital,
-- ordenado por número descendente de hospital.

SELECT COUNT(DNI), M.COD_HOSPITAL 
FROM MEDICOS m 
GROUP BY M.COD_HOSPITAL
ORDER BY M.COD_HOSPITAL DESC;

-- 18. Realizar una consulta en la que se muestre por cada hospital el
-- nombre de las especialidades que tiene.

SELECT DISTINCT H.NOMBRE, M.ESPECIALIDAD 
FROM HOSPITALES h , MEDICOS m 
WHERE H.COD_HOSPITAL = M.COD_HOSPITAL;

-- 19. Realizar una consulta en la que aparezca por cada hospital y en cada
-- especialidad el número de médicos (tendrás que partir de la consulta anterior
-- y utilizar GROUP BY).

SELECT DISTINCT HOSPITALES.NOMBRE ,MEDICOS.ESPECIALIDAD, COUNT(MEDICOS.DNI) 
FROM HOSPITALES, MEDICOS
WHERE HOSPITALES.COD_HOSPITAL = MEDICOS.COD_HOSPITAL
GROUP BY HOSPITALES.NOMBRE ,MEDICOS.ESPECIALIDAD;

-- 20. Obtener por cada hospital el número de empleados. 

SELECT PERSONAS.COD_HOSPITAL , COUNT(PERSONAS.DNI) AS NUM_EMPLEADOS
FROM PERSONAS
GROUP BY PERSONAS.COD_HOSPITAL ;

-- 21. Obtener por cada especialidad el número de trabajadores.

SELECT COUNT(DNI), ESPECIALIDAD 
FROM MEDICOS m 
GROUP BY ESPECIALIDAD ;

-- 22. Visualizar la especialidad que tenga más médicos.

SELECT * FROM (SELECT M.ESPECIALIDAD, COUNT(M.DNI)
				FROM MEDICOS m
				GROUP BY M.ESPECIALIDAD
				ORDER BY COUNT(M.DNI)DESC)
WHERE ROWNUM=1;

-- 23. ¿Cuál es el nombre del hospital que tiene mayor número de plazas?

SELECT * FROM (SELECT H.NOMBRE, H.NUM_PLAZAS
				FROM HOSPITALES h
				ORDER BY H.NUM_PLAZAS DESC)
WHERE ROWNUM=1;

--24. Visualizar las diferentes estanterías de la tabla HERRAMIENTAS ordenados descendentemente por estantería.
SELECT DISTINCT ESTANTERIA 
FROM HERRAMIENTAS
ORDER BY ESTANTERIA DESC;

--25. Averiguar cuántas unidades tiene cada estantería.
SELECT ESTANTERIA , SUM(UNIDADES)
FROM HERRAMIENTAS
GROUP BY ESTANTERIA;

--26. Visualizar las estanterías que tengan más de 15 unidades
SELECT ESTANTERIA , SUM(UNIDADES)
FROM HERRAMIENTAS
GROUP BY ESTANTERIA
HAVING SUM(UNIDADES) > 15;

--27. ¿Cuál es la estantería que tiene más unidades?
SELECT ESTANTERIA , SUM(UNIDADES)
FROM HERRAMIENTAS
GROUP BY ESTANTERIA
ORDER BY SUM(UNIDADES) DESC LIMIT 1;

--28. A partir de las tablas EMPLE y DEPART mostrar los datos del departamento que no tiene ningún empleado. 
SELECT DEPART.DEPT_NO, DEPART.DNOMBRE 
FROM DEPART LEFT JOIN EMPLE
ON DEPART.DEPT_NO = EMPLE.DEPT_NO 
GROUP BY DEPART.DEPT_NO, DEPART.DNOMBRE
HAVING COUNT(EMPLE.EMP_NO) = 0;

SELECT DEPART.DEPT_NO, DEPART.DNOMBRE 
FROM DEPART, EMPLE
WHERE DEPART.DEPT_NO = EMPLE.DEPT_NO(+)
AND EMPLE.DEPTNO IS NULL;

--29. Mostrar el número de empleados de cada departamento. En la salida se debe mostrar también los departamentos que no tienen ningún empleado.
SELECT DEPART.DEPT_NO , COUNT(EMPLE.EMP_NO) AS NUM_EMPLE
FROM DEPART LEFT JOIN EMPLE 
ON EMPLE.DEPT_NO = DEPART.DEPT_NO
GROUP BY DEPART.DEPT_NO;

SELECT DEPART.DEPT_NO , COUNT(EMPLE.EMP_NO) AS NUM_EMPLE
FROM DEPART, EMPLE 
WHERE EMPLE.DEPT_NO = DEPART.DEPT_NO
GROUP BY DEPART.DEPT_NO
UNION
SELECT DEPART.DEPT_NO, DEPART.DNOMBRE 
FROM DEPART LEFT JOIN EMPLE
ON DEPART.DEPT_NO = EMPLE.DEPT_NO 
GROUP BY DEPART.DEPT_NO, DEPART.DNOMBRE
HAVING COUNT(EMPLE.EMP_NO) = 0;

SELECT DEPART.DEPT_NO , COUNT(EMPLE.EMP_NO) AS NUM_EMPLE
FROM DEPART, EMPLE 
WHERE EMPLE.DEPT_NO = DEPART.DEPT_NO
GROUP BY DEPART.DEPT_NO
UNION
SELECT DEPART.DEPT_NO, DEPART.DNOMBRE 
FROM DEPART, EMPLE
WHERE DEPART.DEPT_NO = EMPLE.DEPT_NO(+)
AND EMPLE.DEPTNO IS NULL;

--30. Obtener la suma de salarios de cada departamento, mostrando las columnas DEPT_NO, SUMA DE SALARIOS y DNOMBRE. En el resultado
--    también se deben mostrar los departamentos que no tienen asignados empleados.
SELECT DEPART.DEPT_NO , SUM(EMPLE.SALARIO) AS SUMA_SALARIO, DEPART.DNOMBRE  
FROM DEPART LEFT JOIN EMPLE
ON DEPART.DEPT_NO = EMPLE.DEPT_NO 
GROUP BY DEPART.DEPT_NO, DEPART.DNOMBRE

--31. Utilizar la función IFNULL en la consulta anterior para que en el caso de que un departamento no tenga empleados, aparezca como suma de
--    salarios el valor 0.
SELECT DEPART.DEPT_NO , IFNULL(SUM(EMPLE.SALARIO),0) AS SUMA_SALARIO, DEPART.DNOMBRE  
FROM DEPART LEFT JOIN EMPLE
ON DEPART.DEPT_NO = EMPLE.DEPT_NO 
GROUP BY DEPART.DEPT_NO, DEPART.DNOMBRE  ;

--32. Obtener el número de médicos que pertenecen a cada hospital, mostrando las columnas COD_HOSPITAL, NOMBRE y NÚMERO DEMÉDICOS. En el resultado 
--   deben aparecer también los datos de los hospitales que no tienen médicos.
SELECT HOSPITALES.COD_HOSPITAL ,HOSPITALES.NOMBRE , COUNT(MEDICOS.DNI)
FROM HOSPITALES LEFT JOIN MEDICOS
ON MEDICOS.COD_HOSPITAL = HOSPITALES.COD_HOSPITAL 
GROUP BY HOSPITALES.COD_HOSPITAL ,HOSPITALES.NOMBRE;













