
create table refund(
	idx int not null auto_increment primary key,
	oIdx int not null,
	refundReason int not null default 1,
	refundDetail varchar(100) not null,
	refundSw int not null default 0, /*0:환불 신청 상태, 1:환불 승인, 2: 환불 X*/
	minusPoint int not null,
	plusPoint int not null,
	deliveryPrice int not null,
	couponUse int not null,
	totalRefund int not null
);

select o.*,p.name as productName,p.fSName as fSName,d.optionName as optionName  from orders o,products p,DBoption d where o.idx=24 and p.idx=o.productIdx and d.idx= o.optionIdx ;