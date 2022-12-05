-- SQL (DML => 저장된 데이터를 조작하는 프로그램) => 검색, 추가, 수정, 삭제 (CURD)
/*
        DML (데이터 조작)
          = SELECT (데이터를 검색 => 추출)
          ** 컬럼명 확인 => DESC table명
          = 1) 형식)
               SELECT * | column1, column2 ...
               FROM table name (table 데이터 저장 공간)
               [
                    WHERE => 조건 검색
                    GROUP BY => 그룹으로 나눠서 그룹별 처리 (분기별, 부서별, 직위별)
                    HAVING 그룹 검색 => 반드시 GROUP BY가 있어서 사용이 가능 (단독적으로 사용이 불가능)
                    ORDER BY 정렬 (ASC/DESC)
               ]
            2) 조건 검색 (연산자)
               WHERE 조건절 (컬럼명 연산자 값)
                                  -----
               산술연산자 : SELECT 뒤에서 주로 사용한다 (+, -, *, /) => 정수/정수 => 실수 => ROW단위 통계 => 사용자 정의 함수
                           '10' => 자동으로 정수형으로 변경
                           +는 Only 산술만 할 수 있다, (문자열 결합 = ||)
                           => 오라클은 "" => ''
                           => ''를 사용해서 표현 = 문자열, 날짜형
               비교연산자 : = , != , <> , ^= , < , > , <= , >=
               논리연산자 : AND, OR ==> & : 입력값을 받을 때 사용
                                      || : 문자열 결합시 사용
               IN : OR가 여러개 사용될 경우에 사용
                    WHERE 컬럼명 IN(값, 값, 값..)
               LIKE : % (문자열을 알 수 없다), _ (한글자)
                      A% , %A , %A% , _A% , _A_
               BETWEEN : 기간, 범위 => 페이징 기법 ==>    >= AND <=
                     WHERE 컬럼명 BETWEEN 값 AND 값
                     ==> 날짜, 문자도 포함한다
                     ==> WHERE hiredate BETWEEN '81/01/01 AND '81/12/31';
                     ==> WHERE '81/01/01' <= hiredate AND hiredate <= '81/12/31';
                     ==> WHERE hiredate LIKE '81%';
                     ==> WHERE SUBSTA(hiredate, 1, 2) = 81;
               NOT : 부정 (예약일 아닌 날, 포함이 안된..)
                     NOT IN(), NOT BETWEEN, NOT LIKE
                     
               NULL : null 값일 경우는 연산처리를 하지 못한다
                      null값을 처리하는 연산자
                      1) null 일 경우 ======> IS NULL
                      2) null 값이 아닌 경우 ====> IS NOT NULL
            ------------------------------> 여기까지 배웠어!
            3) 내장 함수
            4) JOIN
            5) SubQuery
*/

-- 1. emp에서 급여가 2000 이상인 사람을 출력하세요.
SELECT * 
FROM emp 
WHERE sal >= 2000;

-- 2. emp에서 급여 sal가 2000 이상인 사람의 이름 ename과 사번 empno을 출력하세요.
SELECT ename, empno
FROM emp
WHERE sal >= 2000;

-- 3.?emp에서 이름이 'FORD'인 사람의 사번 empno과 급여 sal을 출력하세요
-- 문자열을 입력 ==> '' + 대소문자를 구분한다
SELECT empno, sal
FROM emp
WHERE ename = 'FORD';

-- 4.?emp에서 입사일자 hiredate가 82년 이후에 입사한 사람의?? 이름과 입사일자를 출력하세요.
-- (날짜를 넣을때는 YY/MM/DD형태를 사용하면된다.)
SELECT ename, hiredate 
FROM emp 
WHERE hiredate > '82/12/31';

-- 5.?emp에서 이름이 J가 들어가는 사원의 이름과 사번을 출력하세요.
SELECT ename, empno 
FROM emp 
WHERE ename LIKE '%J%';

-- 6.?emp에서 이름이 S로 끝나는 사원의 이름과 사번을 출력하세요.
SELECT ename, empno
FROM emp
WHERE ename LIKE '%S';

-- 7.?emp에서 이름의 두번째 글자가 A가 들어가는 사원의 이름과 사번을 출력하세요.
SELECT ename, empno
FROM emp
WHERE ename LIKE '_A%';

-- 8.?emp에서 보너스가 300이거나 500이거나 1400인 사람의??? 이름, 사번, 보너스를 출력하세요.
SELECT ename, empno, comm
FROM emp
WHERE comm IN(300, 500, 1400);

-- 9.?emp에서 보너스가 500에서 4000 사이의 사원의 이름과 사번, 보너스를 출력하세요.
SELECT ename, empno, comm
FROM emp
WHERE 500 <= comm AND comm <= 4000;

-- 10.?emp에서 부서가 10이고 직책이 CLERK인 직원이름,사번,직책(job),부서(deptno)를 출력하세요.
SELECT ename, empno, job, deptno
FROM emp
WHERE job = 'CLERK' AND deptno = 10;

-- 11.?emp에서 입사일자가 82년 이후이거나 직책이 MANAGER인 사람의 이름과 입사일자를 출력하세요.
SELECT ename, hiredate
FROM emp
WHERE hiredate > '82/12/31' OR job = 'MANAGER';

-- 12.?emp에서 부서번호가 10이 아닌 직원의 사번,이름,부서번호를 출력하세요.
-- 프로그래머 !=
SELECT empno, ename, deptno
FROM emp
WHERE deptno <> 10;

-- 13.?emp에서 이름에 A가 없는 직원의 사번과 이름을 출력하세요.
SELECT empno, ename
FROM emp
WHERE ename NOT LIKE '%A%';

-- 14.?emp에서 보너스가 500에서 1400이 아닌 직원의 사번과 보너스를 출력하세요.
SELECT empno, comm
FROM emp
WHERE comm NOT BETWEEN 500 AND 1400 AND comm <> 0;

-- 15.?emp에서 매니저를 갖지 않은 직원이름을 출력하세요.
-- null값은 is null로 표현한다.
SELECT ename
FROM emp
WHERE mgr IS NULL;

-- 16. emp에서 커미션을 받는(커미션이 null값이 아닌) 직원이름과 커미션을 출력하세요.
SELECT ename, comm
FROM emp
WHERE comm IS NOT NULL AND comm <> 0;

SELECT DISTINCT job FROM emp;
-- ||, 컬럼 "별칭", 컬럼 as 별칭 129 ~ 155page