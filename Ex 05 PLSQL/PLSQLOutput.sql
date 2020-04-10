SQL> @"C:\Users\svish\Desktop\plsql.sql"
SQL> REM ********************************************************************
SQL> REM	     UCS 1412 - DATABASE LAB | IV SEMESTER
SQL> REM	     EX : 5	PL/SQL - CONTROL STRUCTURES
SQL> REM				                          - S. Vishakan 18 5001 196 CSE - C
SQL> REM ********************************************************************
SQL>
SQL> DECLARE
  2  	     ptype pizza.pizza_type % TYPE;
  3  	     p_id pizza.pizza_id % TYPE;
  4  	     pizza_type pizza.pizza_type % TYPE;
  5  	     u_price pizza.unit_price % TYPE;
  6  
  7  
  8  BEGIN
  9  	     ptype := '&ptype';
 10  
 11  	     SELECT * INTO p_id, pizza_type, u_price
 12  	 FROM pizza
 13  	 WHERE pizza_type = ptype;
 14  
 15  	 EXCEPTION
 16  	     WHEN NO_DATA_FOUND THEN
 17  	     DBMS_OUTPUT.PUT_LINE('Pizza type: '||ptype||' is not available.');
 18  
 19  	     IF SQL%FOUND THEN
 20  		     DBMS_OUTPUT.PUT_LINE('Pizza type: '||ptype||' is available.');
 21  	     END IF;
 22  
 23  END;
 24  /
Enter value for ptype: pan
old   9: 	ptype := '&ptype';
new   9: 	ptype := 'pan';

PL/SQL procedure successfully completed.

SQL> 
SQL> REM 2. For the given customer name and a range of order date, find whether a customer had
SQL> REM placed any order, if so display the number of orders placed by the customer along
SQL> REM with the order number(s).
SQL> 
SQL> DECLARE
  2  	     no_of_orders NUMBER(3);
  3  	 order_id CHAR(5);
  4  	 c_name customer.cust_name % TYPE;
  5  	 start_date DATE;
  6  	 end_date DATE;
  7  
  8  	 CURSOR order_select IS
  9  		     SELECT order_no
 10  		     FROM orders, customer
 11  		     WHERE order_date BETWEEN start_date AND end_date
 12  	     AND customer.cust_id = orders.cust_id
 13  	     AND cust_name = c_name;
 14  
 15  BEGIN
 16  	     c_name := '&c_name';
 17  	     start_date := '&start_date';
 18  	     end_date := '&end_date';
 19  
 20  	     OPEN order_select;
 21  
 22  	 FETCH order_select INTO order_id;
 23  
 24  	     IF order_select%FOUND = False THEN
 25  		     DBMS_OUTPUT.PUT_LINE('Customer '||c_name||' has not done any orders in this time period.');
 26  	     ELSE
 27  	     DBMS_OUTPUT.PUT_LINE('Orders:');
 28  	     WHILE order_select%FOUND LOOP
 29  		 DBMS_OUTPUT.PUT_LINE(order_id);
 30  		 FETCH order_select INTO order_id;
 31  	     END LOOP;
 32  	     DBMS_OUTPUT.PUT_LINE('Customer '||c_name||' has done '||order_select%ROWCOUNT||' orders in this time period.');
 33  
 34  	     END IF;
 35  
 36  	     CLOSE order_select;
 37  END;
 38  /
Enter value for c_name: Hari
old  16: 	c_name := '&c_name';
new  16: 	c_name := 'Hari';
Enter value for start_date: 27-JUN-15
old  17: 	start_date := '&start_date';
new  17: 	start_date := '27-JUN-15';
Enter value for end_date: 02-JUL-15
old  18: 	end_date := '&end_date';
new  18: 	end_date := '02-JUL-15';
Orders:                                                                         
OP100                                                                           
OP500                                                                           
Customer Hari has done 2 orders in this time period.                            

PL/SQL procedure successfully completed.

SQL> 
SQL> REM 3. Display the customer name along with the details of pizza type and its quantity
SQL> REM ordered for the given order number. Also find the total quantity ordered for the given
SQL> REM order number as shown below:
SQL> 
SQL> DECLARE
  2  	     no_of_orders NUMBER(3);
  3  	 order_id CHAR(5);
  4  	 c_name customer.cust_name % TYPE;
  5  	 p_type pizza.pizza_type % TYPE;
  6  	 qty order_list.qty % TYPE;
  7  
  8  	 CURSOR order_details IS
  9  		     SELECT pizza_type, qty
 10  		     FROM pizza, order_list
 11  		     WHERE order_no = order_id
 12  	     AND pizza.pizza_id = order_list.pizza_id;
 13  
 14  	 CURSOR person_details IS
 15  	     SELECT cust_name
 16  	     FROM customer, orders
 17  	     WHERE orders.cust_id = customer.cust_id
 18  	     AND orders.order_no = order_id;
 19  
 20  BEGIN
 21  	     order_id := '&order_id';
 22  
 23  	 OPEN person_details;
 24  	 OPEN order_details;
 25  
 26  	 FETCH person_details INTO c_name;
 27  	 FETCH order_details INTO p_type, qty;
 28  
 29  	     IF person_details%FOUND = False THEN
 30  		     DBMS_OUTPUT.PUT_LINE('Specified order does not exist.');
 31  	     ELSE
 32  	     DBMS_OUTPUT.PUT_LINE('Customer Name: '||c_name||'.');
 33  	     DBMS_OUTPUT.PUT_LINE('Has ordered the following Pizza: ');
 34  	     DBMS_OUTPUT.PUT_LINE(RPAD('PIZZA TYPE', 13)||RPAD('QTY.', 4));
 35  	     WHILE order_details%FOUND LOOP
 36  		 DBMS_OUTPUT.PUT_LINE(RPAD(p_type, 13)||RPAD(qty, 4));
 37  		 FETCH order_details INTO p_type, qty;
 38  	     END LOOP;
 39  
 40  	     END IF;
 41  
 42  	     CLOSE person_details;
 43  	     CLOSE order_details;
 44  END;
 45  /
