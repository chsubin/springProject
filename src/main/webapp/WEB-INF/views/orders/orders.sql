show tables;

create table bucket(
	idx int auto_increment primary key not null,
	mid varchar (20) not null, /*회원아이디*/
	productIdx int not null, /*상품 고유번호*/
	optionIdx int not null, /*옵션고유번호*/
	optionNum int not null default 1, /*상품개수*/
	optionDetail varchar(100) default '', /*알레르기과일*/
	totalPrice int not null, /*전체 금액*/
	foreign key(productIdx) references products(idx),
	foreign key(optionIdx) references dbOption(idx)
);
drop table bucket;

create table orders(
	idx int auto_increment primary key not null,
	orderIdx varchar(20) not null,
	mid varchar (20) not null, /*회원아이디*/
	name varchar (20) not null, /*이름*/
	email varchar (50) not null, /*이메일*/
	address varchar(200) not null, /*주소*/
	tel varchar(15) not null, /*주소*/
	productIdx int not null, /*상품 고유번호*/
	optionIdx int not null, /*옵션고유번호*/
	optionNum int not null default 1, /*상품개수*/
	optionDetail varchar(100) default '', /*알레르기과일*/
	totalPrice int not null, /*전체 금액*/
	orderSw int not null, /*결제여부*/
	orderDate  datetime default now(),
	foreign key(productIdx) references products(idx),
	foreign key(optionIdx) references dbOption(idx)
);
desc dboption;
drop table orders;

select *,p.name as name, o.optionName
from bucket b,products p,dboption o
where b.mid='admin'
and p.idx = b.productIdx
and o.idx = b.optionIdx;

update bucket set optionNum=optionNum+1,totalPrice=totalPrice+69800 where mid='admin' and productIdx=4 and optionIdx=15;

select p.*,(select sum(optionNum) from orders where p.idx = productIdx ) as orderNum from products p  where p.codelarge=2 ;


select (select name from products where idx = o.productIdx) as productName from orders o  group by productIdx limit 7; /*판매량 순*/
select mid from orders o group by mid limit 7; /*판매량 순*/

select *,(select count(*) from orders o where p.idx = o.productIdx and orderDate>='20230213' and orderDate<'20230220' group by productIdx ) as sellCnt from products p order by cnt desc;

select *,datediff(now(),o.orderDate) as day_diff from orders o 


		select *
		,(select count(*) from orders o 
		where p.idx = o.productIdx and orderDate>='20230213' and orderDate<'20230220' group by productIdx ) as sellCnt
		 from products p order by sellCnt desc limit 7;
		 
//////select sum(s.totalPrice) from orderSub s where s.oIdx in (select orderIdx from orders where DATE_FORMAT(orderDate,'%Y-%m-%d')='2023-02-18');
select sum(s.totalPrice) from orderSub s, orders o where s.oIdx = o.orderIdx and o.orderSw>0 ;

delete from orders where orderIdx not in (select oIdx from orderSub);

delete from orderSub where oIdx not in (select orderIdx from orders);

select sum(s.totalPrice) from orderSub s;

select * from orderSub;

select * from orderSub;

select * from smallcategory;

select sum(optionNum) as cnt,sum(o.totalPrice),
(select smallName from categorySmall where codeSmall=p.codeSmall)
from orders o,products p
where orderSw>=0 and p.idx=o.productIdx and p.codeLarge=2 
and o.orderDate>='2023-02-13' and o.orderDate<'2023-02-20'
group by p.codesmall;

select * from products p

select * from orders where mid in (select mid from members where level='3');

select *,
(select count(*) from orders where orderSw!=0 and p.idx=productIdx) as orders, 
(select count(*) from boards r,orders o where p.idx=o.productIdx and o.idx = r.oidx) as reviews
from products p;

		select p.*,l.largeName,s.smallName
		,(select count(*) from orders o where o.productIdx = p.idx and o.orderSw!=0) as orders
		,(select count(*) from boards r,orders o where r.oIdx = o.idx  and o.productIdx = p.idx) as reviews
		 from products p, categorySmall s,categoryLarge l
 			where p.codeLarge=l.codeLarge and p.codeSmall = s.codeSmall <if test="codeLarge!=0"> and p.codeLarge=#{codeLarge} </if> <if test="codeSmall!=0">and p.codeSmall=#{codeSmall}</if>
 			<if test="orderBy==''"> order by p.idx desc limit #{startIndexNo},#{pageSize} </if> 
 			<if test="orderBy!=''"> order by ${orderBy} desc limit #{startIndexNo},#{pageSize} </if>;