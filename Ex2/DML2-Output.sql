SQL> SET ECHO ON;
SQL> 
SQL> 
SQL> REM ********************************************************************
SQL> REM 		UCS 1412 - DATABASE LAB | IV SEMESTER
SQL> REM 		EX : 2     DML BASICS
SQL> REM 								- S. Vishakan 18 5001 196 CSE - C
SQL> REM ********************************************************************
SQL> 
SQL> REM 11. Display first name, job id and salary of all the employees.
SQL> 
SQL> SELECT  first_name  AS  "FIRST NAME",
  2          job_id      AS  "JOB ID",
  3          salary      AS  "SALARY"
  4  FROM    employees;

FIRST NAME           JOB ID         SALARY
-------------------- ---------- ----------
Steven               AD_PRES         24000
Neena                AD_VP           17000
Lex                  AD_VP           17000
Alexander            IT_PROG          9000
Bruce                IT_PROG          6000
David                IT_PROG          4800
Valli                IT_PROG          4800
Diana                IT_PROG          4200
Kevin                ST_MAN           5800
Trenna               ST_CLERK         3500
Curtis               ST_CLERK         3100

FIRST NAME           JOB ID         SALARY
-------------------- ---------- ----------
Randall              ST_CLERK         2600
Peter                ST_CLERK         2500
Eleni                SA_MAN          10500
Ellen                SA_REP          11000
Jonathon             SA_REP           8600
Kimberely            SA_REP           7000
Jennifer             AD_ASST          4400
Michael              MK_MAN          13000
Pat                  MK_REP           6000
Shelley              AC_MGR          12000
William              AC_ACCOUNT       8300

22 rows selected. 

SQL> 
SQL> REM 12. Display the id, name(first & last), salary and annual salary of all the employees. Sort the 
SQL> REM     employees by first name. Label the columns as shown below:
SQL> REM     (EMPLOYEE_ID, FULL NAME, MONTHLY SAL, ANNUAL SALARY)
SQL> 
SQL> SELECT  employee_id                     AS  "EMPLOYEE ID",
  2          CONCAT(first_name,last_name)    AS  "FULL NAME",
  3          salary                          AS  "MONTHLY SALARY",
  4          salary*12                       AS  "ANNUAL SALARY"
  5  FROM    employees;

EMPLOYEE ID FULL NAME                                     MONTHLY SALARY ANNUAL SALARY
----------- --------------------------------------------- -------------- -------------
        100 StevenKing                                             24000        288000
        101 NeenaKochhar                                           17000        204000
        102 LexDe Haan                                             17000        204000
        103 AlexanderHunold                                         9000        108000
        104 BruceErnst                                              6000         72000
        105 DavidAustin                                             4800         57600
        106 ValliPataballa                                          4800         57600
        107 DianaLorentz                                            4200         50400
        124 KevinMourgos                                            5800         69600
        141 TrennaRajs                                              3500         42000
        142 CurtisDavies                                            3100         37200

EMPLOYEE ID FULL NAME                                     MONTHLY SALARY ANNUAL SALARY
----------- --------------------------------------------- -------------- -------------
        143 RandallMatos                                            2600         31200
        144 PeterVargas                                             2500         30000
        149 EleniZlotkey                                           10500        126000
        174 EllenAbel                                              11000        132000
        176 JonathonTaylor                                          8600        103200
        178 KimberelyGrant                                          7000         84000
        200 JenniferWhalen                                          4400         52800
        201 MichaelHartstein                                       13000        156000
        202 PatFay                                                  6000         72000
        205 ShelleyHiggins                                         12000        144000
        206 WilliamGietz                                            8300         99600

22 rows selected. 

SQL> 
SQL> REM 13. List the different jobs in which the employees are working for.
SQL> 
SQL> SELECT  DISTINCT job_id  AS   "JOBS"
  2  FROM    employees;

JOBS      
----------
AD_VP
AC_MGR
ST_CLERK
AD_ASST
IT_PROG
SA_MAN
AC_ACCOUNT
ST_MAN
AD_PRES
MK_MAN
SA_REP

JOBS      
----------
MK_REP

12 rows selected. 

SQL> 
SQL> REM 14. Display the id, first name, job id, salary and commission of employees who are earning 
SQL> REM     commissions.
SQL> 
SQL> SELECT  employee_id     AS  "EMPLOYEE ID",
  2          first_name      AS  "FIRST NAME",
  3          salary          AS  "SALARY",
  4          commission_pct  AS  "COMMISSION"
  5  FROM    employees
  6  WHERE   commission_pct  IS NOT NULL;

EMPLOYEE ID FIRST NAME               SALARY COMMISSION
----------- -------------------- ---------- ----------
        149 Eleni                     10500         .2
        174 Ellen                     11000         .3
        176 Jonathon                   8600         .2
        178 Kimberely                  7000        .15

SQL> 
SQL> REM 15. Display the details (id, first name, job id, salary and dept id) of employees who are 
SQL> REM     MANAGERS.
SQL> 
SQL> SELECT  employee_id     AS  "EMPLOYEE ID",
  2          first_name      AS  "FIRST NAME",
  3          job_id          AS  "JOB ID",
  4          salary          AS  "SALARY",
  5          department_id   AS  "DEPARTMENT ID"
  6  FROM    employees
  7  WHERE   job_id          LIKE '%MAN';

EMPLOYEE ID FIRST NAME           JOB ID         SALARY DEPARTMENT ID
----------- -------------------- ---------- ---------- -------------
        124 Kevin                ST_MAN           5800            50
        149 Eleni                SA_MAN          10500            80
        201 Michael              MK_MAN          13000            20

