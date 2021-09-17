package com.project.controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.service.ReviewBoardService;
import com.project.util.FileUtil;
import com.project.util.Log;
import com.project.vo.ReviewBoardVO;

import lombok.extern.log4j.Log4j;
import net.webjjang.util.PageObject;

@Controller
@Log4j
@RequestMapping("/reviewBoard")
//@AllArgsConstructor
public class ReviewBoardController {
	
	private final String MODULE = "reviewBoard";
	
	//@AllArgsConstructor 를 이용한 자동 DI사용
	@Autowired
	@Qualifier("reviewBoardServiceImpl")
	private ReviewBoardService service;
	
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
		return MODULE + "/list";
	}

	@RequestMapping(value="/view")
	public String view(Model model, int no, int inc) {
		log.info("Controller.view()...");
		model.addAttribute("vo", service.view(no, inc));
		log.info("Controller.list()... no : " + no + ", inc" + inc);
		
		return MODULE + "/view";
	}
	
	@RequestMapping(value = "/write")
	public String write() {
		
		return MODULE + "/write";
	}
	
	@RequestMapping(value = "/writeAction")
	   public String writeAction(ReviewBoardVO vo, MultipartFile imageFile, RedirectAttributes rattr, HttpServletRequest request) throws IllegalStateException, IOException{
	      try {
	         String path = "/resources/images/review/";
	         
	         String realPath = request.getServletContext().getRealPath(path);
	            
	          String fileName = imageFile.getOriginalFilename();
	            
	          // 저장 할려는 파일 시스템의 실제 위치와 파일명 찾기
	          String saveFileName = FileUtil.checkDuplicate(realPath + fileName);
	            
	          // 실제적으로 실제 위치와 파일명으로 저장해야 한다.
	          // request안에 data로 담겨있는 파일 내용을 실제적인 파일로 저장
	          imageFile.transferTo(new File(saveFileName));
	          // 서버에 올라간 파일명만 가져오기 - path 없음.
	          String uploadFileName = saveFileName.substring(saveFileName.lastIndexOf("\\")+1);
	            
	          vo.setFileName(uploadFileName);
	            
	          service.write(vo);
	          
	          //글 쓰기 정상처리 표시 데이타 셋팅
	          rattr.addFlashAttribute("writeAction", "write success");
	            
	          return "redirect:list";
	      } catch (Exception e) {
	         e.printStackTrace();
	      }
	      service.write(vo);
	      rattr.addFlashAttribute("writeAction", "write success");
	      return "redirect:list";
	   }
	
	@RequestMapping(value = "/update")
	public String update(Model model, ReviewBoardVO vo) {
		model.addAttribute("vo", vo);
		
		return MODULE + "/update";
	}
	
	@RequestMapping(value = "/updateAction")
	public String updateAction(ReviewBoardVO vo) {
		service.update(vo);
		
		return "redirect:list";
	}
	
	@RequestMapping(value = "/deleteAction")
	public String delete(Model model, int no, RedirectAttributes rattr) {
		service.delete(no);
		
		rattr.addFlashAttribute("deleteAction", "delete success");
		
		return "redirect:list";
	}
	
	@RequestMapping(value="/comment")
	public String comment(Model model, int no, int inc) {
		
		model.addAttribute("no", no);
		service.view(no, inc);
		model.addAttribute("vo", service.view(no, inc));
		
		return MODULE + "/comment";
	}
	
	@RequestMapping(value="/addComment")
	public String addComment(ReviewBoardVO vo, Model model) {
		
		service.addComment(vo);
		
		return "redirect:list";
	}
	
	
	
}
