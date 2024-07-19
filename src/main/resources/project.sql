-- 테이블 삭제
DROP TABLE PARENT;
DROP TABLE CHILD;
DROP TABLE PARENT_POST;
DROP TABLE PARENT_COMMENT;
DROP TABLE PARENT_FILE;
DROP TABLE PARENT_REPORT;
DROP TABLE PARENT_NOTE;
DROP TABLE PRO;
DROP TABLE PRO_POST;
DROP TABLE PRO_COMMENT;
DROP TABLE PRO_FILE;
DROP TABLE PRO_REPORT;
DROP TABLE CLASS;
DROP TABLE CLASS_SAVE;
DROP TABLE REVIEW;
DROP TABLE IMG;
DROP TABLE RESERVATION;
DROP TABLE RESERVATION_DATE;
DROP TABLE RESERVATION_TIME;
DROP TABLE QUESTION;
DROP TABLE ANSWER;

-- 시퀀스 삭제
DROP SEQUENCE SEQ_PROJECT;

-- 부모 테이블
CREATE TABLE PARENT(
	PARENT_NUMBER NUMBER PRIMARY KEY, 			-- PK
	PARENT_EMAIL VARCHAR2(100) NOT NULL,		-- 이메일
	PARENT_PASSWORD VARCHAR2(100) NOT NULL,		-- 비밀번호
	PARENT_NAME VARCHAR2(100) NOT NULL,			-- 이름
	PARENT_NICKNAME VARCHAR2(100),				-- 닉네임, NOT NULL 제약조건 삭제
	PARENT_PHONE_NUMBER VARCHAR2(100) NOT NULL,	-- 휴대전화
	PARENT_ADDRESS VARCHAR2(100) NOT NULL,		-- 주소
	PARENT_PROFILE_IMAGE_URL VARCHAR2(100), 	-- 프로필 이미지, NOT NULL 제약조건 삭제
	PARENT_REPORT_COUNT NUMBER					-- 신고 당한 횟수 
);

-- 아이 테이블
CREATE TABLE CHILD(
	CHILD_NUMBER NUMBER PRIMARY KEY,				-- PK
	CHILD_NAME VARCHAR2(50) NOT NULL,				-- 이름
	CHILD_AGE NUMBER NOT NULL,						-- 나이
	CHILD_GENDER VARCHAR2(10) NOT NULL,				-- 성별
	CHILD_SPECIAL_ISSUES VARCHAR2(500) NOT NULL,	-- 특이사항
	PARENT_NUMBER NUMBER, 							-- FK (부모 테이블)
	CONSTRAINT FK_PARENT_TO_CHILD FOREIGN KEY(PARENT_NUMBER)
	REFERENCES PARENT(PARENT_NUMBER)
);

-- 부모 게시판 테이블
CREATE TABLE PARENT_POST(
	PARENT_POST_NUMBER NUMBER PRIMARY KEY,			-- PK
	PARENT_POST_TITLE VARCHAR2(100) NOT NULL,		-- 게시글 제목
	PARENT_POST_CONTENT VARCHAR2(1000) NOT NULL,	-- 게시글 내용
	PARENT_POST_VIEWS NUMBER DEFAULT 0 NOT NULL,	-- 게시글 조회 수, DEFAULT 값 0으로 설정 
	PARENT_POST_REGISTER_DATE DATE DEFAULT SYSDATE, -- 등록일, DEFAULT 값 현재 날짜로 설정
	PARENT_POST_UPDATE_DATE DATE DEFAULT SYSDATE,	-- 수정일
	PARENT_NUMBER NUMBER,							-- FK (부모 테이블)
	CONSTRAINT FK_PARENT_TO_POST FOREIGN KEY(PARENT_NUMBER)
	REFERENCES PARENT(PARENT_NUMBER)
);

-- 댓글 (부모) 테이블
CREATE TABLE PARENT_COMMENT(
	PARENT_COMMENT_NUMBER NUMBER PRIMARY KEY,			-- PK
	PARENT_COMMENT_CONTENT VARCHAR2(1000) NOT NULL,		-- 댓글 내용
	PARENT_COMMENT_REGISTER_DATE DATE DEFAULT SYSDATE,	-- 댓글 등록일, DEFAULT 값 현재 날짜로 설정
	PARENT_COMMENT_UPDATE_DATE DATE DEFAULT SYSDATE,	-- 댓글 수정일
	PARENT_NUMBER NUMBER,								-- FK (부모 테이블)
	PARENT_POST_NUMBER NUMBER,							-- FK (부모 게시판 테이블)
	CONSTRAINT FK_PARENT_TO_COMMENT_NUMBER FOREIGN KEY(PARENT_NUMBER)
	REFERENCES PARENT(PARENT_NUMBER),
	CONSTRAINT FK_PARENT_TO_COMMENT_POST FOREIGN KEY(PARENT_POST_NUMBER)
	REFERENCES PARENT_POST(PARENT_POST_NUMBER)
);

-- 첨부파일 (부모) 테이블
CREATE TABLE PARENT_FILE(
    PARENT_FILE_NUMBER NUMBER PRIMARY KEY,				-- PK
    PARENT_FILE_NAME VARCHAR2(100) NOT NULL,			-- 첨부파일 이름
    PARENT_FILE_SIZE NUMBER NOT NULL,					-- 첨부파일 용량
    PARENT_FILE_URL VARCHAR2(500) NOT NULL,				-- 첨부파일 주소
    PARENT_FILE_UPLOAD_TIME DATE DEFAULT SYSDATE,		-- 첨부파일 업로드 시간
    PARENT_POST_NUMBER NUMBER,							-- FK (부모 게시판 테이블)
    CONSTRAINT FK_PARENT_TO_FILE FOREIGN KEY(PARENT_POST_NUMBER)
    REFERENCES PARENT_POST(PARENT_POST_NUMBER)
);

-- 신고하기 ( 부모 ) 테이블
CREATE TABLE PARENT_REPORT(
	PARENT_REPORT_NUMBER NUMBER PRIMARY KEY,			-- PK
	PARENT_REPORT_TYPE VARCHAR2(100) NOT NULL,			-- 신고 유형
	PARENT_REPORT_CONTENT VARCHAR2(1000) NOT NULL,		-- 신고 내용
	PARENT_REPORT_REGISTER_DATE DATE DEFAULT SYSDATE,	-- 등록일
	PARENT_POST_NUMBER NUMBER,							-- FK (부모 게시판 테이블)
	CONSTRAINT FK_PARENT_TO_REPORT FOREIGN KEY(PARENT_POST_NUMBER)
	REFERENCES PARENT_POST(PARENT_POST_NUMBER)
);

