/*
    1. DQL
       = SELECT : ������ �˻�
         ����)
              SELECT * | column1, column2 .. ==========> 5
              FROM table_name | SELECT ~  ============> 1
              [
                 WHERE ���ǹ� ============> 2
                 GROUP BY �÷���|�Լ� =====> 3
                 HAVING �����Լ� ==========> 4
                 ORDER BY �÷���|�Լ���|�÷��� ��ġ��ȣ (ASC|DESC => ASC ��������) ===> 6
              ]
              
              �������� 
              ------- SQL ������ �����ؼ� �ѹ��� ������ ����
              MainQuery = (SubQuery)
                           -------- ������� MainQuery�� ������ ����
              = �Ϲ� ��������
                = ������ �������� (�÷� 1, �� 1)
                SELECT ~~
                FROM table_name --- ��������
                WHERE �÷��� = (SELECT �÷� ~~)
                               ----- ��������(����� 1���� ���)
                = ������ �������� (�÷� 1, �� ������)
                SELECT ~~
                FROM table_name
                WHERE �÷��� IN (SELECT ~ )
                
                SELECT ~~
                FROM table_name
                WHERE �÷��� > ANY(SELECT ~ ) | SOME(SELECT ~ ) | ALL(SELECT ~ )
                
                SELECT ~~
                FROM table_name
                WHERE �÷��� < ANY(SELECT ~ ) | SOME(SELECT ~ ) | ALL(SELECT ~ )
              = ��Į�� �������� : �÷���� ��� (�ٸ� ���̺��� �����͸� �о� �ö�) ==> JOIN ��� ���
                 * �˻��ӵ��� ������, �ҽ��ڵ��� ���
                 SELECT �÷���, (SELECT ~) => ������ ������� 1���� ����
                 FROM table_name
              = �ζ��κ� : ���̺��� ��� ==> FROM SELECT ~~
                SELECT ~~ (������ �÷��� ����� ����)
                FROM (SELECT ~ )
                      --------- ������ �÷�
                rownum : ������ �߰��Ҷ����� �� ROW�� ����Ŭ���� ������ ��ȣ (1�� ����)
                         ���ϴ� ������ŭ ���, ����, ���� �󼼺��� (�׻� ������)
                ������ �پ�� (���� ���̺�) => ������ ó�� (Top-N) => �α���� 10 ...
               *** �ڹٿ��� DB���� => �� ���α׷��� �ٽ� (Front-End, Back-End)
               -------------
                 JDBC ==> ��(DBCP) ==> ORM ==> Mapper
                                      ---------------
                                      ORM : MyBatis / Hibernate
                                      => JPA
                                      SELECT * FROM emp WHERE empno = 7788;
                                      findByEmpno(int empno)
                                      save()
             JOIN
             ----------------------------- ���̺� ������ => �����͸� ���� (������ ����)
             INNER JOIN (������ ==> �÷��� ���� ���� ��쿡 ������ ����) => NULL���� �ְų� ��Ī�� �ȵǴ� ��� (������ �� ����) 
                  10        10
                  20        20
                  30        30
                            40 ==> ����Ұ� => ������ �����ϰ� ����� ��� -> Outer JOIN
                = ����)
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
                    ------------------------------------------- Admin (������)
                    => ��Ÿ���� (������, �����Լ�)
                
    2. DDL
        = ���� CREATE
          1) ���̺�(������ ���� ���) => ����
             CREATE TABLE table_name (
                �÷��� �������� [��������], ==> NOT NULL , DEFAULT
                �÷��� �������� [��������],
                �÷��� �������� [��������],
                [��������] => PRIMARY KEY, FOREIGN KEY, CHECK, UNIQUE
             )
             table_name , column_name �ĺ���
             ----------------
              1. ���ڷ� ���� (���ĺ�, �ѱ�) => ���ĺ��� ��ҹ��ڸ� �������� �ʴ´� (����Ŭ�� ����ÿ��� �빮�ڷ� ����)
                 ** ���̺� �˻��ÿ��� �빮�ڷ� ����
                 WHERE table_name = 'EMP'
                 *** SQL������ ��ҹ��ڸ� �������� �ʴ´� (��, ����� �����ʹ� ��ҹ��ڸ� �����Ѵ�)
                     ------ UPPER, LOWER
              2. ���ڴ� ����� ���� (�տ� ����� �� ����)
              3. Ư������ ����� ���� (�ܾ 2���̻�) ==> _ foodHouse => food_house
              4. Ű����� ����� �� ���� (SELECT, INSERT ...)
              5. ���̺��� �÷����� �����ϰ� �� �� �ִ�
              *** ���̺���� (30��) ==> 5 ~ 15 => ���ĺ� ����
            ��������
            --------
              ������ => ������ ������ ����
                 CHAR (1~2000byte)
                 VARCHAR2 (1~4000byte)
                 CLOB(4�Ⱑ)
              ������
                 NUMBER(4), NUMBER => NUMBER(8, 2)
                 --------- NUMBER(38, -128)
                 int, double
              ��¥��
                 DATE
            
            ��������
            --------
              1. NOT NULL => �ݵ�� �Է°��� �־�� �ȴ�
              2. UNIQUE => �ĺ�Ű, ��üŰ (NULL���� ���) => �ߺ��� ���� �� (��ȭ, �̸���)
              3. PRIMARY KEY(�⺻Ű) => NOT NULL + UNIQUE => �������� ������
                 ** ��� ���̺��� �⺻Ű �Ѱ� �̻��� �ʿ�� �Ѵ�
                    => NUMBER, ID(VARCHAR2) => ������ ���Ἲ
                                               ----------- ����, ��������
              4. FOREIGN KEY : �ٸ� ���̺��� �����Ͱ��� ���� (�ܷ�Ű, ����Ű)
                 => JOIN (�Խ��� <==> ���), (���� <==> ȸ������)
                                                  ID
              5. CHECK : ������ �����͸� ÷�ΰ� �����ϰ� ����� (�μ���, �ٹ���, ���� ...)
              6. DEFAULT : ���� �Է��� �ȵ� ��쿡 �����ϴ� ���� ����
                           DEFAULT SYSDATE, DEFAULT
              
              
          2) ���� ���̺� (��) => �б� ����
          3) INDEX : �ӵ�����ȭ ==> ORDER BY => INDEX_ASC , INDEX_DESC
          4) ������ : �ڵ� ������ȣ �����
          5) FUNCTION : �������� �ִ� �Լ� (���� �Լ�)
          6) PROCEDURE : ����� ������ �ִ� �Լ� (�������� ����) ****** PL/SQL �ٽ�
          7) TRIGGER : �̺�Ʈ (�ڵ�ȭ ó��)
          
        = ALTER : ����, ����, �߰� (���̺� ����)
                MODIFY DROP  ADD
                 ����) 
                      ALTER TABLE table_name ADD �÷��� �������� [��������]
                      ALTER TABLE table_name MODIFY �÷��� �������� [��������]
                      ALTER TABLE table_name DROP COLUMN �÷���
        = DROP : CREATE�� ������ ��� ���� DROP���� �����Ѵ�
                 ����) 
                      DROP TABLE table_name
                      DROP VIEW view_name
                      DROP FUNCTION func_name
        = TRUNCATE : ������ �߶󳻱� (���̺��� ����)
                 ����)
                      TRUNCATE TABLE table_name
        = RENAME : ���̺� �̸� ����
                 ����)
                      RENAME old_name TO new_name
    3. DML
        = ������ ���� ��� (����, ����, �߰�)
          INSERT
            = INSERT INTO table_name VALUES(��...)
                          table�� ������ �ִ� ��� �÷����� ����
                          ** NULL ==> NULL, ''
            = INSERT INTO table_name(�÷��� ...) VALUES(�� ...)
                                    -------- ���� ��ġ ------- (DEFAULT�� �ִ� ���)
              *** �ڵ�������ȣ => ���������� �̿��Ѵ�
          UPDATE
            = UPDATE table_name SET
              �÷��� = ��, �÷��� = �� ...
              [WHERE ����]
          DELETE
            = DELETE FROM table_name
              [WHERE ����]
    4. TCL
        => ���� ���� : COMMIT
        => ������ ��� : ROLLBACK
        ==> INSERT, UPDATE, DELETE => COMMIT�ʿ� (�ڹٴ� ����Ŀ��)
    ------------------- Basic
*/
-- ���� => CURD (�Խ���)
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

