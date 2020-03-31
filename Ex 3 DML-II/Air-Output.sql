SQL> REM ********************************************************************
SQL> REM 		UCS 1412 - DATABASE LAB | IV SEMESTER
SQL> REM 		EX : 3     ADVANCED	DML
SQL> REM 								- S. Vishakan 18 5001 196 CSE - C
SQL> REM ********************************************************************
SQL> 
SQL> 
SQL> REM	1. Display the flight number,departure date and time of a flight, its route details and aircraft
SQL> REM	name of type either Schweizer or Piper that departs during 8.00 PM and 9.00 PM.
SQL> 
SQL> SELECT		f.flightNo		AS	"FLIGHT NUMBER",
  2  			    s.departs		AS	"DEPARTURE DATE",
  3  			    s.dtime			AS	"DEPARTURE TIME",
  4  			    r.routeID		AS 	"ROUTE ID",
  5  			    r.dest_airport	AS	"DEST. AIRPORT",
  6  			    r.orig_airport	AS	"ORIG. AIRPORT",
  7  			    r.distance		AS	"DISTANCE"
  8  FROM		flights f, fl_schedule s, routes r
  9  WHERE		f.flightNo	=	s.flno
 10  AND			r.routeID	=	f.rID
 11  AND			s.dtime 	BETWEEN	2000 AND 2100
 12  AND			f.aid 		=	ANY (SELECT aid 
 13  								          FROM aircraft 
 14  								          WHERE type IN ('Schweizer', 'Piper'));

FLIGHT  DEPARTUR DEPARTURE TIME ROUTE  DEST. AIRPORT        ORIG. AIRPORT          DISTANCE
------- -------- -------------- ------ -------------------- -------------------- ----------
RP-5018 15-04-05           2100 MC201  Chicago              Madison                     150
AS-5062 13-04-05           2010 MM203  Minneapolis          Madison                     247

SQL> 
SQL> REM	2. For all the routes, display the flight number, origin and destination airport, if a flight is
SQL> REM	assigned for that route.
SQL> 
SQL> SELECT		f.flightNo		  AS	"FLIGHT NUMBER",
  2  			    r.orig_airport	AS	"ORIGIN AIRPORT",
  3  			    r.dest_airport	AS	"DESTINATION AIRPORT"
  4  FROM		routes 	r
  5  INNER JOIN	flights f
  6  ON			f.rID	=	r.routeID;

FLIGHT  ORIGIN AIRPORT       DESTINATION AIRPORT 
------- -------------------- --------------------
9E-3749 Detroit              Montreal            
MQ-4477 Detroit              New York            
MQ-4565 Detroit              New York            
CX-7520 Los Angeles          Dallas              
WS-5060 Los Angeles          Dallas              
QF-3045 Los Angeles          Dallas              
JJ-7456 Los Angeles          Washington D.C.     
JJ-2482 Los Angeles          Washington D.C.     
SN-8814 Los Angeles          Washington D.C.     
WN-484  Los Angeles          Chicago             
WN-434  Los Angeles          Chicago             

FLIGHT  ORIGIN AIRPORT       DESTINATION AIRPORT 
------- -------------------- --------------------
B6-474  Los Angeles          Boston              
B6-482  Los Angeles          Boston              
VA-6551 Los Angeles          Sydney              
VA-2    Los Angeles          Sydney              
DJ-2    Los Angeles          Sydney              
SQ-11   Los Angeles          Tokyo               
AI-7205 Los Angeles          Tokyo               
MH-93   Los Angeles          Tokyo               
HA-3    Los Angeles          Honolulu            
HA-1    Los Angeles          Honolulu            
UA-1428 Los Angeles          Honolulu            

FLIGHT  ORIGIN AIRPORT       DESTINATION AIRPORT 
------- -------------------- --------------------
A5-3376 Chicago              Los Angeles         
A5-3246 Chicago              New York            
9E-3851 Madison              Detroit             
9E-3622 Madison              Detroit             
G7-6205 Madison              New York            
EV-5134 Madison              New York            
RP-5018 Madison              Chicago             
G7-3664 Madison              Chicago             
FX-2351 Madison              Pittsburgh          
AS-5958 Madison              Minneapolis         
AS-5062 Madison              Minneapolis         

