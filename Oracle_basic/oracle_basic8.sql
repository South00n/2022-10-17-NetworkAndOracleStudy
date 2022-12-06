/*
        집합함수 (집계함수) => COLUMN단위로 계산
        ------------------------------------
        ***** COUNT() 갯수 출력 => 저장된 ROW의 갯수
         ------
           COUNT(*) ==> NULL을 포함
           COUNT(column) ==> NULL을 포함하지 않는다
           ------------------------------------- 검색결과, 페이지, 아이디 중복, 로그인, 장바구니 확인 ...
           1
           2
           3
           4
           5
           --
           6
           --
           7
        ***** MAX() : 최대값 => 자동 증가번호 MAX() + 1
        MIN() : 최소값
        SUM() : 합
        AVG() : 평균
        ------------------------------------------------- 집계함수, 분석함수 => 컬럼하고 같이 사용이 가능
        RANK() : 건너뛰고
            1
            2
            2
            4
        DENSE_RANK() : 순차적으로
            1
            2
            2
            3
        CUBE()
        ROLLUP()
        -------------------------- 단일행함수, 단일 컬럼과 같이 사용할 수 없다
        SELECT AVG(sal), ename ~~ 오류
               --- 집계  ------ 단일 컬럼
               => 집계함수는 GROUP BY와 같이 사용이 가능
*/
SELECT COUNT(comm), COUNT(mgr), COUNT(*) FROM emp;
SELECT * FROM emp;
/*
CREATE TABLE my2(
    no NUMBER PRIMARY KEY,
    name VARCHAR2(20)
);
INSERT INTO my2 VALUES(1,'aaa');
INSERT INTO my2 VALUES((SELECT MAX(no) + 1 FROM my2), 'bbb');

SELECT * FROM my2; 
*/
-- 급여 합, 평균 (import)
SELECT SUM(sal) "합", ROUND(AVG(sal),2) "평균"
FROM emp;

-- 급여 최대, 최소
SELECT MAX(sal), MIN(sal) FROM emp;

-- rank
SELECT ename, hiredate, sal, DENSE_RANK() OVER(ORDER BY sal DESC) rank
FROM emp;

/*
       인기순위, 노래, 영화
*/
-- GROUP BY => 157page
-- job, hiredate, deptno
SELECT * FROM emp
ORDER BY deptno ASC;

SELECT sum(sal), avg(sal), count(*)
FROM emp
WHERE deptno = 10;

SELECT sum(sal), avg(sal), count(*)
FROM emp
WHERE deptno = 20;

SELECT sum(sal), avg(sal), count(*)
FROM emp
WHERE deptno = 30;

-- 그룹별 통계 GROUP BY => 집계함수와 사용이 가능
-- 그룹별로 별도로 통계가 가능
SELECT deptno, sum(sal), round(avg(sal),2), count(*)
FROM emp
GROUP BY deptno
ORDER BY deptno ASC;

-- 입사연도별 => 인원수, 급여합, 급여평균, 최대급여, 최소급여
SELECT TO_CHAR(hiredate, 'YYYY'), count(*) "인원수", sum(sal) "급여합", avg(sal) "급여평균", max(sal) "최대급여", min(sal) "최소급여"
FROM emp
GROUP BY TO_CHAR(hiredate, 'YYYY')
ORDER BY TO_CHAR(hiredate, 'YYYY');

SELECT SUBSTR(hiredate,1,2), count(*) "인원수", sum(sal) "급여합", avg(sal) "급여평균", max(sal) "최대급여", min(sal) "최소급여"
FROM emp
GROUP BY SUBSTR(hiredate,1,2)
ORDER BY SUBSTR(hiredate,1,2);