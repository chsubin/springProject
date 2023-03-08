package com.spring.green2209S_20.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.spring.green2209S_20.common.JavawspringProvide;
import com.spring.green2209S_20.dao.AdminDAO;
import com.spring.green2209S_20.dao.OrdersDAO;
import com.spring.green2209S_20.vo.BasisVO;
import com.spring.green2209S_20.vo.BoardVO;
import com.spring.green2209S_20.vo.CategoryLargeVO;
import com.spring.green2209S_20.vo.CategorySmallVO;
import com.spring.green2209S_20.vo.DBoptionVO;
import com.spring.green2209S_20.vo.OrdersVO;
import com.spring.green2209S_20.vo.ProductVO;

@Service
public class AdminServiceImpl implements AdminService {
	@Autowired
	AdminDAO adminDAO;
	@Autowired
	OrdersDAO ordersDAO;

	@Override
	public List<CategoryLargeVO> getLargeCategoryList() {
		return adminDAO.getLargeCategoryList();
	}

	@Override
	public List<CategorySmallVO> getSmallCategoryList() {
		return adminDAO.getSmallCategoryList();
	}

	@Override
	public void setCategoryInput(CategorySmallVO vo) {
		adminDAO.setCategoryInput(vo);
	}

	@Override
	public CategoryLargeVO getSubDetail(int i) {
		return adminDAO.getSubDetail(i);
	}

	@Override
	public void imgCheckUpdate(String folder,String content) {
		//      0         1         2         3         4         5         6
		//      01234567890123456789012345678901234567890123456789012345678901234567890
		// <img src="/green2209S_20/data/ckeditor/sdetail/230111121324_green2209J_06.jpg" style="height:967px; width:1337px" /></p>
// content안에 그림파일이 존재할때만 작업을 수행 할수 있도록 한다.(src="/_____~~)
		if(content.indexOf("src=\"/") == -1) return;
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String uploadPath ="";
		if (folder.equals("sdetail")) uploadPath= request.getSession().getServletContext().getRealPath("/resources/data/ckeditor/sdetail/");
		else if (folder.equals("product")) uploadPath= request.getSession().getServletContext().getRealPath("/resources/data/ckeditor/product/");
		
		int position = 42;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0, nextImg.indexOf("\""));
			
			String origFilePath = uploadPath + imgFile;
			String copyFilePath = request.getSession().getServletContext().getRealPath("/resources/data/ckeditor/") + imgFile;
			
			
			fileCopyCheck(origFilePath, copyFilePath);  // sdetail폴더에 파일 복사
			
