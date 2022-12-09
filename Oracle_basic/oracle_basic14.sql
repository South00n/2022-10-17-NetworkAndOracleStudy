/*
        SQL
          1) DQL : 데이터 검색
              SELECT
          2) DDL : 데이터 저장공간 생성, 가상 테이블, 함수, 프로시저, 인덱스, 트리거
             ------ 복구가 불가능
              CREATE : 생성
              ALTER : 수정
              DROP : 삭제
              TRUNCATE : 잘라내기 => 테이블의 형태는 남아 있다 => 데이터 잘라내기
              RENAME : 이름 변경 (테이블 이름 변경)
          3) DML : 데이터수정, 삭제, 추가
             INSERT
             UPDATE
             DELETE
          4) DCL : 제어언어
             GRANT
             REVOKE ====> VIEW 생성을 할 수 없다
          5) TCL
             COMMIT : 정상적으로 저장
             ROLLBACK : 취소
            --------------------------------- 둘중에 한개가 실행되면 다른 실행할 수 없다
            COMMIT 실행하면 Rollback은 안된다
*/