-- 쪽지 (부모) 테이블
CREATE TABLE PARENT_NOTE(	
	PARENT_NOTE_NUMBER NUMBER PRIMARY KEY,				-- PK
	PARENT_NOTE_CONTENT VARCHAR2(1000) NOT NULL,		-- 쪽지 내용
	PARENT_NOTE_SEND_TIME DATE DEFAULT SYSDATE,			-- 쪽지 전송 시간, TIME 데이터 타입도 있지만 적용이 되지 않음. (DEFAULT 값 현재 날짜로 설정)
	PARENT_NOTE_ALARM_CHECK VARCHAR2(20) NOT NULL,		-- 쪽지 알림 체크 여부, DEFAULT 값이 들어가야 되는데 뭔지???
	PARENT_NUMBER NUMBER,								-- FK (부모 테이블)
	PRO_NUMBER NUMBER,									-- FK (전문가 테이블)
	CONSTRAINT FK_PARENT_TO_NOTE FOREIGN KEY(PARENT_NUMBER)
	REFERENCES PARENT(PARENT_NUMBER),
	CONSTRAINT FK_PRO_TO_NOTE FOREIGN KEY(PRO_NUMBER)
	REFERENCES PRO(PRO_NUMBER)
);

-- 전문가 테이블
CREATE TABLE PRO(
	PRO_NUMBER NUMBER PRIMARY KEY,									-- PK
	PRO_EMAIL VARCHAR2(100) NOT NULL,								-- 이메일
	PRO_PASSWORD VARCHAR2(100) NOT NULL,						-- 비밀번호
	PRO_NAME VARCHAR2(100) NOT NULL,								-- 이름
	PRO_NICKNAME VARCHAR2(100),											-- 별명, NOT NULL 제약조건 삭제
	PRO_PHONE_NUMBER VARCHAR2(100) NOT NULL,				-- 휴대전화
	PRO_ADDRESS VARCHAR2(300) NOT NULL,							-- 주소
	PRO_PROFILE_IMAGE_URL VARCHAR2(500),						-- 프로필 이미지, NOT NULL 제약조건 삭제
	PRO_FILE VARCHAR2(500),													-- 첨부 파일, NOT NULL 제약조건 삭제
	PRO_INTRO VARCHAR2(1000) NOT NULL								-- 자기 소개
);

-- 전문가 게시판 테이블
CREATE TABLE PRO_POST(
	PRO_POST_NUMBER NUMBER PRIMARY KEY,					-- PK
	PRO_POST_TITLE VARCHAR2(100) NOT NULL,				-- 게시글 제목
	PRO_POST_CONTENT VARCHAR2(1000) NOT NULL,			-- 게시글 내용
	PRO_POST_VIEWS NUMBER DEFAULT 0 NOT NULL,			-- 게시글 조회 수
	PRO_POST_REGISTER_DATE DATE DEFAULT SYSDATE,		-- 등록일
	PRO_POST_UPDATE_DATE DATE DEFAULT SYSDATE,			-- 수정일
	PRO_NUMBER NUMBER,									-- FK (전문가 테이블)
	CONSTRAINT FK_PRO_TO_POST FOREIGN KEY(PRO_NUMBER)
	REFERENCES PRO(PRO_NUMBER)
);

-- 댓글 ( 전문가 ) 테이블
CREATE TABLE PRO_COMMENT(
	PRO_COMMENT_NUMBER NUMBER PRIMARY KEY,				-- PK
	PRO_COMMENT_CONTENT VARCHAR2(1000) NOT NULL,		-- 댓글 내용
	PRO_COMMENT_REGISTER_DATE DATE DEFAULT SYSDATE,		-- 등록일
	PRO_COMMENT_UPDATE_DATE DATE DEFAULT SYSDATE,		-- 수정일
	PRO_POST_NUMBER NUMBER,								-- FK (전문가 게시판 테이블)
	PRO_NUMBER NUMBER,									-- FK (전문가 테이블)
	CONSTRAINT FK_PRO_TO_COMMENT_NUMBER FOREIGN KEY(PRO_POST_NUMBER)
	REFERENCES PRO_POST(PRO_POST_NUMBER),
	CONSTRAINT FK_PRO_TO_COMMENT_POST FOREIGN KEY(PRO_NUMBER)
	REFERENCES PRO(PRO_NUMBER)
);

-- 첨부파일 ( 전문가 ) 테이블
CREATE TABLE PRO_FILE(
	PRO_FILE_NUMBER NUMBER PRIMARY KEY,					-- PK
	PRO_FILE_NAME VARCHAR2(100) NOT NULL,				-- 첨부파일 이름
	PRO_FILE_URL VARCHAR2(500) NOT NULL,				-- 첨부파일 주소
	PRO_FILE_SIZE NUMBER NOT NULL,						-- 첨부파일 용량
	PRO_FILE_UPLOAD_TIME DATE DEFAULT SYSDATE,			-- 첨부파일 업로드 시간
	PRO_POST_NUMBER NUMBER,								-- FK (전문가 게시판 테이블)
	CONSTRAINT FK_PRO_TO_FILE FOREIGN KEY(PRO_POST_NUMBER)
	REFERENCES PRO_POST(PRO_POST_NUMBER)
);

-- 신고하기 ( 전문가 ) 테이블
CREATE TABLE PRO_REPORT(
	PRO_REPORT_NUMBER NUMBER PRIMARY KEY,				-- PK
	PRO_REPORT_TYPE VARCHAR2(200) NOT NULL,				-- 신고 유형
	PRO_REPORT_CONTENT VARCHAR2(1000) NOT NULL,			-- 신고 내용
	PRO_REPORT_REGISTER_DATE DATE DEFAULT SYSDATE,		-- 신고 등록일
	PRO_POST_NUMBER NUMBER,								-- FK (전문가 게시판 테이블)
	CONSTRAINT FK_PRO_TO_REPORT FOREIGN KEY(PRO_POST_NUMBER)
	REFERENCES PRO_POST(PRO_POST_NUMBER)
);

