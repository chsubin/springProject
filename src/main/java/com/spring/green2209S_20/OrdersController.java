package com.spring.green2209S_20;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mysql.fabric.xmlrpc.base.Array;
import com.spring.green2209S_20.pagenation.PageProcess;
import com.spring.green2209S_20.pagenation.PageVO;
import com.spring.green2209S_20.service.AdminService;
import com.spring.green2209S_20.service.MemberService;
import com.spring.green2209S_20.service.OrdersService;
import com.spring.green2209S_20.service.SubscribeService;
import com.spring.green2209S_20.vo.BasisVO;
import com.spring.green2209S_20.vo.BucketVO;
import com.spring.green2209S_20.vo.CategorySmallVO;
import com.spring.green2209S_20.vo.CouponsVO;
import com.spring.green2209S_20.vo.DBoptionVO;
import com.spring.green2209S_20.vo.MemberVO;
import com.spring.green2209S_20.vo.ProductVO;

@Controller
@RequestMapping("/orders")
public class OrdersController {

	@Autowired
	OrdersService ordersService;
	@Autowired
	AdminService adminService;
	
	@Autowired
	PageProcess pageProcess;
	
	@Autowired
	SubscribeService subscribeService;
	
	@Autowired
	MemberService memberService;
	
	//메인메뉴
	@RequestMapping(value="/ordersMain",method=RequestMethod.GET)
	public String ordersMainGet(Model model,
			@RequestParam(name="codeSmall",defaultValue = "0" ,required = false)int codeSmall,
			@RequestParam(name="pag",defaultValue = "1" ,required = false)int pag,
			@RequestParam(name="orderBy",defaultValue = "" ,required = false)String orderBy
			) {
		List<CategorySmallVO> categoryVos =ordersService.getSmallCategoryList(2);
		
		for(CategorySmallVO cateVo:categoryVos) {
			if(cateVo.getCodeSmall()==codeSmall) {
				model.addAttribute("cateVo", cateVo);
			}
		}
		
		PageVO pageVo = pageProcess.totRecCnt(pag, 12, "product", 2, codeSmall, "", "");
		ArrayList<ProductVO> vos = ordersService.getProductList(2,codeSmall,pageVo.getStartIndexNo(),pageVo.getPageSize(),orderBy);
		
		model.addAttribute("categoryVos", categoryVos);
		model.addAttribute("codeSmall", codeSmall);
		model.addAttribute("pageVo", pageVo);
		model.addAttribute("vos", vos);
		model.addAttribute("orderBy", orderBy);
		
		return "orders/ordersMain";
	}
	
