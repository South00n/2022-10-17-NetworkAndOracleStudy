/*
       5�� ���� => ���α׷�
       
       = ����Ŭ ���� ���α׷�
         - �������α׷��� ������ �� �ִ� ��� => PL/SQL => ������ PL/ ����� SQL
            PL => ���α׷� ���
                  -----------
                   ����
                   ������
                   ���
                     ���ǹ�
                        IF ���ǹ� THEN
                            ó������
                        END IF;
                        -----------------
                        IF ���ǹ� THEN
                            ó������
                        ELSE
                            ó������
                        END IF;
                        -----------------
                        IF ���ǹ� THEN
                            ó������
                        ELSIF ���ǹ� THEN
                            ó������
                        ELSE
                            ó������
                        END IF;
                        -----------------
                     �ݺ���
                        FOR ������ IN lo..hi LOOP
                            ó������
                        END LOOP;
                        
                        FOR ������ IN cursor�� LOOP
                            ó������
                        END LOOP;
         - ���ν���
            CREATE [OR REPLACE] PROCEDURE pro_name (
                �Ű�����
            )
            IS | AS
                ��������
            BEGIN
                ����
            END;
            /
         - �Լ�
            CREATE [OR REPLACE] FUNCTION pro_name (
                �Ű�����
            ) RETURN ��������
            IS | AS
                ��������
            BEGIN
                ����
                RETURN ��
            END;
            /
         - Ʈ����
            CREATE [OR REPLACE] TRIGGER tri_name
            AFTER | BEFORE (INSERT|UPDATE|DELETE) ON table_name
            FOR EACH ROW
            DECLARE
                �������� ����
            BEGIN
                �ڵ�ó�� ����
            END;
            /
       = �ڹ� ���� ���α׷�
            ========= �ڹ� �ڵ�
                      -------------------------
                      1) �ѹ� ���� : *** ������
                      2) �ݺ� ����
                      3) �Ѱ��� ��� => ����
                      ------------------------- �޼ҵ�ȭ ó�� (������ ���α׷�, ������, ����ó��, �ܶ�)
            1. ����Ŭ ����Ǵ� ����
                1) ����̹� ��� : �ѹ��� ���� => ������
                    Class.forName(����̹���) com.mysql.cj.Driver
                2) ����Ŭ ���� : ��û�ø��� �ڵ� => �޼ҵ�ȭ ó�� (�ݺ�) => getConnection()
                    conn = DriverManager.getConnection(URL, USER, PWD)
                3) SQL���� ����
                    => DML, DQL
                    => ������ �������� => VIEW
                    => ���� => INDEX => ORDER BY ASC (INDEX_ASC()), ORDER BY DESC (INDEX_DESC())
                    => �ݺ��� ���� SQL => ���ν���
                    => �ٸ� ���̺��� ������ �䱸 => Ʈ����
                    => ����¡ => �ζ��κ�
                    => ����ȭ => ���̺��� ���� �������� (JOIN)
                4) SQL���� ����
                    ps = conn.preparedStatement(sql)
                5) SQL�� ����Ŭ���� �����Ŀ� ������� ������ �´�
                    ResultSet rs = ps.excuteQuery()
                    ResultSet����
                    SELECT empno, ename, job FROM emp;
                    -------------------------------------------
                            empno      ename       job
                    -------------------------------------------
                                      BOF (Begin Of FIle)
                    -------------------------------------------
                            111         hong        ������    | <-Ŀ����ġ next() ==> ���� ��ü �б�
                            ---         ----        ----- getString(3)
                            getInt(1)   getString(2)    
                    -------------------------------------------
                            222         park        ���ߺ�
                    -------------------------------------------
                            333         shim        �ѹ���    | <-Ŀ����ġ previous()
                    -------------------------------------------
                                      EOF ==> Ŀ���� ��ġ (End OF File)
                    -------------------------------------------
                            getInt(), getString(), getDouble(), getDate()
                    
                6) VO, ArrayList�� ��Ƶд�
                7) ����Ŭ �ݱ� => ��û�ø��� �ڵ� => �޼ҵ�ȭ ó�� (�ݺ�) => getConnection()
            2. ���� �ľ�
            3. Ŭ������ �޼ҵ� 
       = �� ���� ���α׷� (�� ���α׷���)
            1. ����Ŭ SQL����  ======> DAO
            2. ����Ŭ ������ ��Ī ====> VO
            3. JSP ==> Java Server Page (�������� ����Ǵ� �ڹ� ����)
            4. HTML/CSS ==> ȭ�� ��� (���������� ����Ǵ� ��� => HTML/XML)
                => JSP�� ���� => HTML�� ��ȯ (��Ĺ)
*/