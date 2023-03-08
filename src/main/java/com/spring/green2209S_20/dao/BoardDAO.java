package com.spring.green2209S_20.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.beust.jcommander.Parameter;
import com.spring.green2209S_20.vo.BoardVO;
import com.spring.green2209S_20.vo.BoardsReplyVO;
import com.spring.green2209S_20.vo.MemberVO;

public interface BoardDAO {

	public int totRecCnt(@Param("sw") int sw,@Param("part")String part,@Param("search")String search);

	public List<BoardVO> getboardListSw(@Param("startIndexNo") int startIndexNo, @Param("pageSize")int pageSize, @Param("sw")int sw,@Param("part")String part,@Param("search")String search);

	public void setBoardInput(@Param("vo") BoardVO vo);

	public BoardVO getBoardContent(@Param("idx") int idx);

	public BoardVO getBoardPrevNext(@Param("idx") int idx,@Param("sw1") int sw1, @Param("sw") String sw);

	public void setBoardUpdate(@Param("vo") BoardVO vo);

	public void setBoardReplyInput(@Param("vo") BoardsReplyVO vo);

	public void setBoardReplyUpdatePidx();

	public List<BoardsReplyVO> getReplyList(@Param("idx") int idx);

	public BoardVO getBoardContent(@Param("idx") int idx,@Param("sw") int sw);

	public void setBoardDelete(@Param("idx") int idx);

	public void setBoardReplyDelete(@Param("idx") int idx);
	
	public void setReplyUpdate(@Param("idx") int idx,@Param("content") String content);

	public BoardsReplyVO getReply(@Param("idx") int idx);

	public List<BoardsReplyVO> getReplyByPidx(@Param("pidx") int pidx);

	public void setboardDeleteUpdate(@Param("idx") int idx);

	public void setBoardViewsUpdate(@Param("idx") int idx);

	public void setLikeUpdate(@Param("idx") int idx,@Param("flag") String flag,@Param("buho")int buho);




}