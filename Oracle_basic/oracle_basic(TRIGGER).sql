/*
    -- 284page ����
    SQL
     - DML
     - DQL 
     - DDL ==> ���̺��, �÷���, ��������, �������� ==> ���� ���̺��� ������ �����ؾߵȴ�
     - DCL
     - TCL
    �������α׷�
      - ����Ŭ => DBA
      - �ڹ� (O) ======> �Լ�, Ʈ����,���ν���
    �����ͺ��̽� ���� => DBA
    ==> VIEW / SEQUENCE
    �䱸����
      1) Back-End
      2) Front-End
      3) �� ���
    -----------------------------------------------------------------------------
    
        PL/SQL
          => ���ν���, �Լ�, Ʈ����
          1) ��������, ���� (�Ű�����, ��������)
            --------------
            1. ��Į�� ���� : �Ϲ� ����Ŭ �������� ���
                            ���� / ���� / ��¥
                                        ---- DATE
                                  ---- NUMBER
                            --- CHAR,VARCHER2,CLOB
               ���� ��������
                ��) no NUMBER
                    name VARCHAR2(20)
            2. %TYPE : ���� ���̺� ������ �������� �о� �´� (���� ���� ���)
                ��)
                      empno NUMBER(4)
                      vempno emp.empno%TYPE
                             -------------- NUMBER(4)
                             ���̺��.�÷���%TYPE
            3. %ROWTYPE : ���̺� ��ü�� ���������� ������ �� �� ==> ~VO
                          => �Ѱ��� ���̺� �÷� (JOIN, SubQuery�� ����� �� ���� ��쵵 �ִ�)
               ��)
                    emp : empno NUMBER(4), ename VARCHAR2(20), job ... (8��)
                    vemp emp%ROWTYPE
                         ----------- ���̺��� �������ִ� ��� �÷��� ���������� ������´�
                         ���̺��%ROWTYPE
            4. RECORD : ����� ���� (���̺� �������� ��� ������ ����)
               ------ JOIN/SubQuery
               ����)
                     TYPE ������ IS RECORD (
                        �ʿ��� ������ ���� ...
                        ...
                        ...
                        ...
                     )
            -----------------------------------------------------�� ���� (ROW 1���� ���� �����͸� ������ ����)
            5. CURSOR : ��ü ROW�� ���� �����͸� ������ �� �ִ� ����
               ����)
                        CURSOR cur�� IS (SELECT�� ����� ������� cur�� �������ִ´�)
                            SELECT ~~ ==> View�� ����
          2) ����ó��
                ���������, ��������, �񱳿�����, ���Կ�����, NOT, IN, BETWEEN ~ AND, LIKE, NULL
                                                --------
                                                  :=
          3) ���
             ���ǹ�
                = ���� ����
                    IF ���ǹ� THEN
                       ���๮��
                    END IF;
                = ���� ����
                    IF ���ǹ� TEHN
                        ���๮��
                    ELSE
                        ���๮��
                    END IF;
                = ���� ����
                    IF ���ǹ� THEN
                        ���๮��
                    ELSIF ���ǹ� THEN
                        ���๮��
                    ELSIF ���ǹ� THEN
                        ���๮��
                    ELSE
                        ���๮��
                    END IF;
                = ���ù�
                    CASE
                        WHEN ���ǹ� TEHN
                            ���๮��
                        WHEN ���ǹ� TEHN
                            ���๮��
                        WHEN ���ǹ� TEHN
                            ���๮��
                        ELSE
                            ���๮��
                    END;
             �ݺ���
                = WHILE ==> BREAK, CONTINUE �� �Ⱦ�
                    ����(�ʱ�ȭ)
                    WHILE (���ǹ�) LOOP
                        �ݺ� ó������
                        ���� ������ (++, --�� ����)
                        no = no + 1;
                    END LOOP;
                = FOR                    (1..9 , 1..100)
                    FOR ���� IN (REVERSE) lo..hi LOOP
                        ó������
                    END LOOP
          4) ����
              = ���ν��� : �Ϲ� ��� (INSERT, UPDATE, DELETE, SELECT, ����¡) => ���� => ���
                          ����, ����, ������ ==> 
                CREATE [OR REPLACE] PROCEDURE pro_name (
                    �Ű�����
                )
                IS(AS)
                    ��������
                ---------------------------------------- �����
                BEGIN
                    ������ : SQL
                
                END;
                /
              = ����� ���� �Լ� => SubQuery�� ��ü (SELECT, WHERE) => ������� �ݵ�� �ʿ�
                CREATE [OR REPLACE] FUNCTION func_name (
                    �Ű�����
                ) RETURN ��������
                IS(AS)
                    ��������
                BEGIN
                    ������
                    RETURN ��
                END;
                /
              = Ʈ����
                - �ڵ� �̺�Ʈ ó��
                - �̸� ������ ���ǿ� �´� ��쿡 ���� (����Ŭ ��ü���� ���� => �ڹٿ��� ȣ������ �ʴ´�)
                - INSERT, UPDATE, DELETE������ ����� ����
                - �԰� => INSERT => ��� (�ڵ� ����)
                - ��� => INSERT => ��� (�ڵ� ����)
                - ����)
                    CREATE [OR REPLACE] TRIGGER tri_name
                    BEFORE | AFTER (INSERT | UPDATE | DELETE) ON table_name
                    FOR EACH -- ��ü ROW�� ���� ó��
                    ---------------------------------------------------------- ����
                    DECLARE
                        ���� ���� --> ������ ������ ���� ��� (������ ����)
                    BEGIN -- (
                        ����
                    END; -- )
                    /
                    ----------------------------------------------------------
                    
                    = ����
                        DROP TRIGGER tri_name
                    = ����
                        ALTER TRIGGER tri_name => ���󵵰� ���� => OR REPLACE�� ���
                        
                        ��ȭ / ���� / å ...
                        �� ==> jjim�� ���� ==> ��ȭ ���̺� jjim count����
*/
CREATE TABLE ��ǰ (
    ǰ�� NUMBER,
    ��ǰ�� VARCHAR2(30),
    �ܰ� NUMBER
);
CREATE TABLE �԰� (
    ǰ�� NUMBER,
    ���� NUMBER,
    �ݾ� NUMBER
);
CREATE TABLE ��� (
    ǰ�� NUMBER,
    ���� NUMBER,
    �ݾ� NUMBER
);
CREATE TABLE ��� (
    ǰ�� NUMBER,
    ���� NUMBER,
    �ݾ� NUMBER,
    �����ݾ� NUMBER
);

