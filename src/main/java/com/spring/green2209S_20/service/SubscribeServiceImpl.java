package com.spring.green2209S_20.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.green2209S_20.dao.OrdersDAO;
import com.spring.green2209S_20.dao.SubscribeDAO;
import com.spring.green2209S_20.vo.BucketVO;
import com.spring.green2209S_20.vo.CategoryLargeVO;
import com.spring.green2209S_20.vo.DBoptionVO;
import com.spring.green2209S_20.vo.OrdersVO;
import com.spring.green2209S_20.vo.ProductVO;
import com.spring.green2209S_20.vo.SubscribeVO;

@Service
public class SubscribeServiceImpl implements SubscribeService {

	@Autowired
	SubscribeDAO subscribeDAO;
	
	@Autowired
	OrdersDAO ordersDAO;
	
	
	@Override
	public CategoryLargeVO getSubContent(int codeLarge) {
		return subscribeDAO.getSubContent(codeLarge);
	}

	@Override
	public void setProductBuket(BucketVO vo,String optionIdxs) {
		ProductVO proVo = ordersDAO.getProduct(vo.getProductIdx());
		String detail = vo.getOptionDetail()==null?"":vo.getOptionDetail();
		optionIdxs= optionIdxs==null?"":optionIdxs;
		String [] arr = detail.split(",");
		String [] optionIdx = optionIdxs.split(",");
		if(optionIdxs.contains(",")) {
			for(int i=0;i<arr.length;i++) {
				DBoptionVO optionVo = ordersDAO.getOption(Integer.parseInt(optionIdx[i]));
				vo.setOptionIdx(optionVo.getIdx());
				vo.setCodeLarge(proVo.getCodeLarge());
				vo.setCodeSmall(proVo.getCodeSmall());
				vo.setOptionNum(1);
				vo.setOptionDetail(arr[i]);
				vo.setSubSw("OK");
				vo.setTotalPrice(proVo.getPrice()+Integer.parseInt(optionVo.getOptionPrice()));
				ordersDAO.setProductBucketInput(vo);
			}
		}
		else {
			DBoptionVO optionVo = ordersDAO.getOption(Integer.parseInt(optionIdxs));
			vo.setOptionIdx(optionVo.getIdx());
			vo.setCodeLarge(proVo.getCodeLarge());
			vo.setCodeSmall(proVo.getCodeSmall());
			vo.setOptionNum(1);
			vo.setOptionDetail(detail);
			vo.setSubSw("OK");
			vo.setTotalPrice(proVo.getPrice()+Integer.parseInt(optionVo.getOptionPrice()));
			ordersDAO.setProductBucketInput(vo);
		} 
		
	}

	@Override
	public void setSubscribeInput(SubscribeVO vo) {
		subscribeDAO.setSubscribeInput(vo);
	}

	@Override
	public List<SubscribeVO> getSubscribeList(int oIdx) {
		return subscribeDAO.getSubscribeList(oIdx);
	}

	@Override
	public void setSubscribeStop(int oIdx,String subSw) {
		subscribeDAO.setSubscribeStop(oIdx,subSw);
	}

	@Override
	public void setOrdersSubUpdate(OrdersVO vo) {
		subscribeDAO.setOrdersSubUpdate(vo);
	}

	@Override
	public List<ProductVO> getProductList(String search,String orderBy) {
		return subscribeDAO.getProductList(search,orderBy);
	}

}
