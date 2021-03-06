SQL> REM ********************************************************************
SQL> REM 		UCS 1412 - DATABASE LAB | IV SEMESTER
SQL> REM 		EX : 1 DDL QUERIES FOR MUSIC STORE
SQL> REM 									- S. Vishakan 18 5001 196 CSE - C
SQL> REM ********************************************************************
SQL> 
SQL> 
SQL> DROP TABLE sungby;

Table SUNGBY dropped.

SQL> DROP TABLE song;

Table SONG dropped.

SQL> DROP TABLE album;

Table ALBUM dropped.

SQL> DROP TABLE artist;

Table ARTIST dropped.

SQL> DROP TABLE studio;

Table STUDIO dropped.

SQL> DROP TABLE musician;

Table MUSICIAN dropped.

SQL> 
SQL> 
SQL> REM ARTIST TABLE CREATION
SQL> 
SQL> CREATE TABLE artist(
  2  	artist_id 	NUMBER(5)
  3  	CONSTRAINT artist_id_pk PRIMARY KEY,
  4  	artist_name 	VARCHAR2(30) 
  5  	CONSTRAINT artist_name_uk UNIQUE
  6  	);

Table ARTIST created.

SQL> 
SQL> DESC artist;
Name        Null?    Type         
----------- -------- ------------ 
ARTIST_ID   NOT NULL NUMBER(5)    
ARTIST_NAME          VARCHAR2(30) 
SQL> 
SQL> REM STUDIO TABLE CREATION
SQL> 
SQL> CREATE TABLE studio(
  2  	studio_name 	VARCHAR2(30)
  3  	CONSTRAINT name_pk PRIMARY KEY,
  4  	address		VARCHAR2(50),
  5  	phone 		NUMBER(10)
  6  	);

Table STUDIO created.

SQL> 
SQL> DESC studio;
Name        Null?    Type         
----------- -------- ------------ 
STUDIO_NAME NOT NULL VARCHAR2(30) 
ADDRESS              VARCHAR2(50) 
PHONE                NUMBER(10)   
SQL> 
SQL> REM MUSICIAN TABLE CREATION
SQL> 
SQL> CREATE TABLE musician(
  2  	musician_id 	NUMBER(5) 
  3  	CONSTRAINT musician_id_pk PRIMARY KEY,
  4  	musician_name 	VARCHAR2(30),
  5  	birthplace 	VARCHAR2(30)
  6  	);

Table MUSICIAN created.

SQL> 
SQL> DESC musician;
Name          Null?    Type         
------------- -------- ------------ 
MUSICIAN_ID   NOT NULL NUMBER(5)    
MUSICIAN_NAME          VARCHAR2(30) 
BIRTHPLACE             VARCHAR2(30) 
SQL> 
SQL> REM ALBUM TABLE CREATION
SQL> 
SQL> CREATE TABLE album(
  2  	album_id 	NUMBER(5) 
  3  	CONSTRAINT album_id_pk PRIMARY KEY,
  4  	album_name 	VARCHAR2(30),
  5  	rel_year DATE 
  6  	CONSTRAINT year_gt_1945 CHECK (EXTRACT(YEAR FROM(rel_year)) >= 1945),
  7  	no_of_tracks 	NUMBER(2) 
  8  	CONSTRAINT no_of_tracks_nn NOT NULL,
  9  	studio 		VARCHAR(30),
 10  	album_genre 	CHAR(3) 
 11  	CONSTRAINT album_genre_chk CHECK(album_genre IN('CAR',	'DIV',	'MOV',	'POP')),
 12  	musician 	NUMBER(5) 
 13  	CONSTRAINT musician_fk REFERENCES musician(musician_id),
 14  	CONSTRAINT studio_fk FOREIGN KEY(studio) REFERENCES studio(studio_name)
 15  	);

Table ALBUM created.

