package com.spring.green2209S_20;

import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.spring.green2209S_20.pagenation.PageProcess;
import com.spring.green2209S_20.pagenation.PageVO;
import com.spring.green2209S_20.service.AdminService;
import com.spring.green2209S_20.service.BoardService;
import com.spring.green2209S_20.service.CouponsService;
import com.spring.green2209S_20.service.JoinsService;
import com.spring.green2209S_20.service.MemberService;
import com.spring.green2209S_20.service.OrdersService;
import com.spring.green2209S_20.vo.BasisVO;
import com.spring.green2209S_20.vo.BoardVO;
import com.spring.green2209S_20.vo.BucketVO;
import com.spring.green2209S_20.vo.CouponsVO;
import com.spring.green2209S_20.vo.JoinsVO;
import com.spring.green2209S_20.vo.MemberVO;
import com.spring.green2209S_20.vo.OrderSubVO;
import com.spring.green2209S_20.vo.OrdersVO;
import com.spring.green2209S_20.vo.PayMentVO;
import com.spring.green2209S_20.vo.ProductVO;

@Controller
@RequestMapping("/member")
public class MemberController {
	
	@Autowired 
	MemberService memberService;
	
	@Autowired 
	OrdersService ordersService;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@Autowired
	JavaMailSender mailSender;
	
	@Autowired
	AdminService adminService;
	
	@Autowired
	PageProcess pageProcess;
	
	@Autowired
	CouponsService couponsService;
	
	@Autowired
	BoardService boardService;
	
	@Autowired
	JoinsService joinsService;
	
	
	
	@RequestMapping(value="/memberJoin",method=RequestMethod.GET)
	public String memberJoinGet() {
		return "member/memberJoin";
	}
	@RequestMapping(value="/memberComJoin",method=RequestMethod.GET)
	public String memberComJoinGet() {
		return "member/memberComJoin";
	}
	@RequestMapping(value="/memberLogin",method=RequestMethod.GET)
	public String memberLoginGet(HttpServletRequest request) {
		Cookie[] cookies = request.getCookies();
		for(int i=0; i<cookies.length; i++) {
			if(cookies[i].getName().equals("cMid")) {
				request.setAttribute("mid", cookies[i].getValue());
				break;
			}
		}
		return "member/memberLogin";
	}
	@RequestMapping(value="/memberKakaoLogin",method=RequestMethod.POST)
	public String memberKakaoLoginPost(String email,HttpSession session) {
		MemberVO vo = memberService.getMemberFromEmail(email);
		//이메일이 없을때 
		if(vo==null)return "redirect:/member/memberJoin?email="+email;
		else if(vo.getUserDel().equals("OK"))return "redirect:/member/memberJoin?email="+email;

		String strLevel ="";
		if(vo.getLevel()==0) strLevel ="관리자";
		else if(vo.getLevel()==1) strLevel ="운영자";
		else if(vo.getLevel()==2) strLevel ="회원";
		
		session.setAttribute("strLevel", strLevel);
		session.setAttribute("sLevel", vo.getLevel());
		session.setAttribute("sMid", vo.getMid());
		session.setAttribute("kakao", "OK");
		
		return "redirect:/member/memberMain";
	}
	
