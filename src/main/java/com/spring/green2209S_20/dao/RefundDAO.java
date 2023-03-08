package com.spring.green2209S_20.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.green2209S_20.vo.RefundVO;

public interface RefundDAO {

	public void setRefundInput(@Param("vo") RefundVO vo);

	public String totRecCnt(@Param("part") String part,@Param("search") String search) ;

	public List<RefundVO> getRefundList(@Param("startIndexNo") int startIndexNo,@Param("pageSize") int pageSize,@Param("part") String part,@Param("search") String search);

	public void setRefundUpdateSw(@Param("idx") int idx,@Param("sw") int sw);

	public RefundVO getRefund(@Param("idx") int idx);

	public void setRefundUpdatePrice(@Param("vo") RefundVO vo);

	public String totRecAdminCnt(@Param("refundSw") int codeLarge, int codeSmall,@Param("startDate") String startDate,@Param("lastDate") String lastDate,@Param("part") String part,
			@Param("search") String search);

	public List<RefundVO> getRefundSearchList(@Param("startIndexNo") int startIndexNo, @Param("pageSize")int pageSize,@Param("refundSw") int refundSw,@Param("startDate") String startDate,
			@Param("lastDate")String lastDate,@Param("part") String part,@Param("search")String search);



}
