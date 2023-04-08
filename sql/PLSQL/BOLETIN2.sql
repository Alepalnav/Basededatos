--1. Escribe un procedimiento que muestre el número de empleados y el salario
--mínimo, máximo y medio del departamento de FINANZAS. Debe hacerse
--uso de cursores implícitos, es decir utilizar SELECT ... INTO.

CREATE OR REPLACE 
PROCEDURE FINANZAS AS 
	NUMERO NUMBER;
	MAXIMO NUMBER;
	MINIMO NUMBER;
	MEDIA NUMBER;
	DPTO NUMBER;
BEGIN 
	SELECT NUMDE INTO DPTO FROM DEPARTAMENTOS
	WHERE UPPER(NOMDE) = 'FINANZAS';

	SELECT COUNT(*), MAX(SALAR), MIN(SALAR), ROUND(AVG(SALAR),2)
	INTO NUMERO,MAXIMO,MINIMO,MEDIA
	FROM EMPLEADOS e WHERE NUMDE = DPTO;

	dbms_output.put_line(NUMERO);
	dbms_output.put_line(MAXIMO);
	dbms_output.put_line(MINIMO);
	dbms_output.put_line(MEDIA);
	dbms_output.put_line(DPTO);
END;

BEGIN
	FINANZAS;
END;

--2. Escribe un procedimiento que suba un 10% el salario a los EMPLEADOS
--con más de 2 hijos y que ganen menos de 2000 €. Para cada empleado se
--mostrar por pantalla el código de empleado, nombre, salario anterior y final.
--Utiliza un cursor explícito. La transacción no puede quedarse a medias. Si
--por cualquier razón no es posible actualizar todos estos salarios, debe
--deshacerse el trabajo a la situación inicial.

CREATE OR REPLACE 
PROCEDURE EMPLEADOS1 AS 
	CODEMPLE = NUMBER;
	NOMBRE = VARCHAR;
	SALARIOANTERIOR = NUMBER;
	SALARIOFINAL = NUMBER;
BEGIN
	SELECT E.NUMEM, E.NOMEM, E.SALAR, E.SALAR+E.SALAR*0,10
	INTO CODEMPLE, NOMBRE, SALARIOANTERIOR, SALARIOFINAL
	FROM EMPLEADOS e WHERE E.NUMHI > 2
	AND E.SALAR < 2000;

	dbms_output.put_line(CODEMPLE);
	dbms_output.put_line(NOMBRE);
	dbms_output.put_line(SALARIOANTERIOR);
	dbms_output.put_line(SALARIOFINAL);
END;

BEGIN
	EMPLEADOS1;
END;







--3. Escribe un procedimiento que reciba dos parámetros (número de
--departamento, hijos). Deber. crearse un cursor explícito al que se le pasarán
--estos parámetros y que mostrar. los datos de los empleados que pertenezcan
--al departamento y con el número de hijos indicados. Al final se indicar. el
--número de empleados obtenidos.





--4. Escribe un procedimiento con un parámetro para el nombre de emp