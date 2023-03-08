package com.spring.green2209S_20.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.green2209S_20.vo.BasisVO;
import com.spring.green2209S_20.vo.BoardVO;
import com.spring.green2209S_20.vo.CategoryLargeVO;
import com.spring.green2209S_20.vo.CategorySmallVO;
import com.spring.green2209S_20.vo.DBoptionVO;
import com.spring.green2209S_20.vo.OrdersVO;
import com.spring.green2209S_20.vo.ProductVO;

public interface AdminDAO {

	public List<CategoryLargeVO> getLargeCategoryList();

	public List<CategorySmallVO> getSmallCategoryList();

	public void setCategoryInput(@Param("vo") CategorySmallVO vo);

	public CategoryLargeVO getSubDetail(@Param("codeLarge")  int i);

	public void setSubContentUpdate(@Param("codeLarge") int i,@Param("content") String content);

	public List<CategorySmallVO> getSmallCategory(@Param("codeLarge") int codeLarge);
	
	//만드는중
	public void setProductInput(@Param("vo") ProductVO vo);

	public String getProductLastIdx();

	public void setOptionInput(@Param("vo") DBoptionVO optionVo);

	public void setProductUpdate(@Param("vo") ProductVO vo);

	public void setOptionUpdate(@Param("vo") DBoptionVO vo);

	public void setOptionDelete(@Param("idx") int idx);

	public void setProductDelete(@Param("idx") int idx);

	public void setCategoryDelete(@Param("codeSmall") int codeSmall);

	public void setCategoryUpdate(@Param("vo") CategorySmallVO vo);

	public BasisVO getBasis();

	public int totRecOrdersCnt(@Param("subSw") int subSw, @Param("orderSw") int orderSw,@Param("startDate") String startDate,@Param("lastDate") String lastDate,
			@Param("part") String part,@Param("search") String search);

	public List<OrdersVO> getOrdersList(@Param("startIndexNo") int startIndexNo,@Param("pageSize") int pageSize,@Param("orderSw") int orderSw,@Param("startDate") String startDate,@Param("lastDate") String lastDate,
			@Param("part") String part,@Param("search") String search);

	public int totRecSubCnt(@Param("subSw") String subSw, @Param("orderSw") int orderSw,@Param("startDate") String startDate,@Param("lastDate") String lastDate,
			@Param("part") String part,@Param("search") String search,@Param("sstartDate") String sstartDate,@Param("slastDate") String slastDate);

	public List<OrdersVO> getSubsList(@Param("startIndexNo") int startIndexNo,@Param("pageSize") int pageSize, @Param("subSw") String subSw, @Param("orderSw") int orderSw,@Param("startDate") String startDate,@Param("lastDate") String lastDate,
			@Param("part") String part,@Param("search") String search,@Param("sstartDate") String sstartDate,@Param("slastDate") String slastDate);
 
	public void setMemberLevelUpdate(@Param("idx") int idx,@Param("level") int level);

	public void adminMemberDelete(@Param("mid") String mid);

	public void setBasisUpdate(@Param("vo") BasisVO vo);

	public void setProductSellSwUpdate(@Param("idx")int idx, @Param("sellSw")String sellSw);


	
}
