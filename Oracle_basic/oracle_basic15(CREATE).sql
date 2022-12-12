-- 179page DDL (데이터 정의 언어)
/*
        DQL
          SELECT
        DML
          INSERT, UPDATE, DELETE
        DDL
          CREATE, ALTER, DROP, TRUNCATE
          
        DCL
          GRANT, REVOKE
        TCL
          COMMIT, ROLLBACK
        --------------------------------
        DDL : 생성 (Table : 데이터 저장 장소)
              View : 가상테이블
              Index : 검색 속도 향상(최적화)
              Sequence : 자동 증가번호 => 중복이 없는 데이터 ==> MAX() + 1
              PL / SQL => Function, Procedure, Trigger
        Table : 데이터 저장 장소 만들기
                1. 데이터형
                   문자형
                     CHAR (1~2000byte)
                       => 고정 바이트 (글자수가 동일한 데이터가 들어갈때 많이 사용 -> 남자/여자, y/n)
                       => CHAR(10)
                          -> 저장 데이터 'A'
                          -> 한 글자가 들어가도 고정으로 10byte
                             메모리 누수현상이 많다
                             ----------------------
                              A \0 \0 \0 \0 ...
                             ----------------------
                     VARCHAR2 (1~4000byte) : default값 (단점 : 오라클에서만 사용이 가능)
                       => 가변 바이트 -> 초기값을 약간 크게
                       => VARCHAR2(10)
                          => 저장 데이터 'A'
                          => 1byte만 메모리 할당
                             메모리 누수현상 방지
                     CLOB (4기가) : 가변 바이트 -> 문자열 저장 -> 줄거리, 자기소개 ... , 회사 소개)
                     ----------------------------------------------- String
                   숫자형
                     NUMBER(38)) ==> int, long
                     NUMBER(4)   ==> 저장할 수 있는 데이터 -> 0~9999
                     NUMBER(8)   ==> default값 (NUMBER만 쓰면 -> NUMBER(8,2))
                     NUMBER(7,2) ==> 7자리 저장이 가능, 소수점 2자리를 사용할 수 있다 (무조건 실수를 저장하는 것은 아니다)
                                                      ---------- 정수 5, 소수점 2
                                 ==> 저장된 데이터가 실수면 double로 정수면 int로 받는다 (자바에서)
                   날짜형
                     DATE : default
                     TIMESTAMP : 기록 경기 ...
                   기타형 : 동영상, 이미지(로고), 증명사진 ...
                     => BLOB(2진파일) , BFILE(file형식으로 저장) --> 폴더에 저장후 파일을 읽어서 출력
                     => HTML의 링크 (원격)
                1-1.
                        테이블명(식별자)
                         1) 같은 데이터베이스 (XE)에서 같은 이름의 테이블을 만들 수 없다
                         2) 문자로 시작한다 (알파벳, 한글) => 알파벳
                            => 운영체재마다 한글 읽는 방식 다르다 (AWS => 호스팅)
                            => 알파벳을 사용시에 대소문자 구분이 없다
                            => *** 실제 오라클에 저장될때 대문자로 저장이 된다 (실제 테이블의 형식을 읽을때)
                               WHERE table_name = 'emp' -> 못찾는다
                               WHERE table_name = 'EMP'
                         3) 테이블명 (30) => 15자 : 테이블명 컬럼명은 동일할 수 있다
                         4) 숫자는 사용할 수 있다 (단 앞에 사용 금지)
                         5) 키워드는 사용할 수 없다 (SELECT, INSERT ...)
                         6) 특수 문자 사용이 가능 ( _(언더바) )
                2. 제약조건 : 이상현상을 방지 (프로그램에 필요한 데이터만 저장)
                            -------------- 수정, 삭제 -> 원하지 않는 데이터가 수정, 삭제가 될 수도 있다
                            예)
                               id   name   sex
                               aaa  hong   man
                               aaa  shim   woman
                               -------------------- DELETE FROM member WHERE id = 'aaa'
                         1) NOT NULL : NULL값을 허용하지 않는다 (무조건 데이터값을 필요로 한다)
                              * 필수 입력
                         2) UNIQUE : 유일값 (중복이 없는 데이터 => NULL값을 허용)
                              * 후보키(대체키) => 기본키를 잃어 버린 경우 => 이메일, 전화번호
                         3) PRIMARY KEY : 기본키 => 정수값, ID => 중복이 없는 값
                              * 모든 테이블은 Primary Key 한개 이상 설정 => 권장
                                NOT NULL + UNIQUE 
                                게시물 번호, 영화번호 ... (ID)
                         4) FOREGIN KEY : 참조키 => 참조하고 있는 데이터값만 저장 (다른 테이블 연결)
                             게시판 <==> 댓글 (게시판 참조해서 댓글)
                             영화  <==> 리뷰
                         5) CHECK : 지정된 데이터값만 입력이 가능하게 만든다
                                    => 부서명, 근무지
                                    => 라디오박스, 콤보
                         6) DEFAULT : 미리 기본값을 성정한 후에 ==> 데이터값이 없는 경우 자동으로 값을 입력
                                      regdate DATE DEFAULT SYSDATE
                                      hit NUMBER DEFAULT 0
                ---------------------------------------------------------------
                2-1. TABLE 만들기
                     1) 기존의 테이블을 복사 (데이터값 + 테이블형태)
                        CREATE TABLE table_name
                        AS
                        SELECT ~
                     2) 테이블형태만 복사
                        CREATE TABLE table_name
                        AS
                        SELECT ~
                        WHERE 1 = 2; --> false가 되게 (데이터가 카피안되게)
                     3) 사용자 정의 (********)
                     ----------------------- *** COMMIT(AUTO)
                
                3. 수정, 삭제, 필요없는 데이터 자르기
        
*/
-- 복사
CREATE TABLE myEmp
AS
SELECT * FROM emp;
SELECT * FROM myEmp;
DESC myEmp;

