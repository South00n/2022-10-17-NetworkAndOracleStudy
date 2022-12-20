/*
    -- 284page 문법
    SQL
     - DML
     - DQL 
     - DDL ==> 테이블명, 컬럼명, 제약조건, 데이터형 ==> 기존 테이블은 제작이 가능해야된다
     - DCL
     - TCL
    응용프로그램
      - 오라클 => DBA
      - 자바 (O) ======> 함수, 트리거,프로시저
    데이터베이스 설계 => DBA
    ==> VIEW / SEQUENCE
    요구사항
      1) Back-End
      2) Front-End
      3) 툴 사용
    -----------------------------------------------------------------------------
    
        PL/SQL
          => 프로시저, 함수, 트리거
          1) 데이터형, 변수 (매개변수, 지역변수)
            --------------
            1. 스칼라 변수 : 일반 오라클 데이터형 사용
                            문자 / 숫자 / 날짜
                                        ---- DATE
                                  ---- NUMBER
                            --- CHAR,VARCHER2,CLOB
               변수 데이터형
                예) no NUMBER
                    name VARCHAR2(20)
            2. %TYPE : 실제 테이블에 설정된 데이터형 읽어 온다 (가장 많이 사용)
                예)
                      empno NUMBER(4)
                      vempno emp.empno%TYPE
                             -------------- NUMBER(4)
                             테이블명.컬럼명%TYPE
            3. %ROWTYPE : 테이블 전체의 데이터형을 가지고 올 때 ==> ~VO
                          => 한개의 테이블 컬럼 (JOIN, SubQuery는 사용할 수 없는 경우도 있다)
               예)
                    emp : empno NUMBER(4), ename VARCHAR2(20), job ... (8개)
                    vemp emp%ROWTYPE
                         ----------- 테이블이 가지고있는 모든 컬럼의 데이터형을 가지고온다
                         테이블명%ROWTYPE
            4. RECORD : 사용자 정의 (테이블 여러개를 묶어서 데이터 제어)
               ------ JOIN/SubQuery
               형식)
                     TYPE 변수명 IS RECORD (
                        필요한 데이터 설정 ...
                        ...
                        ...
                        ...
                     )
            -----------------------------------------------------↑ 단점 (ROW 1개에 대한 데이터만 저장이 가능)
            5. CURSOR : 전체 ROW에 대한 데이터를 저장할 수 있는 변수
               형식)
                        CURSOR cur명 IS (SELECT가 실행된 결과값을 cur가 가지고있는다)
                            SELECT ~~ ==> View와 유사
          2) 연산처리
                산술연산자, 논리연산자, 비교연산자, 대입연산자, NOT, IN, BETWEEN ~ AND, LIKE, NULL
                                                --------
                                                  :=
          3) 제어문
             조건문
                = 단일 조건
                    IF 조건문 THEN
                       실행문장
                    END IF;
                = 선택 조건
                    IF 조건문 TEHN
                        실행문장
                    ELSE
                        실행문장
                    END IF;
                = 다중 조건
                    IF 조건문 THEN
                        실행문장
                    ELSIF 조건문 THEN
                        실행문장
                    ELSIF 조건문 THEN
                        실행문장
                    ELSE
                        실행문장
                    END IF;
                = 선택문
                    CASE
                        WHEN 조건문 TEHN
                            실행문장
                        WHEN 조건문 TEHN
                            실행문장
                        WHEN 조건문 TEHN
                            실행문장
                        ELSE
                            실행문장
                    END;
             반복문
                = WHILE ==> BREAK, CONTINUE 잘 안씀
                    변수(초기화)
                    WHILE (조건문) LOOP
                        반복 처리문장
                        변수 증감식 (++, --가 없다)
                        no = no + 1;
                    END LOOP;
                = FOR                    (1..9 , 1..100)
                    FOR 변수 IN (REVERSE) lo..hi LOOP
                        처리문장
                    END LOOP
          4) 형식
              = 프로시저 : 일반 기능 (INSERT, UPDATE, DELETE, SELECT, 페이징) => 재사용 => 댓글
                          맛집, 여행, 레시피 ==> 
                CREATE [OR REPLACE] PROCEDURE pro_name (
                    매개변수
                )
                IS(AS)
                    지역변수
                ---------------------------------------- 선언부
                BEGIN
                    구현부 : SQL
                
                END;
                /
              = 사용자 정의 함수 => SubQuery를 대체 (SELECT, WHERE) => 결과값이 반드시 필요
                CREATE [OR REPLACE] FUNCTION func_name (
                    매개변수
                ) RETURN 데이터형
                IS(AS)
                    지역변수
                BEGIN
                    구현부
                    RETURN 값
                END;
                /
              = 트리거
                - 자동 이벤트 처리
                - 미리 설정된 조건에 맞는 경우에 실행 (오라클 자체에서 실행 => 자바에서 호출하지 않는다)
                - INSERT, UPDATE, DELETE에서만 사용이 가능
                - 입고 => INSERT => 재고 (자동 변경)
                - 출고 => INSERT => 재고 (자동 변경)
                - 형식)
                    CREATE [OR REPLACE] TRIGGER tri_name
                    BEFORE | AFTER (INSERT | UPDATE | DELETE) ON table_name
                    FOR EACH -- 전체 ROW에 대한 처리
                    ---------------------------------------------------------- 설정
                    DECLARE
                        변수 선언 --> 설정할 변수가 없는 경우 (생략이 가능)
                    BEGIN -- (
                        구현
                    END; -- )
                    /
                    ----------------------------------------------------------
                    
                    = 삭제
                        DROP TRIGGER tri_name
                    = 수정
                        ALTER TRIGGER tri_name => 사용빈도가 적용 => OR REPLACE를 사용
                        
                        영화 / 맛집 / 책 ...
                        찜 ==> jjim에 저장 ==> 영화 테이블 jjim count증가
*/
CREATE TABLE 상품 (
    품번 NUMBER,
    상품명 VARCHAR2(30),
    단가 NUMBER
);
CREATE TABLE 입고 (
    품번 NUMBER,
    수량 NUMBER,
    금액 NUMBER
);
CREATE TABLE 출고 (
    품번 NUMBER,
    수량 NUMBER,
    금액 NUMBER
);
CREATE TABLE 재고 (
    품번 NUMBER,
    수량 NUMBER,
    금액 NUMBER,
    누적금액 NUMBER
);