-- 수업 테이블
CREATE TABLE CLASS(
	CLASS_NUMBER NUMBER PRIMARY KEY,								-- PK
	CLASS_NAME VARCHAR2(100) NOT NULL,							-- 수업 이름
	CLASS_CATEGORY_BIG VARCHAR2(100) NOT NULL,			-- 수업 카테고리(대)
	CLASS_CATEGORY_SMALL VARCHAR2(100) NOT NULL, 		-- 수업 카테고리(소)
	CLASS_CONTENT VARCHAR2(1000) NOT NULL,					-- 수업 내용 (썸머 노트)
	CLASS_PAYMENT_ACCOUNT NUMBER NOT NULL,					-- 결제 금액
	CLASS_REGISTER_DATE DATE DEFAULT SYSDATE,				-- 수업 등록일
	PRO_NUMBER NUMBER,															-- FK (전문가 테이블)
	CONSTRAINT FK_PRO_TO_CLASS FOREIGN KEY(PRO_NUMBER)
	REFERENCES PRO(PRO_NUMBER)
);

-- 수업 찜 테이블
CREATE TABLE CLASS_SAVE(
	CLASS_NUMBER NUMBER,								-- FK (수업 테이블)
	PARENT_NUMBER NUMBER NOT NULL,			-- FK (부모 테이블), NOT NULL 제약조건 추가
	CONSTRAINT FK_CLASS_TO_SAVE FOREIGN KEY(CLASS_NUMBER)
	REFERENCES CLASS(CLASS_NUMBER),
	CONSTRAINT FK_PARENT_TO_SAVE FOREIGN KEY(PARENT_NUMBER)
	REFERENCES PARENT(PARENT_NUMBER)
);

-- 수업 리뷰 테이블 
CREATE TABLE REVIEW(
	REVIEW_NUMBER NUMBER PRIMARY KEY,			-- PK
	REVIEW_CONTENT VARCHAR2(1000) NOT NULL,		-- 리뷰 내용
	REVIEW_EVALUTION_POINT NUMBER NOT NULL,		-- 리뷰 별점
	REVIEW_REGISTER_DATE DATE DEFAULT SYSDATE,	-- 등록일
	REVIEW_UPDATE_DATE DATE DEFAULT SYSDATE,	-- 수정일
	PARENT_NUMBER NUMBER,						-- FK (부모 테이블)
	CLASS_NUMBER NUMBER,						-- FK (수업 테이블)
	CONSTRAINT FK_PARENT_TO_REVIEW FOREIGN KEY(PARENT_NUMBER)
	REFERENCES PARENT(PARENT_NUMBER),
	CONSTRAINT FK_CLASS_TO_REVIEW FOREIGN KEY(CLASS_NUMBER)
	REFERENCES CLASS(CLASS_NUMBER)
);

-- 이미지 테이블
CREATE TABLE IMG(
	IMAGE_NUMBER NUMBER PRIMARY KEY,			-- PK
	IMAGE_FILE_URL VARCHAR2(500) NOT NULL,		-- 이미지 파일 경로
	CLASS_NUMBER NUMBER,						-- FK (수업 테이블)
	CONSTRAINT FK_CLASS_TO_IMG FOREIGN KEY(CLASS_NUMBER)
	REFERENCES CLASS(CLASS_NUMBER)
);

-- 예약 날짜 테이블 
CREATE TABLE RESERVATION_DATE(
	RESERVATION_DATE_NUMBER NUMBER PRIMARY KEY,		-- PK
	RESERVATION_DATE DATE DEFAULT SYSDATE,			-- 예약 날짜
	CLASS_NUMBER NUMBER,							-- FK (수업 테이블)
	CONSTRAINT FK_CLASS_TO_RESERVATION_DATE FOREIGN KEY(CLASS_NUMBER)
	REFERENCES CLASS(CLASS_NUMBER)
);

-- 예약 시간 테이블
CREATE TABLE RESERVATION_TIME(
	RESERVATION_TIME_NUMBER NUMBER PRIMARY KEY,		-- PK 
	RESERVATION_TIME DATE NOT NULL,			        -- 예약 시간
	RESERVATION_DATE_NUMBER NUMBER,					-- FK (예약 날짜 테이블)
	CONSTRAINT FK_DATE_TO_TIME FOREIGN KEY(RESERVATION_DATE_NUMBER)
	REFERENCES RESERVATION_DATE(RESERVATION_DATE_NUMBER)
);

-- 예약 내역 (결제 내역) 테이블
CREATE TABLE RESERVATION(
	RESERVATION_DATE_NUMBER NUMBER,					-- FK (예약 날짜 테이블)
	RESERVATION_TIME_NUMBER NUMBER,					-- FK (예약 시간 테이블)
	PARENT_NUMBER NUMBER,							-- FK (부모 테이블)
	CHILD_NUMBER NUMBER,							-- FK (아이 테이블)
	CONSTRAINT FK_DATE_TO_RESERVATION FOREIGN KEY(RESERVATION_DATE_NUMBER)
	REFERENCES RESERVATION_DATE(RESERVATION_DATE_NUMBER),
	CONSTRAINT FK_TIME_TO_RESERVATION FOREIGN KEY(RESERVATION_TIME_NUMBER)
	REFERENCES RESERVATION_TIME(RESERVATION_TIME_NUMBER),
	CONSTRAINT FK_PARENT_TO_RESERVATION FOREIGN KEY(PARENT_NUMBER)
	REFERENCES PARENT(PARENT_NUMBER),
	CONSTRAINT FK_CHILD_TO_RESERVATION FOREIGN KEY(CHILD_NUMBER)
	REFERENCES CHILD(CHILD_NUMBER)
);

ALTER TABLE RESERVATION
    ADD REVIEW_COMPLETED NUMBER(1) DEFAULT 0;


-- 문의하기 테이블
CREATE TABLE QUESTION(
	QUESTION_NUMBER NUMBER PRIMARY KEY,				-- PK
	QUESTION_TITLE VARCHAR2(100) NOT NULL,			-- 문의하기 제목
	QUESTION_CONTENT VARCHAR2(1000) NOT NULL,		-- 문의하기 내용
	QUESTION_REGISTER_DATE DATE NOT NULL,			-- 등록일
	QUESTION_READING_CHECK VARCHAR2(50) NOT NULL,	-- 문의하기 게시글 열람 가능 여부 
	QUESTION_STATUS VARCHAR2(50) NOT NULL,			-- 문의하기 상태 (미완, 완료)
	PARENT_NUMBER NUMBER,							-- FK (부모 테이블)
	CONSTRAINT FK_PARENT_TO_QUESTION FOREIGN KEY(PARENT_NUMBER)
	REFERENCES PARENT(PARENT_NUMBER)
);

