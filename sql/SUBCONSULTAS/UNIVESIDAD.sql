--1.	Mostrar el identificador de los alumnos matriculados en cualquier asignatura 
-- excepto la '150212' y la '130113'

SELECT DISTINCT(AA.IDALUMNO)  
FROM ALUMNO_ASIGNATURA aa 
WHERE AA.IDALUMNO  NOT IN (SELECT AA2.IDALUMNO  
							FROM ALUMNO_ASIGNATURA aa2
							WHERE AA2.IDASIGNATURA LIKE '150212'
							OR AA2.IDASIGNATURA LIKE '130113');
						
select distinct(idalumno)
from alumno_asignatura
where idalumno not in(select idalumno from alumno_asignatura
			where idasignatura = '150212' or idasignatura = '130113');

-- 2.	Mostrar el nombre de las asignaturas que tienen más créditos que "Seguridad Vial". 

SELECT A.NOMBRE 
FROM ASIGNATURA a 
WHERE A.CREDITOS > (SELECT a2.CREDITOS 
					FROM ASIGNATURA a2
					WHERE A2.NOMBRE LIKE 'Seguridad Vial');

-- 3.	Obtener el Id de los alumnos matriculados en las asignaturas "150212" y "130113" a la vez. 
SELECT AA.IDALUMNO  
FROM ALUMNO_ASIGNATURA aa 
WHERE AA.IDASIGNATURA LIKE '150212'
AND AA.IDALUMNO IN (SELECT AA2.IDALUMNO 
					FROM ALUMNO_ASIGNATURA aa2
					WHERE AA2.IDASIGNATURA LIKE '130113');
				
select distinct(idalumno)
from alumno_asignatura
where idalumno in (select idalumno from alumno_asignatura where idasignatura=150212)
And idalumno in (select idalumno from alumno_asignatura where idasignatura=130113);

-- 4.	Mostrar el Id de los alumnos matriculados en las asignatura "150212" ó "130113",
-- en una o en otra pero no en ambas a la vez

SELECT AA.IDALUMNO 
FROM ALUMNO_ASIGNATURA aa 
WHERE (AA.IDASIGNATURA LIKE '150212'
AND AA.IDALUMNO NOT IN (SELECT AA2.IDALUMNO 
					FROM ALUMNO_ASIGNATURA aa2
					WHERE AA2.IDASIGNATURA LIKE '130113'))
OR (AA.IDASIGNATURA LIKE '130113'
AND AA.IDALUMNO NOT IN (SELECT AA2.IDALUMNO 
					FROM ALUMNO_ASIGNATURA aa2
					WHERE AA2.IDASIGNATURA LIKE '150212'));
				
select distinct(idalumno)
from alumno_asignatura
where (idasignatura = 130113 and idalumno not in
(select idalumno from alumno_asignatura where idasignatura=150212))
Or
(idasignatura = 150212 and idalumno not in
(select idalumno from alumno_asignatura where idasignatura=130113));

-- 5.	Mostrar el nombre de las asignaturas de la titulación "130110" cuyos costes 
-- básicos sobrepasen el coste básico promedio por asignatura en esa titulación.

SELECT A.NOMBRE 
FROM ASIGNATURA a 
WHERE A.IDTITULACION LIKE '130110'
AND A.COSTEBASICO >= (SELECT AVG(A2.COSTEBASICO)
					FROM ASIGNATURA a2
					WHERE A2.IDTITULACION LIKE '130110');
				
select nombre
from asignatura a
where costebasico>(select avg(nvl(a.costebasico,0)) from asignatura a
				where idtitulacion='130110')
	   and idtitulacion='130110';
				


-- 6.	Mostrar el identificador de los alumnos matriculados en cualquier asignatura excepto 
-- la "150212" y la "130113”

SELECT AA.IDALUMNO 
FROM ALUMNO_ASIGNATURA aa 
WHERE AA.IDASIGNATURA NOT IN (SELECT AA2.IDASIGNATURA 
							FROM ALUMNO_ASIGNATURA aa2
							WHERE AA2.IDASIGNATURA LIKE '150212'
							OR AA2.IDASIGNATURA LIKE '130113');
						
SELECT distinct(idalumno)
from alumno_asignatura
where  idalumno not in(SELECT idalumno
from alumno_asignatura
where  idasignatura in('150212','130113'));

-- 7.	Mostrar el Id de los alumnos matriculados en la asignatura "150212" pero no en la "130113". 

SELECT AA.IDALUMNO 
FROM ALUMNO_ASIGNATURA aa 
WHERE AA.IDASIGNATURA LIKE '150212'
AND AA.IDALUMNO  NOT IN (SELECT AA2.IDALUMNO 
							FROM ALUMNO_ASIGNATURA aa2
							WHERE AA2.IDASIGNATURA LIKE '130113');
						
select idalumno
from alumno_asignatura
where idasignatura = '150212'
	and idalumno not in(SELECT idalumno
			from alumno_asignatura
			where  idasignatura = '130113');

-- 8.	Mostrar el nombre de las asignaturas que tienen más créditos que "Seguridad Vial". 

SELECT A.NOMBRE 
FROM ASIGNATURA a 
WHERE A.CREDITOS > (SELECT a2.CREDITOS 
					FROM ASIGNATURA a2
					WHERE A2.NOMBRE LIKE 'Seguridad Vial');
--QUITAMOS ESPACIOS A LA IZQ Y LO PONEMOS EN MINUSCULAS (TRIM QUITA LOS DOS ESPACIOS)
select distinct(nombre)
from asignatura
where creditos>(select creditos
			from asignatura
			where ltrim(lower(nombre))='seguridad vial');
				
-- 9.	Mostrar las personas que no son ni profesores ni alumnos.

SELECT *
FROM PERSONA p 
WHERE DNI NOT IN (SELECT DNI
				FROM ALUMNO a)
AND DNI NOT IN (SELECT DNI
				FROM PROFESOR p2);
				
select * from persona
where dni not in(select dni from alumno )
and dni not in(select dni from profesor);
			
-- 10.	Mostrar el nombre de las asignaturas que tengan más créditos. 

SELECT A.NOMBRE 
FROM ASIGNATURA a 
WHERE A.CREDITOS = (SELECT MAX(CREDITOS)
					FROM ASIGNATURA a2 );
				
select  nombre
from asignatura
where creditos = (select max(creditos)
                from asignatura);

-- 11.	Lista de asignaturas en las que no se ha matriculado nadie. 

SELECT *
FROM ASIGNATURA a 
WHERE A.IDASIGNATURA NOT IN (SELECT AA.IDASIGNATURA 
							FROM ALUMNO_ASIGNATURA aa);

--12.	Ciudades en las que vive algún profesor y también algún alumno. 

SELECT DISTINCT(P.CIUDAD) 
FROM PERSONA p 
WHERE P.DNI IN (SELECT A.DNI 
				FROM ALUMNO a)  --MAL
OR P.DNI IN (SELECT P2.DNI
			FROM PROFESOR p2);
		
select distinct(p.ciudad)
from persona p, persona p1
where  (p.dni in(select dni from alumno)
and p1.dni in(select dni from profesor))
and p.ciudad=p1.ciudad;

						
						
						
