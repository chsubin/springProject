package com.spring.green2209S_20.service;

import java.util.List;

import com.spring.green2209S_20.vo.QnaVO;

public interface QnaService {

	public List<QnaVO> getQnaList(String mid,String sw);

	public void setQnaInput(QnaVO vo);

	public List<QnaVO> getQnaAdminList(int startIndexNo, int pageSize);

	public List<QnaVO> getQnaMidList(int startIndexNo, int pageSize);

	public void setAnswerSwUpdate(String questionId);

	public void setQnaAnswerInput(QnaVO vo);

	public void setQnaExit(String questionId);

	public List<QnaVO> getQnaAdminUnConfirmCnt();

	public void setAdminDelete();

	public void setQnaAdminDelete(int idx);

	public void setQnaUpdateAnswer(int idx, String answer);

	public void setQnaUpdateLevel(int idx, int level);

	public List<QnaVO> getFAQList();


}
