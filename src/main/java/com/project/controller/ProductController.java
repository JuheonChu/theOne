package com.project.controller;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map.Entry;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.service.InventoryService;
import com.project.service.MemberService;
import com.project.service.OrderService;
import com.project.service.ProductService;
import com.project.service.SurveyService;
import com.project.service.TempService;
import com.project.vo.MemberVO;
import com.project.vo.OrderVO;
import com.project.vo.ProductVO;
import com.project.vo.SurveyVO;
import com.project.vo.TempVO;

import net.webjjang.util.PageObject;

@Controller
@RequestMapping(value = "/product")
public class ProductController {
	
	@Autowired
	ProductService service;
	//ProductVOService service;
	@Autowired
	MemberService memberService;
	@Autowired
	OrderService orderService;
	@Autowired
	InventoryService inventoryService;
	
	@Autowired
	SurveyService surveyservice;
	
	@Autowired
	TempService tempservice;
	
	@RequestMapping(value = "/dabang/gotoPaikDabang.do", method = RequestMethod.GET)
	public String goToPaikDabang(String franchisekey, HttpServletRequest request, PageObject pageObject, HttpSession httpSession) {
		HttpSession session = request.getSession();
		
		try {
			request.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}
		
		System.out.println("header에서 넘어온 쿼리들..." + request.getQueryString());
		
		TempVO ttTTT = tempservice.findmyBusiness(franchisekey);
		
		String key = request.getParameter("franchisekey");
		System.out.println("바로가기로부터 넘어온 key 값은? " + key);
		String menu = request.getParameter("selectmenu");
		System.out.println("바로가기로부터 넘어온 menu들은?" + menu);
		String tier = null;
		//int defaultquantity = 50;
		
		try {
			tier = request.getParameter("tier");
		}catch(Exception e) {
			tier = "customer";
		}
		
		String[] selectmenu = menu.split("_"); //디저트 메뉴
		//System.out.println(selectmenu.length);//19개
		
		List<String> menulist = new ArrayList<String>();
		List<String> templist = new ArrayList<String>();
		
		int [] indexArr = new int[selectmenu.length];
		int [] tempIdx = new int[selectmenu.length];
		
		//menu만 모아둔것
		for(int i = 0; i < selectmenu.length;i++) {
			for(int k = 0; k < selectmenu[i].length(); k++) {
				//char temp = selectmenu[i].charAt(k); 
				int hot  = selectmenu[i].indexOf("H");
				int ice = selectmenu[i].indexOf("I");
				int basic = selectmenu[i].indexOf("B");//BASIC
				int soft = selectmenu[i].indexOf("S");
				
				if(basic != -1) {
					System.out.println("basic 의 값은 ? " + basic);
					indexArr[i] = basic;
					tempIdx[i] = basic;
				}
				else if((hot != -1)){
					indexArr[i] = hot;
					tempIdx[i] = hot;
				}
				else if(ice != -1) {
					indexArr[i] = ice;
					tempIdx[i] = ice;
				}
				
				else if(soft != -1) {
					indexArr[i] = soft;
					tempIdx[i] = soft;
				}
				else {
					indexArr[i] = selectmenu[i].length();
					tempIdx[i]=-1;
					
				}
			}
		}
		
		System.out.println("indexArr: " + Arrays.toString(indexArr));
		System.out.println("tempIdx: " + Arrays.toString(tempIdx));
		
	for(int i = 0; i < indexArr.length;i++) {
		if(tempIdx[i] == -1){
			System.out.println("85번째줄 들어는옵니까.....");
			templist.add(" ");
			menulist.add(selectmenu[i].substring(0, selectmenu[i].length()));//여기까진완료.....
		}else {
			menulist.add(selectmenu[i].substring(0, indexArr[i]));//여기까진완료.....
			templist.add(selectmenu[i].substring(indexArr[i]));
		}
	}		
		
		System.out.println("menulist: " + menulist.toString());
		System.out.println("templist: " + templist.toString());
		
		List<ProductVO> mymenuchoice = service.getMenuList(menulist, templist, pageObject); //사장님이 선택한 전체메뉴(디저트메뉴들을 못받아옴...)
		
		//List<ProductVO> temp = service.getPageList(pageObject);
		
		List<ProductVO> mycoffeelist = new ArrayList<ProductVO>();
		List<ProductVO> mybeveragelist = new ArrayList<ProductVO>();
		List<ProductVO> mydessertlist = new ArrayList<ProductVO>();
		List<ProductVO> mydrinklist = new ArrayList<ProductVO>();
		System.out.println("사장님이 선택한 메뉴들: " + mymenuchoice);
		
	for(int k = 0; k < mymenuchoice.size();k++) {
			ProductVO product = mymenuchoice.get(k);
			System.out.println(product.toString()); //NullPointerException(dessert)
		if("빽다방".equals(product.getBrand())) {
			if("coffee".equals(product.getType())) {
				System.out.println("문제의 그부분 들어옴...");
				mycoffeelist.add(product);
			}else if("beverage".equals(product.getType())) {
				mybeveragelist.add(product);
			}else if("dessert".equals(product.getType())) {
				mydessertlist.add(product);
			}else if("drink".equals(product.getType())) {
				mydrinklist.add(product);
			}else {
				System.out.println("그외...>");
			}
		}
	}
	
	System.out.println("커피 메뉴는? " + mycoffeelist);
		
		request.getSession().setAttribute("superSonny", menu);
		session.setAttribute("mydabangbusiness",ttTTT);
		
		System.out.println("ttTTTTTT:>>>>>>>>>>>>. " + ttTTT);
		request.getSession().setAttribute("franchisekey", key);
		request.getSession().setAttribute("menulist", mymenuchoice);
		request.getSession().setAttribute("coffeelist", mycoffeelist);
		request.getSession().setAttribute("beveragelist", mybeveragelist);
		request.getSession().setAttribute("dessertlist", mydessertlist);
		request.getSession().setAttribute("drinklist", mydrinklist);
		
		switch(tier) {
			case "franchise":
				session.setAttribute("franchiseid", session.getAttribute("userid"));
				session.setAttribute("franchise", session.getAttribute("loginMember"));
				//request.setAttribute("franchisekey", key);
				request.setAttribute("menu", menu);
				request.setAttribute("tier", tier);
				break;
			case "customer":
				//request.setAttribute("franchisekey",key);
				request.setAttribute("menu", menu);
				request.setAttribute("tier", "customer");
				break;
			case "headquarter":
				//request.setAttribute("franchisekey",key);
				request.setAttribute("menu", menu);
				request.setAttribute("tier", "customer");
				break;
		}
		
/*										베스트메뉴뽑는부분																			*/
		ArrayList<OrderVO> info = (ArrayList<OrderVO>)surveyservice.fransalesinfo(franchisekey);
		HashMap<Integer, Integer> count = new HashMap<Integer, Integer>(); //key: pid, value : 구매수량
		ArrayList<Integer> franpid = new ArrayList<Integer>();
		ArrayList<Integer> pidcount = new ArrayList<Integer>();	
		List <Integer> bestmenu = new ArrayList<Integer>();
		
		
		if(info.size()>0) {	//특정 가맹점에서의 주문기록이 1개이상일때
			
			for(int i=0;i<info.size();i++) {
				if(count.get(info.get(i).getPid()) == null) { //주문기록이하나도없을때 (상품이 주문된적이없을때)
					count.put(info.get(i).getPid(), info.get(i).getCount());
				}else {
					int num = count.get(info.get(i).getPid())+ info.get(i).getCount(); //중복상품걸릴때 ex) 카라멜마끼야또 3개 + 추가로 나올 카라멜마끼야또 3개
					count.put(info.get(i).getPid(), num); 
				}
			}
			
			Set set = count.entrySet();
			Iterator iterator = set.iterator();
			while(iterator.hasNext()) {
				Entry<Integer, Integer> entry = (Entry)iterator.next();
				int pid = (int)entry.getKey();
				franpid.add(pid);
				int value = (int)entry.getValue();
				pidcount.add(value);
			}
			System.out.println(franpid);
			System.out.println(pidcount);
			while(true) {
				int index = 0;
				if(pidcount.size()==1) {
					index = 0;
				}else {
					for(int i=1;i<pidcount.size();i++) {
						if(pidcount.get(i)>=pidcount.get(index)) {
							index = pidcount.indexOf(pidcount.get(i)); 
						}else {
							index = pidcount.indexOf(pidcount.get(i-1)); 				
						}
					}
				}
				bestmenu.add(franpid.get(index)); //베스트 메뉴
				pidcount.remove(index);
				franpid.remove(index);
				if(bestmenu.size()==3) {
					break;
				}
				if(bestmenu.size()<3 && franpid.size()==0) {
					while(bestmenu.size()<3) {
						bestmenu.add(0); // 만약에 주문한상품이 없거나 3개이하일때 ===> ex) 0,0,0 이렇게담김
						if(bestmenu.size()==3) {
						break;				
						}
					}
					break;
				}
			}
		}else {	//특정가맹으로부터의 주문기록이 하나도없을때
			while(bestmenu.size()<3) {
				bestmenu.add(0);
				if(bestmenu.size()==3) {
				break;				
				}
			}
		}
		
		List<ProductVO> bestProducts = null;
		try{
			bestProducts = service.getBestMenu(bestmenu);
		}catch(Exception e) {
			bestProducts = null;
			ProductVO pdt = new ProductVO();
			pdt.setIdx(0);
			
			bestProducts.add(pdt);
			bestProducts.add(pdt);
			bestProducts.add(pdt);
		}
		//if(bestProducts.get(0))
		
		
		
		//request.setAttribute("productlist",service.getProductList());
		
		session.setAttribute("bestmenu",bestmenu);
		
		if(bestProducts.size()!=0) {
			session.setAttribute("bestProducts",bestProducts);	 
		}else {
			request.setAttribute("bestProductNull", bestmenu);
		}
		//bestmenu에 pid		
/*							베스트 메뉴 뽑는부분  										*/		
		

		System.out.println("bestproductS: ///>>>>>best메뉴를뽑습니다:  " + bestProducts);
		session.setAttribute("bestproduts",bestProducts);
		
		return "paikdabang/index";
		
	}
	
