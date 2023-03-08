package com.spring.green2209S_20.service;

import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.green2209S_20.common.JavawspringProvide;
import com.spring.green2209S_20.dao.BoardDAO;
import com.spring.green2209S_20.vo.BoardVO;
import com.spring.green2209S_20.vo.BoardsReplyVO;
import com.spring.green2209S_20.vo.MemberVO;

@Service
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	BoardDAO boardDAO;

	@Override
	public List<BoardVO> getboardListSw(int startIndexNo, int pageSize, int sw,String part, String search) {
		return boardDAO.getboardListSw(startIndexNo, pageSize,sw,part,search);
	}

	@Override
	public void setBoardInput(BoardVO vo) {
		 boardDAO.setBoardInput(vo);
	}

	@Override
	public BoardVO getBoardContent(int idx,int sw) {
		BoardVO vo = boardDAO.getBoardContent(idx,sw);
		BoardVO prevVo = boardDAO.getBoardPrevNext(idx,sw,"prev");
		BoardVO nextVo = boardDAO.getBoardPrevNext(idx,sw,"next");
		if(prevVo!=null) {
			vo.setPrevIdx(prevVo.getIdx());
			vo.setPrevTitle(prevVo.getTitle());
		}
		if(nextVo!=null) {
			vo.setNextIdx(nextVo.getIdx());
			vo.setNextTitle(nextVo.getTitle());
		}
		
		return vo;
	}

	@Override
	public void setBoardUpdate(BoardVO vo) {
		boardDAO.setBoardUpdate(vo);
	}

	@Override
	public void setBoardReplyInput(BoardsReplyVO vo) {
		boardDAO.setBoardReplyInput(vo);
		boardDAO.setBoardReplyUpdatePidx();
	}

	@Override
	public List<BoardsReplyVO> getReplyList(int idx) {
		return boardDAO.getReplyList(idx);
	}

	@Override
	public void setReviewInput(MultipartHttpServletRequest mFile, BoardVO vo) {
		try {
			String oFileNames="";
			String sFileNames="";
			
			List<MultipartFile> fileList = mFile.getFiles("file"); //앞에서 name을 file로 넘겼다.
			
			for(MultipartFile file:fileList) {
				String oFileName = file.getOriginalFilename();
				if(oFileName.equals(""))break;
				String sFileName = saveFileName(oFileName);
				
				//파일 업로드 메소드 호출
				writeFile(file,sFileName);

				oFileNames+=oFileName+"/";
				sFileNames+=sFileName+"/";
			}
			vo.setFName(oFileNames);
			vo.setFSName(sFileNames);
			vo.setSw(2);
			
			boardDAO.setBoardInput(vo);
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
	//실제로 파일을 서버에 저장한다.
	private void writeFile(MultipartFile file, String sFileName) throws IOException {
		byte [] data = file.getBytes();
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/ckeditor/adboard/");
		
		FileOutputStream fos = new FileOutputStream(realPath+sFileName);
		fos.write(data);
		fos.close();
	}

	//실제 서버에 저장되는 파일명 중복방지를 위한 파일명설정
	private String saveFileName(String oFileName) {
		String fileName ="";
		
		Calendar cal = Calendar.getInstance();
		fileName += cal.get(Calendar.YEAR);
		fileName += cal.get(Calendar.MONTH);
		fileName += cal.get(Calendar.DATE);
		fileName += cal.get(Calendar.HOUR);
		fileName += cal.get(Calendar.MINUTE);
		fileName += cal.get(Calendar.SECOND);
		fileName += cal.get(Calendar.MILLISECOND); //소수이하 한단위로 들어옴
		fileName += "_"+oFileName;
		
		return fileName;	
	}

	@Override
	public void setBoardDelete(int idx) {
		BoardVO origVo = boardDAO.getBoardContent(idx,1);
		if(!origVo.getFSName().equals("")) {
			String [] origFSNames =origVo.getFSName().split("/");
			JavawspringProvide pv=new JavawspringProvide();
			for(String origFSName:origFSNames) {
				pv.deleteFile(origFSName,"data/ckeditor/adboard");
			}
		}
		boardDAO.setBoardDelete(idx);
	}

	@Override
	public String setReviewUpdate(BoardVO vo, MultipartHttpServletRequest mFile,String mid) {
		try {
			BoardVO origVo = boardDAO.getBoardContent(vo.getIdx(),2);
			if (!origVo.getMid().equals(mid))return "0";
			String [] origFSNames =origVo.getFSName().split("/");
			JavawspringProvide pv=new JavawspringProvide();
			for(String origFSName:origFSNames) {
				pv.deleteFile(origFSName,"data/ckeditor/adboard");
			}
			
			String oFileNames="";
			String sFileNames="";
			
			List<MultipartFile> fileList = mFile.getFiles("file"); //앞에서 name을 file로 넘겼다.
			
			for(MultipartFile file:fileList) {
				String oFileName = file.getOriginalFilename();
				if(oFileName.equals(""))break;
				String sFileName = saveFileName(oFileName);
				
				//파일 업로드 메소드 호출
				writeFile(file,sFileName);

				oFileNames+=oFileName+"/";
				sFileNames+=sFileName+"/";
			}
			vo.setFName(oFileNames);
			vo.setFSName(sFileNames);
			vo.setSw(2);
			boardDAO.setBoardUpdate(vo);
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		return"1"; 
	}

	@Override
	public void setBoardReplyDelete(int idx) {
		
		//댓글이 달린것이 있는지 확인하고 지워야함.
		
		BoardsReplyVO vo =  boardDAO.getReply(idx);
		int pidx = vo.getPIdx();
		if(vo.getLevel()==0) {
			List<BoardsReplyVO> vos = boardDAO.getReplyByPidx(pidx);
			if(vos.size()==1) boardDAO.setBoardReplyDelete(idx);
			else boardDAO.setboardDeleteUpdate(idx);
		}
		else boardDAO.setBoardReplyDelete(idx);
	}

	@Override
	public void setReplyUpdate(int idx, String content) {
		boardDAO.setReplyUpdate(idx, content);
	}

	@Override
	public void setBoardViewsUpdate(int idx) {
		boardDAO.setBoardViewsUpdate(idx);
	}

	@Override
	public void setLikeUpdate(int idx, String flag,int buho) {
		boardDAO.setLikeUpdate(idx, flag,buho);
	}

	
	
}