-- 문의 답변하기 테이블
CREATE TABLE ANSWER (
	ANSWER_NUMBER NUMBER PRIMARY KEY,				-- PK
	ANSWER_CONTENT VARCHAR2(1000) NOT NULL,			-- 답변 내용
	QUESTION_NUMBER NUMBER,							-- FK (문의하기 테이블)
	CONSTRAINT FK_QUESTION_TO_ANSWER FOREIGN KEY(QUESTION_NUMBER)
	REFERENCES QUESTION(QUESTION_NUMBER)
);

-- 시퀀스 생성
CREATE SEQUENCE SEQ_PROJECT
START WITH 1
INCREMENT BY 1
NOCACHE;

select SEQ_PROJECT.currval from dual; -- 현재 시퀀스 조회
drop sequence SEQ_PROJECT; -- 시퀀스 삭제

-- 더미 데이터 ( 수업 테이블 )
INSERT INTO CLASS (CLASS_NUMBER, CLASS_NAME, CLASS_CATEGORY_BIG, CLASS_CATEGORY_SMALL, CLASS_CONTENT, CLASS_PAYMENT_ACCOUNT, CLASS_REGISTER_DATE, PRO_NUMBER)
VALUES (SEQ_PROJECT.nextval, '기초 프로그래밍', '교육', '실내놀이', '프로그래밍의 기초부터 차근차근 배우는 수업입니다. 변수, 조건문, 반복문 등을 포함합니다.', 100000, SYSDATE, 4);

INSERT INTO CLASS (CLASS_NUMBER, CLASS_NAME, CLASS_CATEGORY_BIG, CLASS_CATEGORY_SMALL, CLASS_CONTENT, CLASS_PAYMENT_ACCOUNT, CLASS_REGISTER_DATE, PRO_NUMBER)
VALUES (SEQ_PROJECT.nextval, '웹 개발 입문', '교육', '실내놀이', 'HTML, CSS, JavaScript를 활용하여 웹 페이지를 만드는 방법을 배웁니다.', 150000, SYSDATE, 4);

INSERT INTO CLASS (CLASS_NUMBER, CLASS_NAME, CLASS_CATEGORY_BIG, CLASS_CATEGORY_SMALL, CLASS_CONTENT, CLASS_PAYMENT_ACCOUNT, CLASS_REGISTER_DATE, PRO_NUMBER)
VALUES (SEQ_PROJECT.nextval, '데이터 분석 기초', '돌봄', '놀이터', '기초적인 데이터 분석 방법과 도구 사용법을 배웁니다. Python 및 Excel 활용.', 200000, SYSDATE, 4);

INSERT INTO CLASS (CLASS_NUMBER, CLASS_NAME, CLASS_CATEGORY_BIG, CLASS_CATEGORY_SMALL, CLASS_CONTENT, CLASS_PAYMENT_ACCOUNT, CLASS_REGISTER_DATE, PRO_NUMBER)
VALUES (SEQ_PROJECT.nextval, '디지털 마케팅 전략', '돌봄', '놀이터', '효과적인 디지털 마케팅 전략을 세우고 실행하는 방법을 배웁니다.', 250000, SYSDATE, 5);

INSERT INTO CLASS (CLASS_NUMBER, CLASS_NAME, CLASS_CATEGORY_BIG, CLASS_CATEGORY_SMALL, CLASS_CONTENT, CLASS_PAYMENT_ACCOUNT, CLASS_REGISTER_DATE, PRO_NUMBER)
VALUES (SEQ_PROJECT.nextval, '영어 회화 기본', '예능', '책읽기', '기초적인 영어 회화 능력을 향상시키기 위한 수업입니다. 일상 대화 및 표현 연습.', 120000, SYSDATE, 5);

INSERT INTO CLASS (CLASS_NUMBER, CLASS_NAME, CLASS_CATEGORY_BIG, CLASS_CATEGORY_SMALL, CLASS_CONTENT, CLASS_PAYMENT_ACCOUNT, CLASS_REGISTER_DATE, PRO_NUMBER)
VALUES (SEQ_PROJECT.nextval, '재무 관리 기초', '예능', '책읽기', '기초적인 재무 관리 이론과 실습을 통해 재무 관리를 배우는 수업입니다.', 180000, SYSDATE, 5);

INSERT INTO CLASS (CLASS_NUMBER, CLASS_NAME, CLASS_CATEGORY_BIG, CLASS_CATEGORY_SMALL, CLASS_CONTENT, CLASS_PAYMENT_ACCOUNT, CLASS_REGISTER_DATE, PRO_NUMBER)
VALUES (SEQ_PROJECT.nextval, '사진 촬영 기술', '운동', '견학/체험 ', '기초부터 고급까지 사진 촬영 기술을 배우고 실습하는 과정입니다.', 160000, SYSDATE, 6);

INSERT INTO CLASS (CLASS_NUMBER, CLASS_NAME, CLASS_CATEGORY_BIG, CLASS_CATEGORY_SMALL, CLASS_CONTENT, CLASS_PAYMENT_ACCOUNT, CLASS_REGISTER_DATE, PRO_NUMBER)
VALUES (SEQ_PROJECT.nextval, '스포츠 마사지', '운동', '견학/체험 ', '스포츠 및 운동 후 회복을 위한 마사지 기법과 이론을 배웁니다.', 130000, SYSDATE, 6);

INSERT INTO CLASS (CLASS_NUMBER, CLASS_NAME, CLASS_CATEGORY_BIG, CLASS_CATEGORY_SMALL, CLASS_CONTENT, CLASS_PAYMENT_ACCOUNT, CLASS_REGISTER_DATE, PRO_NUMBER)
VALUES (SEQ_PROJECT.nextval, 'UX/UI 디자인', '돌봄', '등/하원', '사용자 경험과 사용자 인터페이스 디자인의 기초를 배우고 실습합니다.', 220000, SYSDATE, 6);