FLIGHT  ORIGIN AIRPORT       DESTINATION AIRPORT 
------- -------------------- --------------------
DL-3402 Pittsburgh           New York            
CY-1846 New York             London              
BA-178  New York             London              
IB-4618 New York             London              
VS-26   New York             London              
AF-23   New York             Paris               
AF-11   New York             Paris               
RJ-7056 New York             Paris               
AF-12   Los Angeles          New York            

42 rows selected. 

SQL> 
SQL> REM	3. For all aircraft with cruisingrange over 5,000 miles, find the name of the aircraft and the
SQL> REM	average salary of all pilots certified for this aircraft.
SQL> 
SQL> SELECT		a.aname			  AS	"AIRCRAFT NAME",
  2  			    avg(e.salary)	AS	"AVG. SALARY"
  3  FROM		  aircraft a, certified c, employee e
  4  WHERE		a.aid = c.aid 
  5  AND			c.eid = e.eid 
  6  AND			a.cruisingrange > 5000
  7  GROUP BY	a.aname;

AIRCRAFT NAME                  AVG. SALARY
------------------------------ -----------
Airbus A340-300                 217597.667
Boeing 777-300                  257973.333
Boeing 767-400ER                    209557
Boeing 747-400                   244776.75
Lockheed L1011 Tristar           242685.75

SQL> 
SQL> REM	4. Show the employee details such as id, name and salary who are not pilots and whose salary
SQL> REM	is more than the average salary of pilots.
SQL> 
SQL> SELECT		e.eid		AS	"EMPLOYEE ID",
  2  			    e.ename 	AS	"EMPLOYEE NAME",
  3  			    e.salary	AS	"SALARY"
  4  FROM		    employee	e
  5  LEFT JOIN	certified	c
  6  ON			    e.eid		=	c.eid
  7  WHERE		  c.eid		IS NULL
  8  AND			  e.salary	>	(SELECT AVG(emp.salary) 
  9  						            FROM employee emp, certified ctd 
 10  							          WHERE emp.eid = ctd.eid);

EMPLOYEE ID EMPLOYEE NAME                      SALARY
----------- ------------------------------ ----------
  486512566 David Anderson                     743001

SQL> 
SQL> REM	5. Find the id and name of pilots who were certified to operate some aircrafts but at least one
SQL> REM	of that aircraft is not scheduled from any routes.	
SQL> 
SQL> SELECT		e.eid	AS	"EMPLOYEE ID",
  2  			    e.ename	AS	"EMPLOYEE NAME"
  3  FROM		  employee e, certified c
  4  WHERE		e.eid	=	c.eid
  5  AND			c.aid 	IN	(SELECT c.aid 
  6  						          FROM certified c 
  7  						          LEFT JOIN flights f 
  8  						          ON f.aid = c.aid 
  9  					          	WHERE f.rID IS NULL);

EMPLOYEE ID EMPLOYEE NAME                 
----------- ------------------------------
   90873519 Elizabeth Taylor              
  269734834 George Wright                 
  356187925 Robert Brown                  
  574489456 William Jones                 
  142519864 Betty Adams                   
  269734834 George Wright                 
  390487451 Lawrence Sperry               
  556784565 Mark Young                    
  567354612 Lisa Walker                   
  573284895 Eric Cooper                   

10 rows selected. 

SQL> 
SQL> REM	6. Display the origin and destination of the flights having at least three departures with
SQL> REM	maximum distance covered.
SQL> 
SQL> SELECT      orig_airport "ORIGIN AIRPORT",
  2              dest_airport "DESTINATION AIRPORT"
  3  FROM        (SELECT     r.orig_airport, r.dest_airport, COUNT(fl.departs)
  4              FROM        routes	r, flights f, fl_schedule fl
  5              WHERE       r.routeID = f.rID AND fl.flno = f.flightNo
  6              AND         r.distance  =   (SELECT MAX(r.distance) 
  7                                           FROM routes r)
  8              GROUP BY    r.orig_airport, r.dest_airport
  9              HAVING      COUNT(fl.departs) >= 3);

