/*
        실제 프로젝트에 필요한 테이블 제작 -> 물리적 설계
 
        DDL
          => 생성 : CREATE
          => 수정 : ALTER
          => 삭제 : DROP
          => 이름 변경 : RENAME
          => 데이터 잘라내기 : TRUNCATE
    ---------------------------------------------
       제약조건
         = NOT NULL : NULL값을 허용하지 않는 경우
           컬럼명 데이터형 NOT NULL
           ---------------------- 나중에 제약조건 변경이나 삭제가 불가능
           컬럼명 데이터형 CONSTRAINT 테이블명_컬럼명_nn NOT NULL
           
         = UNIQUE : 대체키(후보키) -> 기본키를 찾는 경우에 사용 (email, phone)
                    중복이 없는 데이터를 설정 (Null값을 허용)
                컬럼을 선언 종료 후에
                CONSTRAINT 테이블명_컬럼명_uk UNIQUE(컬럼명)
                
         = PRIMARY KEY : NOT NULL + UNIQUE -> 기본키
                         테이블 제작시에는 1개 이상 권장 => 결정자
                CONSTRAINT 테이블명_컬럼명_pk PRIMARY KEY(컬럼명)
                
         = FOREIGN KEY : 참조키, 다른 테이블의 데이터를 찹조해서 연결
                         JOIN, 테이블 연결(매핑 테이블)
                CONSTRAINT 테이블명_컬럼명_fk FOREIGN KEY(컬럼명)
                REFERENCES 테이블명(컬럼명)
                
         = CHECK : 데이터를 지정한 후 지정된 데이터만 추가가 되게 만드는 제약조건
                CONSTRAINT 테이블명_컬럼명_ck CHECK(컬럼명 IN(값, 값...));
                
         = DEFAULT -> 제약조건이 아니다 -> 값이 입력이 안된 경우에 자동으로 추가 데이터 설정     
        
        
        형식)
            테이블명_1, 테이블명_2, 테이블명_3, 테이블명_4
            ---------------------------------------------------------
            
            CREATE TABLE table_name(
                컬럼명 데이터형 [제약조건],  -- NOT NULL, DEFAULT
                컬럼명 데이터형 [제약조건],
                컬럼명 데이터형 [제약조건],
                컬럼명 데이터형 [제약조건],
                컬럼명 데이터형 [제약조건],
                컬럼명 데이터형 [제약조건],
                [제약조건] -- PRIMARY KEY, FOREIGN KEY, CHECK, UNIQUE
            );
*/
/*
CREATE TABLE project_member(
    id VARCHAR2(20),
    pwd VARCHAR2(10) CONSTRAINT pm_pwd_nn NOT NULL,
    name VARCHAR2(34) CONSTRAINT pm_name_nn NOT NULL,
    sex VARCHAR(6),
    birthday VARCHAR2(15) CONSTRAINT pm_birthday_nn NOT NULL,
    email VARCHAR2(50),
    post VARCHAR2(7) CONSTRAINT pm_post_nn NOT NULL,
    addr1 VARCHAR2(200) CONSTRAINT pm_addr1_nn NOT NULL,
    addr2 VARCHAR2(200),
    phone VARCHAR2(20) CONSTRAINT pm_phone_nn NOT NULL,
    content CLOB,
    admin CHAR(1) DEFAULT 'n',
    regdate DATE DEFAULT SYSDATE,
    CONSTRAINT pm_id_pk PRIMARY KEY(id),
    CONSTRAINT pm_sex_ck CHECK(sex IN('남자','여자')),
    CONSTRAINT pm_email_uk UNIQUE(email),
    CONSTRAINT pm_phone_uk UNIQUE(phone),
    CONSTRAINT pm_admin_ck CHECK(admin IN('y', 'n'))
);
*/
-- 게시판 / 댓글
CREATE TABLE project_board(
    bno NUMBER,
    name VARCHAR2(34) CONSTRAINT pb_name_nn NOT NULL,
    subject VARCHAR2(4000)  CONSTRAINT pb_sub_nn NOT NULL,
    content CLOB CONSTRAINT pb_cont_nn NOT NULL,
    pwd VARCHAR2(10) CONSTRAINT pb_pwd_nn NOT NULL,
    regdate DATE DEFAULT SYSDATE,
    hit NUMBER DEFAULT 0,
    CONSTRAINT pb_bno_pk PRIMARY KEY(bno)
);
CREATE SEQUENCE pb_bno_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

