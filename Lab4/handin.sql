/* PROBLEM 1 BEGIN */
SELECT empno, empfname FROM emp 
	WHERE bossno IS NULL;
/* PROBLEM 1 END */

/* PROBLEM 2 BEGIN */
SELECT Wrk.empno AS empno, Wrk.empfname AS empfname, 
		Boss.empno AS mgrno, Boss.empfname AS mgrfname
	FROM emp Wrk, emp Boss
		WHERE Wrk.bossno = Boss.empno
			ORDER BY empfname;
/* PROBLEM 2 END */

/* PROBLEM 3 BEGIN */
SELECT dept.deptname FROM dept, emp
    WHERE emp.deptname = dept.deptname
    	AND dept.empno != emp.empno
            GROUP BY dept.deptname
                HAVING AVG(emp.empsalary) > 25000;	
/* PROBLEM 3 END */

/* PROBLEM 4 BEGIN */
SELECT empno, empfname FROM emp
	WHERE bossno = (SELECT bossno FROM emp WHERE empfname = "Andrew");
/* PROBLEM 4 END */

/* PROBLEM 5 BEGIN */
SELECT empno, empfname, empsalary FROM emp
	WHERE empsalary = (SELECT MAX(empsalary) FROM emp 
		WHERE bossno = (SELECT bossno FROM emp WHERE empfname = "Andrew"))
		AND empno IN (SELECT empno FROM emp
	WHERE bossno = (SELECT bossno FROM emp WHERE empfname = "Andrew"));
/* PROBLEM 5 END */

/* PROBLEM 6 BEGIN */
SELECT empno, empfname FROM emp
	WHERE emp.empno NOT IN 
		(SELECT dept.empno FROM dept) 
			AND emp.empno IN 
				(SELECT emp.bossno FROM emp);
/* PROBLEM 6 END */

/* PROBLEM 7 BEGIN */
SELECT product.prodid, proddesc, prodprice FROM product,assembly
	WHERE product.prodid = assembly.subprodid AND prodprice = 
	(SELECT MAX(prodprice) FROM product, assembly
		WHERE product.prodid = assembly.subprodid 
		AND assembly.prodid  = 
			(SELECT product.prodid FROM product WHERE proddesc = "Animal photography kit"))
		AND subprodid IN (SELECT subprodid FROM assembly,product 
			WHERE assembly.prodid = 
				(SELECT product.prodid FROM product WHERE proddesc = "Animal photography kit"))

/* PROBLEM 7 END */
