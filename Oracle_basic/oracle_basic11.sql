/*CREATE TABLE SALGRADE(
	GRADE NUMBER,
	LOSAL NUMBER,
	HISAL NUMBER
	);
INSERT INTO SALGRADE VALUES (1, 700, 1200);
INSERT INTO SALGRADE VALUES (2, 1201, 1400);
INSERT INTO SALGRADE VALUES (3, 1401, 2000);
INSERT INTO SALGRADE VALUES (4, 2001, 3000);
INSERT INTO SALGRADE VALUES (5, 3001, 9999);
COMMIT;*/

-- SELECT * FROM salgrade;

/*
    비등가 조인 (NON EQUI_JOIN) => = 이외의 연산자 사용시 ==> 범위 포함
*/
SELECT empno, ename, job, hiredate, sal, grade
FROM emp, salgrade
WHERE sal BETWEEN losal AND hisal;
/*
    emp, dept, salgrade => 3개 조인
*/
SELECT empno, ename, job, hiredate, sal, dname, loc, grade
--     -------------------------------- emp ------ dept --- salgrade
FROM emp, dept, salgrade
WHERE emp.deptno = dept.deptno
AND sal BETWEEN losal AND hisal;

-- ANSI JOIN
SELECT empno, ename, job, hiredate, sal, dname, loc, grade
FROM emp JOIN dept
ON emp.deptno = dept.deptno
JOIN salgrade
ON sal BETWEEN losal AND hisal;

-- NATURAL JOIN
SELECT empno, ename, job, hiredate, dname, loc, grade
FROM emp NATURAL JOIN dept
JOIN salgrade
ON sal BETWEEN losal AND hisal;

-- JOIN USING
SELECT empno, ename, job, hiredate, dname, loc, grade
FROM emp JOIN dept USING (deptno)
JOIN salgrade
ON sal BETWEEN losal AND hisal;

-- emp => empno, ename, job, hiredate, sal => dname, loc ==> SOCTT사원의 정보
-- 사원 정보, 부서 정보 => 두 테이블에서 필요한 데이터를 추출 ==> JOIN
SELECT empno, ename, job, hiredate, sal, dname, loc
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND ename = 'SCOTT';

SELECT empno, ename, job, hiredate, sal,
      (SELECT dname FROM dept WHERE deptno = emp.deptno) dname,
      (SELECT loc FROM dept WHERE deptno = emp.deptno) loc
FROM emp
WHERE ename = 'SCOTT';
/*
    162page
    => 2개 이상의 테이블에서 데이터값 읽기 vuerd => 데이터베이스 설계 ==> dbleaver
    1) JOIN : 2개 이상의 테이블에 데이터를 추출하는 방법
              = 165page
                여러개의 테이블을 연결해서 하나의 테이블을 만들어가는 과정
                동등조인(equl join) ==> 연산자 사용시에 =를 사용한다
                WHERE 테이블명.컬럼 = 테이블명.컬럼
                ------------------------------- => 테이블과 테이블이 같은 값을 저장하고 있어야 조인이 가능
                ------------------------------- 단점 : null을 가지고 있으면 검색할 수 없다 (null을 포함하지 않는다)
                ------------------------------- 가장 많이 사용되는 조인이다
                회원 => 구매목록을 출력할 수 없다
                aaa 이름 나이           aaa A
                aaa 이름 나이           aaa B
                셀프조인 => 별칭
                구분 => 테이블, 별칭 (Natual JOIN, JOIN ~ USING에서는 별칭 사용 안함)
    2) SubQuery : 2개 이상의 SQL문장을 연결해서 처리
    INNER JOIN => INTERSECT (교집합)
    168page => outer join (innerJOIN + null을 포함해서 데이터를 가지고 온다)
      = LEFT OUTER JOIN ==> INTERSECT + MINUS (A-B)
        형식)
            = Oracle JOIN
              SELECT A.column, B.column
              FROM A, B
              WHERE A.column = B.column(+)
            = ANSI JOIN
              SELECT A.cloumn, B.column
              FROM A LEFT OUTER JOIN B
              ON  A.column = B.column
                   
      = RIGHT OUTER JOIN ==> INTERSECT + MINUS (B-A)
            =  = Oracle JOIN
              SELECT A.column, B.column
              FROM A, B
              WHERE A.column(+) = B.column
            = ANSI JOIN
              SELECT A.cloumn, B.column
              FROM A RIGHT OUTER JOIN B
              ON  A.column = B.column
              
      = FULL OUTER JOIN ==> UNION
            = ANSI JOIN
              SELECT A.cloumn, B.column
              FROM A FULL OUTER JOIN B
              ON  A.column = B.column
*/
-- SELECT * FROM emp;
-- SELECT * FROM dept;
CREATE TABLE test1(no NUMBER);
CREATE TABLE test2(no NUMBER);
INSERT INTO test1 VALUES(1);
INSERT INTO test1 VALUES(2);
INSERT INTO test1 VALUES(3);
INSERT INTO test1 VALUES(4);
INSERT INTO test2 VALUES(3);
INSERT INTO test2 VALUES(4);
INSERT INTO test2 VALUES(5);
INSERT INTO test2 VALUES(6);
COMMIT;
-- 합
SELECT no FROM test1
UNION ALL
SELECT no FROM test2;

SELECT no FROM test1
UNION
SELECT no FROM test2; -- 중복은 제거

SELECT no FROM test1
INTERSECT
SELECT no FROM test2; -- 같은값만 가져온다

SELECT no FROM test1
MINUS
SELECT no FROM test2;

SELECT no FROM test2
MINUS
SELECT no FROM test1;

-- right
SELECT ename, empno, job, hiredate, sal, dname, loc, dept.deptno
FROM emp, dept
WHERE emp.deptno(+) = dept.deptno;

SELECT ename, empno, job, hiredate, sal, dname, loc, dept.deptno
FROM emp RIGHT OUTER JOIN dept
ON emp.deptno = dept.deptno;

-- left
SELECT ename, empno, job, hiredate, sal, dname, loc, dept.deptno
FROM emp, dept
WHERE emp.deptno = dept.deptno(+);

SELECT ename, empno, job, hiredate, sal, dname, loc, dept.deptno
FROM emp LEFT OUTER JOIN dept
ON emp.deptno = dept.deptno;

-- ANSI JOIN으로 바꾸는법 ( , -> JOIN // WHERE -> ON)
/*
    169page (조인문법 외워야함)
*/