SQL> 
SQL> DESC album;
Name         Null?    Type         
------------ -------- ------------ 
ALBUM_ID     NOT NULL NUMBER(5)    
ALBUM_NAME            VARCHAR2(30) 
REL_YEAR              DATE         
NO_OF_TRACKS NOT NULL NUMBER(2)    
STUDIO                VARCHAR2(30) 
ALBUM_GENRE           CHAR(3)      
MUSICIAN              NUMBER(5)    
SQL> 
SQL> REM SONG TABLE CREATION
SQL> 
SQL> CREATE TABLE song(
  2  	album_id 	NUMBER(5), 
  3  	track_no 	NUMBER(2),
  4  	song_name 	VARCHAR2(30),
  5  	song_length 	NUMBER(4,2),
  6  	song_genre 	VARCHAR2(3) 
  7  	CONSTRAINT song_genre_chk CHECK(song_genre IN ('PHI',	'REL',	'LOV',	'DEV',	'PAT')),
  8  	CONSTRAINT song_pk PRIMARY KEY (album_id, track_no),
  9  	CONSTRAINT album_fk FOREIGN KEY(album_id) REFERENCES album(album_id),
 10  	CONSTRAINT song_pat_length CHECK (song_genre NOT IN ('PAT') OR song_length>7)
 11  	);

Table SONG created.

SQL> 
SQL> DESC song;
Name        Null?    Type         
----------- -------- ------------ 
ALBUM_ID    NOT NULL NUMBER(5)    
TRACK_NO    NOT NULL NUMBER(2)    
SONG_NAME            VARCHAR2(30) 
SONG_LENGTH          NUMBER(4,2)  
SONG_GENRE           VARCHAR2(3)  
SQL> 
SQL> REM SUNGBY TABLE CREATION
SQL> 
SQL> CREATE TABLE sungby(
  2  	album_id 	NUMBER(5),
  3  	track_no 	NUMBER(5),
  4  	artist_id 	NUMBER(5),
  5  	record_date 	DATE,
  6  	CONSTRAINT artist_id_fk FOREIGN KEY (artist_id) REFERENCES artist(artist_id),
  7  	CONSTRAINT album_id_track_no_fk FOREIGN KEY (album_id, track_no) REFERENCES song(album_id, track_no),
  8  	CONSTRAINT sungby_pk PRIMARY KEY (album_id , artist_id, track_no)
  9  	);

Table SUNGBY created.

SQL> 
SQL> DESC sungby;
Name        Null?    Type      
----------- -------- --------- 
ALBUM_ID    NOT NULL NUMBER(5) 
TRACK_NO    NOT NULL NUMBER(5) 
ARTIST_ID   NOT NULL NUMBER(5) 
RECORD_DATE          DATE      
SQL> 
SQL> REM ********************************************************************
SQL> REM 					INSERTION OF VALUES
SQL> REM ********************************************************************
SQL> 
SQL> INSERT INTO artist VALUES	(1, 
  2  							'Joe'
  3  							);

1 row inserted.

SQL> 
SQL> INSERT INTO artist VALUES	(2,
  2  							'Ame'
  3  							);

1 row inserted.

SQL> 
SQL> INSERT INTO artist VALUES	(3, 	
  2  							'Vishal'
  3  							);

1 row inserted.

SQL> 
SQL> INSERT INTO artist VALUES	(4, 	
  2  							'Vikram'
  3  							);

1 row inserted.

SQL> 
SQL> INSERT INTO artist VALUES	(5, 	
  2  							'Aaron'
  3  							);

1 row inserted.

SQL> 
SQL> 
SQL> INSERT INTO musician VALUES	(1, 
  2  							'Rahman',
  3  							'Chennai'
  4  							);

1 row inserted.

SQL> 
SQL> INSERT INTO musician VALUES	(2, 
  2  							'Eminem',
  3  							'America'
  4  							);

1 row inserted.

SQL> 
SQL> 
SQL> INSERT INTO musician VALUES	(3,
  2  							'Emily',
  3  							'UK'
  4  							);

1 row inserted.