INSERT INTO CLASS (CLASS_NUMBER, CLASS_NAME, CLASS_CATEGORY_BIG, CLASS_CATEGORY_SMALL, CLASS_CONTENT, CLASS_PAYMENT_ACCOUNT, CLASS_REGISTER_DATE, PRO_NUMBER)
VALUES (SEQ_PROJECT.nextval, '비즈니스 영어', '교육', '등/하원', '비즈니스 상황에서의 영어 회화 및 서면 커뮤니케이션을 배우는 수업입니다.', 140000, SYSDATE, 7);

-- 더미 데이터 ( 수업 리뷰 테이블 )
INSERT INTO REVIEW (REVIEW_NUMBER, REVIEW_CONTENT, REVIEW_EVALUTION_POINT, REVIEW_REGISTER_DATE, REVIEW_UPDATE_DATE, PARENT_NUMBER, CLASS_NUMBER)
VALUES (SEQ_PROJECT.nextval, '이 수업은 매우 유익했습니다. 강사의 설명이 명확하고 이해하기 쉬웠습니다. 추천합니다!', 5, SYSDATE, SYSDATE, 3, 8);

INSERT INTO REVIEW (REVIEW_NUMBER, REVIEW_CONTENT, REVIEW_EVALUTION_POINT, REVIEW_REGISTER_DATE, REVIEW_UPDATE_DATE, PARENT_NUMBER, CLASS_NUMBER)
VALUES (SEQ_PROJECT.nextval, '수업 내용이 다소 부족했으나 강사가 열정적으로 진행했습니다.', 3, SYSDATE, SYSDATE, 3, 9);

INSERT INTO REVIEW (REVIEW_NUMBER, REVIEW_CONTENT, REVIEW_EVALUTION_POINT, REVIEW_REGISTER_DATE, REVIEW_UPDATE_DATE, PARENT_NUMBER, CLASS_NUMBER)
VALUES (SEQ_PROJECT.nextval, '전반적으로 좋았지만, 수업 진행 속도가 너무 빨라서 따라가기가 힘들었습니다.', 4, SYSDATE, SYSDATE, 3, 10);

INSERT INTO REVIEW (REVIEW_NUMBER, REVIEW_CONTENT, REVIEW_EVALUTION_POINT, REVIEW_REGISTER_DATE, REVIEW_UPDATE_DATE, PARENT_NUMBER, CLASS_NUMBER)
VALUES (SEQ_PROJECT.nextval, '강의가 매우 유익하고, 예제도 다양하게 제공되었습니다. 다만, 시간 관리가 아쉬웠습니다.', 4, SYSDATE, SYSDATE, 3, 11);

INSERT INTO REVIEW (REVIEW_NUMBER, REVIEW_CONTENT, REVIEW_EVALUTION_POINT, REVIEW_REGISTER_DATE, REVIEW_UPDATE_DATE, PARENT_NUMBER, CLASS_NUMBER)
VALUES (SEQ_PROJECT.nextval, '이 수업은 아주 흥미롭고 실용적이었습니다. 강사의 열정이 돋보였습니다.', 5, SYSDATE, SYSDATE, 3, 12);

INSERT INTO REVIEW (REVIEW_NUMBER, REVIEW_CONTENT, REVIEW_EVALUTION_POINT, REVIEW_REGISTER_DATE, REVIEW_UPDATE_DATE, PARENT_NUMBER, CLASS_NUMBER)
VALUES (SEQ_PROJECT.nextval, '내용이 너무 기초적이어서 더 심화된 내용이 필요했습니다. 그러나 강사는 친절했습니다.', 3, SYSDATE, SYSDATE, 3, 13);

INSERT INTO REVIEW (REVIEW_NUMBER, REVIEW_CONTENT, REVIEW_EVALUTION_POINT, REVIEW_REGISTER_DATE, REVIEW_UPDATE_DATE, PARENT_NUMBER, CLASS_NUMBER)
VALUES (SEQ_PROJECT.nextval, '전체적으로 만족스러웠으나, 수업이 너무 짧아서 아쉬웠습니다.', 4, SYSDATE, SYSDATE, 3, 14);

INSERT INTO REVIEW (REVIEW_NUMBER, REVIEW_CONTENT, REVIEW_EVALUTION_POINT, REVIEW_REGISTER_DATE, REVIEW_UPDATE_DATE, PARENT_NUMBER, CLASS_NUMBER)
VALUES (SEQ_PROJECT.nextval, '수업 내용이 알차고 실습이 많은 점이 좋았습니다. 다만, 자료가 부족했습니다.', 4, SYSDATE, SYSDATE, 3, 15);

INSERT INTO REVIEW (REVIEW_NUMBER, REVIEW_CONTENT, REVIEW_EVALUTION_POINT, REVIEW_REGISTER_DATE, REVIEW_UPDATE_DATE, PARENT_NUMBER, CLASS_NUMBER)
VALUES (SEQ_PROJECT.nextval, '강사의 전문성이 돋보였으며, 수업이 체계적으로 구성되어 있었습니다.', 5, SYSDATE, SYSDATE, 3, 16);

INSERT INTO REVIEW (REVIEW_NUMBER, REVIEW_CONTENT, REVIEW_EVALUTION_POINT, REVIEW_REGISTER_DATE, REVIEW_UPDATE_DATE, PARENT_NUMBER, CLASS_NUMBER)
VALUES (SEQ_PROJECT.nextval, '강의 내용이 좋았지만, 실습 시간이 부족했습니다. 추가적인 실습 시간이 필요합니다.', 3, SYSDATE, SYSDATE, 3, 17);

-- 테스트 코드

-- 특정 전문가가 진행하는 특정 수업에 대한 모든 리뷰조회
SELECT R.REVIEW_NUMBER,
       R.REVIEW_CONTENT,
       R.REVIEW_EVALUTION_POINT,
       R.REVIEW_REGISTER_DATE,
       R.REVIEW_UPDATE_DATE,
       R.PARENT_NUMBER,
       R.CLASS_NUMBER
 FROM (
        SELECT
            P.PRO_NAME,
            C.CLASS_NUMBER,
            C.CLASS_CATEGORY_BIG,
            C.CLASS_CATEGORY_SMALL,
            C.CLASS_CONTENT
        FROM PRO P
          JOIN CLASS C
            ON P.PRO_NUMBER = 4
            AND C.CLASS_NUMBER = 18
    ) DETAIL JOIN REVIEW R
    ON DETAIL.CLASS_NUMBER = R.CLASS_NUMBER;

