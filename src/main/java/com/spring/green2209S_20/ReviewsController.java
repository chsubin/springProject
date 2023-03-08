package com.spring.green2209S_20;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.mail.Session;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.type.BigIntegerTypeHandler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.green2209S_20.pagenation.PageProcess;
import com.spring.green2209S_20.pagenation.PageVO;
import com.spring.green2209S_20.service.BoardService;
import com.spring.green2209S_20.service.OrdersService;
import com.spring.green2209S_20.vo.BoardVO;
import com.spring.green2209S_20.vo.BoardsReplyVO;
import com.spring.green2209S_20.vo.MemberVO;
import com.spring.green2209S_20.vo.OrdersVO;

@Controller
@RequestMapping("/reviews")
public class ReviewsController {

	@Autowired
	BoardService boardService;
	
	@Autowired
	OrdersService ordersService;
	
	@Autowired
	PageProcess pageProcess;
	
	@RequestMapping(value="/reviewsInput",method =RequestMethod.GET)
	public String reviewsInputGet(int idx,Model model) {
		OrdersVO vo = ordersService.getOrder(idx);
		model.addAttribute("vo", vo);
		return "reviews/reviewsInput";
	}
	@RequestMapping(value="/reviewsInput",method =RequestMethod.POST)
	public String reviewsInputPost(BoardVO vo,MultipartHttpServletRequest file) {
		boardService.setReviewInput(file,vo);
		return "redirect:/msg/reviewInputOk";
	}
	@RequestMapping(value="/reviewsList",method =RequestMethod.GET)
	public String reviewsListGet(Model model,
			@RequestParam(name ="pag",defaultValue = "1",required = false) int pag,
			@RequestParam(name ="pageSize",defaultValue = "12",required = false) int pageSize,
			@RequestParam(name ="part",defaultValue = "",required = false) String part,
			@RequestParam(name ="search",defaultValue = "",required = false) String search
			) {
		PageVO pageVo = pageProcess.totRecCnt(pag, pageSize, "board", 2, 0, part, search);
		List<BoardVO> vos = boardService.getboardListSw(pageVo.getStartIndexNo(),pageSize,2,part,search);
		model.addAttribute("pageVo", pageVo);
		model.addAttribute("vos", vos);
		model.addAttribute("part", part);
		model.addAttribute("search", search);
		
		return "reviews/reviewsList";
	}
	@RequestMapping(value="/reviewsContent",method =RequestMethod.GET)
	public String reviewsContentGet(Model model,int idx,HttpSession session) {
		if(session.getAttribute("board"+idx)==null) {
			boardService.setBoardViewsUpdate(idx);
			session.setAttribute("board"+idx,"on");
		}
		if(session.getAttribute("good"+idx)!=null) {
			model.addAttribute("likes", session.getAttribute("good"+idx));
		}
		BoardVO vo = boardService.getBoardContent(idx,2);
		List<BoardsReplyVO> vos =  boardService.getReplyList(idx);
		model.addAttribute("vo", vo);
		model.addAttribute("replyVos", vos);
		String [] fNames = vo.getFName().split("/");
		String [] fSNames = vo.getFSName().split("/");
		model.addAttribute("fNames", fNames);
		model.addAttribute("fSNames", fSNames);
		
		
		return "reviews/reviewsContent";
	}
	@RequestMapping(value = "/reviewsTotalDown", method = RequestMethod.GET)
	public String pdsTotalDownGet(HttpServletRequest request, int idx) throws IOException {
		
		// 여러개의 파일일 경우 모든 파일을 하나의 파일로 압축(?=통합)하여 다운한다. 이때 압축파일명은 '제목'으로 처리한다.
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/ckeditor/adboard/");
		
		BoardVO vo = boardService.getBoardContent(idx,2);
		
		String[] fNames = vo.getFName().split("/");
		String[] fSNames = vo.getFSName().split("/");
		
		String zipPath = realPath + "temp/";
		String zipName = vo.getTitle() + ".zip";
		
		FileInputStream fis = null;
		FileOutputStream fos = null;
		
		ZipOutputStream zout = new ZipOutputStream(new FileOutputStream(zipPath + zipName));
		
		byte[] buffer = new byte[2048];
		
		for(int i=0; i<fSNames.length; i++) {
			fis = new FileInputStream(realPath + fSNames[i]);
			fos = new FileOutputStream(zipPath + fNames[i]);
			File moveAndRename = new File(zipPath + fNames[i]);
			
			// fos에 파을 쓰기작업
			int data;
			while((data = fis.read(buffer, 0, buffer.length)) != -1) {
				fos.write(buffer, 0, data);
			}
			fos.flush();
			fos.close();
			fis.close();
			
			// zip파일에 fos를 넣는 작업
			fis = new FileInputStream(moveAndRename);
			zout.putNextEntry(new ZipEntry(fNames[i]));
			
			while((data = fis.read(buffer, 0, buffer.length)) != -1) {
				zout.write(buffer, 0, data);
			}
			zout.flush();
			zout.closeEntry();
			fis.close();
		}
		zout.close();
		
		return "redirect:/reviews/reviewsDownAction?file="+java.net.URLEncoder.encode(zipName);
	}
	@RequestMapping(value = "/reviewsDownAction", method = RequestMethod.GET)
	public void pdsDownActionGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String file = request.getParameter("file");
		