	@RequestMapping(value="/dabang/menu.do")
	public String menu(Model model, HttpServletRequest request,PageObject pageObject) {
		String selectmenu = null;
		if(request.getParameter("selectmenu")!=null) {
			selectmenu = request.getParameter("selectmenu");
		}
	
		/*	String [] mymenu = selectmenu.split("_");
		
		List<String> menulist = new ArrayList<String>();
		List<String> templist = new ArrayList<String>();
		
		int [] indexArr = new int[mymenu.length];
		
		//menu만 모아둔것
		for(int i = 0; i < mymenu.length;i++) {
			for(int k = 0; k < mymenu[i].length(); k++) {
				char temp = mymenu[i].charAt(k);
				if(temp >= 'A' && temp <= 'Z') {
					indexArr[i] = k;
					break;
				}else {
					indexArr[i] = mymenu[i].length()-1;
				}
			}
			
			menulist.add(mymenu[i].substring(0, indexArr[i]));//여기까진완료.....
			templist.add(mymenu[i].substring(indexArr[i]));
		}

		System.out.println("menulist? " + menulist.toString());
		System.out.println("templist? " + templist.toString());*/
		
		/*그 메뉴들로부터 타입객체들을 모아놓은거*/
		List<ProductVO> mymenuchoice = (List<ProductVO>)request.getSession().getAttribute("menulist");
		
		//List<ProductVO> temp = service.getPageList(pageObject);
		
		List<ProductVO> mycoffeelist = (List<ProductVO>)request.getSession().getAttribute("coffeelist");
		List<ProductVO> mybeveragelist = (List<ProductVO>)request.getSession().getAttribute("beveragelist");
		List<ProductVO> mydessertlist = (List<ProductVO>)request.getSession().getAttribute("dessertlist");
		List<ProductVO> mydrinklist = (List<ProductVO>)request.getSession().getAttribute("drinklist");
	//	System.out.println("사장님이 선택한 메뉴들: " + mymenuchoice);
		
		request.setAttribute("selectmenu", selectmenu);
		request.setAttribute("menulist",mymenuchoice);
		request.setAttribute("coffeelist",mycoffeelist);
		request.setAttribute("beveragelist",mybeveragelist);
		request.setAttribute("dessertlist",mydessertlist);
		request.setAttribute("drinklist",mydrinklist);
		request.setAttribute("inventoryService", inventoryService);
		
		
		return "paikdabang/menu";
	}
	
