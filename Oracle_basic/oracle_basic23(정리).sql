SELECT * FROM book; -- å����
SELECT * FROM customer; -- ����� ����
SELECT * FROM orders; -- å �Ǹ�

DESC book;
/*
    BOOKID    NOT NULL NUMBER(2)    ==> å ����
    BOOKNAME           VARCHAR2(40) ==> å �̸�
    PUBLISHER          VARCHAR2(40) ==> ���ǻ�
    PRICE              NUMBER(8)    ==> ����
*/

DESC customer;
/*
    CUSTID  NOT NULL NUMBER(2)     ==> ������
    NAME             VARCHAR2(40)  ==> �̸�
    ADDRESS          VARCHAR2(50)  ==> �ּ�
    PHONE            VARCHAR2(20)  ==> ��ȭ
*/

DESC orders;
/*
    ORDERID   NOT NULL NUMBER(2) ==> ������ 
    CUSTID             NUMBER(2) ==> ����� ����
    BOOKID             NUMBER(2) ==> å ����
    SALEPRICE          NUMBER(8) ==> ���ž�
    ORDERDATE          DATE      ==> ��������
*/

SELECT name, address, phone, saleprice, orderdate, bookname, publisher, price
FROM customer, orders, book
WHERE customer.custid = orders.custid
AND book.bookid = orders.bookid;

-- View ���� => SQL������ ����
CREATE OR REPLACE VIEW book_all
AS
SELECT name, address, phone, saleprice, orderdate, bookname, publisher, price
FROM customer, orders, book
WHERE customer.custid = orders.custid
AND book.bookid = orders.bookid;

SELECT * FROM book_all;
-- ��ũ�� ������ �ȵȴ� (���� �پ��)
SELECT text FROM user_views WHERE view_name = 'BOOK_ALL';

DROP VIEW book_all;

/*
     1. TABLE : �����͸� �����ϴ� ����
                SELECT / INSERT / UPDATE / DELETE
                CREATE / DROP / ALTER / RENAME / TRUNCATE
                ------ ��������
                NOT NULL : NULL���� ������� �ʴ´� (������ ���� �ʿ�� �Ѵ�)
                UNIQUE : �ߺ��� ���� �� (NULL���� ����Ѵ�)
                PRIMARY KEY : �⺻Ű (ROW�� �����ϴ� ������) => ����/������ �����Ͱ� ������ ����
                ----------- Ư���� ��찡 �ƴϸ� ���ڷ� ��������ִ� (ȸ�� : ID => ���ڿ�)
                            ----------------------------------- ������
                FOREIGN KEY : ����Ű (���� ���� ������ �־�� �Ѵ� => JOIN)
                PRIMARY KEY <======> FOREIGN KEY
                            1 : N
                CHECK : ������ ���� ÷�� => ������ư , �޺�
                DEFAULT : ���������� �ƴϴ� => ���� �Է����� �ʴ� ��� => �ڵ� ����
                *** ��������
                    NOT NULL, DEFAULT => �÷��ڿ� ����
                    CHECK, PRIMARY, UNIQUE, FOREIGN => �÷������� ���� ������ ����
                    CREATE TABLE table�� (
                        �÷��� �������� [��������], => NOT NULL, DEFAULT
                        �÷��� �������� [��������],
                        �÷��� �������� [��������],
                        [��������] => CHECK, PRIMARY, UNIQUE, FOREIGN
                    )
     2. VIEW : ������ ���̺��� ���� (���̺��� ����)
             => �Ѱ� (�ܼ���) => DML�� ����� �� �ִ� => ���󵵴� ����
             => ������ (���պ�) ==> JOIN, SubQuery ==> ���� : DML�� ������ �ִ�
                ----------------------------------------------------------- SQL������ ����� ������ ����
             => �����Ͱ� ������ �� ���°� �ƴϱ� ������ ������ ����
             => �ζ��κ� : ���̺� ��ſ� SELECT�� �̿��ؼ� �����͸� ���� => Top-N ����, ����¡
             => VIEW�� ����Ǵ� ��ġ => user_views, user_tables, user_constraint
             => ������ ���ÿ� ����
                CREATE OR REPLACE VIEW view_name
                AS
                SELECT ~~~
             => ����
                DROP VIEW view_name
             *** ����, �ڹ����α׷����� ������ SQL������ �ܼ�ȭ
     3. SEQUENCE : �ڵ� ���� ��ȣ
             1) ����
                => �����ø��� ���� ��ȣ�� �����ȴ� : PRIMARY KEY(��ȣ) => MAX() + 1
                CREATE SEQUENCE seq_name ==> ���̺��_�÷���_seq
                    START WITH 1  ==> ���۹�ȣ
                    INCREMENT BY  ==> ����
                    NOCYCLE       ==> ���Ѵ�
                    NOCACHE       ==> �������� �ʰ� �ٷ� ����
             2) ����
                DROP SEQUENCE seq_name
             3) ��������� �� : currval
             4) ������ : nextval
      -------------------------------------------------------------------------
            => INDEX / PL/SQL ����
            => FUNCTION / PROCEDURE / TRIGGER
             
     
*/
