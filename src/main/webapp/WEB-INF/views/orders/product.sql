drop table categoryLarge;
drop table categorySmall;

select * from categoryLarge;
create table categoryLarge(
	codeLarge int primary key auto_increment, /*대분류 코드*/
	largeName varchar(20) not null,	/*대분류이름*/
	content text not null  /*상세설명*/
);

insert into categoryLarge values (default,'정기구독','매번 실패없이 맛있는 과일을 구매하는 번거로움 없이 큐레이터가 가장 맛있는 시기에 갓 수확한 제철과일을 떄마다 알아서 집 앞까지 무료로 배송해드리는 서비스입니다.');
insert into categoryLarge values (default,'쇼핑하기','');

drop table categoryLarge;
drop table categorySmall;

create table categorySmall(
	codeLarge int not null, /*대분류코드*/
	codeSmall int not null primary key auto_increment, /*소분류코드*/
	smallName varchar(20) not null, /*소분류 이름*/
	content text not null, /*소분류 상세설명*/
	foreign key(codeLarge) references categoryLarge(codeLarge)
);

insert into categorySmall values (2,default,'제철과일','농촌진흥청,농림축삼식품부가 선정한 최고 농업기술 명인, 신지식농업인, 농업마이스터, 그리고 과일대전자 지자체 등에서 수상한 과일명인이 정성껏 재배한 프리미엄 제철과일을 맛보세요.');
insert into categorySmall values (2,default,'간편과일','가장 맛있는 시기에 갓 수확한 신선한 제철과일을 엄선하여 어떠한 첨가물도 없는 100%의 과일 그대로를 씻고 깎는 등의 번거로움 없이 간편하게 바로 드실 수 있도록 손질한 과일이에요.');
desc categorysmall;


insert into categorySmall values (2,default,'건강식품','올곧은 마음으로 안전하고 건강한 프리미엄 먹거리를 진심을 다해 정성껏 만든 몸에 좋고, 맛도 좋은 프리미엄 건강식품으로 건강관리 시작해 보세요.');
create table products(
	idx int primary key auto_increment, /*상품 고유번호*/
	codeLarge int not null, /*대분류*/
	codeSmall int not null, /*소분류*/
	code varchar(10) not null unique key, /*상품코드*/
	name varchar(50) not null, /*상품이름*/
	content varchar(100) not null, /*상품 간단 설명*/
	detail text not null,  /*상품소개 상세*/
	point int not null, /*구매혜택 포인트*/
	contry varchar(50) not null, /*원산지*/
	selloption varchar(50) not null, /*판매단위*/
	delivery varchar(100) not null, /*배송방법*/
	deliveryPrice int default 3500, /*배송비*/
	fName varchar(200) not null, /*상품 소개 썸네일 사진*/
	fSName varchar(200) not null, /*실제 저장된 사진*/
	price int not null, /*가격*/
	sellSw char(2) not null default 'OK', /*판매여부*/
	foreign key(codeLarge) references categoryLarge(codeLarge) on delete cascade,
	foreign key(codeSmall) references categorySmall(codeSmall) on delete cascade
);
drop table products;
drop table bucket;


insert into products values(default,1,1,'A01-001','제철과일 구독서비스(1회당 5만원)','가장 맛있을때 받아보는 제철과일 구독서비스','가장 맛있을때 받아보는 제철과일 구독서비스','noimage.jpg','noimage.jpg',50000,'OK');
insert into products values(default,1,1,'A01-002','제철과일 구독서비스(1회당 10만원)','','가장 맛있을때 받아보는 제철과일 구독서비스','noimage.jpg','noimage.jpg',100000,'OK');
insert into products values(default,1,1,'A02-002','제철과일 구독서비스(1회당 10만원)','','가장 맛있을때 받아보는 제철과일 구독서비스','noimage.jpg','noimage.jpg',100000,'OK');
insert into products values(default,1,1,'A01-002','제철과일 구독서비스(1회당 10만원)',
'가장 맛있을때 받아보는 제철과일 구독서비스','',1000,'한국','','새벽배송 or 일반배송',0,'noimage.jpg','noimage.jpg',200000,'OK');
insert into products values(default,1,1,'A02-001','[명인의 과일]서귀포 레드향 1kg',
'서귀포시 레드향 명인 제 1호','',188,'제주 서귀포','1kg내외/2kg내외','새벽배송 or 일반배송',3500,'noimage.jpg','noimage.jpg',18800,'OK');

delete  from products;

select p.*,l.largeName,s.smallName from products p, categorySmall s,categoryLarge l
 where p.codeLarge=l.codeLarge and p.codeSmall = s.codeSmall;
 
create table dbOption(
 idx int primary key auto_increment,
 productIdx int not null,
 optionName varchar(50) not null,
 optionPrice int not null
);

create table basis (
 idx int not null auto_increment primary key,
 photo varchar(100) not null,
 deliveryDetail text not null,
 deliveryPrice int not null,
 deliveryMinPrice int not null
);
drop table basis;
insert into basis values (default,'none.png','배송 설명란입니다.','3500','40000');


desc bucket;
select * from boards;

select p.*
,(select count(*) from orders o where o.productIdx = p.idx and o.orderSw=1) as orders
,(select count(*) from boards r,orders o where r.oIdx = o.idx  and o.productIdx = p.idx) as reviews
from products p order by reviews;

update boards set likes = likes+1 where idx = 157;