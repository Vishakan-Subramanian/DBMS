REM  ********************************************************************
REM 		UCS 1412 - DATABASE LAB | IV SEMESTER
REM 		EX : 9A    DATABASE DESIGN USING NORMAL FORMS
REM 								- S. Vishakan 18 5001 196 CSE - C
REM *********************************************************************

REM CREATING THE BASIC COMPANY - 1NF TABLE

CREATE TABLE Company(
                    empid   NUMBER(9),
                    name    VARCHAR2(35),
                    address VARCHAR2(50),
                    bdate   DATE,
                    sex     CHAR(1),
                    salary  NUMBER(8, 2),
                    dno     NUMBER(5),
                    dname   VARCHAR2(25),
                    mgr_id  NUMBER(9),
                    pno     NUMBER(5),
                    pname   VARCHAR2(30),
                    pdno    NUMBER(5),
                    hrs     NUMBER(5, 2),
                    CONSTRAINT company_empid_pno_pk PRIMARY KEY(empid, pno)
                    );

REM POPULATING THE COMPANY - 1NF TABLE

INSERT INTO Company VALUES (123456789, 'John B Smith', '731 Fondren, Houston, TX', '09-JAN-1965', 'M', 30000, 
                            5, 'Research', 333445555, 1, 'ProductX', 5, 32.5);

INSERT INTO Company VALUES (453453453, 'Joyce A English', '5631 Rice, Houston, TX', '31-JUL-1972', 'F', 25000,
                            5, 'Research', 333445555, 1, 'ProductX', 5, 20);

INSERT INTO Company VALUES (123456789, 'John B Smith', '731 Fondren, Houston, TX', '09-JAN-1965', 'M', 30000,
                            5, 'Research', 333445555, 2, 'ProductY', 5, 7.5);

INSERT INTO Company VALUES (333445555, 'Franklin T Wong', '638 Voss, Houston, TX', '08-DEC-1955', 'M', 40000,
                            5, 'Research', 333445555, 2, 'ProductY', 5, 10);

INSERT INTO Company VALUES (453453453, 'Joyce A English', '5631 Rice, Houston, TX', '31-JUL-1972', 'F', 25000,
                            5, 'Research', 333445555, 2, 'ProductY', 5, 20);

INSERT INTO Company VALUES (333445555, 'Franklin T Wong', '638 Voss, Houston, TX', '08-DEC-1955', 'M', 40000,
                        	5, 'Research', 333445555, 3, 'ProductZ', 5, 10);

INSERT INTO Company VALUES (666884444, 'Ramesh K Narayan', '975 Fire Oak, Humble, TX', '15-SEP-1962', 'M', 38000,
                            5, 'Research', 333445555, 3, 'ProductZ', 5, 40);

INSERT INTO Company VALUES (333445555, 'Franklin T Wong', '638 Voss, Houston, TX', '08-DEC-1955', 'M', 40000,
                            5, 'Research', 333445555, 10, 'Computerization', 4, 10);

INSERT INTO Company VALUES (987987987, 'Ahmad V Jabbar', '980 Dallas, Houston, TX', '29-MAR-1969', 'M', 25000,
                            4, 'Administration', 987654321, 10, 'Computerization', 4, 35);

INSERT INTO Company VALUES (999887777, 'Alicia J Zelaya', '3321 Castle, Spring, TX', '19-JAN-1968', 'F', 25000,	
                            4, 'Administration', 987654321, 10, 'Computerization', 4, 10);

INSERT INTO Company VALUES (333445555, 'Franklin T Wong', '638 Voss, Houston, TX', '08-DEC-1955', 'M', 40000,	
                            5, 'Research', 333445555, 20, 'Reorganization', 1, 10);

INSERT INTO Company VALUES (888665555, 'James E Borg', '450 Stone, Houston, TX', '10-NOV-1937', 'M', 55000,	
                            1, 'Headquarters', 888665555, 20, 'Reorganization', 1, NULL);

INSERT INTO Company VALUES (987654321, 'Jennifer S Wallace', '291 Berry, Bellaire, TX', '20-JUN-1941', 'F', 43000,	
                            4, 'Administration', 987654321, 20, 'Reorganization', 1, 15);

INSERT INTO Company VALUES (987654321, 'Jennifer S Wallace', '291 Berry, Bellaire, TX', '20-JUN-1941', 'F', 43000,	
                            4, 'Administration', 987654321, 30, 'New Benefits', 4, 20);

INSERT INTO Company VALUES (987987987, 'Ahmad V Jabbar', '980 Dallas, Houston, TX', '29-MAR-1969', 'M', 25000,	
                            4, 'Administration', 987654321, 30, 'New Benefits', 4, 5);

INSERT INTO Company VALUES (999887777, 'Alicia J Zelaya', '3321 Castle, Spring, TX', '19-JAN-1968', 'F', 25000,	
                            4, 'Administration', 987654321, 30, 'New Benefits', 4, 30);

REM CONTENTS OF COMPANY - 1NF TABLE

SELECT * FROM Company;

REM NORMALIZATION OF COMPANY - 1NF TABLE

