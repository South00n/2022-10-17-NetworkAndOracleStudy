SELECT * FROM book; -- 책정보
SELECT * FROM customer; -- 사용자 정보
SELECT * FROM orders; -- 책 판매

DESC book;
/*
    BOOKID    NOT NULL NUMBER(2)    ==> 책 구분
    BOOKNAME           VARCHAR2(40) ==> 책 이름
    PUBLISHER          VARCHAR2(40) ==> 출판사
    PRICE              NUMBER(8)    ==> 가격
*/

DESC customer;
/*
    CUSTID  NOT NULL NUMBER(2)     ==> 구분자
    NAME             VARCHAR2(40)  ==> 이름
    ADDRESS          VARCHAR2(50)  ==> 주소
    PHONE            VARCHAR2(20)  ==> 전화
*/

DESC orders;
/*
    ORDERID   NOT NULL NUMBER(2) ==> 구분자 
    CUSTID             NUMBER(2) ==> 사용자 구분
    BOOKID             NUMBER(2) ==> 책 구분
    SALEPRICE          NUMBER(8) ==> 구매액
    ORDERDATE          DATE      ==> 구매일자
*/

SELECT name, address, phone, saleprice, orderdate, bookname, publisher, price
FROM customer, orders, book
WHERE customer.custid = orders.custid
AND book.bookid = orders.bookid;

-- View 제작 => SQL문장을 저장
CREATE OR REPLACE VIEW book_all
AS
SELECT name, address, phone, saleprice, orderdate, bookname, publisher, price
FROM customer, orders, book
WHERE customer.custid = orders.custid
AND book.bookid = orders.bookid;

SELECT * FROM book_all;
-- 디스크에 저장이 안된다 (보안 뛰어나다)
SELECT text FROM user_views WHERE view_name = 'BOOK_ALL';

DROP VIEW book_all;

/*
     1. TABLE : 데이터를 저장하는 공간
                SELECT / INSERT / UPDATE / DELETE
                CREATE / DROP / ALTER / RENAME / TRUNCATE
                ------ 제약조건
                NOT NULL : NULL값을 허용하지 않는다 (무조건 값을 필요로 한다)
                UNIQUE : 중복이 없는 값 (NULL값을 허용한다)
                PRIMARY KEY : 기본키 (ROW를 구분하는 데이터) => 수정/삭제시 데이터가 변질을 방지
                ----------- 특별한 경우가 아니면 숫자로 만들어져있다 (회원 : ID => 문자열)
                            ----------------------------------- 시퀀스
                FOREIGN KEY : 참조키 (같은 값을 가지고 있어야 한다 => JOIN)
                PRIMARY KEY <======> FOREIGN KEY
                            1 : N
                CHECK : 지정된 값만 첨부 => 라디오버튼 , 콤보
                DEFAULT : 제약조건은 아니다 => 값을 입력하지 않는 경우 => 자동 설정
                *** 제약조건
                    NOT NULL, DEFAULT => 컬럼뒤에 설정
                    CHECK, PRIMARY, UNIQUE, FOREIGN => 컬럼설정이 끝난 다음에 설정
                    CREATE TABLE table명 (
                        컬럼명 데이터형 [제약조건], => NOT NULL, DEFAULT
                        컬럼명 데이터형 [제약조건],
                        컬럼명 데이터형 [제약조건],
                        [제약조건] => CHECK, PRIMARY, UNIQUE, FOREIGN
                    )
     2. VIEW : 기존의 테이블을 참조 (테이블이 존재)
             => 한개 (단순뷰) => DML을 사용할 수 있다 => 사용빈도는 없다
             => 여러개 (복합뷰) ==> JOIN, SubQuery ==> 단점 : DML에 제약이 있다
                ----------------------------------------------------------- SQL문장을 만들어 저장후 재사용
             => 데이터가 저장이 된 상태가 아니기 때문에 보안이 좋다
             => 인라인뷰 : 테이블 대신에 SELECT를 이용해서 데이터를 추출 => Top-N 추출, 페이징
             => VIEW가 저장되는 위치 => user_views, user_tables, user_constraint
             => 수정과 동시에 생성
                CREATE OR REPLACE VIEW view_name
                AS
                SELECT ~~~
             => 삭제
                DROP VIEW view_name
             *** 보안, 자바프로그램에서 복잡한 SQL문장을 단순화
     3. SEQUENCE : 자동 증가 번호
             1) 생성
                => 생성시마다 따로 번호가 증가된다 : PRIMARY KEY(번호) => MAX() + 1
                CREATE SEQUENCE seq_name ==> 테이블명_컬럼명_seq
                    START WITH 1  ==> 시작번호
                    INCREMENT BY  ==> 증가
                    NOCYCLE       ==> 무한대
                    NOCACHE       ==> 저장하지 않고 바로 증가
             2) 삭제
                DROP SEQUENCE seq_name
             3) 현재저장된 값 : currval
             4) 다음값 : nextval
      -------------------------------------------------------------------------
            => INDEX / PL/SQL 기초
            => FUNCTION / PROCEDURE / TRIGGER
             
     
*/