SQL> 
SQL> INSERT INTO musician VALUES	(4,
  2  							'Aaron',
  3  							'UK'
  4  							);

1 row inserted.

SQL> 
SQL> INSERT INTO musician VALUES	(5,
  2  							'Weron',
  3  							'UK'
  4  							);

1 row inserted.

SQL> 
SQL> 
SQL> INSERT INTO studio VALUES	('AVM',
  2  							'Chennai',
  3  							1234567890
  4  							);

1 row inserted.

SQL> INSERT INTO studio VALUES	('2D', 	
  2  							'Hyderabad',
  3  							1111111111
  4  							);

1 row inserted.

SQL> 
SQL> INSERT INTO studio VALUES	('3D',
  2  							'Delhi',
  3  							3333333333
  4  							);

1 row inserted.

SQL> 
SQL> INSERT INTO studio VALUES	('4D',
  2  							'Rome',
  3  							2222222222
  4  							);

1 row inserted.

SQL> 
SQL> INSERT INTO studio VALUES	('5D', 	
  2  							'Delhi', 	
  3  							4444444444
  4  							);

1 row inserted.

SQL> 
SQL> 
SQL> INSERT INTO album VALUES	(1,
  2  							'Jazzy Music', 		
  3  							'19-JUL-2000',	
  4  							5,	
  5  							'AVM',	
  6  							'POP',	
  7  							1
  8  							);

1 row inserted.

SQL> 
SQL> INSERT INTO album VALUES	(2,	
  2  							'Movie Music', 		
  3  							'22-OCT-2000',	
  4  							7,	
  5  							'2D',	
  6  							'MOV',	
  7  							2
  8  							);

1 row inserted.

SQL> 
SQL> INSERT INTO album VALUES	(3,	
  2  							'Diverse Music', 	
  3  							'11-MAY-1950',	
  4  							3,	
  5  							'3D',	
  6  							'DIV',	
  7  							3
  8  							);

1 row inserted.

SQL> 
SQL> INSERT INTO album VALUES	(4,	
  2  							'New Music', 		
  3  							'14-MAY-1975',	
  4  							6,	
  5  							'4D',	
  6  							'DIV',	
  7  							4
  8  							);

1 row inserted.

SQL> 
SQL> INSERT INTO album VALUES	(5,	
  2  							'Old Music', 		
  3  							'29-JUN-1980',	
  4  							3,	
  5  							'5D',	
  6  							'DIV',	
  7  							5
  8  							);

1 row inserted.

SQL> 
SQL> 
SQL> INSERT INTO song VALUES	(1,	
  2  						1,	
  3  						'Song11', 	
  4  						7.25, 	
  5  						'PAT'
  6  						);

1 row inserted.

SQL> 
SQL> INSERT INTO song VALUES	(2,	
  2  						1,	
  3  						'Song12', 	
  4  						8.25, 	
  5  						'PAT'
  6  						);

1 row inserted.

SQL> 
SQL> INSERT INTO song VALUES	(1,	
  2  						2,	
  3  						'Song21', 	
  4  						4.50, 	
  5  						'PHI'
  6  						);

1 row inserted.

SQL> 
SQL> INSERT INTO song VALUES	(2,	
  2  						2,	
  3  						'Song22', 	
  4  						3.50, 	
  5  						'LOV'
  6  						);

1 row inserted.

SQL> 
SQL> INSERT INTO song VALUES	(1,	
  2  						3,	
  3  						'Song31', 	
  4  						4.25, 	
  5  						'PHI'
  6  						);

1 row inserted.

SQL> 
SQL> INSERT INTO song VALUES	(3,	
  2  						3,	
  3  						'Song33', 	
  4  						4.25, 	
  5  						'PHI'
  6  						);

1 row inserted.

SQL> 
SQL> 
SQL> INSERT INTO sungby VALUES	(1,	
  2  							1,	
  3  							1,	
  4  							'19-JUL-2000'
  5  							);

1 row inserted.

