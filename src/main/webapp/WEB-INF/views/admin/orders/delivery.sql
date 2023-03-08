
create table subscribe(
	idx int not null auto_increment primary key,
	oIdx int not null,
	content varchar(50) not null,
	address varchar(100) not null,
	dDate varchar(12) not null,
 	foreign key(oIdx) references orders(idx) on delete restrict
);
drop table subscribe;

		select o.*,p.name as productName,p.fSName as fSName,d.optionName as optionName ,(select dDate from subscribe where o.idx=oIdx and dDate<20220101 order by idx  desc limit 1) as dDate
		 from orders o,products p,DBoption d where p.idx=o.productIdx and d.idx= o.optionIdx and subSw!='' and o.idx in (select oIdx from subscribe where o.idx=oIdx and dDate<20220101)
		  order by idx desc;
		  
		  select count(*)
		 from orders o,products p,DBoption d where p.idx=o.productIdx and d.idx= o.optionIdx and subSw!='' and o.idx in (select oIdx from subscribe where o.idx=oIdx );

		 
create table orderSub(
	idx int not null auto_increment primary key,
	oIdx varchar(50) not null,
	deliveryPrice int not null default 0,
	point int not null default 0,
	couponIdx int not null default 0,
	totalPrice int not null
);

drop table orderSub;

select * from refund;