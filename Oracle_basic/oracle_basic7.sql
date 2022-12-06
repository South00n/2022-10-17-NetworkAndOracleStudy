-- 숫자관련
/*
     211page
       ***=> MOD() : 나머지 값 = % in Java
             MOD(10,2) ==> 0 
       ***=> CEIL() : 올림함수 (총 페이지)
             CEIL(10.2) ==> 11
       ***=> ROUND() : 반올림
             ROUND(10.5678, 2)
                        -     => 10.57
       => TRUNC() : 버림
            TRUNC(10.5678, 2) => 10.56 (퇴직금 계산시)
       ----------------------------------------------- 날짜형 (숫자)
*/
SELECT MOD(10, 3) FROM DUAL; -- 10%3
SELECT empno, ename, job
FROM emp
WHERE MOD(empno, 2) = 0
ORDER BY 1;

SELECT CEIL(10.1) FROM DUAL;
SELECT CEIL(10.0) FROM DUAL;
-- 총 페이지
SELECT CEIL(COUNT(*) / 10.0) FROM emp;
-- 14 / 10.0 -> 1.4 -> 2
-- ROUND
SELECT ROUND(10.23456,3) FROM DUAL; -- 10.235
-- TRUNC
SELECT TRUNC(10.23456,3) FROM DUAL; -- 10.234

-- 216page => 날짜함수
/*
      ***SYSDATE : 시스템의 날짜와 시간을 읽을 때 사용
      ***MONTHS_BETWEEN : 기간에 해당되는 개월수
      형식) MONTHS_BETWEEN (현재, 과거)
                            최근, 이전
      22/02/01 ~ 22/12/01 ==> 10
      ADD_MONTH : 월추가
      ADD_MONTH(5) => 보험, 적금
      NEXT_DAY : SYSDATE, '월' ==> 
      LAST_DAY : 마지막 날을 읽어 온다 SYSDATE => 12/31
                                    '22/10/10' => 10/31
      ***ROUND
      ***TRUNC
*/
/*CREATE TABLE my(
    name VARCHAR2(20),
    regdate DATE
);

INSERT INTO my VALUES ('hong', SYSDATE);
SELECT * FROM my;*/
SELECT SYSDATE FROM DUAL;
SELECT SYSDATE - 1 "어제", SYSDATE "오늘", SYSDATE + 1 "내일" FROM DUAL;
SELECT ename, hiredate, TRUNC(TRUNC(MONTHS_BETWEEN(SYSDATE, hiredate)) / 12) "근무개월수"
FROM emp;

SELECT SYSDATE, ADD_MONTHS(SYSDATE, 3) FROM DUAL;
SELECT LAST_DAY(SYSDATE) FROM DUAL;
SELECT LAST_DAY('22/02/01') FROM DUAL;
SELECT NEXT_DAY(SYSDATE, '화') FROM DUAL;

/*
      변환
        **** TO_CHAR : 문자열 변환
        TO_DATE : 날짜형 변경
        TO_NUMBER : 숫자형 변경 '10' + 10 => 20
*/
SELECT TO_NUMBER('100') + TO_NUMBER('200') FROM DUAL;
SELECT '100' + '200' FROM DUAL; -- 자동변환 TO_NUMBER는 거의 안씀

SELECT TO_DATE(SYSDATE) - 5 Before,
       TO_DATE(SYSDATE, 'YYYY-MM-DD') + 5 After
FROM DUAL;
-- TO CHAR
/*
     날짜, 숫자를 문자로 변경 => valueOf()
     
     날짜 패턴
       d => 1 ~ 31
       dd => 1 ~ 9 => 01 ... 11 12
       yy (rr)
       yyyy (rrrr)
       m => month
       mm
       dy 요일
       hh/hh24
       mi
       s
       ss
     숫자 패턴
       $999,999
       L999,999 (원 표시 => L)
*/
SELECT ename, TO_CHAR(sal,'L999,999') FROM emp;
SELECT TO_CHAR(SYSDATE, 'RRRR-MM-DD'), TO_CHAR(SYSDATE, 'YYYY-MM-DD') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'DY') FROM DUAL;

-- emp 사원 => 입사 요일을 출력
SELECT ename, TO_CHAR(hiredate, 'DY') || '요일' FROM emp;
-- 목요일에 입사한 사원의 모든 정보 출력
SELECT * FROM emp
WHERE TO_CHAR(hiredate, 'DY') = '목';

/*
      기타 함수
        ***NVL() : NULL을 대체하는 함수
          NNL(데이터, 값)
          => NULL일 경우에는 연산처리가 안된다
        DECODE() : switch문장
        CASE : 다중 조건문
*/
SELECT ename, sal, comm, sal + NVL(comm, 0) FROM emp;
SELECT zipcode, sido || ' ' || gugun || ' ' || dong || ' ' || NVL(bunji, ' ') FROM zipcode;
SELECT ename, job, hiredate, deptno FROM emp;
-- 일반 SQL문장
/*
     SELECT ename, job, hiredate, DECODE(deptno, 1, '★☆☆☆☆',
                                                 2, '★★☆☆☆',
                                                 3, '★★★☆☆'
                                                 4, '★★★★☆'
                                                 5, '★★★★★') "dname"
    
*/
SELECT ename, job, hiredate, DECODE(deptno, 10, '개발부',
                                            20, '총무부',
                                            30, '기획부') "dname"
FROM emp;
-- TRIGGER, PROCEDURE
/*
     입고 => 재고
     출고 => 재고
*/
SELECT ename, job, hiredate, CASE
                             WHEN deptno = 10 THEN '개발부'
                             WHEN deptno = 20 THEN '기확부'
                             WHEN deptno = 30 THEN '자재부'
                             END "dname"
FROM emp;
                             