SELECT * FROM REVIEW;
<<<<<<< HEAD
SELECT * FROM IMG;
SELECT * FROM RESERVATION;
SELECT * FROM RESERVATION_DATE;
SELECT * FROM RESERVATION_TIME;
SELECT * FROM QUESTION;
SELECT * FROM ANSWER;

-- 모든 테이블 INSERT 쿼리문
INSERT INTO PARENT
(PARENT_NUMBER, PARENT_EMAIL, PARENT_PASSWORD, PARENT_NAME, PARENT_NICKNAME, PARENT_PHONE_NUMBER, PARENT_ADDRESS, PARENT_PROFILE_IMAGE_URL, PARENT_REPORT_COUNT)
VALUES(2, 'cdsf577@naver.com', '20198diff', '김시도', '김밥', '01023370987', '김해', 'kim.img', 35);

INSERT INTO CHILD
(CHILD_NUMBER, CHILD_NAME, CHILD_AGE, CHILD_GENDER, CHILD_SPECIAL_ISSUES, PARENT_NUMBER)
VALUES(0, '', 0, '', '', 0);

INSERT INTO PARENT_POST
(PARENT_POST_NUMBER, PARENT_POST_TITLE, PARENT_POST_CONTENT, PARENT_POST_VIEWS, PARENT_POST_REGISTER_DATE, PARENT_POST_UPDATE_DATE, PARENT_NUMBER)
VALUES(0, '', '', 0, '', '', 0);

INSERT INTO PARENT_COMMENT
(PARENT_COMMENT_NUMBER, PARENT_COMMENT_CONTENT, PARENT_COMMENT_REGISTER_DATE, PARENT_COMMENT_UPDATE_DATE, PARENT_NUMBER, PARENT_POST_NUMBER)
VALUES(0, '', '', '', 0, 0);

INSERT INTO PARENT_FILE
(PARENT_FILE_NUMBER, PARENT_FILE_NAME, PARENT_FILE_SIZE, PARENT_FILE_UPLOAD_TIME, PARENT_POST_NUMBER)
VALUES(0, '', 0, '', 0);

INSERT INTO PARENT_REPORT
(PARENT_REPORT_NUMBER, PARENT_REPORT_TYPE, PARENT_REPORT_CONTENT, PARENT_REPORT_REGISTER_DATE, PARENT_POST_NUMBER)
VALUES(0, '', '', '', 0);

INSERT INTO PARENT_NOTE
(PARENT_NOTE_NUMBER, PARENT_NOTE_CONTENT, PARENT_NOTE_SEND_TIME, PARENT_NOTE_ALARM_CHECK, PARENT_NUMBER, PRO_NUMBER)
VALUES(0, '', '', '', 0, 0);

INSERT INTO PRO
(PRO_NUMBER, PRO_EMAIL, PRO_PASSWORD, PRO_NAME, PRO_NICKNAME, PRO_PHONE_NUMBER, PRO_ADDRESS, PRO_PROFILE_IMAGE_URL, PRO_FILE, PRO_INTRO)
VALUES(SEQ_PROJECT.nextval, 'ds221@nffdfffdk.com', '123344244', '나는 전문가', '프로이죠', '010-2233-3324', '수원', 'pro.jpg', 'sd', '안녕하세요.');

INSERT INTO PRO_POST
(PRO_POST_NUMBER, PRO_POST_TITLE, PRO_POST_CONTENT, PRO_POST_VIEWS, PRO_POST_REGISTER_DATE, PRO_POST_UPDATE_DATE, PRO_NUMBER)
VALUES(0, '', '', 0, '', '', 0);

INSERT INTO PRO_COMMENT
(PRO_COMMENT_NUMBER, PRO_COMMENT_CONTENT, PRO_COMMENT_REGISTER_DATE, PRO_COMMENT_UPDATE_DATE, PRO_POST_NUMBER, PRO_NUMBER)
VALUES(0, '', '', '', 0, 0);

INSERT INTO PRO_FILE
(PRO_FILE_NUMBER, PRO_FILE_NAME, PRO_FILE_URL, PRO_FILE_SIZE, PRO_FILE_UPLOAD_TIME, PRO_POST_NUMBER)
VALUES(0, '', '', 0, '', 0);

INSERT INTO PRO_REPORT
(PRO_REPORT_NUMBER, PRO_REPORT_TYPE, PRO_REPORT_CONTENT, PRO_REPORT_REGISTER_DATE, PRO_POST_NUMBER)
VALUES(0, '', '', '', 0);

INSERT INTO CLASS
(CLASS_NUMBER, CLASS_NAME, CLASS_CATEGORY_BIG, CLASS_CATEGORY_SMALL, CLASS_CONTENT, CLASS_PAYMENT_ACCOUNT, PRO_NUMBER)
VALUES(SEQ_PROJECT.nextval, '어린이 등/하원 시켜주기', '돌봄', '견학/체험', '아이들의 오감을 키우기 위해 학교를 견학/체험 한다.', 17000, 4);

select * from class;

INSERT INTO CLASS_SAVE
(CLASS_NUMBER, PARENT_NUMBER)
VALUES(0, 0);

INSERT INTO REVIEW
(REVIEW_NUMBER, REVIEW_CONTENT, REVIEW_EVALUTION_POINT, REVIEW_REGISTER_DATE, REVIEW_UPDATE_DATE, PARENT_NUMBER, CLASS_NUMBER)
VALUES(0, '', 0, '', '', 0, 0);

INSERT INTO IMG
(IMAGE_NUMBER, IMAGE_FILE_URL, CLASS_NUMBER)
VALUES(0, '', 0);

INSERT INTO RESERVATION
(RESERVATION_DATE_NUMBER, RESERVATION_TIME_NUMBER, PARENT_NUMBER, CHILD_NUMBER)
VALUES(0, 0, 0, 0);

INSERT INTO RESERVATION_DATE
(RESERVATION_DATE_NUMBER, RESERVATION_DATE, CLASS_NUMBER)
VALUES(0, '', 0);

INSERT INTO RESERVATION_TIME
(RESERVATION_TIME_NUMBER, RESERVATION_TIME, RESERVATION_DATE_NUMBER)
VALUES(0, '', 0);