	@RequestMapping(value="/dabang/coffee")
	public String coffee(Model model) {
		
		//model.addAttribute("list", service.coffeeList());
		
		return "paikdabang/coffee";
	}
	
	@RequestMapping(value="/dabang/beverage")
	public String beverage(Model model) {
		//model.addAttribute("list", service.beverageList());
		
		return "paikdabang/beverage";
	}
	
	@RequestMapping(value="/dabang/dessert")
	public String dessert(Model model) {
		//model.addAttribute("list", service.dessertList());
		
		return "paikdabang/dessert";
	}
	
	@RequestMapping(value="/dabang/drink")
	public String drink(Model model) {
		model.addAttribute("list", service.drinkList());
		
		return "paikdabang/drink";
	}
	
	@RequestMapping(value = "/dabang/resources/order")
	public String orderResources(HttpServletRequest request, HttpSession session) {
		// request.setAttribute("service", service);
		//List<ResourcesOrderVO> orderList = orderservice.getTotalOrderList();
		String franchisekey = request.getParameter("franchisekey");
		System.out.println("넘어가는 franchisekey는 ? " + franchisekey);
		String selectmenu = request.getParameter("selectmenu");
		String tier = request.getParameter("tier");
		System.out.println("들어온 메뉴....");
		MemberVO member = (MemberVO)session.getAttribute("loginMember");
		request.setAttribute("ceo", member);
		request.setAttribute("key", franchisekey);

	//	request.setAttribute("orderlist", orderlist);

		return "paikdabang/orderResources";
	}
	
	@RequestMapping(value = "/dabang/itemdetail")
	public String itemdatail(ProductVO product, Model model, int idx) {

		model.addAttribute("product", service.getItemDetail(product.getIdx()));

		return "paikdabang/itemdetail";
	}

	@RequestMapping(value = "/dabang/basket")
	public String basket(String id, Model model) {
		
		//model.addAttribute("orderservice", );
		model.addAttribute("basketList", orderService.getBasket(id));// 로그인 안된유저 : none(ID)
		model.addAttribute("id", id);

		return "paikdabang/basket";
	}

	@RequestMapping(value = "/dabang/addBasket")
	public String addBasket(String id, int pid, int count, String franchisekey) {
		ProductVO product = service.getItemDetail(pid);
		MemberVO member = memberService.selectMember(id);
		OrderVO order = new OrderVO();
		int sum = product.getPrice();

		if (!member.getId().equals("none")) {
			order.setId(member.getId());
			order.setFranchisekey(franchisekey);
			order.setName(member.getName());
			order.setAddress(member.getAddress());
			order.setDetailaddress(member.getDetailaddress());
			order.setPhone(member.getPhone());
			order.setBrand(product.getBrand());
			order.setType(product.getType());
			order.setMenu(product.getMenu());
			order.setTemp(product.getTemp());
			order.setPrice(sum);
			order.setCount(count);
			order.setSumPrice(count * sum);
			order.setImage(product.getImage());
			order.setPid(product.getIdx());
			System.out.println("order >> " + order);
	
			orderService.addBasket(order);
			
			return "paikdabang/index";
		} else {
			order.setId(member.getId());
			
			return "paikdabang/nullBuy";
		}
		
	}

	@RequestMapping(value = "/dabang/deleteBasket")
	public String deleteBasket(int oid, String id, Model model) {
		orderService.DeleteBasket(oid);

		model.addAttribute("basketList", orderService.getBasket(id));

		return "paikdabang/basket";
	}