SQL> 
SQL> INSERT INTO sungby VALUES	(1,	
  2  							1,	
  3  							2,	
  4  							'22-OCT-2000'
  5  							);

1 row inserted.

SQL> 
SQL> INSERT INTO sungby VALUES	(1,
  2  							2,	
  3  							1,	
  4  							'11-MAY-1950'
  5  							);

1 row inserted.

SQL> 
SQL> INSERT INTO sungby VALUES	(2,	
  2  							2,	
  3  							1,	
  4  							'08-FEB-1950'
  5  							);

1 row inserted.

SQL> 
SQL> INSERT INTO sungby VALUES	(2,	
  2  							2,	
  3  							2,	
  4  							'21-FEB-1950'
  5  							);

1 row inserted.

SQL> 
SQL> INSERT INTO sungby VALUES	(3,	
  2  							3,	
  3  							3,	
  4  							'21-FEB-1950'
  5  							);

1 row inserted.

SQL> 
SQL> 
SQL> 
SQL> REM ********************************************************************
SQL> REM 						TABLE CONTENTS
SQL> REM ********************************************************************
SQL> SELECT * FROM artist;

 ARTIST_ID ARTIST_NAME                   
---------- ------------------------------
         1 Joe                           
         2 Ame                           
         3 Vishal                        
         4 Vikram                        
         5 Aaron                         

SQL> SELECT * FROM musician;

MUSICIAN_ID MUSICIAN_NAME                  BIRTHPLACE                    
----------- ------------------------------ ------------------------------
          1 Rahman                         Chennai                       
          2 Eminem                         America                       
          3 Emily                          UK                            
          4 Aaron                          UK                            
          5 Weron                          UK                            

SQL> SELECT * FROM studio;

STUDIO_NAME                    ADDRESS                                                 PHONE
------------------------------ -------------------------------------------------- ----------
AVM                            Chennai                                            1234567890
2D                             Hyderabad                                          1111111111
3D                             Delhi                                              3333333333
4D                             Rome                                               2222222222
5D                             Delhi                                              4444444444

SQL> SELECT * FROM album;

  ALBUM_ID ALBUM_NAME                     REL_YEAR NO_OF_TRACKS STUDIO                         ALB   MUSICIAN
---------- ------------------------------ -------- ------------ ------------------------------ --- ----------
         1 Jazzy Music                    19-07-00            5 AVM                            POP          1
         2 Movie Music                    22-10-00            7 2D                             MOV          2
         3 Diverse Music                  11-05-50            3 3D                             DIV          3
         4 New Music                      14-05-75            6 4D                             DIV          4
         5 Old Music                      29-06-80            3 5D                             DIV          5

SQL> SELECT * FROM song;

  ALBUM_ID   TRACK_NO SONG_NAME                      SONG_LENGTH SON
---------- ---------- ------------------------------ ----------- ---
         1          1 Song11                                7.25 PAT
         2          1 Song12                                8.25 PAT
         1          2 Song21                                 4.5 PHI
         2          2 Song22                                 3.5 LOV
         1          3 Song31                                4.25 PHI
         3          3 Song33                                4.25 PHI

6 rows selected. 

SQL> SELECT * FROM sungby;

  ALBUM_ID   TRACK_NO  ARTIST_ID RECORD_D
---------- ---------- ---------- --------
         1          1          1 19-07-00
         1          1          2 22-10-00
         1          2          1 11-05-50
         2          2          1 08-02-50
         2          2          2 21-02-50
         3          3          3 21-02-50

6 rows selected. 

SQL> 
SQL> 
SQL> REM ********************************************************************
SQL> REM 					VIOLATING SOME CONSTRAINTS
SQL> REM ********************************************************************
SQL> 
SQL> 
SQL> INSERT INTO song VALUES	(2,	
  2  						3,	
  3  						'Song23',	 
  4  						4.30, 	
  5  						'PAT'
  6  						);

Error starting at line : 319 in command -
INSERT INTO song VALUES	(2,	
						3,	
						'Song23',	 
						4.30, 	
						'PAT'
						)
