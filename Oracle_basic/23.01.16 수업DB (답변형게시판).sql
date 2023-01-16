-- �亯�� �Խ���
CREATE TABLE replyBoard(
    no NUMBER,
    name VARCHAR2(34) CONSTRAINT rb_name_nn NOT NULL,
    subject VARCHAR2(4000) CONSTRAINT rb_sub_nn NOT NULL,
    content CLOB CONSTRAINT rb_cont_nn NOT NULL,
    pwd VARCHAR2(10) CONSTRAINT rb_pwd_nn NOT NULL,
    regdate DATE DEFAULT SYSDATE,
    hit NUMBER DEFAULT 0,
    group_id NUMBER, -- �亯 �׷�
    group_step NUMBER DEFAULT 0, -- �亯 ����
    group_tab NUMBER DEFAULT 0, -- �亯 ��
    root NUMBER DEFAULT 0, -- �亯�� ��� �پ�����
    depth NUMBER DEFAULT 0, -- �亯�� �����
    CONSTRAINT rb_no_pk PRIMARY KEY(no)
);

CREATE SEQUENCE rb_no_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;
/*
    group_id : �亯 �׷�
                         group_id    group_step    groupt_tab    root    depth 
        1AAAAAA              1           1             0          0        2           
          => 2BBBBBB         1           2             1          1        0
          => 3CCCCCC         1           3             1          1        1
             => 4DDDDDDDD    1           4             2          3        0
             
        EEEEEE              2           1             0
          =>KKKKKK          2           2             1
    group_step
    group_tab
    root
    depth
    414page
*/ 

DESC replyboard;
INSERT INTO replyboard(no,name,subject,content,pwd,group_id)
VALUES(rb_no_seq.nextval, 'ȫ�浿', '�亯���Խ���', '�亯���Խ��� = Chapter 15��', '1234', 1);
INSERT INTO replyboard(no,name,subject,content,pwd,group_id)
VALUES(rb_no_seq.nextval, 'ȫ�浿', '�亯���Խ���', '�亯���Խ��� = Chapter 15��', '1234', 2);
INSERT INTO replyboard(no,name,subject,content,pwd,group_id)
VALUES(rb_no_seq.nextval, 'ȫ�浿', '�亯���Խ���', '�亯���Խ��� = Chapter 15��', '1234', 3);
INSERT INTO replyboard(no,name,subject,content,pwd,group_id)
VALUES(rb_no_seq.nextval, 'ȫ�浿', '�亯���Խ���', '�亯���Խ��� = Chapter 15��', '1234', 4);
INSERT INTO replyboard(no,name,subject,content,pwd,group_id)
VALUES(rb_no_seq.nextval, 'ȫ�浿', '�亯���Խ���', '�亯���Խ��� = Chapter 15��', '1234', 5);
INSERT INTO replyboard(no,name,subject,content,pwd,group_id)
VALUES(rb_no_seq.nextval, 'ȫ�浿', '�亯���Խ���', '�亯���Խ��� = Chapter 15��', '1234', 6);
INSERT INTO replyboard(no,name,subject,content,pwd,group_id)
VALUES(rb_no_seq.nextval, 'ȫ�浿', '�亯���Խ���', '�亯���Խ��� = Chapter 15��', '1234', 7);
INSERT INTO replyboard(no,name,subject,content,pwd,group_id)
VALUES(rb_no_seq.nextval, 'ȫ�浿', '�亯���Խ���', '�亯���Խ��� = Chapter 15��', '1234', 8);
INSERT INTO replyboard(no,name,subject,content,pwd,group_id)
VALUES(rb_no_seq.nextval, 'ȫ�浿', '�亯���Խ���', '�亯���Խ��� = Chapter 15��', '1234', 9);
INSERT INTO replyboard(no,name,subject,content,pwd,group_id)
VALUES(rb_no_seq.nextval, 'ȫ�浿', '�亯���Խ���', '�亯���Խ��� = Chapter 15��', '1234', 10);
-- �亯
INSERT INTO replyboard(no,name,subject,content,pwd,group_id, group_step, group_tab)
VALUES(rb_no_seq.nextval, 'ȫ�浿', '�亯���Խ���', '�亯���Խ��� = Chapter 15��', '1234', 10, 1, 1);
INSERT INTO replyboard(no,name,subject,content,pwd,group_id,  group_step, group_tab)
VALUES(rb_no_seq.nextval, 'ȫ�浿', '�亯���Խ���', '�亯���Խ��� = Chapter 15��', '1234', 10, 2, 2);
COMMIT;

desc seoul_location;
desc food_location;
select * from food_location;