	@RequestMapping(value="/memberLogin",method=RequestMethod.POST)
	public String memberLoginPost(HttpServletRequest request,HttpServletResponse response,HttpSession session,
			@RequestParam(name="mid",defaultValue = "",required = false) String mid, 
			@RequestParam(name="pwd",defaultValue = "",required = false) String pwd, 
			@RequestParam(name="idCheck",defaultValue = "",required = false) String idCheck) {

		MemberVO vo = memberService.memberLoginCheck(mid);
		
		if(vo!=null) {
			if(passwordEncoder.matches(pwd, vo.getPwd())&&vo.getUserDel().equals("NO")) {
				//회원 인증처리된 경우 수행할 내용?strLevel처리, session 에 필요한 자료를 저장, 쿠키값처리,그날 방문자수 1증가(방문포인트도 증가),...
				String strLevel ="";
				if(vo.getLevel()==0) strLevel ="관리자";
				else if(vo.getLevel()==1) strLevel ="운영자";
				else if(vo.getLevel()==2) strLevel ="회원";
				
				session.setAttribute("strLevel", strLevel);
				session.setAttribute("sLevel", vo.getLevel());
				session.setAttribute("sMid", mid);
				
				if(!idCheck.equals("")) { //쿠키처리
					Cookie cookie = new Cookie("cMid", mid);
					cookie.setMaxAge(60*60*24*7);
					response.addCookie(cookie);
				}
				else {
					Cookie[] cookies = request.getCookies();
					for(int i=0;i<cookies.length;i++) {
						if(cookies[i].getName().equals("cMid")) {
							cookies[i].setMaxAge(0);
							response.addCookie(cookies[i]);
							break;
						}
					}
				}
				memberService.setLastDateUpdate(mid);
				if(vo.getLevel()<=1) {
					vo = memberService.memberLoginCheck(mid);
					session.setAttribute("sTime",vo.getLastDate());
				}
				
				return "redirect:/msg/memberLoginOk?mid="+mid;
			}
			else {
				return "redirect:/msg/memberLoginNo";
			}
		}
		return "redirect:/msg/memberLoginNo";
	}
	
