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

CREATE TABLE composition ( 
	compid int,
	comptitle varchar(50),
	compyear varchar(4),
		PRIMARY KEY (compid)
);

CREATE TABLE person ( 
	psnid int,
	psnfname varchar(10),
	psnlname varchar(20),
		PRIMARY KEY (psnid)
);

CREATE TABLE cd ( 
	cdid int,
	cdlblid varchar(15),
	cdtitle varchar(40),
	cdyear int,
	lbltitle varchar(40),
		PRIMARY KEY (cdid),
		CONSTRAINT fk_cd FOREIGN KEY (lbltitle) REFERENCES label(lbltitle)
);

CREATE TABLE recording ( 
	rcdid int, 
	rcdlength decimal(4,2),
	rcddate date,
	compid int,
		PRIMARY KEY (rcdid,compid),
		CONSTRAINT fk_recording_compid FOREIGN KEY (compid) REFERENCES composition(compid)
);

CREATE TABLE person_cd (
	psncdorder int,
	psnid int,
	cdid int,
		PRIMARY KEY (psnid,cdid),
		CONSTRAINT fk_personcd_psnid FOREIGN KEY (psnid) REFERENCES person(psnid),
		CONSTRAINT fk_personcd_cdid FOREIGN KEY (cdid) REFERENCES cd(cdid)
);

CREATE TABLE person_composition (
	psncomprole varchar(10),
	psncomporder int,
	psnid int,
	compid int,
		PRIMARY KEY (psncomprole,psnid,compid),
		CONSTRAINT fk_personcomp_psnid FOREIGN KEY (psnid) REFERENCES person(psnid),
		CONSTRAINT fk_personcomp_compid FOREIGN KEY (compid) REFERENCES composition(compid)
);

CREATE TABLE person_recording (
	psnrcdrole varchar(20),
	psnid int,
	rcdid int,
	compid int,
		PRIMARY KEY (psnrcdrole,psnid,rcdid,compid),
		CONSTRAINT fk_personrec_psnid FOREIGN KEY (psnid) REFERENCES person(psnid),
		CONSTRAINT fk_presonrec_rccompid FOREIGN KEY (rcdid,compid) REFERENCES recording(rcdid,compid)
);

CREATE TABLE track ( 
	cdid int,
	trknum int,
	rcdid int,
	compid int,
		PRIMARY KEY (cdid,trknum),
		CONSTRAINT fk_track_cdid FOREIGN KEY (cdid) REFERENCES cd(cdid),
		CONSTRAINT fk_track_otherids FOREIGN KEY (rcdid,compid) REFERENCES recording(rcdid,compid)
);
/* PROBLEM 1 END */

/* PROBLEM 2 BEGIN */
SELECT trknum, comptitle FROM track 
	JOIN composition ON composition.compid = track.compid
		JOIN cd ON cd.cdid = track.cdid
    		WHERE cdtitle = "Giant Steps";
/* PROBLEM 2 END */


/* PROBLEM 3 BEGIN */
SELECT psnfname, psnlname, psnrcdrole FROM person_recording
	JOIN person ON person.psnid = person_recording.psnid
	JOIN recording ON recording.rcdid = person_recording.rcdid
	JOIN composition ON composition.compid = person_recording.compid
		WHERE rcddate = "1959-05-04" AND comptitle = "Giant Steps";
/* PROBLEM 3 END */

/* PROBLEM 4 BEGIN */
SELECT psnfname, psnlname FROM person,person_recording,person_composition 
	WHERE person.psnid = person_recording.psnid 
		AND person.psnid = person_composition.psnid 
			LIMIT 1;
/* PROBLEM 4 */

/* PROBLEM 5 BEGIN */
SELECT comptitle, trknum, cdtitle FROM composition, track, cd
	WHERE composition.compid = track.compid 
		AND cd.cdid = track.cdid
			AND track.cdid IN
		(SELECT cdid FROM track GROUP BY track.compid, track.cdid HAVING count(*) > 1)
			AND track.compid IN
		(SELECT compid FROM track GROUP BY track.compid, track.cdid HAVING count(*) > 1)
			ORDER BY comptitle, trknum;		
/* PROBLEM 5 END */

/* PROBLEM 6 BEGIN */
SELECT recording.rcdid, rcddate FROM recording
	JOIN track ON track.rcdid = recording.rcdid
	JOIN cd ON track.cdid = cd.cdid
		WHERE NOT EXISTS
	(SELECT * FROM cd WHERE NOT EXISTS
	(SELECT * FROM track 
		WHERE track.rcdid = recording.rcdid
			AND track.cdid = cd.cdid));
/* PROBLEM 6 END */

/* PROBLEM 7 BEGIN */
SELECT recording.rcdid, recording.rcddate FROM recording 
	JOIN track ON recording.rcdid = track.rcdid
		GROUP BY recording.rcdid, recording.rcddate
			HAVING COUNT(DISTINCT cdid) = 
				(SELECT COUNT(DISTINCT cd.cdid) FROM cd);
/* PROBLEM 7 END */

