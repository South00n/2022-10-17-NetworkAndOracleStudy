/*
    CHR(65) ==> 숫자 문자로 변경
*/

-- SELECT CHR(65) FROM DUAL;
-- HAVING : 그룹별 조건을 사용할 때 ==> 반드시 GROUP BY가 있는 경우에만 사용이 가능
-- 직위별 그룹 => 인원수, 급여합, 급여평균, 전체 급여의 평균보다 높은 급여만 출력
SELECT ROUND(AVG(sal)) FROM emp; -- 2073
SELECT job, COUNT(*), SUM(sal), ROUND(AVG(sal))
FROM emp
GROUP BY job
HAVING AVG(sal) > 2073;

SELECT job, COUNT(*), SUM(sal), ROUND(AVG(sal))
FROM emp
GROUP BY job
HAVING AVG(sal) > (SELECT ROUND(AVG(sal)) FROM emp);
-- 서브쿼리 SQL문장을 여러개 묶어서 한번에 처리 (부속질의)

-- 년도별 ==> 인원이 두명이상 => 인원수, 급여최대, 급여최소
SELECT TO_CHAR(hiredate, 'YYYY'), COUNT(*), MAX(sal), MIN(sal)
FROM emp
GROUP BY TO_CHAR(hiredate, 'YYYY')
HAVING COUNT(*) > 1;
/*
      JOIN
       한개이상의 테이블에서 출력에 필요한 데이터를 추출하는 기법
       = 종류
          1) INNER JOIN ==> 교집합 (같은 값을 가지고 있는 경우 처리) => 단점 : NULL을 경우에는 처리하지 못한다
             = EQUI_JOIN => 연산자 (=) => 
                = Oracle JOIN
                  SELECT A.cloumn, B.cloumn
                  FROM A, B
                  WHERE A.cloumn = B.column
                = ANSI JOIN
                  SELECT A.cloumn, B.cloumn
                  FROM A (INNER)JOIN B
                         ------- 생략이 가능
                  ON A.column = B.column
                  ------> column 구분 => 테이블명.컬럼, 별칭.컬럼 => 컬럼명이 다른 경우에는 생략
                                      => 컬럼명이 같은 경우에 생략하면 "애매한 정의"라는 에러 발생
             = NON_EQUI_JOIN => 연산자 (= 연산자 외의 다른 연산자 사용) => 포함 (BETWEEN, 비교연산자, 논리연산자)
                = Oracle JOIN
                = ANSI JOIN
             --------------------------------
             = NATURAL JOIN => 자연조인 
             = JOIN ~ USING
             -------------------------------- 반드시 같은 컬럼명이 있어야 한다
          2) OUTER JOIN => INNERJOIN + @ ==> 교집합 + 차집합 => NULL일 경우에도 처리한다
             = LEFT OUTER JOIN
                = Oracle JOIN
                = ANSI JOIN
             = RIGHT OUTER JOIN
                = Oracle JOIN
                = ANSI JOIN
             = FULL OUTER JOIN
                = ANSI JOIN
          3) SELF JOIN (같은 테이블에서)
*/
/*
SELECT empno, ename, job, hiredate, sal, deptno
FROM emp;

SELECT * FROM dept;*/

-- 사번, 이름, 직위, 입사일, 급여, 부서명, 근무지, 부서번호
-- ------------------------ emp ------------- dept
SELECT empno, ename, job, hiredate, sal, dname, loc, dept.deptno
FROM emp, dept
WHERE emp.deptno = dept.deptno;
-- 테이블 별칭을 사용한 경우
-- 동등조인
SELECT empno, ename, job, hiredate, sal, dname, loc, e.deptno
FROM emp e, dept d
WHERE e.deptno = d.deptno;
-- ANSI JOIN => 표준화 (모든 데이터베이스 통일 => Oracle, MS_SQL, MYSQL...)
SELECT empno, ename, job, hiredate, sal, dname, loc, emp.deptno
FROM emp JOIN dept
ON emp.deptno = dept.deptno;

SELECT empno, ename, job, hiredate, sal, dname, loc, e.deptno
FROM emp e JOIN dept d
ON e.deptno = d.deptno;
-- 테이블과 테이블에 같은 컬럼명이 있는 경우만 처리가 가능 => 자연조인
SELECT empno, ename, job, hiredate, sal, dname, loc, deptno
FROM emp NATURAL JOIN dept;
-- JOIN ~ USING
SELECT empno, ename, job, hiredate, sal, dname, loc, deptno
FROM emp JOIN dept USING (deptno);
----------------------------------------- SELF JOIN (같은 테이블) => 별칭을 이용한다
SELECT e1.ename "본인", e2.ename "사수"
FROM emp e1, emp e2
WHERE e1.mgr = e2.empno;
SELECT * FROM emp;
-- 조건 수행 ==> 이름중에 A를 포함하고 있는 사원의 이름, 직위, 부서명, 근무지
-- 조인의 조건 ==> 양쪽 테이블에서 같은 값을 가지고 있는 데이터(컬럼명은 관계없다)
/*
    게시판         댓글
     게시물번호     댓글번호
                   게시물번호
*/
SELECT * FROM dept;