CREATE TABLE project_reply(
    rno NUMBER,
    bno NUMBER,
    id VARCHAR2(20),
    name VARCHAR2(34) CONSTRAINT pr_name_nn NOT NULL,
    msg CLOB  CONSTRAINT pr_msg_nn NOT NULL,
    regdate DATE DEFAULT SYSDATE,
    group_id NUMBER CONSTRAINT pr_gi_nn NOT NULL,
    group_step NUMBER DEFAULT 0,
    group_tab NUMBER DEFAULT 0,
    root NUMBER DEFAULT 0,
    depth NUMBER DEFAULT 0,
    CONSTRAINT pr_rno_pk PRIMARY KEY(rno),
    CONSTRAINT pr_bno_fk FOREIGN KEY(bno)
    REFERENCES project_board(bno),
    CONSTRAINT pr_id_fk FOREIGN KEY(id)
    REFERENCES project_member(id)
);

CREATE SEQUENCE pr_rno_seq
    START WITH 1
    INCREMENT BY 1
    NOCYCLE
    NOCACHE;
-- 자료수집
CREATE TABLE project_category (
    cno NUMBER,
    title VARCHAR2(100) CONSTRAINT pc_title_nn NOT NULL,
    subject VARCHAR2(200) CONSTRAINT pc_subject_nn NOT NULL,
    poster VARCHAR2(300) CONSTRAINT pc_poster_nn NOT NULL,
    link VARCHAR2(200) CONSTRAINT pc_link_nn NOT NULL,
    CONSTRAINT pc_cno_pk PRIMARY KEY(cno)
);

CREATE SEQUENCE pc_cno_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;
-- 예약중심
CREATE TABLE project_food (
    fno NUMBER,
    cno NUMBER,
    poster VARCHAR2(1000) CONSTRAINT pf_poster_nn NOT NULL, -- 따로 테이블 제작하면 번거로우니 같이 넣어줬음 (DB설계는 분리하기 정규화한척)
    name VARCHAR2(100) CONSTRAINT pf_name_nn NOT NULL,
    score NUMBER(2,1) CONSTRAINT pf_score_nn NOT NULL,
    address VARCHAR2(250) CONSTRAINT pf_address_nn NOT NULL,
    tel VARCHAR2(20) CONSTRAINT pf_tel_nn NOT NULL,
    type VARCHAR2(100) CONSTRAINT pf_type_nn NOT NULL,
    price VARCHAR2(20),
    parking VARCHAR2(20),
    time VARCHAR2(20),
    menu VARCHAR2(500), -- 따로 테이블 제작하면 번거로우니 같이 넣어줬음 (DB설계는 분리하기 정규화한척)
    jjim_count NUMBER DEFAULT 0,
    like_count NUMBER DEFAULT 0,
    hit NUMBER DEFAULT 0,
    CONSTRAINT pf_fno_pk PRIMARY KEY(fno),
    CONSTRAINT pf_cno_fk FOREIGN KEY(cno)
    REFERENCES project_category(cno)
);

CREATE SEQUENCE pf_fno_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;
 -- 예약없이 검색용   
CREATE TABLE project_location_food (
    fno NUMBER,
    poster VARCHAR2(1000) CONSTRAINT plf_poster_nn NOT NULL, -- 따로 테이블 제작하면 번거로우니 같이 넣어줬음 (DB설계는 분리하기 정규화한척)
    name VARCHAR2(100) CONSTRAINT plf_name_nn NOT NULL,
    score NUMBER(2,1) CONSTRAINT plf_score_nn NOT NULL,
    address VARCHAR2(250) CONSTRAINT plf_address_nn NOT NULL,
    tel VARCHAR2(20) CONSTRAINT plf_tel_nn NOT NULL,
    type VARCHAR2(100) CONSTRAINT plf_type_nn NOT NULL,
    price VARCHAR2(20),
    parking VARCHAR2(20),
    time VARCHAR2(20),
    menu VARCHAR2(500), -- 따로 테이블 제작하면 번거로우니 같이 넣어줬음 (DB설계는 분리하기 정규화한척)
    jjim_count NUMBER DEFAULT 0,
    like_count NUMBER DEFAULT 0,
    hit NUMBER DEFAULT 0,
    CONSTRAINT plf_fno_pk PRIMARY KEY(fno)
);

