/*
        1. 데이터베이스 모델링
        --------------------
        1) 데이터베이스의 생명주기
            요구사항 분석 => 어떤 사이트를 만들지 확인 (벤치마킹)
            ** 요구사항은 반드시 제작 (조별 특성 추가?)
            - 사이트 파악 (흐름) => 기능
            - 사이트를 만들때 어떤 데이터가 필요한지 (담당 파트)
            - 데이터 저장
              ----------
                1. 카테고리
                    ------------------------
                    
                    ------------------------
                    
                    ------------------------
                    
                    ------------------------
                2. 맛집정보
        2) 데이터베이스 설계
            1. 중복된 데이터
            2. NULL이 있는 컬럼
            3. 매핑테이블
        3) 데이터베이스 첨부된 데이터를 이용해서 => 구현
        4) 유지보수
        5) 개선점, 검사
        ------------------------------------------------
         프로그램은 데이터관리
                  --------- VueJS / ReactJS => 데이터를 관리하는 프로그램
         데이터베이스 : 데이터를 저장하는 장소
         ---------- 메모리 / 파일 / RDBS (가장 쉽게 제어)
                    변수 / 배열 / 클래스 / 파일 (기능별 분리 => 제어하기 어렵다)
                    ------------------ 휘발성 (임시 저장)
        => 316page
            요구사항 수집 및 분석 => 아키텍처(DBA) => 실무 (테이블 설계 / 데이터 수집)
                 |
                설계
            ------------------
                 |
              개념적 설계 : 엔티티(테이블) => 데이터를 추출 (화면)
                 |
              논리적 설계 : 상세 => 데이터형, => 테이블 제작 ==> 구체화, 키의 종류
                 |
              물리적 설계 : 실제 테이블 (메모리 크기) 
              ----------------
              1) 프로젝트에 필요한 데이터 확인(개념적 설계)
              2) 논리적 설계
                    1. 관계형 데이터베이스 (RDBMS) => 오라클
                    -------------------------------------
                    => 데이터의 중복을 최소화
                      예매
                      ------------------------------------
                      예매번호
                      ------------------------------------
                      ** 아이디 ==> 예약시마다 (로그인)
                      ------------------------------------
                      ** 영화명
                      ------------------------------------
                      예약일
                      ------------------------------------
                      예약시간
                      ------------------------------------
                      인원
                      ------------------------------------
                      좌석번호
                      ------------------------------------
                      
                      ==> 구별 (구분자)
                         -------------
                          기본키 ==================> PRIMARY KEY
                          외래키(참조키) ===========> FOREGIN KEY
                ---------------------------------------------------------------
                데이터베이스 설계시 고려 사항
                1) 무결성 : 이상현상을 방지 (원하는 데이터만 제어) => 수정, 삭제
                2) 일치성 => 데이터간의 응답의 일치성 (참조키)
                3) 보안 => 파밍, SQL문장 => SQL을 자바에서 사용하지 않고 XML로 이용 (MyBatis) => View
                4) 효율성 => 응답시간 (인라인뷰, 인덱스)
                
                SELECT * FROM book;
                
                => 논리적 설계
                    테이블에 대한 특성 => 키를 부여 (제약조건)
                    ----------------
                    1) 속성값은 단일값을 가지고 있다
                        => 변수 : 값을 한개만 저장
                        => actor : 류준열(천경수), 유해진(인조) => , 가 들어가면 테이블을 따로 제작
                    2) 속성(컬럼)은 다른 이름을 가지고 있다 (식별자)
                    3) 속성의 순서는 상관없다
                    4) 테이블안에는 중복된 데이터를 첨부할 수 없다 (중복이 없는 값을 포함한다) => 무결성
                    5) 튜플 (ROW, RECORD) 순서는 상관없다 ==> 정렬 (ORDER BY, INDEX)
                 SELECT * FROM food_location; => 데이터 수집 : ASC
                 입력이 있는 경우 : 게시물 글쓰기, 댓글 => 최신 (DESC)
                 
                 키(KEY) => 중요
                 -------
                    종류
                     #슈퍼키 : 식별 => 튜플을 구분하는 모든 키를 모아서 슈퍼키
                    # 후보키 : 모든 테이블은 반드시 후보키 한개를 가지고 있다
                     기본키 : NULL값을 포함하지 않는 키 => 중복이 없는 키 (튜플 식별자 역할)
                             회원가입 => ID ... PRIMARY KEY
                     대체키 : 기본키를 잊어 버린 경우 => ID를 잊어버린 경우 => 찾는 키가 필요하다
                             전화 번호 / 이메일 ... UNIQUE
                     외래키 : 다른 테이블의 값을 참조 => 매핑 테이블
                     ---------------------------------------------------------------------
                     
                1. 맛집 : 망고플레이트 / 식신
                2. 레시피 : 10000개의 레시피
                           레시피 / 쉐프
                3. 레시피 => 레시피 스토어 
                4. 서울 여행 => 맛집 (명소, 자연, 쇼핑 ..)
                --------------------------------------
                  => 예약 (맛집)
                  => 장바구니 (결제 => 오픈API => 아이엠 포트)
                ------------------------------------------
                  => 추천, 코스
                  => 재료 => 가격비교 (이마트 ...) => 스프링
                --------------------------------------
                
                게시판 (자유게시판 => 댓글형 (다중))
                묻고답하기
                회원
                공지사항
                ----------> 맛집/레시피/여행 => 댓글 (프로시저)
                자료실 => 업로드/다운로드
                -------------------------------------------
                    1(게시판) : N(댓글) ==> 한개의 게시물 여러개의 댓글을 달 수 있다
                1. 게시판
                    게시물 번호
                    작성자
                    -- 이메일
                    -- 홈페이지
                    제목
                    내용
                    작성일
                    조회수
                    비밀번호 : 사용자 확인
                2. 댓글
                    댓글번호            (PK)
                    게시물 참조번호 ====> 게시판에서 참조 (FK)
                    아이디 ============> 회원에서 참조 (FK)
                    작성자
                    내용
                    작성일
                    -- 좋아요...
                    ** 다중 댓글
                    -----------------------
                    그룹번호
                    그룹 출력순서
                    간격
                    댓글의 갯수
                    참조 댓글
                    -----------------------
                    
                    예)
                            reply
                            ORDER BY gno ASC, gstep ASC
                                                                         
                                                    gno   gstep   gtab   root   depth
                                                                        (참조 (댓글 몇개)
                                                                       댓글번호)
                            --------------------------------------------------------------
                    1       AAAAAAAAAA               1      1       0      0      2
                    2         => BBBBBBBB            1      2       1      1      0
                    3         => CCCCCCCC            1      3       1      1      1
                    4             => DDDDDDDD        1      4       2      3      0
                    5       KKKKKKKKKK               2      1       0      0      1
                    6         => LLLLLLLL            2      2       1      5      0
                    
                 3. 묻고 답하기
                    ---------
                        => 질문 (사용자) ============> 마이페이지
                            => 답변하기 (관리자) ====> 관리자 페이지
                        
                      게시물번호
                      이름
                      제목
                      내용
                      비밀번호
                      조회수
                      작성일
                      답변여부확인 => y/n 
                      답변 체크
                      => 임의로 필요한 내용 추출
                --------------------------------------
                 4. 회원
                    아이디 => 중복체크 ==> 핵심1   (PK)
                    비밀번호
                    이름
                    성별
                    생년월일
                    이메일 -----------> 대체키    (UK)
                    -------------------
                    우편번호
                    주소 1              핵심2
                    주소 2 (상세)
                    ------------------- 
                    전화번호 -----------> 대체키   (UK)
                    소개
                    관리자/사용자 구분             (CK)
                
                 5. 공지사항
                     공지번호
                     작성자 ==> 회원참조(관리자)
                     제목
                     내용
                     공지종료
                     작성일 ==> 날짜/시간
                     조회수
                     비밀번호
                 6. 자료실
                    자료실 번호
                    작성자
                    제목
                    내용
                    작성일
                    조회수
                    비밀번호 : 사용자 확인
                    파일명
                    파일크기
                 ------------------------------------ 필수사항
                 ===> 화면 UI => 데이터 수집후에 출력
                 => 예약테이블
                 => 장바구니
                 => 구매테이블
                 => 카테고리
                 ------------------------------------
                 맛집
                 레시피
                 쉐프
                 스토어
                 서울여행 ==> 명소 / 자연 / 호텔 / 쇼핑몰 / 게스트 하우스 / 이벤트 / 축제,행사 ==> 벤치마킹 사이트보고 결정
                 ---------------------------------------------------------------------- 14~25개 테이블갯수
                 
                 => 좋아요, 찜하기 ... , 마이페이지, 관리자페이지 ...
                 
                 맛집 : 카테고리, 맛집정보
                 레시피 : 레시피, 쉐프
                 스토어 : 전체, 특가, 베스트, 신상품
                 
                 맛집
                    => 카테고리
                       카테번호(구분자)
                       제목
                       부제목
                       이미지
                       -------------------->
                    => 맛집정보
                       맛집번호
                       카테고리번호
                       맛집명
                       이미지 ========> 고려사항 (5개) ==> 테이블 분리
                       평점
                       주소
                       전화번호
                       음식종류
                       영업시간
                       주차
                       메뉴 ---> 고려 (5 ~ 10) ==> 테이블 분리
                       HIT ---> 인기순위
                       ---------------------- trigger
                       jjim
                       Like
                       ---------------------- 
                 레시피
                    => 레시피
                        - 레시피번호 (Sequence)
                        - 레시피이미지
                        - 쉐프이미지
                        - 쉐프명
                        - 레시피명
                        - 레시피 설명
                        - 정보1
                        - 정보2
                        - 정보3
                        - 재료 ------------- 고려
                        - 소스재료 ---------- 고려
                        - 조리순서 ---------- 고려
                            => 조리순서 / 이미지
                        - 레시피 작성자
                        - HIT
                        - Jjim
                        - Like
                        - 제작 영상 => 고려 (Youtube)
                        ===================================== 댓글
                    => 쉐프
                        - 쉐프번호
                        - 쉐프명
                        - mem_cont1 => 작품수
                        - mem_cont2 => 스크랩
                        - mem_cont3 => 조회수
                        - mem_cont7 => 팔로우
                    ------------------------------------------------
                    
                    => 스토어
                        - 전체 상품
                            - 상품 번호
                            - 이미지
                            - 상품명
                            - 상품소개
                            - 가격
                            - 할인
                            - 첫구매 금액
                            - 평점
                        - 특가 상품
                            - 상품 번호
                            - 이미지
                            - 상품명
                            - 상품소개
                            - 가격
                            - 할인
                            - 첫구매 금액
                            - 평점
                        - 신상품
                            - 상품 번호
                            - 이미지
                            - 상품명
                            - 상품소개
                            - 가격
                            - 할인
                            - 첫구매 금액
                            - 평점
                        - 베스트 상품
                            - 상품 번호
                            - 이미지
                            - 상품명
                            - 상품소개
                            - 가격
                            - 할인
                            - 첫구매 금액
                            - 평점
                    ----------------------------------------
                     => 댓글 / 찜하기 / 좋아요 / 장바구니 / 구매내역
                        ---------------------------------------
                    서울여행 : 코스 => 네이버 카페 / 네이버 블로그 => 추출
                    ==> Open API - MapReduce
                    ------------------------ 고민
                    명소 / 자연 / 호텔 / 쇼핑몰 / 게스트 하우스  
                     - 명소(자연, 호텔, 쇼핑, 게스트)번호
                     - 명칭
                     - 이미지
                     - 주소
                     - 소개
                    축제 / 행사
                      = 번호
                      = 행사명
                      = 행사 이미지
                      = 행사소개
                      = 행사기간
                      = 이용시간
                      = 이용금액
                      = 주소
                      = 교통정보
*/
/*
       개념적 설계 => 필요한 데이터 추출
       논리적 설계 => 키 종류 설정, 1:1, 1:N 설정 ...
            => 정규화
       물리적 설계 => 테이블 완성
                        |
                    데이터 수집 (SELECTOR) => 태그명, 클래스명, 아이디명, 가상선택자
                                                    --------------- 구분자 (태그)
                    <div></div>
                    
                    <<div id = "a">aaa<div>
                    <div class= "b">aaa<div> ===> 필요한 값
                    <div id = "c">aaa<div>
                    
                    div.b
                    
                    <div>aaa<div>
                    <div>bbb<div>  ===> 값
                    <div>ccc<div>
                    
                    div:eq(2)
*/








