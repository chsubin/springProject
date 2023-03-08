package com.spring.green2209S_20.service;

import java.util.List;

import com.spring.green2209S_20.vo.AnswerVO;
import com.spring.green2209S_20.vo.BasicServeyVO;
import com.spring.green2209S_20.vo.QuestionVO;
import com.spring.green2209S_20.vo.RealAnswerVO;
import com.spring.green2209S_20.vo.ServeyVO;

public interface ServeyService {

	public List<ServeyVO> getServeys(int serveySw);

	public ServeyVO getServey(int idx);

	public List<QuestionVO> getServeyQuestions(int idx);

	public List<AnswerVO> getServeyAnswers(int idx,String part, String smallPart);

	public void setServeyInput(ServeyVO vo);

	public int getLastIdx();

	public void setServeyQuesionInput(QuestionVO vo);

	public void setServeyAnswerInput(AnswerVO vo);

	public void setServeyAnswerDelete(int idx);

	public void setServeyQuestionDelete(int idx);

	public void setServeyQuestionUpdate(QuestionVO vo);

	public int setBasicServeyInput(BasicServeyVO vo);

	public void setServeyRealAnswerInput(RealAnswerVO vo);

	public List<RealAnswerVO> getRealAnswer(int idx, String part, String smallPart);

	public List<String> getRealAnswerSmallPart(int idx, String part);

	public void setServeySwAutoUpdate();

	public void setServeyUpdate(ServeyVO vo);



	
	
}
