

create table coupons(
	idx int not null auto_increment primary key,
	code varchar(100) not null, /*코드 식별자 */
	name varchar(50) not null,
	fSName varchar(100) not null,
	price int not null,
	useSw varchar(2) not null,
	startDate datetime default now(),
	lastDate datetime default now(),
	useDate datetime 
);

drop table coupons;

select idx from coupons order by idx desc limit 1;

select * from orderSub where oIdx ='g1676270688501';


select o.*,c.price as couponPrice from orderSub o,coupons c where oIdx='g1676271250682'  and (o.couponIdx = c.idx or o.couponIdx=0);

select r.* from joinRequest r,joinsapply a where ;

select r.*,p.productName as productName from joinrequest r,joins j,joinproduct p where p.idx = r.productIdx and p.joinsIdx = j.idx;
select * from joins;