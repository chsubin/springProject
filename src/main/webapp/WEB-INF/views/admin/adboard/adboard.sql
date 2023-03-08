
create table boards(
	idx int not null auto_increment primary key, /*고유번호*/
	mid varchar(20) not null, /*아이디*/
	title varchar(50) not null, /*제목*/
	content text not null, /*상세내용 */
	wDate datetime not null default now(), /*작성일*/
	sw int not null /*공지사항, 이모저모*/
);

create table boardsReply(
	idx int not null auto_increment primary key, /*고유번호*/
	boardIdx int not null, /*게시글 고유번호*/
	level int not null, /*0,1*/
	pIdx int not null, /*댓글 고유번호*/
	mid varchar(20) not null,/*아이디*/
	content varchar(200) not null, /*내용*/
	rDate datetime default now()/*내용*/
);
drop table boardsReply;

insert into boardsReply values (default,1,0,idx,'admin','댓글입니다.');
select * from boardsReply;

1. 댓글번호 오름차순대로 0번이면 고유번호 따라감
2. 레벨 오름차순
3. idx 오름차순



insert into boards values (1,'admin','이벤트게시판입니다.','앞으로 이벤트를 올릴 예정입니다. 많은 참여 바랍니다.',now(),0);

select count(*) from board where sw=1;

select * from boardsreply;

select * from qnas;

select count(*) from qnas where answerSw='n' group by questionId;