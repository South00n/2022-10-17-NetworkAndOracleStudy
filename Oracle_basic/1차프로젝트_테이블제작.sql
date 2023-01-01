-- 회원정보
CREATE TABLE project_member_3 (
    id VARCHAR2(20),
    pwd VARCHAR2(10) CONSTRAINT pm_pwd_nn_3 NOT NULL,
    name VARCHAR2(34) CONSTRAINT pm_name_nn_3 NOT NULL,
    sex VARCHAR2(6),
    brithday VARCHAR2(20) CONSTRAINT pm_brithday_nn_3 NOT NULL,
    email VARCHAR2(50),
    post VARCHAR2(7) CONSTRAINT pm_post_nn_3 NOT NULL,
    addr1 VARCHAR2(200) CONSTRAINT pm_addr1_nn_3 NOT NULL,
    addr2 VARCHAR2(200),
    phone VARCHAR2(20) CONSTRAINT pm_phone_nn_3 NOT NULL,
    admin CHAR(1) DEFAULT 'n',
    CONSTRAINT pm_id_pk_3 PRIMARY KEY(id),
    CONSTRAINT pm_sex_ck_3 CHECK(sex IN('남자', '여자')),
    CONSTRAINT pm_email_uk_3 UNIQUE(email),
    CONSTRAINT pm_phone_uk_3 UNIQUE(phone),
    CONSTRAINT pm_admin_ck_3 CHECK(admin IN('y', 'n'))
);

-- 그림정보
CREATE TABLE project_picture_3 (
    ppno NUMBER,
    image VARCHAR2(260) CONSTRAINT pp_image_nn_3 NOT NULL,
    title VARCHAR2(150) CONSTRAINT pp_title_nn_3 NOT NULL,
    content CLOB,
    CONSTRAINT pp_ppno_pk_3 PRIMARY KEY(ppno)
);
CREATE SEQUENCE pp_ppno_seq_3
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

-- 전시회 예약
CREATE TABLE project_exhibition_reserve_3 (
    perno NUMBER,
    rdate VARCHAR2(30) CONSTRAINT per_rdate_nn_3 NOT NULL,
    rtime VARCHAR2(20) CONSTRAINT per_rtime_nn_3 NOT NULL,
    inwon NUMBER CONSTRAINT per_inwon_nn_3 NOT NULL,
    ok VARCHAR2(10) CONSTRAINT per_ok_nn_3 NOT NULL,
    peno NUMBER,
    id VARCHAR2(20),
    CONSTRAINT per_perno_pk_3 PRIMARY KEY(perno),
    CONSTRAINT per_inwon_ck_3 CHECK(inwon > 0),
    CONSTRAINT per_peno_fk_3 FOREIGN KEY(peno)
    REFERENCES project_exhibition_3(peno),
    CONSTRAINT per_id_fk_3 FOREIGN KEY(id)
    REFERENCES project_member_3(id)
);

-- 예약날짜
CREATE TABLE project_reserve_date_3 (
    prdno NUMBER,
    rdate NUMBER CONSTRAINT prd_radte_nn_3 NOT NULL,
    time VARCHAR2(30) CONSTRAINT prd_radte_nn_3 NOT NULL,
    perno NUMBER,
    CONSTRAINT prd_prdno_pk_3 PRIMARY KEY(prdno),
    CONSTRAINT prd_perno_fk_3 FOREIGN KEY(perno)
    REFERENCES project_exhibition_reserve_3(perno)
);

-- 예약시간
CREATE TABLE project_reserve_time_3 (
    prtno NUMBER,
    time VARCHAR2(10) CONSTRAINT prt_time_nn_3 NOT NULL,
    prdno NUMBER,
    CONSTRAINT prt_prtno_pk_3 PRIMARY KEY(prtno),
    CONSTRAINT prt_prdno_fk_3 FOREIGN KEY(prdno)
    REFERENCES project_reserve_date_3(prdno)
);
