
show tables;

create table sproduct(
	idx int not null auto_increment,	/* 정기구독 고유번호 */
  title varchar(50) not null,					/* single/double/preimium 등등*/
 	content varchar(50) not null,  			/*간단한 설명*/
  detail varchar(100) not null,				/* 자세한 설명 */
  price int not null,							/* 가격 */
  fName varchar(100),							/*원본파일*/
  fSName varchar(100),			  		/*서버에 저장된 파일 이름*/
  primary key(idx)							/* 주키: idx(고유번호), mid(아이디) */
);

create table categoryLarge( /*1: 정기구독,2:쇼핑하기,3:B2B*/
	codeLarge int not null auto_increment, /*대분류*/
	largename varchar(20) not null,
	primary key(codeLarge)
);

insert into categoryLarge values (1,'정기배송');
insert into categoryLarge values (2,'쇼핑하기');
insert into categoryLarge values (3,'비즈몰');

create table categorySmall( 
	codeLarge int not null,/*대분류코드*/ 
	codeSmall int not null primary key auto_increment, /*소분류코드*/
	smallName varchar(20) not null, /*소분류코드이름*/
	content varchar(100) not null, /*소분류 설명*/
  foreign key(codeLarge) references categoryLarge(codeLarge) on delete restrict
);
insert into categorySmall values (2,1,'제철과일','제철과일 설명');
insert into categorySmall values (2,2,'간편과일','간편과일 설명');

drop table categoryLarge;
drop table categorySmall;

desc bucket;
