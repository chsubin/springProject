package com.spring.green2209S_20.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.green2209S_20.dao.OrdersDAO;
import com.spring.green2209S_20.vo.BucketVO;
import com.spring.green2209S_20.vo.CategorySmallVO;
import com.spring.green2209S_20.vo.CouponsVO;
import com.spring.green2209S_20.vo.DBoptionVO;
import com.spring.green2209S_20.vo.OrderSubVO;
import com.spring.green2209S_20.vo.OrdersVO;
import com.spring.green2209S_20.vo.ProductVO;

@Service
public class OrdersServiceImpl implements OrdersService {

	@Autowired
	OrdersDAO ordersDAO;

	@Override
	public List<CategorySmallVO> getSmallCategoryList(int codeLarge) {
		return ordersDAO.getSmallCategoryList(codeLarge);
	}

	@Override
	public ArrayList<ProductVO> getProductList(int codeLarge, int codeSmall, int startIndexNo, int pageSize,String orderBy) {
		return ordersDAO.getProductList(codeLarge, codeSmall, startIndexNo, pageSize,orderBy);
	}

	@Override
	public ProductVO getProduct(int idx) {
		return ordersDAO.getProduct(idx);
	}

	@Override
	public List<DBoptionVO> getOptionList(int idx) {
		return ordersDAO.getOptionList(idx);
	}

	@Override
	public BucketVO getBucketList(BucketVO vo) {
		return ordersDAO.getBucketList(vo);
	}

	@Override
	public void setProductBucket(BucketVO vo) {
		ordersDAO.setProductBucketInput(vo);
		
	}

	@Override
	public void setBucketUpdate(BucketVO vo) {
		ordersDAO.setBucketUpdate(vo);
	}

	@Override
	public DBoptionVO getOption(int optionIdx) {
		return ordersDAO.getOption(optionIdx);
	}

	@Override
	public void setOrders(OrdersVO vo) {
		ordersDAO.setOrders(vo);
	}

	@Override
	public void setOrdersUpdateSw(String orderIdx) {
		ordersDAO.setOrdersUpdateSw(orderIdx);
	}

	@Override
	public void setBucketDelete(String mid) {
		ordersDAO.setBucketDelete(mid);
	}

	@Override
	public List<OrdersVO> getOrdersList(int startIndexNo, int pageSize,int subSw, String part, String search) {
		return ordersDAO.getOrdersList(startIndexNo, pageSize,subSw , part, search);
	}

	@Override
	public List<OrdersVO> getOrders(String orderIdx) {
		return ordersDAO.getOrders(orderIdx);
	}

	@Override
	public OrdersVO getOrder(int idx) {
		return ordersDAO.getOrder(idx);
	}

	@Override
	public List<OrdersVO> getSubsList(int startIndexNo, int pageSize, String subSw, int ordersSw, String part,
			String search) {
		return ordersDAO.getSubsList(startIndexNo, pageSize, subSw, ordersSw,part, search);
	}

	@Override
	public void setOrderUpdateSw(int idx, int orderSw) {
		ordersDAO.setOrderUpdateSw(idx, orderSw);
	}

	@Override
	public CouponsVO getUsableCoupons(String code) {
		return ordersDAO.getUsableCoupons(code);
	}

	@Override
	public void setOrderSub(OrderSubVO vo) {
		ordersDAO.setOrderSub(vo);
	}

	@Override
	public OrderSubVO getOrderSub(String orderIdx) {
		return ordersDAO.getOrderSub(orderIdx);
	}

	@Override
	public void setorderSubUpdateRefundCoupon(String orderIdx, int couponUse) {
		ordersDAO.setorderSubUpdateRefundCoupon(orderIdx, couponUse);
	}

	
	
	
}
