package com.spring.green2209S_20;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.filefilter.FalseFileFilter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.mysql.jdbc.jdbc2.optional.SuspendableXAConnection;
import com.spring.green2209S_20.pagenation.PageProcess;
import com.spring.green2209S_20.pagenation.PageVO;
import com.spring.green2209S_20.service.AdminService;
import com.spring.green2209S_20.service.OrdersService;
import com.spring.green2209S_20.service.ServeyService;
import com.spring.green2209S_20.service.SubscribeService;
import com.spring.green2209S_20.vo.ProductVO;
import com.spring.green2209S_20.vo.ServeyVO;
@Controller
public class HomeController {
	
	@Autowired 
	OrdersService ordersService;
	
	@Autowired PageProcess pageProcess;
	
	@Autowired ServeyService serveyService;
	
	@Autowired
	SubscribeService subscribeService;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@RequestMapping(value = {"/","h"}, method = RequestMethod.GET)
	public String home(Locale locale, Model model,HttpServletRequest request,HttpServletResponse response) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		
		model.addAttribute("serverTime", formattedDate );
		
		serveyService.setServeySwAutoUpdate();
		
		PageVO pageVo = pageProcess.totRecCnt(1, 12, "product", 2, 1, "", "");
		ArrayList<ProductVO> vos = ordersService.getProductList(2,1,pageVo.getStartIndexNo(),pageVo.getPageSize(),"");

		model.addAttribute("vos", vos);
		
		List<ServeyVO> serveyVos = serveyService.getServeys(1);
		
		Cookie[] cookies = request.getCookies();
		
		if(serveyVos.size()!=0) {
			for(int i=0;i<serveyVos.size();i++) {
				if(cookies!=null) {
					for(int j =0;j<cookies.length;j++) {
						String imsi = "servey"+serveyVos.get(i).getIdx();
						if(cookies[j].getName().equals(imsi)) {
							serveyVos.remove(i);
							break;
						}
					}
				}
				
				model.addAttribute("serveyVos",serveyVos);
			}
		}
		
		return "home";
	}
	@RequestMapping(value= "/introduce/introduce", method=RequestMethod.GET)
	public String introduceGet() {
		return "introduce/introduce";
	}
	
	@RequestMapping("/imageUpload")
	public void imageUploadGet(MultipartFile upload,
			HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		String oFileName = upload.getOriginalFilename();
		
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
		oFileName =sdf.format(date)+"_"+oFileName;
		
		byte [] bytes = upload.getBytes();
		
		//ckeditor에서 올린(전송) 파일을 서버파일 시스템에 실제로 저장할 경로를 결정한다.
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/ckeditor/");
		OutputStream os = new FileOutputStream(new File(realPath+oFileName)); 
		os.write(bytes);
		
		//서버 파일시스템에 저장되어있는 파일을 브라우저 편집 화면에 보여주기 위한 작업
		PrintWriter out = response.getWriter();
		String fileUrl = request.getContextPath()+"/data/ckeditor/"+oFileName;
		out.println("{\"originalFilename\":\""+oFileName+"\",\"uploaded\":1,\"url\":\""+fileUrl+"\"}");
		
		out.flush();
		os.close();
	}
	
	@RequestMapping("/searchProductList")
	public String searchProductList(String search,Model model,
			@RequestParam(name="orderBy",defaultValue = "idx",required =false) String orderBy
			) {
		List<ProductVO> vos = subscribeService.getProductList(search,orderBy);
		
		for(int i=0;i<vos.size();i++) {
			ProductVO vo =  vos.get(i);
			if(vo.getCodeLarge()==1) vo.setFlag("subscribe");
			else vo.setFlag("orders");
			vos.set(i, vo);
		}
		
		model.addAttribute("vos", vos);
		model.addAttribute("cnt", vos.size());
		model.addAttribute("search",search);
		model.addAttribute("orderBy",orderBy);
		
		
		return "/searchProductList";
	}
	@RequestMapping("/error404")
	public String error404Get() {
		return "/error404";
	}
	@RequestMapping("/error500")
	public String error500Get() {
		return "/error500";
	}
	
}
