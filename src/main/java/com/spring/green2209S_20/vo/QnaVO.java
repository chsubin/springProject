package com.spring.green2209S_20.vo;

import lombok.Data;

@Data
public class QnaVO {
	private int idx;
	private String part;
	private String question;
	private String questionId;
	private String questionSw;
	private String questionDate;
	private String answer;
	private String answerSw;
	private String answerDate;
	private int level;
	
	private String aSw;
	private String aDate;
	private String qDate;
}
