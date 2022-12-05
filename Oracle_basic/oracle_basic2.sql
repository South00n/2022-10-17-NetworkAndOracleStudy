-- SQL문장
/*
        SQL
        ----
            1) DML : 데이터 조작언어
               = SELECT : 데이터 검색
               = INSERT : 데이터 추가
               = UPDATE : 데이터 수정
               = DELETE : 데이터 삭제
               
            = SELECT
              emp / dept (부서 정보)
              emp 구조 (사원 정보)
              ------------------
              8개의 컬럼으로 구성 => 사원수 14명
              empno : 사번 (정수형)
              ename : 이름 (문자형)
              job : 직위 (문자형)
              mgr : 사수의 사번 (정수형)
              hiredate : 입사일 (날짜형)
              sal : 급여 (정수형)
              comm : 성과급 (정수형)
              deptno : 부서번호 =====> dept와 연결시에 사용하는 컬럼명 ==> 정수형
              ------------------------------------------------------------- 확인 DESC 테이블명
*/
-- DESC emp;
/*
      *** 오라클
          1. 대소문자 구분을 하지 않는다 (단 데이터값은 대소문자를 구분한다) => 명령문은 대소문자를 구분하지 않는다
             SELECT, select ... (약속 사항 => 키워드는 대문자로 서술한다)
          2. 표현법
             정수, 실수 => 그대로 표현 1, 2 ... 10.0
             문자, 날짜 표시는 => ''
             인용부호 => "" (별칭, 날짜한글)
             예) 조건
                 WHERE ename = king ==> 오류
                 WHERE ename = 'king';
                 WHERE empno = 7788;
             => 문장이 종료하면 ;을 사용한다
                 WHERE hiredate = '22/01/02'
      1) SELECT => 데이터를 검색 (추출)
         = 형식
           SELECT * | column1, column2 .. => 전체 데이터(*) or 출력에 필요한 데이터만 추출
           FROM table_name
           [
                WHERE 조건문 => if => 연산자, 내장함수
                GROUP BY 그룹컬럼 => 입사일, 부서별, 직위별
                HAVING 그룹에 대한 조건
                ORDER BY 컬럼명 => 정렬 (ASC(생략이 가능), DESC)
           ]
           => 자바에서 => SQL => 오라클 => 처리 결과를 받아 온다
*/
-- emp에 있는 모든 데이터를 검색
SELECT * FROM emp;
-- emp에 있는 데이터중에 사번, 이름, 직위, 입사일만 추출
SELECT empno, ename, job, hiredate FROM emp;
-- 컬럼에 별칭을 주는 방법 => 사용자 쉽게 볼 수 있게 만든다
/*
       컬럼명, 테이블명 ==> 길때
       컬럼명 "별칭"
       컬럼명 as 별칭
*/
SELECT empno "사번", ename "이름", hiredate "입사일"
FROM emp;

SELECT empno as 사번, ename as 이름, hiredate as 입사일
FROM emp;

-- JOIN을 사용할때, 테이블명 길이 30자까지 가능 // 길때 별칭사용
SELECT empno as 사번, ename as 이름, hiredate as 입사일
FROM emp e;

-- 문자열 결합 ==> || (연산자중에 논리연산자 => ||를 사용하지 않고 OR를 사용한다)
SELECT ename || '님의 입사일은 ' || hiredate || '입니다' FROM emp;

-- 중복을 제거 DISTINCT
SELECT deptno FROM emp;
SELECT DISTINCT deptno FROM emp; -- 장르, 부서명, 근무지등 중복제거가 필요한 데이터를 가져올때 사용
/*
      1) 형식
         = 전체 데이터 추출  ==> SELECT *
         = 원하는 컬럼만 추출 ==> SELECT 컬럼명 나열 ...
      2) 문자열 결합         ==> 문자열 결합시 ||사용 결합할 문자열 ''안에 작성
      3) 컬럼명이 복잡하다 => 별칭 ==> 컬럼명 as 별칭, 컬럼명 "별칭"
      4) 중복이 없는 데이터 추출 ==> DISTINCT 컬럼명 ==> 1개 추출
      
      SELECT - FROM - WHERE - GROUP BY - HAVING - ORDER BY => 자바 (항상 =>  실행후에 SQL)
*/
