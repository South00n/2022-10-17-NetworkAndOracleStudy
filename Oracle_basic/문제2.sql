/*
GROUP BY 문제
----------- 운영자 => 일별 판매량, 월별 예매량
            같은 값을 가지고 있는 그룹을 묶어서 그룹별처리를 따로 하는 SQL
            SELECT ~ ==> 5
            FROM ============== 1
            WHERE ============= 2
            GROUP BY 컬럼명|함수 === 3
            => 조건이 있는 경우 => HAVING == 4
            ORDER BY == 6
*/
-- GROUP BY 문제
-- 1. 각 부서별로 최대 급여를 구하세요.
SELECT deptno, MAX(sal)
FROM emp
GROUP BY deptno
ORDER BY deptno;

-- 이중 그룹
SELECT deptno, TO_CHAR(hiredate, 'YYYY'), MAX(sal)
FROM emp
GROUP BY deptno, TO_CHAR(hiredate, 'YYYY')
ORDER BY deptno;

-- 2. 각 직급(job)별로 최대 급여를 구하세요. 
SELECT job, MAX(sal)
FROM emp
GROUP BY job;

-- 3. 각 부서별로 평균 급여를 구하세요.
SELECT deptno, ROUND(AVG(sal))
FROM emp
GROUP BY deptno;

-- 집합함수 : COUNT() , AVG , SUM , MAX , MIN => 단일행 함수, 일반 컬럼과 같이 사용할 수 없다
--           ------------------------------- 일반 컬럼과 동시에 사용 => GROUP BY 사용
--           => 전체를 대상으로 통계는 가능(세로), 개인당으로 통계할 수 없다(ROW) => 사용자 정의로 제작
-- 4. 각 직급(job)별의 인원수를 구하세요.
SELECT job, COUNT(job)
FROM emp
GROUP BY job;

-- 5. 각 부서별 보너스(comm)을 받는  인원수 출력 . 
SELECT deptno, COUNT(comm)
FROM emp
WHERE comm IS NOT NULL
GROUP BY deptno;

-- 6. 각 년도별로 입사한 인원수를 구하세요.
SELECT TO_CHAR(hiredate, 'YYYY'), COUNT(*)
FROM emp
GROUP BY TO_CHAR(hiredate, 'YYYY');

SELECT TO_CHAR(hiredate, 'day'), COUNT(*), SUM(sal), ROUND(AVG(sal))
FROM emp
GROUP BY TO_CHAR(hiredate, 'day');

-- 7.  부셔별 평균급여를 구하고 그 결과 평균급여가 2000 이상인 부서만 출력하세요.
SELECT deptno, ROUND(AVG(sal))
FROM emp
GROUP BY deptno
HAVING AVG(sal) >= 2000;

-- WHERE => 그룹 함수를 사용할 수 없다, 그룹함수를 사용시에는 HAVING을 이용한다

-- JOIN 문제 (Oracle JOIN, ANSI JOIN, SubQuery, 자바로 읽기 -> 한 문제로 이렇게 네개 공부해봐!!)
-- 1. 사원 이름이 SCOTT인 사원의 사번(empno), 이름(ename), 부서명(dname)를 출력하세요.
SELECT e.empno, e.ename, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno AND e.ename = 'SCOTT';

SELECT empno, ename, (SELECT dname FROM dept WHERE deptno = emp.deptno) dname
FROM emp
WHERE ename = 'SCOTT';

-- 2. 사원이름과 급여(sal)와 급여등급(grade)을 출력하세요.
SELECT ename, sal, grade
FROM emp, salgrade
WHERE sal BETWEEN losal AND hisal; -- NON EQUI_JOIN 구간사이에 있을때 grade를 가져온다 (=을 사용하지 않는 경우 => 비등가조인)

SELECT ename, sal, grade -- ANSI JOIN
FROM emp JOIN salgrade
ON sal BETWEEN losal AND hisal;

SELECT ename, sal, (SELECT grade FROM salgrade WHERE emp.sal BETWEEN losal AND hisal) "grade"
FROM emp;

-- 3. 위 2번문제에서 부서명을 추가시켜 출력하세요.
SELECT ename, sal, grade, dname
FROM emp, salgrade, dept
WHERE dept.deptno = emp.deptno AND sal BETWEEN losal AND hisal;

