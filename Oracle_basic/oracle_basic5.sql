-- 오라클 2일차 -> SELECT (내장함수)
/*
        SQL : 데이터베이스에서 사용되는 언어
              => 목적 : 모든 사용자에게 데이터 공유 (웹사이트)
              => 데이터베이스에 저장된 데이터를 제어 => DBMS(데이터베이스 시스템) => 제어할때 사용되는 언어 : SQL
              => 필요한 데이터만 수집 => 구분(컬럼)
                 ----------------- 테이블 제작시 (키에 대한 종류, 제약조건)
              => readonly : 읽기전용 => View, 중복을 최소화 => 시퀀스, 함수 ...
        emp/dept
        => 문법
            1) DML => 데이터 조작 (CURD) => 웹 프로그래머
                사용자는 필요한 데이터만 입력 ==> SQL문장을 만들어서 => 오라클로 전송
                예) 영화 검색 : 눈
                    WHERE title LIKE '%눈%'
                = SELECT : 사용자에게 데이터를 검색해주는 문장 
                           목록출력, 상세보기, 검색, 추천데이터 읽기...(65%)
                           테이블 연결 (JOIN, SubQuery)
                           예) 영화 상세보기 => 댓글, 게시판 => 댓글, 예매 => id를 가지고온다
                            
                = INSERT : 사용자가 요청힌 데이터를 오라클에 추가
                           예) 회원가입, 글쓰기, 댓글 올리기, 찜하기, 예매요청
                = UPDATE : 사용자 요청에 의해 데이터를 수정
                           예) 회원수정, 수정하기, 장바구니 갯수 수정...
                = DELETE : 데이터 삭제
                           예) 회원 탈퇴, 구매 취소, 예약 취소
            2) DDL : 저장공간 만들기(테이블), 함수, 가상테이블, 인덱스, 자동 증가번호 ...
                = CREATE : 생성
                           CREATE TABLE, CREATE VIEW, CREATE SEQUENCE, CREATE INDEX, CREATE FUNCTION ...
                           ------------ 제약조건, 데이터형, 키
                           ------------ 데이터베이스 모델링 => 정규화
                = ALTER : 수정
                          *** 오라클 : 한글 (3byte)
                          --- 1.ADD(컬럼 추가), 2.MODIFY(컬럼 수정), 3.DROP(컬럼 삭제), 4.TRUNCATE(데이터 잘라내기)
                = DROP : 테이블, VIEW를 완전 삭제
                = RENAME
            3) DCL : GRANT, REVOKE => 사용자 계정 (View, Index를 사용할 권한이 없다)
            4) TCL : 일괄 처리 (COMMIT, ROLLBACK)
            
            => SELECT : 데이터 검색
                1) 형식 (문법사항) => 145page
                   SELECT * | column1, column2 ... (컬럼리스트)
                   FROM table_name|view_name|SELECT~
                   [
                       WHERE 조건 검색
                       -------------------------------
                       GROUP BY 그룹별로 나눠서 따로 처리 : 독립적으로 사용이 가능
                       HAVING : 그룹 조건 => 반드시 GROUP BY가 설정이 되어 있을때 사용이 가능 (독립적으로 사용이 불가능)
                       -------------------------------
                       ORDER BY : 정렬
                   ]
                   => SELECT문장 => 컬럼대신, 테이블 대신 사용이 가능 (인라인뷰)
                                   ------- 스칼라 서브쿼리 
                2) 조건 검색 : 연산자
                   산술연산자 : +, -, *, / => '10' => 산술연산자 사용하면 => 자동으로 숫자로 변경이 된다 (문자열 결합은 할 수 없고 Only 산술처리)
                                / => 정수/정수 = 실수
                   비교연산자 : = , (<> , != , ^=) , < , > , <= , >=
                   논리연산자 : AND , OR
                              || => 문자열 결합
                              && => 입력값 받는 경우
                   ------------ 데이터베이스에만 있는 연산자
                   IN : OR가 여러개 일때 사용되는 연산자
                        WHERE empno IN(값, 값...)
                              컬럼명
                   NOT : 부정연산자 ==> NOT LIKE , NOT BETWEEN , NOT IN ==> !(사용금지)
                   NULL : NULL(실체가 없는 값) => 모든 연산처리가 불가능 ==> IS NULL, IS NOT NULL
                          ==> NVL() -> NULL값 대처하는 함수
                   BETWEEN : 기간, 범위 ==>    >= AND <= (포함)
                   LIKE : 유사문자열 검색
                          % : 글자수와 관계없다
                          A% => A로 시작
                          %A => A로 끝
                          %A% => A가 포함
                          _ : 한글자
                          REGEXP_LIKE : 정규식 ==> 149 ~ 155
                3) 원하는 데이터를 추출 : 내장함수
                4) 데이터형 => 숫자형, 문자형, 날짜형
                                     ------------ 반드시 ''
                5) 문자열 결합 : ||
                6) 컬럼명이니, 테이블명이 긴 경우 : 별칭사용 => 컬럼명 "별칭명" , 컬럼명 as 별칭명
                7) 중복없는 데이터 추출 : DISTINCT
                
                => 155page : 정렬 => 정렬해서 추출하지 않는다 => ORDER BY (가급적이면 사용하지 말라) => 대체하는 명령어 (***INDEX 기술면접)
                ORDER BY 순서 => 마지막에 등장
                
                사용법)
                   SELECT empno, ename, job
                   FROM emp
                   ORDER BY empno;  ==> ASC생략 (올림차순)
                   
                   SELECT empno, ename, job
                   FROM emp
                   ORDER BY empno DESC;  ==> (내림차순)
                            1      2     3
                   SELECT empno, ename, job
                   FROM emp
                   ORDER BY 3;  ==> job으로 정렬
                   
                   ****** 자바 (0번 부터), 오라클 (1번 부터)
                   
                   이중 정렬
                   -------- 묻고답하기
                   SELECT empno, ename, job, deptno
                   FROM emp
                   ORDER BY deptno ASC, ename DESC
                            ----------
                            10      aaa -> ccc
                            10      bbb -> bbb
                            10      ccc -> aaa
                            20      ddd
                            30      eee
                            
                   SELECT empno, ename, job, deptno
                   FROM emp
                   ORDER BY 4 ASC, 2 DESC
*/
SELECT LENGTHB('홍길동') FROM DUAL;

-- emp 테이블에서 사번을 정렬 => 올림차순 정렬
SELECT *
FROm emp
ORDER BY empno ASC;

SELECT *
FROm emp
ORDER BY empno DESC; -- 내림차순

-- 급여가 많은 순서로 출력
SELECT *
FROM emp
ORDER BY sal DESC;

-- 입사일이 빠른 순서로 출력
SELECT *
FROM emp
ORDER BY hiredate ASC;

-- 이름을 알파벳 순서
SELECT *
FROM emp
ORDER BY ename ASC;

-- 부서별로 출력 => 정렬 , GROUP BY
SELECT *
FROM emp
ORDER BY deptno ASC;

-- 이중 정렬
SELECT ename, deptno
FROM emp
ORDER BY 2, 1 DESC;




