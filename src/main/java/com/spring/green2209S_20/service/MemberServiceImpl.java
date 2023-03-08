package com.spring.green2209S_20.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.green2209S_20.dao.MemberDAO;
import com.spring.green2209S_20.vo.BucketVO;
import com.spring.green2209S_20.vo.MemberVO;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	MemberDAO memberDAO;

	@Override
	public String memberIdCheck(String mid) {
		String res="0";
		MemberVO vo =  memberDAO.memberIdCheck(mid);
		if(vo!=null) {
			if(vo.getMid().equals(mid)) res ="1";
		}
		return res;
	}

	@Override
	public int setMemberJoin(MemberVO vo) {
		int res =0;
		if(vo.getName()!=null) {
			memberDAO.setMemberJoin(vo);
			res=1;
		}
		return res;
	}

	@Override
	public MemberVO memberLoginCheck(String mid) {
		return memberDAO.memberIdCheck(mid);
	}

	@Override
	public void setLastDateUpdate(String mid) {
		memberDAO.setLastDateUpdate(mid);
	}

	@Override
	public List<MemberVO> getMemberList(int startIndexNo, int pageSize,int searchLevel,String part, String search) {
		return memberDAO.getMemberList(startIndexNo,pageSize,searchLevel,part,search);
	}

	@Override
	public List<BucketVO> getMemberBucket(String mid) {
		return memberDAO.getMemberBucket(mid);
	}

	@Override
	public void setBucketDelete(int idx) {
		memberDAO.setBucketDelete(idx);
	}

	@Override
	public MemberVO getMemberMidSearch(String name, String email) {
		return memberDAO.getMemberMidSearch(name,email);
	}

	@Override
	public void setMemberPwdUpdate(String mid, String pwd) {
		memberDAO.setMemberPwdUpdate(mid,pwd);
	}

	@Override
	public void bucketUpdate(int idx,int price, int buho) {
		memberDAO.bucketUpdate(idx,price, buho);
	}

	@Override
	public void setMemberPointUpdate(int point,String mid) {
		memberDAO.setMemberPointUpdate(point,mid);
	}

	@Override
	public void setMemberUpdate(MemberVO vo) {
		memberDAO.setMemberUpdate(vo);
	}

	@Override
	public MemberVO getMemberFromEmail(String email) {
		return memberDAO.getMemberFromEmail(email);
	}

	@Override
	public void setMemberDelete(String mid) {
		memberDAO.setMemberDelete(mid);
	}


}
