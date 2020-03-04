REM ********************************************************************
REM 		UCS 1412 - DATABASE LAB | IV SEMESTER
REM 		EX : 3     ADVANCED	DML
REM 					- S. Vishakan 18 5001 196 CSE - C
REM ********************************************************************


REM	1. Display the flight number,departure date and time of a flight, its route details and aircraft
REM	name of type either Schweizer or Piper that departs during 8.00 PM and 9.00 PM.

SELECT		f.flightNo AS "FLIGHT NUMBER", s.departs AS "DEPARTURE DATE", s.dtime AS "DEPARTURE TIME", r.routeID AS "ROUTE ID", r.dest_airport AS "DEST. AIRPORT", r.orig_airport AS "ORIG. AIRPORT", r.distance AS "DISTANCE", a.aname AS "AIRCRAFT NAME"
FROM		flights f, fl_schedule s, routes r, aircraft a
WHERE		f.flightNo	=	s.flno
AND			r.routeID	=	f.rID
AND			a.aid 		=	f.aid
AND			s.dtime 	BETWEEN	2000 AND 2100
AND			f.aid 		=	ANY(SELECT	a.aid 
								FROM 	aircraft a
								WHERE	a.type IN ('Schweizer', 'Piper'));

REM	2. For all the routes, display the flight number, origin and destination airport, if a flight is
REM	assigned for that route.

SELECT		r.routeID AS "ROUTE ID", f.flightNo AS "FLIGHT NUMBER", r.orig_airport AS "ORIGIN AIRPORT", r.dest_airport AS "DESTINATION AIRPORT"
FROM		routes 	r
LEFT JOIN	flights f
ON			f.rID	=	r.routeID
ORDER BY 	r.routeID;

REM	3. For all aircraft with cruisingrange over 5,000 miles, find the name of the aircraft and the
REM	average salary of all pilots certified for this aircraft.

SELECT		a.aname AS "AIRCRAFT NAME", avg(e.salary) AS "AVG. SALARY"
FROM		aircraft a, certified c, employee e
WHERE		a.aid = c.aid 
AND			c.eid = e.eid 
AND			a.cruisingrange > 5000
GROUP BY	a.aname;

REM	4. Show the employee details such as id, name and salary who are not pilots and whose salary
REM	is more than the average salary of pilots.

SELECT		e.eid AS "EMPLOYEE ID", e.ename AS "EMPLOYEE NAME", e.salary AS "SALARY"
FROM		employee	e
LEFT JOIN	certified	c
ON			e.eid		=	c.eid
WHERE		c.eid		IS NULL
AND			e.salary	>	(SELECT AVG(emp.salary) 
							FROM employee emp, certified ctd 
							WHERE emp.eid = ctd.eid);

REM	5. Find the id and name of pilots who were certified to operate some aircrafts but at least one
REM	of that aircraft is not scheduled from any routes.	

SELECT		DISTINCT e.eid AS "EMPLOYEE ID", e.ename AS "EMPLOYEE NAME"
FROM		employee e, certified c
WHERE		e.eid	=	c.eid
AND			c.aid 	IN	(SELECT c.aid 
						FROM certified c 
						LEFT JOIN flights f 
						ON f.aid = c.aid 
						WHERE f.rID IS NULL)
ORDER BY e.eid DESC;	

REM	6. Display the origin and destination of the flights having at least three departures with
REM	maximum distance covered.

SELECT	orig_airport AS "ORIGIN AIRPORT", dest_airport AS "DESTINATION AIRPORT"
FROM	(SELECT     r.orig_airport, r.dest_airport, COUNT(fl.departs)
    	FROM        routes	r, flights f, fl_schedule fl
        WHERE       r.routeID = f.rID AND fl.flno = f.flightNo
        AND         r.distance  =   (SELECT MAX(r.distance) 
                                    FROM routes r)
    	GROUP BY    r.orig_airport, r.dest_airport
    	HAVING      COUNT(fl.departs) >= 3);	 	

REM	7. Display name and salary of pilot whose salary is more than the average salary of any pilots
REM	for each route other than flights originating from Madison airport.

