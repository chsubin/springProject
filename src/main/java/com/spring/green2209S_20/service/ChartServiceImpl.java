package com.spring.green2209S_20.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.green2209S_20.dao.ChartDAO;
import com.spring.green2209S_20.vo.CategorySmallVO;
import com.spring.green2209S_20.vo.ChartVO;
import com.spring.green2209S_20.vo.ProductVO;

@Service
public class ChartServiceImpl implements ChartService {

	@Autowired
	ChartDAO chartDAO;

	@Override
	public List<ProductVO> getProductNameByOrder(String startDate, String lastDate,String part,String search) {
		return chartDAO.getProductNameByOrder(startDate, lastDate,part,search);
	}

	@Override
	public int getTotalSellPrice(String orderDate,String subSw,String part,String search) {
		return chartDAO.getTotalSellPrice(orderDate,subSw,part,search)==null?0:Integer.parseInt(chartDAO.getTotalSellPrice(orderDate,subSw,part,search));
	}

	@Override
	public List<CategorySmallVO> getOrdersByCategory(String startDate, String lastDate,String part,String search) {
		return chartDAO.getOrdersByCategory(startDate,lastDate,part,search);
	}

	@Override
	public int getSubscribeCnt(String orderDate,String part,String search) {
		return chartDAO.getSubscribeCnt(orderDate,part,search);
	}

	@Override
	public int getMemberGenderCnt(String startDate, String gender) {
		return chartDAO.getMemberGenderCnt(startDate,gender);
	}

	@Override
	public int getMemberComCnt(String datesPlus) {
		return chartDAO.getMemberComCnt(datesPlus);
	}

	@Override
	public List<ChartVO> getOrdersMid() {
		return chartDAO.getOrdersMid();
	}

	@Override
	public int getTodayMember(String startDate) {
		return chartDAO.getTodayMember(startDate);
	}

	
}
