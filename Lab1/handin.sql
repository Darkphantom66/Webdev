/* Author: Randen J. Nolan*/

/* PROBLEM 1 BEGIN */
/* Perform the following SQL query and paste your results below: */
SELECT * from track WHERE trklength > 6;

/* 
trkid,trknum,trktitle,trklength
5,5,Syeeda's song flute,7.00
7,7,Mr. P.C.,6.95
12,12,Syeeda's song flute,7.03
22,10,Clouds,7.20 
*/

/* PROBLEM 1 END */

/* PROBLEM 2 BEGIN */
SELECT * from track WHERE trklength BETWEEN 3 and 4;
/* PROBLEM 2 END */

/* PROBLEM 3 BEGIN */
SELECT trknum,trklength from track where trktitle = "java jive";
/* PROBLEM 3 END */

/* PROBLEM 4 BEGIN */
SELECT avg(trklength) from track;
/* PROBLEM 4 END */

/* PROBLEM 5 BEGIN */
CREATE TABLE ship (
	RegCode varchar(7),
    ShipName varchar(50),
    Tonnage int,
    Year int,
    Type varchar(9),
    	PRIMARY KEY(RegCode)
);
/* PROBLEM 5 END */

/* PROBLEM 6 BEGIN */
SELECT RegCode from ship where ShipName REGEXP 'a';
/* PROBLEM 6 END */

/* PROBLEM 7 BEGIN */
SELECT ShipName from ship where Tonnage = (Select max(Tonnage) from ship);
/* PROBLEM 7 END */
