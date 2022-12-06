-- 오라클 2일차 정리
/*
      SELECT / INSERT / UPDATE / DELETE
      CREATE / ALTER / DROP / TRUNCATE / RENAME
      GRANT / REVOKE
      COMMIT / ROLLBACK
      ------------------------------------------
          TABLE / VIEW / SEQUENCE / PROCEDURE / FUNCTION / TRIGGER
          -------------------------------------------------------- JDBC => Oracle_Basic
          *** DESC table명
              ------------- 컬럼명, 데이터형
                                   -------
                                   숫자형 : NUMBER
                                   ------------------------------
                                   문자형 : CHAR , VARCHAR2
                                   날짜형 : DATE , TIMESTAMP
                                   
          오라클 문법 => 명령문이 종료되면 반드시 ;을 사용한다
                        (단 자바에서 SQL문장을 전송시에는 ;를 사용하면 오류난다) => 명령문이 다를 경우가 존재
          => 권장 사항 : 키워드는 대문자 사용 (대소문자 구분을 하지 않는다 (SQL문장), 저장된 데이터는 대소문자 구분
          
        1) SELECT : 데이터 추출 (화면 출력할 데이터) => 데이터 검색 => 웹 (65 - 75%)
            = 형식
               ==============================================================================
               SELECT [ALL[DISTINCT] column1, colum2 ... | * (컬럼 전체값)
                                     ------------------- 출력에 필요한 컬럼만 가지고온다
               FROM table_name : table(데이터가 저장되어 있는 최소단위) => 파일
               ============================================================================== 필수
               [
                    1) WHERE 컬럼명 연산자 값 => 조건 검색
                    2) GROUP BY 컬럼명, 함수 => 그룹을 묶어서 그룹별 처리
                    3) HAVING 그룹함수 => 그룹 조건
                    4) ORDER BY 컬럼명, 함수명 ASC/DESC
               ]
            = 연산자
               산술연산자 : + , - , * , / (정수/정수 = 실수)
                          '10' => 자동으로 변환 => TO_NUMBER()
               ******** 비교연산자 : = , <> , != , ^=
                          --  -------------  JavaScript => === , !==
               *** 논리연산자 : AND , OR
               IN ==> OR(여러개 IN(값...))
               NULL => 연산처리가 안된다 => IS NULL , IS NOT NULL
               NOT => 부정 => NOT IN , NOT BETWEEN , NOT LIKE
               *** BETWEEN : 기간 , 범위 ==>  >= AND <=
               *** LIKE : % , _
                      A%
                      %A
                      %A%
            = 내장 함수
            = JOIN (오라클 조인 / ANSI 조인) => SELECT
            = SubQuery ( WHERE , 테이블 대신 , 컬럼 대신) => INSERT, UPDATE, DELETE
              (부속질의)
              
              자바 => 오라클로 SQL ** 자주연습해야해 **
              String sql = "SELECT ename, job, hiredate, sal, deptno "; // 공백 필요 
                            + "FROM emp ";
                            + "WHERE ename = 'KING'";  --> 대문자앞은 한칸씩 띄어야된다
                            
*/
-- select * from emp;
DESC zipcode;
