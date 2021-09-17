package com.project.controller;

import java.io.File;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.MDC;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;
import org.springframework.web.servlet.ModelAndView;

import com.project.service.BoardService;
import com.project.service.MemberService;
import com.project.vo.BoardVO;
import com.project.vo.MemberVO;

@Controller

public class BoardController{
	
	@Autowired
	BoardService service;
	
	
	@RequestMapping(value = "/board/list.do", method = RequestMethod.GET)
	public ModelAndView home(HttpServletRequest request) {
		List<com.project.vo.BoardVO> boardList; // 10개씩보는거 limit 10 offset
		
		//List<MemberVO>memberList = memberService.selectAll();
		//boolean hasImg = memberService.hasImgFile();
		
		List<com.project.vo.BoardVO> boardAsWhole; // 한페이지에 전체 다나오는리스트
		ModelAndView mav = new ModelAndView();
		try {
			
			int limit = 10; // 한페이지에 몇개의 게시글을 담을수있나
			int page = 1;//default 페이지
			try {
				if(request.getParameter("page")!= null) {
					page = Integer.parseInt(request.getParameter("page"));//NumberFormatException
				}
			}catch(NullPointerException e) {
				page = 1;
			}
			//limit 10 offset 0 
			//
			
			int offset = (page-1)*10; //몇번째 글부터 보여줄까요?
			
			int countPage = 10;// 한화면에 몇페이지까지 보여줄지 적는거.
			
			int startPage = ((page - 1) / 10) * 10 + 1; //시작페이지 (1)
			
			int endPage = startPage + countPage -1;//끝페이지  
			
			
			
			
			
			boardList = service.selectAll2(limit, offset); //nullpointerException
			boardAsWhole = service.selectList(); // 총몇페이지 인지를 알기위한 전체 게시글 수
			
			int totalcnt = boardAsWhole.size();
			int totalPage = totalcnt / 10;


			if (totalcnt % 10 > 0) {
				totalPage++;
			}
			if (totalPage < page) {
				page = totalPage;
			}
			
			
			//마지막페이지 보정
			if (endPage > totalPage) {
				endPage = totalPage;
			}
			mav.setViewName("list");
			mav.addObject("boardList", boardList);
			
			//request.setAttribute("memberList", memberList);
			//request.setAttribute("hasImg", hasImg);
			request.setAttribute("service",service);
			request.setAttribute("boards",boardAsWhole);
			request.setAttribute("page", page);
			request.setAttribute("startPage", startPage);
			request.setAttribute("endPage", endPage);
			request.setAttribute("totalPage", totalPage);
			request.getSession().setAttribute("boardList", boardList);
			System.out.println(boardList);
			
			return mav;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	
	@RequestMapping(value = "/board/view.do", method = RequestMethod.GET)
	public ModelAndView read(@RequestParam int bno, HttpServletRequest request) {
		
		service.increaseViewCountAction(bno);
		
		BoardVO board = service.readAction(bno);
		System.out.println(board.toString());
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("view");
		request.setAttribute("board", board);
		return mav;
	}


	
	@RequestMapping(value = "/board/update.do", method = RequestMethod.GET)
	public String updateBoard(int bno, Model model) {
		model.addAttribute("bno", bno);
		
		
		return "update";
	}
	
	@RequestMapping(value = "/board/updateAction.do", method = RequestMethod.POST)
	public String updateActionBoard(BoardVO vo, Model model, HttpSession session) {
		
		String filenameTotal = "";
		
		String filepath = session.getServletContext().getRealPath("/resources/images/");
		
		
		//MultipartRequest multi = new MultipartRequest() 
		
		MultipartFile [] arrMultipart = vo.getMultiparts();
				
		String [] arrFilename = new String[arrMultipart.length]; //nullpointer exception
		//serializeFilenames = arrFilename.toString();
		for(int i = 0 ; i  <= arrMultipart.length-1; i++) {
			MultipartFile multipart = arrMultipart[i];
			String filename = "(이름없음)";
			
			//multipart, filename, transferTo()
			if(!multipart.isEmpty()) {
				filename = multipart.getOriginalFilename();
				//System.out.println("filename: " + filename);
				File file = new File(filepath, filename);
				if(!file.exists()) {
					file.mkdirs();
				}
				try {
					multipart.transferTo(file);//파일저장.
				}catch (Exception e) {
					e.printStackTrace();
				} 
			}
			arrFilename[i] = filename;
			filenameTotal += filename+"_";
		}
		
		vo.setFile(filenameTotal);
		
		System.out.println("filename: " + vo.getFile());
		
		BoardVO board = service.readAction(vo.getBno());
		
		if(board.getWriter().equals((String)session.getAttribute("userid"))) {
			if(vo.getFile().equals("(이름없음)")) {
				System.out.println("회원이 첨부한 파일이없는경우");
				service.updateBoardActionWOFile(vo);
				model.addAttribute("vo",vo);
				model.addAttribute("updateSucceed", "succeed");
				return "redirect:./list.do";
			}else {
				System.out.println("회원이 첨부한 파일이 있는경우");
				
				service.updateBoardActionWithFile(vo);
				model.addAttribute("vo",vo);
				model.addAttribute("updateSucceed", "succeed");
				return "redirect:./list.do";
			}
		
		}else {
			System.out.println("수정권한이 없는경우");
			model.addAttribute("updateFail","fail");
			model.addAttribute("bno",vo.getBno());
			return "update";
		}
		
	}
	
	
	@RequestMapping(value = "/board/write.do", method = RequestMethod.GET)
	public String write() {
		return "write";
	}
	
	
	@RequestMapping(value = "/board/writeAction.do", method = RequestMethod.POST)
	public String writeAction(BoardVO vo, Model model, HttpSession session) throws Exception {
		String filenameTotal = ""; //이게 제 db에들어갈 board 테이블 file 컬럼값
		
		String filepath = session.getServletContext().getRealPath("/resources/images/");
		
		
		//MultipartRequest multi = new MultipartRequest() 
		
		MultipartFile [] arrMultipart = vo.getMultiparts();
				
		String [] arrFilename = new String[arrMultipart.length]; //nullpointer exception
		//serializeFilenames = arrFilename.toString();
		for(int i = 0 ; i  <= arrMultipart.length-1; i++) {
			MultipartFile multipart = arrMultipart[i];
			String filename = "(이름없음)";
			
			
			if(!multipart.isEmpty()) {
				filename = multipart.getOriginalFilename();
				System.out.println("filename: " + filename);
				File file = new File(filepath, filename);
				if(!file.exists()) {
					file.mkdirs();
				}
				multipart.transferTo(file); //파일저장.
			}
			arrFilename[i] = filename;
			filenameTotal += filename+"_";
		}
		
		vo.setFile(filenameTotal);
		
		System.out.println("fileNames가들어갔을까?"+ vo.toString());
		
		service.writeAction(vo);
		
		model.addAttribute("vo",vo);
		
		return "redirect:./list.do";
	}
	
	@RequestMapping(value = "/board/delete.do", method = RequestMethod.GET)
	public String deleteBoard(@RequestParam int bno, HttpSession session, Model model) {
		
		BoardVO board = service.readAction(bno);
		
		if(board.getWriter().equals((String)session.getAttribute("userid"))) {
			System.out.println("삭제권한이 있는경우");
			service.deleteBoardAction(bno);
			model.addAttribute("delete", "delete");
			return "redirect:./list.do";
		}else {
			System.out.println("삭제권한이 없는경우");
			model.addAttribute("board", board);
			model.addAttribute("deactivateDeletion", "deactivateDeletion");
			return "view";
		}
		
	}
	
	/*댓글달기*/
	@RequestMapping(value = "/board/reply.do", method = RequestMethod.GET)
	public String replyBoard(@RequestParam int bno, HttpServletRequest request) {
		request.setAttribute("bno",bno);
		BoardVO board = service.readAction(bno);
		request.setAttribute("board", board);
		return "reply";
	}
	
	/*댓글ACtion*/
	
	@RequestMapping(value= {"/board/replyAction.do"},method = RequestMethod.POST,
			consumes = MediaType.APPLICATION_JSON_UTF8_VALUE,
			headers = {"Accept=application/json"})
	@ResponseBody //
	public String replyBoard(@RequestBody BoardVO vo, Model model) {
		
		service.addComment(vo);
		return "";
	//	return JSONResult.success() ;
	}
	
	
}