CREATE TABLE myEmp2
AS
SELECT * FROM emp
WHERE 1 = 2;

SELECT * FROM myEmp2;
-- 삭제
DROP TABLE myEmp;
DROP TABLE myEmp2;

CREATE TABLE myEmp
AS
SELECT emp.*, dname, loc
FROM emp, dept
WHERE emp.deptno = dept.deptno;

SELECT * FROM myEmp;
DROP TABLE myEmp;

TRUNCATE TABLE myEmp;
/*
       필요없는 데이터 삭제 : DELETE  ==> 취소가능
       전체 데이터 삭제 : TRUNCATE  ==> 취소 불가능(복구할 수 없다)
       테이블 자체 삭제 : DROP  ==> 취소 불가능(복구할 수 없다)
       => DML (복구가능), DDL(복구할 수 없다) --> 백업
*/
DESC myEmp;
-- 테이블명 변경 => RENAME old_name TO new_name
RENAME myEmp TO myEmp2;
/*
       사용자 정의 테이블 (179page)
       ---------------
       형식)
           CREATE TABLE table_name(
              컬럼명 데이터형 [제약조건], ==> 컬럼레벨 (컬럼과 동시에 생성) => NOT NULL, DEFAULT
              컬럼명 데이터형 [제약조건],
              컬럼명 데이터형 [제약조건],
              컬럼명 데이터형 [제약조건],
              컬럼명 데이터형 [제약조건],
              [제약조건] => 테이블레벨 => 테이블이 만들어진 다음에 생성 => PRIMARY KEY, FOREGIN KEY, CHECK, UNIQUE
           );
          => 약식
          CREATE TABLE member (
               id VARCHAER2(20) PRIMARY KEY, (중복이되면 안되고 반드시 입력값이 있어야한다)
               pwd VARCHAR2(10) NOT NULL, (반드시 입력을 해야한다)
               name VARCHAR2(34) NOT NULL,
               sex CHAR(10) CHECK(sex IN('남자', '여자')),
               email VARCHAR2(100) UNIQUE, (대체키를 만듬)
               tel VARCAHR2(13) UNIQUE,
               regadte DATE DEFAULT SYSDATE
          );
          => 제약조건에 이름 부여 ==> 권장 (제약조건만 수정, 삭제)
          CREATE TABLE member (
              id VARCHAR2(20),
              pwd VARCHAR2(10) CONSTRAINT member_pwd_nn NOT NULL,
                                          ------------- 중복을 허용하지 않는다
                                          테이블명_컬럼명_제약조건약자
                                          ==> pk (PRIMARY KEY)
                                          ==> nn (NOT NULL)
                                          ==> fk (FOREGIN KEY)
                                          ==> ck (CHECK)
                                          ==> uk (UNIQUE)
              name VARCHAR2(34) CONSTRAINT member_name_nn NOT NULL,
              sex CHAR(10),
              email VARCHAR2(100),
              tel VARCHAR2(13),
              regdate DATE DEFAULT SYSDATE,
              CONSTRAINT member_id_pk PRIMARY KEY(id)
              CONSTRAINT member_sex_ck CHECK(sex IN('남자','여자'))
              CONSTRAINT member_et_uk UNIQUE(email, tel)
          );
          
          emp
          EMPNO    NOT NULL NUMBER(4)    
         ENAME             VARCHAR2(10) 
         JOB               VARCHAR2(9)  
         MGR               NUMBER(4)    
         HIREDATE          DATE         
         SAL               NUMBER(7,2)  
         COMM              NUMBER(7,2)  
         DEPTNO            NUMBER(2) 
            
          dept
          DEPTNO NOT NULL NUMBER       
          DNAME           VARCHAR2(20) 
          LOC             VARCHAR2(20) 
          
          CREATE TABLE dept(
             deptno NUMBER(2),
             dname VARCHAR2(20) CONSTRAINT dept_dname_nn NOT NULL,
             loc VARCHAR2(20) CONSTRAINT dept_loc_nn NOT NULL,
             CONSTRAINT dept_deptno_pk PRIMARY KEY(deptno)
          );
          
          CREATE TABLE emp(
             empno NUMBER(4),
             ENAME             VARCHAR2(10) CONSTRAINT emp_ename_nn NOT NULL,
             JOB               VARCHAR2(9)  CONSTRAINT emp_job_nn NOT NULL,
             MGR               NUMBER(4)    -- NULL값을 허용
             HIREDATE          DATE DEFAULT SYSDATE
             SAL               NUMBER(7,2)  CONSTRAINT emp_sal_nn NOT NULL,
             COMM              NUMBER(7,2)  
             DEPTNO            NUMBER(2),
             CONSTRAINT emp_empno_pk PRIMARY KEY(empno)
             CONSTRAINT emp_deptno_fk FOREGIN KEY(deptno)
             REFERENCES dept(deptno)
          );
*/