CREATE SEQUENCE plf_fno_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

CREATE TABLE project_keyword(
    kno NUMBER,
    id VARCHAR2(20),
    keyword VARCHAR2(100) CONSTRAINT pk_keyword_nn NOT NULL,
    CONSTRAINT pk_kno_pk PRIMARY KEY(kno),
    CONSTRAINT pk_id_fk FOREIGN KEY(id)
    REFERENCES project_member(id)
);
CREATE SEQUENCE pk_kno_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;
SELECT * FROM tab;
/*
    레시피 / 레시피상세 / 레시피상품 (구매정보)
    서울여행
    ---------------------------- 좋아요 / 찜 / 댓글 (프로시저)
    예매 / 예약일 정보 / 예약시간정보
    ----------------------------
    묻고답하기, 자료실
    ----------------------  기본 틀
*/
-- 레시피
CREATE TABLE project_recipe (
    rno NUMBER,
    title VARCHAR2(500) CONSTRAINT pro_title_nn NOT NULL,
    poster VARCHAR2(260) CONSTRAINT pro_poster_nn NOT NULL,
    chef VARCHAR2(100) CONSTRAINT pro_chef_nn NOT NULL,
    hit NUMBER DEFAULT 0,
    jjim_count NUMBER DEFAULT 0,
    like_count NUMBER DEFAULT 0,
    CONSTRAINT pro_rno_pk PRIMARY KEY(rno)
);
-- 레시피 상세
CREATE TABLE project_recipe_detail(
    rno NUMBER,
    title VARCHAR2(100) CONSTRAINT prd_title_nn NOT NULL,
    poster VARCHAR2(260) CONSTRAINT prd_poster_nn NOT NULL,
    content VARCHAR2(1000) CONSTRAINT prd_content_nn NOT NULL,
    chef_name VARCHAR2(100) CONSTRAINT prd_cf_nn NOT NULL,
    chef_poster VARCHAR2(260) CONSTRAINT prd_cp_nn NOT NULL,
    info1 VARCHAR2(20) CONSTRAINT prd_info1_nn NOT NULL,
    info2 VARCHAR2(20) CONSTRAINT prd_info2_nn NOT NULL,
    info3 VARCHAR2(20) CONSTRAINT prd_info3_nn NOT NULL,
    food_data CLOB CONSTRAINT prd_fd_nn NOT NULL,
    food_make CLOB CONSTRAINT prd_fm_nn NOT NULL,
    chef_email VARCHAR2(100) CONSTRAINT prd_ce_nn NOT NULL,
    hashtag CLOB,
    CONSTRAINT prd_rno_fk FOREIGN KEY(rno)
    REFERENCES project_recipe(rno)
);
-- 쉐프, 지역맛집 ==> 검색(Ajax)
CREATE TABLE project_recipe_chef(
    cno NUMBER,
    chef_name VARCHAR2(100) CONSTRAINT prc_cn_nn NOT NULL,
    mem_cont1 NUMBER DEFAULT 0,
    mem_cont2 NUMBER DEFAULT 0,
    mem_cont7 NUMBER DEFAULT 0,
    mem_cont3 NUMBER DEFAULT 0,
    chef_poster VARCHAR2(260) CONSTRAINT prc_cp_nn NOT NULL,
    CONSTRAINT prc_cno_pk PRIMARY KEY(cno)
);
-- 상품 카테고리 전체, 베스트, 특가, 신상품
CREATE TABLE project_goods_category(
    cno NUMBER,
    cate_name VARCHAR2(30) CONSTRAINT pgc_name_nn NOT NULL,
    CONSTRAINT pgc_cno_pk PRIMARY KEY(cno)
);
-- 상품
CREATE TABLE project_recipe_goods(
    gno NUMBER,
    cno NUMBER,
    goods_name VARCHAR2(4000) CONSTRAINT prc_gn_nn NOT NULL,
    goods_content VARCHAR2(4000) CONSTRAINT prc_gc_nn NOT NULL,
    goods_price NUMBER CONSTRAINT prc_gp_nn NOT NULL,
    goods_percent NUMBER CONSTRAINT prc_gp2_nn NOT NULL,
    first_buy_price NUMBER CONSTRAINT prc_fb_nn NOT NULL,
    send VARCHAR2(30) CONSTRAINT prc_send_nn NOT NULL,
    account NUMBER CONSTRAINT prc_acc_nn NOT NULL,
    jjim_count NUMBER DEFAULT 0,
    like_count NUMBER DEFAULT 0,
    hit NUMBER DEFAULT 0,
    goods_poster VARCHAR2(260) CONSTRAINT prc_gpo_nn NOT NULL,
    CONSTRAINT prg_gno_pk PRIMARY KEY(gno),
    CONSTRAINT prg_cno_fk FOREIGN KEY(cno)
    REFERENCES project_goods_category(cno)
);
-- 구매 하기 (결제)
CREATE TABLE project_goods_buy(
    bno NUMBER,
    gno NUMBER,
    id VARCHAR2(20),
    account NUMBER,
    total_price NUMBER,
    buy_ok CHAR(1),
    CONSTRAINT pgb_bno_pk PRIMARY KEY(bno),
    CONSTRAINT pgb_gno_fk FOREIGN KEY(gno)
    REFERENCES project_recipe_goods(gno),
    CONSTRAINT pgb_account_ck CHECK(account>0),
    CONSTRAINT pgb_tp_ck CHECK(total_price>0),
    CONSTRAINT pgb_bo_ch CHECK(buy_ok IN('y', 'n'))
);
ALTER TABLE project_goods_buy ADD CONSTRAINT pgb_id_fk FOREIGN KEY(id)
REFERENCES project_member(id);
-- 장바구니 (DB) --> Session / Cookie -> 임시저장
-- 최신방문 => Cookie
-- 마이페이지 ==> 기존의 DB를 읽어온다 -> 댓글 / 찜하기 / 회원정보
-- 관리자 페이지 => 기존에 등록된 데이터를 관리