Enter value for order_id: OP100
old  21: 	order_id := '&order_id';
new  21: 	order_id := 'OP100';
Customer Name: Hari.                                                            
Has ordered the following Pizza:                                                
PIZZA TYPE   QTY.                                                               
pan          3                                                                  
grilled      2                                                                  
italian      1                                                                  
spanish      5                                                                  

PL/SQL procedure successfully completed.

SQL> 
SQL> REM 4. Display the total number of orders that contains one pizza type, two pizza type and
SQL> REM so on.
SQL> 
SQL> DECLARE
  2  	     ptype_count NUMBER(3);
  3  	 counter NUMBER(3);
  4  	 max_count NUMBER(4);
  5  	 order_no orders.order_no % TYPE;
  6  
  7  	 CURSOR total_types IS
  8  		     SELECT COUNT(DISTINCT pizza_type)
  9  		     FROM pizza;
 10  
 11  	 CURSOR type_counter IS
 12  	     SELECT order_no
 13  	     FROM order_list
 14  	     GROUP BY order_no
 15  	     HAVING COUNT(order_no) = counter;
 16  
 17  BEGIN
 18  	     counter := 0;
 19  	 OPEN total_types;
 20  
 21  	 FETCH total_types INTO max_count;
 22  
 23  	     IF max_count = 0 THEN
 24  		     DBMS_OUTPUT.PUT_LINE('Table: Pizza is Empty.');
 25  	     ELSE
 26  	     DBMS_OUTPUT.PUT_LINE('Number of Orders that contain: ');
 27  	     FOR COUNT IN 1..max_count LOOP
 28  		 ptype_count := 0;
 29  		 counter := counter + 1;
 30  		 OPEN type_counter;
 31  		 FETCH type_counter INTO order_no;
 32  		 WHILE type_counter%FOUND LOOP
 33  		     ptype_count := ptype_count + 1;
 34  		     FETCH type_counter INTO order_no;
 35  		 END LOOP;
 36  		 CLOSE type_counter;
 37  
 38  		 DBMS_OUTPUT.PUT_LINE(counter||' Pizza Type(s): '||ptype_count);
 39  	     END LOOP;
 40  	     END IF;
 41  
 42  	 CLOSE total_types;
 43  END;
 44  /
Number of Orders that contain:                                                  
1 Pizza Type(s): 2                                                              
2 Pizza Type(s): 1                                                              
3 Pizza Type(s): 2                                                              
4 Pizza Type(s): 1                                                              

PL/SQL procedure successfully completed.

SQL> 
SQL> REM ********************************************************************
SQL> REM				     END OF SCRIPT FILE
SQL> REM ********************************************************************
SQL> 
SQL> 
SQL> SELECT order_no
  2  FROM orders, customer
  3  WHERE order_date BETWEEN '27-JUN-15' AND '02-JUL-15'
  4  AND customer.cust_id = orders.cust_id
  5  AND cust_name = 'Hari';

ORDER                                                                           
-----                                                                           
OP100                                                                           
OP500                                                                           

SQL> 
SQL> 
SQL> SELECT pizza_type, qty
  2  		     FROM pizza, order_list
  3  		     WHERE order_no = 'OP100'
  4  	     AND pizza.pizza_id = order_list.pizza_id;

PIZZA_TYPE             QTY                                                      
--------------- ----------                                                      
pan                      3                                                      
grilled                  2                                                      
italian                  1                                                      
spanish                  5                                                      

SQL> 
SQL> SELECT cust_name
  2  	     FROM customer, orders
  3  	     WHERE orders.cust_id = customer.cust_id
  4  	     AND orders.order_no = 'OP100';

CUST_NAME                                                                       
---------------                                                                 
Hari                                                                            

SQL> 
SQL> 
SQL> SELECT COUNT(DISTINCT pizza_type)
  2  		     FROM pizza;

COUNT(DISTINCTPIZZA_TYPE)                                                       
-------------------------                                                       
                        4                                                       

SQL> 
SQL> SELECT order_no
  2  	     FROM order_list
  3  	     GROUP BY order_no
  4  	     HAVING COUNT(order_no) = 1;

ORDER                                                                           
-----                                                                           
OP300                                                                           
OP600                                                                           

SQL> SPOOL OFF