	@RequestMapping(value="/ordersProduct", method = RequestMethod.GET)
	public String ordersProductGet(int idx,Model model,HttpSession session){
		ProductVO vo = ordersService.getProduct(idx);
		
		ArrayList<ProductVO> vos =  
				(ArrayList<ProductVO>) session.getAttribute("sProductVos")==null?
						new ArrayList<ProductVO>():(ArrayList<ProductVO>) session.getAttribute("sProductVos");
		
		vo.setFlag("orders");
		vos.add(vo);
		
		for (int i=0;i<vos.size()-1;i++) {
			if(vos.get(i).getIdx()==vo.getIdx()) {
				vos.remove(i);
			}
		}
		if(vos.size()>4) {
			vos.remove(0);
		}
		session.setAttribute("sProductCnt", vos.size());
		session.setAttribute("sProductVos", vos);
		
		List<DBoptionVO> optionVos = ordersService.getOptionList(idx);
		model.addAttribute("vo", vo);
		model.addAttribute("optionVos", optionVos);
		
		BasisVO basisVo = adminService.getBasis();
		model.addAttribute("basisVo", basisVo);
		
		return "orders/ordersProduct";
	}
	@RequestMapping(value="/ordersProduct", method = RequestMethod.POST)
	public String ordersProductPost(BucketVO vo,int subSw,Model model,HttpSession session,
			@RequestParam(name="optionIdxs",defaultValue = "" ,required = false) String optionIdxs,
			@RequestParam(name="optionNums",defaultValue = "0" ,required = false) String optionNums,
			@RequestParam(name="optionPrices",defaultValue = "0" ,required = false) String optionPrices
			){

		if(subSw==1) {  //장바구니
			String [] arrIdx = optionIdxs.split(",");
			String [] arrNum= optionNums.split(",");
			String [] arrPrices= optionPrices.split(",");
			ProductVO proVo = ordersService.getProduct(vo.getProductIdx());
			vo.setCodeLarge(proVo.getCodeLarge());
			vo.setCodeSmall(proVo.getCodeSmall());
			vo.setSellSw(proVo.getSellSw());
			for(int i=0;i<arrIdx.length;i++) {
				if(!arrNum[i].equals("0")) {
					vo.setOptionIdx(Integer.parseInt(arrIdx[i]));
					vo.setOptionNum(Integer.parseInt(arrNum[i]));
					vo.setTotalPrice((Integer.parseInt(arrPrices[i])+proVo.getPrice())*Integer.parseInt(arrNum[i]));
					vo.setOptionDetail("");
					vo.setSubSw("");
					BucketVO bucketVo = ordersService.getBucketList(vo);
					if(bucketVo==null) { //없을때
						ordersService.setProductBucket(vo);
					}
					else { //있으면 더해야함!!
						ordersService.setBucketUpdate(vo);
					}
				}
			}
		}
		else { //결제창(바로결제)
			ArrayList<BucketVO> vos = new ArrayList<BucketVO>();
			BucketVO bucketVo;
			
			String [] arrIdx = optionIdxs.split(",");
			String [] arrNum= optionNums.split(",");
			String [] arrPrices= optionPrices.split(",");
			ProductVO proVo = ordersService.getProduct(vo.getProductIdx());
			
			vo.setCodeLarge(proVo.getCodeLarge());
			vo.setCodeSmall(proVo.getCodeSmall());
			BasisVO basisVo = adminService.getBasis();
			model.addAttribute("basisVo", basisVo);
			int sumOfPrice=0;
			int sumOfOptionNum=0;
			int sub=0;
			int subPrice=0;
			
			for(int i=0;i<arrIdx.length;i++) {
				if(!arrNum[i].equals("0")) {
					DBoptionVO optionVo = ordersService.getOption(Integer.parseInt(arrIdx[i]));
					bucketVo = new BucketVO();
					bucketVo.setIdx(0);
					bucketVo.setName(proVo.getName());
					bucketVo.setProductIdx(vo.getProductIdx());
					bucketVo.setCodeLarge(bucketVo.getCodeLarge());
					bucketVo.setCodeSmall(bucketVo.getCodeSmall());
					bucketVo.setOptionIdx(Integer.parseInt(arrIdx[i]));
					bucketVo.setOptionNum(Integer.parseInt(arrNum[i]));
					bucketVo.setOptionPrice(Integer.parseInt(optionVo.getOptionPrice()));
					bucketVo.setTotalPrice((Integer.parseInt(arrPrices[i])+proVo.getPrice())*Integer.parseInt(arrNum[i]));
					bucketVo.setOptionDetail("");
					bucketVo.setSubSw("");
					bucketVo.setFSName(proVo.getFSName());
					bucketVo.setSellSw(proVo.getSellSw());
					bucketVo.setOptionName(optionVo.getOptionName());
					vos.add(bucketVo);
					
					sumOfPrice+=bucketVo.getTotalPrice();
					sumOfOptionNum+=bucketVo.getOptionNum();
					if(bucketVo.getCodeLarge()==1) {
						subPrice+= bucketVo.getTotalPrice();
						sub+= bucketVo.getOptionNum();
					}
				}
			}
			String sMid = session.getAttribute("sMid")==null?"":(String)session.getAttribute("sMid");
			if(!sMid.equals("")) {
				MemberVO memberVO =memberService.memberLoginCheck(sMid);
				model.addAttribute("vo",memberVO);
				model.addAttribute("point", memberVO.getPoint());
			}

			model.addAttribute("sub", sub);
			model.addAttribute("subPrice", subPrice);
			model.addAttribute("sumOfPrice", sumOfPrice);
			model.addAttribute("sumOfOptionNum", sumOfOptionNum);
			model.addAttribute("bucketVos", vos);
			model.addAttribute("bucketSw", "0");
			
			session.setAttribute("sVos", vos);
			
			return "member/memberOrders"; //결제창으로 바로 보내기
		}
		return "redirect:/msg/ordersBucketOK?flag="+vo.getProductIdx();
	}
	@ResponseBody
	@RequestMapping(value="/getCoupons",method = RequestMethod.POST, produces="application/text; charset=utf8")
	public String getCouponsPost(String code) {
	 CouponsVO vo = ordersService.getUsableCoupons(code);
	 if(vo==null) return "0";
	 
	 String res = vo.getPrice()+"";
	 
	 return res;
	}
	
	
	@RequestMapping(value="/ordersSearch",method = RequestMethod.GET)
	public String ordersSearchGet() {
		return "orders/ordersSearch";
	}
	@RequestMapping(value="/ordersSearch",method = RequestMethod.POST)
	public String ordersSearchPost(HttpSession session,String orderIdx, String name) {
		session.setAttribute("sOrderIdx",orderIdx);
		session.setAttribute("sName",name);
		
		return "redirect:/member/ordersResult";
	}
	
	
	
}

