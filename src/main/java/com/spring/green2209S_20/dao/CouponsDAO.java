package com.spring.green2209S_20.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.green2209S_20.vo.CouponsVO;

public interface CouponsDAO {

	public String getLastIdx();

	public void setCouponInput(@Param("vo") CouponsVO vo);

	public int totRecCnt();

	public List<CouponsVO> getCouponList(@Param("startIndexNo") int startIndexNo,@Param("pageSize") int pageSize);

	public void setCouponUpdate(@Param("couponIdx") int couponIdx);

	public void setCouponDelete(@Param("idx") int idx);

	public CouponsVO getCoupon(@Param("code") String code);


}
