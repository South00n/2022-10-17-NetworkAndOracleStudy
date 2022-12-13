/*
       187page => DML (데이터 조작언어) ==> ROW 단위
          = INSERT : 데이터 추가
               1. INSERT ALL
                  전체 데이터 등록, 나눠서 저장
               2. 전체 데이터 등록 (모든 컬럼에 데이터 추가)
                  INSERT INTO table_name VALUES(값...)
                              ----------        -----
                               컬럼 갯수와 값의 갯수가 동일해야함
               3. 필요한 데이터만 등록 (컬럼을 지정해서 처리)
                  INSERT INTO table_name(컬럼, 컬럼...) VALUES(값..)
                                         -----------          ----
                                        지정된 컬럼의 갯수와 값의 갯수가 동일해야함
                                        => DEFAULT가 있는 경우에 많이 사용
          = UPDATE : 데이터 수정
              UPDATE table_name SET
              컬럼명 = 값, 컬럼명 = 값 ...
              [WHERE 조건] // 조건에 맞는걸 수정해서 안쓰면 전체수정 [거의 필수]
          = DELETE : 데이터 삭제
              DELETE FROM table_name
              [WHERE 조건]
          *** INSERT , UPDATE, DELETE => 반드시 COMMIT : 자바에서 에러가 없는데 데이터를 읽지 못한다 (COMMIT 확인)
          
*/
/*
CREATE TABLE emp_10
AS
SELECT empno, ename, job, hiredate, sal FROM emp
WHERE 1 = 2;
SELECT * FROM emp_10;

CREATE TABLE emp_20
AS
SELECT empno, ename, job, hiredate, sal FROM emp
WHERE 1 = 2;
SELECT * FROM emp_20;

CREATE TABLE emp_30
AS
SELECT empno, ename, job, hiredate, sal FROM emp
WHERE 1 = 2;
SELECT * FROM emp_30;
-- 파티션테이블 --> 분기별 통계
INSERT ALL
    WHEN deptno = 10 THEN
        INTO emp_10 VALUES(empno, ename, job, hiredate, sal)
    WHEN deptno = 20 THEN
        INTO emp_20 VALUES(empno, ename, job, hiredate, sal)
    WHEN deptno = 30 THEN
        INTO emp_30 VALUES(empno, ename, job, hiredate, sal)
SELECT * FROM emp;

SELECT * FROM emp_10;
SELECT * FROM emp_20;
SELECT * FROM emp_30;

SELECT DISTINCT TO_CHAR(hiredate, 'YYYY') FROM emp;

CREATE TABLE emp_1980
AS
SELECT empno, ename, job, hiredate, sal FROM emp
WHERE 1 = 2;

CREATE TABLE emp_1981
AS
SELECT empno, ename, job, hiredate, sal FROM emp
WHERE 1 = 2;

CREATE TABLE emp_1982
AS
SELECT empno, ename, job, hiredate, sal FROM emp
WHERE 1 = 2;

CREATE TABLE emp_1983
AS
SELECT empno, ename, job, hiredate, sal FROM emp
WHERE 1 = 2;

INSERT ALL
    WHEN TO_CHAR(hiredate, 'YYYY') = 1980 THEN
    INTO emp_1980 VALUES(empno, ename, job, hiredate, sal)
    WHEN TO_CHAR(hiredate, 'YYYY') = 1981 THEN
    INTO emp_1981 VALUES(empno, ename, job, hiredate, sal)
    WHEN TO_CHAR(hiredate, 'YYYY') = 1982 THEN
    INTO emp_1982 VALUES(empno, ename, job, hiredate, sal)
    WHEN TO_CHAR(hiredate, 'YYYY') = 1983 THEN
    INTO emp_1983 VALUES(empno, ename, job, hiredate, sal)
SELECT * FROM emp;

SELECT * FROM emp_1981;
-- 맛집 ==> 한식/양식/중식/일식/기타
-- 노래 ==> 가요/POP/트롯/ ...
DROP TABLE emp_1983;
*/
DROP TABLE student;
CREATE TABLE student (
    hakbun NUMBER,
    name VARCHAR2(34) CONSTRAINT std_name_nn NOT NULL,
    subject VARCHAR2(100),
    kor NUMBER(3),
    eng NUMBER(3),
    math NUMBER(3),
    regdate DATE DEFAULT SYSDATE,
    CONSTRAINT std_hak_pk PRIMARY KEY(hakbun)
);
-- TABLE 저장공간 = 데이터를 추가 => INSERT
INSERT INTO student VALUES (1, '홍길동', '', 90, 80, 90, SYSDATE);
INSERT INTO student (hakbun, name, kor, eng, math) VALUES (2, '심청이', 89, 78, 90); -- DEFAULT가 적용되는 부분
SELECT * FROM student;

SELECT hakbun, name, kor, eng, math, (kor + eng + math) total, ROUND((kor + eng + math) / 3 , 2) avg
FROM student;
-- 서브쿼리 => INSERT, UPDATE, DELETE에서 사용이 가능
-- 자동 증가번호를 이용
INSERT INTO student (hakbun, name, kor, eng, math) VALUES((SELECT MAX(hakbun) + 1 FROM student), '박문수', 90, 80, 67);

-- 자동증가번호 , 형식 (필요한 데이터 추가, 전체 데이터 추가) 
-- default가 많은 경우 => 선택적으로 추가
-- 문자/날짜는 반드시 ''를 이용해서 추가한다
-- 그렇지 않은 경우 => 전체적으로 추가

ALTER TABLE student DROP COLUMN subject;
ALTER TABLE student DROP COLUMN regdate;

CREATE TABLE emp_test
AS
SELECT * FROM emp;

SELECT * FROM emp_test;

TRUNCATE TABLE emp_test;

INSERT INTO emp_test(empno, ename, job, mgr, hiredate, sal, comm, deptno)
SELECT * FROM emp;

SELECT * FROM student;

TRUNCATE TABLE student;
