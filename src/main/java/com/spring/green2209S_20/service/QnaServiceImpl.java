package com.spring.green2209S_20.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.green2209S_20.dao.QnaDAO;
import com.spring.green2209S_20.vo.QnaVO;


@Service
public class QnaServiceImpl implements QnaService {

	@Autowired
	QnaDAO qnaDAO;

	@Override
	public List<QnaVO> getQnaList(String mid,String sw) {
		return qnaDAO.getQnaList(mid,sw);
	}

	@Override
	public void setQnaInput(QnaVO vo) {
		qnaDAO.setQnaInput(vo);
	}

	@Override
	public List<QnaVO> getQnaAdminList(int startIndexNo, int pageSize) {
		return qnaDAO.getQnaAdminList(startIndexNo, pageSize);
	}

	@Override
	public List<QnaVO> getQnaMidList(int startIndexNo, int pageSize) {
		return qnaDAO.getQnaMidList(startIndexNo, pageSize);
	}

	@Override
	public void setAnswerSwUpdate(String questionId) {
		qnaDAO.setAnswerSwUpdate(questionId);
	}

	@Override
	public void setQnaAnswerInput(QnaVO vo) {
		qnaDAO.setQnaAnswerInput(vo);
	}

	@Override
	public void setQnaExit(String questionId) {
		qnaDAO.setQnaExit(questionId);
	}

	@Override
	public List<QnaVO> getQnaAdminUnConfirmCnt() {
		return qnaDAO.getQnaAdminUnConfirmCnt();
	}

	@Override
	public void setAdminDelete() {
		qnaDAO.setAdminDelete();
	}

	@Override
	public void setQnaAdminDelete(int idx) {
		qnaDAO.setQnaAdminDelete(idx);
	}

	@Override
	public void setQnaUpdateAnswer(int idx, String answer) {
		qnaDAO.setQnaUpdateAnswer(idx, answer);
	}

	@Override
	public void setQnaUpdateLevel(int idx, int level) {
		qnaDAO.setQnaUpdateLevel(idx, level);
	}

	@Override
	public List<QnaVO> getFAQList() {
		return qnaDAO.getFAQList();
	}


	
	
}
