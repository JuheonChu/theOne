package com.project.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.http.HttpResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.project.service.BoardService;
import com.project.service.FranchisePdtApprovalService;
import com.project.service.IncomeService;
import com.project.service.InventoryService;
import com.project.service.MemberService;
import com.project.service.ProductService;
import com.project.service.RequestOrderService;
import com.project.service.TempService;
import com.project.util.KakaoGeoApi1;
import com.project.vo.BoardVO;
import com.project.vo.FranchisePdtApprovalVO;
import com.project.vo.IncomeVO;
import com.project.vo.InventoryVO;
import com.project.vo.RequestOrderVO;
import com.project.vo.TempVO;

@RestController
@RequestMapping(value="/rest2", produces = "application/json;charset=utf-8")
public class MyRestController {
	@Autowired
	BoardService boardService;
	@Autowired
	MemberService memberService;
	
	@Autowired
	ProductService productservice;
	
	@Autowired
	TempService tempservice;//LaunchBusinessService + HeadQuartermanagerService합친거
	
	@Autowired
	RequestOrderService service;
	
	@Autowired
	InventoryService inventoryservice;
	
	@Autowired
	IncomeService incomeservice;
	
	@Autowired
	FranchisePdtApprovalService dummyservice;
	
	@RequestMapping(value = "/vo/reply", produces = "application/json; charset=utf-8")
	public  Map<String, Object>  rest2(BoardVO vo, HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
		try {
			request.setCharacterEncoding("UTF-8");
			response.setContentType("text/html; charset=utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		String title = vo.getTitle();
		String content = vo.getContent();
		String writer = vo.getWriter();
		
		
		title = URLDecoder.decode(title,"UTF-8");//한글
		content= URLDecoder.decode(content,"UTF-8");
		writer = URLDecoder.decode(writer, "UTF-8");
		
		vo.setTitle(title);
		vo.setContent(content);
		vo.setWriter(writer);
		
		System.out.println("param으로 넘어온 BoardVO 객체 : " + vo);
		
		boardService.addComment(vo); //댓글을 달아줍니다 
		
		HashMap<String,Object> commentRes = new HashMap<String,Object>();
		commentRes.put("bno", vo.getBno());
		commentRes.put("ref", vo.getRef());
		commentRes.put("step", vo.getStep());
		commentRes.put("level", vo.getLevel());
		commentRes.put("title", vo.getTitle());
		commentRes.put("content", vo.getContent());
		commentRes.put("writer", vo.getWriter());
		
		return commentRes;
	}

	@RequestMapping("/vo/login/json")
	@ResponseBody
	public Map<String,String> rest4(@RequestBody Map<String,String>param){
		//ystem.out.println("전달된  ");
		return null;
		
	}
	
	@RequestMapping(value = {"/vo/signup/businesslaunch","/vo/signup/businesslaunch.json"}, produces = "application/json; charset=utf-8")
	public  Map<String, Object>  signupForBusinessLauncher(TempVO vo, /*LaunchbusinessVO vo,*/ HttpServletRequest request, HttpServletResponse response,String emaildomain) throws UnsupportedEncodingException {
		try {
			request.setCharacterEncoding("UTF-8");
			
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		System.out.println("작성된 launchBusinessVO 객체 : " + vo.toString());
		
		String email = vo.getEmail()+"@"+emaildomain;
		System.out.println("email: " + email);
		vo.setEmail(email);
		
	//	vo.setMember_index(member_index);
		
		//launchService.signuplaunchForm(vo);
		tempservice.signuplaunchForm(vo);
		return null;
	}
	
	
	@RequestMapping(value = {"/vo/approveBusiness.do","/vo/approveBusiness.json"}, produces = "application/json; charset=utf-8")
	@ResponseBody
	public  Map<String, Object>  approveBusiness(@RequestBody Map<String,Object>map, HttpServletRequest request) throws UnsupportedEncodingException, IllegalArgumentException, ClassNotFoundException {
		try {
			request.setCharacterEncoding("UTF-8");
			
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		Map<String,Object> map2 = new HashMap<String,Object>();
		map2 = map;
		Set<String> keySet = map2.keySet();
		java.util.Iterator<String> iterator = keySet.iterator();
		while(iterator.hasNext()) {
			System.out.println(map2.get(iterator.next()));
		}
		
		
		
		
		int contractno = Integer.parseInt(((String) map2.get("contractno")).trim());
	//	String disable = ((String)(map2.get("disable"))).trim();

	//	TempVO myown= tempservice.findmyBusiness(contractno);
		
	
		
//////////////////////////////////////////////////////////////////////////		
		tempservice.updateStatus(contractno); // waiting ---> approved
		
		
		TempVO business = tempservice.findmyBusiness(contractno);
		String mymenu = business.getSelectmenu();
		
	
		
		
		request.setAttribute("disabled", true);
		
		
		return map2;
		
		
	}
	
	
	@RequestMapping(value = {"/vo/order/product/to/hq","/vo/order/product/to/hq.json"}, produces = "application/json; charset=utf-8")
	@ResponseBody
	public  Map<String, Object> requestResources(@RequestBody Map<String,Object>map, HttpServletRequest request) throws UnsupportedEncodingException, IllegalArgumentException, ClassNotFoundException {
		try {
			request.setCharacterEncoding("UTF-8");
			
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		Map<String,Object> map2 = new HashMap<String,Object>();
		map2 = map;
		//Set<String> keySet = map2.keySet();
		//java.util.Iterator<String> iterator = keySet.iterator();
		
		System.out.println(map2.get("quantity"));
		System.out.println(map2.get("price"));
		System.out.println(map2.get("imgsrc"));
		//System.out.println(map2.get("franchisekey"));
		System.out.println(map2.get("pid"));
		System.out.println(map2.get("status"));
		System.out.println(map2.get("available"));
		
		RequestOrderVO vo = new RequestOrderVO();
		vo.setAvailable(0);
		vo.setPid(Integer.parseInt(((String) map2.get("pid")).trim()));
		vo.setReqCount(Integer.parseInt(((String) map2.get("quantity")).trim()));
		vo.setRid((String)map2.get("franchisekey"));
		vo.setStatus("waiting");
		System.out.println(vo.toString());
		
		service.insertOrder(vo);
		
		return map2;
		
		
	}
	
	
	
	@RequestMapping(value = {"/vo/ratify/inventory/to/franchise","/vo/ratify/inventory/to/franchise.json"}, produces = "application/json; charset=utf-8")
	@ResponseBody
	public  Map<String, Object> approveInventory(@RequestBody Map<String,Object>map,  HttpServletRequest request, HttpSession session) throws UnsupportedEncodingException, IllegalArgumentException, ClassNotFoundException {
		try {
			request.setCharacterEncoding("UTF-8");
			
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		int quantity = Integer.parseInt((String)map.get("quantity").toString().trim());
		int price = Integer.parseInt((String)map.get("price").toString().trim());
		String imgsrc = (String)map.get("imgsrc").toString().trim();
		String franchisekey = (String)map.get("franchisekey").toString().trim();
		int pid = Integer.parseInt((String)map.get("pid").toString().trim());
		String status = (String)map.get("status").toString();
		String random = (String)map.get("random").toString();
		int available = 0;
		int contractno = Integer.parseInt((String)map.get("contractno").toString().trim());
		int req_orderid = Integer.parseInt((String)map.get("req_orderid").toString().trim());
		
		System.out.println("넘어온 값들은 ? quantity: " + quantity + ", price : " + price + " imgsrc : " + imgsrc + " franchisekey : " +
		franchisekey + " pid: " + pid + ", status : " + status + "random : " + random + "req_orderid: " + req_orderid);
		
		FranchisePdtApprovalVO dumb = new FranchisePdtApprovalVO();
		dumb.setFranchisekey(franchisekey);
		dumb.setReq_orderid(req_orderid);
		//request
		dummyservice.insertDummy(dumb); // 재고승인받았다라는것을의미..
		
		
		//dummyservice.insertDummy(dumb);
		
		//System.out.println(inventory.toString());
	//	System.out.println(income.toString());
		
		//Map<String,Object> map2 = new HashMap<String,Object>();
		//map2 = map;
		
//		int reqCount = Integer.parseInt((String)map2.get("quantity"));
//		int price = Integer.parseInt((String)map2.get("price").toString().trim());
//		int pid = Integer.parseInt((String)map2.get("pid").toString().trim());
//	int profit = reqCount * price;
//		String franchise = (String)map2.get("franchisekey");
		
		//System.out.println(map2.get("reqCount"));
//		System.out.println(map2.get("price"));
		//System.out.println(map2.get("profit"));
		
//		System.out.println(map2.get("franchisekey"));
//		System.out.println(map2.get("imgsrc"));
//		System.out.println(map2.get("pid"));
//		System.out.println(map2.get("status"));
//		System.out.println(map2.get("available"));
//		

		
//		return map2;
		return map;
		
	}
	
	
	
	@RequestMapping(value = {"/vo/verify/delivery","/vo/verify/delivery.json"}, produces = "application/json; charset=utf-8")
	@ResponseBody
	public  Map<String, Object> verifyDelivery(@RequestBody Map<String,Object>map, HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
		try {
			request.setCharacterEncoding("UTF-8");
			response.setContentType("text/html; charset=utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		int pid = Integer.parseInt((String)map.get("pid").toString().trim());
		String rid = (String)map.get("rid").toString();
		int price = Integer.parseInt((String)map.get("price").toString().trim());
		int req_orderid = Integer.parseInt((String)map.get("req_orderid").toString().trim());
		int reqcount = Integer.parseInt((String)map.get("reqcount").toString().trim());
		
		System.out.println("param 잘넘어왔을까요? pid: " + pid + " , " + " rid : " + rid + ", price : " + price + ", req_orderid: " + req_orderid
				+ "reqcount  : " + reqcount);
	//	System.out.println("param으로 넘어온 InventoryVO 객체: " + inventory.toString());
		
	//	System.out.println("param으로 넘어온 IncomeVO 객체 : " + income.toString());
		
		
		//income insert해주고.. inventory update 해주고
		IncomeVO income = new IncomeVO();
		income.setFranchise(rid);
		income.setProfit(price * reqcount);
		System.out.println(income.toString());
		incomeservice.insertIncome(income);
		
		
		InventoryVO inventory = new InventoryVO();
		inventory.setCount(reqcount);
		inventory.setAvailable(1);
		inventory.setFk_pid(pid);
		inventory.setIuid(rid);
		System.out.println(inventory.toString());
		inventoryservice.updateInventory(inventory);
		
		RequestOrderVO req = new RequestOrderVO();
		req.setAvailable(2);
		req.setPid(pid);
		req.setReqCount(reqcount);
		req.setRid(rid);
		req.setReq_orderid(req_orderid);
		req.setReqCount(reqcount);
		
//		req.setStatus("approved");
		System.out.println("RequestOrderVO : " + req.toString());
		service.updateStatus(req);
		
		return null;
	}
	
}