--ANSI JOIN
SELECT ename, sal, grade, dname
FROM emp JOIN salgrade
ON sal BETWEEN losal AND hisal
JOIN dept
ON emp.deptno = dept.deptno;

-- SubQuery
SELECT ename, sal, (SELECT grade FROM salgrade WHERE emp.sal BETWEEN losal AND hisal) grade,
(SELECT dname FROM dept WHERE deptno = emp.deptno) dname
FROM emp;

SELECT sal, grade, dname
FROM emp NATURAL JOIN dept --> 비교하는 같은 컬럼명을 가지고 있는 경우에 사용 (자연 조인)
JOIN salgrade
ON sal BETWEEN losal AND hisal;

SELECT sal, grade, dname
FROM emp JOIN dept USING(deptno)
JOIN salgrade
ON sal BETWEEN losal AND hisal;

    -- ==> Oracle JOIN, ANSI JOIN, Subquery
    --     --------------------------------- 각각 변형시킬 수 있어야해!
    
-- 4. 사원이름과 매니저의 이름을 아래와 같은 형식으로 출력하세요.
--    "XXX"의 매니져는 "XXX" 입니다. => SELF JOIN
SELECT e1.ename || '의 매니져는 ' || e2.ename || '입니다.'
FROM emp e1, emp e2 -- 같은 테이블로 이용 --> 별칭을 이용해서 구분 (Natural JOIN, JOIN USING 사용할 수 없다)
WHERE e1.mgr = e2.empno;
----- 컬럼명은 달라도 같은 값을 가지고 있으면 비교가 된다

-- ANSI JOIN (표준화)
SELECT e1.ename || '의 매니져는 ' || e2.ename || '입니다.'
FROM emp e1 INNER JOIN emp e2 -- INNER는 생략이 가능
ON e1.mgr = e2.empno;

-- SUBQUERY
SELECT e1.ename || '의 매니져는 ' || (SELECT ename FROM emp WHERE e1.mgr = empno) || '입니다.'
FROM emp e1;

-- 5. 부서번호가 30번인 사원들의 이름, 직급(job), 부서번호(deptno), 부서위치(loc)를 출력하세요.
                              ----------------------------- emp ---------- dept
SELECT ename, job, emp.deptno, loc
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND emp.deptno = 30;

SELECT ename, job, e.deptno, loc
FROM emp e JOIN dept d
ON e.deptno = d.deptno AND e.deptno = 30;

SELECT ename, job, deptno, (SELECT loc FROM dept WHERE deptno = emp.deptno) loc
FROM emp
WHERE deptno = 30;


-- 6. 보너스(comm)을 받은사원의 이름, 보너스, 부서명, 부서위치를 출력하세요.
SELECT ename, comm, dname, loc
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND comm IS NOT NULL AND comm <> 0;

-- ANSI JOIN
SELECT ename, comm, dname, loc
FROM emp JOIN dept
ON emp.deptno = dept.deptno
AND comm IS NOT NULL AND comm <> 0;

-- SUBQUERY
SELECT ename, comm, (SELECT dname FROM dept WHERE deptno = emp.deptno) dname, 
(SELECT loc FROM dept WHERE deptno = emp.deptno) loc
FROM emp
WHERE comm IS NOT NULL AND comm <> 0;

-- 7. DALLAS에서 근무하는 사원들의 이름, 직급, 부서번호, 부서명을 출력하세요.
SELECT ename, job, emp.deptno, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND loc = 'DALLAS';

-- ANSI JOIN
SELECT ename, job, emp.deptno, dname
FROM emp JOIN dept
ON emp.deptno = dept.deptno
AND loc = 'DALLAS';

-- SUBQUERY
SELECT ename, job, e.deptno, (SELECT dname FROM dept WHERE deptno = e.deptno) dname
FROM emp e
WHERE (SELECT loc FROM dept WHERE deptno = e.deptno) = 'DALLAS';
-- WHERE deptno = (SELECT deptno FROM dept WHERE loc = 'DALLAS');

-- 8. 이름에 'A'가 들어가는 사원들의 이름과 부서명을 출력하세요.
SELECT ename, dname
FROM emp, dept
WHERE ename LIKE '%A%' AND emp.deptno = dept.deptno;

SELECT ename, dname
FROM emp, dept
WHERE REGEXP_LIKE(ename,'A') AND emp.deptno = dept.deptno;
-- REGEXP_LIKE(ename, 'A|B|C|D|E')

