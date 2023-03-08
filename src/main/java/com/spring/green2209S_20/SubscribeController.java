package com.spring.green2209S_20;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.green2209S_20.pagenation.PageProcess;
import com.spring.green2209S_20.pagenation.PageVO;
import com.spring.green2209S_20.service.AdminService;
import com.spring.green2209S_20.service.MemberService;
import com.spring.green2209S_20.service.OrdersService;
import com.spring.green2209S_20.service.SubscribeService;
import com.spring.green2209S_20.vo.BasisVO;
import com.spring.green2209S_20.vo.BucketVO;
import com.spring.green2209S_20.vo.CategoryLargeVO;
import com.spring.green2209S_20.vo.DBoptionVO;
import com.spring.green2209S_20.vo.MemberVO;
import com.spring.green2209S_20.vo.OrdersVO;
import com.spring.green2209S_20.vo.ProductVO;
import com.spring.green2209S_20.vo.SubscribeVO;

@Controller
@RequestMapping("/subscribe")
public class SubscribeController {
	
	@Autowired
	SubscribeService subscribeService;

	@Autowired
	OrdersService ordersService;
	
	@Autowired
	PageProcess pageProcess;
	
	@Autowired
	MemberService memberService;

	@Autowired
	AdminService adminService;
	
	@RequestMapping(value = "/shome",method = RequestMethod.GET)
	public String shomeGet(Model model) {
		CategoryLargeVO vo = subscribeService.getSubContent(1);
		model.addAttribute("vo", vo);
		BasisVO basisVo = adminService.getBasis();
		model.addAttribute("basisVo", basisVo);
		return "subscribe/shome";
	}
	@RequestMapping(value = "/subscribeMain",method = RequestMethod.GET)
	public String subscribeMainGet(Model model,
			@RequestParam(name="codeSmall",defaultValue = "0" )int codeSmall,
			@RequestParam(name="pag",defaultValue = "1" )int pag
			) {
		
		PageVO pageVo = pageProcess.totRecCnt(pag, 12, "product", 1, codeSmall, "", "");
		ArrayList<ProductVO> vos = ordersService.getProductList(1,codeSmall,pageVo.getStartIndexNo(),pageVo.getPageSize(),"");
		
		model.addAttribute("codeSmall", codeSmall);
		model.addAttribute("pageVo", pageVo);
		model.addAttribute("vos", vos);
		return "subscribe/subscribeMain";
	}
	
	@RequestMapping(value="/subscribeProduct", method = RequestMethod.GET)
	public String subscribeProductGet(int idx,Model model,HttpSession session){
		ProductVO vo = ordersService.getProduct(idx);
		
		ArrayList<ProductVO> vos =  (ArrayList<ProductVO>) session.getAttribute("sProductVos")==null?new ArrayList<ProductVO>():(ArrayList<ProductVO>) session.getAttribute("sProductVos");
		
		vo.setFlag("subscribe");
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
		
		return "subscribe/subscribeProduct";
	}
	
	@RequestMapping(value="/subscribeProduct", method = RequestMethod.POST)
	public String subscribeProductPost(HttpSession session, Model model, BucketVO vo,int subSw,String optionIdxs,String optionPricess,String optionDetails){
		BasisVO basisVo = adminService.getBasis();
		model.addAttribute("basisVo", basisVo);
		
		if(subSw==1) {
			//장바구니에 넣기
			vo.setOptionDetail(optionDetails);
			subscribeService.setProductBuket(vo,optionIdxs);
			return "redirect:/msg/subscribeBucketOK?flag="+vo.getProductIdx();
		}
		else { //바로구매
			ArrayList<BucketVO> vos = new ArrayList<BucketVO>();
			BucketVO bucketVo;
			
			String [] arrIdx = optionIdxs.split(",");
			String [] arrPrices= optionPricess.split(",");
			String [] arrDetails = optionDetails.split(",");
			ProductVO proVo = ordersService.getProduct(vo.getProductIdx());
			
			vo.setCodeLarge(proVo.getCodeLarge());
			vo.setCodeSmall(proVo.getCodeSmall());
			
			int sumOfPrice=0;
			int sumOfOptionNum=0;
			int sub=0;
			int subPrice=0;
			
			for(int i=0;i<arrIdx.length;i++) {
					DBoptionVO optionVo = ordersService.getOption(Integer.parseInt(arrIdx[i]));
					bucketVo = new BucketVO();
					bucketVo.setIdx(0);
					bucketVo.setName(proVo.getName());
					bucketVo.setProductIdx(vo.getProductIdx());
					bucketVo.setCodeLarge(bucketVo.getCodeLarge());
					bucketVo.setCodeSmall(bucketVo.getCodeSmall());
					bucketVo.setOptionIdx(Integer.parseInt(arrIdx[i]));
					bucketVo.setOptionNum(1);
					bucketVo.setOptionPrice(Integer.parseInt(optionVo.getOptionPrice()));
					bucketVo.setTotalPrice((Integer.parseInt(arrPrices[i])+proVo.getPrice()));
					bucketVo.setOptionDetail(arrDetails[i].replace(",", "_").replace("/", "_"));
					bucketVo.setFSName(proVo.getFSName());
					bucketVo.setOptionName(optionVo.getOptionName());
					bucketVo.setSubSw("OK");
					vos.add(bucketVo);
					
					sumOfPrice+=bucketVo.getTotalPrice();
					sumOfOptionNum+=bucketVo.getOptionNum();
					if(bucketVo.getCodeLarge()==1) {
						subPrice+= bucketVo.getTotalPrice();
						sub+= bucketVo.getOptionNum();
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
			model.addAttribute("bucketSw", 0);
			model.addAttribute("bucketVos", vos);
			
			session.setAttribute("sVos", vos);
			
			return "member/memberOrders";
		}
	}	
	@RequestMapping(value="/subscribeList",method = RequestMethod.GET)
	public String adminSubContentGet(int oIdx, Model model) {
		OrdersVO vo =  ordersService.getOrder(oIdx);
		List<SubscribeVO> subVos = subscribeService.getSubscribeList(oIdx); 
		BasisVO basisVo = adminService.getBasis();
		
		model.addAttribute("vo",vo);
		model.addAttribute("subVos",subVos);
		model.addAttribute("basisVo",basisVo);
		
		return "subscribe/subscribeList";
	}
	@ResponseBody
	@RequestMapping(value="/stopSub",method = RequestMethod.POST)
	public String stopSubPost(int oIdx,String subSw) {
		subscribeService.setSubscribeStop(oIdx,subSw);
		return "";
	}
	@RequestMapping(value="/subscribeList",method = RequestMethod.POST)
	public String adminSubContentPost(OrdersVO vo) {
		System.out.println(vo);
		subscribeService.setOrdersSubUpdate(vo);
		return "redirect:/msg/subUpdateOK?flag="+vo.getIdx();
	}
	
}
