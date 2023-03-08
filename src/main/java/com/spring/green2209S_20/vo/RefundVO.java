package com.spring.green2209S_20.vo;

import lombok.Data;

@Data
public class RefundVO {
	
	private int idx;
	private String code;
	private String orderIdx;
	private String oIdxs;
	private int refundReason;
	private String refundDetail;
	private String mid;
	private int refundSw;
	private String rDate;
	private int minusPoint; 
	private int plusPoint;
	private int deliveryPrice ;
	private int couponUse;
	private int totalRefund;
	
	private String oDate; //주문날짜
	private int orderSw; //주문날짜
}
