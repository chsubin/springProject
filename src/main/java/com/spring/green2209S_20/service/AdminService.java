package com.spring.green2209S_20.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.spring.green2209S_20.vo.BasisVO;
import com.spring.green2209S_20.vo.BoardVO;
import com.spring.green2209S_20.vo.CategoryLargeVO;
import com.spring.green2209S_20.vo.CategorySmallVO;
import com.spring.green2209S_20.vo.DBoptionVO;
import com.spring.green2209S_20.vo.OrdersVO;
import com.spring.green2209S_20.vo.ProductVO;

public interface AdminService {

	public List<CategoryLargeVO> getLargeCategoryList();

	public List<CategorySmallVO> getSmallCategoryList();

	public void setCategoryInput(CategorySmallVO vo);

	public CategoryLargeVO getSubDetail(int i);

	public void imgCheckUpdate(String folder,String content);

	public void imgDelete(String folder, String content);

	public void imgCheck(String folder, String content);

	public void setSubContentUpdate(int i, String content);

	public String widthCheck(String content);

	public List<CategorySmallVO> getSmallCategory(int codeLarge);

	public int setProductInput(MultipartFile fName, ProductVO vo);

	public int getProductLastIdx();

	public void setOptionInput(DBoptionVO optionVo);

	public int setProductUpdate(MultipartFile fileName, ProductVO vo);

	public void setOptionUpdate(DBoptionVO vo);

	public void setOptionDelete(int idx);

	public void setProductDelete(int idx);

	public void setCategoryDelete(int codeSmall);

	public void setCategoryUpdate(CategorySmallVO vo);

	public BasisVO getBasis();

	public List<OrdersVO> getOrdersList(int startIndexNo, int pageSize, int orderSw, String startDate, String lastDate,
			String part, String search);

	public List<OrdersVO> getSubsList(int startIndexNo, int pageSize, String string, int i, String startDate,
			String lastDate, String search, String part,String sstartDate, String slastDate);

	public void setMemberLevelUpdate(int idx, int level);

	public void adminMemberDelete(String mid);

	public void setBasisUpdate(BasisVO vo);

	public void setFileDelete(String delItems,String str);

	public void setProductSellSwUpdate(int idx, String string);


}
