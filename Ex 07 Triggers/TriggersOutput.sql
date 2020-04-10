SQL> @"D:\College Material\Second Year\4th Semester\DBMS Lab\Ex7\Triggers.sql"
SQL> REM ********************************************************************
SQL> REM	  UCS 1412 - DATABASE LAB | IV SEMESTER
SQL> REM	  EX : 7     PL/SQL - TRIGGERS
SQL> REM					 - S. Vishakan 18 5001 196 CSE - C
SQL> REM ********************************************************************
SQL> 
SQL> SAVEPOINT A;

Savepoint created.

SQL> 
SQL> REM     1. The date of arrival should be always later than or on the same date of departure.
SQL> 
SQL> CREATE OR REPLACE TRIGGER date_of_arrival
  2  BEFORE INSERT OR UPDATE ON fl_schedule
  3  FOR EACH ROW
  4  BEGIN
  5  	     IF (:NEW.arrives < :OLD.departs) OR (:NEW.departs > :OLD.arrives) OR (:NEW.arrives < :NEW.departs) THEN
  6  		     RAISE_APPLICATION_ERROR(-20001, 'ERROR: Date of Arrival Must be Later Than/On the Same Date of Departure');
  7  	     END IF;
  8  END;
  9  /

Trigger created.

SQL> 
SQL> REM SATISFYING RECORD
SQL> INSERT INTO fl_schedule VALUES('AF-12','19-APR-20',1245,'20-APR-20',1850,450.25);

1 row created.

SQL> REM VIOLATING RECORD
SQL> INSERT INTO fl_schedule VALUES('AF-12','21-APR-20',1245,'20-APR-20',1850,450.25);
INSERT INTO fl_schedule VALUES('AF-12','21-APR-20',1245,'20-APR-20',1850,450.25)
            *
ERROR at line 1:
ORA-20001: ERROR: Date of Arrival Must be Later Than/On the Same Date of Departure 
ORA-06512: at "VISH.DATE_OF_ARRIVAL", line 3 
ORA-04088: error during execution of trigger 'VISH.DATE_OF_ARRIVAL' 


SQL> 
SQL> REM SATISFYING UPDATE
SQL> UPDATE fl_schedule SET arrives = '21-APR-20' WHERE flno = 'AF-12' AND departs = '19-APR-20';

1 row updated.

SQL> REM VIOLATING UPDATE
SQL> UPDATE fl_schedule SET arrives = '18-APR-20' WHERE flno = 'AF-12' AND departs = '19-APR-20';
UPDATE fl_schedule SET arrives = '18-APR-20' WHERE flno = 'AF-12' AND departs = '19-APR-20'
       *
ERROR at line 1:
ORA-20001: ERROR: Date of Arrival Must be Later Than/On the Same Date of Departure 
ORA-06512: at "VISH.DATE_OF_ARRIVAL", line 3 
ORA-04088: error during execution of trigger 'VISH.DATE_OF_ARRIVAL' 


SQL> 
SQL> DROP TRIGGER date_of_arrival;

Trigger dropped.

SQL> 
SQL> REM     2. Flight number CX­7520 is scheduled only on Tuesday, Friday and Sunday.
SQL> 
SQL> CREATE OR REPLACE TRIGGER cx7520_schedule
  2  BEFORE INSERT OR UPDATE ON fl_schedule
  3  FOR EACH ROW
  4  DECLARE
  5  	     sched_day_of_week CHAR(1);
  6  BEGIN
  7  	     SELECT TO_CHAR(:NEW.departs, 'D') INTO sched_day_of_week FROM DUAL;
  8  	     IF (sched_day_of_week NOT IN('1', '3', '6') AND :NEW.flno = 'CX-7520') THEN
  9  		     RAISE_APPLICATION_ERROR(-20002, 'ERROR: Flight CX-7520 is scheduled only on Tuesdays, Fridays or Sundays.');
 10  	     END IF;
 11  END;
 12  /

Trigger created.

SQL> 
SQL> REM SATISFYING RECORD - FRIDAY
SQL> INSERT INTO fl_schedule VALUES('CX-7520','06-MAR-20',1245,'07-MAR-20',1850,450.25);

1 row created.

SQL> REM VIOALTING RECORD - SATURDAY
SQL> INSERT INTO fl_schedule VALUES('CX-7520','07-MAR-20',1245,'07-MAR-20',1850,450.25);
INSERT INTO fl_schedule VALUES('CX-7520','07-MAR-20',1245,'07-MAR-20',1850,450.25)
            *