-- DESC dept;
-- SELECT * FROM emp;
/*
       게시판 / 댓글 ==> 웹 등장
       -----------------------
       *** 참조하는 테이블
       *** 참조되는 테이블 (우선순위 생성)
       설계
       **게시물번호 => 중복이 안되는 데이터 PK => 자동 증가 (구분자) => MAX => NUMBER(8)
       이름 => NOT NULL VARCHAR2
       제목 => NOT NULL VARCHAR2
       내용 => NOT NULL CLOB
       비밀번호 => 수정/삭제시 본인 확인 ==> NOT NULL 
       **등록일 => DEFAULT SYSDATE
       **조회수 => DEFAULT 0
       
       -----------------------------------------------------------------------------
       컬럼명           no      name      subject     content     pwd     regdate     
       -----------------------------------------------------------------------------
       키(제약조건)      PK      NN          NN          NN        NN      DEFAULT
       -----------------------------------------------------------------------------
       참조테이블
       -----------------------------------------------------------------------------
       참조컬럼
       -----------------------------------------------------------------------------
       체크
       -----------------------------------------------------------------------------
       데이터형       NUMBER  VARCHAR2   VARCHAR2       CLOB     VARCHAR2   DATE
       -----------------------------------------------------------------------------
       크기            8        34        4000                     10
       -----------------------------------------------------------------------------
*/
DROP TABLE board;
CREATE TABLE board(
    no NUMBER,
    name VARCHAR2(34) CONSTRAINT board_name_nn NOT NULL,
    subject VARCHAR2(4) CONSTRAINT board_subject_nn NOT NULL,
    content CLOB CONSTRAINT board_content_nn NOT NULL,
    pwd VARCHAR2(10) CONSTRAINT board_pwd_nn NOT NULL,
    regdate DATE DEFAULT SYSDATE,
    address VARCHAR2(100),
    CONSTRAINT board_no_pk PRIMARY KEY(no)
);