-- 여행 카테고리
CREATE TABLE project_seoul_category(
    cno NUMBER,
    cate_name VARCHAR2(20) CONSTRAINT psc_cn_nn NOT NULL,
    CONSTRAINT psc_cno_pk PRIMARY KEY(cno)
);
-- 서울여행
CREATE TABLE project_seoul (
    sno NUMBER,
    cno NUMBER,
    name VARCHAR2(100) CONSTRAINT ps_name_nn NOT NULL,
    poster VARCHAR2(260) CONSTRAINT ps_poster_nn NOT NULL,
    content CLOB,
    address VARCHAR2(300) CONSTRAINT ps_addr_nn NOT NULL,
    jjim_count NUMBER DEFAULT 0,
    like_count NUMBER DEFAULT 0,
    hit_count NUMBER DEFAULT 0,
    CONSTRAINT ps_sno_pk PRIMARY KEY(sno),
    CONSTRAINT ps_cno_fk FOREIGN KEY(cno)
    REFERENCES project_seoul_category(cno)
);

-- SELECT * FROM tab;

-- 묻고답하기 (관리자모드 / 사용자모드)
CREATE TABLE project_replyBoard(
    no NUMBER,
    name VARCHAR2(34) CONSTRAINT pro_re_name_nn NOT NULL,
    subject VARCHAR2(1000) CONSTRAINT pro_re_sub_nn NOT NULL,
    content CLOB CONSTRAINT pro_re_cont_nn NOT NULL,
    pwd VARCHAR2(10) CONSTRAINT pro_re_pwd_nn NOT NULL,
    regdate DATE DEFAULT SYSDATE,
    hit NUMBER DEFAULT 0,
    group_id NUMBER DEFAULT 0,
    group_step NUMBER DEFAULT 0,
    group_tab NUMBER DEFAULT 0,
    CONSTRAINT pro_re_no_pk PRIMARY KEY(no)
);
-- 업로드 / 다운로드 자료실
CREATE TABLE project_dataBoard(
    no NUMBER,
    name VARCHAR2(34) CONSTRAINT pro_data_name_nn NOT NULL,
    subject VARCHAR2(1000) CONSTRAINT pro_data_sub_nn NOT NULL,
    content CLOB CONSTRAINT pro_data_cont_nn NOT NULL,
    pwd VARCHAR2(10) CONSTRAINT pro_data_pwd_nn NOT NULL,
    regdate DATE DEFAULT SYSDATE,
    hit NUMBER DEFAULT 0,
    filename VARCHAR2(260),
    filesize NUMBER DEFAULT 0,
    CONSTRAINT pro_data_no_pk PRIMARY KEY(no)
);
-- 예매 관련
CREATE TABLE project_reserve_time (
    tno NUMBER,
    time VARCHAR2(20) CONSTRAINT prt_time_nn NOT NULL,
    CONSTRAINT prt_tno_pk PRIMARY KEY(tno)
);
CREATE TABLE project_reserve_dae (
    dno NUMBER,
    rdate NUMBER CONSTRAINT prd_rdate_nn NOT NULL,
    time VARCHAR2(20) CONSTRAINT prd_time_nn NOT NULL,
    CONSTRAINT prd_dno_pk PRIMARY KEY(dno)
);
CREATE TABLE project_reserve(
    rno NUMBER,
    fno NUMBER,
    id VARCHAR2(20),
    rdate VARCHAR2(20) CONSTRAINT pro_res_rdate_nn NOT NULL,
    rtime VARCHAR2(20) CONSTRAINT pro_res_rtime_nn NOT NULL,
    inwon NUMBER,
    reserve_no VARCHAR2(20) CONSTRAINT pro_res_ro_nn NOT NULL,
    ok CHAR(1),
    regdate DATE DEFAULT SYSDATE,
    CONSTRAINT pro_res_rno_pk PRIMARY KEY(rno),
    CONSTRAINT pro_res_fno_fk FOREIGN KEY(fno)
    REFERENCES project_food(fno),
    CONSTRAINT pro_res_id_fk FOREIGN KEY(id)
    REFERENCES project_member(id),
    CONSTRAINT pro_res_inwon_ck CHECK(inwon > 0)
);
-- 찜하기 / 좋아요 / 전체댓글
CREATE TABLE project_all_jjim(
    jno NUMBER,
    cate_no NUMBER,
    no NUMBER,
    id VARCHAR2(20),
    CONSTRAINT paj_jno_pk PRIMARY KEY(jno),
    CONSTRAINT paj_id_fk FOREIGN KEY(id)
    REFERENCES project_member(id)
);
CREATE TABLE project_all_like(
    lno NUMBER,
    cate_no NUMBER,
    no NUMBER,
    id VARCHAR2(20),
    CONSTRAINT pal_lno_pk PRIMARY KEY(lno),
    CONSTRAINT pal_id_fk FOREIGN KEY(id)
    REFERENCES project_member(id)
);
SELECT * FROM tab;
CREATE TABLE project_all_reply(
    rno NUMBER,
    cate_no NUMBER,
    no NUMBER,
    id VARCHAR2(20),
    name VARCHAR2(34) CONSTRAINT par_name_nn NOT NULL,
    msg CLOB CONSTRAINT par_msg_nn NOT NULL,
    regdate DATE DEFAULT SYSDATE,
    CONSTRAINT par_rno_pk PRIMARY KEY(rno),
    CONSTRAINT par_id_fk FOREIGN KEY(id)
    REFERENCES project_member(id)
);
-- 사이트 : 필수
/*
     1. 회원 : 아이디중복체크, 우편번호 검색
     2. 게시판 : CURD
     3. 공지사항 : 특정 USER
     -----------------------------------
*/
-- 공지사항
CREATE TABLE project_notice(
    no NUMBER,
    type NUMBER,
    name VARCHAR2(34) CONSTRAINT pro_no_name_nn NOT NULL,
    subject VARCHAR2(1000) CONSTRAINT pro_no_subject_nn NOT NULL,
    content CLOB CONSTRAINT pro_no_content_nn NOT NULL,
    regdate DATE DEFAULT SYSDATE,
    hit NUMBER DEFAULT 0,
    CONSTRAINT pro_no_pk PRIMARY KEY(no)
);

SELECT * FROM tab;
