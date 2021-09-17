package com.project.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.service.StudyService;
import com.project.util.Log;
import com.project.vo.StudyVO;

import lombok.extern.log4j.Log4j;
import net.webjjang.util.PageObject;

@Controller
@Log4j
@RequestMapping("/Study")
public class StudyController {
	
	private final String MODULE = "admin";
	
	@Autowired
	@Qualifier("studyServiceImpl")
	private StudyService service;
	
	@RequestMapping(value = "/list")
	public String list(Model model, PageObject pageObject) throws IOException {
		
		Log logging = new Log();
		
		log.info("Controller.list()...");
		// ${list} == ${requestScope.list} 이건 request에서만 찾아서 보안상 적합
		model.addAttribute("list", service.list(pageObject));
		// 하단 부분의 페이지네이션 처리를 위해서 pageObject가 꼭 필요합니다.
		// 2페이지 이상이 되면 표시한다.
		model.addAttribute("pageObject", pageObject);
		
		logging.Logging(log);
		return MODULE + "/studyvlist";
	}
	
	@RequestMapping(value = "/StudyWrite")
	public String write(Model model) throws IOException {
		return MODULE + "/studyvwrite";
	}

	@RequestMapping(value = "/writeAction")
	public String writeAction(@ModelAttribute StudyVO vo, String url) throws IOException {
		if(url.contains("/")) {
		String realurl = "";
		String[] url1= url.split("/");
		realurl=url1[url1.length-1];
		vo.setUrl(realurl);
		}
		service.Vwrite(vo);
		return "redirect:list";
	}
	
	@RequestMapping(value = "/update")
	public String update(Model model, String menu) throws IOException {
		model.addAttribute("list", service.Updatelist(menu));
		return MODULE + "/studyvupdate";
	}
	
	@RequestMapping(value = "/UpdateAction")
	public String UpdateAction(@ModelAttribute StudyVO vo, String url, String menu) throws IOException {
		if(url.contains("/")) {
			String realurl = "";
			String[] url1= url.split("/");
			realurl=url1[url1.length-1];
			vo.setUrl(realurl);
		}
		service.Vupdate(vo, menu);
		return "redirect:list";
	}

	@RequestMapping(value = "/delete")
	public String delete(String menu) throws IOException {
		service.Vdelete(menu);
		return "redirect:list";
	}
	
	@RequestMapping(value = "/studyflist")
	public String studyflist(Model model, PageObject pageObject) throws IOException {
		
		Log logging = new Log();
			
		log.info("Controller.list()...");
		// ${list} == ${requestScope.list} 이건 request에서만 찾아서 보안상 적합
		model.addAttribute("list", service.flist(pageObject));
		// 하단 부분의 페이지네이션 처리를 위해서 pageObject가 꼭 필요합니다.
		// 2페이지 이상이 되면 표시한다.
		model.addAttribute("pageObject", pageObject);
		logging.Logging(log);
		return MODULE + "/studyflist";
	}
	
	@RequestMapping(value = "/studycontent")
	public String studycontent(String menu, Model model) throws IOException {
		model.addAttribute("menu", service.flist(menu));
		return MODULE + "/studyfcontent";
	}
	
	@RequestMapping(value = "/download")
	public void download(String filename, HttpServletRequest request, HttpServletResponse response) throws IOException {
		String fileName = request.getParameter("filename");
		String realFolder= request.getServletContext().getRealPath("/resources/data");
		File file = new File(realFolder, fileName);
		
	  FileInputStream fileInputStream = null;
	  ServletOutputStream servletOutputStream = null;
	 
	    try{
	        String downName = null;
	        String browser = request.getHeader("User-Agent");
	        //파일 인코딩
	        if(browser.contains("MSIE") || browser.contains("Trident") || browser.contains("Chrome")){//브라우저 확인 파일명 encode  
	            
	            downName = URLEncoder.encode(fileName,"UTF-8").replaceAll("\\+", "%20");
	            
	        }else{
	            
	            downName = new String(fileName.getBytes("UTF-8"), "ISO-8859-1");
	            
	        }
	        
	        response.setHeader("Content-Disposition","attachment;filename=\"" + downName+"\"");             
	        response.setContentType("application/octer-stream");
	        response.setHeader("Content-Transfer-Encoding", "binary;");
	 
	        fileInputStream = new FileInputStream(file);
	        servletOutputStream = response.getOutputStream();
	 
	        byte b [] = new byte[1024];
	        int data = 0;
	 
	        while((data=(fileInputStream.read(b, 0, b.length))) != -1){	
	            servletOutputStream.write(b, 0, data);   
	        }	 
	        servletOutputStream.flush();//출력
	        
	    }catch (Exception e) {
	        e.printStackTrace();
	    }finally{
	        if(servletOutputStream!=null){
	            try{
	                servletOutputStream.close();
	            }catch (IOException e){
	                e.printStackTrace();
	            }
	        }
	        if(fileInputStream!=null){
	            try{
	                fileInputStream.close();
	            }catch (IOException e){
	                e.printStackTrace();
	            }
	        }
		}
	}
}