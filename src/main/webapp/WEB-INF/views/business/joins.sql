

create table joinsApply (
	idx int not null auto_increment primary key,
	mid varchar(20) not null,
	name varchar(20) not null,
	comname varchar(50) not null,
	tel varchar(20) not null,
	email varchar(50)  not null,
	part varchar(50) not null,
	content text not null,
	applyResult text not null
);

show tables;
drop table joinsApply;
drop table joins;
/*가맹점 등록*/
create table joins(
	idx int not null auto_increment primary key,
	mid varchar(50) not null,
	name varchar(20) not null,
	comname varchar(50) not null,
	tel varchar(50) not null,
	email varchar(50) not null,
	part varchar(50) not null,
	compart varchar(50) not null, /**/
	content text not null,
	memo text not null,
  comaddress		varchar(50) not null,	/* 지점명 */
  latitude	double not null,			/* 위도 */
  longitude double not null,				/* 경도 */
  joinSw int not null default 0/**/
);
/*상품등록*/
create table requestList(
 idx int not null auto_increment primary key,
 joinsIdx int not null,
 productName varchar(50),
);

create table joinProduct(
	idx int not null auto_increment primary key,
	joinsIdx int not null,
	productName varchar(50) not null,
	productUnit varchar(50) not null
);
create table joinRequest(
	idx int not null auto_increment primary key,
	productIdx int not null, /*상품고유번호*/
	productNum varchar(50) not null, /*상품개수*/
	content varchar(100) not null default, /**/
	rDate datetime default now(), /*요청날짜*/
	rSw int not null default 0,  /*상태 받았는지 안받았는지*/
	foreign key(productIdx) references joinProduct(idx) on delete restrict
);


desc kakaoAddress;

select * from kakaoAddress order by address;

delete from kakaoAddress;

select * from joins order by idx desc limit 0,2;
select * from joinProduct p where p.joinsIdx in (select idx from joins order by idx desc limit 0,2);

select * from qnas where questionId='pms1234' and answerSw!='x' or questionId='' ;

select * from orders where orderDate<20230218;

select count(*) as cnt ,mid from orders group by mid order by cnt desc limit 7;