	@PostMapping(value = "/dabang/buy")
	public String Buy(Model model, String id) {
		
		if (!(id.equals("none"))) {
			model.addAttribute("basketList", orderService.getBasket(id));
			model.addAttribute("id", memberService.selectMember(id));
			
			//List<Integer> list = new ArrayList<Integer>();
			
			model.addAttribute("pid", orderService);
			model.addAttribute("count", orderService);
			return "paikdabang/buy";
		}
		else {
			model.addAttribute("basketList", orderService.getBasket(id));
			return "paikdabang/nullBuy";
		}
	}
	
	@RequestMapping(value = "/dabang/buyAction")
	public String BuyAction(Model model, Integer count, Integer pid, String iuid, HttpSession session, HttpServletRequest req) {
		//List<Integer> pidList = new ArrayList<Integer>();
		
		TempVO asmr = tempservice.findmyBusiness(iuid);
		
		
		String id = req.getParameter("id");
		
		List<Integer> pidList = (List<Integer>)session.getAttribute("pidList");
		List<Integer> countList = (List<Integer>)session.getAttribute("countList");
		
		orderService.Buy(id);
		inventoryService.sellProduct(countList, pidList, iuid);
		session.removeAttribute("mydabangbusiness");
		session.setAttribute("mydabangbusiness", asmr);
		session.removeAttribute("pidList");
		session.removeAttribute("countList");
		
		
		req.setAttribute("franchisekey", iuid);
		return "paikdabang/paikresult";
	}
	
	@PostMapping(value = "/dabang/nullBuy")
	public String nullBuy(Model model, String id, int pid, int count, String address, String detailaddress,
			String phone, String email) {
		model.addAttribute("basketList", orderService.getBasket(id));
		MemberVO member = memberService.selectMember(id);
		ProductVO product = new ProductVO();
		
		model.addAttribute("basketList", service.getItemDetail(pid));
		model.addAttribute("count", count);
		
		return "paikdabang/nullBuy";
	}
	
	@PostMapping(value = "/dabang/nullBuyAction")
	public String nullBuyAction(String id, int pid, int count, String address, String detailaddress,
			String phone, String email, String name, String franchisekey, int sum, HttpSession session, HttpServletRequest request) {
		MemberVO member = memberService.selectMember(id);
		ProductVO product = service.getItemDetail(pid);
		OrderVO order = new OrderVO();
		
		System.out.println("pid >> " + pid);
		System.out.println(id);
		System.out.println(franchisekey);
		System.out.println(name);
		System.out.println(address);
		System.out.println(detailaddress);
		System.out.println(phone);
		System.out.println(count);
		System.out.println(sum);
		
		order.setId(id);
		order.setFranchisekey(franchisekey);
		order.setName(name);
		order.setAddress(address);
		order.setDetailaddress(detailaddress);
		order.setPhone(phone);
		order.setBrand(product.getBrand());
		order.setType(product.getType());
		order.setMenu(product.getMenu());
		order.setTemp(product.getTemp());
		order.setPrice(product.getPrice());
		order.setCount(count);
		order.setSumPrice(sum);
		order.setImage(product.getImage());
		order.setPid(product.getIdx());
		
		System.out.println("order >> " + order);
		
		inventoryService.nullSellProduct(count, product.getIdx(), franchisekey);
		
		orderService.nullBuy(order);
		session.removeAttribute("pidList");
		session.removeAttribute("countList");
		
		session.removeAttribute("mydabangbusiness");
		
		TempVO asmr = tempservice.findmyBusiness(franchisekey);
		session.setAttribute("mydabangbusiness", asmr);
		
		request.setAttribute("franchisekey", franchisekey);
		
		return "paikdabang/paikresult";
	}
	
