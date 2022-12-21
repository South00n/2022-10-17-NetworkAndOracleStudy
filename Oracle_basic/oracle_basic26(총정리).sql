/*
      DDL => 데이터 정의 언어
             1) 데이터 저장 장소 : table
             2) 가상 테이블 : 기존의 테이블을 참조해서(재사용) => 디스크에 저장되지 않는다 : view
             3) PRIMARY KEY (숫자) => 중복이 없는 데이터 첨부 : sequence
             4) 검색이나 정렬의 속도를 최적화 : index
             ------------------------------------------- 요구사항 (입문)
             5) SQL문장의 반복 => 함수화
                -> 함수를 만드는 언어 : PL/SQL
                -> 리턴형이 있는 함수 : function
                -> 리턴형이 없는 함수 : procedure
                -> 자동화 처리 : trigger
             ------------------------------------------- 사이트 모든 댓글 한개로 제작 (procedure)
        => 문자열로 명령문 => 구분해서 실행 (table, view, index, sequence -> 객체) -> CREATE (new in java)
           1) 생성 : CREATE / public class
           2) 수정 : ALTER  / 컴파일을 다시 (CTRL + F11)
           3) 삭제 : DROP   / GC (객체 = null)
           4) 이름 변경 : RENAME / class 이름 변경 => 리팩토링 (가독성)
           5) 데이터 잘라내기 : TRUNCATE / 초기화
           ---------------------------------------------------------
           1. CREATE
              형식)
                    CREATE TABLE table_name (
                        컬럼(멤버변수) 데이터형 [제약조건 => NOT NULL | DEFAULT], => 컬럼레벨
                        컬럼(멤버변수) 데이터형 [제약조건 => NOT NULL | DEFAULT],
                        컬럼(멤버변수) 데이터형 [제약조건 => NOT NULL | DEFAULT],
                        컬럼(멤버변수) 데이터형 [제약조건 => NOT NULL | DEFAULT],
                        컬럼(멤버변수) 데이터형 [제약조건 => NOT NULL | DEFAULT],
                        [제약조건 => PRIMARY KEY | FOREIGN KEY | CHECK | UNIQUE], => 테이블레벨
                        [제약조건]
                        ...
                    );
                    
                    1) table_name명, 컬럼명에 대한 문법 (식별자)
                        1. 문자로 시작 (알파벳, 한글) => 대소문자를 구분하지 않는다
                           => 단 저장시에 알파벳은 대문자로 저장이 된다 (테이블 검색시에는 반드시 대문자로 한다)
                           SELECT * FROM user_tables WHERE table_name = 'emp'; (X)
                           SELECT * FROM user_tables WHERE table_name = 'EMP'; (O)
                        2. table명은 30byte => 5byte => 5byte ~ 15byte (알파벳을 권장)
                        3. 숫자사용이 가능 (앞에 사용할 수 없다)
                        4. 키워드는 사용할 수 없다 (CREATE, DROP, INSERT, SELECT ...)
                        5. 특수문자 사용이 가능 ( _ ) ==> 두개단어가 있는 경우
                           genie_music, melon_music, daum_movie, naver_movie
                           seoul_location, seoul_hotel ...
                    2) 데이터형
                        문자형 : 글자수를 지정 (한글 1글자당 3byte)
                          = CHAR (1~2000 byte) : 고정바이트 (메모리 낭비 가능성) => 글자수와 상관없이 무조건 지정된 크기만큼 메모리에 저장
                                                 => 메모리 낭비가 많다
                                                 => 같은 글자수를 저장 (남자/여자, y/n)
                          = VARCHAR2 (1~4000 byte) : 가변 바이트 => 글자수에 따라 메모리 크기가 달라진다
                                                  => 크기를 약간 크게 잡는다
                            *** 오라클에서만 존재하는 데이터형
                          = CLOB : 가변 메모리, 대용량 데이터 첨부 => 4기가
                                   줄거리, 소개 .. 메뉴 .. 글쓰기 내용 ..
                        숫자형 : NUMBER
                          = 실수 => NUMBER(5,2)
                          = 정수 => NUMBER(4), NUMBER(10)
                          = 생략 => NUMBER => NUMBER(8, 2) => 정수만 저장이 가능, 실수도 저장이 가능
                        날짜형 : DATE, TIMESTAMP  // 기록경기
                          = 일반 날짜 저장 => DATE
                    3) 제약조건 : 이상현상(수정, 삭제, 추가) 방지목적, 정형화된 데이터 => 원하는 데이터만 추가가 가능
                       ------- 비정형화 데이터 (필요한/불필요한 => 혼합 => 필요한 데이터만 추출)
                                              => 자연어 처리, 통계, 확률 => AI
                       *** 모든 프로그램은 데이터 관리
                                         ---------- 메모리 / 파일 / DBMS (관리, 연결)
                                         ---------- XML(B2B, B2G, G2G => 공유(스프링)), **JSON(RESTFUL), JSONP, 클로저
                       = NOT NULL : 반드시 입력값이 존재
                         => 컬럼명 데이터명 CONSTRAINT 테이블명_컬럼명_nn NOT NULL (컬럼뒤에 설정)
                         => 컬럼명 데이터형 NOT NULL 도 가능하긴함 => 단점은 제어를 할 수 없기 때문에 => 테이블을 지우고 수정후에 다시 테이블 제작
                         => 예) 데이터 수집 => 데이터가 없는 경우
                       = UNIQUE : 중복이 없는 값 => NULL값을 허용 (대체키, 후보키) => email, tel ...
                         => 컬럼명 데이터형 CONSTRAINT 테이블명_컬럼명_uk UNIQUE
                         => 컬럼명 데이터형 UNIQUE
                       = PRIMARY KEY : 기본형 (테이블당 1개이상 포함 권장) => 수정, 삭제시에 문제가 없게 만든다
                                       회원 (문자열 : ID) => 아이디 중복체크, 기타는 => 숫자(영화번호, 댓글번호, 뮤직번호)
                                       => NOT NULL + UNIQUE
                         => 컬럼명 데이터형 CONSTRAINT 테이블명_컬럼명_pk PRIMARY KEY
                         *** => CONSTRAINT 테이블명_컬럼명_pk PRIMARY KEY(컬럼명)
                         => 컬럼명 데이터형 PRIMARY KEY
                       = CHECK : 저장할 데이터값을 지정 (지정된 데이터만 첨부)
                                 성별, 장르, 음식종류, 부서명, 근무지 ...
                         => CONSTRAINT 테이블명_컬럼명_ck CHECK(컬럼명 IN(값, 값...))
                       = FOREIGN KEY : 외래키, 참조키 (참조하는 테이블의 컬럼값만 사용이 가능)
                         JOIN / (PRIMARY KEY <==> FOREIGN KEY)
                         => 삭제시에 문제 발생 (참조해주는 테이블 / 참조하는 테이블)
                                                                ------------
                                                                     1               
                                             ----------------
                                                    2
                         => 게시물 / 댓글 (댓글 삭제, 게시글 삭제)
                         => CONSTRAINT 테이블명_컬럼명_fk FOREIGN KEY(컬럼명)
                            REFERENCES 테이블명(컬럼명)
                    = DEFAULT : 값을 입력하지 않은 경우에 자동으로 추가
                                => 날짜 : DEFAULT SYSDATE
                                => 조회수 : hit DEFAULT 0
*/  
-- DESC user_tables;
-- SELECT * FROM user_tables WHERE table_name = 'EMP';

