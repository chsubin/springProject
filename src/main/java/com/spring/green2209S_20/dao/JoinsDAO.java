package com.spring.green2209S_20.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.green2209S_20.vo.JoinProductVO;
import com.spring.green2209S_20.vo.JoinsRequestVO;
import com.spring.green2209S_20.vo.JoinsVO;

import lombok.experimental.PackagePrivate;

public interface JoinsDAO {

	public void setJoinsInput(@Param("vo") JoinsVO vo);

	public int totRecCnt(@Param("joinSw") int codeLarge,@Param("part") String part ,@Param("search") String search );

	public List<JoinsVO> getJoinsList(@Param("startIndexNo") int startIndexNo,@Param("pageSize") int pageSize,@Param("joinSw") int joinSw,@Param("part") String part ,@Param("search") String search);

	public JoinsVO getJoin(@Param("idx") int idx);

	public void setJoinsUpdate(@Param("vo") JoinsVO vo);

	public void setJoinProduct(@Param("vo") JoinProductVO vo);

	public List<JoinProductVO> getjoinsProductList(@Param("idx") int idx);

	public List<JoinProductVO> getJoinsProductsList();

	public void setJoinsMemoUpdate(@Param("idx") int idx,@Param("content") String content);

	public void setJoinsRequest(@Param("vo") JoinsRequestVO vo);

	public List<JoinsRequestVO> getRequestList(@Param("startIndexNo") int startIndexNo,@Param("pageSize") int pageSize,@Param("startDate") String startDate,@Param("lastDate") String lastDate,@Param("part") String part,@Param("search") String search);

	public void setJoinProductUpdate(@Param("vo") JoinProductVO vo);

	public void setJoinProductDelete(@Param("idx") int idx);

	public String totRequestCnt(@Param("startDate") String startDate,@Param("lastDate") String lastDate,@Param("part") String part,@Param("search") String search);

	public void setJoinSwUpdate(@Param("idx") int idx,@Param("joinSw") int joinSw);

}
