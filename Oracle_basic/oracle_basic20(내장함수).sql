/*
        209page => �����Լ�
        ===> ����Ŭ���� �����ϴ� �Լ�
        ===> SELECT () ==> SELECT TO_CHAR(hiredate, 'YYYY')
        ===> WHERE () ==> WEHRE MOD(empno, 2) = 0
        ===> GROUP BY() ==> GROUP BY TO_CHAR(hiredate, 'YYYY')
        ===> HAVING () ==> AVG(sal) > 3000
        ===> ORDER BY() ==> ORDER BY LENGTH(ename) ASC
    
        1) ������ �Լ� ==> ���� ROW => ���پ� ó��
           ���� �Լ� : LENGTH() , SUBSTR(), INSTR(), RPAD(), REPLACE()
           ��¥ �Լ� : SYSDATE, MONTHS_BETWEEN
           ���� �Լ� : TRUNC(), CEIL(), ROUND()
           ��ȯ �Լ� : TO_CHAR()
                      ��¥ -> ���ڿ�
                       YYYY �⵵
                       MM   ��
                       DD   ��
                       DY   ����
                       HH/HH24 => �ð�
                       MI ��
                       SS ��
                      ���� -> ���ڿ�
                       L999,999
           ��Ÿ �Լ� : NVL => NULL�� ��ü
           223page => ROWNUM => ����Ŭ ���������� ���� => �����÷� (SQL����� => ROW�� ��ȣ ����)
                      1) ����¡, 2) ����/���� => �󼼺���
           224page => ��������
              => WHERE �ڿ� => ��ø ����
              => �÷� ��� => ��Į�� ��������
              => ���̺� ��� => �ζ��κ�
        2) ������ �Լ� ==> ���� COLUMN
           AVG, COUNT, MAX, SUM, MIN
                ----------
           RANK(), CUBE(), ROLLUP() => ���
        ------------------------------------------ �ΰ��� ���ÿ� ����� �� ����
*/