-- 테이블 (지니뮤직) *******************************
-- liked, jjim => 장바구니, 구매
-- liked, jjim --> 테이블을 따로 만들어서 저장
/*
1. 구분자 (PK - 정수) 2. RANK 3. 등폭 (state, 증가or감사) 5. title 6. singer 7. album 8. 카테고리 9.key 10. hit
*/
CREATE TABLE genie_music (
    mno NUMBER,  -- pk
    cno NUMBER(2) CONSTRAINT gm_cno_nn NOT NULL,  -- nn
    title VARCHAR2(200) CONSTRAINT gm_title_nn NOT NULL, -- nn
    singer VARCHAR2(100) CONSTRAINT gm_singer_nn NOT NULL, -- nn
    album VARCHAR2(200) CONSTRAINT gm_album_nn NOT NULL, -- nn
    poster VARCHAR2(260) CONSTRAINT gm_poster_nn NOT NULL, -- nn
    state VARCHAR2(30), -- ck
    idcrement NUMBER(3) CONSTRAINT gm_id_nn NOT NULL, -- nn
    key VARCHAR2(30),
    hit NUMBER DEFAULT 0, -- default 0
    CONSTRAINT gm_mno_pk PRIMARY KEY(mno),
    CONSTRAINT gm_state_ck CHECK(state IN('유지', '상승', '하강'))
);
DESC genie_music;
-- ALTER => 이용
/*
        ALTER : 수정, 삭제, 추가 (컬럼, 제약조건 추가가 가능하다)
        -- 컬럼관련
        1) 추가
            ALTER TABLE table_name ADD 컬럼명 데이터형 [제약조건]
        2) 삭제
            ALTER TABLE table_name DROP COLUMN 컬럼
        3) 수정
            ALTER TABLE table_name MODIFY 컬럼명 데이터형 [제약조건]
            
        -- 제악조건
        1) 추가
            => PRIMARY KEY, FOREIGN KEY, CHECK, UNIQUE => ADD
        2) 삭제
            => DROP
        3) 수정 
            => NOT NULL ==> MODIFY
*/ -- 자동화 처리 (트리거)
ALTER TABLE genie_music ADD liked NUMBER;
ALTER TABLE genie_music ADD jjim NUMBER;

