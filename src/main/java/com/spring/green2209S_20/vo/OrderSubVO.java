package com.spring.green2209S_20.vo;

import lombok.Data;

@Data
public class OrderSubVO {

	private int idx;
	private String oIdx;
	private int deliveryPrice;
	private int point;
	private int couponIdx;
	private int totalPrice;
	private String couponPrice;
	private int refundCoupon;
}
