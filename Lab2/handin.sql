/* Author: Randen J. Nolan*/


/* PROBLEM 1 BEGIN */
CREATE TABLE label (
	lbltitle varchar(40),
	lblstreet varchar(40),
	lblcity varchar(40),
	lblstate varchar(40),
	lblpostcode varchar(15),
	lblnation varchar(10),
		PRIMARY KEY(lbltitle)
);

CREATE TABLE cd (
	cdid int,
	cdlblid varchar(15),
	cdtitle varchar(40),
	cdyear int,
	lbltitle varchar(40),
		PRIMARY KEY (cdid),
		FOREIGN KEY (lbltitle) REFERENCES label(lbltitle)
);

CREATE TABLE track (
	trkid int,
	trknum int,
	trktitle varchar(50),
	trklength decimal(4,2),
	cdid int,
		PRIMARY KEY (trkid),
		FOREIGN KEY (cdid) REFERENCES cd(cdid)
);

/* PROBLEM 1 END */

/* PROBLEM 2 BEGIN */
SELECT trktitle, cdtitle, trklength FROM track,cd
	WHERE cd.cdid = track.cdid 
		ORDER BY cdtitle,trklength;
/* PROBLEM 2 END */

/* PROBLEM 3 BEGIN */
SELECT trktitle, trklength FROM track,cd
	WHERE track.cdid = cd.cdid  AND 
		track.cdid = (SELECT cd.cdid from cd where cd.cdid = 2);
/* PROBLEM 3 END */


/* PROBLEM 4 BEGIN */
SELECT cdtitle, trktitle, trklength FROM track,cd
    WHERE track.cdid = cd.cdid 
        AND trklength = (SELECT MAX(trklength) FROM track WHERE track.cdid = cd.cdid)
/* PROBLEM 4 END */

/* PROBLEM 5 BEGIN */
SELECT cdtitle, COUNT(trktitle) AS trkcount, SUM(trklength) AS cdlength FROM track,cd 
	WHERE track.cdid = cd.cdid
		GROUP BY cd.cdtitle
			ORDER BY trkcount DESC;
/* PROBLEM 5 END */

/* PROBLEM 6 BEGIN */
SELECT label.lbltitle, lblnation, cdtitle, SUM(trklength) AS cdlength FROM label,cd,track
	WHERE cd.lbltitle = label.lbltitle 
		AND cd.cdid = track.cdid 
			GROUP BY cd.cdid
				HAVING cdlength > 40;
/* PROBLEM 6 END */

/* PROBLEM 7 BEGIN */
SELECT cdtitle, trktitle, trklength FROM track,cd
	WHERE cd.cdid = track.cdid 
		 ORDER BY trklength ASC
			LIMIT 3;
/* PROBLEM 7 END */

/* PROBLEM 8 BEGIN */
CREATE VIEW CDView (cdid, cdlblid, cdtitle, cdyear, cdlength) 
	AS SELECT cd.cdid, cdlblid, cdtitle, cdyear, SUM(trklength) as cdlength FROM track, cd
		WHERE cd.cdid = track.cdid
		  GROUP BY cd.cdid; 
/* PROBLEM 8 END */

/* PROBLEM 9 BEGIN */
SELECT trktitle, trklength, cdtitle FROM track,cd
	WHERE cd.cdid = track.cdid AND trktitle REGEXP '^C|^c';
/* PROBLEM 9 END */
