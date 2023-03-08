

/*1대 1 qna 만들기 */
create table qnas (
	idx int not null auto_increment primary key,
	part varchar(50) not null,
	question varchar(200) not null, /*질문*/
	questionId varchar(20) not null, /*보낸사람*/
	questionSw char(1) not null, /*보낸메시지(s),휴지통(g)-생략,휴지통에서 삭제(x)표시*/
	questionDate datetime default now(), /*보낸날짜*/
	answer varchar(200) not null, /*답변*/ 
	answerSw char(1) not null, /*보낸메시지(s),휴지통(g)-생략,휴지통에서 삭제(x)표시*/
	answerDate datetime,  /*답변날짜*/
	level int default 0 not null /**/
);

drop table qnas;

insert into qnas values (default,'구독','주말에 시간있니?','admin','s',default,'','s',null,1);
insert into qnas values (default,'구독','','','s',default,'모든분들께 알립니다. 채팅방 서비스를 시작하였습니다. 많이 사용해주세요.!','s',default,1);
insert into qnas values (default,'구독','','','s',default,'공지입니다.','s',default,1);
insert into qnas values (default,'구독','구독에 대해 질문하고 싶어용','admin','s',default,'도배하면 경고를 당합니다.','s',default,1);
insert into qnas values (default,'구독','구독은 뭔가요?','admin','s',default,'도배하면 경고를 당합니다.','s',default,1);
insert into qnas values (default,'구독','구독은 뭔가요?','admin','s',default,'','s',null,1);

/*
create table webMessage(
	idx int not null auto_increment primary key, /*고유번호*/
	title varchar(100) not null, /*메시지 제목*/
	content text not null, /*메시지 내용*/
	sendId varchar(20) not null, /*보낸사람 아이디*/
	sendSw char(1) not null, /*보낸메시지(s),휴지통(g)-생략,휴지통에서 삭제(x)표시*/
	sendDate datetime default now(), /*메시지 보낸날짜*/
	receiveId varchar(20) not null, /*받는사람아이디*/
	receiveSw char(2) not null, /*받은메시지(n) , 읽은메시지(r),휴지통(g), 휴지통에서 삭제(x)*/
	receiveDate datetime default now() /*메세지 받은날짜*/
);
*/
select * from qnas;
select * from qnas;
select * from qnas  group by questionId order by answerSw;

select q.*,(select answerSw from qnas order by answerSw limit 1) as aSw,(select answerDate from qnas order by answerDate limit 1) as aDate 
	,(select questionDate from qnas where questionId=q.questionId order by questionDate desc limit 1) as qDate from qnas q
	where questionId!=''  group by questionId order by idx desc;
	
select distinct q.questionId,idx,(select questionId from qnas where q.questionId=questionId order by idx desc limit 1) as qId from qnas q order by idx desc;
select distinct q.questionId,(select questionId from qnas where q.questionId=questionId order by idx desc limit 1) as qId from qnas q order by idx desc;

select (select distinct questionId from qnas order by idx) as qid from qnas where questionId in (select distinct questionId from qnas order by idx) group by questionId;
select questionId,(select distinct questionId from qnas order by idx) as qid from qnas where questionId in (select distinct questionId from qnas order by idx) group by questionId;

select distinct questionId from qnas order by idx desc;
select distinct questionId from qnas order by idx desc group by questionId;


		select q.*,(select answerSw from qnas order by answerSw limit 1) as aSw,(select answerDate from qnas order by answerDate limit 1) as aDate 
		,(select questionDate from qnas where questionId=q.questionId order by questionDate desc limit 1) as qDate from qnas q
		where questionId!='' group by questionId order by idx desc;
		
select from questionId order;
		

select * from qnas where questionId='pms1234' and questionSw!='x'  or questionId='' ;