SELECT		e.salary AS "SALARY", e.ename AS "EMPLOYEE NAME"
FROM		employee	e, routes r, flights f, certified c
WHERE		e.eid		=	c.eid	AND f.rID = r.routeID AND f.aid = c.aid
AND			e.salary	>	(SELECT		AVG(e.salary) 
							FROM		employee e, certified c
							WHERE		e.eid = c.eid)
AND			r.orig_airport NOT LIKE 'Madison'
GROUP BY	e.ename, e.salary;

REM	8. Display the flight number, aircraft type, source and destination airport of the aircraft having
REM	maximum number of flights to Honolulu.

SELECT	f.flightNo AS "FLIGHT NO.", a.type AS "AIRCRAFT TYPE", r.orig_airport AS "SRC. AIRPORT", r.dest_airport AS "DEST. AIRPORT"
FROM	flights f, aircraft a, routes r
WHERE	f.rID = r.routeID AND f.aid = a.aid
AND		r.dest_airport = 'Honolulu'
AND		f.aid =	(SELECT aid FROM	(SELECT f_outer.aid, COUNT(*) 
									FROM routes r, flights f_outer 
									WHERE r.dest_airport = 'Honolulu' AND r.routeID = f_outer.rID
									GROUP BY f_outer.aid
									ORDER BY COUNT(*) DESC) 
							WHERE rownum = 1);

REM	9. Display the pilot(s) who are certified exclusively to pilot all aircraft in a type.

SELECT	* 
FROM	employee 
WHERE	eid IN	(SELECT c.eid
				FROM	certified c, aircraft a
				WHERE	c.aid = a.aid AND c.eid	IN	(SELECT c1.eid
													FROM	certified c1, aircraft a1
													WHERE	c1.aid = a1.aid
													GROUP BY c1.eid
													HAVING	 COUNT(DISTINCT a1.type) = 1)
				GROUP BY c.eid, a.type
				HAVING 	 COUNT(*) = (SELECT COUNT(a2.aid)
									FROM 	aircraft a2
									WHERE 	a2.type = a.type))
ORDER BY eid;

REM	10. Name the employee(s) who is earning the maximum salary among the airport having
REM	maximum number of departures.

SELECT e.ename	AS	"EMPLOYEE NAME" 
FROM employee e
WHERE e.salary	=	(SELECT	MAX(e.salary)
					FROM	employee e, certified c
					WHERE	e.eid = c.eid
					AND     c.aid	IN	(SELECT f.aid FROM flights f, routes r
										WHERE 	f.rID = r.routeID
										AND		r.orig_airport =	(SELECT orig_airport 
																	FROM	(SELECT r.orig_airport, COUNT(fl.departs)
																			FROM routes r, flights f, fl_schedule fl
																			WHERE r.routeID = f.rID AND fl.flno = f.flightNo
																			GROUP BY r.orig_airport
																			ORDER BY COUNT(fl.departs) DESC) 
																	WHERE rownum = 1)));		

REM	11. Display the departure chart as follows:
REM	flight number, departure(date,airport,time), destination airport, arrival time, aircraft name
REM	for the flights from New York airport during 15 to 19th April 2005. Make sure that the route
REM	contains at least two flights in the above specified condition.
        
SELECT	f.flightNo												AS "FLIGHT NUMBER", 
		fl.departs || ' ' || r.orig_airport || ' ' || fl.dtime	AS "DEPARTURE",
		r.dest_airport 											AS "DEST. AIRPORT",
		fl.atime 												AS	"ARRIVAL TIME",
		a.aname 												AS "AIRCRAFT NAME"
FROM	flights f, fl_schedule fl, routes r, aircraft a
WHERE	f.flightNo = fl.flno AND r.routeID = f.rID AND f.aid = a.aid
AND		r.orig_airport = 'New York' AND	fl.departs BETWEEN TO_DATE('15/04/2005', 'DD/MM/YYYY') AND TO_DATE('19/04/2005', 'DD/MM/YYYY')
;


AND		(SELECT COUNT(*) FROM	(SELECT fl.flno
								FROM	flights f, fl_schedule fl, routes r, aircraft a
								WHERE	f.flightNo = fl.flno AND r.routeID = f.rID AND f.aid = a.aid
								AND		r.orig_airport = 'New York' AND	fl.departs BETWEEN TO_DATE('15/04/2005', 'DD/MM/YYYY') AND TO_DATE('19/04/2005', 'DD/MM/YYYY'))) >= 2;


