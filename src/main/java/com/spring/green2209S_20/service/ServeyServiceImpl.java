package com.spring.green2209S_20.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.green2209S_20.dao.ServeyDAO;
import com.spring.green2209S_20.vo.AnswerVO;
import com.spring.green2209S_20.vo.BasicServeyVO;
import com.spring.green2209S_20.vo.QuestionVO;
import com.spring.green2209S_20.vo.RealAnswerVO;
import com.spring.green2209S_20.vo.ServeyVO;

@Service
public class ServeyServiceImpl implements ServeyService {

	
	@Autowired
	ServeyDAO serveyDAO;

	@Override
	public List<ServeyVO> getServeys(int serveySw) {
		return serveyDAO.getServeys(serveySw);
	}

	@Override
	public ServeyVO getServey(int idx) {
		return serveyDAO.getServey(idx);
	}

	@Override
	public List<QuestionVO> getServeyQuestions(int idx) {
		return serveyDAO.getServeyQuestions(idx);
	}

	@Override
	public List<AnswerVO> getServeyAnswers(int idx,String part, String smallPart) {
		return serveyDAO.getServeyAnswers(idx,part,smallPart);
	}

	@Override
	public void setServeyInput(ServeyVO vo) {
		serveyDAO.setServeyInput(vo);
	}

	@Override
	public int getLastIdx() {
		return serveyDAO.getLastIdx();
	}

	@Override
	public void setServeyQuesionInput(QuestionVO vo) {
		serveyDAO.setServeyQuesionInput(vo);
	}

	@Override
	public void setServeyAnswerInput(AnswerVO vo) {
		serveyDAO.setServeyAnswerInput(vo);
	}

	@Override
	public void setServeyAnswerDelete(int idx) {
		serveyDAO.setServeyAnswerDelete(idx);
	}

	@Override
	public void setServeyQuestionDelete(int idx) {
		serveyDAO.setServeyQuestionDelete(idx);
	}

	@Override
	public void setServeyQuestionUpdate(QuestionVO vo) {
		serveyDAO.setServeyQuestionUpdate(vo);
	}

	@Override
	public int setBasicServeyInput(BasicServeyVO vo) {
		serveyDAO.setBasicServeyInput(vo);
		int idx = serveyDAO.getLastBasicIdx();
		return idx;
	}

	@Override
	public void setServeyRealAnswerInput(RealAnswerVO vo) {
		serveyDAO.setServeyRealAnswerInput(vo);
	}

	@Override
	public List<RealAnswerVO> getRealAnswer(int idx,String part, String smallPart) {
		return serveyDAO.getRealAnswer(idx,part,smallPart);
	}

	@Override
	public List<String> getRealAnswerSmallPart(int idx, String part) {
		return serveyDAO.getRealAnswerSmallPart(idx, part);
	}

	@Override
	public void setServeySwAutoUpdate() {
		serveyDAO.setServeySwAutoUpdate();
	}

	@Override
	public void setServeyUpdate(ServeyVO vo) {
		serveyDAO.setServeyUpdate(vo);
	}

}