CREATE TABLE Departments(
                        dno     NUMBER(5)
                        CONSTRAINT departments_dno_pk PRIMARY KEY,
                        dname   VARCHAR2(25),
                        mgr_id  NUMBER(9)
                        );

CREATE TABLE Project(
                    pno     NUMBER(5)
                    CONSTRAINT project_pno_pk PRIMARY KEY,
                    pname   VARCHAR2(30),
                    pdno    NUMBER(5) REFERENCES Departments(dno)
                    );

CREATE TABLE Employees(
                    empid   NUMBER(9)
                    CONSTRAINT employees_empid_pk PRIMARY KEY,
                    name    VARCHAR2(35),
                    address VARCHAR2(50),
                    bdate   DATE,
                    sex     CHAR(1),
                    salary  NUMBER(8, 2),
                    dno     NUMBER(5),
                    CONSTRAINT employees_dno_fk FOREIGN KEY(dno) REFERENCES Departments(dno)
                    );
                    
CREATE TABLE Progress(
                    pno     NUMBER(5),
                    empid   NUMBER(9),
                    hrs     NUMBER(5, 2),
                    CONSTRAINT progress_pno_empid_pk PRIMARY KEY(pno, empid),
                    CONSTRAINT progress_pno_fk FOREIGN KEY(pno) REFERENCES Project(pno),
                    CONSTRAINT progress_empid_fk FOREIGN KEY(empid) REFERENCES Employees(empid)
                    );

REM POPULATING THE NORMALIZED TABLES

INSERT INTO Departments VALUES (5, 'Research', 333445555);
INSERT INTO Departments VALUES (4, 'Administration', 987654321);
INSERT INTO Departments VALUES (1, 'Headquarters', 888665555);

INSERT INTO Project VALUES (1, 'ProductX', 5);
INSERT INTO Project VALUES (2, 'ProductY', 5);
INSERT INTO Project VALUES (3, 'ProductZ', 5);
INSERT INTO Project VALUES (10, 'Computerization', 4);
INSERT INTO Project VALUES (20, 'Reorganization', 1);
INSERT INTO Project VALUES (30, 'New Benefits', 4);

INSERT INTO Employees VALUES (123456789, 'John B Smith', '731 Fondren, Houston, TX', '09-JAN-1965', 'M', 30000, 5);
INSERT INTO Employees VALUES (333445555, 'Franklin T Wong', '638 Voss, Houston, TX', '08-DEC-1955', 'M', 40000, 5);
INSERT INTO Employees VALUES (999887777, 'Alicia J Zelaya', '3321 Castle, Spring, TX', '19-JAN-1968', 'F', 25000, 4);
INSERT INTO Employees VALUES (987654321, 'Jennifer S Wallace', '291 Berry, Bellaire, TX', '20-JUN-1941', 'F', 43000, 4);
INSERT INTO Employees VALUES (666884444, 'Ramesh K Narayan', '975 Fire Oak, Humble, TX', '15-SEP-1962', 'M', 38000, 5);
INSERT INTO Employees VALUES (453453453, 'Joyce A English', '5631 Rice, Houston, TX', '31-JUL-1972', 'F', 25000, 5);
INSERT INTO Employees VALUES (987987987, 'Ahmad V Jabbar', '980 Dallas, Houston, TX', '29-MAR-1969', 'M', 25000, 4);
INSERT INTO Employees VALUES (888665555, 'James E Borg', '450 Stone, Houston, TX', '10-NOV-1937', 'M', 55000, 1);

INSERT INTO Progress VALUES (1, 123456789, 32.5);
INSERT INTO Progress VALUES (2, 123456789, 7.5);
INSERT INTO Progress VALUES (3, 666884444, 40.0);
INSERT INTO Progress VALUES (1, 453453453, 20.0);
INSERT INTO Progress VALUES (2, 453453453, 20.0);
INSERT INTO Progress VALUES (2, 333445555, 10.0);
INSERT INTO Progress VALUES (3, 333445555, 10.0);
INSERT INTO Progress VALUES (10, 333445555, 10.0);
INSERT INTO Progress VALUES (20, 333445555, 10.0);
INSERT INTO Progress VALUES (30, 999887777, 30.0);
INSERT INTO Progress VALUES (10, 999887777, 10.0);
INSERT INTO Progress VALUES (10, 987987987, 35.0);
INSERT INTO Progress VALUES (30, 987987987, 5.0);
INSERT INTO Progress VALUES (30, 987654321, 20.0);
INSERT INTO Progress VALUES (20, 987654321, 15.0);
INSERT INTO Progress VALUES (20, 888665555, NULL);

REM CONTENTS OF THE NORMALIZED TABLES

SELECT * FROM Employees;
SELECT * FROM Departments;
SELECT * FROM Project;
SELECT * FROM Progress;

REM PROVING LOSSLESS JOIN PROPERTY

SELECT * FROM Employees NATURAL JOIN Departments NATURAL JOIN Project NATURAL JOIN Progress;

REM DROPPING THE TABLES

DROP TABLE Company;
DROP TABLE Progress;
DROP TABLE Employees;
DROP TABLE Project;
DROP TABLE Departments;

REM ********************************************************************
REM 					END OF SCRIPT FILE
REM ********************************************************************