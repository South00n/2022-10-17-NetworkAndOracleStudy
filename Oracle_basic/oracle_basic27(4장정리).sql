/*
    ==> DML, DQL, DDL, 내장함수, 연산자, 서브쿼리 => BASIC (입문)
    ==> JOIN종류, View역할, 서브쿼리 vs JOIN, PROCEDURE vs TRIGGER, 트랜잭션
        -----------------------------------------------------------------
      4장 SQL 고급
      -----------
       1. 내장함수 (209page)
          오라클에서 지원하는 함수 (이미 제작 => 라이브러리) => 전체 지원하지 않는다, 필요하면 사용자 정의 함수도 가능
                                                                              PL/SQL
                                                                              => 처음보는 함수 (회사마다 다르게)
          문자 함수 ==> 웹프로그래머 (자바 String)
            LENGTH()
            SUBSTR()
            RPAD()
          숫자 함수 ==> 자바 Math
            ROUND()
            CEIL()
          날짜 함수
            SYSDATE
            MONTHS_BETWEEN()
          변환 함수
            TO_CHAR() ==> 자바에서 변환하면 입력된 시간을 읽을 경우 => 항상 12:00
          기타 함수
            NVL() => NULL 대체하는 함수
          ---------------------------------------- 나머지는 자바에서 제어
       1-1. 서브쿼리 => 224page ~ 234page 참조
            SQL문장을 통합해서 한개의 명령문을 만든다
            WHERE => 중첩질의 (두개의 테이블 연결) => 예매, 결제 (아임포트)
                     = 단일행 서브쿼리 (컬럼 1, 결과값 1) => id (주소, 전화), 영화번호 => 영화정보 ...
                     = 다중행 서브쿼리 (컬럼이 1개, 결과값 여러개)
                         => 전체에 대한 정보 ==> IN()
                         => 선택 => ANY(SOME), ALL ==> 최대값, 최소값 
            *** SELECT => 스칼라 서브쿼리 : JOIN을 대신 사용 (JOIN보다 속도가 빠르다)
                          ***** 프로그램 => 퍼포먼스 (속도 최적화), 가독성, 재사용성
                                기능 1개 (MS - 명령프롬프트), 기능 여러개 (IBM - OS2) => IBM의 하청업체
                                ------- 언어 (복잡한 언어 => 스크립트릿) => servlet => JSP
                          ***** 컬럼을 대신하는 방법
                          SELECT 컬럼명, (SELECT ~~) 별칭 ...
                                         --------- 주의점 : 반드시 컬럼값 1개만 나온다 => 단점 (소스가 길다)
                                         --------- 실무 (17줄 ~ 120줄)
                          FROM table_name
            *** FROM => 인라인뷰 : 보안이 뛰어나다 (디스크에 저장하지 않는다), 페이지, ROW를 나눠서 처리
                        ==> 더보기
            
       2. VIEW : 235page ~ 236page (뷰장점)
                 1) 개념 => 하나이상의 테이블을 합쳐서 만든 가상테이블 (보안, 재사용, SQL문장을 최소화)
                           한개연결 : 단순 뷰
                           *** 여러개 연결 : 복합 뷰 (복잡한 쿼리문장, SQL문장 길 경우에 => SQL문장 저장후에 재사용)
                                                    ------------------------- JOIN, SubQuery
                           *** 저장되는 것은 데이터가 아니라 => SQL문장을 저장하고 있다
                           *** 제한적이지만 DML을 수행할 수 있다 (DML이 사용에 참조 테이블에 영향이 있다)
                                => 읽기전용으로 설정 ==> WITH READ ONLY
                 2) 생성 237page
                     CREATE VIEW view_name
                     AS
                      SELECT ~~
                     ------------------------ 수정할때는 => DROP후에 수정하고 다시 생성
                     ==> 테이블하고 동일하게 사용한다
                 3) 수정 240page
                     CREATE OR REPLACE VIEW view_name
                     AS
                      SELECT ~~
                 4) 삭제 240page
                    DROP VIEW view_name
       3. INDEX : 개념 (면접) => 자료를 쉽고 빠르게 찾을 수 있게 만들어 준다 (속도 최적화)
          249page 검색속도가 빠르다, 인덱스를 저장할 수 있는 저장공간을 필요로 하기때문에 생성시간이 오래 걸릴 수 있다
                  수정/삭제를 했을 경우 => 다시 리빌드해야함
          생성) CREATE INDEX index_name ON table_name(컬럼) => 검색에 자주 사용되는 컬럼
          삭제) DROP INDEX index_name
          리빌드) ALTER INDEX index_name REBUILD
          사용법) -> 정렬 INDEX_ASC(), INDEX_DESC() => ORDER BY사용 -> PRIMARY KEY(인덱스가 자동 생성)
       4. SEQUENCE : 자동증가
           1) 생성
              CREATE SEQUENCE seq_name
              START WITH 1
              INCREMENT BY 1
              NOCACHE
              NOCYCLE
           2) 삭제
              DROP SEQUENCE seq_name;
              
           3) 현재값 currval
              다음값 nextval
           ---------------------------------------------------------
*/
CREATE OR REPLACE FUNCTION getDname(pDeptno emp.deptno%TYPE)
RETURN VARCHAR2
IS
vdname dept.dname%TYPE;
BEGIN
  SELECT dname INTO vdname
  FROM dept
  WHERE deptno = pDeptno;
  return vdname;
END;
/
SELECT empno, ename, getDname(deptno) FROM emp;