Error report -
ORA-02290: check constraint (VISH.SONG_PAT_LENGTH) violated

SQL> 
SQL> INSERT INTO song VALUES	(2,	
  2  						4,	
  3  						'Song24',	 
  4  						4.00, 	
  5  						'REL'
  6  						);

1 row inserted.

SQL> 
SQL> SELECT * FROM song;

  ALBUM_ID   TRACK_NO SONG_NAME                      SONG_LENGTH SON
---------- ---------- ------------------------------ ----------- ---
         1          1 Song11                                7.25 PAT
         2          1 Song12                                8.25 PAT
         1          2 Song21                                 4.5 PHI
         2          2 Song22                                 3.5 LOV
         1          3 Song31                                4.25 PHI
         3          3 Song33                                4.25 PHI
         2          4 Song24                                   4 REL

7 rows selected. 

SQL> SELECT * FROM sungby;

  ALBUM_ID   TRACK_NO  ARTIST_ID RECORD_D
---------- ---------- ---------- --------
         1          1          1 19-07-00
         1          1          2 22-10-00
         1          2          1 11-05-50
         2          2          1 08-02-50
         2          2          2 21-02-50
         3          3          3 21-02-50

6 rows selected. 

SQL> 
SQL> REM REMOVAL OF EXISTING RECORD
SQL> DELETE FROM song WHERE album_id = 1 AND track_no = 1;

Error starting at line : 337 in command -
DELETE FROM song WHERE album_id = 1 AND track_no = 1
Error report -
ORA-02292: integrity constraint (VISH.ALBUM_ID_TRACK_NO_FK) violated - child record found

SQL> 
SQL> 
SQL> SELECT * FROM song;

  ALBUM_ID   TRACK_NO SONG_NAME                      SONG_LENGTH SON
---------- ---------- ------------------------------ ----------- ---
         1          1 Song11                                7.25 PAT
         2          1 Song12                                8.25 PAT
         1          2 Song21                                 4.5 PHI
         2          2 Song22                                 3.5 LOV
         1          3 Song31                                4.25 PHI
         3          3 Song33                                4.25 PHI
         2          4 Song24                                   4 REL

7 rows selected. 

SQL> SELECT * FROM sungby;

  ALBUM_ID   TRACK_NO  ARTIST_ID RECORD_D
---------- ---------- ---------- --------
         1          1          1 19-07-00
         1          1          2 22-10-00
         1          2          1 11-05-50
         2          2          1 08-02-50
         2          2          2 21-02-50
         3          3          3 21-02-50

6 rows selected. 

SQL> 
SQL> 
SQL> INSERT INTO sungby VALUES	(5,	
  2  							5,	
  3  							5,	
  4  							'19-JUL-2000'
  5  							);

Error starting at line : 344 in command -
INSERT INTO sungby VALUES	(5,	
							5,	
							5,	
							'19-JUL-2000'
							)
Error report -
ORA-02291: integrity constraint (VISH.ALBUM_ID_TRACK_NO_FK) violated - parent key not found

SQL> 
SQL> UPDATE 	sungby 
  2  SET 	album_id = 5 
  3  WHERE	track_no = 1 AND artist_id = 1;

Error starting at line : 350 in command -
UPDATE 	sungby 
SET 	album_id = 5 
WHERE	track_no = 1 AND artist_id = 1
Error report -
ORA-02291: integrity constraint (VISH.ALBUM_ID_TRACK_NO_FK) violated - parent key not found

SQL> REM FOREIGN KEY CONSTRAINT VIOLATION
SQL> 
SQL> UPDATE 	sungby
  2  SET 	track_no = 2
  3  WHERE 	album_id = 1 AND artist_id = 1;

Error starting at line : 355 in command -
UPDATE 	sungby
SET 	track_no = 2
WHERE 	album_id = 1 AND artist_id = 1
Error report -
ORA-00001: unique constraint (VISH.SUNGBY_PK) violated

