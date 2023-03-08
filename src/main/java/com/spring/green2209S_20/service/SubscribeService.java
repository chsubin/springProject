package com.spring.green2209S_20.service;

import java.util.List;

import com.spring.green2209S_20.vo.BucketVO;
import com.spring.green2209S_20.vo.CategoryLargeVO;
import com.spring.green2209S_20.vo.OrdersVO;
import com.spring.green2209S_20.vo.ProductVO;
import com.spring.green2209S_20.vo.SubscribeVO;

public interface SubscribeService {

	public CategoryLargeVO getSubContent(int codeLarge);

	public void setProductBuket(BucketVO vo, String optionidxs);

	public void setSubscribeInput(SubscribeVO vo);

	public List<SubscribeVO> getSubscribeList(int oIdx);

	public void setSubscribeStop(int oIdx,String subSw);

	public void setOrdersSubUpdate(OrdersVO vo);

	public List<ProductVO> getProductList(String search, String orderBy);


}
