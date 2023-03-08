package com.spring.green2209S_20;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.mail.Session;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.green2209S_20.pagenation.PageProcess;
import com.spring.green2209S_20.pagenation.PageVO;
import com.spring.green2209S_20.service.AdminService;
import com.spring.green2209S_20.service.OrdersService;
import com.spring.green2209S_20.service.RefundService;
import com.spring.green2209S_20.vo.BasisVO;
import com.spring.green2209S_20.vo.DBoptionVO;
import com.spring.green2209S_20.vo.OrderSubVO;
import com.spring.green2209S_20.vo.OrdersVO;
import com.spring.green2209S_20.vo.ProductVO;
import com.spring.green2209S_20.vo.RefundVO;

@Controller
@RequestMapping("/refund")
public class RefundController {
	
	@Autowired
	OrdersService ordersService;
	
	@Autowired
	AdminService adminService;
	
	@Autowired
	RefundService refundService;
	
	@Autowired
	PageProcess pageProcess;
	

	@RequestMapping(value="/refundDelete",method = RequestMethod.GET)
	public String ordersDeleteGet(String del,Model model) {
		String dels =del.substring(0, del.length()-1);
		List<OrdersVO> vos= new ArrayList<OrdersVO>();
		OrdersVO vo=null;
		if(dels.contains(",")) {
			for(String delIdx :dels.split(",")) {
				vo = new OrdersVO();
				vo =  ordersService.getOrder(Integer.parseInt(delIdx));
				if(vo!=null) {
				vos.add(vo);
				}
			}
		}
		else {
			vo =  ordersService.getOrder(Integer.parseInt(dels));
			vos.add(vo);
		}
		if(vo==null) {
			vo = new OrdersVO();
			vo =  ordersService.getOrder(Integer.parseInt(dels));
			vos.add(vo);
		}
	 	OrderSubVO subVo = ordersService.getOrderSub(vo.getOrderIdx());
	 	BasisVO basisVo =  adminService.getBasis();
	 	
	 	int tot = subVo.getTotalPrice(); //할인 적용된 가격
	 	int point = subVo.getPoint();
	 	int coupon = subVo.getCouponPrice()==null?0:Integer.parseInt(subVo.getCouponPrice());
	 	int origTot = subVo.getTotalPrice()+point+coupon; //포인트, 쿠폰 할인전 원래 가격
	 	
	 	
	 	int onPoint = 0; //반환포인트
	 	int offPoint = 0; //차감포인트
	 	int productPrice=0; //환불 가격의 합산을 구할 것임.
	 	int realProductPrice=0; //환불 가격의 합산을 구할 것임.
	 	int refundCoupon = subVo.getRefundCoupon(); //여태까지 환불시 사용한 쿠폰 금액
	 	int useableCoupon =subVo.getCouponPrice()==null?0:Integer.parseInt(subVo.getCouponPrice())-refundCoupon;
	 	//현재 환불시 사용할 수 있는 남은 쿠폰 금액
	 	int usingCoupon = 0;
	 	
	 	for(String delIdx :del.split(",")) {
	 		vo =  ordersService.getOrder(Integer.parseInt(delIdx));
	 		DBoptionVO optionVo = ordersService.getOption(vo.getOptionIdx());
	 		ProductVO productVO = ordersService.getProduct(optionVo.getProductIdx());
	 		
	 		productPrice += (Integer.parseInt((optionVo.getOptionPrice()))+productVO.getPrice())*vo.getOptionNum();
	 		realProductPrice += (Integer.parseInt((optionVo.getOptionPrice()))+productVO.getPrice())*vo.getOptionNum(); 
	 		//원래 상품가격
	 	}
	 	productPrice+=subVo.getDeliveryPrice();
	 	if(productPrice>=useableCoupon) { //금액> 남은쿠폰금액
	 		productPrice -= useableCoupon;
	 		usingCoupon=useableCoupon;
	 	}
	 	else { // 금액<쿠폰금액
	 		productPrice =0;
	 		usingCoupon = productPrice;
	 	}
	 	onPoint +=(int)(realProductPrice*point/origTot); //반환포인트 계산
	 	offPoint+= (int)(tot*0.01*(realProductPrice)/origTot); //차감포인트 계산
	// 	offPoint+= (int)((origTot-coupon-point)*0.01); //차감포인트 계산
	 	
	 	model.addAttribute("orderSw", vos.get(0).getOrderSw()); 
	 	
		model.addAttribute("subVo", subVo);//결제 사항
		model.addAttribute("basisVo", basisVo); //배송비
		model.addAttribute("vos", vos); //
		model.addAttribute("onPoint",onPoint);
		model.addAttribute("offPoint",offPoint);
		model.addAttribute("coupon",usingCoupon);
		model.addAttribute("productPrice",( ((int)(productPrice-onPoint)/10))*10 );
		//model.addAttribute("productPrice",(int)(productPrice-onPoint))));
		//(int)(coupon*productPrice/(origTot*100))
		model.addAttribute("orderIdx",vo.getOrderIdx());
		
		
		return "refund/refundDelete";
	}
	