-- ANSI JOIN
SELECT ename, dname
FROM emp JOIN dept
ON ename LIKE '%A%' AND emp.deptno = dept.deptno;

-- SUBQUERY
SELECT ename, (SELECT dname FROM dept WHERE deptno = emp.deptno) dname
FROM emp
WHERE ename LIKE '%A%';
/*
    오버라이딩 vs 오버로딩
    추상클래스 vs 인터페이스
    캡슐화 vs 은닉화
    동기화 vs 비동기화
    예외복구 vs 예외회피
    ArrayList vs Vector
    DAO vs Service
    GET vs POST
    OOP vs AOP
    AOP vs 인터셉트
    
*/
-- JOIN과 SUBQUERY 차이
-- 데이터처리 or SQL문장처리
-- 여러개의 테이블에서 필요한 데이터를 추출 (JOIN)
-- 여러개의 SQL문장을 통합해서 한번에 실행할 목적 (서브쿼리) => 자바에서 주로사용
-- SUBQUERY 문제
-- 1. SCOTT의 급여와 동일하거나 더 많이 받는 사원의 이름과 급여를 출력하세요.
SELECT ename, sal
FROM emp
WHERE sal >= (SELECT sal FROM emp WHERE ename = 'SCOTT');

-- 2. 직급(job)이 'CLERK'인 사람의 부서의 부서번호와 부서명을 출력하세요.
SELECT deptno, dname
FROM dept
WHERE deptno IN (SELECT deptno FROM emp WHERE job = 'CLERK');

-- 3. 이름에 T를 포함하고 있는 사원들과 같은부서에서 근무하는 사원의 사번과 이름을 출력하세요
SELECT empno, ename
FROM emp
WHERE deptno IN (SELECT deptno FROM emp WHERE ename LIKE '%T%');
-- => 먼저 실행되는 SQL(서브쿼리)
-- 예)
-- 급여의 평균보다 많이 받는 사원의 모든 정보
SELECT *
FROM emp
WHERE sal > (SELECT AVG(sal) FROM emp); 

-- 4. 부서위치(loc)가 DALLAS인 모든 사원의 이름, 부서번호를 출력하세요
SELECT ename, deptno
FROM emp
WHERE deptno = (SELECT deptno FROM dept WHERE loc = 'DALLAS');


-- 5. SALES 부서의 모든사원의 이름과 급여를 출력하세요
SELECT ename, sal
FROM emp
WHERE deptno = (SELECT deptno FROM dept WHERE dname = 'SALES');

-- 6. 자신의 급여가 평균 급여보다 많고 이름에 S가 들어가는 사원과
--    동일한 부서에서 근무하는 모든 사원의 이름, 급여를 출력하세요
-- 170 page
SELECT AVG(sal) FROM emp;

SELECT deptno
FROM emp
WHERE ename LIKE '%S%'
AND sal >= 2073;

SELECT ename, sal
FROM emp
WHERE deptno = 20;

SELECT ename, sal
FROM emp
WHERE deptno in (SELECT deptno FROM emp WHERE sal > (SELECT AVG(sal) FROM emp) AND ename LIKE '%S%');

-- 7. 평균 급여보다 더 많은 급여를 받는 사원의 이름, 사번, 급여를 검색하되 급여가 많은 순서로나열하세요.
SELECT ename, empno, sal
FROM emp
WHERE sal > (SELECT AVG(sal) FROM emp)
ORDER BY sal DESC;




--2. 직급(job)이 'CLERK'인 사람의 부서의 부서번호와 부서명을 출력하세요.
select deptno, dname
from dept
where deptno in (select deptno from emp where job = 'CLERK');


SELECT ename, job, e.deptno, dname
FROM emp e, dept d
WHERE e.deptno = d.deptno AND job = 'CLERK';

SELECT ename, job, deptno, (SELECT dname FROM dept WHERE deptno = e.deptno)
FROM emp e
WHERE job = 'CLERK';

SELECT fno, name
FROM food_location
ORDER BY fno ASC;

-- 인라인뷰 (테이블 대신 사용) => Top-N 방식이라 중간추출 불가능
-- 2번 사용하면 중간추출 가능
SELECT fno, name, num
FROM (SELECT fno, name, rownum as num FROM  
     (SELECT fno, name FROM food_location ORDER BY fno ASC))
WHERE num BETWEEN 21 AND 30;
