
create table servey(
	idx int not null auto_increment primary key,
	title varchar(50) not null,
	content varchar(50) not null,
	memo varchar(50) not null,
	sDate datetime default now() not null,
	startDate datetime not null,
	endDate datetime not null,
	showSw int not null
);

insert into servey values(default,'과일 구매 시 애로사항을 알려주세요!','리얼후르츠에서 소비자 맞춤 서비스를 할수 있게 도와주세요.','',now(),20230201,20230501,1);

drop table answer;
drop table question;
drop table servey;

create table question(
	idx int not null auto_increment primary key,
	sIdx int not null,
	qcontent varchar(50),
	answerSw int not null,
	foreign key(sIdx) references servey(idx) on delete restrict
);
insert into question values  (default,1,'가장 좋아하는 과일은 무엇인가요?',1);
insert into question values  (default,1,'과일 구매 시 애로사항을 알려주세요.',1);
insert into question values  (default,1,'그 밖에 리얼 후르츠한테 원하는것을 자유롭게 써주세요.',0);

select * from question;

create table answer(
	idx int not null auto_increment primary key,
	sIdx int not null,
	qIdx int not null,
	acontent  varchar(50),
	foreign key(sIdx) references servey(idx) on delete restrict,
	foreign key(qIdx) references question(idx) on delete restrict
);

create table realAnswer(
	idx int not null auto_increment primary key,
	bIdx int not null,
	sIdx int not null,
	qIdx int not null,
	aIdx int not null,
	detailAnswer varchar(50)  not null,
	foreign key(sIdx) references servey(idx) on delete restrict,
	foreign key(qIdx) references question(idx) on delete restrict,
	foreign key(bIdx) references basicServey(idx) on delete restrict
);



insert into answer values (default,1,1,'딸기');
insert into answer values (default,1,1,'사과');
insert into answer values (default,1,1,'배');
insert into answer values (default,1,1,'복숭아');
insert into answer values (default,1,2,'대량구매');
insert into answer values (default,1,2,'짧은유통기한');
insert into answer values (default,1,2,'비싼가격');






create table basicServey(
	idx int not null auto_increment primary key,
	gender varchar(4) not null,
	age varchar(15) not null,
	address varchar(15) not null
);


drop table basicServey;

select * from question where sIdx=1;
select * from answer where sIdx=1 and qIdx=1 and qIdx in (select qIdx from question where answerSw=1);

select * from realAnswer where sIdx=1;

select acontent from answer a where sIdx=1 ; 
select * from answer where sIdx=1
select count(*) from realAnswer group by aIdx;

select *,(select count(*) from realAnswer where aIdx=a.idx group by aIdx ) as realAnswerCnt from answer a where sIdx = 1;


select * from realAnswer where sIdx=1 and bIdx in (select idx from basicServey where gender='남자');