	@ResponseBody
	@RequestMapping(value="/memberIdCheck",method=RequestMethod.POST)
	public String memberIdCheckPost(@RequestParam(name="mid", defaultValue = "")  String mid) {
		String res="0";
		if(!mid.equals("")) {
			res = memberService.memberIdCheck(mid);
		}
		return res;
	}
	@RequestMapping(value="/memberJoin",method=RequestMethod.POST)
	public String memberJoinPost(MemberVO vo) {
		if(memberService.getMemberFromEmail(vo.getEmail())!=null) {
			return "redirect:/msg/memberEmailNo";
		}
		
		if(vo.getReceiveSw()==null) vo.setReceiveSw("NO");
		vo.setLevel(2);
		vo.setPwd(passwordEncoder.encode(vo.getPwd()));
		int res= memberService.setMemberJoin(vo);
		if(res==0) return "redirect:/msg/memberJoinNo";
		else return "redirect:/msg/memberJoinOk";
	}
	@RequestMapping(value="/memberComJoin",method=RequestMethod.POST)
	public String memberComJoinPost(MemberVO vo) {
		if(memberService.getMemberFromEmail(vo.getEmail())!=null) {
			return "redirect:/msg/memberComEmailNo";
		}
		
		if(vo.getReceiveSw()==null) vo.setReceiveSw("NO");
		vo.setLevel(3);
		vo.setPwd(passwordEncoder.encode(vo.getPwd()));
		int res= memberService.setMemberJoin(vo);
		if(res==0) return "redirect:/msg/memberJoinNo";
		else return "redirect:/msg/memberJoinOk";
	}
	@RequestMapping(value="/memberMain",method=RequestMethod.GET)
	public String memberMain(HttpSession session,Model model) {
		String mid = session.getAttribute("sMid")==null?"":(String)session.getAttribute("sMid");
		
		MemberVO vo =  memberService.memberLoginCheck(mid);
		model.addAttribute("vo", vo);
		
	 PageVO orderPageVO= pageProcess.totRecCnt(1, 3, "orders",0 , 99, "mid", mid);
	 List<OrdersVO> orderVos= ordersService.getOrdersList(orderPageVO.getStartIndexNo(), 3, 99, "mid", mid);
	 
	 model.addAttribute("ordersVos", orderVos);
	 PageVO subPageVo = pageProcess.totRecCnt(1, 5, "subscribe", 1, 99, "mid", mid);
	 List<OrdersVO> subVos = ordersService.getSubsList(subPageVo.getStartIndexNo() , subPageVo.getPageSize(), "OK", 99, "mid", mid);
	 model.addAttribute("subVos", subVos);
	 
		return "member/memberMain";
	}
	@RequestMapping(value="/memberUpdate",method=RequestMethod.GET)
	public String memberUpdateGet(HttpSession session,Model model) {
		String mid = session.getAttribute("sMid")==null?"":(String)session.getAttribute("sMid");
		
		MemberVO vo =  memberService.memberLoginCheck(mid);
		model.addAttribute("vo", vo);
		return "member/memberUpdate";
	}
	@RequestMapping(value="/memberUpdate",method=RequestMethod.POST)
	public String memberUpdatePost(MemberVO vo) {
		if(vo.getReceiveSw()==null) {
			vo.setReceiveSw("NO");
		}
		
		memberService.setMemberUpdate(vo);
		
		return "redirect:/msg/memberUpdateOK";
	}
	@RequestMapping(value="/memberOrderList",method=RequestMethod.GET)
	public String memberOrderList(HttpSession session,Model model,
			@RequestParam(name="pag",defaultValue = "1")int pag,
			@RequestParam(name="pageSize",defaultValue = "5")int pageSize
			) {
		String mid = session.getAttribute("sMid")==null?"":(String)session.getAttribute("sMid");
		PageVO pageVo = pageProcess.totRecCnt(pag, pageSize, "orders", 1, 99, "mid", mid);
		List<OrdersVO> orderVos = ordersService.getOrdersList(pageVo.getStartIndexNo(),pageVo.getPageSize(),99,"mid",mid);
		MemberVO vo =  memberService.memberLoginCheck(mid);
		model.addAttribute("ordersVos", orderVos);
		model.addAttribute("vo", vo);
		model.addAttribute("pageVo", pageVo);
		return "member/memberOrderList";
	}
	@RequestMapping(value="/memberSubList",method=RequestMethod.GET)
	public String memberSubList(HttpSession session,Model model,
			@RequestParam(name="pag",defaultValue = "1")int pag,
			@RequestParam(name="pageSize",defaultValue = "5")int pageSize
			) {
		String mid = session.getAttribute("sMid")==null?"":(String)session.getAttribute("sMid");
		PageVO pageVo = pageProcess.totRecCnt(pag, pageSize, "subscribe", 1, 99, "mid", mid);
		List<OrdersVO> orderVos = ordersService.getSubsList(pageVo.getStartIndexNo(),pageVo.getPageSize(),"OK",99,"mid",mid);
		MemberVO vo =  memberService.memberLoginCheck(mid);
		model.addAttribute("ordersVos", orderVos);
		model.addAttribute("vo", vo);
		model.addAttribute("pageVo", pageVo);
		return "member/memberSubList";
	}
	@RequestMapping(value="/memberLogout", method = RequestMethod.GET)
	public String memberLogoutGet(HttpSession session) {
		String mid = session.getAttribute("sMid")==null?"":(String)session.getAttribute("sMid");
		
		if(session.getAttribute("kakao")!=null) {
			session.invalidate();
			return "member/kakaoLogout";
		}
		session.invalidate();
		
		return "redirect:/msg/memberLogout?mid="+mid;
	}
	@RequestMapping(value="/memberBucket", method = RequestMethod.GET)
	public String memberBucketGet(HttpSession session,Model model) {
		String mid = session.getAttribute("sMid")==null?"":(String)session.getAttribute("sMid");
		List<BucketVO> vos = memberService.getMemberBucket(mid);
		int sumOfPrice=0;
		int sumOfOptionNum=0;
		int sub=0;
		int subPrice=0;
		for(BucketVO vo : vos) {
			sumOfPrice+=vo.getTotalPrice();
			sumOfOptionNum+=vo.getOptionNum();
			if(vo.getCodeLarge()==1) {
				subPrice+= vo.getTotalPrice();
				sub+= vo.getOptionNum();
			}
		}
		BasisVO basisVo = adminService.getBasis();
		
		model.addAttribute("basisVo", basisVo);
		model.addAttribute("sub", sub);
		model.addAttribute("subPrice", subPrice);
		model.addAttribute("sumOfPrice", sumOfPrice);
		model.addAttribute("sumOfOptionNum", sumOfOptionNum);
		
		model.addAttribute("vos", vos);
		return "member/memberBucket";
	}
	@RequestMapping(value="/deleteBucket", method = RequestMethod.POST)
	public String memberdeleteBucketPost(String deleteboxes) {
		if(deleteboxes.contains("/")) {
			
			deleteboxes= deleteboxes.substring(0,deleteboxes.length()-1);
			
			String [] arr = deleteboxes.split("/");
			for(int i=0;i<arr.length;i++) {
				memberService.setBucketDelete(Integer.parseInt(arr[i]));
			}
		}
		else {
			memberService.setBucketDelete(Integer.parseInt(deleteboxes));
		}
		
		return "member/deleteBucket";
	}
	