SQL> REM PRIMARY KEY CONSTRAINT VIOLATION
SQL> 
SQL> UPDATE 	sungby
  2  SET 	album_id = 2 
  3  WHERE 	track_no = 1 AND artist_id = 1;

1 row updated.

SQL> REM INSERTED BECAUSE SUCH AN ALBUM_ID, TRACK_NO COMBINATION EXISTS IN THE SONG TABLE WITHOUT ANY EXISTING REFERENCES IN THE SUNGBY TABLE
SQL> 
SQL> 
SQL> REM REMOVAL OF EXISTING RECORD
SQL> DELETE FROM song where album_id = 2;

Error starting at line : 367 in command -
DELETE FROM song where album_id = 2
Error report -
ORA-02292: integrity constraint (VISH.ALBUM_ID_TRACK_NO_FK) violated - child record found

SQL> 
SQL> 
SQL> REM CHECKING THE RELATIONSHIP BETWEEN THE VARIOUS FOREIGN KEY-PRIMARY KEY OF CORRESPONDING RELATIONS
SQL> DELETE FROM album where album_id = 1;

Error starting at line : 371 in command -
DELETE FROM album where album_id = 1
Error report -
ORA-02292: integrity constraint (VISH.ALBUM_FK) violated - child record found

SQL> DELETE FROM album where album_id = 5;

1 row deleted.

SQL> 
SQL> DELETE FROM song where album_id = 3;

Error starting at line : 374 in command -
DELETE FROM song where album_id = 3
Error report -
ORA-02292: integrity constraint (VISH.ALBUM_ID_TRACK_NO_FK) violated - child record found

SQL> 
SQL> REM REMOVAL OF EXISTING RECORD
SQL> DELETE FROM song where album_id = 1;

Error starting at line : 377 in command -
DELETE FROM song where album_id = 1
Error report -
ORA-02292: integrity constraint (VISH.ALBUM_ID_TRACK_NO_FK) violated - child record found

SQL> 
SQL> REM REMOVAL OF EXISTING RECORD
SQL> DELETE FROM sungby where album_id = 3;

1 row deleted.

SQL> 
SQL> REM REMOVAL OF EXISTING RECORD
SQL> DELETE FROM song where album_id = 3;

1 row deleted.

SQL> 
SQL> 
SQL> 
SQL> REM ********************************************************************
SQL> REM 					ALTER TABLE QUERIES
SQL> REM ********************************************************************
SQL> 
SQL> REM 10)It is necessary to represent the gender of an artist in the table
SQL> 
SQL> ALTER TABLE artist ADD gender CHAR(1);

Table ARTIST altered.

SQL> 
SQL> INSERT INTO artist VALUES	(6, 	
  2  							'Vikraman'
  3  							);

Error starting at line : 395 in command -
INSERT INTO artist VALUES	(6, 	
							'Vikraman'
							)
Error at Command Line : 395 Column : 13
Error report -
SQL Error: ORA-00947: not enough values
00947. 00000 -  "not enough values"
*Cause:    
*Action:
SQL> 
SQL> REM 11)The first few words of the lyrics constitute the song name. 
SQL> REM The song name do not accommodate some of the words (in lyrics).
SQL> 
SQL> ALTER TABLE song MODIFY song_name VARCHAR2(50);

Table SONG altered.

SQL> 
SQL> 
SQL> REM 12)The phone number of each studio should be different.
SQL> 
SQL> ALTER TABLE studio ADD CONSTRAINT ph_uk UNIQUE(phone);

Table STUDIO altered.

SQL> 
SQL> INSERT INTO studio VALUES	('6D', 	
  2  							'Bangalore', 	
  3  							1111111111
  4  							);

Error starting at line : 409 in command -
INSERT INTO studio VALUES	('6D', 	
							'Bangalore', 	
							1111111111
							)
Error report -
ORA-00001: unique constraint (VISH.PH_UK) violated

SQL> 
SQL> REM 13)An artist who sings a song for a particular track of an album can not be recorded
SQL> REM without the record_date.
SQL> 
SQL> ALTER TABLE sungby MODIFY (record_date NOT NULL);

