package com.spring.green2209S_20.pagenation;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.green2209S_20.dao.AdminDAO;
import com.spring.green2209S_20.dao.BoardDAO;
import com.spring.green2209S_20.dao.CouponsDAO;
import com.spring.green2209S_20.dao.JoinsDAO;
import com.spring.green2209S_20.dao.MemberDAO;
import com.spring.green2209S_20.dao.OrdersDAO;
import com.spring.green2209S_20.dao.QnaDAO;
import com.spring.green2209S_20.dao.RefundDAO;
import com.spring.green2209S_20.service.AdminService;
import com.spring.green2209S_20.service.JoinsService;

@Service
public class PageProcess {

	@Autowired
	OrdersDAO ordersDAO;
	
	@Autowired
	MemberDAO memberDAO;
	
	@Autowired
	AdminDAO adminDAO;
	
	@Autowired
	BoardDAO boardDAO;
	
	@Autowired
	QnaDAO qnaDAO;
	
	@Autowired
	JoinsDAO joinsDAO;
	@Autowired
	CouponsDAO couponsDAO;
	
	@Autowired
	RefundDAO refundDAO;
	
	public PageVO totRecCnt(int pag, int pageSize, String section,int codeLarge,int codeSmall, String part, String search) {
		PageVO pageVO= new PageVO();
		int totRecCnt=0;
		
		if(section.equals("product")) {
			totRecCnt = ordersDAO.totRecCnt(codeLarge,codeSmall)==null?0:Integer.parseInt(ordersDAO.totRecCnt(codeLarge,codeSmall));
		}		
		else if(section.equals("member")) {
			totRecCnt =memberDAO.totRecCnt(codeLarge,part,search);
		}		
		else if(section.equals("board")) {
			totRecCnt =boardDAO.totRecCnt(codeLarge,part,search);
		}		
		else if(section.equals("orders")) {
				totRecCnt = ordersDAO.totRecOrdersCnt(codeLarge,codeSmall,part,search);
		}		
		else if(section.equals("subscribe")) {
			if(codeLarge==1) totRecCnt = ordersDAO.totRecSubCnt("OK",codeSmall,part,search);
			else if(codeLarge==-1) totRecCnt = ordersDAO.totRecSubCnt("NO",codeSmall,part,search);
			else totRecCnt = ordersDAO.totRecSubCnt("",codeSmall,part,search);
		}
		else if(section.equals("qna")) {
			totRecCnt = qnaDAO.totRecCnt();
		}		
		else if(section.equals("joins")) {
			totRecCnt = joinsDAO.totRecCnt(codeLarge,part,search);
		}		
		else if(section.equals("coupons")) {
			totRecCnt =couponsDAO.totRecCnt();
		}		
		else if(section.equals("refund")) {
			totRecCnt = refundDAO.totRecCnt(part,search)==null?0:Integer.parseInt(refundDAO.totRecCnt(part,search));
		}
		
		
		int totPage = (totRecCnt % pageSize)==0 ? totRecCnt / pageSize : (totRecCnt / pageSize) + 1;
		int startIndexNo = (pag - 1) * pageSize;
		int curScrStartNo = totRecCnt - startIndexNo;
		
		int blockSize = 3;
		int curBlock = (pag - 1) / blockSize;
		int lastBlock = (totPage - 1) / blockSize;
		
		pageVO.setPag(pag);
		pageVO.setPageSize(pageSize);
		pageVO.setTotRecCnt(totRecCnt);
		pageVO.setTotPage(totPage);
		pageVO.setStartIndexNo(startIndexNo);
		pageVO.setCurScrStartNo(curScrStartNo);
		pageVO.setBlockSize(blockSize);
		pageVO.setCurBlock(curBlock);
		pageVO.setLastBlock(lastBlock);
		
		
		return pageVO;
	}
	//검색기 사용
	public PageVO totRecCnt(int pag, int pageSize, String section,int codeLarge,int codeSmall,String startDate,String lastDate, String part, String search) {
		PageVO pageVO= new PageVO();
		int totRecCnt=0;
		
		if(section.equals("adminOrders")) {
			totRecCnt = adminDAO.totRecOrdersCnt(codeLarge,codeSmall,startDate,lastDate,part,search);
		}		
		else if(section.equals("refund")) {
			totRecCnt =  refundDAO.totRecAdminCnt(codeLarge,codeSmall,startDate,lastDate,part,search)==null?0: Integer.parseInt(refundDAO.totRecAdminCnt(codeLarge,codeSmall,startDate,lastDate,part,search));
			//refundSw, X , 
		}		
		else if(section.equals("request")) {
			totRecCnt =  joinsDAO.totRequestCnt(startDate,lastDate,part,search)==null?0: Integer.parseInt(joinsDAO.totRequestCnt(startDate,lastDate,part,search));
			//refundSw, X , 
		}		
		
		int totPage = (totRecCnt % pageSize)==0 ? totRecCnt / pageSize : (totRecCnt / pageSize) + 1;
		int startIndexNo = (pag - 1) * pageSize;
		int curScrStartNo = totRecCnt - startIndexNo;
		
		int blockSize = 3;
		int curBlock = (pag - 1) / blockSize;
		int lastBlock = (totPage - 1) / blockSize;
		
		pageVO.setPag(pag);
		pageVO.setPageSize(pageSize);
		pageVO.setTotRecCnt(totRecCnt);
		pageVO.setTotPage(totPage);
		pageVO.setStartIndexNo(startIndexNo);
		pageVO.setCurScrStartNo(curScrStartNo);
		pageVO.setBlockSize(blockSize);
		pageVO.setCurBlock(curBlock);
		pageVO.setLastBlock(lastBlock);
		
		
		return pageVO;
	}
	//검색기 사용
	public PageVO totRecCnt(int pag, int pageSize, String section,int codeLarge,int codeSmall,String startDate,String lastDate, String part, String search,String sStartDate,String sLastDate) {
		PageVO pageVO= new PageVO();
		int totRecCnt=0;
		
		if(section.equals("adminSubscribe")) {
			if(codeLarge==1) totRecCnt = adminDAO.totRecSubCnt("OK",codeSmall,startDate,lastDate,part,search,sStartDate,sLastDate);
			else if(codeLarge==0) totRecCnt = adminDAO.totRecSubCnt("",codeSmall,startDate,lastDate,part,search,sStartDate,sLastDate);
			else if(codeLarge==-1) totRecCnt = adminDAO.totRecSubCnt("NO",codeSmall,startDate,lastDate,part,search,sStartDate,sLastDate);
		}		
		
		
		int totPage = (totRecCnt % pageSize)==0 ? totRecCnt / pageSize : (totRecCnt / pageSize) + 1;
		int startIndexNo = (pag - 1) * pageSize;
		int curScrStartNo = totRecCnt - startIndexNo;
		
		int blockSize = 3;
		int curBlock = (pag - 1) / blockSize;
		int lastBlock = (totPage - 1) / blockSize;
		
		pageVO.setPag(pag);
		pageVO.setPageSize(pageSize);
		pageVO.setTotRecCnt(totRecCnt);
		pageVO.setTotPage(totPage);
		pageVO.setStartIndexNo(startIndexNo);
		pageVO.setCurScrStartNo(curScrStartNo);
		pageVO.setBlockSize(blockSize);
		pageVO.setCurBlock(curBlock);
		pageVO.setLastBlock(lastBlock);
		
		
		return pageVO;
	}
}
