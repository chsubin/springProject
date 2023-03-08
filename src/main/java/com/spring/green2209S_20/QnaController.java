package com.spring.green2209S_20;

import java.util.List;

import javax.mail.Session;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.web.access.RequestMatcherDelegatingWebInvocationPrivilegeEvaluator;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.green2209S_20.service.QnaService;
import com.spring.green2209S_20.service.ServeyService;
import com.spring.green2209S_20.vo.AnswerVO;
import com.spring.green2209S_20.vo.BasicServeyVO;
import com.spring.green2209S_20.vo.QnaVO;
import com.spring.green2209S_20.vo.QuestionVO;
import com.spring.green2209S_20.vo.RealAnswerVO;
import com.spring.green2209S_20.vo.ServeyVO;

@Controller
@RequestMapping("/qna")
public class QnaController {
	@Autowired 
	QnaService qnaService;
	
	@Autowired
	ServeyService serveyService;
	
	
	@RequestMapping(value= "/qnaMain",method = RequestMethod.GET)
	public String qnaMainGet(HttpSession session,Model model) {
		String mid = session.getAttribute("sMid")==null?"":(String)session.getAttribute("sMid");
		List<QnaVO> vos = qnaService.getQnaList(mid,"questionSw");
		model.addAttribute("vos", vos);
		
		List<QnaVO> vos2 =  qnaService.getFAQList();
		model.addAttribute("faqVos", vos2);
		
		
		return "qna/qnaMain";
	}
	@ResponseBody
	@RequestMapping(value= "/qnaInput",method = RequestMethod.POST)
	public String qnaqnaInputPost(QnaVO vo) {
		qnaService.setQnaInput(vo);
		return "qna/qnaInput";
	}
	/*
	 * @RequestMapping(value="/qnaFAQ" ) public String adminQnaFAQGet(Model model) {
	 * List<QnaVO> vos = qnaService.getFAQList(); model.addAttribute("vos", vos);
	 * return "qna/qnaFAQ"; }
	 */
	@RequestMapping(value="/servey",method = RequestMethod.GET)
	public String serveyGet(int idx,Model model) {
		
		ServeyVO vo =  serveyService.getServey(idx);
		model.addAttribute("vo",vo);
		
  	List<QuestionVO> questionVos =  serveyService.getServeyQuestions(idx);
  	model.addAttribute("questionVos", questionVos);
  	
  	List<AnswerVO> answerVos = serveyService.getServeyAnswers(idx,"","");
  	model.addAttribute("answerVos", answerVos);
		
		return "qna/servey";
	}
	
	
	@RequestMapping(value="/basicServey",method = RequestMethod.GET)
	public String basicServeyGet(int idx,Model model) {
		ServeyVO vo =  serveyService.getServey(idx);
		model.addAttribute("vo",vo);
		
		return "qna/basicServey";
	}
	@RequestMapping(value="/basicServey",method = RequestMethod.POST)
	public String basicServeyPost(int idx,BasicServeyVO vo,HttpSession session) {
		session.setAttribute("basicServeyVo", vo);
		return "redirect:/qna/servey?idx="+idx;
	}
	@Transactional
	@RequestMapping(value="/servey",method = RequestMethod.POST)
	public String serveyPost(String answer,HttpServletRequest request,RealAnswerVO vo,HttpServletResponse response,HttpSession session,Model model) {
		String detailAnswer = vo.getDetailAnswer();
		BasicServeyVO  basicServeyVo =  (BasicServeyVO) session.getAttribute("basicServeyVo");
		int bIdx = serveyService.setBasicServeyInput(basicServeyVo);
		List<QuestionVO> qvos = serveyService.getServeyQuestions(vo.getSIdx());
		
		vo.setBIdx(bIdx);
		if(answer!=null) {
			for(String ans:answer.split(",")) {
				
				 vo.setQIdx(Integer.parseInt(ans.split("/")[0])); 
				 vo.setAIdx(Integer.parseInt(ans.split("/")[1])); 
				 vo.setDetailAnswer("");
				 
				 serveyService.setServeyRealAnswerInput(vo);
			}
		}
		for(String datail:detailAnswer.split(",")) {
			 vo.setQIdx(Integer.parseInt(datail.split("/")[0]));
			 vo.setDetailAnswer(datail.split("/")[1]);
			 vo.setAIdx(0);
			 if(vo.getQIdx()==0) continue;
			 serveyService.setServeyRealAnswerInput(vo);
		}
		for(QuestionVO qvo : qvos) {
			if(qvo.getAnswerSw()==2) {
				int radioAnswer = Integer.parseInt(request.getParameter("radioAnswer"+qvo.getIdx()));
				vo.setQIdx(qvo.getIdx());
				vo.setAIdx(radioAnswer);
				vo.setDetailAnswer("");
				serveyService.setServeyRealAnswerInput(vo);
			}
		}
		
		
		
		
		model.addAttribute("idx",vo.getSIdx());
		
		
		return "qna/serveySuccess";
	}
	
}
