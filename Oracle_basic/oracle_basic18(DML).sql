-- 189page UPDATE, DELETE
/*
    활용 / 서블릿 => 자바로 웹 ==>
    =======> 오라클(RDBMS) ==> 데이터 검색 (데이터 공유
    DML
       INSERT : 데이터 추가
                게시판 글쓰기, 회원가입, 찜하기, 예매하기, 댓글쓰기 ...
                형식)
                     = 전체 데이터 추가
                       INSERT INTO table_name VALUES(값, 값, '값' ...) => 값이 문자열, 날짜일땐 ''안에
                                    -> 무조건 컬럼의 모든 값에 값을 추가
                     = 필요한 데이터만 추가 (디폴트값이 설정된 경우)
                       INSERT INTO table_name(컬럼명, 컬럼명 ...) VALUES(값, 값 ...)
                                              ---------------- 갯수일치 ----------
                                                               + 데이터형 일치
                       *** 주의점 (제약조건) ==> 자바스크립트(유효성) => 스프링(라이브러리 => 유효성검사)
                       *** 주의점 : 추가후 => 반드시 COMMIT을 보내준다
                                   자바는 AutoCommit => executeUpdate()
                                   ----------------
                                   => 자바에서는 한개의 기능을 수행할떄 (SQL문장을 여러번 수행할 수 있다)
                                   예) 상세보기
                                        = UPDATE (조회수 증가)
                                        = SELECT (데이터 읽기)
                                   DML단점 - 쿼리문장 여러개를 날려야 하나의 기능을 수행
                                   
       UPDATE : 데이터 수정
                게시판 수정, 댓글 수정, 회원 수정, 장바구니 수정, 예매수정
                형식)
                     UPDATE table_name 
                     SET 컬럼명 = 값, 컬럼명 = '문자', 컬럼명 = '날짜'
                     ----------------------------------------- 전체 데이터 변경 (급여인상)
                     [WHERE 조건] ---- 원하는 데이터만 변경
       DELETE : 데이터 삭제
                게시물 삭제, 댓글 삭제, 회원 탈퇴, 예매취소 ...
*/
CREATE TABLE emp_update
AS
SELECT * FROM emp;

SELECT * FROM emp_update;

-- 직위 변경
UPDATE emp_update
SET job = 'CLERK';

SELECT * FROM emp_update;
ROLLBACK; -- COMMIT을 수행하면 Rollback이 적용되지 않는다 (자바)

-- 추가
-- (SELECT NVL(MAX(empno) + 1, 1) FROM emp_update) -> 값이 없는 경우 초기값 1
INSERT INTO emp_update VALUES((SELECT MAX(empno) + 1 FROM emp_update), '홍길동', 'CLERK', 7788,
        SYSDATE, 2000, 100, 40);
INSERT INTO emp_update VALUES((SELECT MAX(empno) + 1 FROM emp_update), '심청이', 'MANAGER', 7788,
        '21/10/10', 3000, 500, 40);
INSERT INTO emp_update VALUES((SELECT MAX(empno) + 1 FROM emp_update), '박문수', 'CLERK', 7788,
        SYSDATE, 2000, 100, 40);
COMMIT; -- 완전 저장
SELECT * FROM emp_update;

-- 박문수 수정
UPDATE emp_update SET
job = 'SALESMAN', mgr = 7698, hiredate = '20/01/05', sal = 3500, comm = 700, deptno = 30
-- 대입
WHERE empno = 7937;
-- 비교연산자
COMMIT;