	@RequestMapping(value="/hanshin/gotoHanshin.do")
	public String goToHanshin(String franchisekey, HttpServletRequest request, HttpSession session) {
		
	//	HttpSession session = request.getSession();
		try {
			request.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}
		
		System.out.println("header에서 넘어온 쿼리들..." + request.getQueryString());
		
		String key = request.getParameter("franchisekey");
		System.out.println("바로가기로부터 넘어온 key 값은? " + key);
		String menu = request.getParameter("selectmenu");
		System.out.println("바로가기로부터 넘어온 menu들은?" + menu);
		String tier = null;
		//int defaultquantity = 50;
		
		TempVO myown = tempservice.findmyBusiness(key); //지금 쓰지는 않지만 만일을위해서 남겨둠...
		
		try {
			tier = request.getParameter("tier");
		}catch(Exception e) {
			tier = "customer";
		}
		
		String[] selectmenu = menu.split("_"); //디저트 메뉴
		//System.out.println(selectmenu.length);//19개
		
		List<String> menulist = new ArrayList<String>();
		
	//	int [] indexArr = new int[selectmenu.length];
	//	int [] tempIdx = new int[selectmenu.length];
		
		//menu만 모아둔것
		for(int i = 0; i < selectmenu.length;i++) {
			menulist.add(selectmenu[i]);
		}
		
	//	System.out.println("indexArr: " + Arrays.toString(indexArr));
		
/*	for(int i = 0; i < indexArr.length;i++) {
		if(tempIdx[i] == -1){
			System.out.println("85번째줄 들어는옵니까.....");
			menulist.add(selectmenu[i].substring(0, selectmenu[i].length()));//여기까진완료.....
		}else {
			menulist.add(selectmenu[i].substring(0, indexArr[i]));//여기까진완료.....
		}
	}	*/	
		
		System.out.println("menulist: " + menulist.toString());
		
		List<ProductVO> mymenuchoice = service.getHanshinMenuList(menulist); //사장님이 선택한 전체메뉴(디저트메뉴들을 못받아옴...)
		

		
		System.out.println("사장님이 선택한 메뉴들: " + mymenuchoice);
		
	for(int k = 0; k < mymenuchoice.size();k++) {
		ProductVO product = mymenuchoice.get(k);
		System.out.println(product.toString()); //NullPointerException(dessert)
	}
	
		
		session.setAttribute("franchisekey", key);
		session.setAttribute("menulist", mymenuchoice);
		session.setAttribute("mymymymymenu",menu);
		session.setAttribute("mymymymymymyown", myown);
		
		switch(tier) {
			case "franchise":
				session.setAttribute("franchiseid", session.getAttribute("userid"));
				session.setAttribute("franchise", session.getAttribute("loginMember"));
				//request.setAttribute("franchisekey", key);
				request.setAttribute("menu", menu);
				request.setAttribute("tier", tier);
				request.setAttribute("tempservice", tempservice);
		//		session.setAttribute("myownNN", myown);
				break;
			case "customer":
				//request.setAttribute("franchisekey",key);
				request.setAttribute("menu", menu);
				request.setAttribute("tier", "customer");
				request.setAttribute("tempservice", tempservice);
		//		session.setAttribute("myownNN", myown);
				break;
			case "headquarter":
				//request.setAttribute("franchisekey",key);
				request.setAttribute("menu", menu);
				request.setAttribute("tier", "customer");
				request.setAttribute("tempservice", tempservice);
		//		session.setAttribute("myownNN", myown);
				break;
		}
		
//		if(tier.equals)
		ArrayList<OrderVO> info = (ArrayList<OrderVO>)surveyservice.fransalesinfo(franchisekey);
		HashMap<Integer, Integer> count = new HashMap<Integer, Integer>(); //key: pid, value : 구매수량
		ArrayList<Integer> franpid = new ArrayList<Integer>();
		ArrayList<Integer> pidcount = new ArrayList<Integer>();	
		List <Integer> bestmenu = new ArrayList<Integer>();
		
		
		if(info.size()>0) {	//특정 가맹점에서의 주문기록이 1개이상일때
			
			for(int i=0;i<info.size();i++) {
				if(count.get(info.get(i).getPid()) == null) { //주문기록이하나도없을때 (상품이 주문된적이없을때)
					count.put(info.get(i).getPid(), info.get(i).getCount());
				}else {
					int num = count.get(info.get(i).getPid())+ info.get(i).getCount(); //중복상품걸릴때 ex) 카라멜마끼야또 3개 + 추가로 나올 카라멜마끼야또 3개
					count.put(info.get(i).getPid(), num); 
				}
			}
			
			Set set = count.entrySet();
			Iterator iterator = set.iterator();
			while(iterator.hasNext()) {
				Entry<Integer, Integer> entry = (Entry)iterator.next();
				int pid = (int)entry.getKey();
				franpid.add(pid);
				int value = (int)entry.getValue();
				pidcount.add(value);
			}
			System.out.println(franpid);
			System.out.println(pidcount);
			while(true) {
				int index = 0;
				if(pidcount.size()==1) {
					index = 0;
				}else {
					for(int i=1;i<pidcount.size();i++) {
						if(pidcount.get(i)>=pidcount.get(index)) {
							index = pidcount.indexOf(pidcount.get(i)); 
						}else {
							index = pidcount.indexOf(pidcount.get(i-1)); 				
						}
					}
				}
				bestmenu.add(franpid.get(index)); //베스트 메뉴
				pidcount.remove(index);
				franpid.remove(index);
				if(bestmenu.size()==3) {
					break;
				}
				if(bestmenu.size()<3 && franpid.size()==0) {
					while(bestmenu.size()<3) {
						bestmenu.add(0); // 만약에 주문한상품이 없거나 3개이하일때 ===> ex) 0,0,0 이렇게담김
						if(bestmenu.size()==3) {
						break;				
						}
					}
					break;
				}
			}
		}else {	//특정가맹으로부터의 주문기록이 하나도없을때
			while(bestmenu.size()<3) {
				bestmenu.add(0);
				if(bestmenu.size()==3) {
				break;				
				}
			}
		}
		
		List<ProductVO> bestProducts = null;
		try{
			bestProducts = service.getBestMenu(bestmenu);
		}catch(Exception e) {
			bestProducts = null;
			ProductVO pdt = new ProductVO();
			pdt.setIdx(0);
			
			bestProducts.add(pdt);
			bestProducts.add(pdt);
			bestProducts.add(pdt);
		}
		//if(bestProducts.get(0))
		
		
		
		//request.setAttribute("productlist",service.getProductList());
		
		request.setAttribute("bestmenu",bestmenu);
		
		if(bestProducts.size()!=0) {
			request.setAttribute("bestProducts",bestProducts);	 
		}else {
			request.setAttribute("bestProductNull", bestmenu);
		}
		//bestmenu에 pid		
/*							베스트 메뉴 뽑는부분  										*/		
		

		System.out.println("bestproductS: ///>>>>>best메뉴를뽑습니다:  " + bestProducts);
		
		
		return "hanshin/index";
	}
	