ALTER TABLE genie_music MODIFY liked DEFAULT 0 CONSTRAINT gm_liked_nn NOT NULL;
ALTER TABLE genie_music MODIFY jjim DEFAULT 0 CONSTRAINT gm_jjim_nn NOT NULL;

DESC genie_music;

/*
      테이블 만드는 순서
      웹사이트 => 데이터 추출
              => 크기결정
              => 제약조건
      ----------------------------- 부가적으로 추가 : ALTER, 제약조건 미흡한것도 ALTER로 추가
*/ -- *******************
-- Melon
CREATE TABLE melon_music (
    mno NUMBER,
    cno NUMBER(2) CONSTRAINT mm_cno_nn NOT NULL,
    title VARCHAR2(200) CONSTRAINT mm_title_nn NOT NULL,
    singer VARCHAR2(200) CONSTRAINT mm_singer_nn NOT NULL,
    album VARCHAR2(200) CONSTRAINT mm_album_nn NOT NULL,
    poster VARCHAR2(260) CONSTRAINT mm_poster_nn NOT NULL,
    state VARCHAR2(30),
    idcrement NUMBER(3) CONSTRAINT mm_id_nn NOT NULL,
    key VARCHAR2(30),
    hit NUMBER DEFAULT 0,
    liked NUMBER DEFAULT 0 CONSTRAINT mm_liked_nn NOT NULL,
    jjim NUMBER DEFAULT 0 CONSTRAINT mm_jjim_nn NOT NULL,
    CONSTRAINT mm_mno_pk PRIMARY KEY(mno),
    CONSTRAINT mm_state_ck CHECK(state in('유지', '상승', '하락'))
);

-- 삭제
-- DROP TABLE table_name
DROP TABLE genie_music;
DROP TABLE melon_music;
ROLLBACK; -- 복구 (DDL은 롤백안된다)
DESC genie_music;

-- 이름 변경
RENAME genie_music TO my_music;
DESC genie_music;
DESC my_music;
RENAME my_music TO genie_music;

-- 데이터 잘라내기 (테이블유지, 데이터만 삭제) => ROLLBACK을 사용할 수 없다
-- TRUNCATE TABLE table_name
TRUNCATE TABLE genie_music;

-- 테이블 제작 => 데이터 수집 => DML(SELECT, INSERT, UPDATE, DELETE : 복구가능)
-- 테이블에 대한 정보 확인
/*
     저장
      1) table => user_tables 
      2) constraint => user_constraint
      3) view => user_views
      ** 모든 명칭이 대문자로 저장돼있다
      
*/
SELECT owner, constraint_name, constraint_type, status
FROM user_constraints
WHERE table_name = 'GENIE_MUSIC';
/*
     TYPE
      - C => NOT NULL, CHECK
      - P => PRIMARY KEY
      - R => FOREIGN KEY
      - U => UNIQUE
*/
SELECT owner, constraint_name, table_name, column_name
FROM user_cons_columns
WHERE table_name = 'MELON_MUSIC';

-- FOREIGN KEY 연습
DROP TABLE test2;

-- PRIMARY KEY : 테이블당 1개만 생성 권장
-- 두개이상이 필요시에는 => UNIQUE 
-- FOREIGN KEY와 상관없이 독립적으로 사용시에 ON DELETE CASCADE
-- 테이블 : 10, 15~20
CREATE TABLE test1 (
    no NUMBER, 
    id VARCHAR2(20),
    name VARCHAR2(34) CONSTRAINT test1_name_nn NOT NULL,
    sex VARCHAR2(20),
    CONSTRAINT test1_no_pk PRIMARY KEY(no, id),
    CONSTRAINT test1_sex_ck CHECK(sex IN('남', '여'))
    --CONSTRAINT test1_id_uk UNIQUE(id)
);
INSERT INTO test1 VALUES(1, 'aaa', 'hong', '남');
INSERT INTO test1 VALUES(1, 'bbb', 'hong', '남');
INSERT INTO test1 VALUES(2, 'aaa', 'hong', '남');

