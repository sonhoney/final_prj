


-----------------------------------------------------------------------------------------
create table member(
    mid  varchar2(20)
    ,pwd  varchar2(20)  not  null
    ,primary key(mid)

);

insert into member values('abc','123');
commit;

select * from member;
-----------------------------------------------------------------------------------------
create table board(
    b_no      number(9)                        --게시판 글 고유번호
    ,subject   varchar2(50)     not null       --글 제목
    ,writer    varchar2(30)     not null       --글쓴이 이름
    ,content   varchar2(2000)   not null       --글 내용
    ,pwd       varchar2(12)     not null       --암호
    ,email     varchar2(30)                    --이메일
    ,reg_date   date            default sysdate  --등록일
    ,readcount  number(5)       default 0        --조회수
    ----------------------------------------------------------
    ,group_no   number(9)       not null         --게시판 글의 소속 그룹번호. 정렬 시 사용.
    ,print_no   number(9)       not null         --같은 그룹번호 내에서 화면 출력 순서 번호.정렬 시 사용.
    ,print_level number(9)      not null         --같은 그룹번호 내에서 댓글 들여쓰기 레벨 단계 번호. 
                                                 --부모 자식 관계를 알수 있다.
    ----------------------------------------------------------
    , primary key(b_no)
)

select * from    board;


insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (1,'제목1','내용 1','송예인','1111','abc1@naver.com',0,to_date('1969-05-23_11:04:52', 'YYYY-MM-DD_HH:MI:SS'),1,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (2,'제목2','내용 2','구철천','1111','abc2@naver.com',1,to_date('1971-06-08_08:56:20', 'YYYY-MM-DD_HH:MI:SS'),2,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (3,'제목3','내용 3','송덕혜','1111','abc3@naver.com',3,to_date('1972-02-22_07:29:57', 'YYYY-MM-DD_HH:MI:SS'),3,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (4,'제목4','내용 4','구진현','1111','abc4@naver.com',1,to_date('1972-02-26_06:30:08', 'YYYY-MM-DD_HH:MI:SS'),4,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (5,'제목5','내용 5','성현운','1111','abc5@naver.com',0,to_date('1973-05-05_12:51:05', 'YYYY-MM-DD_HH:MI:SS'),5,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (6,'제목6','내용 6','피천인','1111','abc6@naver.com',0,to_date('1974-02-08_08:47:08', 'YYYY-MM-DD_HH:MI:SS'),6,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (7,'제목7','내용 7','유단호','1111','abc7@naver.com',0,to_date('1974-09-07_01:34:14', 'YYYY-MM-DD_HH:MI:SS'),7,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (8,'제목8','내용 8','송온혜','1111','abc8@naver.com',0,to_date('1975-01-12_09:12:01', 'YYYY-MM-DD_HH:MI:SS'),8,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (9,'제목9','내용 9','문인순','1111','abc9@naver.com',3,to_date('1975-04-27_09:32:02', 'YYYY-MM-DD_HH:MI:SS'),9,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (10,'제목10','내용 10','마린지','1111','abc10@naver.com',3,to_date('1976-04-13_05:43:48', 'YYYY-MM-DD_HH:MI:SS'),10,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (11,'제목11','내용 11','마철나','1111','abc11@naver.com',3,to_date('1976-08-07_07:54:30', 'YYYY-MM-DD_HH:MI:SS'),11,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (12,'제목12','내용 12','우장예','1111','abc12@naver.com',2,to_date('1976-08-19_09:36:42', 'YYYY-MM-DD_HH:MI:SS'),12,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (13,'제목13','내용 13','이영열','1111','abc13@naver.com',2,to_date('1976-11-13_06:17:52', 'YYYY-MM-DD_HH:MI:SS'),13,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (14,'제목14','내용 14','피호윤','1111','abc14@naver.com',1,to_date('1977-03-22_08:26:03', 'YYYY-MM-DD_HH:MI:SS'),14,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (15,'제목15','내용 15','라만태','1111','abc15@naver.com',1,to_date('1977-03-25_12:10:37', 'YYYY-MM-DD_HH:MI:SS'),15,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (16,'제목16','내용 16','조만유','1111','abc16@naver.com',0,to_date('1978-07-19_02:57:52', 'YYYY-MM-DD_HH:MI:SS'),16,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (17,'제목17','내용 17','유재유','1111','abc17@naver.com',3,to_date('1979-03-24_01:15:31', 'YYYY-MM-DD_HH:MI:SS'),17,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (18,'제목18','내용 18','박빈조','1111','abc18@naver.com',2,to_date('1981-02-26_09:10:15', 'YYYY-MM-DD_HH:MI:SS'),18,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (19,'제목19','내용 19','강민현','1111','abc19@naver.com',0,to_date('1981-06-22_07:00:53', 'YYYY-MM-DD_HH:MI:SS'),19,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (20,'제목20','내용 20','서민진','1111','abc20@naver.com',3,to_date('1981-09-29_11:19:54', 'YYYY-MM-DD_HH:MI:SS'),20,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (21,'제목21','내용 21','손단희','1111','abc21@naver.com',1,to_date('1983-01-21_08:59:22', 'YYYY-MM-DD_HH:MI:SS'),21,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (22,'제목22','내용 22','장지만','1111','abc22@naver.com',3,to_date('1983-01-29_01:03:26', 'YYYY-MM-DD_HH:MI:SS'),22,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (23,'제목23','내용 23','허성복','1111','abc23@naver.com',0,to_date('1983-02-20_08:57:10', 'YYYY-MM-DD_HH:MI:SS'),23,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (24,'제목24','내용 24','구단진','1111','abc24@naver.com',1,to_date('1983-09-30_01:44:18', 'YYYY-MM-DD_HH:MI:SS'),24,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (25,'제목25','내용 25','김지재','1111','abc25@naver.com',3,to_date('1983-10-28_02:01:52', 'YYYY-MM-DD_HH:MI:SS'),25,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (26,'제목26','내용 26','남지윤','1111','abc26@naver.com',0,to_date('1983-12-02_07:47:37', 'YYYY-MM-DD_HH:MI:SS'),26,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (27,'제목27','내용 27','신아사','1111','abc27@naver.com',3,to_date('1984-07-04_11:20:28', 'YYYY-MM-DD_HH:MI:SS'),27,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (28,'제목28','내용 28','신은용','1111','abc28@naver.com',1,to_date('1984-10-29_04:22:44', 'YYYY-MM-DD_HH:MI:SS'),28,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (29,'제목29','내용 29','신인나','1111','abc29@naver.com',0,to_date('1984-11-08_05:19:09', 'YYYY-MM-DD_HH:MI:SS'),29,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (30,'제목30','내용 30','조도윤','1111','abc30@naver.com',0,to_date('1985-01-20_09:12:24', 'YYYY-MM-DD_HH:MI:SS'),30,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (31,'제목31','내용 31','이희주','1111','abc31@naver.com',2,to_date('1985-02-10_05:58:11', 'YYYY-MM-DD_HH:MI:SS'),31,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (32,'제목32','내용 32','윤사성','1111','abc32@naver.com',2,to_date('1986-01-13_06:15:06', 'YYYY-MM-DD_HH:MI:SS'),32,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (33,'제목33','내용 33','우미경','1111','abc33@naver.com',0,to_date('1986-04-15_11:18:52', 'YYYY-MM-DD_HH:MI:SS'),33,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (34,'제목34','내용 34','피윤상','1111','abc34@naver.com',0,to_date('1986-09-28_04:30:13', 'YYYY-MM-DD_HH:MI:SS'),34,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (35,'제목35','내용 35','윤진순','1111','abc35@naver.com',2,to_date('1988-01-24_07:14:26', 'YYYY-MM-DD_HH:MI:SS'),35,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (36,'제목36','내용 36','라수나','1111','abc36@naver.com',2,to_date('1988-02-14_10:38:55', 'YYYY-MM-DD_HH:MI:SS'),36,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (37,'제목37','내용 37','고조린','1111','abc37@naver.com',1,to_date('1989-02-12_00:08:20', 'YYYY-MM-DD_HH:MI:SS'),37,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (38,'제목38','내용 38','우구온','1111','abc38@naver.com',0,to_date('1989-02-13_02:39:35', 'YYYY-MM-DD_HH:MI:SS'),38,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (39,'제목39','내용 39','임국덕','1111','abc39@naver.com',3,to_date('1989-05-02_06:27:25', 'YYYY-MM-DD_HH:MI:SS'),39,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (40,'제목40','내용 40','구만아','1111','abc40@naver.com',2,to_date('1989-08-23_02:51:32', 'YYYY-MM-DD_HH:MI:SS'),40,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (41,'제목41','내용 41','추인천','1111','abc41@naver.com',1,to_date('1990-01-22_05:51:30', 'YYYY-MM-DD_HH:MI:SS'),41,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (42,'제목42','내용 42','민윤규','1111','abc42@naver.com',0,to_date('1990-07-23_05:04:30', 'YYYY-MM-DD_HH:MI:SS'),42,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (43,'제목43','내용 43','조구비','1111','abc43@naver.com',3,to_date('1990-07-27_08:17:30', 'YYYY-MM-DD_HH:MI:SS'),43,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (44,'제목44','내용 44','신인호','1111','abc44@naver.com',0,to_date('1990-08-01_02:34:39', 'YYYY-MM-DD_HH:MI:SS'),44,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (45,'제목45','내용 45','마나현','1111','abc45@naver.com',1,to_date('1990-08-06_10:24:26', 'YYYY-MM-DD_HH:MI:SS'),45,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (46,'제목46','내용 46','라주예','1111','abc46@naver.com',2,to_date('1990-11-22_08:56:28', 'YYYY-MM-DD_HH:MI:SS'),46,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (47,'제목47','내용 47','고철단','1111','abc47@naver.com',3,to_date('1991-02-21_09:07:37', 'YYYY-MM-DD_HH:MI:SS'),47,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (48,'제목48','내용 48','윤만호','1111','abc48@naver.com',1,to_date('1992-05-22_07:37:47', 'YYYY-MM-DD_HH:MI:SS'),48,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (49,'제목49','내용 49','임장경','1111','abc49@naver.com',0,to_date('1992-07-02_09:19:07', 'YYYY-MM-DD_HH:MI:SS'),49,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (50,'제목50','내용 50','반미인','1111','abc50@naver.com',1,to_date('1992-07-06_01:12:31', 'YYYY-MM-DD_HH:MI:SS'),50,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (51,'제목51','내용 51','안현영','1111','abc51@naver.com',3,to_date('1992-10-17_01:31:01', 'YYYY-MM-DD_HH:MI:SS'),51,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (52,'제목52','내용 52','박운아','1111','abc52@naver.com',3,to_date('1994-04-03_04:23:32', 'YYYY-MM-DD_HH:MI:SS'),52,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (53,'제목53','내용 53','선경성','1111','abc53@naver.com',0,to_date('1994-09-07_10:31:02', 'YYYY-MM-DD_HH:MI:SS'),53,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (54,'제목54','내용 54','강수규','1111','abc54@naver.com',3,to_date('1995-04-30_03:49:42', 'YYYY-MM-DD_HH:MI:SS'),54,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (55,'제목55','내용 55','이국연','1111','abc55@naver.com',0,to_date('1995-08-07_04:32:55', 'YYYY-MM-DD_HH:MI:SS'),55,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (56,'제목56','내용 56','이지윤','1111','abc56@naver.com',1,to_date('1995-12-09_02:39:47', 'YYYY-MM-DD_HH:MI:SS'),56,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (57,'제목57','내용 57','신동복','1111','abc57@naver.com',3,to_date('1996-03-28_02:34:29', 'YYYY-MM-DD_HH:MI:SS'),57,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (58,'제목58','내용 58','권호정','1111','abc58@naver.com',3,to_date('1996-07-25_02:48:21', 'YYYY-MM-DD_HH:MI:SS'),58,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (59,'제목59','내용 59','피현예','1111','abc59@naver.com',0,to_date('1996-08-05_02:04:31', 'YYYY-MM-DD_HH:MI:SS'),59,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (60,'제목60','내용 60','라복린','1111','abc60@naver.com',0,to_date('1996-08-06_03:35:51', 'YYYY-MM-DD_HH:MI:SS'),60,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (61,'제목61','내용 61','구은희','1111','abc61@naver.com',0,to_date('1997-09-28_04:03:40', 'YYYY-MM-DD_HH:MI:SS'),61,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (62,'제목62','내용 62','나조란','1111','abc62@naver.com',0,to_date('1998-02-24_10:18:21', 'YYYY-MM-DD_HH:MI:SS'),62,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (63,'제목63','내용 63','피연인','1111','abc63@naver.com',1,to_date('1998-08-06_02:59:45', 'YYYY-MM-DD_HH:MI:SS'),63,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (64,'제목64','내용 64','남단미','1111','abc64@naver.com',0,to_date('1999-08-11_01:06:39', 'YYYY-MM-DD_HH:MI:SS'),64,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (65,'제목65','내용 65','선희철','1111','abc65@naver.com',3,to_date('1999-10-12_04:02:11', 'YYYY-MM-DD_HH:MI:SS'),65,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (66,'제목66','내용 66','류구사','1111','abc66@naver.com',3,to_date('2000-04-10_08:41:33', 'YYYY-MM-DD_HH:MI:SS'),66,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (67,'제목67','내용 67','반도국','1111','abc67@naver.com',3,to_date('2000-06-16_06:51:14', 'YYYY-MM-DD_HH:MI:SS'),67,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (68,'제목68','내용 68','장영연','1111','abc68@naver.com',1,to_date('2001-07-26_11:24:55', 'YYYY-MM-DD_HH:MI:SS'),68,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (69,'제목69','내용 69','추아예','1111','abc69@naver.com',1,to_date('2003-03-28_00:23:06', 'YYYY-MM-DD_HH:MI:SS'),69,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (70,'제목70','내용 70','장임인','1111','abc70@naver.com',2,to_date('2003-06-07_08:53:03', 'YYYY-MM-DD_HH:MI:SS'),70,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (71,'제목71','내용 71','피만정','1111','abc71@naver.com',3,to_date('2003-10-17_11:04:47', 'YYYY-MM-DD_HH:MI:SS'),71,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (72,'제목72','내용 72','임윤신','1111','abc72@naver.com',3,to_date('2004-01-15_05:08:06', 'YYYY-MM-DD_HH:MI:SS'),72,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (73,'제목73','내용 73','추운경','1111','abc73@naver.com',2,to_date('2004-12-04_09:38:46', 'YYYY-MM-DD_HH:MI:SS'),73,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (74,'제목74','내용 74','류성경','1111','abc74@naver.com',2,to_date('2005-01-17_03:32:47', 'YYYY-MM-DD_HH:MI:SS'),74,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (75,'제목75','내용 75','신은빈','1111','abc75@naver.com',1,to_date('2005-04-03_05:44:13', 'YYYY-MM-DD_HH:MI:SS'),75,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (76,'제목76','내용 76','장도미','1111','abc76@naver.com',0,to_date('2006-11-25_08:17:50', 'YYYY-MM-DD_HH:MI:SS'),76,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (77,'제목77','내용 77','송사주','1111','abc77@naver.com',1,to_date('2006-12-16_02:12:25', 'YYYY-MM-DD_HH:MI:SS'),77,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (78,'제목78','내용 78','권우빈','1111','abc78@naver.com',3,to_date('2006-12-31_01:39:36', 'YYYY-MM-DD_HH:MI:SS'),78,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (79,'제목79','내용 79','선상우','1111','abc79@naver.com',2,to_date('2008-05-27_03:43:32', 'YYYY-MM-DD_HH:MI:SS'),79,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (80,'제목80','내용 80','허은지','1111','abc80@naver.com',1,to_date('2009-05-16_11:08:48', 'YYYY-MM-DD_HH:MI:SS'),80,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (81,'제목81','내용 81','신운온','1111','abc81@naver.com',0,to_date('2009-05-22_10:44:30', 'YYYY-MM-DD_HH:MI:SS'),81,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (82,'제목82','내용 82','추순나','1111','abc82@naver.com',2,to_date('2009-06-15_07:10:50', 'YYYY-MM-DD_HH:MI:SS'),82,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (83,'제목83','내용 83','허경나','1111','abc83@naver.com',0,to_date('2009-09-17_01:30:40', 'YYYY-MM-DD_HH:MI:SS'),83,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (84,'제목84','내용 84','선동장','1111','abc84@naver.com',3,to_date('2010-09-09_05:42:28', 'YYYY-MM-DD_HH:MI:SS'),84,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (85,'제목85','내용 85','피철장','1111','abc85@naver.com',0,to_date('2012-03-13_11:12:44', 'YYYY-MM-DD_HH:MI:SS'),85,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (86,'제목86','내용 86','장연온','1111','abc86@naver.com',0,to_date('2012-04-22_05:48:04', 'YYYY-MM-DD_HH:MI:SS'),86,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (87,'제목87','내용 87','고빈온','1111','abc87@naver.com',2,to_date('2012-09-01_05:04:26', 'YYYY-MM-DD_HH:MI:SS'),87,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (88,'제목88','내용 88','장도운','1111','abc88@naver.com',3,to_date('2012-10-28_01:34:22', 'YYYY-MM-DD_HH:MI:SS'),88,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (89,'제목89','내용 89','박시순','1111','abc89@naver.com',2,to_date('2014-12-15_11:51:06', 'YYYY-MM-DD_HH:MI:SS'),89,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (90,'제목90','내용 90','추온영','1111','abc90@naver.com',1,to_date('2015-08-26_09:26:44', 'YYYY-MM-DD_HH:MI:SS'),90,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (91,'제목91','내용 91','구임사','1111','abc91@naver.com',1,to_date('2015-08-27_08:01:48', 'YYYY-MM-DD_HH:MI:SS'),91,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (92,'제목92','내용 92','추빈신','1111','abc92@naver.com',1,to_date('2015-10-21_01:38:08', 'YYYY-MM-DD_HH:MI:SS'),92,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (93,'제목93','내용 93','손재용','1111','abc93@naver.com',2,to_date('2016-01-31_03:36:36', 'YYYY-MM-DD_HH:MI:SS'),93,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (94,'제목94','내용 94','문도단','1111','abc94@naver.com',2,to_date('2016-02-05_03:20:25', 'YYYY-MM-DD_HH:MI:SS'),94,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (95,'제목95','내용 95','라민성','1111','abc95@naver.com',1,to_date('2016-04-29_12:16:28', 'YYYY-MM-DD_HH:MI:SS'),95,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (96,'제목96','내용 96','피열호','1111','abc96@naver.com',0,to_date('2016-06-04_05:47:11', 'YYYY-MM-DD_HH:MI:SS'),96,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (97,'제목97','내용 97','고은만','1111','abc97@naver.com',0,to_date('2017-03-15_04:04:54', 'YYYY-MM-DD_HH:MI:SS'),97,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (98,'제목98','내용 98','송신진','1111','abc98@naver.com',0,to_date('2017-08-31_09:38:45', 'YYYY-MM-DD_HH:MI:SS'),98,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (99,'제목99','내용 99','우예정','1111','abc99@naver.com',1,to_date('2017-09-21_12:06:42', 'YYYY-MM-DD_HH:MI:SS'),99,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (100,'제목100','내용 100','마웅빈','1111','abc100@naver.com',2,to_date('2018-09-21_11:38:12', 'YYYY-MM-DD_HH:MI:SS'),100,0,0); 
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (101,'제목101','내용 101','마조경','1111','abc101@naver.com',0,to_date('2019-02-17_06:56:45', 'YYYY-MM-DD_HH:MI:SS'),101,0,0); 