INSERT INTO QUESTION
(QUESTION_NUMBER, QUESTION_TITLE, QUESTION_CONTENT, QUESTION_REGISTER_DATE, QUESTION_READING_CHECK, QUESTION_STATUS, PARENT_NUMBER)
VALUES(0, '', '', '', '', '', 0);

INSERT INTO ANSWER
(ANSWER_NUMBER, ANSWER_CONTENT, QUESTION_NUMBER)
VALUES(0, '', 0);


-- 테스트

INSERT INTO PRO
(PRO_NUMBER, PRO_EMAIL, PRO_PASSWORD, PRO_NAME, PRO_NICKNAME, PRO_PHONE_NUMBER, PRO_ADDRESS, PRO_PROFILE_IMAGE_URL, PRO_FILE, PRO_INTRO)
VALUES(SEQ_PROJECT.nextval, 'dssd@nsdsfdk.com', '1234', '전문가1', '전문', '030-245-3434', '서울시 강북구', 'SSD.MPG', 'SDS', '전문가입니다.');

select * from pro;
select * from parent;

INSERT INTO CLASS
(CLASS_NUMBER, CLASS_NAME, CLASS_CATEGORY_BIG, CLASS_CATEGORY_SMALL, CLASS_CONTENT, CLASS_PAYMENT_ACCOUNT, PRO_NUMBER)
VALUES(SEQ_PROJECT.nextval, '어린이 등/하원 시켜주기', '돌봄', '놀이터', '아이들과 놀이터에서 재밌고 유익한 시간을 보낸다.', 25000, 15);

select * from class;

INSERT INTO REVIEW
(REVIEW_NUMBER, REVIEW_CONTENT, REVIEW_EVALUTION_POINT, REVIEW_REGISTER_DATE, REVIEW_UPDATE_DATE, PARENT_NUMBER, CLASS_NUMBER)
VALUES(SEQ_PROJECT.nextval, '이 수업은 ', 4, sysdate, sysdate, 1, 19);



-- 수업 등록에서 추가할 때, 등록된 예약 날짜 및 시간을 들고와서, 수업 상세보기 페이지에서 뿌려줘야 한다.
SELECT
    CLASS.PRO_NUMBER,
    CLASS.PRO_NAME,
    CLASS.CLASS_NUMBER,
    CLASS.CLASS_NAME,
    CLASS.CLASS_CATEGORY_BIG,
    CLASS.CLASS_CATEGORY_SMALL,
    CLASS.CLASS_CONTENT,
    CLASS.CLASS_PAYMENT_ACCOUNT,
    TO_CHAR(CLASS.CLASS_REGISTER_DATE, 'YYYY-MM-DD / HH24') || '시'  AS CLASS_REGISTER_DATE
FROM
    (
        SELECT
            P.*,
            C.CLASS_CATEGORY_BIG,
            C.CLASS_CATEGORY_SMALL,
            C.CLASS_CONTENT,
            C.CLASS_NAME,
            C.CLASS_NUMBER,
            C.CLASS_PAYMENT_ACCOUNT,
            C.CLASS_REGISTER_DATE
        FROM PRO P JOIN CLASS C

        ON P.PRO_NUMBER = C.PRO_NUMBER
        AND C.PRO_NUMBER = 1
    ) CLASS
WHERE CLASS.CLASS_NUMBER = 20;


SELECT
    p.pro_profile_image_url, -- 전문가 이미지
    p.pro_name, -- 전문가 이름
    COALESCE(AVG(r.review_evaluation_point), 0) AS averageRating, -- 평균 평점, NULL 값은 0으로 대체
    COUNT(r.review_number) AS reviewCount -- 리뷰 개수
FROM
    pro p -- 전문가 테이블
        LEFT JOIN
    review r ON p.pro_number = r.class_number -- 리뷰 테이블을 전문가 테이블과 LEFT JOIN
GROUP BY
    p.pro_name, -- 전문가 이름으로 그룹화
    p.pro_profile_image_url -- 전문가 이미지 URL로 그룹화
ORDER BY
    averageRating DESC, -- 평균 평점이 높은 순으로 정렬
    reviewCount DESC;



SELECT
    p.pro_profile_image_url, -- 전문가 이미지
    p.pro_name, -- 전문가 이름
    COALESCE(AVG(r.review_evaluation_point), 0) AS averageRating, -- 평균 평점, NULL 값은 0으로 대체
    COUNT(r.review_number) AS reviewCount -- 리뷰 개수
FROM
    pro p -- 전문가 테이블
    JOIN
    class c -- 리뷰테이블
    ON p.pro_number = c.PRO_NUMBER -- 리뷰 테이블을 전문가 테이블과 JOIN
    join review r -- 수업테이블
    on c.class_number = r.class_number -- 전문가 테이블과 수업테이블 join
GROUP BY
    p.pro_name,-- 전문가 이름으로 그룹화
    p.pro_profile_image_url -- 전문가 이미지 URL로 그룹화
-- ORDER BY
--     averageRating DESC;






=======
            ON P.PRO_NUMBER = C.PRO_NUMBER
            AND C.PRO_NUMBER = 4
    ) CLASS JOIN IMG I
    ON CLASS.CLASS_NUMBER = I.CLASS_NUMBER;

-- 예약 날짜와 예약 시간 테이블을 조인하는 쿼리문
SELECT *
FROM(
SELECT
       D.RESERVATION_DATE_NUMBER,
       D.CLASS_NUMBER,
       D.RESERVATION_DATE,
       T.RESERVATION_TIME
FROM RESERVATION_DATE D JOIN RESERVATION_TIME T
    ON D.RESERVATION_DATE_NUMBER = T.RESERVATION_DATE_NUMBER
    AND D.RESERVATION_DATE_NUMBER = 102
    )
WHERE RESERVATION_DATE = TO_DATE('2024-05-24')
AND RESERVATION_TIME = TO_DATE('2024-05-24 10:00:00', 'YY-MM-DD HH24:MI:SS');

-- 56번 (2024-05-24) / 175번 (2024-06-15)
insert into RESERVATION_DATE (RESERVATION_DATE_NUMBER, RESERVATION_DATE, CLASS_NUMBER)
values (SEQ_PROJECT.nextval, TO_DATE('2024-06-15'), 8);