		String downPathFile = request.getSession().getServletContext().getRealPath("/resources/data/ckeditor/adboard/temp/") + file;
		
		File downFile = new File(downPathFile);

		String downFileName = new String(file.getBytes("UTF-8"), "8859_1");
		
		response.setHeader("Content-Disposition", "attachment;filename="+downFileName);
		
		FileInputStream fis = new FileInputStream(downFile);
		ServletOutputStream sos = response.getOutputStream();
		
		byte[] buffer = new byte[2048];
		int data = 0;
		while((data = fis.read(buffer, 0, buffer.length)) != -1) {
			sos.write(buffer, 0, data);
		}
		sos.flush();
		sos.close();
		fis.close();
		
		// 다운로드 완료후 temp폴더의 파일들을 모두 삭제한다.
//		new File(downPathFile).delete();
		downFile.delete();
	}
	@RequestMapping(value="/reviewsUpdate",method =  RequestMethod.GET)
	public String reviewsUpdateGet(Model model,int idx) {
		BoardVO vo =  boardService.getBoardContent(idx, 2);
		model.addAttribute("vo",vo);
		return "reviews/reviewsUpdate";
	}
	//수정
	@RequestMapping(value="/reviewsUpdate",method =  RequestMethod.POST)
	public String reviewsUpdatePost(BoardVO vo,MultipartHttpServletRequest file,HttpSession session) {
		String mid = session.getAttribute("sMid")==null?"":(String)session.getAttribute("sMid");
		String res= boardService.setReviewUpdate(vo,file,mid);
		if(res.equals("1")) return "redirect:/msg/reviewUpdateOK?flag="+vo.getIdx();
		return "redirect:/msg/reviewUpdateNO?flag="+vo.getIdx();
	}
	//삭제
	@RequestMapping(value="/reviewsDelete",method =  RequestMethod.GET)
	public String reviewsDeletePost(int idx,HttpSession session) {
		String mid = session.getAttribute("sMid")==null?"":(String)session.getAttribute("sMid");
		int level = session.getAttribute("sLevel")==null?99:  Integer.parseInt(String.valueOf(session.getAttribute("sLevel")));
		BoardVO origVo =  boardService.getBoardContent(idx, 1);
		List<BoardsReplyVO> replyVos = boardService.getReplyList(idx);
		if(replyVos.size()>0) {return "redirect:/msg/reviewsReplyExist?flag="+idx;}
		if(!mid.equals(origVo.getMid())&&level>=2) return "redirect:/msg/reviewUpdateNO?flag="+idx;
		if(origVo.getReplyCount()>0) {
			return "redirect:/msg/reviewDeleteNO?flag="+idx;
		}
		else{boardService.setBoardDelete(idx);}
		return "redirect:/msg/reviewDeleteOK";
	}
	@ResponseBody
	@RequestMapping(value="/updateLike",method = RequestMethod.POST)
	public String updateLikePost(int idx,String flag,HttpSession session) {
		String good = session.getAttribute("good"+idx)==null?"":(String)session.getAttribute("good"+idx);
		if(good.equals(flag)) {
			session.removeAttribute("good"+idx);
			boardService.setLikeUpdate(idx,flag,-1);
		}
		else if(good.equals("")) {
			boardService.setLikeUpdate(idx,flag,+1);
			session.setAttribute("good"+idx, flag);
		}
		else {
			return "0";
		}
		return "1";
	}
	
}
