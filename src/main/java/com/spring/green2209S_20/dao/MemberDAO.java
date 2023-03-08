package com.spring.green2209S_20.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.beust.jcommander.Parameter;
import com.spring.green2209S_20.vo.BucketVO;
import com.spring.green2209S_20.vo.MemberVO;

public interface MemberDAO {

	public MemberVO memberIdCheck(@Param("mid") String mid);

	public void setMemberJoin(@Param("vo") MemberVO vo);

	public void setLastDateUpdate(@Param("mid") String mid);

	public int totRecCnt(@Param("searchLevel")int searchLevel,@Param("part")String part,@Param("search")String search);

	public List<MemberVO> getMemberList(@Param("startIndexNo") int startIndexNo,@Param("pageSize") int pageSize,@Param("searchLevel") int searchLevel,@Param("part") String part,@Param("search") String search);

	public List<BucketVO> getMemberBucket(@Param("mid") String mid);

	public void setBucketDelete(@Param("idx") int idx);

	public MemberVO getMemberMidSearch(@Param("name") String name,@Param("email") String email);

	public void setMemberPwdUpdate(@Param("mid") String mid,@Param("pwd") String pwd);

	public void bucketUpdate(@Param("idx") int idx,@Param("price") int price ,@Param("buho") int buho);

	public void setMemberPointUpdate(@Param("point") int point,@Param("mid") String mid);

	public void setMemberUpdate(@Param("vo") MemberVO vo);

	public MemberVO getMemberFromEmail(@Param("email") String email);

	public void setMemberDelete(@Param("mid") String mid);

	
}