-- 테이블 --> 데이터가 있는 경우 
-- ALTER => 컬럼을 수정, 컬럼을 삭제, 컬럼 추가, 제약조건 변경 ... 
-- hit => 추가
ALTER TABLE board ADD hit NUMBER DEFAULT 0;
DESC board;
-- subject => 글자수변경
ALTER TABLE board MODIFY subject VARCHAR(4000);
-- address => 삭제
ALTER TABLE board DROP COLUMN address;
ALTER TABLE board ADD address VARCHAR2(100) CONSTRAINT board_address_nn NOT NULL;
ALTER TABLE board RENAME COLUMN address TO email;
-- 제약조건을 추가하는 경우에 => 데이터가 없는 경우에는 문제가 없다, 데이터가 있는 경우 : NOT NULL, PRIMARY KEY, FOREGIN KEY, CHECK
/*
    ALTER
      추가 : ADD
      삭제 : DROP COLUMN
      수정 : MODIFY
*/
SELECT * FROM tab;
DROP TABLE member;
/*
      member
      id  ==>  PK
      pwd ==>  NN
      sex ==> CHECK
      name ==> NN
      address
      tel
*/
-- default, NOT NULL은 컬럼뒤에 생성
-- 나머지는 나중에
CREATE TABLE member(
    id VARCHAR2(20),
    pwd VARCHAR2(10) CONSTRAINT member_pwd_nn NOT NULL,
    sex VARCHAR2(6),
    name VARCHAR2(34) CONSTRAINT member_name_nn NOT NULL,
    CONSTRAINT member_id_pk PRIMARY KEY(id),
    CONSTRAINT member_sex_ck CHECK(sex IN('남자','여자'))
);

INSERT INTO member VALUES('bbb', ' ', '남자', '홍길동');
-- '' (NULL), ' '(공백)
SELECT * FROM member;
ALTER TABLE member ADD address VARCHAR2(100) DEFAULT ' ' CONSTRAINT member_address_nn NOT NULL;

-- 제약조건은 한개만 사용하는 것이 아니고 여러개 사용이 가능
-- 데이터 NOT NULL UNIQUE CHECK
--
DROP TABLE board;

CREATE TABLE board(
    no NUMBER,
    name VARCHAR2(34),
    subject VARCHAR2(4000),
    content CLOB,
    pwd VARCHAR2(10),
    regdate DATE,
    address VARCHAR2(100)
);
DESC board;
-- ALTER를 이용해서 제약조건 추가
-- PRIMARY KEY 추가
ALTER TABLE board ADD CONSTRAINT board_no_pk PRIMARY KEY(no);
-- NOT NULL
-- PRIMARY KEY, FOREGIN KEY, CHECK, UNIQUE (ADD), NOT NULL (MODIFY) 
ALTER TABLE board MODIFY name CONSTRAINT board_name_nn NOT NULL;

--DEFAULT 제약조건이 아니다
ALTER TABLE board MODIFY regdate DATE DEFAULT SYSDATE;
-- 제약조건 삭제
ALTER TABLE board DROP CONSTRAINT board_name_nn;
/*
      name VARCHAR2(10) NOT NULL
      sex VARCHAR2(10) NOT NULL
*/
-- 컬럼의 순서는 관계없다 ==> id, email,
DROP TABLE member2;
CREATE TABLE member2(
    id VARCHAR2(20),
    name VARCHAR2(30) CONSTRAINT member2_name_nn NOT NULL,
    email VARCHAR2(100),
    pwd VARCHAR2(10) CONSTRAINT member2_pwd_nn NOT NULL,
    CONSTRAINT member2_id_pk PRIMARY KEY(id)
);

CREATE TABLE member2(
    id VARCHAR2(20),
    name VARCHAR2(30) CONSTRAINT member2_name_nn NOT NULL,
    email VARCHAR2(100),
    pwd VARCHAR2(10) CONSTRAINT member2_pwd_nn NOT NULL,
    CONSTRAINT member2_id_email_pk PRIMARY KEY(id, email)
);
-- PRIMARY KEY 2개잡으면 제어하기 어렵다 될 수 있으면 한개만 잡자
--INSERT INTO member2 VALUES('aaa', 'hong', 'hong@co.kr', '1234');
INSERT INTO member2 VALUES('aaa', 'shim', 'shim@co.kr', '1234');
INSERT INTO member2 VALUES('bbb', 'park', 'park@co.kr', '1234');
INSERT INTO member2 VALUES('ccc', 'kim', 'park@co.kr', '1234');
/*
INSERT INTO member2 VALUES('aaa', 'hong', '', '1234');
SELECT * FROM member2;
DELETE FROM member2 WHERE id ='aaa';
*/
-- COMMIT => ROLLBACK => java (오토커밋)