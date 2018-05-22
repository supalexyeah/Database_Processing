--2.ACTOR & PLAY
-- Create tables
CREATE TABLE Actor (
actor_id NUMBER(10) NOT NULL, 
name VARCHAR2(30),
year_born INTEGER,

PRIMARY KEY(actor_id)
);

CREATE TABLE Play (
play_id NUMBER(10) NOT NULL,
title   VARCHAR2(50), 
author  VARCHAR2(30), 
year_written INTEGER,

PRIMARY KEY(play_id)
);

CREATE TABLE Role (
actor_id NUMBER(10), 
character_name VARCHAR2(30) NOT NULL,
play_id NUMBER(10),

PRIMARY KEY(actor_id, character_name, play_id),
FOREIGN KEY(actor_id) REFERENCES Actor(actor_id),
FOREIGN KEY(play_id) REFERENCES Play(play_id)
);

--2.1 Write a SQL query that returns the number of actors who have performed in three or more different 
-- plays written by the author “August Wilson”.
SELECT count(Role.actor_id)
FROM Role, Play
WHERE Play.author = "August Wilson" AND 
      Play.play_id = ROLE.play_id 
GROUP BY Role.actor_id
HAVING count(DISTINCT Role.play_id) >=3 ;

--2.2 Write a SQL query that returns the names of all actors who have performed some play by the author 
-- “Chekhov” and have never performed in any play written by author “Shakespeare”.  
SELECT DISTINCT Actor.name
FROM Actor, Play p1, Role r1
WHERE p1.author = "Chekhov" AND 
      p1.play_id = r1.play_id AND 
      r1.actor_id = Actor.actor_id AND
      Actor.actor_id NOT IN (SELECT r2.actor_id 
                         FROM Role r2, Play p2
                         WHERE p2.author = "Shakespeare" AND p2.play_id = r2.play_id);