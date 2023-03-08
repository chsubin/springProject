package com.spring.green2209S_20.service;

import java.util.List;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.green2209S_20.vo.BoardVO;
import com.spring.green2209S_20.vo.BoardsReplyVO;
import com.spring.green2209S_20.vo.MemberVO;

public interface BoardService {

	public List<BoardVO> getboardListSw(int startIndexNo, int pageSize, int sw,String part,String search);

	public void setBoardInput(BoardVO vo);

	public BoardVO getBoardContent(int idx,int sw);

	public void setBoardUpdate(BoardVO vo);

	public void setBoardReplyInput(BoardsReplyVO vo);

	public List<BoardsReplyVO> getReplyList(int idx);

	public void setReviewInput(MultipartHttpServletRequest file, BoardVO vo);

	public void setBoardDelete(int idx);

	public String setReviewUpdate(BoardVO vo, MultipartHttpServletRequest file,String mid);

	public void setBoardReplyDelete(int idx);

	public void setReplyUpdate(int idx, String content);

	public void setBoardViewsUpdate(int idx);

	public void setLikeUpdate(int idx, String flag,int buho);


}