	@RequestMapping(value="/updateBucket",method=RequestMethod.POST)
	public String updateBucketPost(int idx,int price,int buho) {
		memberService.bucketUpdate(idx,price,buho);
		return "";
	}
	
	
	@RequestMapping(value="/memberIdSearch",method = RequestMethod.GET)
	public String memberIdSearchGet() {
		return "member/memberIdSearch";
	}
	@RequestMapping(value="/memberIdSearch",method = RequestMethod.POST)
	public String memberIdSearchPost(String imsiMid,Model model) {
		model.addAttribute("imsiMid", imsiMid);
		return "redirect:/member/memberImsiPwdUpdate";
	}
	@RequestMapping(value="/memberImsiPwdUpdate",method = RequestMethod.POST)
	public String memberImsiPwdUpdatePost() {
		return "member/memberImsiPwdUpdate";
	}
	@ResponseBody
	@RequestMapping(value="/memberMidSearch",method = RequestMethod.POST)
	public String membermemberMidSearchPost(String name,String email) {
		String res="";
		MemberVO vo = memberService.getMemberMidSearch(name,email);
		if(vo!=null) {
			String mid=vo.getMid();
	  	int i = (int) (Math.random()*mid.length());
	  	int j = (int) (Math.random()*mid.length());
	  	int k = (int) (Math.random()*mid.length());
	  	String arrayMid [] = mid.split("");
	  	String strMid="";
	  	for(int x=0;x<mid.length();x++) {
	  		if(x==i) {
	  			strMid+="*";
	  		}
	  		else if(x==j) {
	  			strMid+="*";
	  		}
	  		else if(x==k) {
	  			strMid+="*";
	  		}
	  		else {
	  			strMid+=arrayMid[x];
	  		}
	  	}
	  	
	  	res=strMid;
		
		}
		else res="0";
		return res;
	}
	@ResponseBody
	@RequestMapping(value="/memberPwdSearch",method = RequestMethod.POST)
	public String membermemberPwdSearchPost(String mid,String email,HttpSession session) {
		String res="0";
		MemberVO vo = memberService.memberLoginCheck(mid);
		if(vo!=null) {
			if(vo.getEmail().equals(email)) { //메일보내야함.
				// 회원정보가 맞다면 인증번호를 발급받는다.
				UUID uid = UUID.randomUUID();
				String pwd = uid.toString().substring(0,8);
				
				session.setAttribute("sImsiPwd", pwd);
				session.setAttribute("sImsiMid", mid);
				String content = pwd;
				
				//임시비밀번호를 메일로 전송처리 한다.
				res = mailSend(email,content);
				
			}
		}
		return res;
	}
	public String mailSend(String toMail, String content) {
		try {
			String title = "인증 코드가 발급되었습니다.";
			
			// 메일을 전송하기 위한 객체 : MimeMessage, MimeMessageHelper()
			MimeMessage message = mailSender.createMimeMessage(); 
			MimeMessageHelper messageHelper = new MimeMessageHelper(message,true , "UTF-8"); //보관함
			
			//메일보관함에 회원이 보내온 메시지들을 모두 저장시킨다.
			messageHelper.setTo(toMail);
			messageHelper.setSubject(title);
			messageHelper.setText(content);
			
			//메세지 보관함의 내용(content)에 필요한 정보를 추가로 담아서 전송시킬 수 있도록 한다.
			//content = content.replace("\n", "<br/>");
			content = "<br><hr><h3>인증번호는 <font color='red'>"+content+"</font>입니다.</h3><hr><br>";
			content += "<br>인증코드 입력 후 비밀번호를 변경하시기 바랍니다.<br>";
			content += "<p>방문하기 : <a href='http://49.142.157.251:9090/green2209S_20/'>리얼후르츠</a></p>";
			content += "<p><img src=\"cid:main.jpg\"></p>";
			content += "<hr>";
			messageHelper.setText(content,true);
			
			//본문에 기재된 그림파일의 경로를 따로 표시시켜준다. 그리고, 보관함에 다시 저장시켜준다.
			HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
			String realPath = request.getRealPath("resources/images/logo-1.png");
			FileSystemResource file = new FileSystemResource(realPath);
			messageHelper.addInline("main.jpg", file);
			
			//메일 전송하기
			mailSender.send(message);
			return "1";
			
		} catch (MessagingException e) { //메일센더때문에 오류가 발생
			e.printStackTrace();
		}
		return "0";
	}
	@RequestMapping(value="/memberPwdUpdate",method = RequestMethod.GET)
	public String memberPwdUpdateGet() {
		return "member/memberPwdUpdate";
	}
	@RequestMapping(value="/memberPwdUpdate",method = RequestMethod.POST)
	public String memberPwdUpdatePost(String mid,String oldPwd,String newPwd ) {
	  MemberVO origVo =  memberService.memberLoginCheck(mid);
	  if(!passwordEncoder.matches(oldPwd,origVo.getPwd())){
	  	return "redirect:/msg/pwdUpdateNo";
	  }
	  oldPwd= passwordEncoder.encode(oldPwd);
	  newPwd = passwordEncoder.encode(newPwd);
	  memberService.setMemberPwdUpdate(mid, newPwd);
		return "redirect:/msg/pwdUpdateOk";
	}
  @RequestMapping(value="/memberImsiPwdUpdates",method = RequestMethod.POST)
  public String memberImsiPwdUpdatePost(String mid,String newPwd ) { 
  	newPwd = passwordEncoder.encode(newPwd);
  	memberService.setMemberPwdUpdate(mid,newPwd);
  return "redirect:/msg/pwdImsiUpdateOk";
  }
  
