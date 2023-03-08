package com.spring.green2209S_20.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.beust.jcommander.Parameter;
import com.spring.green2209S_20.vo.BucketVO;
import com.spring.green2209S_20.vo.CategorySmallVO;
import com.spring.green2209S_20.vo.CouponsVO;
import com.spring.green2209S_20.vo.DBoptionVO;
import com.spring.green2209S_20.vo.OrderSubVO;
import com.spring.green2209S_20.vo.OrdersVO;
import com.spring.green2209S_20.vo.ProductVO;

public interface OrdersDAO {

	List<CategorySmallVO> getSmallCategoryList(@Param("codeLarge") int codeLarge);

	public String totRecCnt(@Param("codeLarge") int codeLarge,@Param("codeSmall") int codeSmall);

	public ArrayList<ProductVO> getProductList(@Param("codeLarge")int codeLarge, @Param("codeSmall")int codeSmall,@Param("startIndexNo") int startIndexNo,@Param("pageSize") int pageSize,@Param("orderBy")String orderBy);

	public ProductVO getProduct(@Param("idx") int idx);

	public List<DBoptionVO> getOptionList(@Param("productIdx") int idx);

	public DBoptionVO getOption(@Param("idx") int optionIdx);

	public void setProductBucketInput(@Param("vo") BucketVO vo);

	public BucketVO getBucketList(@Param("vo") BucketVO vo);

	public void setProductBuket(@Param("vo") BucketVO vo);

	public void setBucketUpdate(@Param("vo") BucketVO vo);

	public void setOrders(@Param("vo") OrdersVO vo);

	public void setOrdersUpdateSw(@Param("orderIdx") String orderIdx);

	public void setBucketDelete(@Param("mid") String mid);

	public int totRecOrdersCnt(@Param("subSw")int subSw, @Param("orderSw")int orderSw, @Param("part") String part,@Param("search") String search);
	

	public List<OrdersVO> getOrdersList(@Param("startIndexNo") int startIndexNo,@Param("pageSize") int pageSize,@Param("orderSw")int orderSw,@Param("part") String part,@Param("search") String search);
	
	public List<OrdersVO> getOrders(@Param("orderIdx") String orderIdx);

	public OrdersVO getOrder(@Param("idx") int idx);

	public int totRecSubCnt(@Param("subSw")String subSw,@Param("orderSw")int orderSw, @Param("part") String part,@Param("search") String search);

	public List<OrdersVO> getSubsList(@Param("startIndexNo") int startIndexNo,@Param("pageSize") int pageSize,@Param("subSw")String subSw ,@Param("orderSw")int ordersSw,@Param("part") String part,@Param("search") String search);

	public void setOrderUpdateSw(@Param("idx") int idx,@Param("orderSw") int orderSw);

	public CouponsVO getUsableCoupons(@Param("code") String code);

	public void setOrderSub(@Param("vo") OrderSubVO vo);

	public OrderSubVO getOrderSub(@Param("oIdx") String orderIdx);

	public void setorderSubUpdateRefundCoupon(@Param("orderIdx")String orderIdx,@Param("couponUse") int couponUse);


	


	
}
