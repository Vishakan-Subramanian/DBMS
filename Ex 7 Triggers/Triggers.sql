SQL> REM ********************************************************************
SQL> REM	     UCS 1412 - DATABASE LAB | IV SEMESTER
SQL> REM	     EX : 7	PL/SQL - TRIGGERS
SQL> REM				                  - S. Vishakan 18 5001 196 CSE - C
SQL> REM ********************************************************************

SAVEPOINT A;

REM	1. The date of arrival should be always later than or on the same date of departure.

CREATE OR REPLACE TRIGGER date_of_arrival
BEFORE INSERT OR UPDATE ON fl_schedule
FOR EACH ROW
BEGIN
	IF (:NEW.arrives < :OLD.departs) OR (:NEW.departs > :OLD.arrives) OR (:NEW.arrives < :NEW.departs) THEN
		RAISE_APPLICATION_ERROR(-20001, 'ERROR: Date of Arrival Must be Later Than/On the Same Date of Departure');
	END IF;
END;
/

INSERT INTO fl_schedule VALUES('AF-12','19-APR-20',1245,'20-APR-20',1850,450.25);
INSERT INTO fl_schedule VALUES('AF-12','21-APR-20',1245,'20-APR-20',1850,450.25);

REM	2. Flight number CX­7520 is scheduled only on Tuesday, Friday and Sunday.

CREATE OR REPLACE TRIGGER cx7520_schedule
BEFORE INSERT OR UPDATE ON fl_schedule
FOR EACH ROW
DECLARE
	sched_day NUMBER(1);
BEGIN
	SELECT EXTRACT(day from :NEW.departs) INTO sched_day FROM DUAL;
	IF (sched_day NOT IN(1, 5, 6) AND :NEW.flno = 'CX-7520') THEN
		RAISE_APPLICATION_ERROR(-20002, 'ERROR: Flight CX-7520 is scheduled only on Tuesdays, Fridays or Sundays.');
	END IF;
END;
/

REM FRIDAY
INSERT INTO fl_schedule VALUES('CX-7520','06-MAR-20',1245,'07-MAR-20',1850,450.25);
REM SATURDAY
INSERT INTO fl_schedule VALUES('CX-7520','07-MAR-20',1245,'07-MAR-20',1850,450.25);


REM	3. An aircraft is assigned to a flight only if its cruising range is more than the distance of the 
REM	flights’ route.

CREATE OR REPLACE TRIGGER cruise_range_distance_check
BEFORE INSERT OR UPDATE ON flights
FOR EACH ROW
DECLARE
	cr_range aircraft.cruisingrange % TYPE;
	dist routes.distance % TYPE;
BEGIN
	SELECT DISTINCT cruisingrange, distance INTO cr_range, dist 
	FROM aircraft, flights, routes 
	WHERE aircraft.aid = :NEW.aid AND routes.routeID = :NEW.rid;

	IF (cr_range < dist) THEN
		RAISE_APPLICATION_ERROR(-20003, 'ERROR: Cruising Range of Flight should be more than route distance.');
	END IF;
END;
/

REM Cruising Range of Boeing, ID : 1 is : 8430
REM VIOLATION
INSERT INTO routes VALUES ('LS104','Los Angeles','Perth',10300);
INSERT INTO flights VALUES('9B-3733', 'LS104', 1);
REM SATISFYING RECORD
INSERT INTO routes VALUES ('LS110','Los Angeles','Ottawa',8429);
INSERT INTO flights  VALUES('9B-3734', 'LS110', 1);

ROLLBACK TO A;

REM ********************************************************************
REM 					END OF SCRIPT FILE
REM ********************************************************************