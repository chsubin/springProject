package com.spring.green2209S_20.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.green2209S_20.vo.CategoryLargeVO;
import com.spring.green2209S_20.vo.OrdersVO;
import com.spring.green2209S_20.vo.ProductVO;
import com.spring.green2209S_20.vo.SubscribeVO;

public interface SubscribeDAO {

	public CategoryLargeVO getSubContent(@Param("codeLarge") int codeLarge);

	public void setSubscribeInput(@Param("vo") SubscribeVO vo);

	public List<SubscribeVO> getSubscribeList(@Param("oIdx") int oIdx);

	public void setSubscribeStop(@Param("oIdx") int oIdx,@Param("subSw")String subSw);

	public void setOrdersSubUpdate(@Param("vo") OrdersVO vo);

	public List<ProductVO> getProductList(@Param("search") String search,@Param("orderBy") String orderBy);


}
