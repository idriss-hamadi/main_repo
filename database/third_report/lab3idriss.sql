--lab3 
--------------- QUESTION 1------------
desc dict;
---------------QUESTION2------------
DESC ALL_TAB_COLUMNS
DESC USER_USERS
DESC ALL_CONSTRAINTS
DESC USER_TAB_PRIVS
----------------QUESTION3----------
SELECT USERNAME FROM USER_USERS;
----------------QUESTION4-----------
DESC ALL_TAB_COLUMNS
DESC USER_TAB_COLUMNS-----------
--NOTE :it is the same,they're equal
----------------QUESTION 5----------- 
SELECT DISTINCT(TABLE_NAME) FROM ALL_TAB_COLUMNS WHERE OWNER='DBAINTERVENTION';--7 TABLES 
DESC CUSTOMER
DESC EMPLOYEE
DESC BRAND
DESC MODEL
DESC VEHICLE
DESC PARTICIPANTS 
DESC INTERVENTION
---------------QUESTION 6------------
SELECT DISTINCT(TABLE_NAME) FROM ALL_TAB_COLUMNS WHERE OWNER='SYSTEM';
SELECT DISTINCT(TABLE_NAME) FROM ALL_TAB_COLUMNS WHERE OWNER='DBAINTERVENTION';
----------------QUESTION 7-----------------
 SELECT DISTINCT(COLUMN_NAME) FROM USER_TAB_COLUMNS WHERE TABLE_NAME='VEHICLE' ;
 SELECT DISTINCT(COLUMN_NAME) FROM USER_TAB_COLUMNS WHERE TABLE_NAME='INTERVENTIONS'
------------------QUESTION 8-----------------------
 SELECT DISTINCT(CONSTRAINT_NAME) FROM ALL_CONSTRAINTS WHERE TABLE_NAME='INTERVENTIONS';
 SELECT CONSTRAINT_TYPE FROM ALL_CONSTRAINTS WHERE TABLE_NAME='VEHICLE';
-------------------------QUESTION 9--------------------
 DESC USER_CONSTRAINTS
 SELECT DISTINCT(CONSTRAINT_NAME) FROM USER_CONSTRAINTS WHERE OWNER='DBAINTERVENTION';
  SELECT DISTINCT(CONSTRAINT_NAME) FROM USER_CONSTRAINTS WHERE OWNER='SYSTEM';--429 rows selected.
 
--------------10----------
-- INTERVENTIONS ATTRIBUTES :
SELECT DISTINCT(COLUMN_NAME) FROM ALL_TAB_COLUMNS WHERE TABLE_NAME='INTERVENTIONS';
--INTERVENTIONS CONSTRAINTS:
SELECT DISTINCT(CONSTRAINT_NAME) FROM USER_CONSTRAINTS WHERE TABLE_NAME='INTERVENTIONS';
--QUESTION 11:Find all privileges granted to Admin.
 SELECT *FROM USER_SYS_PRIVS;
 SELECT DISTINCT(PRIVILEGE) FROM USER_TAB_PRIVS WHERE GRANTEE='SYSTEM';
 SELECT PRIVILEGE FROM USER_SYS_PRIVS WHERE USERNAME='ADMIN';--NO ROWS SELECTED DUE TO REVOKE ACTION IN PREVIOUS LAB 
 --QUESTION 12 : Find the roles given to Admin.
 CONNECT ADMIN
 SELECT GRANTED_ROLE FROM USER_ROLE_PRIVS ;
 --QUESTION 13 : Find all objects belonging to Admin.
 DESC USER_OBJECTS
 --QUESTION 14 : The administrator is looking for the owner of the INTERVENTIONS table,
 DESC ALL_TAB_COLUMNS
 SELECT DISTINCT(OWNER) FROM ALL_TAB_COLUMNS WHERE TABLE_NAME='INTERVENTIONS';
 --QUESTION 15: Give the size of the INTERVENTIONS table in KB.
 DESC ALL_TAB_COLUMNS
 SELECT DISTINCT(DATA_LENGTH) FROM ALL_TAB_COLUMNS WHERE TABLE_NAME='INTERVENTIONS';--FOR DATA 
 DESC DBA_SEGMENTS--FOR TABLES
SELECT  BYTES FROM DBA_SEGMENTS WHERE SEGMENT_NAME='INTERVENTIONS' AND SEGMENT_TYPE='TABLE';--RESULT  65536 BYTES 
--QUESTION 16 : CHECK THE EFFECT 