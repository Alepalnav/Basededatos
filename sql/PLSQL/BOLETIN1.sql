--1. Crea un procedimiento llamado ESCRIBE para mostrar por pantalla el
--mensaje HOLA MUNDO.

CREATE OR REPLACE 
PROCEDURE ESCRIBE
IS 
BEGIN 
	DBMS_OUTPUT.PUT_LINE('HOLA MUNDO');
END;

BEGIN
	ESCRIBE;
END;

--2. Crea un procedimiento llamado ESCRIBE_MENSAJE que tenga un
--parámetro de tipo VARCHAR2 que recibe un texto y lo muestre por pantalla.
--La forma del procedimiento ser. la siguiente:
--ESCRIBE_MENSAJE (mensaje VARCHAR2)

CREATE OR REPLACE 
PROCEDURE ESCRIBE_MENSAJE(TEXTO VARCHAR)
IS 
BEGIN 
	DBMS_OUTPUT.PUT_LINE(TEXTO);
END;

BEGIN
	ESCRIBE_MENSAJE('HOLA');
END;

--3. Crea un procedimiento llamado SERIE que muestre por pantalla una serie de
--números desde un mínimo hasta un máximo con un determinado paso. La
--forma del procedimiento ser. la siguiente:
--SERIE (minimo NUMBER, maximo NUMBER, paso NUMBER)

CREATE OR REPLACE PROCEDURE DUMMY.SERIE(MINIMO NUMBER, MAXIMO NUMBER, PASO NUMBER)
IS 
NUM NUMBER;
BEGIN 
	NUM := MINIMO;
	WHILE NUM <= MAXIMO LOOP
		dbms_output.put_line(NUM);
		NUM:=NUM+PASO;
	END LOOP;
END;

BEGIN 
	SERIE(1,20,2);
END;

--4. Crea una función AZAR que reciba dos parámetros y genere un número al
--azar entre un mínimo y máximo indicado. La forma de la función será la
--siguiente:
--AZAR (minimo NUMBER, maximo NUMBER) RETURN NUMBER

CREATE OR REPLACE 
FUNCTION AZAR(MINIMO NUMBER,MAXIMO NUMBER)
RETURN NUMBER 
IS 
BEGIN 
	RETURN MOD(ABS(DBMS_RANDOM.RANDOM),MAXIMO-MINIMO+1)+MINIMO;
END;

SELECT AZAR(10,20) FROM DUAL;

--5. Crea una función NOTA que reciba un parámetro que será una nota numérica
--entre 0 y 10 y devuelva una cadena de texto con la calificación (Suficiente,
--Bien, Notable, ...). La forma de la función será la siguiente:
--NOTA (nota NUMBER) RETURN VARCHAR2

CREATE OR REPLACE
FUNCTION NOTA(NOTA NUMBER)
RETURN VARCHAR
IS 
BEGIN 
	IF NOTA >= 9 THEN
		RETURN('SOBRESALIENTE');
	ELSIF NOTA >= 7 THEN
		RETURN('NOTABLE');
	ELSIF NOTA=6 THEN 
		RETURN('BIEN');
	ELSIF NOTA=5 THEN
		RETURN('SUFICIENTE');
	ELSIF NOTA<5 AND NOTA >=0 THEN 
		RETURN('INSUFUCIENTE');
	ELSE 
		RETURN('NOTA NO VALIDA');
	END IF;
END NOTA;

SELECT NOTA(8) FROM DUAL;

--
DECLARE
    str  VARCHAR(20) := 'HOLA';
    len  NUMBER;
    str1 VARCHAR(20);
BEGIN
    len := Length(str);
  
  
    FOR i IN REVERSE 1.. len LOOP
                     
        str1 := str1
                || Substr(str, i, 1);
    END LOOP;
  
    dbms_output.Put_line(str1);
END;
