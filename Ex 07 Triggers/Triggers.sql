REM ********************************************************************
REM	     UCS 1412 - DATABASE LAB | IV SEMESTER
REM	     EX : 7	PL/SQL - TRIGGERS
REM				                  - S. Vishakan 18 5001 196 CSE - C
REM ********************************************************************

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

REM SATISFYING RECORD
INSERT INTO fl_schedule VALUES('AF-12','19-APR-20',1245,'20-APR-20',1850,450.25);
REM VIOLATING RECORD
INSERT INTO fl_schedule VALUES('AF-12','21-APR-20',1245,'20-APR-20',1850,450.25);

REM SATISFYING UPDATE
UPDATE fl_schedule SET arrives = '21-APR-20' WHERE flno = 'AF-12' AND departs = '19-APR-20';
REM VIOLATING UPDATE
UPDATE fl_schedule SET arrives = '18-APR-20' WHERE flno = 'AF-12' AND departs = '19-APR-20';

DROP TRIGGER date_of_arrival;

REM	2. Flight number CX­7520 is scheduled only on Tuesday, Friday and Sunday.

CREATE OR REPLACE TRIGGER cx7520_schedule
BEFORE INSERT OR UPDATE ON fl_schedule
FOR EACH ROW
DECLARE
	sched_day_of_week CHAR(1);
BEGIN
	SELECT TO_CHAR(:NEW.departs, 'D') INTO sched_day_of_week FROM DUAL;
	IF (sched_day_of_week NOT IN('1', '3', '6') AND :NEW.flno = 'CX-7520') THEN
		RAISE_APPLICATION_ERROR(-20002, 'ERROR: Flight CX-7520 is scheduled only on Tuesdays, Fridays or Sundays.');
	END IF;
END;
/

REM SATISFYING RECORD - FRIDAY
INSERT INTO fl_schedule VALUES('CX-7520','06-MAR-20',1245,'07-MAR-20',1850,450.25);
REM VIOALTING RECORD - SATURDAY
INSERT INTO fl_schedule VALUES('CX-7520','07-MAR-20',1245,'07-MAR-20',1850,450.25);

REM SATISFYING UPDATE - FRIDAY
UPDATE fl_schedule SET departs = '10-APR-2020' WHERE flno = 'CX-7520' AND departs = '12-APR-2005';

REM VIOLATING UPDATE - SATURDAY
UPDATE fl_schedule SET departs = '11-APR-2020' WHERE flno = 'CX-7520' AND departs = '10-APR-2020';

DROP TRIGGER cx7520_schedule;

REM	3. An aircraft is assigned to a flight only if its cruising range is more than the distance of the 
REM	flights’ route.

CREATE OR REPLACE TRIGGER cruise_range_distance_check
BEFORE INSERT OR UPDATE ON flights
FOR EACH ROW
DECLARE
	cr_range aircraft.cruisingrange % TYPE;
	dist routes.distance % TYPE;
BEGIN
	SELECT a.cruisingrange INTO cr_range FROM aircraft a WHERE a.aid = :NEW.aid;
	SELECT r.distance INTO dist FROM routes r WHERE r.routeID = :NEW.rID;

	IF (cr_range < dist) THEN
		RAISE_APPLICATION_ERROR(-20003, 'ERROR: Cruising Range of Flight should be more than route distance.');
	END IF;
END;
/

REM Cruising Range of Boeing, ID : 1 is : 8430

REM SATISFYING RECORD
INSERT INTO routes  VALUES('LS111','Los Angeles','Ottawa',8429);
INSERT INTO flights VALUES('9B-3734', 'LS111', 1);
REM VIOLATING RECORD
INSERT INTO routes	VALUES('LS110','Los Angeles','Perth',10300);
INSERT INTO flights VALUES('9B-3733', 'LS110', 1);

REM SATISFYING UPDATE
UPDATE flights SET aid = 1 WHERE flightNo='9B-3734';
REM VIOLATING UPDATE
UPDATE flights SET aid = 5 WHERE flightNo = '9B-3734';

DROP TRIGGER cruise_range_distance_check;

ROLLBACK;

REM ********************************************************************
REM 					END OF SCRIPT FILE
REM ********************************************************************