/*
GROUP BY ����
----------- ��� => �Ϻ� �Ǹŷ�, ���� ���ŷ�
            ���� ���� ������ �ִ� �׷��� ��� �׷캰ó���� ���� �ϴ� SQL
            SELECT ~ ==> 5
            FROM ============== 1
            WHERE ============= 2
            GROUP BY �÷���|�Լ� === 3
            => ������ �ִ� ��� => HAVING == 4
            ORDER BY == 6
*/

-- 1. �� �μ����� �ִ� �޿��� ���ϼ���.
SELECT deptno, MAX(sal)
FROM emp
GROUP BY deptno
ORDER BY deptno;

-- ���� �׷�
SELECT deptno, TO_CHAR(hiredate, 'YYYY'), MAX(sal)
FROM emp
GROUP BY deptno, TO_CHAR(hiredate, 'YYYY')
ORDER BY deptno;

-- 2. �� ����(job)���� �ִ� �޿��� ���ϼ���. 
SELECT job, MAX(sal)
FROM emp
GROUP BY job;

-- 3. �� �μ����� ��� �޿��� ���ϼ���.
SELECT deptno, ROUND(AVG(sal))
FROM emp
GROUP BY deptno;

-- �����Լ� : COUNT() , AVG , SUM , MAX , MIN => ������ �Լ�, �Ϲ� �÷��� ���� ����� �� ����
--           ------------------------------- �Ϲ� �÷��� ���ÿ� ��� => GROUP BY ���
--           => ��ü�� ������� ���� ����(����), ���δ����� ����� �� ����(ROW) => ����� ���Ƿ� ����
-- 4. �� ����(job)���� �ο����� ���ϼ���.
SELECT job, COUNT(job)
FROM emp
GROUP BY job;

-- 5. �� �μ��� ���ʽ�(comm)�� �޴�  �ο��� ��� . 
SELECT deptno, COUNT(comm)
FROM emp
WHERE comm IS NOT NULL
GROUP BY deptno;

-- 6. �� �⵵���� �Ի��� �ο����� ���ϼ���.
SELECT TO_CHAR(hiredate, 'YYYY'), COUNT(*)
FROM emp
GROUP BY TO_CHAR(hiredate, 'YYYY');

SELECT TO_CHAR(hiredate, 'day'), COUNT(*), SUM(sal), ROUND(AVG(sal))
FROM emp
GROUP BY TO_CHAR(hiredate, 'day');

-- 7.  �μź� ��ձ޿��� ���ϰ� �� ��� ��ձ޿��� 2000 �̻��� �μ��� ����ϼ���.
SELECT deptno, ROUND(AVG(sal))
FROM emp
GROUP BY deptno
HAVING AVG(sal) >= 2000;

-- WHERE => �׷� �Լ��� ����� �� ����, �׷��Լ��� ���ÿ��� HAVING�� �̿��Ѵ�

-- 1. ��� �̸��� SCOTT�� ����� ���(empno), �̸�(ename), �μ���(dname)�� ����ϼ���.
SELECT empno, ename, dname
FROM emp, dept
WHERE emp.ename = 'SCOTT';

-- 2. ����̸��� �޿�(sal)�� �޿����(grade)�� ����ϼ���.
SELECT ename, sal, grade
FROM emp, salgrade;

-- 3. �� 2���������� �μ����� �߰����� ����ϼ���.
SELECT ename, sal, grade, deptno
FROM emp, salgrade;

-- 4. ����̸��� �Ŵ����� �̸��� �Ʒ��� ���� �������� ����ϼ���.
--    "XXX"�� �Ŵ����� "XXX" �Դϴ�. 

-- 5. �μ���ȣ�� 30���� ������� �̸�, ����(job), �μ���ȣ(deptno), �μ���ġ(loc)�� ����ϼ���.
SELECT ename, job, emp.deptno, loc
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND emp.deptno = 30;

-- 6. ���ʽ�(comm)�� ��������� �̸�, ���ʽ�, �μ���, �μ���ġ�� ����ϼ���.
SELECT ename, comm, dname, loc
FROM emp, dept
WHERE comm IS NOT NULL AND comm <> 0;

-- 7. DALLAS���� �ٹ��ϴ� ������� �̸�, ����, �μ���ȣ, �μ����� ����ϼ���.
SELECT ename, job, emp.deptno, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND loc = 'DALLAS';

-- 8. �̸��� 'A'�� ���� ������� �̸��� �μ����� ����ϼ���.
SELECT ename, dname
FROM emp, dept
WHERE ename LIKE '%A%';

-- 1. SCOTT�� �޿��� �����ϰų� �� ���� �޴� ����� �̸��� �޿��� ����ϼ���.
SELECT ename, sal
FROM emp
WHERE sal = (SELECT sal FROM emp WHERE ename = 'SCOTT');
-- 2. ����(job)�� 'CLERK'�� ����� �μ��� �μ���ȣ�� �μ����� ����ϼ���.
SELECT emp.deptno, dept.dname
FROM emp, dept
WHERE emp.job = 'CLERK';

-- 3. �̸��� T�� �����ϰ� �ִ� ������ �����μ����� �ٹ��ϴ� ����� ����� �̸��� ����ϼ���

-- 4. �μ���ġ(loc)�� DALLAS�� ��� ����� �̸�, �μ���ȣ�� ����ϼ���

-- 5. SALES �μ��� ������� �̸��� �޿��� ����ϼ���

-- 6. �ڽ��� �޿��� ��� �޿����� ���� �̸��� S�� ���� �����
--    ������ �μ����� �ٹ��ϴ� ��� ����� �̸�, �޿��� ����ϼ���
-- 7. ��� �޿����� �� ���� �޿��� �޴� ����� �̸�, ���, �޿��� �˻��ϵ� �޿��� ���� �����γ����ϼ���.


