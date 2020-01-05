REM 10)It is necessary to represent the gender of an artist in the table
ALTER TABLE artist ADD gender CHAR(1);

INSERT INTO artist VALUES (5, 'Vikraman','M');

REM 11)The first few words of the lyrics constitute the song name. 
REM The song name do not accommodate some of the words (in lyrics).
ALTER TABLE song MODIFY song_name VARCHAR2(50);

INSERT INTO song VALUES(2,5,'10 charac 10 charac 10 charac 10 charac 10 chara', 4.00, 'PHI');

REM 12)The phone number of each studio should be different.
ALTER TABLE studio ADD CONSTRAINT ph_uk UNIQUE(phone);

INSERT INTO studio VALUES ('4D', 'Bangalore' , 1111111111);

REM 13)An artist who sings a song for a particular track of an album can not be recorded
REM without the record_date.

ALTER TABLE sungby MODIFY (record_date NOT NULL);

INSERT INTO sungby(track_no, album_id, artist_id) VALUES(2,1,3);

REM 14)It was decided to include the genre NAT for nature songs.

ALTER TABLE song DROP CONSTRAINT song_genre_chk;
ALTER TABLE song ADD CONSTRAINT song_genre_chk CHECK(song_genre IN ('PHI','REL','LOV','DEV','PAT','NAT'));

INSERT INTO song VALUES(2,2,'Song4', 4.00, 'NAT');

REM 15)Due to typo­error, there may be a possibility of false information. Hence while 
REM deleting the song information, make sure that all the corresponding information are 
REM also deleted.

ALTER TABLE song DROP CONSTRAINT album_fk;
ALTER TABLE song ADD CONSTRAINT album_fk FOREIGN KEY(album_id) REFERENCES album(album_id) ON DELETE CASCADE;

DELETE FROM album WHERE album_id = 1;
SELECT * FROM album;
SELECT * FROM song;


REM Violating Constraints
INSERT INTO artist VALUES (4, 'Vishal','M');
INSERT INTO artist VALUES (1, 'Balaji', 'M');

INSERT INTO musician VALUES (2, 'Rahman', 'Madurai');

INSERT INTO studio VALUES ('AVM', 'Kodambakkam', 00000000000);


INSERT INTO album VALUES(4,'Rock Music', '19-JUL-1944',2,'AVM','DIV',3);
INSERT INTO album VALUES(4,'Rock Music', '19-JUL-1946',2,'AVM','QQQ',3);
INSERT INTO album VALUES(4,'Rock Music', '19-JUL-1947',2,'AVM','DIV',6);

INSERT INTO sungby VALUES(5,5,5,'19-JUL-2000');


INSERT INTO song VALUES(5,5,'Song4', 4.00, 'REL');

INSERT INTO song VALUES(2,3,'Song4', 4.30, 'PAT');
INSERT INTO song VALUES(2,4,'Song4', 4.00, 'NAY');