Table SUNGBY altered.

SQL> 
SQL> INSERT INTO sungby	(track_no, 
  2  					album_id, 
  3  					artist_id) 
  4  			VALUES	(3,	
  5  					3,	
  6  					3
  7  					);

Error starting at line : 419 in command -
INSERT INTO sungby	(track_no, 
					album_id, 
					artist_id) 
			VALUES	(3,	
					3,	
					3
					)
Error report -
ORA-01400: cannot insert NULL into ("VISH"."SUNGBY"."RECORD_DATE")

SQL> 
SQL> REM 14)It was decided to include the genre NAT for nature songs.
SQL> 
SQL> ALTER TABLE song DROP CONSTRAINT song_genre_chk;

Table SONG altered.

SQL> 
SQL> ALTER TABLE song ADD CONSTRAINT song_genre_chk 
  2  CHECK(song_genre IN ('PHI',	'REL',	'LOV',	'DEV',	'PAT',	'NAT'));

Table SONG altered.

SQL> 
SQL> INSERT INTO song VALUES(4,	3,	'Song43', 	4.00, 	'NAT');

1 row inserted.

SQL> 
SQL> REM 15)Due to typo error, there may be a possibility of false information. Hence while 
SQL> REM deleting the song information, make sure that all the corresponding information are 
SQL> REM also deleted.
SQL> 
SQL> ALTER TABLE sungby DROP CONSTRAINT album_id_track_no_fk;

Table SUNGBY altered.

SQL> 
SQL> ALTER TABLE sungby ADD	CONSTRAINT album_id_track_no_fk 
  2  						FOREIGN KEY(album_id, track_no) 
  3  						REFERENCES song(album_id, track_no) ON DELETE CASCADE;

Table SUNGBY altered.

SQL> 
SQL> 
SQL> SELECT * FROM song;

  ALBUM_ID   TRACK_NO SONG_NAME                                          SONG_LENGTH SON
---------- ---------- -------------------------------------------------- ----------- ---
         1          1 Song11                                                    7.25 PAT
         2          1 Song12                                                    8.25 PAT
         1          2 Song21                                                     4.5 PHI
         2          2 Song22                                                     3.5 LOV
         1          3 Song31                                                    4.25 PHI
         2          4 Song24                                                       4 REL
         4          3 Song43                                                       4 NAT

7 rows selected. 

SQL> SELECT * FROM sungby;

  ALBUM_ID   TRACK_NO  ARTIST_ID RECORD_D
---------- ---------- ---------- --------
         2          1          1 19-07-00
         1          1          2 22-10-00
         1          2          1 11-05-50
         2          2          1 08-02-50
         2          2          2 21-02-50

SQL> 
SQL> REM REMOVAL OF EXISTING RECORD, TO CHECK THE EFFECT OF ON DELETE CASCADE
SQL> DELETE FROM song WHERE album_id = 1 AND track_no = 1;

1 row deleted.

SQL> 
SQL> SELECT * FROM song;

  ALBUM_ID   TRACK_NO SONG_NAME                                          SONG_LENGTH SON
---------- ---------- -------------------------------------------------- ----------- ---
         2          1 Song12                                                    8.25 PAT
         1          2 Song21                                                     4.5 PHI
         2          2 Song22                                                     3.5 LOV
         1          3 Song31                                                    4.25 PHI
         2          4 Song24                                                       4 REL
         4          3 Song43                                                       4 NAT

6 rows selected. 

SQL> SELECT * FROM sungby;

  ALBUM_ID   TRACK_NO  ARTIST_ID RECORD_D
---------- ---------- ---------- --------
         2          1          1 19-07-00
         1          2          1 11-05-50
         2          2          1 08-02-50
         2          2          2 21-02-50

SQL> 
SQL> 
SQL> REM ********************************************************************
SQL> REM 					END OF SCRIPT FILE
SQL> REM ********************************************************************
