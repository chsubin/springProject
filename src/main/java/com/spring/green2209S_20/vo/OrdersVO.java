package com.spring.green2209S_20.vo;

import lombok.Data;

@Data
public class OrdersVO {

	private int idx;
	private String orderIdx;
	private String mid;
	private String name;
	private String email;
	private String address;
	private String tel;
	private int productIdx;
	private int optionIdx;
	private int optionNum;
	private String optionDetail;
	private int totalPrice;
	private int orderSw;
	private String orderDate;
	private String subSw;
	
	private String productName;
	private String optionName;
	private String fSName;
	private String dDate;
}