SQL> 
SQL> REM 16. Display the details of employees other than sales representatives (id, first name, hire date, 
SQL> REM     job id, salary and dept id) who are hired after �01�May�1999� or whose salary is at least 
SQL> REM     10000
SQL> 
SQL> SELECT  employee_id     AS  "EMPLOYEE ID",
  2          first_name      AS  "FIRST NAME",
  3          hire_date       AS  "HIRE DATE",
  4          job_id          AS  "JOB ID",
  5          salary          AS  "SALARY",
  6          department_id   AS  "DEPARTMENT ID"
  7  FROM    employees
  8  WHERE   job_id  NOT IN  ('SA_REP')
  9  AND     (salary >=10000 OR hire_date > to_date('01-MAY-1999', 'DD-MON-YYYY'));

EMPLOYEE ID FIRST NAME           HIRE DAT JOB ID         SALARY DEPARTMENT ID
----------- -------------------- -------- ---------- ---------- -------------
        100 Steven               17-06-87 AD_PRES         24000            90
        101 Neena                21-09-89 AD_VP           17000            90
        102 Lex                  13-01-93 AD_VP           17000            90
        124 Kevin                16-11-99 ST_MAN           5800            50
        149 Eleni                29-01-00 SA_MAN          10500            80
        201 Michael              17-02-96 MK_MAN          13000            20
        205 Shelley              07-06-94 AC_MGR          12000           110

7 rows selected. 

SQL> 
SQL> REM 17. Display the employee details (first name, salary, hire date and dept id) whose salary falls in 
SQL> REM     the range of 5000 to 15000 and his/her name begins with any of characters (A,J,K,S). Sort 
SQL> REM     the output by first name.
SQL> 
SQL> SELECT      first_name      AS  "FIRST NAME",
  2              salary          AS  "SALARY",
  3              hire_date       AS  "HIRE DATE",
  4              department_id   AS  "DEPARTMENT ID"
  5  FROM        employees
  6  WHERE       SUBSTR(first_name, 1, 1)    IN  ('A', 'J', 'K', 'S')
  7  AND         salary                      BETWEEN 5000 AND 15000
  8  ORDER BY    first_name;

FIRST NAME               SALARY HIRE DAT DEPARTMENT ID
-------------------- ---------- -------- -------------
Alexander                  9000 03-01-90            60
Jonathon                   8600 24-03-98            80
Kevin                      5800 16-11-99            50
Kimberely                  7000 24-05-99              
Shelley                   12000 07-06-94           110

SQL> 
SQL> REM 18. Display the experience of employees in no. of years and months who were hired after 1998. 
SQL> REM     Label the columns as: (EMPLOYEE_ID, FIRST_NAME, HIRE_DATE, EXP�YRS, EXP�MONTHS)
SQL> 
SQL> SELECT  employee_id                                                 AS  "EMPLOYEE ID",
  2          first_name                                                  AS  "FIRST NAME",
  3          hire_date                                                   AS  "HIRE DATE",
  4          TRUNC((sysdate - hire_date)/(365))                          AS  "EXPYRS",
  5          TRUNC(MOD(sysdate - hire_date, 365)/30)                     AS  "EXPMONTHS"
  6  FROM    employees
  7  WHERE   EXTRACT(YEAR FROM hire_date) > 1998;

EMPLOYEE ID FIRST NAME           HIRE DAT     EXPYRS  EXPMONTHS
----------- -------------------- -------- ---------- ----------
        107 Diana                07-02-99         20         11
        124 Kevin                16-11-99         20          2
        149 Eleni                29-01-00         19         11
        178 Kimberely            24-05-99         20          8

SQL> 
SQL> REM 19. Display the total number of departments.
SQL> 
SQL> SELECT  COUNT(DISTINCT(department_id))  AS  "NO. OF DEPARTMENTS"
  2  FROM    employees;

NO. OF DEPARTMENTS
------------------
                 7

SQL> 
SQL> REM 20. Show the number of employees hired by year�wise. Sort the result by year�wise.
SQL> 
SQL> SELECT  COUNT(*)                        AS  "NO. OF EMPLOYEES",
  2          EXTRACT(YEAR FROM hire_date)    AS  "YEAR"
  3  FROM        employees
  4  GROUP BY    EXTRACT(YEAR FROM hire_date)
  5  ORDER BY    EXTRACT(YEAR FROM hire_date);

NO. OF EMPLOYEES       YEAR
---------------- ----------
               2       1987
               1       1989
               1       1990
               1       1991
               1       1993
               2       1994
               1       1995
               2       1996
               3       1997
               4       1998
               3       1999

NO. OF EMPLOYEES       YEAR
---------------- ----------
               1       2000

12 rows selected. 

SQL> 
SQL> REM 21. Display the minimum, maximum and average salary, number of employees for each 
SQL> REM     department. Exclude the employee(s) who are not in any department. Include the 
SQL> REM     department(s) with at least 2 employees and the average salary is more than 10000. Sort the 
SQL> REM     result by minimum salary in descending order.
SQL> 
SQL> SELECT  MIN(salary)             AS  "MIN. SALARY",
  2          MAX(salary)             AS  "MAX. SALARY",
  3          TRUNC(AVG(salary),2)    AS  "AVG. SALARY",
  4          COUNT(*)                AS  "NO. OF EMPLOYEES"
  5  FROM        employees
  6  GROUP BY    department_id
  7  HAVING      COUNT(*) >=2
  8  AND         AVG(salary) > 10000
  9  ORDER BY    MIN(salary) DESC;

MIN. SALARY MAX. SALARY AVG. SALARY NO. OF EMPLOYEES
----------- ----------- ----------- ----------------
      17000       24000    19333.33                3
       8600       11000    10033.33                3
       8300       12000       10150                2

SQL> 
SQL> REM ********************************************************************
SQL> REM 					END OF SCRIPT FILE
SQL> REM ********************************************************************
