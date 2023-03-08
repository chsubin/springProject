package com.spring.green2209S_20.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.beust.jcommander.Parameter;
import com.spring.green2209S_20.vo.CategorySmallVO;
import com.spring.green2209S_20.vo.ChartVO;
import com.spring.green2209S_20.vo.ProductVO;

public interface ChartDAO {

	public List<ProductVO> getProductNameByOrder(@Param("startDate") String startDate,@Param("lastDate") String lastDate,@Param("part") String part,@Param("search") String search);

	public String getTotalSellPrice(@Param("orderDate") String orderDate,@Param("subSw")String subSW,@Param("part") String part,@Param("search") String search);

	public List<CategorySmallVO> getOrdersByCategory(@Param("startDate") String startDate,@Param("lastDate") String lastDate,@Param("part") String part,@Param("search")String search);

	public int getSubscribeCnt(@Param("orderDate") String orderDate,@Param("part") String part,@Param("search")String search);

	public int getMemberGenderCnt(@Param("startDate") String startDate,@Param("gender") String gender);

	public int getMemberComCnt(@Param("startDate") String datesPlus);

	public List<ChartVO> getOrdersMid();

	public int getTodayMember(@Param("startDate") String startDate);


}
