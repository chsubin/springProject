package com.spring.green2209S_20.service;

import java.util.ArrayList;
import java.util.List;

import com.spring.green2209S_20.vo.BucketVO;
import com.spring.green2209S_20.vo.CategorySmallVO;
import com.spring.green2209S_20.vo.CouponsVO;
import com.spring.green2209S_20.vo.DBoptionVO;
import com.spring.green2209S_20.vo.OrderSubVO;
import com.spring.green2209S_20.vo.OrdersVO;
import com.spring.green2209S_20.vo.ProductVO;

public interface OrdersService {

	public List<CategorySmallVO> getSmallCategoryList(int CodeLarge);

	public ArrayList<ProductVO> getProductList(int codeLarge, int codeSmall, int startIndexNo, int pageSize,String orderBy);

	public ProductVO getProduct(int idx);

	public List<DBoptionVO> getOptionList(int idx);

	public BucketVO getBucketList(BucketVO vo);

	public void setProductBucket(BucketVO vo);

	public void setBucketUpdate(BucketVO vo);

	public DBoptionVO getOption(int optionIdx);

	public void setOrders(OrdersVO orderVo);

	public void setOrdersUpdateSw(String orderIdx);

	public void setBucketDelete(String mid);

	public List<OrdersVO> getOrdersList(int startIndexNo, int pageSize,int orderSw, String part, String search);

	public List<OrdersVO> getOrders(String orderIdx);

	public OrdersVO getOrder(int idx);

	public List<OrdersVO> getSubsList(int startIndexNo, int pageSize, String subSw,int ordersSw , String string, String mid);

	public void setOrderUpdateSw(int idx, int orderSw);

	public CouponsVO getUsableCoupons(String code);

	public void setOrderSub(OrderSubVO vo);

	public OrderSubVO getOrderSub(String orderIdx);

	public void setorderSubUpdateRefundCoupon(String orderIdx, int couponUse);


}
