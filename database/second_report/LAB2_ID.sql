--lab 2 
--question 1 : create user 
create user admin identified by admin_password;
DEFAULT TABLESPACE INTERVENTION_TBS TEMPORARY TABLESPACE INTERVENTION_TempTBS;
--2-- couldn't log in
connect admin/pw
--3--
GRANT CREATE SESSION TO admin;
--4-- give the PRIVILEGES 
-- create table 
Grant create table to admin;
--create user 
Grant create user to admin;
--login 
connect admin/pw
 --CHECK PREVILAGES
 SELECT *FROM USER_SYS_PRIVS;
--question 5 : 
Select * from DBAINTERVENTION.EMPLOYEE;--error no right for admin on that table 
--question 6--
connect DBAINTERVENTION/pw
GRANT SELECT ON Employee1 TO admin;
connect admin/pw

----------question 7----------------
-- select  EMPLOYEENUMBER,INTERVENTIONNUMBER from PARTICIPANTS1;  --have to give admin the acces to see participant
connect DBAINTERVENTION/pw
grant select,UPDATE on PARTICIPANTS1 to admin;
grant UPDATE on EMPLOYEE1 to admin;
connect admin/pw
select  EMPLOYEENUMBER,INTERVENTIONNUMBER from PARTICIPANTS1;

-------------question 8-----------  
SELECT employeenumber, count(interventionnumber) FROM PARTICIPANTS1 GROUP BY EMPLOYEENUMBER;
UPDATE (
SELECT salary
FROM (SELECT employeenumber AS empl, COUNT(interventionnumber) AS countparti
FROM PARTICIPANTS1
GROUP BY employeenumber) ,
EMPLOYEE1
WHERE countparti >=4 AND employeenumber = empl )
SET salary = salary + 500;
--from teacher 
UPDATE DBAINTERVENTION.EMPLOYEE SET SALARY = SALARY + 3000
WHERE EMPLOYEENUMBER IN ( SELECT EN FROM
             (SELECT EN, COUNT(PI) AS CPI
             FROM (SELECT EMPLOYEE.EMPLOYEENUMBER AS EN, PARTICIPANTS.INTERVENTIONNUMBER AS PI
             FROM DBAINTERVENTION.EMPLOYEE INNER JOIN DBAINTERVENTION.PARTICIPANTS ON EMPLOYEE.EMPLOYEENUMBER = PARTICIPANTS.EMPLOYEENUMBER)
             GROUP BY EN
             HAVING COUNT(PI) >= 4));


------------question 9--------------------
create index LASTNAMEEMP_IX on DBAINTERVENTION.EMPLOYEE( LASTNAMEEMP); --didn't create an index cause i don't have the right
------------question 10--------------------
connect DBAINTERVENTION/pw
Grant create any index to admin; --after this and giving him the right it's working
--OR
GRANT INDEX ON EMPLOYEE TO ADMIN;
connect admin/pw
CREATE INDEX LASTNAMEEMP_I ON DBAINTERVENTION.EMPLOYEE1(LASTNAMEEMP);
--------------QUESTION 11---------------
CONNECT SYSTEM/**/
REVOKE CREATE SESSION FROM admin;
REVOKE CREATE TABLE FROM admin;
REVOKE CREATE USER FROM admin;
CONNECT DBAINTERVENTION/PS;
REVOKE SELECT ON EMPLOYEE1 FROM admin;
REVOKE SELECT ON PARTICIPANTS1 FROM admin;
REVOKE UPDATE ON PARTICIPANTS1 FROM admin;
REVOKE UPDATE ON EMPLOYEE1 FROM admin;
REVOKE INDEX ON EMPLOYEE1 FROM admin;

--------------- QUESTION 12----------------
SELECT * from USER_SYS_PRIVS;

------------- QUESTION 13-----------------------
--Create a profile
CREATE PROFILE Interv_Profile LIMIT
SESSIONS_PER_USER 3
CPU_PER_CALL 35
CONNECT_TIME 90
LOGICAL_READS_PER_SESSION 1200
PRIVATE_SGA 25
IDLE_TIME 30
FAILED_LOGIN_ATTEMPTS 5
PASSWORD_LIFE_TIME 50
PASSWORD_REUSE_TIME 40
PASSWORD_LOCK_TIME 1
PASSWORD_GRACE_TIME 5;


-----------------QUESTION 14------------------
--assign the profile to a user
ALTER USER admin profile Interv_Profile;

----------------question 15-------------------
--Create the role:
CREATE ROLE INTERVENTION_MANAGER;
GRANT select ON EMPLOYEE1  TO INTERVENTION_MANAGER;
GRANT select ON VEHICLE1  TO INTERVENTION_MANAGER;
GRANT select ON CUSTOMER1  TO INTERVENTION_MANAGER;

GRANT  select,insert,update,delete,alter  on  INTERVENTION1  to INTERVENTION_MANAGER;
GRANT  select,insert,update,delete,alter  on  PARTICIPANTS1  to INTERVENTION_MANAGER;


-------------question 16---------------------------
--Assign this role to Admin.
 GRANT INTERVENTION_MANAGER TO admin;
 --check PRIVILEGES
 select * from USER_ROLE_PRIVS;
