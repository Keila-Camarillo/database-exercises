SHOW databases;

USE albums_db;
SHOW tables;

SELECT * 
FROM albums;

SHOW CREATE TABLE albums;
/*
CREATE TABLE `albums` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `artist` varchar(240) DEFAULT NULL,
  `name` varchar(240) NOT NULL,
  `release_date` int DEFAULT NULL,
  `sales` float DEFAULT NULL,
  `genre` varchar(240) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=latin1

What is the primary key for the albums table? id

What does the column named 'name' represent? name of album

What do you think the sales column represents? albums sold

*/

-- Find the name of all albums by Pink Floyd.
SELECT * 
FROM albums
WHERE artist = 'Pink Floyd';

-- What is the year Sgt. Pepper's Lonely Hearts Club Band was released? 1967

SELECT *
FROM albums
WHERE name = "Sgt. Pepper's Lonely Hearts Club Band";

-- What is the genre for the album Nevermind? Grunge, Alternative rock
SELECT name, genre
FROM albums
WHERE name = 'Nevermind';

-- Which albums were released in the 1990s? 
SELECT *
FROM albums
WHERE release_date BETWEEN 1990 and 1999;

-- Which albums had less than 20 million certified sales?
SELECT * 
FROM albums
WHERE sales < 20;