			if(nextImg.indexOf("src=\"/") == -1) {
				sw = false;
			}
			else {
				nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
			}
		}
		
	}

	public void fileCopyCheck(String origFilePath, String copyFilePath) {
		File origFile = new File(origFilePath);
		File copyFile = new File(copyFilePath);
		
		try {
			FileInputStream fis = new FileInputStream(origFile); //원본파일경로
			FileOutputStream fos = new FileOutputStream(copyFile); //복사파일이 위치할 경로
			
			byte[] buffer = new byte[2048];
			int cnt = 0;
			while((cnt = fis.read(buffer)) != -1) {
				fos.write(buffer, 0, cnt);
			}
			fos.flush();
			fos.close();
			fis.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@Override
	public void imgCheck(String folder,String content) {
			
			if(content.indexOf("src=\"/") == -1) return;
			
			HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
			String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/ckeditor/");
			
			int position = 34;
			String nextImg = content.substring(content.indexOf("src=\"/") + position);
			boolean sw = true;
			
			while(sw) {
				String imgFile = nextImg.substring(0, nextImg.indexOf("\""));
				
				String origFilePath = uploadPath + imgFile;
				String copyFilePath="";
				if(folder.equals("sdetail")) copyFilePath = uploadPath + "sdetail/" + imgFile;
				else if(folder.equals("product")) copyFilePath = uploadPath + "product/" + imgFile;
				else if(folder.equals("adboard")) copyFilePath = uploadPath + "adboard/" + imgFile;
					
				fileCopyCheck(origFilePath, copyFilePath);  // sdetail폴더에 파일을 복사하고자 한다.
				
				if(nextImg.indexOf("src=\"/") == -1) {
					sw = false;
				}
				else {
					nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
			}
		}
	}


	@Override
	public void imgDelete(String folder, String content) {
		//      0         1         2         3         4         5         6
		//      01234567890123456789012345678901234567890123456789012345678901234567890
		// <img src="/green2209S_20/data/ckeditor/230111121324_green2209J_06.jpg" style="height:967px; width:1337px" /></p>
		if(content.indexOf("src=\"/") == -1) return;
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String uploadPath = "";
		if(folder.equals("sdetail")) uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/ckeditor/sdetail/");
		else if(folder.equals("product")) uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/ckeditor/product/");
		else if(folder.equals("adboard")) uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/ckeditor/adboard/");
		
		int position = 42;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0, nextImg.indexOf("\"")); //그림 파일명 꺼내오기
			
			String origFilePath = uploadPath + imgFile;
			
			fileDelete(origFilePath);  // sdeta폴더에 파일을 삭제하고자 한다.
			
			if(nextImg.indexOf("src=\"/") == -1) {
				sw = false;
			}
			else {
				nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
			}
		}
		
	}

	private void fileDelete(String origFilePath) {
		File delFile = new File(origFilePath);
		if(delFile.exists()) delFile.delete();
	}

	@Override
	public void setSubContentUpdate(int i, String content) {
		adminDAO.setSubContentUpdate(i, content);
	}

	@Override
	public String widthCheck(String content) {
		if(content.indexOf("src=\"/") == -1) content=content;
		else {
			String originContent = content;
			content="";
			while(originContent.indexOf("src=\"/") != -1) {
				int position = 6;
				if(originContent.indexOf("width:")==-1) break;
				content+= originContent.substring(0,originContent.indexOf("width:"));
				originContent= originContent.substring(originContent.indexOf("width:"));
				int width= Integer.parseInt(originContent.substring(originContent.indexOf("width:")+position,originContent.indexOf("px"))); 
				if(width>1250) {width=1250;}
				content += originContent.substring(0,originContent.indexOf("width:")+6)+width+"px";
				originContent = originContent.substring(originContent.indexOf("px")+2);
			}
			content+=originContent;
		}
		return content;
	}
	@Override
	public List<CategorySmallVO>  getSmallCategory(int codeLarge) {
		return adminDAO.getSmallCategory(codeLarge);
	}
