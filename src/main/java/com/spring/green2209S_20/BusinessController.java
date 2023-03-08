package com.spring.green2209S_20;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.mysql.fabric.xmlrpc.base.Member;
import com.spring.green2209S_20.pagenation.PageProcess;
import com.spring.green2209S_20.pagenation.PageVO;
import com.spring.green2209S_20.service.JoinsService;
import com.spring.green2209S_20.service.MemberService;
import com.spring.green2209S_20.vo.JoinsVO;
import com.spring.green2209S_20.vo.MemberVO;

@Controller
@RequestMapping("/business")
public class BusinessController {
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	JoinsService joinsService;
	
	@Autowired
	PageProcess pageProcess;
	
	@RequestMapping(value ="/businessMain",method = RequestMethod.GET)
	public String businessMainGet(HttpSession session,Model model,
			@RequestParam(name="pag",defaultValue = "1") int pag,
			@RequestParam(name="pageSize",defaultValue = "10") int pageSize
			) {
		String mid = session.getAttribute("sMid")==null?"":(String)session.getAttribute("sMid");
	 	MemberVO vo =  memberService.memberLoginCheck(mid);
	 	model.addAttribute("vo", vo);
	 	
	 	PageVO pageVO= pageProcess.totRecCnt(pag, pageSize, "joins", 1, 0, "", "");
		List<JoinsVO> vos = joinsService.getJoinsList(pageVO.getStartIndexNo(), pageSize, 1,"","");
		model.addAttribute("joinVos", vos);
		model.addAttribute("joinNum", vos.size());
		
		return "business/businessMain";
	}
	@RequestMapping(value ="/businessMain",method = RequestMethod.POST)
	public String businessMainPost(JoinsVO vo) {
		joinsService.setJoinsInput(vo);
		return "redirect:/msg/businessOK";
	}
	
}
