package com.spring.green2209S_20.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.green2209S_20.vo.AnswerVO;
import com.spring.green2209S_20.vo.BasicServeyVO;
import com.spring.green2209S_20.vo.QuestionVO;
import com.spring.green2209S_20.vo.RealAnswerVO;
import com.spring.green2209S_20.vo.ServeyVO;

public interface ServeyDAO {

	public List<ServeyVO> getServeys(@Param("showSw") int serveySw);

	public ServeyVO getServey(@Param("idx") int idx);

	public List<QuestionVO> getServeyQuestions(@Param("sIdx") int idx);

	public List<AnswerVO> getServeyAnswers(@Param("sIdx") int idx,@Param("part") String part,@Param("smallPart") String smallPart);

	public void setServeyInput(@Param("vo") ServeyVO vo);

	public int getLastIdx();

	public void setServeyQuesionInput(@Param("vo") QuestionVO vo);

	public void setServeyAnswerInput(@Param("vo") AnswerVO vo);

	public void setServeyAnswerDelete(@Param("idx") int idx);

	public void setServeyQuestionDelete(@Param("idx") int idx);

	public void setServeyQuestionUpdate(@Param("vo") QuestionVO vo);

	public void setBasicServeyInput(@Param("vo") BasicServeyVO vo);

	public void setServeyRealAnswerInput(@Param("vo") RealAnswerVO vo);

	public int getLastBasicIdx();

	public List<RealAnswerVO> getRealAnswer(@Param("idx") int idx,@Param("part") String part,@Param("smallPart") String smallPart);

	public List<String> getRealAnswerSmallPart(@Param("idx") int idx,@Param("part") String part);

	public void setServeySwAutoUpdate();

	public void setServeyUpdate(@Param("vo") ServeyVO vo);


	

	
	
	
}
