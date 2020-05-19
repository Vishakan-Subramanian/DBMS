SQL> REM ********************************************************************
SQL> REM 		UCS 1412 - DATABASE LAB | IV SEMESTER
SQL> REM 		EX : 10    DATABASE APPLICATION PROGRAMMING USING JDBC
SQL> REM                                  - S. Vishakan 18 5001 196 CSE - C
SQL> REM ********************************************************************
SQL> 
SQL> REM CREATE TABLE STATEMENT
SQL> REM Emp_Payroll ( eid, ename, dob, sex, designation, basic, da, hra, pf, mc, gross, tot_deduc, 
SQL> REM net_pay )
SQL> 
SQL> CREATE TABLE Emp_Payroll(eid NUMBER(6)
  2                          CONSTRAINT ep_eid_pk PRIMARY KEY,
  3                          ename VARCHAR2(25)
  4                          CONSTRAINT ep_ename_nn NOT NULL,
  5                          dob DATE,
  6                          sex CHAR(1)
  7                          CONSTRAINT sex_chk CHECK(sex IN('M', 'F')),
  8                          designation VARCHAR2(15),
  9                          basic NUMBER(6),
 10                          da NUMBER(7,2),
 11                          hra NUMBER(7,2),
 12                          pf NUMBER(7,2),
 13                          mc NUMBER(7,2),
 14                          gross NUMBER(8,2),
 15                          tot_deduc NUMBER(8,2),
 16                          net_pay NUMBER(8,2)
 17                          );

Table EMP_PAYROLL created.

SQL> 
SQL> INSERT INTO emp_payroll(eid, ename, dob, sex, designation, basic) values (1, 'Sample', '27-07-2000', 'M', 'Admin', 50000);

1 row inserted.

SQL> INSERT INTO emp_payroll(eid, ename, dob, sex, designation, basic) values (2, 'Sample2', '26-06-2000', 'F', 'Manager', 40000);

1 row inserted.

SQL> 
SQL> SELECT * FROM emp_payroll;

       EID ENAME                     DOB      S DESIGNATION          BASIC         DA        HRA         PF         MC      GROSS  TOT_DEDUC    NET_PAY
---------- ------------------------- -------- - --------------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ----------
         1 Sample                    27-07-00 M Admin                50000                                                                             
         2 Sample2                   26-06-00 F Manager              40000                                                                             

SQL> 
SQL> CREATE OR REPLACE PROCEDURE pay_calc (e_id IN emp_payroll.eid % TYPE, basic_pay IN emp_payroll.basic % TYPE) IS
  2  
  3  BEGIN
  4  
  5      UPDATE emp_payroll
  6      SET basic = basic_pay,
  7          da = 0.6 * basic_pay,
  8          hra = 0.11 * basic_pay,
  9          pf = 0.04 * basic_pay,
 10          mc = 0.03 * basic_pay,
 11          gross = 1.71 * basic_pay,
 12          tot_deduc = 0.07 * basic_pay,
 13          net_pay = 1.64 * basic_pay
 14      WHERE eid = e_id;
 15  
 16      COMMIT;
 17  END;
 18  /

Procedure PAY_CALC compiled

SQL> 
SQL> CALL pay_calc(1, 50000);

Call completed.

SQL> CALL pay_calc(2, 40000);

Call completed.

SQL> 
SQL> SELECT * FROM emp_payroll;

       EID ENAME                     DOB      S DESIGNATION          BASIC         DA        HRA         PF         MC      GROSS  TOT_DEDUC    NET_PAY
---------- ------------------------- -------- - --------------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ----------
         1 Sample                    27-07-00 M Admin                50000      30000       5500       2000       1500      85500       3500      82000
         2 Sample2                   26-06-00 F Manager              40000      24000       4400       1600       1200      68400       2800      65600

SQL> 
SQL> REM ********************************************************************
SQL> REM 					END OF SCRIPT FILE
SQL> REM ********************************************************************
