show tables;

create table members (
  idx int not null auto_increment,	/* 회원 고유번호 */
  mid varchar(20) not null,					/* 회원 아이디(중복불허) */
 	name varchar(20) not null,  			/*이름*/
  pwd varchar(100) not null,				/* 비밀번호(SHA암호화 처리) */
  address varchar(100),							/* 회원주소(상품 배달시 기본주소로 사용) */
  tel		  varchar(15),							/* 전화번호(010-1234-5678) */
  gender   varchar(5) default '남자',	/* 성별 */
  birthday datetime   default now(),	/* 생일 */
  email   varchar(50) not null,			/* 이메일(아이디/비밀번호 분실시 사용) - 형식체크필수 */
  level			int default 2,					/* 회원등급(0:관리자, 1:운영자, 2:회원)*/
  comname varchar(50) not null default '', /*법인명*/
  comnumber varchar(15) not null default '', /*사업자번호*/
  owner varchar(50) not null default '', /*대표자*/
  compart varchar(50) not null default '', /*업종*/
  point  int not null default 0, /*포인트*/
  userDel  char(2) not null default 'NO', /*회원 탈퇴*/
  receiveSw char(2) not null default 'NO', /*수신동의*/
  startDate datetime default now(),	/* 최초 가입일 */
  lastDate  datetime default now(), /* 마지막 접속일 */
  primary key(idx,mid)							/* 주키: idx(고유번호), mid(아이디) */
);
drop table members;
select * from members;
drop table members;

select o.*,p.name as productName,p.fSName as fSName,d.optionName as optionName from orders o,products p,DBoption d where mid='admin' and p.idx=o.productIdx and d.idx= o.optionIdx order by idx desc limit 5,1;

select *,(select price from coupons whe비밀번호 암호화 저장
-> 정규식 이용
re o.couponIdx=idx) as couponPrice from orderSub o where  oIdx='g1676273746226';

select o.*,c.price as couponPrice from orderSub o,coupons c where oIdx='g1676273746226'  and (o.couponIdx = c.idx or o.couponIdx=0) order by idx desc limit 1;