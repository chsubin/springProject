package com.spring.green2209S_20.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.green2209S_20.dao.RefundDAO;
import com.spring.green2209S_20.vo.RefundVO;

@Service
public class RefundServiceImpl implements RefundService {

	@Autowired
	RefundDAO refundDAO;

	@Override
	public void setRefundInput(RefundVO vo) {
		refundDAO.setRefundInput(vo);
	}

	@Override
	public List<RefundVO> getRefundList(int startIndexNo, int pageSize, String string, String mid) {
		return refundDAO.getRefundList(startIndexNo, pageSize, string, mid);
	}

	@Override
	public void setRefundUpdateSw(int parseInt, int sw) {
		refundDAO.setRefundUpdateSw(parseInt, sw);
	}

	@Override
	public RefundVO getRefund(int idx) {
		return refundDAO.getRefund(idx);
	}

	@Override
	public void setRefundUpdatePrice(RefundVO vo) {
		refundDAO.setRefundUpdatePrice(vo);
	}

	@Override
	public List<RefundVO> getRefundSearchList(int startIndexNo, int pageSize, int refundSw, String startDate,
			String lastDate, String part, String search) {
		return refundDAO.getRefundSearchList(startIndexNo, pageSize, refundSw, startDate,
				lastDate, part, search);
	}

}
