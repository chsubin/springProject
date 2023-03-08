package com.spring.green2209S_20.service;

import java.util.List;

import com.spring.green2209S_20.vo.BucketVO;
import com.spring.green2209S_20.vo.MemberVO;

public interface MemberService {

	public String memberIdCheck(String mid);

	public int setMemberJoin(MemberVO vo);

	public MemberVO memberLoginCheck(String mid);

	public void setLastDateUpdate(String mid);

	public List<MemberVO> getMemberList(int startIndexNo, int pageSize,int searchLevel,String part, String search);

	public List<BucketVO> getMemberBucket(String mid);

	public void setBucketDelete(int idx);

	public MemberVO getMemberMidSearch(String name, String email);

	public void setMemberPwdUpdate(String mid, String pwd);

	public void bucketUpdate(int idx, int price, int buho);

	public void setMemberPointUpdate(int point, String mid);

	public void setMemberUpdate(MemberVO vo);

	public MemberVO getMemberFromEmail(String email);

	public void setMemberDelete(String mid);


}
