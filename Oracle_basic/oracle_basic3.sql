/*
      SQL 기초 (3장)
      => 테이블 설치 (emp, dept)
      => SQLDevleoper, XE
      => SQL소개
         DML, DDL, DCL, TCL
         --- SELECT, INSERT, UPDATE, DELETE, MERGE
             ------ 데이터 추출
             
      145page
       => SELECT 문법
          1) 형식
             SELECT [ALL|DISINCT] * | coulumn1, column2...
             FROM table_name|view_name|SELECT~
             ---------------------------------------------
             {
                WHERE 조건절 (컬럼명, 연산자 값)
                GROUP BY 그룹컬럼|함수
                HAVING 그룹에 대한 조건 ==> GROUP BY가 없는 경우에는 사용할 수 없다
                ORDER BY 컬럼 (ASC|DESC) => ASC는 생략이 가능
             }
        2) 별칭 => 컬럼, 테이블
                  컬럼 "", 컬럼 as 별칭
                  ------  -----------
        3) 문자열 결합 ==> || *** 오라클의 문자열, 날짜표현 ''
        4) 중복없는 데이터를 출력 : DISTINCT 컬럼명
                                ---------------
       => 연산자 처리 / 내장함수 / 응용
       *** 참조 ==> FROM table_name
           ==> 연습용 테이블 : DUAL (산술처리가 가능)
       1) 산술연산자 => 주로 SELECT 뒤에 붙여서 사용
          +, -, *, / ==> 문자열을 연산처리하면 오류 발생 ==> ||
                     ==> /는 0으로 나눌 수 없다, 정수/정수 = 실수
                     ==> 컬럼의 값이 없는 경우 => NULL은 연산처리가 안된다
                     null + 1 = null
       ---------------------- 조건 검색시에 사용
       2) 비교연산자 : =(같다), != , <> , ^= (같지 않다), < , > , <= , >=   ==> true/false
                                   -- 오라클개발자
                              -- 프로그래머
                                   
       3) 논리연산자 : AND , OR
                      && : Scanner : 입력값을 받는 경우에 사용
                      || : 문자열 결합
       4) 대입연산자 : =
          ------------- WHERE, HAVING외에 다른 곳에서 사용
                        ------------- 조건문 (=같다)
          예) SELECT * FROM emp WHERE empno = 7788
                                      ------------ 같다(비교연산자)
              UPDATE emp SET
              ename = '홍길동'; ----- 대입연산자
       ----------------- ↓ 오라클에서만 쓰는 연산자
       5) NOT 연산자 : 부정 (!를 사용하면 안된다) 
                      NOT LIKE , NOT BETWEEN , NOT IN
                      NOT (연산처리)
       6) NULL 연산자 : 값이 존재하지 않는다 (연산처리를 할 수 없다)
            = IS NULL => NULL 일 경우
            = IS NOT NULL => NULL값이 아닌 경우
       7) IN 연산자 ==> OR가 여러개일 경우에 처리하는 연산자
          WHERE deptno = 10 OR deptno = 20 OR deptno = 30 OR deptno = 40
          WHERE deptno IN(10, 20, 30, 40)
       8) BETWEEN ~ AND : 기간이나 범위를 나타내준다
          BETWEEN 1 AND 10 ==> 둘 다 
          >=1 AND <=10
          ------------------- 체크인, 예약가능 날, 페이지 나누기
       9) LIKE => 유사문자열 검색 (검색)
                  % : 문자열 갯수를 모르는 경우
                      'A%' => A로 시작하는 모든 문자열 (startsWith)
                      '%A' => A로 끝나는 모든 문자열 (endsWith)
                      '%A%' => A가 포함된 모든 문자열 ==> 사용 빈도가 많다 (contains)
                  _ : 한글자
                      __A__ ==> 5글자 -> 가운데 A가 포함되어 있다
                      __A%  ==> 3번째 자리가 A인 모든 글자
                  REGEXP_LIKE (정규식)
       ---------------------- WHERE, HAVING에서 주로 사용 => true/false
*/

SELECT 10+2, 10-2, 10*2, 10/3
FROM DUAL;
SELECT 10+2, 10-2, 10*2, 10/0
FROM DUAL;
-- 숫자가 문자열로 묶인 경우에 자동 => 정수형으로 변환
-- 자동 Integer.parseInt() 실행
SELECT '10'+2, 10-2, 10*2, 10/3
FROM DUAL;
SELECT ' 10'+2, 10-2, 10*2, 10/3 -- 공백이있어도 처리가능 trim()
FROM DUAL;
-- NULL값인 경우에 대른 값을 대체
SELECT ename, sal + NVL(comm, 0) "실제급여"
FROM emp;
-- % => 나머지는 함수 ==> MOD(10, 2) => 10%2 

SELECT * FROM emp
WHERE empno = &sabun;
-- 산술 연산자
/*
        오라클 => 도메인단위로는 통계가 가능 (세로)
                 튜플단위는 통계가 없다 (가로) ===> 산술연산자를 이용해서 처리
*/
CREATE TABLE student(
    name VARCHAR2(34),
    kor NUMBER,
    eng NUMBER,
    math NUMBER
);
SELECT * FROM student;
INSERT INTO student VALUES('홍길동', 89, 78, 67);
INSERT INTO student VALUES('심청이', 78, 76, 90);
INSERT INTO student VALUES('박문수', 90, 90, 78);
COMMIT;
-- 산술 연산
SELECT name, kor, eng, math, kor + eng +math "total", (kor + eng + math) / 3 "avg"
FROM student;