  @RequestMapping(value="/memberOrders",method = RequestMethod.GET)
  public String memberOrdersGet(HttpSession session,Model model,
  		@RequestParam(name="sw", defaultValue ="" ,required=false) String sw
  		) { 
  	String mid =(String)session.getAttribute("sMid")==null?"":(String)session.getAttribute("sMid");
  	List<BucketVO> bucketVos = memberService.getMemberBucket(mid);
  	MemberVO vo = memberService.memberLoginCheck(mid);
  	
  	if(!mid.equals("")) {
  		MemberVO memVo =  memberService.memberLoginCheck(mid);
  		model.addAttribute("point", memVo.getPoint());
  	}	
  	
		int sumOfPrice=0;
		int sumOfOptionNum=0;
		int sub=0;
		int subPrice=0;
		for(BucketVO bucketVo : bucketVos) {
			sumOfPrice+=bucketVo.getTotalPrice();
			sumOfOptionNum+=bucketVo.getOptionNum();
			if(bucketVo.getCodeLarge()==1) {
				subPrice+= bucketVo.getTotalPrice();
				sub+= bucketVo.getOptionNum();
			}
		}
		model.addAttribute("sub", sub);
		model.addAttribute("subPrice", subPrice);
		model.addAttribute("sumOfPrice", sumOfPrice);
		model.addAttribute("sumOfOptionNum", sumOfOptionNum);
		
  	BasisVO basisVo = adminService.getBasis();
  	model.addAttribute("basisVo", basisVo);
  	
  	model.addAttribute("vo", vo);
  	model.addAttribute("bucketSw", "1");
		
		if(sw.equals("")) {
			model.addAttribute("bucketVos",session.getAttribute("sVos"));
		}
		else {
			model.addAttribute("bucketVos", bucketVos);
		}
  	return "member/memberOrders";
  }
  //결제가기전
  @Transactional
  @RequestMapping(value="/ordersOk",method = RequestMethod.POST)
  	public String memberOrdersOkPost(OrdersVO vo,HttpSession session, Model model, 
  		@RequestParam(name="products",defaultValue = "",required = false) String products,
  		@RequestParam(name="bucketSw",defaultValue = "0",required = false) int bucketSw,
  		@RequestParam(name="code",defaultValue = "",required = false) String code,
  		@RequestParam(name="usepoint",defaultValue = "0",required = false) int point
	  		) {
  	PayMentVO paymentVo = new PayMentVO();
  	paymentVo.setName("리얼후르츠");
  	paymentVo.setBuyer_name(vo.getName());
  	paymentVo.setBuyer_email(vo.getEmail());
  	paymentVo.setBuyer_tel(vo.getTel());
  	paymentVo.setBuyer_addr(vo.getAddress().substring(7, vo.getAddress().length()));
  	paymentVo.setBuyer_postcode(vo.getAddress().substring(0,5));
  	
  	int priceSum=0; //총결제금액
  	
		BasisVO basisVo = adminService.getBasis();
  	
		Date date = new Date();
		String str=  "g"+date.getTime();
		vo.setIdx(1);
		String mid = vo.getMid()==null?"":vo.getMid();
		paymentVo.setMerchant_uid(str);
		
		if(bucketSw==0) { //바로구매
			String [] product = products.split(",");
			for(int i=0;i<product.length;i++) {
				OrdersVO orderVo = new OrdersVO();
				 String [] pro =product[i].split("/");
				 orderVo.setIdx(0);
				 orderVo.setOrderIdx(str);
				 orderVo.setMid(mid);
				 orderVo.setName(vo.getName());
				 orderVo.setEmail(vo.getEmail());
				 orderVo.setAddress(vo.getAddress());
				 orderVo.setTel(vo.getTel());
				 orderVo.setProductIdx(Integer.parseInt(pro[0]));
				 ProductVO productVo = ordersService.getProduct(Integer.parseInt(pro[0]));
				 if(productVo.getSellSw().equals("NO")) {
					 return "redirect:/msg/sellSwNo";
				 }
				 orderVo.setOptionIdx(Integer.parseInt(pro[1]));
				 orderVo.setOptionNum(Integer.parseInt(pro[2]));
				 orderVo.setOptionDetail(pro[3].substring(0,pro[3].length()-1));
				 orderVo.setTotalPrice(Integer.parseInt(pro[4]));
				 orderVo.setOrderSw(0);
				 ordersService.setOrders(orderVo);
				 priceSum+=orderVo.getTotalPrice();
				 
				 if(orderVo.getOptionDetail().equals("")) {
					 session.setAttribute("sFlag", "orders");
				 }
				 else {
					 session.setAttribute("sFlag", "subscribe");
				 }
				 session.setAttribute("sIdx", orderVo.getProductIdx());
				 
			}
			//통합 주문정보 저장
			OrderSubVO subVO = new OrderSubVO();
			subVO.setOIdx(str);
			subVO.setDeliveryPrice(0);
			subVO.setPoint(0);
			subVO.setCouponIdx(0);
			
			if(priceSum<basisVo.getDeliveryMinPrice()) {
				priceSum+=basisVo.getDeliveryPrice();
				subVO.setDeliveryPrice(basisVo.getDeliveryPrice());
			}
			if(!code.equals("")) {
				CouponsVO cVo = ordersService.getUsableCoupons(code);
			 	priceSum-= cVo.getPrice();
			 	subVO.setCouponIdx(cVo.getIdx());
			}
			if(point!=0) {
				priceSum-= point;
				subVO.setPoint(point);
			}
			subVO.setTotalPrice(priceSum);
			ordersService.setOrderSub(subVO);
			
		}
		else { //장바구니 구매
			List<BucketVO> vos = memberService.getMemberBucket(mid);
			for(BucketVO bucketVo:vos) {
				vo.setOrderIdx(str);
				vo.setProductIdx(bucketVo.getProductIdx());
				
				ProductVO productVo = ordersService.getProduct(vo.getProductIdx());
				if(productVo.getSellSw().equals("NO")) {
					return "redirect:/msg/sellSwNo";
				}
				
				vo.setOptionIdx(bucketVo.getOptionIdx());
				vo.setOptionNum(bucketVo.getOptionNum());
				vo.setOptionDetail(bucketVo.getOptionDetail());
				vo.setTotalPrice(bucketVo.getTotalPrice());
				vo.setOrderSw(0);
				ordersService.setOrders(vo);
				priceSum+=vo.getTotalPrice();
			}
			//통합 주문정보 저장
			OrderSubVO subVO = new OrderSubVO();
			subVO.setOIdx(str);
			subVO.setDeliveryPrice(0);
			subVO.setPoint(0);
			subVO.setCouponIdx(0);
			
			if(priceSum<basisVo.getDeliveryMinPrice()) {
				priceSum+=basisVo.getDeliveryPrice();
				subVO.setDeliveryPrice(basisVo.getDeliveryPrice());
			}
			if(!code.equals("")) {
				CouponsVO cVo = ordersService.getUsableCoupons(code);
			 	priceSum-= cVo.getPrice();
			 	subVO.setCouponIdx(cVo.getIdx());
			}
			if(point!=0) {
				priceSum-= point;
				subVO.setPoint(point);
			}
			subVO.setTotalPrice(priceSum);
			ordersService.setOrderSub(subVO);
			
			session.removeAttribute("sFlag"); //결제 실패시 보내기 위한 화면
			session.removeAttribute("sIdx");
		}
		
		paymentVo.setAmount(priceSum);
		paymentVo.setPaid_amount(String.valueOf(priceSum));
		session.setAttribute("sPayMentVO", paymentVo);
		model.addAttribute("vo", paymentVo);
		model.addAttribute("idx", vo.getIdx());
		
		
		
  	return "orders/sample";
  }
  
