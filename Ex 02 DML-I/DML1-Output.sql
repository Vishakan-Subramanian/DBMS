SQL> SET ECHO ON;
SQL> 
SQL> REM ********************************************************************
SQL> REM 		UCS 1412 - DATABASE LAB | IV SEMESTER
SQL> REM 		EX : 2     DML BASICS
SQL> REM 								- S. Vishakan 18 5001 196 CSE - C
SQL> REM ********************************************************************
SQL> 
SQL> DROP TABLE  Classes;

Table CLASSES dropped.

SQL> 
SQL> CREATE TABLE Classes(
  2      class           VARCHAR2(20)
  3      CONSTRAINT      class_pk        PRIMARY KEY,
  4      type            CHAR(2)
  5      CONSTRAINT      type_chk        CHECK(type IN ('bb', 'bc')),
  6      country         VARCHAR2(15),
  7      numGuns         NUMBER(2),
  8      bore            NUMBER(3),
  9      displacement    NUMBER(6)
 10      );

Table CLASSES created.

SQL> 
SQL> DESC Classes;
Name         Null?    Type         
------------ -------- ------------ 
CLASS        NOT NULL VARCHAR2(20) 
TYPE                  CHAR(2)      
COUNTRY               VARCHAR2(15) 
NUMGUNS               NUMBER(2)    
BORE                  NUMBER(3)    
DISPLACEMENT          NUMBER(6)    
SQL> 
SQL> REM 1. Add first two tuples from the above sample data. List the columns explicitly in the INSERT 
SQL> REM clause. (No ordering of columns)
SQL> REM i)  Bismark bb Germany 8 14 32000
SQL> REM ii) Iowa bb USA 9 16 46000
SQL> 
SQL> INSERT INTO Classes (class,
  2                      type,
  3                      country,
  4                      numGuns,
  5                      bore,
  6                      displacement)
  7  
  8              VALUES  ('Bismark'
  9                      ,'bb'
 10                      ,'Germany'
 11                      ,8
 12                      ,14
 13                      ,32000);

1 row inserted.

SQL> 
SQL> INSERT INTO Classes (class,
  2                      type,
  3                      country,
  4                      numGuns,
  5                      bore,
  6                      displacement)
  7  
  8              VALUES  ('Iowa'
  9                      ,'bb'
 10                      ,'USA'
 11                      ,9
 12                      ,16
 13                      ,46000);

1 row inserted.

SQL> 
SQL> 
SQL> REM 2. Populate the relation with the remaining set of tuples. This time, do not list the columns in 
SQL> REM the INSERT clause.
SQL> REM i)      Kongo bc Japan 8 15 42000
SQL> REM ii)     North Carolina bb USA 9 16 37000
SQL> REM iii)    Revenge bb Gt. Britain 8 15 29000
SQL> REM iv)     Renown bc Gt. Britain 6 15 32000
SQL> 
SQL> INSERT INTO Classes VALUES  ('Kongo'
  2                              ,'bc'
  3                              ,'Japan'
  4                              ,8
  5                              ,15
  6                              ,42000);

1 row inserted.

SQL> 
SQL> INSERT INTO Classes VALUES  ('North Carolina'
  2                              ,'bb'
  3                              ,'USA'
  4                              ,9
  5                              ,16
  6                              ,37000);

1 row inserted.

SQL> 
SQL> INSERT INTO Classes VALUES  ('Revenge'
  2                              ,'bb'
  3                              ,'Gt. Britain'
  4                              ,8
  5                              ,15
  6                              ,29000);

1 row inserted.

SQL> 
SQL> INSERT INTO Classes VALUES  ('Renown'
  2                              ,'bc'
  3                              ,'Gt. Britain'
  4                              ,6
  5                              ,15
  6                              ,32000);

1 row inserted.

SQL> 
SQL> 
SQL> REM 3. Display the populated relation.
SQL> 
SQL> SELECT * FROM Classes;

CLASS                TY COUNTRY            NUMGUNS       BORE DISPLACEMENT
-------------------- -- --------------- ---------- ---------- ------------
Bismark              bb Germany                  8         14        32000
Iowa                 bb USA                      9         16        46000
Kongo                bc Japan                    8         15        42000
North Carolina       bb USA                      9         16        37000
Revenge              bb Gt. Britain              8         15        29000
Renown               bc Gt. Britain              6         15        32000

6 rows selected. 

SQL> 
SQL> 
SQL> REM 4. Mark an intermediate point here in this transaction
SQL> 
SQL> SAVEPOINT INSERTIONS;

Savepoint created.

SQL> 
SQL> 
SQL> REM 5. Change the displacement of Bismark to 34000
SQL> 
SQL> UPDATE  Classes
  2  SET     displacement    =   34000
  3  WHERE   class           =   'Bismark';

1 row updated.

SQL> 
SQL> 
SQL> REM 6. For the battleships having at least 9 number of guns or the ships with at least 15 inch bore, 
SQL> REM increase the displacement by 10%. Verify your changes to the table
SQL> 
SQL> UPDATE  Classes
  2  SET     displacement    =   (1.1)   *   displacement
  3  WHERE   numGuns         >=  9
  4  OR      bore            >=  15;

5 rows updated.

SQL> 
SQL> SELECT * FROM Classes;

CLASS                TY COUNTRY            NUMGUNS       BORE DISPLACEMENT
-------------------- -- --------------- ---------- ---------- ------------
Bismark              bb Germany                  8         14        34000
Iowa                 bb USA                      9         16        50600
Kongo                bc Japan                    8         15        46200
North Carolina       bb USA                      9         16        40700
Revenge              bb Gt. Britain              8         15        31900
Renown               bc Gt. Britain              6         15        35200

6 rows selected. 

SQL> 
SQL> 
SQL> REM 7. Delete Kongo class of ship from Classes table
SQL> 
SQL> DELETE FROM Classes
  2  WHERE       class   =   'Kongo';

1 row deleted.

SQL> 
SQL> 
SQL> REM 8. Display your changes to the table.
SQL> 
SQL> SELECT * FROM Classes;

CLASS                TY COUNTRY            NUMGUNS       BORE DISPLACEMENT
-------------------- -- --------------- ---------- ---------- ------------
Bismark              bb Germany                  8         14        34000
Iowa                 bb USA                      9         16        50600
North Carolina       bb USA                      9         16        40700
Revenge              bb Gt. Britain              8         15        31900
Renown               bc Gt. Britain              6         15        35200

SQL> 
SQL> 
SQL> REM 9. Discard the recent updates to the relation without discarding the earlier INSERT operation(s).
SQL> 
SQL> ROLLBACK TO INSERTIONS;

Rollback complete.

SQL> 
SQL> 
SQL> REM 10. Commit the changes.
SQL> 
SQL> COMMIT;

Commit complete.

SQL> 
SQL> 
SQL> 
SQL> REM ********************************************************************
SQL> REM 					END OF SCRIPT FILE
SQL> REM ********************************************************************
