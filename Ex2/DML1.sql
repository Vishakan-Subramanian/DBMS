REM ********************************************************************
REM 		UCS 1412 - DATABASE LAB | IV SEMESTER
REM 		EX : 2     DML BASICS
REM 								- S. Vishakan 18 5001 196 CSE - C
REM ********************************************************************

DROP TABLE  Classes;

CREATE TABLE Classes(
    class           VARCHAR2(20)
    CONSTRAINT      class_pk        PRIMARY KEY,
    type            CHAR(2)
    CONSTRAINT      type_chk        CHECK(type IN ('bb', 'bc')),
    country         VARCHAR2(15),
    numGuns         NUMBER(2),
    bore            NUMBER(3),
    displacement    NUMBER(6)
    );

DESC Classes;

REM 1. Add first two tuples from the above sample data. List the columns explicitly in the INSERT 
REM clause. (No ordering of columns)
REM i)  Bismark bb Germany 8 14 32000
REM ii) Iowa bb USA 9 16 46000

INSERT INTO Classes (class,
                    type,
                    country,
                    numGuns,
                    bore,
                    displacement)
            
            VALUES  ('Bismark'
                    ,'bb'
                    ,'Germany'
                    ,8
                    ,14
                    ,32000);

INSERT INTO Classes (class,
                    type,
                    country,
                    numGuns,
                    bore,
                    displacement)
            
            VALUES  ('Iowa'
                    ,'bb'
                    ,'USA'
                    ,9
                    ,16
                    ,46000);


REM 2. Populate the relation with the remaining set of tuples. This time, do not list the columns in 
REM the INSERT clause.
REM i)      Kongo bc Japan 8 15 42000
REM ii)     North Carolina bb USA 9 16 37000
REM iii)    Revenge bb Gt. Britain 8 15 29000
REM iv)     Renown bc Gt. Britain 6 15 32000

INSERT INTO Classes VALUES  ('Kongo'
                            ,'bc'
                            ,'Japan'
                            ,8
                            ,15
                            ,42000);

INSERT INTO Classes VALUES  ('North Carolina'
                            ,'bb'
                            ,'USA'
                            ,9
                            ,16
                            ,37000);

INSERT INTO Classes VALUES  ('Revenge'
                            ,'bb'
                            ,'Gt. Britain'
                            ,8
                            ,15
                            ,29000);

INSERT INTO Classes VALUES  ('Renown'
                            ,'bc'
                            ,'Gt. Britain'
                            ,6
                            ,15
                            ,32000);


REM 3. Display the populated relation.

SELECT * FROM Classes;


REM 4. Mark an intermediate point here in this transaction

SAVEPOINT INSERTIONS;


REM 5. Change the displacement of Bismark to 34000

UPDATE  Classes
SET     displacement    =   34000
WHERE   class           =   'Bismark';


REM 6. For the battleships having at least 9 number of guns or the ships with at least 15 inch bore, 
REM increase the displacement by 10%. Verify your changes to the table

UPDATE  Classes
SET     displacement    =   (1.1)   *   displacement
WHERE   numGuns         >=  9
OR      bore            >=  15;

SELECT * FROM Classes;


REM 7. Delete Kongo class of ship from Classes table

DELETE FROM Classes
WHERE       class   =   'Kongo';


REM 8. Display your changes to the table.

SELECT * FROM Classes;


REM 9. Discard the recent updates to the relation without discarding the earlier INSERT operation(s).

ROLLBACK TO INSERTIONS;


REM 10. Commit the changes.

COMMIT;



REM ********************************************************************
REM 					END OF SCRIPT FILE
REM ********************************************************************