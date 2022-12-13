/*
    1. DQL
       = SELECT : 데이터 검색
         형식)
              SELECT * | column1, column2 .. ==========> 5
              FROM table_name | SELECT ~  ============> 1
              [
                 WHERE 조건문 ============> 2
                 GROUP BY 컬럼명|함수 =====> 3
                 HAVING 집합함수 ==========> 4
                 ORDER BY 컬럼명|함수명|컬럼의 위치번호 (ASC|DESC => ASC 생략가능) ===> 6
              ]
              
              서브쿼리 
              ------- SQL 문장을 통합해서 한번에 실행할 목적
              MainQuery = (SubQuery)
                           -------- 결과값을 MainQuery에 전송후 실행
              = 일반 서브쿼리
                = 단일행 서브쿼리 (컬럼 1, 값 1)
                SELECT ~~
                FROM table_name --- 메인쿼리
                WHERE 컬럼명 = (SELECT 컬럼 ~~)
                               ----- 서브쿼리(결과값 1개인 경우)
                = 다중행 서브쿼리 (컬럼 1, 값 여러개)
                SELECT ~~
                FROM table_name
                WHERE 컬럼명 IN (SELECT ~ )
                
                SELECT ~~
                FROM table_name
                WHERE 컬럼명 > ANY(SELECT ~ ) | SOME(SELECT ~ ) | ALL(SELECT ~ )
                
                SELECT ~~
                FROM table_name
                WHERE 컬럼명 < ANY(SELECT ~ ) | SOME(SELECT ~ ) | ALL(SELECT ~ )
              = 스칼라 서브쿼리 : 컬럼대신 사용 (다른 테이블에서 데이터를 읽어 올때) ==> JOIN 대신 사용
                 * 검색속도가 빠르다, 소스코딩이 길다
                 SELECT 컬럼명, (SELECT ~) => 무조건 결과값이 1개만 가능
                 FROM table_name
              = 인라인뷰 : 테이블대신 사용 ==> FROM SELECT ~~
                SELECT ~~ (설정된 컬럼만 사용이 가능)
                FROM (SELECT ~ )
                      --------- 설정된 컬럼
                rownum : 데이터 추가할때마다 각 ROW에 오라클에서 설정한 번호 (1번 시작)
                         원하는 갯수만큼 출력, 이전, 다음 상세보기 (항상 순차적)
                보안이 뛰어나다 (가상 테이블) => 나눠서 처리 (Top-N) => 인기순위 10 ...
               *** 자바에서 DB연동 => 웹 프로그램의 핵심 (Front-End, Back-End)
               -------------
                 JDBC ==> 웹(DBCP) ==> ORM ==> Mapper
                                      ---------------
                                      ORM : MyBatis / Hibernate
                                      => JPA
                                      SELECT * FROM emp WHERE empno = 7788;
                                      findByEmpno(int empno)
                                      save()
             JOIN
             ----------------------------- 테이블 연결후 => 데이터를 추출 (데이터 묶음)
             INNER JOIN (교집합 ==> 컬럼의 값이 같은 경우에 데이터 추출) => NULL값이 있거나 매칭이 안되는 경우 (수행할 수 없다) 
                  10        10
                  20        20
                  30        30
                            40 ==> 수행불가 => 수행이 가능하게 만드는 기법 -> Outer JOIN
                = 형식)
                    SELECT A.colummn, B.column
                    FROM A, B
                    WHERE A.column = B.column
                    
                    SELECT A.colummn, B.column
                    FROM A JOIN B
                    ON A.column = B.column
                    
             OUTER JOIN
                => LEFT OUTER JOIN
                    SELECT A.colummn, B.column
                    FROM A, B
                    WHERE A.column = B.column(+)
                    
                    SELECT A.colummn, B.column
                    FROM A LEFT OUTER JOIN B
                    ON A.column = B.column
                    
                 => RIGHT OUTER JOIN
                    SELECT A.colummn, B.column
                    FROM A, B
                    WHERE A.column(+) = B.column
                    
                    SELECT A.colummn, B.column
                    FROM A RIGHT OUTER JOIN B
                    ON A.column = B.column
                    
                 => FULL OUTER JOIN
                    SELECT A.colummn, B.column
                    FROM A FULL OUTER JOIN B
                    ON A.column = B.column
                    ------------------------------------------- Admin (관리자)
                    => 기타공부 (연산자, 내장함수)
                
    2. DDL
        = 생성 CREATE
          1) 테이블(데이터 저장 장소) => 파일
             CREATE TABLE table_name (
                컬럼명 데이터형 [제약조건], ==> NOT NULL , DEFAULT
                컬럼명 데이터형 [제약조건],
                컬럼명 데이터형 [제약조건],
                [제약조건] => PRIMARY KEY, FOREIGN KEY, CHECK, UNIQUE
             )
             table_name , column_name 식별자
             ----------------
              1. 문자로 시작 (알파벳, 한글) => 알파벳은 대소문자를 구분하지 않는다 (오라클에 저장시에는 대문자로 저장)
                 ** 테이블 검색시에는 대문자로 서술
                 WHERE table_name = 'EMP'
                 *** SQL문장은 대소문자를 구분하지 않는다 (단, 저장된 데이터는 대소문자를 구분한다)
                     ------ UPPER, LOWER
              2. 숫자는 사용이 가능 (앞에 사용할 수 없다)
              3. 특수문자 사용이 가능 (단어가 2개이상) ==> _ foodHouse => food_house
              4. 키워드는 사용할 수 없다 (SELECT, INSERT ...)
              5. 테이블명과 컬럼명을 동일하게 할 수 있다
              *** 테이블명은 (30자) ==> 5 ~ 15 => 알파벳 권장
            데이터형
            --------
              문자형 => 글자의 갯수를 지정
                 CHAR (1~2000byte)
                 VARCHAR2 (1~4000byte)
                 CLOB(4기가)
              숫자형
                 NUMBER(4), NUMBER => NUMBER(8, 2)
                 --------- NUMBER(38, -128)
                 int, double
              날짜형
                 DATE
            
            제약조건
            --------
              1. NOT NULL => 반드시 입력값이 있어야 된다
              2. UNIQUE => 후보키, 대체키 (NULL값을 허용) => 중복이 없는 값 (전화, 이메일)
              3. PRIMARY KEY(기본키) => NOT NULL + UNIQUE => 데이터의 구분자
                 ** 모든 테이블은 기본키 한개 이상을 필요로 한다
                    => NUMBER, ID(VARCHAR2) => 데이터 무결성
                                               ----------- 수정, 삭제방지
              4. FOREIGN KEY : 다른 테이블의 데이터값을 참조 (외래키, 참조키)
                 => JOIN (게시판 <==> 댓글), (예매 <==> 회원가입)
                                                  ID
              5. CHECK : 지정된 데이터만 첨부가 가능하게 만든다 (부서명, 근무지, 성별 ...)
              6. DEFAULT : 값이 입력이 안된 경우에 대입하는 값을 지정
                           DEFAULT SYSDATE, DEFAULT
              
              
          2) 가상 테이블 (뷰) => 읽기 전용
          3) INDEX : 속도최적화 ==> ORDER BY => INDEX_ASC , INDEX_DESC
          4) 시퀀스 : 자동 증가번호 만들기
          5) FUNCTION : 리턴형이 있는 함수 (내장 함수)
          6) PROCEDURE : 기능을 가지고 있는 함수 (리턴형이 없다) ****** PL/SQL 핵심
          7) TRIGGER : 이벤트 (자동화 처리)
          
        = ALTER : 수정, 삭제, 추가 (테이블 변경)
                MODIFY DROP  ADD
                 형식) 
                      ALTER TABLE table_name ADD 컬럼명 데이터형 [제약조건]
                      ALTER TABLE table_name MODIFY 컬럼명 데이터형 [제약조건]
                      ALTER TABLE table_name DROP COLUMN 컬럼명
        = DROP : CREATE로 생성된 모든 것은 DROP으로 삭제한다
                 형식) 
                      DROP TABLE table_name
                      DROP VIEW view_name
                      DROP FUNCTION func_name
        = TRUNCATE : 데이터 잘라내기 (테이블은 유지)
                 형식)
                      TRUNCATE TABLE table_name
        = RENAME : 테이블 이름 변경
                 형식)
                      RENAME old_name TO new_name
    3. DML
        = 데이터 조작 언어 (수정, 삭제, 추가)
          INSERT
            = INSERT INTO table_name VALUES(값...)
                          table이 가지고 있는 모든 컬럼값을 설정
                          ** NULL ==> NULL, ''
            = INSERT INTO table_name(컬럼명 ...) VALUES(값 ...)
                                    -------- 갯수 일치 ------- (DEFAULT가 있는 경우)
              *** 자동증가번호 => 서브쿼리를 이용한다
          UPDATE
            = UPDATE table_name SET
              컬럼명 = 값, 컬럼명 = 값 ...
              [WHERE 조건]
          DELETE
            = DELETE FROM table_name
              [WHERE 조건]
    4. TCL
        => 정상 저장 : COMMIT
        => 비정상 취소 : ROLLBACK
        ==> INSERT, UPDATE, DELETE => COMMIT필요 (자바는 오토커밋)
    ------------------- Basic
*/
-- 응용 => CURD (게시판)
CREATE TABLE freeboard (
    no NUMBER,
    name VARCHAR2(34) CONSTRAINT fb_name_nn NOT NULL,
    subject VARCHAR2(4000) CONSTRAINT fb_subject_nn NOT NULL,
    content CLOB CONSTRAINT fb_content_nn NOT NULL,
    pwd VARCHAR2(10) CONSTRAINT fb_pwd_nn NOT NULL,
    regdate DATE DEFAULT SYSDATE,
    hit NUMBER DEFAULT 0,
    CONSTRAINT fb_no_pk PRIMARY KEY(no)
);