	@RequestMapping(value="/hanshin/menu")
	public String hanshinMenu(Model model, ProductVO vo, HttpServletRequest request, String selectmenu) {
		//request.setCharacterEncoding("UTF-8");
		//System.out.println(request.getQueryString());
		if(request.getParameter("selectmenu")!=null) {
			selectmenu = request.getParameter("selectmenu");
		}
		System.out.println("콘트롤러 셀렉트 메뉴 : " + selectmenu); //들어옴..
		
	//	System.out.println("여기가 에러입니까??");
		System.out.println(service.hanshinMenu(vo).toString());
		
		/*그 메뉴들로부터 타입객체들을 모아놓은거*/
		List<ProductVO> mymenuchoice = (List<ProductVO>)request.getSession().getAttribute("menulist");
	//	System.out.println("여기가 에러입니까 ? " + mymenuchoice.toString());
		
		request.setAttribute("tempserviceABC",tempservice);
		request.setAttribute("selectmenu", selectmenu);
		request.setAttribute("menulist",mymenuchoice);
		
		model.addAttribute("hanshinMenu", service.hanshinMenu(vo));
		request.setAttribute("inventoryService", inventoryService);
		return "hanshin/menu";
	}
	
	@RequestMapping(value="/hanshin/itemdetail")
	public String hanshinDetailMenu(Model model, ProductVO vo, HttpServletRequest request, int idx) {
		
		model.addAttribute("product", service.getItemDetail(idx));
		
		return "hanshin/itemdetail";
	}
	
	@RequestMapping(value = "/hanshin/basket")
	public String basketHanshin(String id, Model model) {
		
		//model.addAttribute("orderservice", );
		model.addAttribute("basketList", orderService.getBasket(id));
		model.addAttribute("id", id);

		return "hanshin/basket";
	}

	@RequestMapping(value = "/hanshin/addBasket")
	public String addBasketHanshin(String id, int pid, int count, String franchisekey) {
		ProductVO product = service.getItemDetail(pid);
		MemberVO member = memberService.selectMember(id);
		OrderVO order = new OrderVO();
		int sum = product.getPrice();

		if (!member.getId().equals("none")) {
			order.setId(member.getId());
			order.setFranchisekey(franchisekey);
			order.setName(member.getName());
			order.setAddress(member.getAddress());
			order.setDetailaddress(member.getDetailaddress());
			order.setPhone(member.getPhone());
			order.setBrand(product.getBrand());
			order.setType(product.getType());
			order.setMenu(product.getMenu());
			order.setTemp(product.getTemp());
			order.setPrice(sum);
			order.setCount(count);
			order.setSumPrice(count * sum);
			order.setImage(product.getImage());
			order.setPid(product.getIdx());
			System.out.println("order >> " + order);
	
			orderService.addBasket(order);
			
			//orderService.updateInventory(order.getFranchisekey(), order.getPid()); // 산 수량만 큼 그 매장 재고에서 개수를 깐다
			
			return "hanshin/index";
		} else {
			order.setId(member.getId());
			
			return "hanshin/nullBuy";
		}
		
	}

	@RequestMapping(value = "/hanshin/deleteBasket")
	public String deleteBasketHanshin(int oid, String id, Model model) {
		
		orderService.DeleteBasket(oid);

		model.addAttribute("basketList", orderService.getBasket(id));

		return "hanshin/basket";
	}

	@PostMapping(value = "/hanshin/buy")
	public String BuyHanshin(Model model, String id) {
		
		if (!(id.equals("none"))) {
			model.addAttribute("basketList", orderService.getBasket(id));
			model.addAttribute("id", memberService.selectMember(id));
			
			//List<Integer> list = new ArrayList<Integer>();
			
			model.addAttribute("pid", orderService);
			model.addAttribute("count", orderService);
			return "hanshin/buy";
		}
		else {
			model.addAttribute("basketList", orderService.getBasket(id));
			return "hanshin/nullBuy";
		}
	}
	
	@RequestMapping(value = "/hanshin/buyAction")
	public String BuyActionHanshin(Model model, String id, Integer count, Integer pid, String iuid, HttpSession session, HttpServletRequest request) {
		//List<Integer> pidList = new ArrayList<Integer>();
		
		List<Integer> pidList = (List<Integer>)session.getAttribute("pidList");
		List<Integer> countList = (List<Integer>)session.getAttribute("countList");
		
		orderService.Buy(id);
		inventoryService.sellProduct(countList, pidList, iuid);
		
		session.removeAttribute("pidList");
		session.removeAttribute("countList");
		
		request.setAttribute("franchisekey", iuid);
		return "hanshin/hanshinresult";
	}
	
	@PostMapping(value = "/hanshin/nullBuy")
	public String nullBuyHanshin(Model model, String id, int pid, int count, String address, String detailaddress,
			String phone, String email) {
		model.addAttribute("basketList", orderService.getBasket(id));
		MemberVO member = memberService.selectMember(id);
		ProductVO product = new ProductVO();
		
		model.addAttribute("basketList", service.getItemDetail(pid));
		model.addAttribute("count", count);
		
		return "hanshin/nullBuy";
	}
	
