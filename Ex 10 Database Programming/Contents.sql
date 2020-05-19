REM ********************************************************************
REM 		UCS 1412 - DATABASE LAB | IV SEMESTER
REM 		EX : 10    DATABASE APPLICATION PROGRAMMING USING JDBC
REM                                    - S. Vishakan 18 5001 196 CSE - C
REM ********************************************************************

REM CREATE TABLE STATEMENT
REM Emp_Payroll ( eid, ename, dob, sex, designation, basic, da, hra, pf, mc, gross, tot_deduc, 
REM net_pay )

CREATE TABLE Emp_Payroll(eid NUMBER(6)
                        CONSTRAINT ep_eid_pk PRIMARY KEY,
                        ename VARCHAR2(25)
                        CONSTRAINT ep_ename_nn NOT NULL,
                        dob DATE,
                        sex CHAR(1)
                        CONSTRAINT sex_chk CHECK(sex IN('M', 'F')),
                        designation VARCHAR2(15),
                        basic NUMBER(6),
                        da NUMBER(7,2),
                        hra NUMBER(7,2),
                        pf NUMBER(7,2),
                        mc NUMBER(7,2),
                        gross NUMBER(8,2),
                        tot_deduc NUMBER(8,2),
                        net_pay NUMBER(8,2)
                        );

INSERT INTO emp_payroll(eid, ename, dob, sex, designation, basic) values (1, 'Sample', '27-07-2000', 'M', 'Admin', 50000);
INSERT INTO emp_payroll(eid, ename, dob, sex, designation, basic) values (2, 'Sample2', '26-06-2000', 'F', 'Manager', 40000);

SELECT * FROM emp_payroll;

CREATE OR REPLACE PROCEDURE pay_calc (e_id IN emp_payroll.eid % TYPE, basic_pay IN emp_payroll.basic % TYPE) IS

BEGIN

    UPDATE emp_payroll
    SET basic = basic_pay,
        da = 0.6 * basic_pay,
        hra = 0.11 * basic_pay,
        pf = 0.04 * basic_pay,
        mc = 0.03 * basic_pay,
        gross = 1.71 * basic_pay,
        tot_deduc = 0.07 * basic_pay,
        net_pay = 1.64 * basic_pay
    WHERE eid = e_id;

    COMMIT;
END;
/

CALL pay_calc(1, 50000);
CALL pay_calc(2, 40000);

SELECT * FROM emp_payroll;

REM ********************************************************************
REM 					END OF SCRIPT FILE
REM ********************************************************************