package com.spring.green2209S_20;

import java.io.File;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.regex.Pattern;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.spring.green2209S_20.common.JavawspringProvide;
import com.spring.green2209S_20.pagenation.PageProcess;
import com.spring.green2209S_20.pagenation.PageVO;
import com.spring.green2209S_20.service.AdminService;
import com.spring.green2209S_20.service.BoardService;
import com.spring.green2209S_20.service.ChartService;
import com.spring.green2209S_20.service.CouponsService;
import com.spring.green2209S_20.service.JoinsService;
import com.spring.green2209S_20.service.MemberService;
import com.spring.green2209S_20.service.OrdersService;
import com.spring.green2209S_20.service.QnaService;
import com.spring.green2209S_20.service.RefundService;
import com.spring.green2209S_20.service.ServeyService;
import com.spring.green2209S_20.service.SubscribeService;
import com.spring.green2209S_20.vo.AnswerVO;
import com.spring.green2209S_20.vo.BasisVO;
import com.spring.green2209S_20.vo.BoardVO;
import com.spring.green2209S_20.vo.BoardsReplyVO;
import com.spring.green2209S_20.vo.CategoryLargeVO;
import com.spring.green2209S_20.vo.CategorySmallVO;
import com.spring.green2209S_20.vo.ChartVO;
import com.spring.green2209S_20.vo.CouponsVO;
import com.spring.green2209S_20.vo.DBoptionVO;
import com.spring.green2209S_20.vo.JoinProductVO;
import com.spring.green2209S_20.vo.JoinsRequestVO;
import com.spring.green2209S_20.vo.JoinsVO;
import com.spring.green2209S_20.vo.MemberVO;
import com.spring.green2209S_20.vo.OrderSubVO;
import com.spring.green2209S_20.vo.OrdersVO;
import com.spring.green2209S_20.vo.ProductVO;
import com.spring.green2209S_20.vo.QnaVO;
import com.spring.green2209S_20.vo.QuestionVO;
import com.spring.green2209S_20.vo.RealAnswerVO;
import com.spring.green2209S_20.vo.RefundVO;
import com.spring.green2209S_20.vo.ServeyVO;
import com.spring.green2209S_20.vo.SubscribeVO;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	AdminService adminService;
	
	@Autowired
	OrdersService ordersService;
	
	@Autowired
	PageProcess pageProcess;
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	BoardService boardService;
	
	@Autowired
	QnaService qnaService;
	
	@Autowired
	SubscribeService subscribeService;
	
	@Autowired
	JoinsService joinsService;
	
	@Autowired
	CouponsService couponsService;
	
	@Autowired
	JavaMailSender mailSender;
	
	@Autowired
	RefundService refundService;
	
	@Autowired
	ChartService chartService;
	
	@Autowired
	ServeyService serveyService;

	@RequestMapping(value="/adminMain",method=RequestMethod.GET)
	public String adminMainGet() {
		return "admin/adminMain";
	}
	@RequestMapping(value="/adminContent",method=RequestMethod.GET)
	public String adminContentGet(Model model) {
		//미확인 문의글
		
	 List<QnaVO> qVos = qnaService.getQnaAdminUnConfirmCnt();
	 model.addAttribute("qVos", qVos);
	 model.addAttribute("qCnt",qVos.size());
	 PageVO orderPageVo1 =  pageProcess.totRecCnt(1, 10, "orders", 0, 1, "", "");
	 PageVO orderPageVo2 =  pageProcess.totRecCnt(1, 10, "orders", 0, 2, "", "");
	 PageVO orderPageVo3 =  pageProcess.totRecCnt(1, 10, "orders", 0, 3, "", "");
	 PageVO orderPageVo4 =  pageProcess.totRecCnt(1, 10, "orders", 0, 4, "", "");
	 PageVO orderPageVo5 =  pageProcess.totRecCnt(1, 10, "orders", 0, 5, "", "");
	 model.addAttribute("o1Cnt", orderPageVo1.getTotRecCnt());
	 model.addAttribute("o2Cnt", orderPageVo2.getTotRecCnt());
	 model.addAttribute("o3Cnt", orderPageVo3.getTotRecCnt());
	 model.addAttribute("o4Cnt", orderPageVo4.getTotRecCnt());
	 model.addAttribute("o5Cnt", orderPageVo5.getTotRecCnt());
	 model.addAttribute("oCnt", orderPageVo1.getTotRecCnt()+orderPageVo2.getTotRecCnt()+orderPageVo3.getTotRecCnt());
	 
	 PageVO subPageVo1 = pageProcess.totRecCnt(1, 10, "subscribe", 1, 1, "", "");
	 PageVO subPageVoN = pageProcess.totRecCnt(1, 10, "subscribe", -1, 1, "", "");
	 model.addAttribute("s1Cnt", subPageVo1.getTotRecCnt());
	 model.addAttribute("sNCnt", subPageVoN.getTotRecCnt());
	 
	 PageVO joinW =  pageProcess.totRecCnt(1, 10, "joins", 0, 0, "", "");
	 PageVO joinIng =  pageProcess.totRecCnt(1, 10, "joins", 1, 0, "", "");
	 PageVO joinNO =  pageProcess.totRecCnt(1, 10, "joins", -1, 0, "", "");
	 
	 model.addAttribute("jwCnt", joinW.getTotRecCnt());
	 model.addAttribute("jiCnt", joinIng.getTotRecCnt());
	 model.addAttribute("jnCnt", joinNO.getTotRecCnt());
	 /*-----------------------------------------------------------------------*/
	 //여기서부터는 차트
	 Calendar cal =Calendar.getInstance();
	 String lastDate = cal.get(Calendar.YEAR) + "-" + (cal.get(Calendar.MONTH)+1<10?"0"+(cal.get(Calendar.MONTH)+1):cal.get(Calendar.MONTH)+1)+"-"+cal.get(Calendar.DAY_OF_MONTH);
	 cal.add(Calendar.DATE , -7);
	 String startDate = cal.get(Calendar.YEAR) + "-" + (cal.get(Calendar.MONTH)+1<10?"0"+(cal.get(Calendar.MONTH)+1):cal.get(Calendar.MONTH)+1)+"-"+cal.get(Calendar.DAY_OF_MONTH);
	 
	 List<ProductVO> productVos  =  chartService.getProductNameByOrder(startDate,lastDate,"","");
	 model.addAttribute("productVos",productVos);
	 
	 //꺾은선 그래프(수익)
	 String dates [] = new String [7];
	 int prices [] = new int [7];
	 for(int i=0;i<7;i++) {
		 dates[i] = cal.get(Calendar.YEAR) + "-" + (cal.get(Calendar.MONTH)+1<10?"0"+(cal.get(Calendar.MONTH)+1):cal.get(Calendar.MONTH)+1)+"-"+cal.get(Calendar.DAY_OF_MONTH);
		 cal.add(Calendar.DATE , 1);
		 prices[i]=  chartService.getTotalSellPrice(dates[i],"OK","","")+chartService.getTotalSellPrice(dates[i],"","","");
	 }
	 model.addAttribute("dates", dates);
	 model.addAttribute("prices", prices);
	 
		return "admin/adminContent";
	}
	@RequestMapping(value="/adminLeft",method=RequestMethod.GET)
	public String adminLeftGet() {
		return "admin/adminLeft";
	}
	@RequestMapping(value="/category/adminCategory",method=RequestMethod.GET)
	public String adminCategoryGet(Model model) {
		List<CategoryLargeVO> largeVos = adminService.getLargeCategoryList();
		List<CategorySmallVO> smallVos = adminService.getSmallCategoryList();
		model.addAttribute("largeVos", largeVos);
		model.addAttribute("smallVos", smallVos);
		return "admin/category/adminCategory";
	}
	@ResponseBody
	@RequestMapping(value="/category/categoryInput",method=RequestMethod.POST)
	public String adminCategoryPost(CategorySmallVO vo) {
		adminService.setCategoryInput(vo);
		return "";
	}
	@ResponseBody
	@RequestMapping(value="/category/categoryUpdate",method=RequestMethod.POST)
	public String adminCategoryUpdatePost(CategorySmallVO vo) {
		adminService.setCategoryUpdate(vo);
		return "";
	}
	
	@RequestMapping(value="/product/adminInputProduct",method=RequestMethod.GET)
	public String adminInputProductGet(Model model) {
		List<CategoryLargeVO> largeVos = adminService.getLargeCategoryList();
		int productIdx = adminService.getProductLastIdx()+1;
		String strIdx="";
		if(productIdx<10) {
			strIdx ="00"+productIdx;
		}
		else if(productIdx<100) {
			strIdx ="0"+productIdx;
		}
		else {
			strIdx =""+productIdx;
		}
		model.addAttribute("largeVos", largeVos);
		model.addAttribute("productIdx", productIdx);
		model.addAttribute("strIdx", strIdx);
		return "admin/product/adminInputProduct";
	}
	//상품 업데이트
	@RequestMapping(value="/product/adminUpdateProduct",method=RequestMethod.GET)
	public String adminUpdateProductGet(Model model,int idx) {
		ProductVO vo = ordersService.getProduct(idx);
		List<CategoryLargeVO> largeVos = adminService.getLargeCategoryList();
		List<CategorySmallVO> smallVos  =adminService.getSmallCategory(vo.getCodeLarge());
		
		/*사진 파일 처리*/
		if(vo.getDetail().indexOf("src=\"/") != -1) adminService.imgCheckUpdate("product",vo.getDetail());
		vo.setDetail(vo.getDetail().replace("/data/ckeditor/product/", "/data/ckeditor/"));
		
		
		int productIdx = adminService.getProductLastIdx()+1;
		String strIdx="";
		if(productIdx<10) {
			strIdx ="00"+productIdx;
		}
		else if(productIdx<100) {
			strIdx ="0"+productIdx;
		}
		else {
			strIdx =""+productIdx;
		}
		//옵션 가져오기
		List<DBoptionVO> optionVos = ordersService.getOptionList(idx);
		
		model.addAttribute("largeVos", largeVos);
		model.addAttribute("smallVos", smallVos);
		model.addAttribute("optionVos", optionVos);
		model.addAttribute("optionNum",optionVos.size());
		model.addAttribute("vo", vo);
		model.addAttribute("productIdx", productIdx);
		model.addAttribute("strIdx", strIdx);
		return "admin/product/adminUpdateProduct";
	}
	//상품등록
	@RequestMapping(value="/product/adminInputProduct",method=RequestMethod.POST)
	public String adminInputProductPost(MultipartFile fileName,ProductVO vo,DBoptionVO optionVo) {
		
		String detail=vo.getDetail();
		adminService.imgCheck("product",detail);
		
		vo.setDetail(vo.getDetail().replace("/data/ckeditor/", "/data/ckeditor/product/"));
		
		int res =adminService.setProductInput(fileName,vo);
		
		if (optionVo!=null) {
			if(!Pattern.matches("^[0-9]+$",optionVo.getOptionPrice())) return "redirect:/msg/productOptionNumNo";
			adminService.setOptionInput(optionVo);
		}
		//옵션등록
		
		if(res==1) return "redirect:/msg/productInputOk";
		else return "redirect:/msg/productInputNo";
	}
	//상품수정
	@RequestMapping(value="/product/adminUpdateProduct",method=RequestMethod.POST)
	public String adminUpdateProductPost(ProductVO vo,
			 MultipartFile fileName) {
		ProductVO origVo = ordersService.getProduct(vo.getIdx());
		String detail = vo.getDetail();
		if(!origVo.getDetail().equals(detail)) {
			//실제로 수정하기 버튼을 클릭하게 되면 기존의 board폴더에 저장된 현재 content의 그림파일 모두를 삭제시킨다.
			if(origVo.getContent().indexOf("src=\"/")!=-1) adminService.imgDelete("product" ,origVo.getDetail());
			
			//vo.getContent()에 들어있는 파일의 경로는 'ckeditor/board' 경로를 'ckeditor'변경시켜줘야한다.
			detail =detail.replace("/data/ckeditor/product/", "/data/ckeditor/");
			
			//앞의 모든준비가 끝나면, 파일을 처음업로드한것과 같은 작업을 처리한다.
			//이 작업은 처음 게시글을 올릴때의 파일복사 작업과 동일한 작업이다.
			adminService.imgCheck("product",detail);
			
			//파일 업로드가 끝나면 다시 경로를 수정한다. 'ckeditor'경로를 'ckeditor/board' 변경시켜줘야한다.(즉,vo.getContent()를 변경된 vo.setContent()처리한다.)
			detail = detail.replace("/data/ckeditor/", "/data/ckeditor/product/");
			detail =  adminService.widthCheck(detail);
			vo.setDetail(detail);
		}
		int res= adminService.setProductUpdate(fileName,vo);
		
		if(res==1) return "redirect:/msg/productUpdateOk?mid="+vo.getIdx();
		else return "redirect:/msg/productUpdateNo";
	}
	
	@RequestMapping(value="/category/adminDetail",method=RequestMethod.GET)
	public String adminDetailGet(Model model) {
		//수정창으로 이동시에는 먼저 원본 파일에 그림파일이 있다면, 현재 폴더(board)의 그림파일을 ckeditor 폴더로 복사시켜둔다.
		CategoryLargeVO vo = adminService.getSubDetail(1);
		if(vo.getContent().indexOf("src=\"/") != -1) adminService.imgCheckUpdate("sdetail",vo.getContent());
		vo.setContent(vo.getContent().replace("/data/ckeditor/sdetail/", "/data/ckeditor/"));
		
		model.addAttribute("vo",vo);
		return "admin/category/adminDetail";
	}
	@RequestMapping(value="/category/adminDetail",method=RequestMethod.POST)
	public String adminDetailPost(Model model,String content) {
		//수정창으로 이동시에는 먼저 원본 파일에 그림파일이 있다면, 현재 폴더(board)의 그림파일을 ckeditor 폴더로 복사시켜둔다.
		CategoryLargeVO origVo = adminService.getSubDetail(1);
		//content의 내용이 조금이라도 변경된 것이 있다면 아래 내용을 수행처리시킨다.
		if(!origVo.getContent().equals(content)) {
			//실제로 수정하기 버튼을 클릭하게 되면 기존의 board폴더에 저장된 현재 content의 그림파일 모두를 삭제시킨다.
			if(origVo.getContent().indexOf("src=\"/")!=-1) adminService.imgDelete("sdetail" ,origVo.getContent());
			
			//vo.getContent()에 들어있는 파일의 경로는 'ckeditor/board' 경로를 'ckeditor'변경시켜줘야한다.
			content =content.replace("/data/ckeditor/sdetail/", "/data/ckeditor/");
			
			//앞의 모든준비가 끝나면, 파일을 처음업로드한것과 같은 작업을 처리한다.
			//이 작업은 처음 게시글을 올릴때의 파일복사 작업과 동일한 작업이다.
			adminService.imgCheck("sdetail",content);
			
			//파일 업로드가 끝나면 다시 경로를 수정한다. 'ckeditor'경로를 'ckeditor/board' 변경시켜줘야한다.(즉,vo.getContent()를 변경된 vo.setContent()처리한다.)
			content = content.replace("/data/ckeditor/", "/data/ckeditor/sdetail/");
 			content =  adminService.widthCheck(content);
			adminService.setSubContentUpdate(1,content);
		}
		return "redirect:/admin/category/adminDetail";
	}
	
	@ResponseBody
	@RequestMapping(value="product/catogory" ,method = RequestMethod.POST)
	public List<CategorySmallVO> catogoryPost(int codeLarge) {
		return adminService.getSmallCategory(codeLarge);
	}
	
	@RequestMapping(value="/product/adminProductList",method=RequestMethod.GET)
	public String adminProductListGet(Model model,
			@RequestParam(name="codeLarge",defaultValue = "0")int categoryLarge,
			@RequestParam(name="codeSmall",defaultValue = "0")int categorySmall,
			@RequestParam(name="pag",defaultValue = "1")int pag,
			@RequestParam(name="pageSize",defaultValue = "10")int pageSize
			) {
		PageVO pageVo = pageProcess.totRecCnt(pag, pageSize, "product", categoryLarge, categorySmall, "", "");
		ArrayList<ProductVO> vos = ordersService.getProductList(categoryLarge, categorySmall, pageVo.getStartIndexNo() , pageVo.getPageSize(),"");
		List<CategoryLargeVO> largeVos = adminService.getLargeCategoryList();
		List<CategorySmallVO> smallVos  =adminService.getSmallCategory(categoryLarge);
		model.addAttribute("vos", vos);
		model.addAttribute("largeVos", largeVos);
		model.addAttribute("smallVos", smallVos);
		model.addAttribute("largeVos", largeVos);
		model.addAttribute("codeLarge", categoryLarge);
		model.addAttribute("codeSmall", categorySmall);
		model.addAttribute("pageVo", pageVo);
		return "admin/product/adminProductList";
	}
	@RequestMapping(value="/member/adminMemberList",method = RequestMethod.GET)
	public String adminMemberListGet(Model model,
			@RequestParam(name="pag",defaultValue = "1")int pag,
			@RequestParam(name="pageSize",defaultValue = "10")int pageSize,
			@RequestParam(name="searchLevel",defaultValue = "99")int searchLevel,
			@RequestParam(name="part",defaultValue = "")String part,
			@RequestParam(name="search",defaultValue = "")String search,
			@RequestParam(name ="startDate",defaultValue = "",required = false) String startDate ,
			@RequestParam(name ="lastDate",defaultValue = "",required = false) String lastDate
			) {
		PageVO pageVo = pageProcess.totRecCnt(pag, pageSize, "member", searchLevel, 0, part, search);
		List<MemberVO> vos = memberService.getMemberList(pageVo.getStartIndexNo(),pageSize,searchLevel,part,search);
		model.addAttribute("pageVo", pageVo);
		model.addAttribute("vos", vos);
		model.addAttribute("searchLevel", searchLevel);
		model.addAttribute("part", part);
		model.addAttribute("search", search);
		
		return "admin/member/adminMemberList";
	}
	@RequestMapping(value="/member/adminMemberAnalize",method = RequestMethod.GET)
	public String adminMemberAnalizeGet(Model model,
			@RequestParam(name ="startDate",defaultValue = "",required = false) String startDate ,
			@RequestParam(name ="lastDate",defaultValue = "",required = false) String lastDate
			) {
		
		Calendar cal =Calendar.getInstance();
		if(lastDate.equals("")) {
		 lastDate = cal.get(Calendar.YEAR) + "-"
				 		+(cal.get(Calendar.MONTH)+1<10? "0"+(cal.get(Calendar.MONTH)+1): cal.get(Calendar.MONTH)+1)+"-"
				 		+(cal.get(Calendar.DAY_OF_MONTH)<10?"0"+(cal.get(Calendar.DAY_OF_MONTH)):(cal.get(Calendar.DAY_OF_MONTH)));
		}
		cal.add(Calendar.DATE , -7);
		 if (startDate.equals("")) {
			 startDate = cal.get(Calendar.YEAR) + "-" 
					 			+ (cal.get(Calendar.MONTH)+1<10?"0"+(cal.get(Calendar.MONTH)+1):cal.get(Calendar.MONTH)+1)+"-"
					 			+(cal.get(Calendar.DAY_OF_MONTH)<10?"0"+(cal.get(Calendar.DAY_OF_MONTH)):(cal.get(Calendar.DAY_OF_MONTH)));
		 }
		 cal.add(Calendar.DATE , +7);
		 
		 
		 int day_diff=0;
		 cal.set(Integer.parseInt(startDate.substring(0, 4)) ,Integer.parseInt(startDate.substring(5,7)),Integer.parseInt(startDate.substring(8, 10)));
		 //두 날짜 차이의 날짜 구하기
		try {
			Date format1 = new SimpleDateFormat("yyyy-MM-dd").parse(lastDate);
			Date format2 = new SimpleDateFormat("yyyy-MM-dd").parse(startDate);
			long diffSec = (format1.getTime() - format2.getTime()) / 1000; //초 차이
			day_diff = (int)diffSec / (24*60*60); //일자수 차이
		} catch (ParseException e) {
			e.printStackTrace();
		}
		 //꺾은선 그래프(수익)
		 String dates [] = new String [day_diff];
		 
		 List<ChartVO> sellVos = new ArrayList<ChartVO>();
		 List<ChartVO> sellVos3 = new ArrayList<ChartVO>();
		 
		 for(int i=0;i<day_diff;i++) {
			 dates[i] = cal.get(Calendar.YEAR) + "-" + (cal.get(Calendar.MONTH)<10?"0"+(cal.get(Calendar.MONTH)):cal.get(Calendar.MONTH))+"-"+(cal.get(Calendar.DAY_OF_MONTH)<10?"0"+(cal.get(Calendar.DAY_OF_MONTH)):(cal.get(Calendar.DAY_OF_MONTH)));
			 
			 ChartVO chartVo = new ChartVO();
			 ChartVO chartVo2 = new ChartVO();
			 chartVo.setDate(dates[i]);
			 
			 String datesPlus = cal.get(Calendar.YEAR) + "-" + (cal.get(Calendar.MONTH)<10?"0"+(cal.get(Calendar.MONTH)):cal.get(Calendar.MONTH))+"-"+((cal.get(Calendar.DAY_OF_MONTH)+1<10?"0"+(cal.get(Calendar.DAY_OF_MONTH)+1):(cal.get(Calendar.DAY_OF_MONTH)+1)));
			 
			 chartVo.setCnt1(chartService.getMemberGenderCnt(datesPlus,"남자")); //누적 가입자수 구하기
			 chartVo.setCnt2(chartService.getMemberGenderCnt(datesPlus,"여자"));
			 chartVo.setCnt(chartService.getMemberComCnt(datesPlus)); //기업회원
			 
			 //가입한사람 구하기
			 chartVo2.setDate(dates[i]);
			 chartVo2.setCnt(chartService.getTodayMember(dates[i]));
			 
			 sellVos.add(chartVo);
			 sellVos3.add(chartVo2);
			 cal.add(Calendar.DATE , 1);
		 }
		 //회원당 Best 주문수
		 List<ChartVO> sellVos2 = chartService.getOrdersMid();
		 
		 model.addAttribute("sellVos",sellVos);
		 model.addAttribute("sellVos2",sellVos2);
		 model.addAttribute("sellVos3",sellVos3);
		
		 model.addAttribute("startDate",startDate);
		 model.addAttribute("lastDate",lastDate);
		 
		return "admin/member/adminMemberAnalize";
	}
	@RequestMapping(value="/product/adminOption")
	public String adminOptionGet(int idx,Model model) {
		ProductVO vo =  ordersService.getProduct(idx);
		List<DBoptionVO> optionVos = ordersService.getOptionList(idx);
		
		model.addAttribute("optionVos", optionVos);
		model.addAttribute("vo", vo);
		return "admin/product/adminOption";
	}
	@ResponseBody
	@RequestMapping(value="/product/optionUpdate",method = RequestMethod.POST)
	public String optionUpdatePost (DBoptionVO vo) {
		adminService.setOptionUpdate(vo);
		return "";
	}
	@ResponseBody
	@RequestMapping(value="/product/optionInput",method = RequestMethod.POST)
	public String optionInputPost (DBoptionVO vo) {
		adminService.setOptionInput(vo);
		return "";
	}
	@ResponseBody
	@RequestMapping(value="/product/optionDelete",method = RequestMethod.POST)
	public String optionDeletePost (int idx) {
		adminService.setOptionDelete(idx);
		return "";
	}
	@ResponseBody
	@RequestMapping(value="/product/deleteProduct",method = RequestMethod.POST)
	public String optionDeletePost (String deleteboxes) {
		deleteboxes= deleteboxes.substring(0,deleteboxes.length()-1);
		String [] arr = deleteboxes.split("/");
		for(int i=0;i<arr.length;i++) {
			adminService.setProductDelete(Integer.parseInt(arr[i]));
		}
		return "";
	}
	
	@RequestMapping(value="/adboard/adminBoardList")
	public String adminBoardListGet(Model model,
			@RequestParam(name="pag",defaultValue = "1")int pag,
			@RequestParam(name="3",defaultValue = "10")int pageSize
			) {
		PageVO pageVo = pageProcess.totRecCnt(pag, pageSize, "board", 1, 0, "", "");
		List<BoardVO> vos = boardService.getboardListSw(pageVo.getStartIndexNo(),pageSize,1,"","");
		model.addAttribute("pageVo", pageVo);
		model.addAttribute("vos", vos);
		return "admin/adboard/adminBoardList";
	}
	@RequestMapping(value="/adboard/adminBoardInput",method = RequestMethod.GET)
	public String adminBoardInputGet() {
		return "admin/adboard/adminBoardInput";
	}
	@RequestMapping(value="/adboard/adminBoardInput" ,method =  RequestMethod.POST)
	public String adminBoardInputPost(BoardVO vo) {
		String content=vo.getContent();
		adminService.imgCheck("adboard",content);
		
		vo.setContent(vo.getContent().replace("/data/ckeditor/", "/data/ckeditor/adboard/"));
		vo.setSw(1);
		content= adminService.widthCheck(content);
		vo.setContent(content);
		boardService.setBoardInput(vo);
		
		
		return "redirect:/admin/adboard/adminBoardList";
	}
	@ResponseBody
	@RequestMapping(value="/category/categoryDelete",method = RequestMethod.POST)
	public String categoryDeletePost(int codeSmall) {
		adminService.setCategoryDelete(codeSmall);
		return "";
	}
	@RequestMapping(value="/board/boardContent",method = RequestMethod.GET)
	public String boardContentGet(int idx,Model model) {
		BoardVO vo =  boardService.getBoardContent(idx,1);
		List<BoardsReplyVO> replyVos = boardService.getReplyList(idx);
		model.addAttribute("replyVos",replyVos);
		model.addAttribute("vo",vo);
		return "admin/adboard/boardContent";
	}
	@RequestMapping(value="/board/boardUpdate",method = RequestMethod.GET)
	public String boardUpdateGet(int idx,Model model) {
		BoardVO vo =  boardService.getBoardContent(idx,1);
		model.addAttribute("vo",vo);
		return "admin/adboard/boardUpdate";
	}
	@RequestMapping(value="/board/boardUpdate",method = RequestMethod.POST)
	public String boardUpdatePost(BoardVO vo) {
		BoardVO origVo = boardService.getBoardContent(vo.getIdx(),1);
		String content = vo.getContent();
		if(!origVo.getContent().equals(content)) {
			if(origVo.getContent().indexOf("src=\"/")!=-1) adminService.imgDelete("adboard" ,origVo.getContent()); //기존파일 삭제
			
			content =content.replace("/data/ckeditor/adboard/", "/data/ckeditor/"); 
			
			adminService.imgCheck("adboard",content); //임시폴더에 있는  파일복사 완료
			
			content= content.replace("/data/ckeditor/", "/data/ckeditor/board/"); //DB에 경로 바꿔서 저장
			content=  adminService.widthCheck(content);
			vo.setContent(content);
		}
		vo.setSw(1);
		boardService.setBoardUpdate(vo);
		
		return "redirect:/admin/board/boardContent?idx="+vo.getIdx();
	}
	@RequestMapping(value="/extra/adminFileList",method = RequestMethod.GET)
	public String fileListGet(HttpServletRequest request,Model model) {
		String realPath = request.getRealPath("resources/data/ckeditor/");
		
		String [] files = new File(realPath).list();
		
		model.addAttribute("files", files);
		
		return "admin/extra/adminFileList";
	}
	@RequestMapping(value="/extra/adminTempFileList",method = RequestMethod.GET)
	public String tempFileListGet(HttpServletRequest request,Model model) {
		String realPath = request.getRealPath("resources/data/ckeditor/adboard/temp");
		
		String [] files = new File(realPath).list();
		
		model.addAttribute("files", files);
		
		return "admin/extra/adminTempFileList";
	}
	@RequestMapping(value="/extra/adminQnaList",method = RequestMethod.GET)
	public String adminQnaListGet(HttpServletRequest request,Model model,
			@RequestParam(name="pag",defaultValue = "1")int pag,
			@RequestParam(name="pageSize",defaultValue = "10")int pageSize,
			@RequestParam(name="questionId",defaultValue = "")String questionId
			) {
		PageVO pageVo = pageProcess.totRecCnt(pag, pageSize, "qna", 0, 0, "", "");
		
		qnaService.setAnswerSwUpdate(questionId);
		List<QnaVO> midVos = qnaService.getQnaMidList(pageVo.getStartIndexNo(),pageSize);
		List<QnaVO> qVos = qnaService.getQnaList(questionId,"answerSw");
		ArrayList<QnaVO> vos = new ArrayList<QnaVO>();
		for(int j=0;j<midVos.size();j++) {
			String mid = midVos.get(j).getQuestionId();
			String id="";
			int sw=0;
			for(int i=0;i<vos.size();i++) {
				id=vos.get(i).getQuestionId();
				if(mid.equals(id)) {
					sw=1;
				}
			}
			if(sw==0) vos.add(midVos.get(j));
		}
		model.addAttribute("pageVo",pageVo);
		model.addAttribute("qVos",qVos);
		model.addAttribute("vos",vos);
		return "admin/extra/adminQnaList";
	}
	@RequestMapping(value="/orders/adminSubList",method = RequestMethod.GET)
	public String adminSubList(HttpServletRequest request,Model model,HttpSession session,
			@RequestParam(name="pag",defaultValue = "1",required = false)int pag,
			@RequestParam(name="pageSize",defaultValue = "10",required = false)int pageSize,
			@RequestParam(name="startDate",defaultValue = "",required = false)String startDate,
			@RequestParam(name="lastDate",defaultValue = "",required = false)String lastDate,
			@RequestParam(name="sstartDate",defaultValue = "",required = false)String sstartDate,
			@RequestParam(name="slastDate",defaultValue = "",required = false)String slastDate,
			@RequestParam(name="search",defaultValue = "",required = false)String search,
			@RequestParam(name="part",defaultValue = "",required = false)String part,
			@RequestParam(name="orderSw",defaultValue = "99",required = false)int orderSw,
			@RequestParam(name="subSw",defaultValue = "0",required = false)int subSw
			) {
		PageVO pageVo = pageProcess.totRecCnt(pag, pageSize, "adminSubscribe", subSw, 1,startDate,lastDate,search,part,sstartDate,slastDate);
		String sw="";
		if(subSw==1) sw="OK"; 
		else if(subSw==0) sw=""; 
		else if(subSw==-1) sw="NO"; 
		List<OrdersVO> orderVos = adminService.getSubsList(pageVo.getStartIndexNo(),pageVo.getPageSize(),sw,1,startDate,lastDate,search,part,sstartDate,slastDate);
		
		model.addAttribute("ordersVos", orderVos);
		model.addAttribute("pageVo", pageVo);
		model.addAttribute("startDate", startDate);
		model.addAttribute("lastDate", lastDate);
		model.addAttribute("sstartDate", sstartDate);
		model.addAttribute("slastDate", slastDate);
		model.addAttribute("part", part);
		model.addAttribute("search", search);
		model.addAttribute("orderSw", orderSw);
		model.addAttribute("subSw", subSw);
		
		return "admin/orders/adminSubList";
	}
	@RequestMapping(value="/orders/adminOrderList",method = RequestMethod.GET)
	public String adminOrderList(HttpServletRequest request,Model model,HttpSession session,
			@RequestParam(name="pag",defaultValue = "1",required = false)int pag,
			@RequestParam(name="pageSize",defaultValue = "10",required = false)int pageSize,
			@RequestParam(name="startDate",defaultValue = "",required = false)String startDate,
			@RequestParam(name="lastDate",defaultValue = "",required = false)String lastDate,
			@RequestParam(name="search",defaultValue = "",required = false)String search,
			@RequestParam(name="part",defaultValue = "",required = false)String part,
			@RequestParam(name="orderSw",defaultValue = "99",required = false)int orderSw
			) {
		
		PageVO pageVo = pageProcess.totRecCnt(pag, pageSize, "adminOrders",1,orderSw,startDate,lastDate, part, search);
		List<OrdersVO> orderVos = adminService.getOrdersList(pageVo.getStartIndexNo(),pageVo.getPageSize(),orderSw,startDate,lastDate,part,search);
		
		model.addAttribute("ordersVos", orderVos);
		model.addAttribute("pageVo", pageVo);
		model.addAttribute("startDate", startDate);
		model.addAttribute("lastDate", lastDate);
		model.addAttribute("part", part);
		model.addAttribute("search", search);
		model.addAttribute("orderSw", orderSw);
		return "admin/orders/adminOrderList";
	}
	
	@ResponseBody
	@RequestMapping(value="/orders/adminSubWrite",method = RequestMethod.POST)
	public String adminSubWrite(String idxs,String content) {
		idxs= idxs.substring(0, idxs.length()-1);
		String [] strIdxs = idxs.split("/");
		SubscribeVO vo ;
		for(String idx:strIdxs) {
			String address= ordersService.getOrder(Integer.parseInt(idx)).getAddress();
			vo=new SubscribeVO();
			vo.setOIdx(Integer.parseInt(idx));
			vo.setContent(content);
			vo.setAddress(address);
			
			subscribeService.setSubscribeInput(vo);
		}
		return "";
	}
	@ResponseBody
	@RequestMapping(value="/orders/adminOrderSwUpdate",method = RequestMethod.POST)
	public String adminOrderSwUpdate(String idxs,int orderSw) {
		idxs= idxs.substring(0, idxs.length()-1);
		String [] strIdxs = idxs.split("/");
		for(String idx:strIdxs) {
			ordersService.setOrderUpdateSw(Integer.parseInt(idx),orderSw);
		}
		return "";
	}
	@ResponseBody
	@RequestMapping(value="/extra/qnaAnswerInput",method=RequestMethod.POST)
	public String qnaAnswerInput(QnaVO vo) {
		qnaService.setQnaAnswerInput(vo);
		return "";
	}
	
	@RequestMapping(value="/subscribe/adminSubContent",method = RequestMethod.GET)
	public String adminSubContentGet(int oIdx, Model model) {
		OrdersVO vo =  ordersService.getOrder(oIdx);
		List<SubscribeVO> subVos = subscribeService.getSubscribeList(oIdx); 
		BasisVO basisVo = adminService.getBasis();
		
		model.addAttribute("vo",vo);
		model.addAttribute("subVos",subVos);
		model.addAttribute("basisVo",basisVo);
		
		return "admin/subscribe/adminSubContent";
	}
	@RequestMapping(value="/orders/adminOrdersContent",method = RequestMethod.GET)
	public String adminOrdersContentGet(Model model, String orderIdx) {
		List<OrdersVO> orderVos = ordersService.getOrders(orderIdx);
		OrdersVO ovo = orderVos.get(0);
		model.addAttribute("orderVos", orderVos);
		model.addAttribute("ovo", ovo);
		OrderSubVO subVo = ordersService.getOrderSub(orderIdx);
		int sumOfPrice=0;
		for(OrdersVO vo : orderVos) {
			sumOfPrice+=vo.getTotalPrice();
		}
		BasisVO basisVo= adminService.getBasis();
		model.addAttribute("basisVo", basisVo);
		model.addAttribute("subVo", subVo);
		model.addAttribute("sumOfPrice", sumOfPrice);
		return "admin/orders/adminOrdersContent";
	}
	@RequestMapping(value="/joins/adminJoinsApply" ,method = RequestMethod.GET)
	public String adminJoinsApplyGet(Model model,
			@RequestParam(name="pag",defaultValue = "1")int pag,
			@RequestParam(name="pageSize",defaultValue = "9")int pageSize,
			@RequestParam(name="joinSw",defaultValue = "0")int joinSw
			) {
		PageVO pageVo = pageProcess.totRecCnt(pag, pageSize, "joins", joinSw, 0, "", "");
		List<JoinsVO> vos = joinsService.getJoinsList(pageVo.getStartIndexNo(),pageSize,joinSw,"","");
		model.addAttribute("vos",vos);
		model.addAttribute("joinSw",joinSw);
		model.addAttribute("pageVo", pageVo);
		
		return "admin/joins/adminJoinsApply";
	}
	@RequestMapping(value="/joins/adminJoinsInput" ,method = RequestMethod.GET)
	public String adminJoinsInputGet(Model model,
			@RequestParam(name="idx", defaultValue = "0",required = false) int idx
			) {
		if(idx!=0) {
			JoinsVO vo = joinsService.getJoin(idx);
			model.addAttribute("vo",vo);}
		return "admin/joins/adminJoinsInput";
	}
	//제휴농가 등록 수정
	@RequestMapping(value="/joins/adminJoinsInput" ,method = RequestMethod.POST)
	public String adminJoinsInputPost(JoinsVO vo,MultipartFile photo) {
		vo.setJoinSw(1);
		
		String memo=vo.getMemo();
		adminService.imgCheck("adjoins",memo);
		
		// 이미지 복사작업이 끝나면, product폴더에 실제로 저장된 파일명을 DB에 저장시켜준다.(/resources/data/ckeditor/  ==>> /resources/data/product/)
		vo.setContent(vo.getContent().replace("/data/ckeditor/", "/data/ckeditor/adjoins/"));
		memo= adminService.widthCheck(memo);
		vo.setMemo(memo);
		
		
		joinsService.setJoinsUpdate(vo,photo);
		return "admin/joins/adminJoinsInput";
	}
	//제휴농가 등록 수정
	@RequestMapping(value="/joins/adminJoinsList" ,method = RequestMethod.GET)
	public String adminJoinsListGet(Model model,
			@RequestParam(name="pag",defaultValue = "1") int pag,
			@RequestParam(name="pageSize",defaultValue = "10") int pageSize
			) {
		
		PageVO pageVO= pageProcess.totRecCnt(pag, pageSize, "joins", 1, 0, "", "");
		List<JoinsVO> vos = joinsService.getJoinsList(pageVO.getStartIndexNo(), pageSize, 1,"","");
		model.addAttribute("vos", vos);
		model.addAttribute("pageVo", pageVO);
		
		return "admin/joins/adminJoinsList";
	}
	@RequestMapping(value="/joins/adminJoinsContent" ,method = RequestMethod.GET)
	public String adminJoinsContentGet(Model model,
			@RequestParam(name="idx", defaultValue = "0",required = false) int idx) {
		JoinsVO vo =  joinsService.getJoin(idx);
		List<JoinProductVO> vos = joinsService.getjoinsProductList(idx);
		model.addAttribute("vo", vo);
		model.addAttribute("productVos", vos);
		return "admin/joins/adminJoinsContent";
	}
	@ResponseBody
	@RequestMapping(value="/joins/adminJoinProductInput" ,method = RequestMethod.POST)
	public String adminJoinProductInputPost(JoinProductVO vo) {
		joinsService.setJoinProduct(vo);
		
		return "";
	}
	@RequestMapping(value="/joins/adminJoinsRequest" ,method = RequestMethod.GET)
	public String adminJoinsRequestGet(Model model,
			@RequestParam(name="pag",defaultValue = "1") int pag,
			@RequestParam(name="pageSize",defaultValue = "10") int pageSize) {
		PageVO pageVO= pageProcess.totRecCnt(pag, pageSize, "joins", 1, 0, "", "");
		List<JoinsVO> vos = joinsService.getJoinsList(pageVO.getStartIndexNo(), pageSize, 1,"","");
		List<JoinProductVO> productVos = joinsService.getJoinsProductsList();
		model.addAttribute("vos", vos);
		model.addAttribute("productVos", productVos);
		model.addAttribute("pageVo", pageVO);
		return "admin/joins/adminJoinsRequest";
	}
	@ResponseBody
	@RequestMapping(value="/joins/adminJoinsMemoUpdate",method =  RequestMethod.POST)
	public String adminJoinsMemoUpdatePost(int idx,String content) {
		joinsService.setJoinsMemoUpdate(idx,content);
		return "";
	}
	
	@RequestMapping(value="/coupons/adminCouponInput",method = RequestMethod.GET)
	public String adminCouponInputGet(Model model,
			@RequestParam(name="pag",defaultValue = "1") int pag,
			@RequestParam(name="pageSize",defaultValue = "10") int pageSize
			) {
		PageVO pageVo = pageProcess.totRecCnt(pag, pageSize,"coupons", 0, 0, "", "");
		List<CouponsVO> vos = couponsService.getCouponList(pageVo.getStartIndexNo(),pageSize);
		PageVO memPageVo = pageProcess.totRecCnt(1, 10, "member", 99, 0, "","");
		List<MemberVO> memberVos = memberService.getMemberList(memPageVo.getStartIndexNo(), memPageVo.getTotRecCnt(),99,"","");
		model.addAttribute("pageVo",pageVo);
		model.addAttribute("vos",vos);
		model.addAttribute("memberVos",memberVos);
		
		return "admin/coupons/adminCouponInput";
	}
	@ResponseBody
	@RequestMapping(value="/coupons/adminCouponsInput",method = RequestMethod.POST)
	public String adminCouponInputPost(CouponsVO vo,HttpServletRequest request) {
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/ckeditor/coupons/");
		
		String lastIdx = couponsService.getLastIdx();
		int intIdx=0;
		if(lastIdx==null) intIdx =1;
		else intIdx= Integer.parseInt(lastIdx)+1 ;
		
		couponsService.qrCreate(intIdx,vo, realPath);
		
		return "";
	}
	@ResponseBody
	@RequestMapping(value="/coupons/adminCouponSend",method=RequestMethod.POST)
	public String adminCouponSendPost(HttpServletRequest request, String photo,String toMail,String title, String content) {
		String res="";
		try {
			// 메일을 전송하기위한 객체 : MimeMessage() , MimeMessageHelper()
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
			
			// 메일보관함에 회원이 보내온 메세지들을 모두 저장시킨다.
			messageHelper.setTo(toMail);
			messageHelper.setSubject(title);
			messageHelper.setText(content);
			
			// 메세지 보관함의 내용(content)에 필요한 정보를 추가로 담아서 전송시킬수 있도록 한다.
			content = content.replace("\n", "<br/>");
			content += "<img src=\"cid:photo.png\" width='200px'>";
			content += "<br><hr><h3>리얼후르츠에서 보냅니다.</h3><hr><br>";
			content += "<p><img src=\"cid:main.jpg\" width='200px'></p>";
			content += "<p>방문하기 : <a href='http://49.142.157.251:9090/cjgreen/'>CJ Green프로젝트</a></p>";
			content += "<hr>";
			messageHelper.setText(content, true);
			
			String realPath = request.getRealPath("resources/images/logo-1.png");
			// 본문에 기재된 그림파일의 경로를 따로 표시시켜준다. 그리고, 보관함에 다시 저장시켜준다.
			FileSystemResource file = new FileSystemResource(realPath);
			messageHelper.addInline("main.jpg", file);
			
			// 첨부파일 보내기(서버 파일시스템에 있는 파일)
			realPath =request.getRealPath("resources/data/ckeditor/coupons/"+photo+".png");
			file = new FileSystemResource(realPath);
			messageHelper.addInline("photo.png", file);
			
			// 메일 전송하기
			mailSender.send(message);
			res="1";
		} catch (MessagingException e) {
			e.printStackTrace();
		}
		
		return res;
	}
	@ResponseBody
	@RequestMapping(value="/member/levelUpdate",method = RequestMethod.POST)
	public String levelUpdatePost(int idx, int level) {
		adminService.setMemberLevelUpdate(idx,level);
		return "";
	}
	@ResponseBody
	@RequestMapping(value="/member/adminMemberDelete",method=RequestMethod.POST)
	public String adminMemberDeletePost(String mid) {
		adminService.adminMemberDelete(mid);
		return "";
	}
	@RequestMapping(value="/board/boardDelete")
	public String boardDeleteGet(int idx) {
		boardService.setBoardDelete(idx);
		return "redirect:/msg/boardDeleteOK";
	}
	@RequestMapping(value="/reviews/adminReviewsList",method =RequestMethod.GET)
	public String reviewsListGet(Model model,
			@RequestParam(name ="pag",defaultValue = "1",required = false) int pag,
			@RequestParam(name ="pageSize",defaultValue = "16",required = false) int pageSize,
			@RequestParam(name ="part",defaultValue = "",required = false) String part,
			@RequestParam(name ="search",defaultValue = "",required = false) String search
			) {
		PageVO pageVo = pageProcess.totRecCnt(pag, pageSize, "board", 2, 0, part, search);
		List<BoardVO> vos = boardService.getboardListSw(pageVo.getStartIndexNo(),pageSize,2,part,search);
		model.addAttribute("pageVo", pageVo);
		model.addAttribute("vos", vos);
		model.addAttribute("part", part);
		model.addAttribute("search", search);
		return "admin/reviews/adminReviewsList";
	}
	@RequestMapping(value="/reviews/adminReviewsContent",method =RequestMethod.GET)
	public String reviewsContentGet(Model model,int idx) {
		BoardVO vo = boardService.getBoardContent(idx,2);
		List<BoardsReplyVO> vos =  boardService.getReplyList(idx);
		model.addAttribute("vo", vo);
		model.addAttribute("replyVos", vos);
		String [] fNames = vo.getFName().split("/");
		String [] fSNames = vo.getFSName().split("/");
		model.addAttribute("fNames", fNames);
		model.addAttribute("fSNames", fSNames);
		
		
		return "admin/reviews/adminReviewsContent";
	}
	@ResponseBody
	@RequestMapping(value="/reviews/deleteReviewReply",method = RequestMethod.POST)
	public String deleteReviewReplyPost(int idx) {
		boardService.setBoardReplyDelete(idx);
		return"";
	}
	@ResponseBody
	@RequestMapping(value="/extra/qnaExit",method = RequestMethod.POST)
	public String qnaExitPost(@RequestParam(name="questionId",defaultValue = "",required = false) String questionId) {
		if(!questionId.equals("")) {
			qnaService.setQnaExit(questionId);
		}
		else {
			qnaService.setAdminDelete();
		}
		
		return "";
	}
	@RequestMapping(value="/extra/adminBasisUpdate",method = RequestMethod.GET)
	public String basisUpdateGet(Model model) {
 		BasisVO vo = adminService.getBasis();
 		model.addAttribute("vo", vo);
		return "admin/extra/adminBasisUpdate";
	}
	@RequestMapping(value="/extra/adminBasisUpdate",method = RequestMethod.POST)
	public String basisUpdatePost(BasisVO vo) {
		adminService.setBasisUpdate(vo);
		return "redirect:/msg/basisUpdateOK";
	}
	@ResponseBody
	@RequestMapping(value="/joins/requestJoin",method=RequestMethod.POST)
	public String requestJoinPost(String requestIdx,String requestNum, String requestDetail) {
		String [] idx = requestIdx.split("/");
		String [] num = requestNum.split("/");
		String [] detail = requestDetail.split("/");
		JoinsRequestVO vo = new JoinsRequestVO();
		for(int i=0;i<idx.length;i++) {
			vo.setProductIdx(Integer.parseInt(idx[i]));
			vo.setProductNum(Integer.parseInt(num[i]));
			vo.setContent(detail[i]);
			joinsService.setJoinsRequest(vo);
		}
		return "";
	}
	
	@RequestMapping(value="/joins/adminRequestList",method=RequestMethod.GET)
	public String adminRequestListGet(Model model,
			@RequestParam(name="pag",defaultValue = "1",required = false)int pag,
			@RequestParam(name="pageSize",defaultValue = "10",required = false)int pageSize,
			@RequestParam(name="startDate",defaultValue = "",required = false)String startDate,
			@RequestParam(name="lastDate",defaultValue = "",required = false)String lastDate,
			@RequestParam(name="search",defaultValue = "",required = false)String search,
			@RequestParam(name="part",defaultValue = "",required = false)String part
			) {
		PageVO pageVo = pageProcess.totRecCnt(pag, pageSize, "request", 0, 0, startDate, lastDate, part, search);
		List<JoinsRequestVO> vos= joinsService.getRequestList(pageVo.getStartIndexNo(),pageVo.getPageSize(),startDate, lastDate, part, search);
		
		model.addAttribute("vos",vos);
		model.addAttribute("pageVo",pageVo);
		model.addAttribute("startDate",startDate);
		model.addAttribute("lastDate",lastDate);
		model.addAttribute("search",search);
		model.addAttribute("part",part);
		
		return "admin/joins/adminRequestList";
	}
	
	@ResponseBody
	@RequestMapping(value="/joins/adminJoinsProductUpdate",method = RequestMethod.POST)
	public String adminJoinsProductUpdatePost(JoinProductVO vo) {
		joinsService.setJoinProductUpdate(vo);
		return "";
	}
	@ResponseBody
	@RequestMapping(value="/joins/adminJoinsProductDelete",method = RequestMethod.POST)
	public String adminJoinsProductDeletePost(int idx) {
		joinsService.setJoinProductDelete(idx);
		return "";
	}
	@ResponseBody
	@RequestMapping(value="/extra/fileSelectDelete",method = RequestMethod.POST)
	public String fileSelectDeletePost(String delItems) {
		adminService.setFileDelete(delItems,"data/ckeditor");
		return "";
	}
	@ResponseBody
	@RequestMapping(value="/extra/tempFileSelectDelete",method = RequestMethod.POST)
	public String tempFileSelectDeletePost(String delItems) {
		adminService.setFileDelete(delItems,"data/ckeditor/adboard/temp");
		return "";
	}
	
	@RequestMapping(value="/refund/adminRefundList",method = RequestMethod.GET)
	public String refundListGet(HttpSession session,Model model,
			@RequestParam(name="pag",defaultValue = "1")int pag,
			@RequestParam(name="pageSize",defaultValue = "10")int pageSize,
			@RequestParam(name="startDate",defaultValue = "",required = false)String startDate,
			@RequestParam(name="lastDate",defaultValue = "",required = false)String lastDate,
			@RequestParam(name="search",defaultValue = "",required = false)String search,
			@RequestParam(name="part",defaultValue = "",required = false)String part,
			@RequestParam(name="refundSw",defaultValue = "99",required = false)int refundSw
			) {
		
		PageVO pageVo = pageProcess.totRecCnt(pag, pageSize, "refund", refundSw, 0, startDate, lastDate, part, search);
		List<RefundVO> vos = refundService.getRefundSearchList(pageVo.getStartIndexNo(),pageVo.getPageSize(),refundSw,startDate,lastDate,part,search);
		
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
		model.addAttribute("refundSw",refundSw);
		model.addAttribute("startDate",startDate);
		model.addAttribute("lastDate",lastDate);
		model.addAttribute("part",part);
		model.addAttribute("search",search);
		
		return "admin/refund/adminRefundList";
	}
	
	@RequestMapping(value="/refund/adminRefundUpdate",method = RequestMethod.GET)
	public String adminRefundUpdateGet(int idx,Model model) {
		RefundVO refundVo =  refundService.getRefund(idx);
		
		String delIdxs = refundVo.getOIdxs();
		
		List<OrdersVO> vos = new ArrayList<OrdersVO>();
		if(delIdxs.contains(",")) {
			for(String delIdx:delIdxs.split(",")) {
				vos.add(ordersService.getOrder(Integer.parseInt(delIdx)));
			}
		}
		else {
			vos.add(ordersService.getOrder(Integer.parseInt(delIdxs)));
		}
		model.addAttribute("refundVo", refundVo);
		model.addAttribute("ordersVos", vos);
		return "/admin/refund/adminRefundUpdate";
	}
	@ResponseBody
	@RequestMapping(value="/refund/refundUpdateOK",method = RequestMethod.POST)
	public String adminRefundUpdatePost(RefundVO vo) {
		refundService.setRefundUpdatePrice(vo);
		return "";
	}
	@ResponseBody
	@RequestMapping(value="/refund/adminRefundSwUpdate",method = RequestMethod.POST)
	public String adminRefundSwUpdate(String idxs, int refundSw) {
		idxs= idxs.substring(0,idxs.length()-1);
		if(idxs.contains("/")) { 
			for(String strIdx : idxs.split("/")) { //환불 고유번호 가져요기
				refundService.setRefundUpdateSw(Integer.parseInt(strIdx) , refundSw);
				if (refundSw>=2) {
					String oIdxs= refundService.getRefund(Integer.parseInt(strIdx)).getOIdxs();
					if(oIdxs.contains(",")) {
						for(String strOIdx : oIdxs.split(",")) {
							ordersService.setOrderUpdateSw(Integer.parseInt(strOIdx) , -1);
						}
					}
					else {
						ordersService.setOrderUpdateSw(Integer.parseInt(oIdxs) , -1);
					}
				}
				if (refundSw==3) { //포인트 적립, 포인트뺴기, 환불할때 사용한 쿠폰금액을 업데이트 시키기
					RefundVO refundVo = refundService.getRefund(Integer.parseInt(strIdx));
					String mid =  refundVo.getMid();
					memberService.setMemberPointUpdate(refundVo.getPlusPoint() , mid);
					memberService.setMemberPointUpdate(-refundVo.getMinusPoint() , mid);
					
					String orderIdx=refundVo.getOrderIdx();
					int couponUse= refundVo.getCouponUse();
					ordersService.setorderSubUpdateRefundCoupon(orderIdx,couponUse);
					
				}
				else if(refundSw==0) {
					String oIdxs= refundService.getRefund(Integer.parseInt(strIdx)).getOIdxs();
					if(oIdxs.contains(",")) {
						for(String strOIdx : oIdxs.split(",")) {
							ordersService.setOrderUpdateSw(Integer.parseInt(strOIdx) , 1);
						}
					}
					else {
						ordersService.setOrderUpdateSw(Integer.parseInt(oIdxs) , 1);
					}
					
				}
			}
		}
		else {
			refundService.setRefundUpdateSw(Integer.parseInt(idxs), refundSw);
			if (refundSw>=2) {
				String oIdxs= refundService.getRefund(Integer.parseInt(idxs)).getOIdxs();
				if(oIdxs.contains(",")) {
					for(String strOIdx : oIdxs.split(",")) {
						ordersService.setOrderUpdateSw(Integer.parseInt(strOIdx) , -1);
					}
				}
				else {
					ordersService.setOrderUpdateSw(Integer.parseInt(oIdxs) , -1);
				}
			}
			if (refundSw==3) { //포인트 적립, 포인트뺴기 ,환불시 사용한 쿠폰금액 업데이트
				RefundVO refundVo = refundService.getRefund(Integer.parseInt(idxs));
				String mid =  refundVo.getMid();
				memberService.setMemberPointUpdate(refundVo.getPlusPoint() , mid);
				memberService.setMemberPointUpdate(-refundVo.getMinusPoint() , mid);
				
				String orderIdx=refundVo.getOrderIdx();
				int couponUse= refundVo.getCouponUse();
				ordersService.setorderSubUpdateRefundCoupon(orderIdx,couponUse);
				
			}
			else if(refundSw==0) {
				String oIdxs= refundService.getRefund(Integer.parseInt(idxs)).getOIdxs();
				if(oIdxs.contains(",")) {
					for(String strOIdx : oIdxs.split(",")) {
						ordersService.setOrderUpdateSw(Integer.parseInt(strOIdx) , 1);
					}
				}
				else {
					ordersService.setOrderUpdateSw(Integer.parseInt(oIdxs) , 1);
				}
			}
		}
		return "";
	}
	@RequestMapping(value="/reviews/adminReviewsDelete")
	public String adminReviewsDeleteGet(int idx) {
		boardService.setBoardDelete(idx);
		return "redirect:/msg/adminReviewsDeleteOK";
	}
	@ResponseBody
	@RequestMapping(value="/coupons/couponDelete",method = RequestMethod.POST)
	public String couponDeletePost(int idx, String fSName) {
		JavawspringProvide js = new JavawspringProvide();
		js.deleteFile(fSName+".png", "data/ckeditor/coupons");
		couponsService.setCouponDelete(idx);
		return "";
	}
	
	@ResponseBody
	@RequestMapping(value="/extra/qnaDelete",method = RequestMethod.POST)
	public String qnaDelete(int idx) {
		qnaService.setQnaAdminDelete(idx);
		return "";
	}	@ResponseBody
	@RequestMapping(value="/product/productSellSwUpdate",method = RequestMethod.POST)
	public String productSellSwUpdatePost(int idx,String sellSw) {
		adminService.setProductSellSwUpdate(idx,sellSw);
		return "";
	}
	
	@RequestMapping(value="/extra/adminAnalize",method =RequestMethod.GET)
	public String adminAnalizeGet(Model model,
			@RequestParam(name ="startDate",defaultValue = "",required = false) String startDate ,
			@RequestParam(name ="lastDate",defaultValue = "",required = false) String lastDate,
			@RequestParam(name ="part",defaultValue = "",required = false) String part,
			@RequestParam(name ="search",defaultValue = "99",required = false) String search
			) {
		
		Calendar cal =Calendar.getInstance();
		if(lastDate.equals("")) {
		 lastDate = cal.get(Calendar.YEAR) + "-" + (cal.get(Calendar.MONTH)+1<10?"0"+(cal.get(Calendar.MONTH)+1):cal.get(Calendar.MONTH)+1)+"-"+(cal.get(Calendar.DAY_OF_MONTH)<10?"0"+(cal.get(Calendar.DAY_OF_MONTH)):(cal.get(Calendar.DAY_OF_MONTH)));
		}
		cal.add(Calendar.DATE , -7);
		 if (startDate.equals("")) {
			 startDate = cal.get(Calendar.YEAR) + "-" + (cal.get(Calendar.MONTH)+1<10?"0"+(cal.get(Calendar.MONTH)+1):cal.get(Calendar.MONTH)+1)+"-"+(cal.get(Calendar.DAY_OF_MONTH)<10?"0"+(cal.get(Calendar.DAY_OF_MONTH)):(cal.get(Calendar.DAY_OF_MONTH)));
		 }
		 cal.add(Calendar.DATE , +7);
		 
		 //카테고리별 판매량,수익 구하기
		 List<CategorySmallVO> cateVo =  chartService.getOrdersByCategory(startDate,lastDate,part,search);
		 model.addAttribute("cateVos",cateVo);
		 
		 
		 //가장많이 팔린 상품 7
		 List<ProductVO> productVos  =  chartService.getProductNameByOrder(startDate,lastDate,part,search);
		 model.addAttribute("productVos",productVos);
		 
		 
		 
		 int day_diff=0;
		 cal.set(Integer.parseInt(startDate.substring(0, 4)) ,Integer.parseInt(startDate.substring(5,7)),Integer.parseInt(startDate.substring(8, 10)));
		 //두 날짜 차이의 날짜 구하기
		try {
			Date format1 = new SimpleDateFormat("yyyy-MM-dd").parse(lastDate);
			Date format2 = new SimpleDateFormat("yyyy-MM-dd").parse(startDate);
			long diffSec = (format1.getTime() - format2.getTime()) / 1000; //초 차이
			day_diff = (int)diffSec / (24*60*60); //일자수 차이
		} catch (ParseException e) {
			e.printStackTrace();
		}
		 //꺾은선 그래프(수익)
		 String dates [] = new String [day_diff];
		 int prices [] = new int [day_diff];
		 
		 List<ChartVO> sellVos = new ArrayList<ChartVO>();
		 
		 for(int i=0;i<day_diff;i++) {
			 dates[i] = cal.get(Calendar.YEAR) + "-" + (cal.get(Calendar.MONTH)<10?"0"+(cal.get(Calendar.MONTH)):cal.get(Calendar.MONTH))+"-"+(cal.get(Calendar.DAY_OF_MONTH)<10?"0"+(cal.get(Calendar.DAY_OF_MONTH)):(cal.get(Calendar.DAY_OF_MONTH)));
			 prices[i]=  chartService.getTotalSellPrice(dates[i],"OK",part,search); //구독상품
			 ChartVO chartVo = new ChartVO();
			 chartVo.setDate(dates[i]);
			 chartVo.setPrice1(prices[i]);
			 prices[i]=  chartService.getTotalSellPrice(dates[i],"",part,search); //단품상품
			 chartVo.setPrice2(prices[i]);
			 //누적 구독 수 구하기
			 String datesPlus = cal.get(Calendar.YEAR) + "-" + (cal.get(Calendar.MONTH)<10?"0"+(cal.get(Calendar.MONTH)):cal.get(Calendar.MONTH))+"-"+((cal.get(Calendar.DAY_OF_MONTH)+1<10?"0"+(cal.get(Calendar.DAY_OF_MONTH)+1):(cal.get(Calendar.DAY_OF_MONTH)+1)));
			 
			 chartVo.setCnt(chartService.getSubscribeCnt(datesPlus,part,search));
			 
			 sellVos.add(chartVo);
			 cal.add(Calendar.DATE , 1);
		 }
		 model.addAttribute("sellVos",sellVos);
		 
		 model.addAttribute("search",search);
		 
		 model.addAttribute("startDate",startDate);
		 model.addAttribute("lastDate",lastDate);
		return "admin/extra/adminAnalize";
	}
	@RequestMapping(value="/joins/adminJoinsExit",method=RequestMethod.GET)
	public String adminJoinsExitGet(int idx) {
		joinsService.setJoinSwUpdate(idx,-2);
		return "redirect:/msg/adminJoinsExitOK";
	}
	@ResponseBody
	@RequestMapping(value="/joins/adminjoinsReply",method=RequestMethod.POST)
	public String adminjoinsReplyPost(int idx) {
		joinsService.setJoinSwUpdate(idx,1);
		return "";
	}
	@ResponseBody
	@RequestMapping(value="/extra/qnaUpdateLevel",method = RequestMethod.POST)
	public String qnaUpdateLevelPost(int idx,String answer,HttpSession session) {
		qnaService.setQnaUpdateAnswer(idx,answer);
		qnaService.setQnaUpdateLevel(idx,0);
		
		return "";
	}
	
	@RequestMapping(value="/extra/adminQnaFAQ",method = RequestMethod.GET )
	public String adminQnaFAQGet(Model model) {
		List<QnaVO> vos =  qnaService.getFAQList();
		model.addAttribute("vos", vos);
		return "admin/extra/adminQnaFAQ";
	}
	@ResponseBody
	@RequestMapping(value="/extra/qnaFAQDelete",method = RequestMethod.POST)
	public String qnaFAQDeletePost(String idxs) {
		idxs= idxs.substring(0, idxs.length()-1);
		if(idxs.contains("/")) {
			for(String strIdx:idxs.split("/")) {
				qnaService.setQnaUpdateLevel(Integer.parseInt(strIdx) ,1) ;
			}
		}
		else {
			qnaService.setQnaUpdateLevel(Integer.parseInt(idxs) ,1);
		}
		return "";
	}
	
	@RequestMapping(value="/servey/adminServeyInput",method = RequestMethod.GET)
	public String adminServeyInputGet(Model model,
			@RequestParam(name="idx" ,defaultValue = "0" ,required=false) int idx
			) {
		
		model.addAttribute("idx", idx);
		return "admin/servey/adminServeyInput";
	}	
	@RequestMapping(value="/servey/adminServeyUpdate",method = RequestMethod.GET)
	public String adminServeyUpdateGet(Model model,
			@RequestParam(name="idx" ,defaultValue = "0" ,required=false) int idx
			) {
		
		model.addAttribute("idx", idx);
	  model.addAttribute("vo",serveyService.getServey(idx)) ;
	  
  	List<QuestionVO> questionVos =  serveyService.getServeyQuestions(idx);
  	model.addAttribute("questionVos", questionVos);
  	
  	List<AnswerVO> answerVos = serveyService.getServeyAnswers(idx,"","");
  	model.addAttribute("answerVos", answerVos);
	  
		return "admin/servey/adminServeyUpdate";
	}	
	
	@RequestMapping(value="/servey/adminServeyInput",method = RequestMethod.POST)
	public String adminServeyInputPost(Model model,ServeyVO vo
			) {
		vo.setShowSw(1);
		serveyService.setServeyInput(vo);
		int idx = serveyService.getLastIdx();
		return "redirect:/msg/serveyInput?flag="+idx;
	}	
	
	@ResponseBody
	@RequestMapping(value="/servey/serveyAnswerInput",method = RequestMethod.POST)
	public String serveyInputPost(QuestionVO vo) {
		serveyService.setServeyQuesionInput(vo);
		return "";
	}
	@ResponseBody
	@RequestMapping(value="/servey/serveyAnswerInputOK",method = RequestMethod.POST)
	public String serveyAnswerInputOKPost(AnswerVO vo) {
		serveyService.setServeyAnswerInput(vo);
		return "";
	}
	@ResponseBody
	@RequestMapping(value="/servey/serveyAnswerDeleteOK",method = RequestMethod.POST)
	public String serveyAnswerDeleteOKPost(int idx) {
		serveyService.setServeyAnswerDelete(idx);
		return "";
	}
	@ResponseBody
	@RequestMapping(value="/servey/serveyQuestionDeleteOK",method = RequestMethod.POST)
	public String serveyQuestionDeleteOKPost(int idx) {
		serveyService.setServeyQuestionDelete(idx);
		return "";
	}
	
	@ResponseBody
	@RequestMapping(value="/servey/serveyQuestionUpdateOK",method = RequestMethod.POST)
	public String serveyQuestionUpdateOKPost(QuestionVO vo) {
		serveyService.setServeyQuestionUpdate(vo);
		return "";
	}
	
	@RequestMapping(value="/servey/adminServeyList",method = RequestMethod.GET)
	public String adminServeyListGet(Model model) {
		List<ServeyVO> vos =  serveyService.getServeys(99);
		model.addAttribute("vos",vos);
		
		return "admin/servey/adminServeyList";
	}
	@RequestMapping(value="/servey/adminServeyResult",method = RequestMethod.GET)
	public String adminServeyResultGet(int idx, Model model,
			@RequestParam(name="part",defaultValue = "") String part,
			@RequestParam(name="smallPart",defaultValue = "")String smallPart
			) {
		
		model.addAttribute("idx", idx);
	  model.addAttribute("vo",serveyService.getServey(idx)) ;
	  
  	List<QuestionVO> questionVos =  serveyService.getServeyQuestions(idx);
  	model.addAttribute("questionVos", questionVos); 
  	
  	List<AnswerVO> answerVos = serveyService.getServeyAnswers(idx,part,smallPart);
  	model.addAttribute("answerVos", answerVos); 
		
  	//선택지가 없는경우도 있다
  	List<RealAnswerVO> realAnswerVos = serveyService.getRealAnswer(idx,part,smallPart);
  	
  	model.addAttribute("realAnswerVos", realAnswerVos); 
  	model.addAttribute("part", part); 
  	model.addAttribute("smallPart", smallPart); 
		
  	if(!part.equals("")) {
	  	List<String> smalls = serveyService.getRealAnswerSmallPart(idx,part);
	  	model.addAttribute("smalls", smalls); 
  	}
  	
		return "admin/servey/adminServeyResult";
	}
	@ResponseBody
	@RequestMapping(value="/servey/serveyGetSmallpart",method =RequestMethod.POST,produces="application/text; charset=utf8")
	public String serveyGetSmallPart(int idx, String part) {
		List<String> smalls = serveyService.getRealAnswerSmallPart(idx,part);
		
		String str ="";
		for(String small:smalls) {
			str+=small+"_";
		}
		
		return str.substring(0, str.length()-1);
	}
	@RequestMapping(value="/servey/adminServeyUpdate",method = RequestMethod.POST)
	public String adminServeyUpdatePost(ServeyVO vo) {
		serveyService.setServeyUpdate(vo);
		
		return "redirect:/msg/serveyUpdateOK?flag="+vo.getIdx();
	}
	
	
	
}