	@PostMapping(value = "/hanshin/nullBuyAction")
	public String nullBuyActionHanshin(String id, int pid, int count, String address, String detailaddress,
			String phone, String email, String name, String franchisekey, int sum, HttpSession session, HttpServletRequest request) {
		MemberVO member = memberService.selectMember(id);
		ProductVO product = service.getItemDetail(pid);
		OrderVO order = new OrderVO();
		
		System.out.println("pid >> " + pid);
		System.out.println(id);
		System.out.println(franchisekey);
		System.out.println(name);
		System.out.println(address);
		System.out.println(detailaddress);
		System.out.println(phone);
		System.out.println(count);
		System.out.println(sum);
		
		order.setId(id);
		order.setFranchisekey(franchisekey);
		order.setName(name);
		order.setAddress(address);
		order.setDetailaddress(detailaddress);
		order.setPhone(phone);
		order.setBrand(product.getBrand());
		order.setType(product.getType());
		order.setMenu(product.getMenu());
		order.setTemp(product.getTemp());
		order.setPrice(product.getPrice());
		order.setCount(count);
		order.setSumPrice(sum);
		order.setImage(product.getImage());
		order.setPid(product.getIdx());
		
		System.out.println("order >> " + order);
		
		inventoryService.nullSellProduct(count, product.getIdx(), franchisekey);
		
		orderService.nullBuy(order);
		session.removeAttribute("pidList");
		session.removeAttribute("countList");
		
		request.setAttribute("franchisekey", franchisekey);
		
		return "hanshin/hanshinresult";
	}
	
	@RequestMapping(value="/dabang/come/to/mystore")
	public String cometoMyDabang(HttpServletRequest request, String franchisekey) {
		System.out.println("franchisekey" + franchisekey);
		request.setAttribute("franchisekeyyy", franchisekey);
		
		//int ctno = Integer.parseInt(franchisekey.trim());
		TempVO myown = tempservice.findmyBusiness(franchisekey);
		request.setAttribute("mystore", myown);
		return "paikdabang/mystore";
	}
	
	
	@RequestMapping(value = "/survey")
	public String survey(HttpServletRequest request) {
		String key = request.getParameter("franchisekey");
		request.setAttribute("franchisekey", key);
		return "paikdabang/evaluation";
	}
	
	@RequestMapping(value = "/hanshin/survey")
	public String surveyHanshin(HttpServletRequest request) {
		String key = request.getParameter("franchisekey");
		request.setAttribute("franchisekey", key);
		return "hanshin/evaluation";
	}
	
	
	
	@RequestMapping(value = "/hanshin/survey.do")
	public String hanshinsurveydo(@ModelAttribute SurveyVO vo) {
		System.out.println("컨트롤러에서보는 fkey : "+vo.getFkey());
		int count = surveyservice.francount(vo.getFranchisekey());
		if(count==0) {
			surveyservice.Survey(vo);
		}else {
			List<SurveyVO> list = surveyservice.franinfo(vo.getFranchisekey());
			int ordercount = list.get(0).getOrdercount();
			int flavor = list.get(0).getFlavor();
			int delivery = list.get(0).getDelivery();
			int service = list.get(0).getService();
			String etc = list.get(0).getEtc();
			
			ordercount += 1;
			flavor += vo.getFlavor();
			delivery += vo.getDelivery();
			service += vo.getService();
			etc += ","+vo.getEtc();
			
			vo.setOrdercount(ordercount);
			vo.setFlavor(flavor);
			vo.setDelivery(delivery);
			vo.setService(service);
			vo.setEtc(etc);
			surveyservice.fchangeinfo(vo);
		}
	return "success";
	}
	
	
	
	@RequestMapping(value = "/survey.do")
	public String surveydo(@ModelAttribute SurveyVO vo) {
		int count = surveyservice.francount(vo.getFranchisekey());
		if(count==0) {
			surveyservice.Survey(vo);
		}else {
			List<SurveyVO> list = surveyservice.franinfo(vo.getFranchisekey());
			int ordercount = list.get(0).getOrdercount();
			int flavor = list.get(0).getFlavor();
			int delivery = list.get(0).getDelivery();
			int service = list.get(0).getService();
			String etc = list.get(0).getEtc();
			
			ordercount += 1;
			flavor += vo.getFlavor();
			delivery += vo.getDelivery();
			service += vo.getService();
			etc += ","+vo.getEtc();
			
			vo.setOrdercount(ordercount);
			vo.setFlavor(flavor);
			vo.setDelivery(delivery);
			vo.setService(service);
			vo.setEtc(etc);
			surveyservice.fchangeinfo(vo);
		}
	return "success";
	}

	@RequestMapping(value="/dabang/gotoindex")
	public String gotoindex() {
		return "paikdabang/index";
	}
	
	@RequestMapping(value="/dabang/resources/chart")
	public String chart(@RequestParam("franchisekey") String franchisekey, Model model) {
		System.out.println("넘어온 franchisekey 는 ? " + franchisekey);
		model.addAttribute("info",surveyservice.franinfo(franchisekey));
		model.addAttribute("location",surveyservice.selectlocation(franchisekey)); //String return
		model.addAttribute("paikaverage", surveyservice.paikaverage());
		return "paikdabang/chart";
	}
	
	@RequestMapping(value="/hanshin/resources/chart")
	public String Hanshinchart(@RequestParam("franchisekey") String franchisekey, Model model) {
		System.out.println("넘어온 franchisekey 는 ? " + franchisekey);
		model.addAttribute("info",surveyservice.franinfo(franchisekey));
		model.addAttribute("location",surveyservice.selectlocation(franchisekey)); //String return
		model.addAttribute("paikaverage", surveyservice.hanshinaverage());
		return "hanshin/chart";
	}
	
