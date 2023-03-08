package com.spring.green2209S_20.service;

import java.util.List;

import com.spring.green2209S_20.vo.CouponsVO;

public interface CouponsService {

	public String qrCreate(int intIdx, CouponsVO vo, String realPath);

	public String getLastIdx();

	public List<CouponsVO> getCouponList(int startIndexNo, int pageSize);

	public void setCouponUpdate(int couponIdx);

	public void setCouponDelete(int idx);

	public CouponsVO getCoupon(String code);


}