	@RequestMapping(value="/refundDelete",method = RequestMethod.POST)
	public String ordersDeletePost(String delItems,RefundVO vo) {
		String orderIdx = vo.getOrderIdx();
		if(pageProcess.totRecCnt(1, 5, "refund", 1, 0,"", "", "orderIdx", orderIdx).getTotRecCnt()!=0||pageProcess.totRecCnt(1, 5, "refund", 2, 0,"", "", "orderIdx", orderIdx).getTotRecCnt()!=0) {
			return "redirect:/msg/refundDeleteNO?flag="+delItems;
		};
		
		
		String dels =delItems.substring(0, delItems.length()-1);
		
		
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd-");
		
		UUID uid =  UUID.randomUUID();
		
		String code = sdf.format(date)+uid.toString().substring(0,8);
		
		vo.setCode(code);
		
		vo.setOIdxs(dels);
		refundService.setRefundInput(vo);
		
		
		return "refund/refundSuccess";
	}
	@RequestMapping(value="/refundSuccess",method = RequestMethod.GET)
	public String refundSuccessGet() {
		return "refund/refundSuccess";
	}
	
	@RequestMapping(value="/refundList",method = RequestMethod.GET)
	public String refundListGet(HttpSession session,Model model,
			@RequestParam(name="pag",defaultValue = "1")int pag,
			@RequestParam(name="pageSize",defaultValue = "10")int pageSize
			) {
		String mid = session.getAttribute("sMid")==null?"":(String)session.getAttribute("sMid");
		
		PageVO pageVo = pageProcess.totRecCnt(pag, pageSize, "refund",0 , 0, "sMid", mid); //sMid 일때는 정확해야 한다.
		List<RefundVO> vos = refundService.getRefundList(pageVo.getStartIndexNo(),pageVo.getPageSize(),"sMid",mid);
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVo", pageVo);
		
		List<OrdersVO> oVos = new ArrayList<OrdersVO>();
		if(vos.size()!=0) {
			for(RefundVO vo:vos) {
				if(vo.getOIdxs().contains(",")) {
					for(String idxs:vo.getOIdxs().split(",")) {
						oVos.add(ordersService.getOrder(Integer.parseInt(idxs)));
					}
				}
				else {
					oVos.add(ordersService.getOrder(Integer.parseInt(vo.getOIdxs())));
				} 
			}
		}
		model.addAttribute("oVos", oVos);
		return "refund/refundList";
	}
	
	@ResponseBody
	@RequestMapping(value="/refundCancle",method = RequestMethod.POST)
	public String refundCanclePost(String delItems) {
		delItems = delItems.substring(0 , delItems.length()-1);
		
		if(!delItems.contains("/")) {
			for(String del : delItems.split("/")) {
				refundService.setRefundUpdateSw(Integer.parseInt(del),0);
			}
		}
		else {
			refundService.setRefundUpdateSw(Integer.parseInt(delItems),0);
		}
		return "";
	}
	
}
