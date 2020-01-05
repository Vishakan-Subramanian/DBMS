DROP TABLE sungby;
DROP TABLE song;
DROP TABLE album;
DROP TABLE artist;
DROP TABLE studio;
DROP TABLE musician;


REM ARTIST TABLE CREATION

CREATE TABLE artist(
	artist_id NUMBER(5) CONSTRAINT artist_id_pk PRIMARY KEY,
	artist_name VARCHAR2(30) CONSTRAINT artist_name_uk UNIQUE
	);

DESC artist;

REM STUDIO TABLE CREATION

CREATE TABLE studio(
	studio_name VARCHAR2(30) CONSTRAINT name_pk PRIMARY KEY,
	address VARCHAR2(50),
	phone NUMBER(10)
	);

DESC studio;

REM MUSICIAN TABLE CREATION

CREATE TABLE musician(
	musician_id NUMBER(5) CONSTRAINT musician_id_pk PRIMARY KEY,
	musician_name VARCHAR2(30),
	birthplace VARCHAR2(30)
	);

DESC musician;

REM ALBUM TABLE CREATION

CREATE TABLE album(
	album_id NUMBER(5) CONSTRAINT album_id_pk PRIMARY KEY,
	album_name VARCHAR2(30),
	rel_year DATE CONSTRAINT year_gt_1945 CHECK (EXTRACT(YEAR FROM(rel_year)) >= 1945),
	no_of_tracks NUMBER(2) CONSTRAINT no_of_tracks_nn NOT NULL,
	studio VARCHAR(30),
	album_genre CHAR(3) CONSTRAINT album_genre_chk CHECK(album_genre IN('CAR','DIV','MOV','POP')),
	musician NUMBER(5) CONSTRAINT musician_fk REFERENCES musician(musician_id),
	CONSTRAINT studio_fk FOREIGN KEY(studio) REFERENCES studio(studio_name)
	);

DESC album;

REM SONG TABLE CREATION

CREATE TABLE song(
	album_id NUMBER(5), 
	track_no NUMBER(2),
	song_name VARCHAR2(30),
	song_length NUMBER(4,2),
	song_genre VARCHAR2(3) CONSTRAINT song_genre_chk CHECK(song_genre IN ('PHI','REL','LOV','DEV','PAT')),
	CONSTRAINT song_pk PRIMARY KEY (album_id, track_no),
	CONSTRAINT album_fk FOREIGN KEY(album_id) REFERENCES album(album_id),
	CONSTRAINT song_pat_length CHECK (song_genre NOT IN ('PAT') OR song_length>7)
	);

DESC song;

REM SUNGBY TABLE CREATION

CREATE TABLE sungby(
	track_no NUMBER(5),
	album_id NUMBER(5),
	artist_id NUMBER(5),
	record_date DATE,
	CONSTRAINT artist_id_fk FOREIGN KEY (artist_id) REFERENCES artist(artist_id),
	CONSTRAINT album_id_track_no_fk FOREIGN KEY (album_id, track_no) REFERENCES song(album_id, track_no),
	CONSTRAINT sungby_pk PRIMARY KEY (album_id , artist_id, track_no)
	);

DESC sungby;    

INSERT INTO artist VALUES (1, 'Joe');
INSERT INTO artist VALUES (2, 'Ame');
INSERT INTO artist VALUES (3, 'Vishal');

INSERT INTO musician VALUES (1, 'Rahman', 'Chennai');
INSERT INTO musician VALUES (2, 'Eminem', 'America');
INSERT INTO musician VALUES (3, 'Emily', 'UK');

INSERT INTO studio VALUES ('AVM' , 'Chennai', 1234567890);
INSERT INTO studio VALUES ('2D', 'Hyderabad' , 1111111111);
INSERT INTO studio VALUES ('3D', 'Delhi', 3333333333);

INSERT INTO album VALUES (1,'Jazzy Music', '19-JUL-2000',5,'AVM','POP',1);
INSERT INTO album VALUES (2,'Movie Music', '22-OCT-2000',7,'2D','MOV',2);
INSERT INTO album VALUES (3,'Diverse Music', '11-MAY-1950',3,'3D','DIV',3);

INSERT INTO song VALUES (1,1,'Song1', 7.25, 'PAT');
INSERT INTO song VALUES (1,1,'Song4', 6.25, 'PAT');
INSERT INTO song VALUES (2,2,'Song2', 3.50, 'LOV');
INSERT INTO song VALUES (3,3,'Song3', 4.25, 'PHI');

INSERT INTO sungby VALUES (1,1,1,'19-JUL-2000');
INSERT INTO sungby VALUES (2,2,2,'22-OCT-2000');
INSERT INTO sungby VALUES (3,3,3,'11-MAY-1950');

SELECT * FROM artist;
SELECT * FROM musician;
SELECT * FROM studio;
SELECT * FROM album;
SELECT * FROM song;
SELECT * FROM sungby;


INSERT INTO song VALUES (5,5,'Song5', 4.50, 'PHI');