SELECT	f.flightNo, fl.atime FROM	flights f, fl_schedule fl, routes r, aircraft a
WHERE	f.flightNo = fl.flno AND r.routeID = f.rID AND f.aid = a.aid
AND		r.orig_airport = 'New York' AND	fl.departs BETWEEN TO_DATE('15/04/2005', 'DD/MM/YYYY') AND TO_DATE('19/04/2005', 'DD/MM/YYYY')



REM	Use SET operators (any one operator) for each of the following:

REM	12. A customer wants to travel from Madison to New York with no more than two changes of
REM	flight. List the flight numbers from Madison if the customer wants to arrive in New York by
REM	6.50 p.m.

SELECT	f.flightNo	AS	"FLIGHT NUMBER"
FROM	flights f
WHERE	f.flightNo	IN( (SELECT		f0.flightNo
						FROM		flights f0, routes r, fl_schedule fl
						WHERE		r.routeID = f0.rID 					AND f0.flightNo = fl.flno
						AND			r.orig_airport = 'Madison' 			AND	r.dest_airport = 'New York'	AND fl.atime <= 1850)
						UNION
						(SELECT		f0.flightNo
						FROM		flights f0, flights f1, routes r0, routes r1, fl_schedule fl0, fl_schedule fl1 
						WHERE		r0.routeID = f0.rID					AND	f0.flightNo = fl0.flno
						AND 		r1.routeID = f1.rID					AND f1.flightNo = fl1.flno
						AND			r0.orig_airport = 'Madison'			AND r0.dest_airport <> 'New York'
						AND			r1.orig_airport = r0.dest_airport	AND	r1.dest_airport = 'New York' 
						AND 		fl1.atime <= 1850 					AND fl0.departs <= fl1.arrives)
						UNION
						(SELECT		f0.flightNo
						FROM		flights f0, flights f1, flights f2, routes r0, routes r1, routes r2, fl_schedule fl0, fl_schedule fl1, fl_schedule fl2
						WHERE		r0.routeID = f0.rID					AND f0.flightNo = fl0.flno
						AND			r1.routeID = f1.rID					AND	f1.flightNo = fl1.flno
                        AND			r2.routeID = f2.rID					AND f2.flightNo = fl2.flno
						AND			r0.orig_airport = 'Madison'			AND	r0.dest_airport <> 'New York'
						AND			r1.orig_airport = r0.dest_airport	AND	r1.dest_airport <> 'New York'
						AND			r2.orig_airport = r1.dest_airport	AND r2.dest_airport = 'New York'
                        AND			fl2.atime <= 1850					AND	fl1.dtime > fl0.atime
                        AND         fl0.departs <= fl1.arrives          AND fl1.departs <= fl2.arrives
                        GROUP BY    f0.flightNo)
					);

REM	13. Display the id and name of employee(s) who are not pilots.

SELECT	eid AS "EMPLOYEE ID", ename AS "EMPLOYEE NAME"	
		FROM	((SELECT * 
				FROM 	employee) 
				MINUS
				(SELECT e.* 
				FROM 	employee e, certified c WHERE e.eid = c.eid));


REM	14. Display the id and name of employee(s) who pilots the aircraft from Los Angels and Detroit
REM	airport.


SELECT	e.eid AS "EMPLOYEE ID", e.ename AS "EMPLOYEE NAME"
FROM	employee e 
WHERE 	e.eid	IN	((SELECT	e.eid	
					FROM		employee e, certified c, flights f, routes r
					WHERE		e.eid = c.eid	AND	f.aid = c.aid	AND	r.routeID = f.rID
					AND			r.orig_airport	= 'Los Angeles')	
					INTERSECT
					(SELECT		e.eid
					FROM		employee e, certified c, flights f, routes r
					WHERE		e.eid = c.eid	AND	f.aid = c.aid	AND	r.routeID = f.rID
					AND			r.orig_airport	= 'Detroit'));



REM ********************************************************************
REM 					END OF SCRIPT FILE
REM ********************************************************************


