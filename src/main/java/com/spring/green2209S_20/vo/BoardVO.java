package com.spring.green2209S_20.vo;

import lombok.Data;

@Data
public class BoardVO {
	private int idx;
	private String mid;
	private String title;
	private String content;
	private String wDate;
	private int sw;
	private int oIdx;
	private String fName;
	private String fSName;
	private int views;
	private int likes;
	private int dislike;
	
	private String day_diff;
	private String hour_diff;
	private int replyCount;
	private int prevIdx;
	private String prevTitle;
	private int nextIdx;
	
	private String nextTitle;
	private String productName;
	private String productfSName;
	private String optionName;
}