	@RequestMapping(value="/dabang/resources/saleschart.do")
	public String saleschart(@RequestParam("franchisekey") String franchisekey, HttpServletRequest request) {
		ArrayList<OrderVO> list = (ArrayList<OrderVO>)surveyservice.fransalesinfo(franchisekey);
		ArrayList<OrderVO> list1 = (ArrayList<OrderVO>)surveyservice.piakssales();
		
		int sales = 0;
		int fransales = 0;
		ArrayList<String> namelist = new ArrayList<String>();
		if(list1.size()!=0){
			namelist.add(list1.get(0).getFranchisekey());
			System.out.println(namelist.toString());
			for(int i=0;i<list1.size();i++){
				String num1 = list1.get(i).getFranchisekey();
				int a = 0;
				for(int j=0;j<namelist.size();j++){
					String num2 = (String)namelist.get(j);				
					if(num1.equals(num2)){
						a+=1;
					}
				}
				if(a==0) {
					namelist.add(num1);
				}
				fransales += list1.get(i).getSumPrice();
				System.out.println(fransales);
			}
			System.out.println(namelist.size());
			System.out.println(namelist.toString());
			fransales = (fransales/namelist.size());
			System.out.println(fransales);
		}
		for(int i=0;i<list.size();i++){
			sales += list.get(i).getSumPrice();
		}
		request.setAttribute("sales",sales);
		request.setAttribute("fransales",fransales);
		request.setAttribute("location",surveyservice.selectlocation(franchisekey));
		return "paikdabang/saleschart";
	}
	
	@RequestMapping(value="/hanshin/come/to/mystore")
	public String cometoMyStore(HttpServletRequest request, String franchisekey) {
		System.out.println("franchisekey" + franchisekey);
		request.setAttribute("franchisekeyyy", franchisekey);
		
		//int ctno = Integer.parseInt(franchisekey.trim());
		TempVO myown = tempservice.findmyBusiness(franchisekey);
		request.setAttribute("mystore", myown);
		return "hanshin/mystore";
	}
	
	@RequestMapping(value = "/hanshin/resources/order")
	public String orderHanshinResources(HttpServletRequest request, HttpSession session) {
		// request.setAttribute("service", service);
		//List<ResourcesOrderVO> orderList = orderservice.getTotalOrderList();
		String franchisekey = request.getParameter("franchisekey");
		System.out.println("넘어가는 franchisekey는 ? " + franchisekey);
		String selectmenu = request.getParameter("selectmenu");
		String tier = request.getParameter("tier");
		System.out.println("들어온 메뉴....");
		MemberVO member = (MemberVO)session.getAttribute("loginMember");
		request.setAttribute("ceo", member);
		request.setAttribute("key", franchisekey); 

	//	request.setAttribute("orderlist", orderlist);

		return "hanshin/orderResources";
	}
	
	@RequestMapping(value="/hanshin/gotoindex")
	public String hanshingotoindex() {
		return "hanshin/index";
	}
	
	
/*한신포차 지점평가 통계*/	
	@RequestMapping(value="/hanshin/resources/hanshinchart")
	public String Hanshinchart(@RequestParam("franchisekey") String franchisekey, Model model, HttpSession session) {
		System.out.println("넘어온 franchisekey 는 ? " + franchisekey);
		model.addAttribute("info",surveyservice.franinfo(franchisekey));
		model.addAttribute("location",surveyservice.selectlocation(franchisekey)); //String return
		model.addAttribute("hanshinaverage", surveyservice.hanshinaverage());
		
		TempVO tttt = tempservice.findmyBusiness(franchisekey);
		session.removeAttribute("mymymymymymyown");
		session.setAttribute("mymymymymymyown", tttt);
		return "hanshin/chart";
	}
	
	@RequestMapping(value="/hanshin/resources/saleschart.do")
	public String hanshinsaleschart(@RequestParam("franchisekey") String franchisekey, HttpServletRequest request) {
		ArrayList<OrderVO> list = (ArrayList<OrderVO>)surveyservice.fransalesinfo(franchisekey);
		ArrayList<OrderVO> list1 = (ArrayList<OrderVO>)surveyservice.hanshinsales();
		
		int sales = 0;
		int fransales = 0;
		ArrayList<String> namelist = new ArrayList<String>();
		if(list1.size()!=0) {
			namelist.add(list1.get(0).getFranchisekey());
			System.out.println(namelist.toString());
			
			for(int i=0;i<list1.size();i++){
				String num1 = list1.get(i).getFranchisekey();
				int a = 0;
				for(int j=0;j<namelist.size();j++){
					String num2 = (String)namelist.get(j);				
					if(num1.equals(num2)){
						a+=1;
					}
				}
				if(a==0) {
					namelist.add(num1);
				}
				fransales += list1.get(i).getSumPrice();
				System.out.println(fransales);
			}
			System.out.println(namelist.size());
			System.out.println(namelist.toString());
			fransales = (fransales/namelist.size());
			System.out.println(fransales);
		}

		for(int i=0;i<list.size();i++){
			sales += list.get(i).getSumPrice();
		}
		request.setAttribute("sales",sales);
		request.setAttribute("fransales",fransales);
		request.setAttribute("location",surveyservice.selectlocation(franchisekey));
		return "hanshin/saleschart";
	}
	
	

}