  @RequestMapping(value="/ordersResult",method = RequestMethod.POST)
  public String ordersResultPost(Model model,HttpSession session,
  		@RequestParam(name="orderIdx",defaultValue = "",required = false) String orderidx
  		) {
		PayMentVO vo = (PayMentVO) session.getAttribute("sPayMentVO");
		model.addAttribute("vo", vo);
		String mid= session.getAttribute("sMid")==null?"":String.valueOf(session.getAttribute("sMid"));
		String orderIdx = vo.getMerchant_uid();
		
		int point= (int) ( vo.getAmount() *0.01);
		memberService.setMemberPointUpdate(point,mid);
		ordersService.setOrdersUpdateSw(orderIdx);
		ordersService.setBucketDelete(mid);
		List<OrdersVO> orderVos = ordersService.getOrders(orderIdx);
		OrderSubVO subVo = ordersService.getOrderSub(orderIdx);
		if(subVo.getPoint()>0) {
			memberService.setMemberPointUpdate(-subVo.getPoint(), mid);
		}
		if(subVo.getCouponIdx()!=0) {
			couponsService.setCouponUpdate(subVo.getCouponIdx());
		}
		
		OrdersVO ovo = orderVos.get(0);
		
		model.addAttribute("orderVos", orderVos);
		model.addAttribute("subVo", subVo);
		model.addAttribute("ovo", ovo);
		
		session.removeAttribute("sPayMentVO");
  	
  	return "orders/ordersResult";
  }
  @RequestMapping(value="/ordersResult",method = RequestMethod.GET)
  public String ordersResultGet(Model model,HttpSession session,
  		@RequestParam(name="orderIdx",defaultValue = "",required = false) String orderIdx) {
  	
  		if(!orderIdx.equals("")) {
	  		List<OrdersVO> orderVos = ordersService.getOrders(orderIdx);
	  		model.addAttribute("orderVos", orderVos);
	  		OrderSubVO subVo = ordersService.getOrderSub(orderIdx);
	  		model.addAttribute("subVo", subVo);
	  		
	  		String mid = session.getAttribute("sMid")==null?"": (String)session.getAttribute("sMid");
	  		int level = session.getAttribute("sLevel")==null?99: Integer.parseInt(String.valueOf(session.getAttribute("sLevel")));
	  		if((!orderVos.get(0).getMid().equals(mid)||orderVos.size()==0)&&level>=2)return "redirect:/msg/midMatchNo";
	  		
	  		OrdersVO ovo = orderVos.get(0);
	  		model.addAttribute("ovo", ovo);
  		}
  		else {
  			orderIdx = (String)session.getAttribute("sOrderIdx")==null?"":(String)session.getAttribute("sOrderIdx");
  			String name = (String)session.getAttribute("sName")==null?"":(String)session.getAttribute("sName");
  			
  			if(orderIdx.equals("")) return "redirect:/msg/midMatchNo";
  			
	  		List<OrdersVO> orderVos = ordersService.getOrders(orderIdx);
	  		model.addAttribute("orderVos", orderVos);
	  		OrderSubVO subVo = ordersService.getOrderSub(orderIdx);
	  		model.addAttribute("subVo", subVo);
	  		session.removeAttribute("sOrderIdx");
	  		session.removeAttribute("sName");
	  		
	  		if(!orderVos.get(0).getName().equals(name)||orderVos.size()==0)return "redirect:/msg/nameMatchNo";
	  		
	  		OrdersVO ovo = orderVos.get(0);
	  		model.addAttribute("ovo", ovo);
	  		
  		}
  	return"orders/ordersResult";
  }
  @RequestMapping(value="/memberDelete",method = RequestMethod.POST)
  public String memberDeletePost(HttpSession session) {
  	String mid = session.getAttribute("sMid")==null?"": (String)session.getAttribute("sMid");
  	memberService.setMemberDelete(mid);
  	session.invalidate();
  	return "redirect:/msg/memberDeleteOK";
  }
	@RequestMapping(value="/memberReviewsList",method=RequestMethod.GET)
	public String memberReviewsList(HttpSession session,Model model,
			@RequestParam(name="pag",defaultValue = "1")int pag,
			@RequestParam(name="pageSize",defaultValue = "5")int pageSize
			) {
		String mid= (String)session.getAttribute("sMid");
		PageVO pageVo = pageProcess.totRecCnt(pag, pageSize, "board", 9, 0, "b.mid", mid);
		List<BoardVO> reviewsVos = boardService.getboardListSw(pageVo.getStartIndexNo(),pageSize,9,"b.mid",mid);
		
		MemberVO vo =  memberService.memberLoginCheck(mid);
		model.addAttribute("pageVo", pageVo);
		model.addAttribute("vo", vo);
		model.addAttribute("reviewsVos", reviewsVos);
		return "member/memberReviewsList";
	}
	@RequestMapping(value="/memberJoinsApply" ,method = RequestMethod.GET)
	public String memberJoinsApplyGet(Model model,HttpSession session,
			@RequestParam(name="pag",defaultValue = "1")int pag,
			@RequestParam(name="pageSize",defaultValue = "10")int pageSize
			) {
		String sMid = session.getAttribute("sMid")==null?"":(String)session.getAttribute("sMid");
		PageVO pageVo = pageProcess.totRecCnt(pag, pageSize, "joins", 99, 0, "sMid", sMid);
		List<JoinsVO> vos = joinsService.getJoinsList(pageVo.getStartIndexNo(),pageSize,99,"sMid",sMid);
		model.addAttribute("vos",vos);
		model.addAttribute("pageVo", pageVo);
		
		return "member/memberJoinsApply";
	}
	@ResponseBody
	@RequestMapping(value="/getCoupons",method = RequestMethod.POST, produces="application/text; charset=utf8")
	public String getCouponsPost(String code) {
		CouponsVO vo1 = couponsService.getCoupon(code);
		if(vo1==null) return "1";
		CouponsVO vo = ordersService.getUsableCoupons(code);
		 if(vo==null) return "0";
		 
		 String res = vo.getPrice()+"/"+vo.getStartDate()+"/"+vo.getLastDate()+"/"+vo.getName();
		 
		 return res;
	}
	
	@RequestMapping(value="/memberFlag")
	public String memberFlagGet(HttpSession session) {
		String sFlag = session.getAttribute("sFlag")==null?"":(String)session.getAttribute("sFlag");
		
		if(sFlag.equals("")) {
			return "redirect:/member/memberBucket";
		}
		else {
			int sIdx = session.getAttribute("sIdx")==null?0:Integer.parseInt(String.valueOf(session.getAttribute("sIdx")));
			
			return "redirect:/"+sFlag+"/"+sFlag+"Product?idx="+sIdx;
		}
	}
  
  
	 
	
	
}
