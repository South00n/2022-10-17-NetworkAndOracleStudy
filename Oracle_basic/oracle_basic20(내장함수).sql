/*
        209page => 내장함수
        ===> 오라클에서 지원하는 함수
        ===> SELECT () ==> SELECT TO_CHAR(hiredate, 'YYYY')
        ===> WHERE () ==> WEHRE MOD(empno, 2) = 0
        ===> GROUP BY() ==> GROUP BY TO_CHAR(hiredate, 'YYYY')
        ===> HAVING () ==> AVG(sal) > 3000
        ===> ORDER BY() ==> ORDER BY LENGTH(ename) ASC
    
        1) 단일행 함수 ==> 단위 ROW => 한줄씩 처리
           문자 함수 : LENGTH() , SUBSTR(), INSTR(), RPAD(), REPLACE()
           날짜 함수 : SYSDATE, MONTHS_BETWEEN
           숫자 함수 : TRUNC(), CEIL(), ROUND()
           변환 함수 : TO_CHAR()
                      날짜 -> 문자열
                       YYYY 년도
                       MM   월
                       DD   일
                       DY   요일
                       HH/HH24 => 시간
                       MI 분
                       SS 초
                      숫자 -> 문자열
                       L999,999
           기타 함수 : NVL => NULL값 대체
           223page => ROWNUM => 오라클 내부적으로 생성 => 가상컬럼 (SQL실행시 => ROW의 번호 지정)
                      1) 페이징, 2) 이전/다음 => 상세보기
           224page => 서브쿼리
              => WHERE 뒤에 => 중첩 질의
              => 컬럼 대신 => 스칼라 서브쿼리
              => 테이블 대신 => 인라인뷰
        2) 다중행 함수 ==> 단위 COLUMN
           AVG, COUNT, MAX, SUM, MIN
                ----------
           RANK(), CUBE(), ROLLUP() => 통계
        ------------------------------------------ 두개를 동시에 사용할 수 없다
*/