ERROR at line 1:
ORA-20002: ERROR: Flight CX-7520 is scheduled only on Tuesdays, Fridays or Sundays. 
ORA-06512: at "VISH.CX7520_SCHEDULE", line 6 
ORA-04088: error during execution of trigger 'VISH.CX7520_SCHEDULE' 


SQL> 
SQL> REM SATISFYING UPDATE - FRIDAY
SQL> UPDATE fl_schedule SET departs = '10-APR-2020' WHERE flno = 'CX-7520' AND departs = '12-APR-2005';

1 row updated.

SQL> 
SQL> REM VIOLATING UPDATE - SATURDAY
SQL> UPDATE fl_schedule SET departs = '11-APR-2020' WHERE flno = 'CX-7520' AND departs = '10-APR-2020';
UPDATE fl_schedule SET departs = '11-APR-2020' WHERE flno = 'CX-7520' AND departs = '10-APR-2020'
       *
ERROR at line 1:
ORA-20002: ERROR: Flight CX-7520 is scheduled only on Tuesdays, Fridays or Sundays. 
ORA-06512: at "VISH.CX7520_SCHEDULE", line 6 
ORA-04088: error during execution of trigger 'VISH.CX7520_SCHEDULE' 


SQL> 
SQL> DROP TRIGGER cx7520_schedule;

Trigger dropped.

SQL> 
SQL> REM     3. An aircraft is assigned to a flight only if its cruising range is more than the distance of the
SQL> REM     flights’ route.
SQL> 
SQL> CREATE OR REPLACE TRIGGER cruise_range_distance_check
  2  BEFORE INSERT OR UPDATE ON flights
  3  FOR EACH ROW
  4  DECLARE
  5  	     cr_range aircraft.cruisingrange % TYPE;
  6  	     dist routes.distance % TYPE;
  7  BEGIN
  8  	     SELECT a.cruisingrange INTO cr_range FROM aircraft a WHERE a.aid = :NEW.aid;
  9  	     SELECT r.distance INTO dist FROM routes r WHERE r.routeID = :NEW.rID;
 10  
 11  	     IF (cr_range < dist) THEN
 12  		     RAISE_APPLICATION_ERROR(-20003, 'ERROR: Cruising Range of Flight should be more than route distance.');
 13  	     END IF;
 14  END;
 15  /

Trigger created.

SQL> 
SQL> REM Cruising Range of Boeing, ID : 1 is : 8430
SQL> 
SQL> REM SATISFYING RECORD
SQL> INSERT INTO routes  VALUES('LS111','Los Angeles','Ottawa',8429);

1 row created.

SQL> INSERT INTO flights VALUES('9B-3734', 'LS111', 1);

1 row created.

SQL> REM VIOLATING RECORD
SQL> INSERT INTO routes      VALUES('LS110','Los Angeles','Perth',10300);

1 row created.

SQL> INSERT INTO flights VALUES('9B-3733', 'LS110', 1);
INSERT INTO flights VALUES('9B-3733', 'LS110', 1)
            *
ERROR at line 1:
ORA-20003: ERROR: Cruising Range of Flight should be more than route distance. 
ORA-06512: at "VISH.CRUISE_RANGE_DISTANCE_CHECK", line 9 
ORA-04088: error during execution of trigger 'VISH.CRUISE_RANGE_DISTANCE_CHECK' 


SQL> 
SQL> REM SATISFYING UPDATE
SQL> UPDATE flights SET aid = 1 WHERE flightNo='9B-3734';

1 row updated.

SQL> REM VIOLATING UPDATE
SQL> UPDATE flights SET aid = 5 WHERE flightNo = '9B-3734';
UPDATE flights SET aid = 5 WHERE flightNo = '9B-3734'
       *
ERROR at line 1:
ORA-20003: ERROR: Cruising Range of Flight should be more than route distance. 
ORA-06512: at "VISH.CRUISE_RANGE_DISTANCE_CHECK", line 9 
ORA-04088: error during execution of trigger 'VISH.CRUISE_RANGE_DISTANCE_CHECK' 


SQL> 
SQL> DROP TRIGGER cruise_range_distance_check;

Trigger dropped.

SQL> 
SQL> ROLLBACK;

Rollback complete.

SQL> 
SQL> REM ********************************************************************
SQL> REM				     END OF SCRIPT FILE
SQL> REM ********************************************************************
SQL> SPOOL OFF;