ORIGIN AIRPORT       DESTINATION AIRPORT 
-------------------- --------------------
Los Angeles          Sydney              

SQL> 
SQL> REM	7. Display name and salary of pilot whose salary is more than the average salary of any pilots
SQL> REM	for each route other than flights originating from Madison airport.
SQL> 
SQL> SELECT		  e.ename 	AS	"EMPLOYEE NAME",
  2  			      e.salary	AS	"SALARY"
  3  FROM		    employee	e
  4  LEFT JOIN	certified	c
  5  ON			    e.eid		=	c.eid
  6  WHERE		  e.salary	>	(SELECT		AVG(e.salary) 
  7  							        FROM		employee e, certified c, routes r, flights f, fl_schedule s
  8  						         	WHERE		e.eid = c.eid		    AND			f.rID = r.routeID
  9  							        AND			f.flightNo = s.flno	AND			f.aid = c.aid
 10  							        AND			r.orig_airport 		  NOT LIKE	'Madison')
 11  GROUP BY	e.ename, e.salary;

EMPLOYEE NAME                      SALARY
------------------------------ ----------
Betty Adams                        227489
George Wright                      289950
Lawrence Sperry                    212156
Angela Martinez                    212156
David Anderson                     743001
Lisa Walker                        256481
Joseph Thompson                    212156

7 rows selected. 

SQL> 
SQL> REM	8. Display the flight number, aircraft type, source and destination airport of the aircraft having
SQL> REM	maximum number of flights to Honolulu.
SQL> 
SQL> SELECT	f.flightNo		  AS	"FLIGHT NO.",
  2  		    a.type			    AS	"AIRCRAFT TYPE",
  3  		    r.orig_airport	AS	"SRC.  AIRPORT",
  4  		    r.dest_airport	AS	"DEST. AIRPORT"
  5  FROM	  flights f, aircraft a, routes r
  6  WHERE	f.rID = r.routeID AND f.aid = a.aid
  7  AND		f.flightNo =	ANY(SELECT f.flightNo 
  8  						          FROM routes r, flights f 
  9  						          WHERE r.dest_airport = 'Honolulu' AND r.routeID = f.rID
 10  						          GROUP BY f.flightNo HAVING COUNT(*) >= ALL(SELECT COUNT(*) FROM flights f GROUP BY f.flightNo));

FLIGHT  AIRCRAFT T SRC.  AIRPORT        DEST. AIRPORT       
------- ---------- -------------------- --------------------
HA-1    Airbus     Los Angeles          Honolulu            
HA-3    Airbus     Los Angeles          Honolulu            
UA-1428 Boeing     Los Angeles          Honolulu            

SQL> 
SQL> REM	9. Display the pilot(s) who are certified exclusively to pilot all aircraft in a type.
SQL> 
SQL> SELECT	e.ename	  AS	"PILOT NAME"
  2  FROM	employee e, certified c
  3  WHERE	e.eid	=	c.eid
  4  AND		c.eid	IN	(SELECT c.eid 
                      FROM certified c, aircraft a_outer
  5                   WHERE  c.aid = a_outer.aid 
  6                   AND c.aid = ALL (SELECT a.aid FROM aircraft a WHERE a.type = a_outer.type))
  7  GROUP BY e.ename;

PILOT NAME                    
------------------------------
Angela Martinez
Elizabeth Taylor
William Moore
Larry West
Milo Brooks
George Wright
Robert Brown
Lisa Walker
Eric Cooper
Michael Miller
Mark Young

PILOT NAME                    
------------------------------
William Ward
William Jones
Betty Adams
Joseph Thompson

15 rows selected. 