-- 68번 ( 2024-05-24 ) , 196번 (2024-07-10 )
insert into RESERVATION_DATE (RESERVATION_DATE_NUMBER, RESERVATION_DATE, CLASS_NUMBER)
values (SEQ_PROJECT.nextval, TO_DATE('2024-07-10'), 9);

-- 91번 ( 2024-05-24) , 195번 ( 2024-07-10 )
insert into RESERVATION_DATE (RESERVATION_DATE_NUMBER, RESERVATION_DATE, CLASS_NUMBER)
values (SEQ_PROJECT.nextval, TO_DATE('2024-07-10'), 10);

-- 102번 (2024-07-10), 211번 (2024-05-24)
insert into RESERVATION_DATE (RESERVATION_DATE_NUMBER, RESERVATION_DATE, CLASS_NUMBER)
values (SEQ_PROJECT.nextval, TO_DATE('2024-05-24'), 11);

-- 113번 (2024-07-10), 222번 (2024-05-24)
insert into RESERVATION_DATE (RESERVATION_DATE_NUMBER, RESERVATION_DATE, CLASS_NUMBER)
values (SEQ_PROJECT.nextval, TO_DATE('2024-05-24'), 12);

-- 124번 (2024-07-10), 229번 (2024-05-24)
insert into RESERVATION_DATE (RESERVATION_DATE_NUMBER, RESERVATION_DATE, CLASS_NUMBER)
values (SEQ_PROJECT.nextval, TO_DATE('2024-05-24'), 13);

SELECT * FROM RESERVATION_DATE;
SELECT * FROM RESERVATION_TIME;

DELETE FROM RESERVATION_TIME
WHERE RESERVATION_TIME_NUMBER = 244;
SELECT * FROM RESERVATION_TIME
WHERE RESERVATION_DATE_NUMBER = 68;


-- 11번 수업에 대해서만 예약 시간(09 ~ 18시) 추가 ( 2024-07-10 )
-- 8, 9번 수업에 대한 예약 날짜, 시간 추가 ( 56, 68번 - 2024-05-24 )
INSERT INTO RESERVATION_TIME (RESERVATION_TIME_NUMBER, RESERVATION_TIME, RESERVATION_DATE_NUMBER)
VALUES (1, TO_DATE('2024-07-10 14:00:00', 'YY-MM-DD HH24:MI:SS'), 124);

-- 날짜에서 시간 데이터만 DATE타입으로 저장하는 방법
-- TO_DATE(TO_CHAR(TO_DATE('2024-07-10 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'HH24:MI:SS'), 'HH24:MI:SS')

SELECT * FROM CLASS;
SELECT * FROM RESERVATION_DATE;
SELECT * FROM RESERVATION_TIME;
SELECT * FROM PRO;
SELECT * FROM IMG;
SELECT * FROM REVIEW;

-- 이미지 더미 데이터 추가
insert into IMG (IMAGE_NUMBER, IMAGE_FILE_URL, CLASS_NUMBER)
values (SEQ_PROJECT.nextval, 'content-img4.jpg', 13);

SELECT * FROM CLASS;
SELECT * FROM IMG;

-- 이미지가 등록된 전문가의 특정 수업을 조회
SELECT
    I.IMAGE_FILE_URL,
    I.IMAGE_NUMBER,
    CLASS.PRO_NUMBER,
    CLASS.PRO_NAME,
    CLASS.CLASS_NUMBER,
    CLASS.CLASS_NAME,
    CLASS.CLASS_CATEGORY_BIG,
    CLASS.CLASS_CATEGORY_SMALL,
    CLASS.CLASS_CONTENT,
    CLASS.CLASS_PAYMENT_ACCOUNT,
    TO_CHAR(CLASS.CLASS_REGISTER_DATE, 'YYYY-MM-DD / HH24') || '시'  AS CLASS_REGISTER_DATE
FROM
    (
        SELECT
            P.*,
            C.CLASS_CATEGORY_BIG,
            C.CLASS_CATEGORY_SMALL,
            C.CLASS_CONTENT,
            C.CLASS_NAME,
            C.CLASS_NUMBER,
            C.CLASS_PAYMENT_ACCOUNT,
            C.CLASS_REGISTER_DATE
        FROM PRO P JOIN CLASS C
                        ON P.PRO_NUMBER = C.PRO_NUMBER
                            AND C.PRO_NUMBER = 4
    ) CLASS JOIN IMG I
     ON CLASS.CLASS_NUMBER = I.CLASS_NUMBER;
--     AND CLASS.CLASS_NUMBER = 8;

SELECT * FROM RESERVATION_DATE;

-- 특정 수업에 대한 특정 예약날짜 정보와 모든 예약시간 정보 조회
SELECT *
FROM(
        SELECT
            D.RESERVATION_DATE_NUMBER,
            D.CLASS_NUMBER,
            D.RESERVATION_DATE,
            T.RESERVATION_TIME
        FROM RESERVATION_DATE D JOIN RESERVATION_TIME T
                                     ON D.RESERVATION_DATE_NUMBER = T.RESERVATION_DATE_NUMBER
    )
WHERE CLASS_NUMBER = 10;

SELECT P.PARENT_NAME,
       R.*
FROM REVIEW R JOIN PARENT P
                   ON R.PARENT_NUMBER = P.PARENT_NUMBER
WHERE R.CLASS_NUMBER = 10;

SELECT * FROM RESERVATION_DATE;

SELECT
    TO_CHAR(RESERVATION_TIME, 'HH24') AS HOUR
FROM
    RESERVATION_TIME
WHERE TO_CHAR(RESERVATION_TIME, 'HH24') > 8 AND TO_CHAR(RESERVATION_TIME, 'HH24') < 20
ORDER BY HOUR;

SELECT *
FROM(
        SELECT
            D.RESERVATION_DATE_NUMBER,
            D.CLASS_NUMBER,
            D.RESERVATION_DATE,
            TO_CHAR(T.RESERVATION_TIME, 'HH24') AS RESERVATION_TIME
        FROM RESERVATION_DATE D JOIN RESERVATION_TIME T
        ON D.RESERVATION_DATE_NUMBER = T.RESERVATION_DATE_NUMBER
    )
WHERE CLASS_NUMBER = 10;

ALTER TABLE CLASS ADD CLASS_INTRO VARCHAR2(500);