REM ********************************************************************

						SELECT		*
						FROM		flights f0, flights f1, routes r0, routes r1, fl_schedule fl0, fl_schedule fl1 
						WHERE		r0.routeID = f0.rID					AND	f0.flightNo = fl0.flno
						AND 		r1.routeID = f1.rID					AND f1.flightNo = fl1.flno
						AND			f0.flightno = '9E-3622' AND r1.dest_airport = 'New York' AND r0.orig_airport = 'Madison'
                        AND         r0.dest_airport = r1.orig_airport;

						
                        
                        SELECT		*
						FROM		flights f0, flights f1, flights f2, routes r0, routes r1, routes r2, fl_schedule fl0, fl_schedule fl1, fl_schedule fl2
						WHERE		r0.routeID = f0.rID					AND f0.flightNo = fl0.flno
						AND			r1.routeID = f1.rID					AND	f1.flightNo = fl1.flno
                        AND			r2.routeID = f2.rID					AND f2.flightNo = fl2.flno
						AND			r0.orig_airport = 'Madison'			AND	r0.dest_airport <> 'New York'
						AND			r1.orig_airport = r0.dest_airport	AND	r1.dest_airport <> 'New York'
						AND			r2.orig_airport = r1.dest_airport	AND r2.dest_airport = 'New York'
                        AND			f0.flightno = '9E-3622';
                        
                        SELECT		*
						FROM		flights f0, routes r, fl_schedule fl
						WHERE		r.routeID = f0.rID 					AND f0.flightNo = fl.flno
						AND			f0.flightno = '9E-3622';

						
						SELECT		*
						FROM		flights f0, flights f1, flights f2, routes r0, routes r1, routes r2, fl_schedule fl0, fl_schedule fl1, fl_schedule fl2
						WHERE		r0.routeID = f0.rID					AND f0.flightNo = fl0.flno
						AND			r1.routeID = f1.rID					AND	f1.flightNo = fl1.flno
                        AND			r2.routeID = f2.rID					AND f2.flightNo = fl2.flno
						AND			r0.orig_airport = 'Madison'			AND	r0.dest_airport <> 'New York'
						AND			r1.orig_airport = r0.dest_airport	AND	r1.dest_airport <> 'New York'
						AND			r2.orig_airport = r1.dest_airport	AND r2.dest_airport = 'New York';


						SELECT		*
						FROM		flights f0, flights f1, routes r0, routes r1, fl_schedule fl0, fl_schedule fl1 
						WHERE		r0.routeID = f0.rID					AND	f0.flightNo = fl0.flno
						AND 		r1.routeID = f1.rID					AND f1.flightNo = fl1.flno
						AND			f0.flightno = 'EV-5134' AND r1.dest_airport = 'New York' AND r0.orig_airport = 'Madison'
                        AND         r0.dest_airport = r1.orig_airport;
                        
                        SELECT		*
						FROM		flights f0, flights f1, flights f2, routes r0, routes r1, routes r2, fl_schedule fl0, fl_schedule fl1, fl_schedule fl2
						WHERE		r0.routeID = f0.rID					AND f0.flightNo = fl0.flno
						AND			r1.routeID = f1.rID					AND	f1.flightNo = fl1.flno
                        AND			r2.routeID = f2.rID					AND f2.flightNo = fl2.flno
						AND			r0.orig_airport = 'Madison'			AND	r0.dest_airport <> 'New York'
						AND			r1.orig_airport = r0.dest_airport	AND	r1.dest_airport <> 'New York'
						AND			r2.orig_airport = r1.dest_airport	AND r2.dest_airport = 'New York'
                        AND			f0.flightno = 'EV-5134';
                        
                        SELECT		*
						FROM		flights f0, routes r, fl_schedule fl
						WHERE		r.routeID = f0.rID 					AND f0.flightNo = fl.flno
						AND			f0.flightno = 'EV-5134';

						
						SELECT	arrives, atime, flno
						FROM	fl_schedule
						GROUP BY arrives, atime, flno;

						SELECT	arrives, atime, flno
						FROM	fl_schedule
						GROUP BY flno, atime, arrives;

						SELECT	arrives, atime, dtime, flno
						FROM	fl_schedule
						GROUP BY flno;