CREATE TABLE test2 (
    no NUMBER,
    tno NUMBER,
    id VARCHAR2(20),
    address VARCHAR2(100) CONSTRAINT test2_addr_nn NOT NULL,
    tel VARCHAR2(20) CONSTRAINT test2_tel_nn NOT NULL,
    CONSTRAINT test2_no_pk PRIMARY KEY(no),
    CONSTRAINT test2_tno_fk FOREIGN KEY(tno)
    REFERENCES test1(no) ON DELETE CASCADE, -- UNIQUE나 PRIMARY KEY만 참조가 가능하다
    CONSTRAINT test2_id_fk FOREIGN KEY(id)
    REFERENCES test1(id) -- UNIQUE나 PRIMARY KEY만 참조가 가능하다
);

DROP TABLE test1;
DROP TABLE test2;


-- INSERT
/*
INSERT INTO test1 VALUES (1, '홍길동', '남');
INSERT INTO test1 VALUES (2, '심청이', '여');
COMMIT;
INSERT INTO test2 VALUES (1, 1, '서울', '010-1111-1111');
INSERT INTO test2 VALUES (2, 2, '서울', '010-2222-2222');
COMMIT;
DELETE FROM test1
WHERE no = 1;
SELECT * FROM test1;
*/

/*
     179page => 도표 (테이블 생성 명령어)
     180page => 문자열 데이터 (VARCHAR2)
     181page => 기본키 => PRIMARY KEY
     183page => 데이터형 (도표)
                NUMBER => 저장된 데이터에 따라서 (자바에서 int, double)
                  NUMBER ==> NUMBER(8, 2)
                                    -  -
                                   정수  소수점
                CHAR, VARCHAR2, CLOB => String
                DATE => java.util.Date;
                -------------------------------------------------
      ALTER => 184 ~ 185page
      DROP => 186page
*/
/*
        DML : 주로 웹프로그래머가 사용
        --------------------------- SELECT, INSERT, UPDATE, DELETE (CURD)
        INSERT : 데이터 추가 (자바)
        UPDATE : 데이터 수정
        DELETE : 데이터 삭제
        --------------------------- 정상 수행(저장) => COMMIT / 비정상 수행(취소) => ROLLBACK
                                    *** 자바에서는 AutoCommit
        1. INSERT
           형식)
                   = 전체 데이터 추가
                     INSERT INTO table_name VALUES(값 ...)
                         1) 값을 추가할때 오라클에 지정된 컬럼순서대로 추가
                         2) 값을 추가할때 오라클에 지정된 모든 갯수와 동일
                         --------------------------------------------- DESC table_name
                         3) 문자, 날짜데이터는 '' 추가
                   = 필요한 데이터 추가
                   *** NULL을 허용하거나, DEFAULT가 있는 경우
                   INSERT INTO table_name(컬럼, 컬럼...) VALUES(값, 값...)
                        1) 값을 추가할때 지정된 컬럼순서대로 추가
                        2) 값을 추가할때 지정된 갯수만큼 추가
                   = 웹 : 회원가입, 글쓰기, 댓글 올리기, 예매, 장바구니, 결재 ...
                   => 187page (형식), 188page
                   
        2. UPDATE : 데이터 수정
          형식) => 189page 맨 마지막줄
          UPDATE table_name
          SET 컬럼명 = 값, 컬럼명 = 값 ...
          ------------------------------ 전체 수정
          [WHERE 조건]
          ------------------------------ 조건에 맞는 데이터만 수정 (********)
          *** 문자 / 날짜 => ''를 사용한다
          *** 필요에 의하면 조건 제시할때 서브쿼리를 이용할 수 있다
          190 page => 일반 조건문, 서브쿼리 => 사원별로 급여 인상, 호봉변경 ....
                     ----------- 회원수정, 글쓰기 수정, 댓글 수정, 장바구니 변경, 예매일 변경
        3. DELETE : 데이터 삭제
           191page => 형식
           DELETE FROM table_name
           ------------------------ 전체 데이터 삭제
           [WHERE 조건]
           ------------------------ 조건에 맞는 데이터만 삭제
           => 회원 탈퇴, 댓글 지우기, 예매 취소, 구매 취소...
           -----------------------------------------------------
         INSERT, UPDATE, DELETE => 단점 바로 오라클에 적용되지 않는다
         적용 : COMMIT, 취소 : ROLLBACK
         --> 192page
         --> 프로그램언어를 이용해서 데이터 제어는 자동으로 저장
           
*/





