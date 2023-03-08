package com.spring.green2209S_20.service;

import java.util.List;

import com.spring.green2209S_20.vo.CategorySmallVO;
import com.spring.green2209S_20.vo.ChartVO;
import com.spring.green2209S_20.vo.ProductVO;

public interface ChartService {

	public List<ProductVO> getProductNameByOrder(String startDate, String lastDate,String part,String search);

	public int getTotalSellPrice(String orderDate,String subSw,String part,String search);

	public List<CategorySmallVO> getOrdersByCategory(String startDate, String lastDate,String part,String search);

	public int getSubscribeCnt(String orderDate,String part,String search);

	public int getMemberGenderCnt(String datesPlus, String gender);

	public int getMemberComCnt(String datesPlus);

	public List<ChartVO> getOrdersMid();

	public int getTodayMember(String startDate);





}
