package com.spring.green2209S_20.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.green2209S_20.vo.QnaVO;

public interface QnaDAO {

	public List<QnaVO> getQnaList(@Param("mid") String mid,@Param("sw") String sw);

	public void setQnaInput(@Param("vo") QnaVO vo);

	public int totRecCnt();

	public List<QnaVO> getQnaAdminList(@Param("startIndexNo") int startIndexNo,@Param("pageSize") int pageSize);

	public List<QnaVO> getQnaMidList(@Param("startIndexNo") int startIndexNo,@Param("pageSize") int pageSize);

	public void setAnswerSwUpdate(@Param("questionId") String questionId);

	public void setQnaAnswerInput(@Param("vo") QnaVO vo);

	public void setQnaExit(@Param("questionId") String questionId);

	public List<QnaVO> getQnaAdminUnConfirmCnt();

	public void setAdminDelete();

	public void setQnaAdminDelete(@Param("idx") int idx);

	public void setQnaUpdateAnswer(@Param("idx") int idx,@Param("answer") String answer);

	public void setQnaUpdateLevel(@Param("idx") int idx,@Param("level") int level);

	public List<QnaVO> getFAQList();

}
