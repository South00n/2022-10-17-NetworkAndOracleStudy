/*
       5장 정리 => 프로그램
       
       = 오라클 응용 프로그램
         - 응용프로그램을 제작할 수 있는 언어 => PL/SQL => 문법은 PL/ 제어는 SQL
            PL => 프로그램 언어
                  -----------
                   변수
                   연산자
                   제어문
                     조건문
                        IF 조건문 THEN
                            처리문장
                        END IF;
                        -----------------
                        IF 조건문 THEN
                            처리문장
                        ELSE
                            처리문장
                        END IF;
                        -----------------
                        IF 조건문 THEN
                            처리문장
                        ELSIF 조건문 THEN
                            처리문장
                        ELSE
                            처리문장
                        END IF;
                        -----------------
                     반복문
                        FOR 변수명 IN lo..hi LOOP
                            처리문장
                        END LOOP;
                        
                        FOR 변수명 IN cursor명 LOOP
                            처리문장
                        END LOOP;
         - 프로시저
            CREATE [OR REPLACE] PROCEDURE pro_name (
                매개변수
            )
            IS | AS
                지역변수
            BEGIN
                구현
            END;
            /
         - 함수
            CREATE [OR REPLACE] FUNCTION pro_name (
                매개변수
            ) RETURN 데이터형
            IS | AS
                지역변수
            BEGIN
                구현
                RETURN 값
            END;
            /
         - 트리거
            CREATE [OR REPLACE] TRIGGER tri_name
            AFTER | BEFORE (INSERT|UPDATE|DELETE) ON table_name
            FOR EACH ROW
            DECLARE
                지역변수 선언
            BEGIN
                자동처리 구현
            END;
            /
       = 자바 연동 프로그램
            ========= 자바 코딩
                      -------------------------
                      1) 한번 수행 : *** 생성자
                      2) 반복 수행
                      3) 한개의 기능 => 재사용
                      ------------------------- 메소드화 처리 (구조적 프로그램, 가독성, 에러처리, 단락)
            1. 오라클 연결되는 순서
                1) 드라이버 등록 : 한번만 수행 => 생성자
                    Class.forName(드라이버명) com.mysql.cj.Driver
                2) 오라클 연결 : 요청시마다 코딩 => 메소드화 처리 (반복) => getConnection()
                    conn = DriverManager.getConnection(URL, USER, PWD)
                3) SQL문장 제작
                    => DML, DQL
                    => 복잡한 쿼리문장 => VIEW
                    => 정렬 => INDEX => ORDER BY ASC (INDEX_ASC()), ORDER BY DESC (INDEX_DESC())
                    => 반복이 많은 SQL => 프로시저
                    => 다른 테이블의 변경이 요구 => 트리거
                    => 페이징 => 인라인뷰
                    => 정규화 => 테이블이 많이 나눠진다 (JOIN)
                4) SQL문장 전송
                    ps = conn.preparedStatement(sql)
                5) SQL을 오라클에서 실행후에 결과값을 가지고 온다
                    ResultSet rs = ps.excuteQuery()
                    ResultSet구조
                    SELECT empno, ename, job FROM emp;
                    -------------------------------------------
                            empno      ename       job
                    -------------------------------------------
                                      BOF (Begin Of FIle)
                    -------------------------------------------
                            111         hong        영업부    | <-커서위치 next() ==> 한줄 전체 읽기
                            ---         ----        ----- getString(3)
                            getInt(1)   getString(2)    
                    -------------------------------------------
                            222         park        개발부
                    -------------------------------------------
                            333         shim        총무부    | <-커서위치 previous()
                    -------------------------------------------
                                      EOF ==> 커서의 위치 (End OF File)
                    -------------------------------------------
                            getInt(), getString(), getDouble(), getDate()
                    
                6) VO, ArrayList에 담아둔다
                7) 오라클 닫기 => 요청시마다 코딩 => 메소드화 처리 (반복) => getConnection()
            2. 구조 파악
            3. 클래스의 메소드 
       = 웹 연동 프로그램 (웹 프로그래머)
            1. 오라클 SQL문장  ======> DAO
            2. 오라클 데이터 매칭 ====> VO
            3. JSP ==> Java Server Page (서버에서 실행되는 자바 파일)
            4. HTML/CSS ==> 화면 출력 (브라우저에서 실행되는 언어 => HTML/XML)
                => JSP를 실행 => HTML로 변환 (톰캣)
*/