SQL> 
SQL> REM	10. Name the employee(s) who is earning the maximum salary among the airport having
SQL> REM	maximum number of departures.
SQL> 
SQL> SELECT e.ename	AS	"EMPLOYEE NAME" 
  2  FROM employee e
  3  WHERE e.salary	=	(SELECT	MAX(e.salary)
  4  					FROM	employee e, certified c
  5  					WHERE	e.eid = c.eid
  6  					AND     c.aid	IN	(SELECT f.aid FROM flights f, routes r
  7  										        WHERE 	f.rID = r.routeID
  8  										        AND		r.orig_airport =	(SELECT orig_airport 
  9  																	                  FROM	(SELECT r.orig_airport, COUNT(fl.departs)
 10  																			                    FROM routes r, flights f, fl_schedule fl
 11  																			                    WHERE r.routeID = f.rID AND fl.flno = f.flightNo
 12  																			                    GROUP BY r.orig_airport
 13  																			                    ORDER BY COUNT(fl.departs) DESC) 
 14  																	                  WHERE rownum = 1)));

EMPLOYEE NAME                 
------------------------------
George Wright

SQL> 
SQL> REM	11. Display the departure chart as follows:
SQL> REM	flight number, departure(date,airport,time), destination airport, arrival time, aircraft name
SQL> REM	for the flights from New York airport during 15 to 19th April 2005. Make sure that the route
SQL> REM	contains at least two flights in the above specified condition.
SQL> 
SQL> SELECT	f.flightNo 												                      AS	"FLIGHT NUMBER",
  2  		    fl.departs || ' ' || r.orig_airport || ' ' || fl.dtime	AS	"DEPARTURE",
  3  		    r.dest_airport											                    AS	"DEST. AIRPORT",
  4  		    fl.atime												                        AS	"ARRIVAL TIME",
  5  		    a.aname												                        	AS	"AIRCRAFT NAME"
  6  FROM	flights f, fl_schedule fl, routes r, aircraft a
  7  WHERE	f.flightNo = fl.flno AND r.routeID = f.rID AND f.aid = a.aid
  8  AND	r.orig_airport = 'New York' AND	fl.departs BETWEEN TO_DATE('15/04/2005', 'DD/MM/YYYY') AND TO_DATE('19/04/2005', 'DD/MM/YYYY');

FLIGHT  DEPARTURE                                                              DEST. AIRPORT        ARRIVAL TIME AIRCRAFT NAME                 
------- ---------------------------------------------------------------------- -------------------- ------------ ------------------------------
BA-178  15-04-05 New York 1140                                                 London                       1020 Boeing 757-300                
IB-4618 18-04-05 New York 1310                                                 London                       1150 Lockheed L1011 Tristar        
AF-11   17-04-05 New York 1340                                                 Paris                        1530 Boeing 757-300                

SQL> 
SQL> 
SQL> REM	Use SET operators (any one operator) for each of the following:
SQL> 
SQL> REM	12. A customer wants to travel from Madison to New York with no more than two changes of
SQL> REM	flight. List the flight numbers from Madison if the customer wants to arrive in New York by
SQL> REM	6.50 p.m.
SQL> 
SQL> SELECT	f.flightNo	AS	"FLIGHT NUMBER"
  2  FROM	flights f
  3  WHERE	f.flightNo	IN( 
                (SELECT	f0.flightNo
  4  						FROM		flights f0, routes r, fl_schedule fl
  5  						WHERE		r.routeID = f0.rID 					    AND f0.flightNo = fl.flno
  6  						AND			r.orig_airport = 'Madison' 			AND	r.dest_airport = 'New York'	AND fl.atime <= 1850)
  7  						UNION
  8  						(SELECT	f0.flightNo
  9  						FROM		flights f0, flights f1, routes r0, routes r1, fl_schedule fl0, fl_schedule fl1 
 10  						WHERE		r0.routeID = f0.rID					      AND	f0.flightNo = fl0.flno
 11  						AND 		r1.routeID = f1.rID					      AND f1.flightNo = fl1.flno
 12  						AND			r0.orig_airport = 'Madison'			  AND r0.dest_airport <> 'New York'
 13  						AND			r1.orig_airport = r0.dest_airport	AND	r1.dest_airport = 'New York' 
 14  						AND 		fl1.atime <= 1850					        AND	fl1.dtime > fl0.atime)
 15  						UNION
 16  						(SELECT	f0.flightNo
 17  						FROM		flights f0, flights f1, flights f2, routes r0, routes r1, routes r2, fl_schedule fl0, fl_schedule fl1, fl_schedule fl2
 18  						WHERE		r0.routeID = f0.rID					      AND f0.flightNo = fl0.flno
 19  						AND			r1.routeID = f1.rID					      AND	f1.flightNo = fl1.flno
 20             AND			r2.routeID = f2.rID					      AND f2.flightNo = fl2.flno
 21  						AND			r0.orig_airport = 'Madison'			  AND	r0.dest_airport <> 'New York'
 22  						AND			r1.orig_airport = r0.dest_airport	AND	r1.dest_airport <> 'New York'
 23  						AND			r2.orig_airport = r1.dest_airport	AND r2.dest_airport = 'New York'
 24             AND			fl2.atime <= 1850					        AND	fl1.dtime > fl0.atime		AND fl2.dtime > fl1.atime)
 25  					);

