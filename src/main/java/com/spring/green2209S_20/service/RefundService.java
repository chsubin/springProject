package com.spring.green2209S_20.service;

import java.util.List;

import com.spring.green2209S_20.vo.RefundVO;

public interface RefundService {

	public void setRefundInput(RefundVO vo);

	public List<RefundVO> getRefundList(int startIndexNo, int pageSize, String string, String mid);

	public void setRefundUpdateSw(int idx, int refundSw);

	public RefundVO getRefund(int idx);

	public void setRefundUpdatePrice(RefundVO vo);

	public List<RefundVO> getRefundSearchList(int startIndexNo, int pageSize, int refundSw, String startDate,
			String lastDate, String part, String search);


}
