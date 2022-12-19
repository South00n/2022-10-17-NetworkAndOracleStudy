/*
       1. FUNCTION : 함수 => 리턴형이 있는 함수 (결과값은 1개만) => 내장함수
          => SELECT ~~ => 컬럼대신 사용, WHERE 조건문으로 사용이 가능
          => ROW단위 (단일행 함수)
          형식)
                CREATE [OR REPLACE] FUNCTION func_name(
                    매개변수 ...
                )
                IS
                    지역변수 설정
                BEGIN
                    구현부
                END;
                /
            ****** 프로시저 vs 트리거
            -----------------------
        2. PROCEDURE : 프로시저 => 리턴형이 없는 함수 (기능 수행) => 오라클의 함수 (프로시저)
          => 반복 수행, 여러개 => 카페 (게시판)
          => 포인터 사용
             IN, OUT ==> 값을 전송할때 매개변수를 이용한다 (변수의 주소값을 전송), IN OUT
          => 형식)
             CREATE [OR REPLACE] PROCEDURE pro_name (
                매개변수 ...
             )
             IS
                지역변수
             BEGIN
                구현부
             END;
             /
*/

-- FUNCTION 제작 
SELECT empno, ename, job, hiredate, sal, comm, dname, loc, grade
FROM emp, dept, salgrade
WHERE emp.deptno = dept.deptno
AND sal BETWEEN losal AND hisal;

SELECT empno, ename, job, hiredate, sal, comm,
        (SELECT dname FROM dept WHERE deptno = emp.deptno) dname,
        (SELECT loc FROM dept WHERE deptno = emp.deptno) loc,
        (SELECT grade FROM salgrade WHERE emp.sal BETWEEN losal AND hisal ) grade
FROM emp;

CREATE OR REPLACE FUNCTION getDname(
    vDeptno emp.deptno%TYPE
    
) RETURN VARCHAR2 -- 데이터형만
IS
    vDname dept.dname%TYPE;
BEGIN
    SELECT dname INTO vDname
    FROM dept
    WHERE deptno = vDeptno;
    RETURN vDname;
END;
/

CREATE OR REPLACE FUNCTION getLoc(
    vDeptno emp.deptno%TYPE
    
) RETURN VARCHAR2 -- 데이터형만
IS
    vLoc dept.loc%TYPE;
BEGIN
    SELECT loc INTO vLoc
    FROM dept
    WHERE deptno = vDeptno;
    RETURN vLoc;
END;
/
-- 단일행 서브쿼리, JOIN에서 다른 테이블 데이터 읽기 ==> FUNCTION
-- 항상 => 반복이 되는 경우 , 재사용이 필요할 때
-- 데이터값(리턴값)을 한개만 설정할 수 있다

CREATE OR REPLACE FUNCTION getGrade(
    vSal emp.sal%TYPE
) RETURN NUMBER
IS
    vGrade salgrade.grade%TYPE;
BEGIN
    SELECT grade INTO vGrade
    FROM salGrade
    WHERE vSal BETWEEN losal AND hisal;
    RETURN vGrade;
END;
/
-- 사용
SELECT empno, ename, job, hiredate, sal, getDname(deptno) dname, getLoc(deptno) loc, getGrade(sal) grade
FROM emp;

SELECT empno, ename, job, hiredate, sal
FROM emp
WHERE sal > (SELECT ROUND(AVG(sal)) FROM emp);

CREATE OR REPLACE FUNCTION getAvg
RETURN NUMBER
IS
    vAvg NUMBER;
BEGIN
    SELECT ROUND(AVG(sal)) INTO vAvg
    FROM emp;
    RETURN vAvg;
END;
/

SELECT empno, ename, job, hiredate, sal
FROM emp
WHERE sal > getAvg();


CREATE OR REPLACE FUNCTION getMax
RETURN NUMBER
IS
    vMax NUMBER; -- IS안에 변수
BEGIN
    SELECT MAX(empno) + 1 INTO vMax
    FROM emp;   
    RETURN vMAX;
END;
/

DROP FUNCTION getAvg;
DROP FUNCTION getDname;
DROP FUNCTION getGrade;
DROP FUNCTION getLoc;
DROP FUNCTION getMax;


