package com.spring.green2209S_20;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.green2209S_20.pagenation.PageProcess;
import com.spring.green2209S_20.pagenation.PageVO;
import com.spring.green2209S_20.service.BoardService;
import com.spring.green2209S_20.vo.BoardVO;
import com.spring.green2209S_20.vo.BoardsReplyVO;
import com.spring.green2209S_20.vo.MemberVO;

@Controller
@RequestMapping("/board")
public class BoardController {
	
	@Autowired
	BoardService boardService;
	
	@Autowired
	PageProcess pageProcess;
	
	@RequestMapping(value="/boardList",method = RequestMethod.GET)
	public String boardListGet(Model model,
			@RequestParam(name="pag",defaultValue = "1")int pag,
			@RequestParam(name="pageSize",defaultValue = "10")int pageSize
			) {
		PageVO pageVo = pageProcess.totRecCnt(pag, pageSize, "board", 1, 0, "", "");
		List<BoardVO> vos = boardService.getboardListSw(pageVo.getStartIndexNo(),pageSize,1,"","");
		model.addAttribute("pageVo", pageVo);
		model.addAttribute("vos", vos);
		return "board/boardList";
	}
	
	@RequestMapping(value="/boardContent",method = RequestMethod.GET)
	public String boardContentGet(int idx,Model model,HttpSession session) {
		if(session.getAttribute("board"+idx)==null) {
			boardService.setBoardViewsUpdate(idx);
			session.setAttribute("board"+idx,"on");
		}
		BoardVO vo =  boardService.getBoardContent(idx,1);
		List<BoardsReplyVO> replyVos = boardService.getReplyList(idx);
		model.addAttribute("replyVos",replyVos);
		model.addAttribute("vo",vo);
		
		
		return "board/boardContent";
	}
	@ResponseBody
	@RequestMapping(value="/boardReplyInput",method = RequestMethod.POST)
	public String boardReplyInputPost(BoardsReplyVO vo) {
		boardService.setBoardReplyInput(vo);
		
		return "";
	}
	@ResponseBody
	@RequestMapping(value="/boardReplyUpdate",method = RequestMethod.POST)
	public String boardReplyUpdatePost(int idx,String content) {
		boardService.setReplyUpdate(idx,content);
		return "";
	}
	@ResponseBody
	@RequestMapping(value="/boardReplyDelete",method = RequestMethod.POST)
	public String boardReplyDeletePost(int idx) {
		boardService.setBoardReplyDelete(idx);
		return "";
	}
	
	
	
}
