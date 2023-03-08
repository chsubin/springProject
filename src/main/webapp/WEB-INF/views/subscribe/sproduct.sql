
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

select count(*) from orders where orderSw!=0  and subSw='' ;

select *,(select ) from products;

select * from products;
