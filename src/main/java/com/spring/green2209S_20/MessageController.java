package com.spring.green2209S_20;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MessageController {
	
	@RequestMapping(value="/msg/{msgFlag}",method = RequestMethod.GET)
	public String msgGet(@PathVariable String msgFlag,Model model,
			@RequestParam(name= "mid", defaultValue = "",required = false) String mid,
			@RequestParam(name="flag",defaultValue = "",required = false)String flag
			) {
		
		if(msgFlag.equals("memberJoinOk")) {
			model.addAttribute("url", "member/memberLogin");
			model.addAttribute("msg", "회원가입 되었습니다.");
		}
		else if(msgFlag.equals("memberJoinNo")) {
			model.addAttribute("url", "member/memberJoin");
			model.addAttribute("msg", "회원가입 실패~");
		}
		else if(msgFlag.equals("memberLoginOk")) {
			model.addAttribute("url", "member/memberMain");
			model.addAttribute("msg", mid+"님 로그인 되었습니다.");
		}
		else if(msgFlag.equals("memberLoginNo")) {
			model.addAttribute("url", "member/memberLogin");
			model.addAttribute("msg", "로그인 실패");
		}
		else if(msgFlag.equals("memberLogout")) {
			model.addAttribute("msg", mid+"님 로그아웃 되었습니다.");
			model.addAttribute("url", "");
		}
		else if(msgFlag.equals("memberNo")) {
			model.addAttribute("msg", "관리자만 사용가능합니다.");
			model.addAttribute("url", "");
		}
		else if(msgFlag.equals("memberNo1")) {
			model.addAttribute("msg", "로그인이 필요한 화면입니다.");
			model.addAttribute("url", "member/memberLogin");
		}
		else if(msgFlag.equals("productInputOk")) {
			model.addAttribute("msg", "상품이 등록되었습니다.");
			model.addAttribute("url", "admin/product/adminInputProduct");
		}
		else if(msgFlag.equals("productInputNo")) {
			model.addAttribute("msg", "상품 등록 실패");
			model.addAttribute("url", "admin/product/adminInputProduct");
		}
		else if(msgFlag.equals("productOptionNumNo")) {
			model.addAttribute("msg", "옵션 등록 실패! 옵션 관리에서 확인해주세요.");
			model.addAttribute("url", "admin/product/adminProductList");
		}
		else if(msgFlag.equals("pwdUpdateOk")) {
			model.addAttribute("msg", "비밀번호가 수정되었습니다.");
			model.addAttribute("url", "member/memberMain");
		}
		else if(msgFlag.equals("pwdImsiUpdateOk")) {
			model.addAttribute("msg", "비밀번호가 수정되었습니다.");
			model.addAttribute("url", "");
		}
		else if(msgFlag.equals("pwdUpdateNo")) {
			model.addAttribute("msg", "기존 비밀번호가 틀리셨습니다.");
			model.addAttribute("url", "member/memberPwdUpdate");
		}
		else if(msgFlag.equals("reviewInputOk")) {
			model.addAttribute("msg", "리뷰가 등록되었습니다.");
			model.addAttribute("url", "reviews/reviewsList");
		}
		else if(msgFlag.equals("productUpdateOk")) {
			model.addAttribute("msg", "상품 정보가 수정되었습니다.");
			model.addAttribute("url", "admin/product/adminProductList");
		}
		else if(msgFlag.equals("memberUpdateOK")) {
			model.addAttribute("msg", "회원 정보가 수정되었습니다.");
			model.addAttribute("url", "member/memberUpdate");
		}
		else if(msgFlag.equals("subUpdateOK")) {
			model.addAttribute("msg", "구독 상세 정보가 수정되었습니다.");
			model.addAttribute("url", "subscribe/subscribeList?oIdx="+flag);
		}
		else if(msgFlag.equals("memberDeleteOK")) {
			model.addAttribute("msg", "성공적으로 탈퇴되었습니다.");
			model.addAttribute("url", "");
		}
		else if(msgFlag.equals("boardDeleteOK")) {
			model.addAttribute("msg", "게시글을 삭제하였습니다.");
			model.addAttribute("url", "admin/adboard/adminBoardList");
		}
		else if(msgFlag.equals("reviewUpdateOK")) {
			model.addAttribute("msg", "리뷰를 수정하였습니다.");
			model.addAttribute("url", "reviews/reviewsContent?idx="+flag);
		}
		else if(msgFlag.equals("reviewDeleteNO")) {
			model.addAttribute("msg", "댓글이 달린 글은 삭제하실 수 없습니다.");
			model.addAttribute("url", "reviews/reviewsContent?idx="+flag);
		}
		else if(msgFlag.equals("reviewUpdateNO")) {
			model.addAttribute("msg", "잘못된 접근입니다.");
			model.addAttribute("url", "reviews/reviewsContent?idx="+flag);
		}
		else if(msgFlag.equals("reviewDeleteOK")) {
			model.addAttribute("msg", "게시글을 삭제하였습니다.");
			model.addAttribute("url", "reviews/reviewsList");
		}
		else if(msgFlag.equals("basisUpdateOK")) {
			model.addAttribute("msg", "배송정보를 수정하였습니다.");
			model.addAttribute("url", "admin/extra/adminBasisUpdate");
		}
		else if(msgFlag.equals("businessOK")) {
			model.addAttribute("msg", "제휴신청서가 등록되었습니다.");
			model.addAttribute("url", "business/businessMain");
		}
		else if(msgFlag.equals("midMatchNo")) {
			model.addAttribute("msg", "잘못된 접근입니다.");
			model.addAttribute("url", "");
		}
		else if(msgFlag.equals("nameMatchNo")) {
			model.addAttribute("msg", "입력하신 정보가 존재하지않습니다.");
			model.addAttribute("url", "orders/ordersSearch");
		}
		else if(msgFlag.equals("adminReviewsDeleteOK")) {
			model.addAttribute("msg", "리뷰 삭제 완료");
			model.addAttribute("url", "admin/reviews/adminReviewsList");
		}
		else if(msgFlag.equals("sellSwNo")) {
			model.addAttribute("msg", "판매가 종료된 상품이 존재합니다.");
			model.addAttribute("url", "member/memberOrders");
		}
		else if(msgFlag.equals("adminJoinsExitOK")) {
			model.addAttribute("msg", "제휴를 종료합니다.");
			model.addAttribute("url", "admin/joins/adminJoinsList");
		}
		else if(msgFlag.equals("reviewsReplyExist")) {
			model.addAttribute("msg", "댓글이 달린 게시글은 삭제하실 수 없습니다..");
			model.addAttribute("url", "reviews/reviewsContent?idx="+flag);
		}
		else if(msgFlag.equals("subscribeBucketOK")) {
			model.addAttribute("msg", "장바구니에 상품이 담겼습니다.");
			model.addAttribute("url", "subscribe/subscribeProduct?idx="+flag);
		}
		else if(msgFlag.equals("ordersBucketOK")) {
			model.addAttribute("msg", "장바구니에 상품이 담겼습니다.");
			model.addAttribute("url", "orders/ordersProduct?idx="+flag);
		}
		else if(msgFlag.equals("refundDeleteNO")) {
			model.addAttribute("msg", "진행 중인 환불신청건이 있습니다.");
			model.addAttribute("url", "refund/refundDelete?del="+flag);
		}
		else if(msgFlag.equals("serveyInput")) {
			model.addAttribute("msg", "설문조사를 등록했습니다.");
			model.addAttribute("url", "admin/servey/adminServeyUpdate?idx="+flag);
		}
		else if(msgFlag.equals("serveyUpdateOK")) {
			model.addAttribute("msg", "설문조사 정보를 수정하였습니다.");
			model.addAttribute("url", "admin/servey/adminServeyUpdate?idx="+flag);
		}
		else if(msgFlag.equals("memberEmailNo")) {
			model.addAttribute("msg", "이미 존재하는 이메일입니다.");
			model.addAttribute("url", "member/memberJoin");
		}
		else if(msgFlag.equals("memberComEmailNo")) {
			model.addAttribute("msg", "이미 존재하는 이메일입니다.");
			model.addAttribute("url", "member/memberComJoin");
		}
		
		
		
		
		
		
		
		
		
		return "/include/message";
	}
}