DESC freeboard;

INSERT INTO freeboard(no, name, subject, content, pwd) VALUES(1, '홍길동', 'CURD연습', 'CURD연습...', '1234');
COMMIT;
SELECT * FROM freeboard;

INSERT INTO freeboard(no, name, subject, content, pwd) VALUES(2, '홍길동', 'CURD연습', 'CURD연습...', '1234');
INSERT INTO freeboard(no, name, subject, content, pwd) VALUES(3, '홍길동', 'CURD연습', 'CURD연습...', '1234');
INSERT INTO freeboard(no, name, subject, content, pwd) VALUES(4, '홍길동', 'CURD연습', 'CURD연습...', '1234');
INSERT INTO freeboard(no, name, subject, content, pwd) VALUES(5, '홍길동', 'CURD연습', 'CURD연습...', '1234');
INSERT INTO freeboard(no, name, subject, content, pwd) VALUES(6, '홍길동', 'CURD연습', 'CURD연습...', '1234');
INSERT INTO freeboard(no, name, subject, content, pwd) VALUES(7, '홍길동', 'CURD연습', 'CURD연습...', '1234');
INSERT INTO freeboard(no, name, subject, content, pwd) VALUES(8, '홍길동', 'CURD연습', 'CURD연습...', '1234');
INSERT INTO freeboard(no, name, subject, content, pwd) VALUES(9, '홍길동', 'CURD연습', 'CURD연습...', '1234');
INSERT INTO freeboard(no, name, subject, content, pwd) VALUES(10, '홍길동', 'CURD연습', 'CURD연습...', '1234');
INSERT INTO freeboard(no, name, subject, content, pwd) VALUES(11, '홍길동', 'CURD연습', 'CURD연습...', '1234');

desc zipcode;
