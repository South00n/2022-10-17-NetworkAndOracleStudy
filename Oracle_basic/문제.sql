/*
문제 5)
별칭에 공백이 있는 경우 "" 붙여서 별칭 사용

WHERE => 연산자
         -----
         산술연산자 (+,-,*,/)
         비교연산자 (=,!=,<>,^=,<,>,<=,>=)
         논리연산자 (AND, OR)
         IN => OR 여러개일 경우에 처리
         NOT => 부정연산자
         NULL => IS NULL, iS NOT NULL
         LIKE => %, _
         BETWEEN => 기간 ==> >= AND <=
         
문제 43)
        LOWER(SUBSTR(ensme, 2, LENGTH(ename)-1))
        
문제 45)
SELECT ename, hiredate
FROM emp
WHERE REGEXP_LIKE(ename, 'EN|IN') --> 최근 방식
ORDER BY hiredate DESC;

문제 71)
SELECT ename, TO_CHAR(sal, '999,999')
FROM emp;

NVL(컬럼명, 값)
    --------- 데이터형이 동일해야된다
*/