-- ��ǰ
INSERT INTO ��ǰ VALUES(100, '�����', 1500);
INSERT INTO ��ǰ VALUES(200, '���ڱ�', 1000);
INSERT INTO ��ǰ VALUES(300, '������', 2000);
INSERT INTO ��ǰ VALUES(400, '¯��', 500);
INSERT INTO ��ǰ VALUES(500, '������', 2500);
COMMIT;
-- �԰�ÿ� ��� ó��
/*
    �԰� ==> ��� (��ǰ�� �����ϴ��� Ȯ��)
            1. ���� : UPDATE - �����߰�
            2. ������ : INSERT - �� �߰�
    ��� ==> ��� (��ǰ�� ������ �?)
            1. 0�� : DELETE - ����
            2. 0���� ũ�� : UPDATE - ��������
            
            => INSERT, UPDATE, DELETE���� ������ �� :NEW.ǰ��
                INSERT INTO �԰� VALUE(100, 10, 1500)
                                      ---  --- -----
                                        :NEW.ǰ��
                                        :NEW.����
                                        :NEW.�ݾ�
                                        
            => ���� ��� ���̺� �ִ� �÷����� ���� ��
                                        :OLD.ǰ��
                                        :OLD.����
                                        :OLD.�ݾ�
*/ -- �̰� �ڵ�ȭ ó��
CREATE OR REPLACE TRIGGER input_trigger
AFTER INSERT ON �԰�
FOR EACH ROW
DECLARE
    v_cnt NUMBER := 0;
BEGIN
    SELECT COUNT(*) INTO v_cnt
    FROM ���
    WHERE ǰ�� = :NEW.ǰ��; -- :NEW = INSERT�ߴ� ���� �����´�

    IF v_cnt = 0 THEN -- ������ ��ǰ�� ���� ��� ó��
     -- INSERT
     INSERT INTO ��� VALUES(:NEW.ǰ��, :NEW.����, :NEW.�ݾ�, :NEW.����*:NEW.�ݾ�);
    ELSE -- ������ ��ǰ�� ����
     -- UPDATE
     UPDATE ��� SET
     ���� = ���� + :NEW.����,
     �����ݾ� = �����ݾ� + (:NEW.����*:NEW.�ݾ�)
     WHERE ǰ�� = :NEW.ǰ��;
     -- ������ : AutoCommit���� => COMMIT�� ����ϸ� �����߻�
    END IF;
END;
/

INSERT INTO �԰� VALUES(100,3,1500);
SELECT * FROM �԰�;
SELECT * FROM ���;

-- ��� : UPDATE/DELETE
CREATE OR REPLACE TRIGGER output_trigger
AFTER INSERT ON ���
FOR EACH ROW

DECLARE
    v_cnt NUMBER := 0;
BEGIN
    SELECT ���� INTO v_cnt
    FROM ���
    WHERE ǰ�� = :NEW.ǰ��;
    
    IF :NEW.���� = v_cnt THEN
        -- ó�� => ��� ���� ���� => DELETE
        DELETE FROM ���
        WHERE ǰ�� = :NEW.ǰ��;
    ELSE
        -- ó�� => �����ִ� ���, �����ݾ׿��� ���ߵ�
        UPDATE ��� SET
        ���� = ���� - :NEW.����,
        �����ݾ� = �����ݾ� - :NEW.���� * :NEW.�ݾ�
        WHERE ǰ�� = :NEW.ǰ��;
    END IF;
END;
/

SELECT * FROM ���;
INSERT INTO ��� VALUES(100,4,1500);


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