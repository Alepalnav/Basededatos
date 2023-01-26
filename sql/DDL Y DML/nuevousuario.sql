ALTER SESSION SET "_oracle_script"=TRUE;
CREATE USER caballos IDENTIFIED BY caballos;
GRANT CONNECT, resource, DBA TO caballos;