FLIGHT 
-------
9E-3851
FX-2351
G7-6205

SQL> 
SQL> REM	13. Display the id and name of employee(s) who are not pilots.
SQL> 
SQL> SELECT eid		AS	"EMPLOYEE ID", 
  2  		    ename	AS	"EMPLOYEE NAME"	
  3 FROM	((SELECT * 
            FROM employee) MINUS
  4  			 (SELECT e.* 
            FROM employee e, certified c WHERE e.eid = c.eid));

EMPLOYEE ID EMPLOYEE NAME                 
----------- ------------------------------
   15645489 Donald King                   
  248965255 Barbara Wilson                
  254099823 Patricia Jones                
  310454877 Chad Stewart                  
  348121549 Haywood Kelly                 
  486512566 David Anderson                
  489221823 Richard Jackson               
  489456522 Linda Davis                   
  552455348 Dorthy Lewis                  
  619023588 Jennifer Thomas               

10 rows selected. 

SQL> 
SQL> 
SQL> REM	14. Display the id and name of employee(s) who pilots the aircraft from Los Angels and Detroit
SQL> REM	airport.
SQL> 
SQL> 
SQL> SELECT	e.eid	  AS	"EMPLOYEE ID",
  2  		    e.ename	AS	"EMPLOYEE NAME"
  3  FROM	  employee e 
  4  WHERE 	e.eid	IN	((SELECT	e.eid	
  5  					          FROM	employee e, certified c, flights f, routes r
  6  					          WHERE	e.eid = c.eid	AND	f.aid = c.aid	AND	r.routeID = f.rID
  7  					          AND	r.orig_airport	= 'Los Angeles')	UNION
  8  					          (SELECT	e.eid
  9  					          FROM	employee e, certified c, flights f, routes r
 10  					          WHERE	e.eid = c.eid	AND	f.aid = c.aid	AND	r.routeID = f.rID
 11  					          AND	r.orig_airport	= 'Detroit'));

EMPLOYEE ID EMPLOYEE NAME                 
----------- ------------------------------
   11564812 John Williams                 
  141582651 Mary Johnson                  
  142519864 Betty Adams                   
  159542516 William Moore                 
  242518965 James Smith                   
  269734834 George Wright                 
  274878974 Michael Miller                
  390487451 Lawrence Sperry               
  550156548 Karen Scott                   
  552455318 Larry West                    
  556784565 Mark Young                    

EMPLOYEE ID EMPLOYEE NAME                 
----------- ------------------------------
  567354612 Lisa Walker                   
  573284895 Eric Cooper                   

13 rows selected. 

SQL> 
SQL> 
SQL> 
SQL> REM ********************************************************************
SQL> REM 					END OF SCRIPT FILE
SQL> REM ********************************************************************