-- 비교연산자
SELECT ename, sal FROM emp;
-- = 같다 (emp에서 급여가 3000인 사원의 이름, 직위, 입사일, 급여)
SELECT ename, job, hiredate, sal
FROM emp
WHERE sal = 3000;
-- <> 같지 않다 (emp에서 급여가 3000이 아닌 사원의 이름, 직위, 입사일, 급여)
SELECT ename, job, hiredate, sal
FROM emp
WHERE sal <> 3000;

SELECT ename, job, hiredate, sal
FROM emp
WHERE sal != 3000;

SELECT ename, job, hiredate, sal
FROM emp
WHERE sal ^= 3000;

-- 작다 < ==> 2500미만인 사원의 모든 정보 출력
SELECT *
FROM emp
WHERE sal < 2500;
-- 비교연산자 => 문자, 날짜도 비교연산자를 사용한다
-- 날짜 ==> YY/MM/DD   81/01/01
-- 81년 이후에 입사한 사원의 모든 정보를 출력
SELECT *
FROM emp
WHERE hiredate > '81/12/31'; -- '' (문자열형식으로 저장)
-- WHERE 문장은 자바 if동일 ==> true일때 처리
/*
    SQL문장 => SELECT
    for (int i = 0; i < emp.length; i++) {
        Where
        if(hiredate > '81/12/31') {
        }
    }
*/
-- 81년에 입사한 사원의 모든 정보 출력
/*SELECT *
FROM emp
WHERE hiredate >= '81/01/01' AND hiredate <= '81/12/31'; */
-- <= , >=
-- 급여가 1500이상인 사원의 이름, 급여
SELECT ename, sal
FROM emp
WHERE sal >= 1500;

-- 급여가 3000이하인 사원의 이름, 급여, 직위
SELECT ename, sal, job
FROM emp
WHERE sal <= 3000;

-- KING보다 높은 이름을 가진 사원의 이름, 급여, 직위
SELECT ename, sal, job
FROM emp
WHERE ename > 'KING';
-- 주의점 => 문자가 들어간 경우 대소문자를 구분
-- king의 모든 정보를 가지고 온다
SELECT *
FROM emp
WHERE ename = UPPER('king');

SELECT *
FROM emp
WHERE ename = 'KING';
-- 자바에서 대문자로 변경후에 오라클로 전송 (toUpperCase())
-- 논리연산자 (OR, AND)
/*
            AND : 직렬
            (조건) AND (조건)  => true and ture 일때만 true가 되는 연산자 => 범위, 기간이 포함시 처리
            OR : 병렬
            (조건) OR (조건)  => 둘중 1개가 true면 true가 되는 연산자 => 범위밖에 있는 경우
            
            --------------------------------------------
                            AND(이고)        OR(이거나)
            --------------------------------------------
            true   true     true            true
            --------------------------------------------
            true   false    false           true
            --------------------------------------------
            false  true     false           true
            --------------------------------------------
            false  false    false           false
            --------------------------------------------
*/
-- OR 연산자 => IN연산자 대체가 가능
-- AND연산자 => BETWEEN 대체가 가능

-- AND ==> 1500이상 3000이하인 급여를 받는 사원의 모든 정보 출력
SELECT *
FROM emp
WHERE 1500 <= sal AND sal <= 3000;

-- 1500이거나 3000인 사원의 모든 정보
SELECT *
FROM emp
WHERE sal = 1500 OR sal = 3000;

-- 부서번호가 30번인 사원의 모든 정보 + 20사원 포함
SELECT *
FROM emp
WHERE deptno = 30 OR deptno = 20;

-- NULL 연산자 ==> 값 null일 경우에는 연산처리가 안된다
-- IS NULL (comm = null), IS NOT NULL
-- comm 성과급 ==> 성과급을 받는 사원의 모든 정보
SELECT *
FROM emp
WHERE comm IS NOT NULL AND comm <> 0;
-- WHERE comm IS NULL OR comm <> 0; 성과급 없는사람들

-- IN연산자 => OR가 여러개일 경우에 처리
-- 급여가 5000, 2850, 1500, 3000, 950을 받는 사원의 모든 정보
SELECT *
FROM emp
WHERE sal = 5000 OR sal = 2850 OR sal = 1500 OR sal = 3000 OR sal = 950;

SELECT *
FROM emp
WHERE sal IN (5000, 2850, 1500, 3000, 950);
-- 문자
-- 직위가 MANAGER, CLERK, SALESMAN
SELECT *
FROM emp
WHERE job NOT IN ('MANAGER', 'CLERK', 'SALESMAN');
-- BETWEEN AND ==> >= AND <=
-- 문자, 숫자, 날짜 가능
-- 급여가 1500 ~ 3000 사이에 있는 사원의 모든 정보
SELECT *
FROM emp
WHERE 1500 <= sal AND sal <= 3000;
-- 웹 (페이징)
SELECT *
FROM emp
WHERE sal BETWEEN 1500 AND 3000;
-- NOT IN, NOT BETWEEN, NOT LIKE
-- 연산자중에 가장 많이 사용되는 연산자 ==> LIKE ==> 모든 검색기
-- 형식 ==> WHERE 컬럼명 LIKE '패턴'    A%, %A, %A%, __A%, __A__
-- 사원 이름중에 A자로 시작하는 사원의 모든 정보를 보여달라
SELECT *
FROM emp
WHERE ename LIKE 'A%';

SELECT *
FROM emp
WHERE ename LIKE '%T';

SELECT *
FROM emp
WHERE ename LIKE '%A%';

SELECT *
FROM emp
WHERE ename LIKE '%EN' OR ename LIKE '%AN';

SELECT *
FROM emp
WHERE ename LIKE '__O__';

SELECT *
FROM emp
WHERE ename LIKE '_A%';