-- 상품
INSERT INTO 상품 VALUES(100, '새우깡', 1500);
INSERT INTO 상품 VALUES(200, '감자깡', 1000);
INSERT INTO 상품 VALUES(300, '맛동산', 2000);
INSERT INTO 상품 VALUES(400, '짱구', 500);
INSERT INTO 상품 VALUES(500, '고구마깡', 2500);
COMMIT;
-- 입고시에 재고를 처리
/*
    입고 ==> 재고 (상품이 존재하는지 확인)
            1. 존재 : UPDATE - 수량추가
            2. 미존재 : INSERT - 값 추가
    출고 ==> 재고 (상품의 갯수가 몇개?)
            1. 0개 : DELETE - 삭제
            2. 0보다 크면 : UPDATE - 수량감소
            
            => INSERT, UPDATE, DELETE에서 들어오는 값 :NEW.품번
                INSERT INTO 입고 VALUE(100, 10, 1500)
                                      ---  --- -----
                                        :NEW.품번
                                        :NEW.수량
                                        :NEW.금액
                                        
            => 기존 재고 테이블에 있는 컬럼값을 읽을 때
                                        :OLD.품번
                                        :OLD.수량
                                        :OLD.금액
*/ -- 이걸 자동화 처리
CREATE OR REPLACE TRIGGER input_trigger
AFTER INSERT ON 입고
FOR EACH ROW
DECLARE
    v_cnt NUMBER := 0;
BEGIN
    SELECT COUNT(*) INTO v_cnt
    FROM 재고
    WHERE 품번 = :NEW.품번; -- :NEW = INSERT했던 값을 가져온다

    IF v_cnt = 0 THEN -- 기존의 상품이 없는 경우 처리
     -- INSERT
     INSERT INTO 재고 VALUES(:NEW.품번, :NEW.수량, :NEW.금액, :NEW.수량*:NEW.금액);
    ELSE -- 기존의 상품이 존재
     -- UPDATE
     UPDATE 재고 SET
     수량 = 수량 + :NEW.수량,
     누적금액 = 누적금액 + (:NEW.수량*:NEW.금액)
     WHERE 품번 = :NEW.품번;
     -- 주의점 : AutoCommit수행 => COMMIT을 사용하면 오류발생
    END IF;
END;
/

INSERT INTO 입고 VALUES(100,3,1500);
SELECT * FROM 입고;
SELECT * FROM 재고;

-- 출고 : UPDATE/DELETE
CREATE OR REPLACE TRIGGER output_trigger
AFTER INSERT ON 출고
FOR EACH ROW

DECLARE
    v_cnt NUMBER := 0;
BEGIN
    SELECT 수량 INTO v_cnt
    FROM 재고
    WHERE 품번 = :NEW.품번;
    
    IF :NEW.수량 = v_cnt THEN
        -- 처리 => 재고가 없는 상태 => DELETE
        DELETE FROM 재고
        WHERE 품번 = :NEW.품번;
    ELSE
        -- 처리 => 남아있는 재고, 누적금액에서 빼야됨
        UPDATE 재고 SET
        수량 = 수량 - :NEW.수량,
        누적금액 = 누적금액 - :NEW.수량 * :NEW.금액
        WHERE 품번 = :NEW.품번;
    END IF;
END;
/

SELECT * FROM 재고;
INSERT INTO 출고 VALUES(100,4,1500);


DESC seoul_location;
DESC seoul_nature;
DESC seoul_shop;
DESC seoul_guest;
DESC seoul_hotel;

DESC food_location;

SELECT fno, name, poster, score, num 
FROM (SELECT fno, name, poster, score, rownum as num
FROM (SELECT /*+ INDEX_ASC(food_location pk_food_location)*/fno, name, poster, score
FROM food_location))
WHERE num BETWEEN 1 AND 20;