//상품등록
	@Override
	public int setProductInput(MultipartFile fileName,ProductVO vo) {
		//업로드된 사진을 서버 파일시스템에 저장시켜준다.
		int res=0;
		try {
			String oFileName = fileName.getOriginalFilename();
			if(oFileName.equals("")) {
				vo.setFName(oFileName);
				vo.setFSName(oFileName);
			}
			
			else {
				UUID uid = UUID.randomUUID();
				String saveFileName = uid + "_" +oFileName;
				
				JavawspringProvide ps = new JavawspringProvide(); 
				ps.writeFile(fileName,saveFileName,"data/ckeditor/product");
				vo.setFName(oFileName);
				vo.setFSName(saveFileName);
			}
			adminDAO.setProductInput(vo);
			res=1;
			
		} catch (IOException e) {
			e.getStackTrace();
		}
		return res;
	}

	@Override
	public int getProductLastIdx() {
		return adminDAO.getProductLastIdx()==null?0:Integer.parseInt(adminDAO.getProductLastIdx());
	}

	@Override
	public void setOptionInput(DBoptionVO optionVo) {
		int productIdx = optionVo.getProductIdx();
		String [] names = optionVo.getOptionName().split(",");
		String [] prices = optionVo.getOptionPrice().split(",");
		for(int i=0;i<names.length;i++) {
			optionVo = new DBoptionVO();
			optionVo.setProductIdx(productIdx);
			optionVo.setOptionName(names[i]);
			optionVo.setOptionPrice(prices[i]);
			adminDAO.setOptionInput(optionVo);
		}
	}

	@Override
	public int setProductUpdate(MultipartFile fileName, ProductVO vo) {
		//업로드된 사진을 서버 파일시스템에 저장시켜준다.
		int res=0;
		try {
			//업로드된 사진 삭제하기
			ProductVO origVo = ordersDAO.getProduct(vo.getIdx());
			
			String oFileName = fileName.getOriginalFilename();
			if(oFileName.equals("")) { //사진을 안올린 경우 원래 파일 유지
				vo.setFName(origVo.getFName());
				vo.setFSName(origVo.getFSName());
			}
			
			else {
				JavawspringProvide ps = new JavawspringProvide(); 
				  
				ps.deleteFile(origVo.getFSName(),"data/ckeditor/product"); //원래있던파일 삭제
				
				UUID uid = UUID.randomUUID();
				String saveFileName = uid + "_" +oFileName;
				
				ps.writeFile(fileName,saveFileName,"data/ckeditor/product");
				vo.setFName(oFileName);
				vo.setFSName(saveFileName);
			}
			adminDAO.setProductUpdate(vo);
			res=1;
			
		} catch (IOException e) {
			e.getStackTrace();
		}
		return res;
	}

	@Override
	public void setOptionUpdate(DBoptionVO vo) {
		adminDAO.setOptionUpdate(vo);
	}

	@Override
	public void setOptionDelete(int idx) {
		adminDAO.setOptionDelete(idx);
	}

	@Override
	public void setProductDelete(int idx) {
		//업로드된 사진 삭제하기
		ProductVO origVo = ordersDAO.getProduct(idx);
		String detail= origVo.getDetail();
			
		imgDelete("product", detail);
	
		JavawspringProvide ps = new JavawspringProvide(); 
		  
		ps.deleteFile(origVo.getFSName(),"data/ckeditor/product"); //원래있던파일 삭제
		adminDAO.setProductDelete(idx);
	}

	@Override
	public void setCategoryDelete(int codeSmall) {
		adminDAO.setCategoryDelete(codeSmall);
	}

	@Override
	public void setCategoryUpdate(CategorySmallVO vo) {
		adminDAO.setCategoryUpdate(vo);
	}

	@Override
	public BasisVO getBasis() {
		return adminDAO.getBasis();
	}

	@Override
	public List<OrdersVO> getOrdersList(int startIndexNo, int pageSize, int orderSw, String startDate, String lastDate,
			String part, String search) {
		return  adminDAO.getOrdersList( startIndexNo, pageSize, orderSw, startDate, lastDate,
				part, search);
	}

	@Override
	public List<OrdersVO> getSubsList(int startIndexNo, int pageSize, String subSw, int orderSw, String startDate,
			String lastDate, String search, String part,String sstartDate, String slastDate) {
		return adminDAO.getSubsList( startIndexNo, pageSize,subSw, orderSw, startDate, lastDate,
				part, search,sstartDate, slastDate);
	}

	@Override
	public void setMemberLevelUpdate(int idx, int level) {
		adminDAO.setMemberLevelUpdate(idx,level);
	}

	@Override
	public void adminMemberDelete(String mid) {
		adminDAO.adminMemberDelete(mid);
	}

	@Override
	public void setBasisUpdate(BasisVO vo) {
		adminDAO.setBasisUpdate(vo);
	}

	@Override
	public void setFileDelete(String delItems,String str) {
		delItems = delItems.substring(0,delItems.length()-1);
		JavawspringProvide pv= new JavawspringProvide();
		for(String file:delItems.split("/")) {
			pv.deleteFile(file, str);
		}
	}

	@Override
	public void setProductSellSwUpdate(int idx, String string) {
		adminDAO.setProductSellSwUpdate(idx, string);
	}

}