INSERT INTO freeboard(no, name, subject, content, pwd) VALUES(1, 'ȫ�浿', 'CURD����', 'CURD����...', '1234');
COMMIT;
SELECT * FROM freeboard;

INSERT INTO freeboard(no, name, subject, content, pwd) VALUES(2, 'ȫ�浿', 'CURD����', 'CURD����...', '1234');
INSERT INTO freeboard(no, name, subject, content, pwd) VALUES(3, 'ȫ�浿', 'CURD����', 'CURD����...', '1234');
INSERT INTO freeboard(no, name, subject, content, pwd) VALUES(4, 'ȫ�浿', 'CURD����', 'CURD����...', '1234');
INSERT INTO freeboard(no, name, subject, content, pwd) VALUES(5, 'ȫ�浿', 'CURD����', 'CURD����...', '1234');
INSERT INTO freeboard(no, name, subject, content, pwd) VALUES(6, 'ȫ�浿', 'CURD����', 'CURD����...', '1234');
INSERT INTO freeboard(no, name, subject, content, pwd) VALUES(7, 'ȫ�浿', 'CURD����', 'CURD����...', '1234');
INSERT INTO freeboard(no, name, subject, content, pwd) VALUES(8, 'ȫ�浿', 'CURD����', 'CURD����...', '1234');
INSERT INTO freeboard(no, name, subject, content, pwd) VALUES(9, 'ȫ�浿', 'CURD����', 'CURD����...', '1234');
INSERT INTO freeboard(no, name, subject, content, pwd) VALUES(10, 'ȫ�浿', 'CURD����', 'CURD����...', '1234');
INSERT INTO freeboard(no, name, subject, content, pwd) VALUES(11, 'ȫ�浿', 'CURD����', 'CURD����...', '1234');

desc zipcode;
