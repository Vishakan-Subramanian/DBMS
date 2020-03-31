REM VERIFYING THE OUTPUT COLUMNS

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
						FROM		flights f0, routes r, fl_schedule fl
						WHERE		r.routeID = f0.rID 					AND f0.flightNo = fl.flno
						AND			f0.flightno = 'FX-2351';

						
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
						FROM		flights f0, flights f1, routes r0, routes r1, fl_schedule fl0, fl_schedule fl1 
						WHERE		r0.routeID = f0.rID					AND	f0.flightNo = fl0.flno
						AND 		r1.routeID = f1.rID					AND f1.flightNo = fl1.flno
						AND			f0.flightno = 'FX-2351' AND r1.dest_airport = 'New York' AND r0.orig_airport = 'Madison'
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


						SELECT		*
						FROM		flights f0, flights f1, routes r0, routes r1, fl_schedule fl0, fl_schedule fl1 
						WHERE		r0.routeID = f0.rID					AND	f0.flightNo = fl0.flno
						AND 		r1.routeID = f1.rID					AND f1.flightNo = fl1.flno
						AND			f0.flightno = 'GV-3664' AND r1.dest_airport = 'New York' AND r0.orig_airport = 'Madison'
                        AND         r0.dest_airport = r1.orig_airport;
                        
                        SELECT		*
						FROM		flights f0, flights f1, flights f2, routes r0, routes r1, routes r2, fl_schedule fl0, fl_schedule fl1, fl_schedule fl2
						WHERE		r0.routeID = f0.rID					AND f0.flightNo = fl0.flno
						AND			r1.routeID = f1.rID					AND	f1.flightNo = fl1.flno
                        AND			r2.routeID = f2.rID					AND f2.flightNo = fl2.flno
						AND			r0.orig_airport = 'Madison'			AND	r0.dest_airport <> 'New York'
						AND			r1.orig_airport = r0.dest_airport	AND	r1.dest_airport <> 'New York'
						AND			r2.orig_airport = r1.dest_airport	AND r2.dest_airport = 'New York'
                        AND			f0.flightno = 'GV-3664';
                        
                        SELECT		*
						FROM		flights f0, routes r, fl_schedule fl
						WHERE		r.routeID = f0.rID 					AND f0.flightNo = fl.flno
						AND			f0.flightno = 'GV-3664';

						 SELECT		*
						FROM		flights f0, routes r, fl_schedule fl
						WHERE		r.routeID = f0.rID 					AND f0.flightNo = fl.flno;
						AND			f0.flightno = 'GV-3664';

						
						SELECT	arrives, atime, flno
						FROM	fl_schedule
						GROUP BY arrives, atime, flno;

						SELECT	arrives, atime, flno
						FROM	fl_schedule
						GROUP BY flno, atime, arrives;

						SELECT	arrives, atime, dtime, flno
						FROM	fl_schedule
						GROUP BY flno;



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


                        SELECT	f.flightNo, fl.atime FROM	flights f, fl_schedule fl, routes r, aircraft a
						WHERE	f.flightNo = fl.flno AND r.routeID = f.rID AND f.aid = a.aid
						AND		r.orig_airport = 'New York' AND	fl.departs BETWEEN TO_DATE('15/04/2005', 'DD/MM/YYYY') AND TO_DATE('19/04/2005', 'DD/MM/YYYY')