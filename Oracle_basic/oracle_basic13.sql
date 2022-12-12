-- 2022-12-09 SELECT문장 정리 ==> DDL (데이터베이스 설계) => 툴 사용법 (vuerd)
/*
        => 병행
            1) SQL문장 실행 => 자바로 연동 (SQL문장, 자바에서 SQL문장) => 웹프로그래머 (자바)
            2) 프로그램 => 반복 => 시행착오
            3) 게시판
    
*/
/*
        테이블 (릴레이션)
            = 데이터를 저장하는 공간 (파일의 역할)
            = 이차원 구조 (ROW, COLUMN) => 행, 열
            = 같은 데이터베이스(폴더)에서 테이블명 1개만 사용이 가능
            ---------------------- XE (default) => Create Database
             ~~ FROM table명
             --------------------------------------
               ID    SEX   NAME   Password   Address   ====> 구분 (Column)
             --------------------------------------
                -     -     -        -         -   ==>  저장된 값 ROW(RECORD) => 자바에서 데이터읽기 - RECORD 단위
                -     -     -        -         -
             --------------------------------------
             ==> 한줄 읽기, 전체, 필요한 컬럼만 ... ==> 명령문 : SELECT (문자열 패턴 => 데이터 검색)
             ==> 그룹으로 묶어서 제어, 조건에 맞는 데이터만 ... 다른 테이블과 연결이 가능
                 GROUP BY           WHERE                   JOIN / SUBQUERY ...
             ==> 데이터 저장 (영구적) => 공유
                 -------------------------- 사용자 요청에 따라 데이터 추출
                 => 사용자는 검색어 ==> 웹프로그래머 (검색어로 SQL문장 ==> 데이터 추출)
                 => 사용자 => 요청에 대한 설계 => 요구사항 분석
                                                   |
                                               데이터베이스 설계
                                                   |
                                               데이터를 저장 (데이터 수집) - 아키텍처
                                                   |
                                                화면 UI - 퍼블리셔
                                                   |
                                                  구현 - 웹프로그래머
                                                   |
                                                 테스팅 - 테스터
                                                   |
                                                  배포 (발표) - 웹프로그래머
*/
/*
        데이터를 검색 (추출) => SELECT => 웹 사이트의 기본 보여주는 역할 (75~80% SELECT)
                 사이트 : user / admin
                         ----   ----- 약간 첨부 (공지사항, 광고, 이벤트, 예약 체크)
        문법 형식)
                 1. 데이터 추출
                    SELECT * | 필요한 데이터 컬럼 나열
                    FROM table_name
                 2. 조건
                    WHERE 조건문 (컬럼명|함수명) 연산자 값
                                ---------------------- true일때 실행
                 3. 그룹
                    GROUP BY (컬럼명|함수)
                             ----------- 같은 값을 가지고 있는 걸 묶어서 (따로 처리) ==> 운영자중심(Admin)
                                         => 분기별 통계 (마이페이지)
                 4. 그룹에 대한 조건 => GROUP BY가 있는 경우만 사용이 가능
                    HAVING 그룹조건 (집합함수를 사용해서 조건을 만든다)
                                    ------- AVG, SUM, MAX, MIN, COUNT
                 5. 정렬 => 추출한 데이터가 작은 경우 (많은 경우 : **INDEX = 최적화)
                 -----------------
                    ORDER BY 컬럼명|함수명 ASC|DESC
                                         ---
                                        올림 / 내림 ==> 최신 등록
                 6. JOIN
                 7. SQL을 여러개 통합
*/
-- 1. 데이터 추출 : => 사용자에게 보여주는 목적 (목록/상세)
-- 1-1 => 테이블 : DESC table (테이블 구성요소 확인) ** 무조건 필수!
-- SEOUL_LOCATION
DESC SEOUL_LOCATION;
/*
    NO      NOT NULL NUMBER         
    TITLE   NOT NULL VARCHAR2(200)  
    POSTER  NOT NULL VARCHAR2(500)  
    MSG     NOT NULL VARCHAR2(4000) 
    ADDRESS NOT NULL VARCHAR2(300)  
    HIT              NUMBER
*/
-- 명소 => 목록 (이미지, 제목, 설명)
SELECT poster, title, msg
FROM seoul_location;
-- 상세보기
SELECT * FROM seoul_location;
-- **인기 순위 ==> 5개 => rownum (서브 쿼리)
SELECT title, hit, rownum
FROM (SELECT title, hit FROM seoul_location ORDER BY hit DESC)
WHERE rownum <= 5;
-- 인기 게시물, 인기 댓글, 인기 이벤트, 인기 영화 // ==> rownum, subquery를 이용해서 순서를 변경 (인라인뷰)
-- 단점 : Top-N (1~몇개)가능 => 중간에서 자르는건 안된다
-- SubQuery를 2번 이용 ==> 페이징 기법
-- 한개에 대한 데이터
SELECT *
FROM seoul_location
WHERE no = 1;
/*
        SELECT * | column_list
        ==> Option
            = 중복이 없는 데이터 출력 ==> DISTINCT 컬럼명
                                       --------
            = 문자열 결합 => 컬럼명 || 컬럼명
            
            = 별칭 : 함수이용, 서브쿼리
                    NVL(comm, 0) comm, (SELECT ~~~) dname
                    => 공백 있는 경우 예) dept name -> 오류 -> "dept name"로 작성
            -------------------------------------- MyBatis / JPA => 별칭을 사용해야 데이터를 읽을 수 있다
            FROM table_name | view_name | (SELECT ~~)
            WHERE 컬럼명|함수명 연산자 값 ==> 데이터형 (숫자형 : 그냥 사용, 날짜, 문자 => '')
                        ----- -----
            => 연산자
                산술연산자 : WHERE에서 사용하지 않는다 (if => true/false)
                            '10' => 자동 형변환
                            TO_NUMBER('10') => 10
                            --------------- 사용하지 않을 수 있다 : 권장 (TO_NUMBER를 이용해라 : 속도문제)
                            *** SQL은 속도 => 퍼포먼스
                            *** 정수/정수 = 실수
                -----------------------------------------------------
                비교연산자 : = , <> , != , ^=
                논리연산자 : AND (범위 포함) , OR
                           --------------   ---
                           BETWEEN           IN
                NOT : !(자바) => NOT
                      WHERE !(no >= 1 AND no <= 10) => 오류
                      WHERE NOT(no >= 1 AND no <= 10) => 정상 수행
                IN : OR가 여러개 사용
                     WHERE 컬럼명 IN(값....) => 많이 사용
                     CHECK(sex IN('남자', '여자')) ==> 지정 => 제약조건의 일종
                NULL : 값이 존재하지 않는 것 ==> 1. 연산처리가 안된다, 2. 브라우저에서 null ==> 대체 (NVL())
                       IS NULL (null일 경우), IS NOT NULL(null이 아닌 경우)
                       => 자바에서 NullPointerException 발생
                BETWEEN : 카테고리, 원하는 범위안에서 데이터 추출
                        WHERE 컬럼명 BETWEEN 값 AND 값
                                            -- 숫자, 날짜, 문자  ===> 페이지나누기
                LIKE : 검색시에 주로 사용 : 게시판, 영화, 맛집 ... , REGEXP_LIKE
                       % : 문자열의 갯수는 관계없음
                           A% : A로 시작
                           %A : A로 끝
                           %A% : A포함 ==> 사용빈도 가장 많다
                                 SQL문장중에 자바에서 SQL 다르다
                                 => WHERE 컬럼명 LIKE '%A%'
                                    =>          LIKE '%' || 값 || '%'
                                    =>          LIKE CONCAT('%', 값, '%') => MYSQL, MariaDB
                       _ : 문자 한개
                           _A                       
                --------------------------------------------- WHERE문장에서 사용되는 연산자
                함수
                  = 문자 관련 (String)
                    = LENGTH() : 문자 갯수 => LENGTH('ABC') => 3 ==> *** function / procedure
                                                                    => 리턴형   리턴형이 없는 함수 (***)
                                                                    CREATE FUNCTION RETURN NUMBER, CREATE PROCEDURE => PL / SQL
                    = SUBSTR() : 문자를 자른다 => SUBSTR(문자열, 시작위치, 갯수)
                                                SUBSTR('22/12/09', 4, 2) ==> 12
                                                ** 시작위치 => 1
                    = INSTR() : 문자의 위치 확인 ==> INSTR(문자열, 찾는 문자열, 시작위치, 몇번째있는건지)
                                                INSTR('Hello Oracle', 'e', 1, 2) -> 12
                    = REPLACE() : 문자나 문자열 변경 ==> REPLACE(문자열, old, new)
                                                       REPLACE('Hello', 'l', 'k') ==> Hekko
                                                       => 보통은 &를 ^로 바꿔라 |를 $로 바꿔라
                                                         - &와 |는 오라클에서 사용하는 기호라서 데이터 받아올때 오류없게
                    = RPAD() => 다른 문자열을 출력할때 => RPAD(문자열, 문자갯수, 출력할문자)
                                RPAD('Oracle', 10, '*') ==> Oracle**** (출력은 10개의 문자)
                  = 숫자 관련 (Math)
                    = MOD() => 나머지 ==> 자바에서 처리 %
                    = ROUND() => 반올림
                    = CEIL() => 올림
                  = 날짜 관련 (Date,Calendar)
                    = SYSDATE : 시스템 날짜
                    = MONTH_BETWEEN : 개월수
                  = 변환 관련 (Format) ==> JSTL (출력시 표준으로출력 항상 변환이 필요)
                    = TO_CHAR
                        => YYYY,MM,DD,HH24,MI,SS,DY,day
                        => 999,999
                  = 기타
                     = NVL() => NULL값 대체
                  = GROUP BY , ORDER BY
                    => 그룹별로 묶어서 그룹별로 처리
                        GROUP BY 컬럼명|함수 ==> 같은 값을 가지고 있는 것끼리 묶어서 처리 => 통계
                        => 조건 : HAVING
                  = SUBQUERY : SQL문장 여러개 묶어서 한번 실행
                               MainQuery = (SubQuery)
                                               1
                                         결과값
                                   2
                               => WHERE : 단일행 서브쿼리 (컬럼 1개, 결과값 1개)
                                          다중행 서브쿼리 (컬럼 1개, 결과값 여러개)
                                            결과값 전체 대입 : IN
                                            최대값 , 최소값 : ANY, ALL, SOME
                                            < ANY, SOME
                                              ANY(10, 20, 30) ==> 30
                                            > ANY, SOME
                                              ANY(10, 20, 30) ==> 10
                                            < ALL
                                              ALL(10, 20, 30) ==> 10
                                            > ALL
                                              ALL(10, 20, 30) ==> 30
                               ------------------------
                               => 컬럼 : 스칼라 서브쿼리
                                  SELECT 컬럼명, (SELECT~~) ==> 결과값이 1개만 나와야 한다
                                  FROM table_name
                               => 테이블 : 인라인뷰
                                  SELECT 컬럼명 ...
                                  FROM (SELECT ~)
                               ------------------------ 핵심
                  = JOIN
                    INNER JOIN
                      = Oracle JOIN
                        SELECT A.column, B.column
                        FROM A, B
                        WHERE A.column = B.column
                        
                        -- 컬럼이 3개
                        SELECT A.column, B.column, C.column ==> 테이블로 구분, 별칭으로 구분 => 컬럼이 다른 경우는 구분하지 않아도 된다
                        FROM A, B, C
                        WHERE A.column = B.column
                        AND A.column = C.column;
                        ---
                        
                      = ANSI JOIN
                        SELECT A.column, B.column
                        FROM A JOIN B
                        ON A.column = B.column
                        
                        --컬럼이 3개면
                        SELECT A.column, B.column
                        FROM A JOIN B
                        ON A.column = B.column
                        JOIN C
                        ------
                        ON A.column = C.column;
                    OUTER JOIN
                      = LEFT OUTER JOIN
                        = Oracle JOIN
                          SELECT A.column, B.column
                          FROM A, B
                          WHERE A.column = B.column(+)
                          
                        = ANSI JOIN
                          SELECT A.column, B.column
                          FROM A LEFT OUTER JOIN B
                                ---------------- 생략이 불가능
                          WHERE A.column = B.column
                      = RIGHT OUTER JOIN
                        = Oracle JOIN
                          SELECT A.column, B.column
                          FROM A, B
                          WHERE A.column(+) = B.column
                          
                        = ANSI JOIN
                          SELECT A.column, B.column
                          FROM A RIGHT OUTER JOIN B
                                ---------------- 생략이 불가능
                          WHERE A.column = B.column
                  
*/
SELECT deptno, ROUND(AVG(sal)), COUNT(*)
FROM emp
GROUP BY ROLLUP(deptno)
ORDER BY deptno;









