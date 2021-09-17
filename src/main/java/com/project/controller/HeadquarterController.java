package com.project.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.project.service.CrawlingService;
import com.project.service.FranchisePdtApprovalService;
import com.project.service.IncomeService;
import com.project.service.InventoryService;
import com.project.service.MapService;
import com.project.service.MemberService;
import com.project.service.MessageService;
import com.project.service.ProductService;
import com.project.service.RequestOrderService;
import com.project.service.SurveyService;
import com.project.service.TempService;
import com.project.service.UserSha256;
import com.project.util.KakaoGeoApi1;
import com.project.util.LocalHost;
import com.project.vo.FranchisePdtApprovalVO;
import com.project.vo.IncomeVO;
import com.project.vo.InventoryVO;
import com.project.vo.MapServiceVO;
import com.project.vo.MemberVO;
import com.project.vo.OrderVO;
import com.project.vo.ProductVO;
import com.project.vo.RequestOrderVO;
import com.project.vo.TempVO;

import net.webjjang.util.PageObject;

@Controller
@RequestMapping(value = "/headquarter", method = RequestMethod.GET)
public class HeadquarterController<O> {

	@Autowired
	FranchisePdtApprovalService productapproveservice;
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	TempService tempservice;
	
	@Autowired
	ProductService productservice;
	
	@Autowired
	InventoryService inventoryservice;
	
	@Autowired
	RequestOrderService orderservice;
	
	@Autowired
	IncomeService incomeservice;
	
	@Autowired
	MessageService messageService;
	
	@Autowired
	MapService mapservice;
	
	@Autowired
	SurveyService surveyservice;
	
	@Autowired
	CrawlingService crawlingService;

	@RequestMapping(value = "", method = RequestMethod.GET)
	public String home(HttpSession session) {
		session.setAttribute("tempMessage", messageService);
		
		return "index";

	}

	@RequestMapping(value = "/launchbusiness.do", method = RequestMethod.GET)
	public String launchBusinessforStartUps(HttpServletRequest request) {

		List<ProductVO> dabang = tempservice.getDabangList();
		List<ProductVO> hanshin = tempservice.getHanshinList();
		request.setAttribute("dabang", dabang);
		request.setAttribute("hanshin", hanshin);
		// 한신포차리스트
		// 설렁탕리스트
		return "headquarters/launchBusiness";

	}

	@RequestMapping(value = "/admin.do", method = RequestMethod.GET)
	public String admin() {
		return "admin/admin";

	}

	@RequestMapping(value = "/adminLaunchApproval.do", method = RequestMethod.GET)
	public String approveBusiness(HttpServletRequest request) {
		//List<LaunchBusinessVO> list = service.getWaitingList();
		List<TempVO> list = tempservice.getWaitingList();
		
		request.setAttribute("waitinglist", list);
		request.setAttribute("memberService", memberService);

		request.setAttribute("disable", "disable");

		return "admin/approve";

	}

	@RequestMapping(value = "/franchiseform.do")
	public String proceedDetailConsultForLaunchingBusiness(HttpServletRequest request) {
		String contractno = "";
		// int contractNumber = 0;
		List<ProductVO> dabang = tempservice.getDabangList();
		List<ProductVO> hanshin = tempservice.getHanshinList();
		// contractNumber가필요함...

		try {
			contractno = request.getParameter("contractno");
			System.out.println(tempservice.findBrandByContractNumber(Integer.parseInt(contractno)));
		} catch (Exception e) {

			System.out.println("nullpointer.... line 79 @ headquarter/franchiseform.do");
		}

		// System.out.println("controller에서 보내는 contractno String값: ?" + contractno);

		request.setAttribute("contractno", contractno);
		request.setAttribute("tempservice", tempservice);
		request.setAttribute("memberService", memberService);
		request.setAttribute("dabang", dabang);
		request.setAttribute("hanshin", hanshin);
		return "franchise/franchise";

	}

	@RequestMapping(value = "/franchiseRequirement.do") //가맹 세부컨설팅 ==> 메뉴선택 
	public String submitFranchiseForm(/*LaunchBusinessVO vo*/ TempVO vo, String extraAddress, String[] selectmenu,
			HttpServletRequest request) throws UnsupportedEncodingException {
		System.out.println(Arrays.deepToString(selectmenu) + " 들어왔습니다");
		String selectmenuVal = "";
		for (int i = 0; i < selectmenu.length; i++) {
			selectmenuVal += selectmenu[i] + "_";
		}
		vo.setSelectmenu(selectmenuVal);
		vo.setAddress(vo.getAddress() + " " + extraAddress);

		System.out.println("넘어온 값들 : " + vo.toString());
		
		/**
		 * 위도 경도로 치환할수 있는 카카오 api가필요함
		 */
		String strAddr = "";
		if(vo.getDetailaddress()==null) {
			System.out.println("상세주소가 없는경우...");
			strAddr = vo.getAddress();
		}else {
			System.out.println("상세주소가있습니다....");
			strAddr=  vo.getAddress() + " " + vo.getDetailaddress();
		}
		
		String myaddress = KakaoGeoApi1.addrToCoord(URLEncoder.encode(strAddr, "UTF-8"));
		System.out.println("카카오 맵에 찍을 주소는 ? " + myaddress);
		String [] latlng = KakaoGeoApi1.getRegionAddress(myaddress);
		vo.setLatitude(latlng[1]);
		vo.setLongitude(latlng[0]);
		
		System.out.println(latlng[1]);
		System.out.println(latlng[0]);

		
		
		
		
		
		tempservice.updateConsult(vo);

		request.setAttribute("franchiseSignup", "franchiseSignup");

		return "index";
	}
	
	@RequestMapping(value = "/franchisemapservice.do")
	   public String proceedDetailConsultForLaunchingBusinessMapservice(HttpServletRequest request) {
	      String contractno = "";
	      // int contractNumber = 0;
	      List<ProductVO> dabang = tempservice.getDabangList();
	      List<ProductVO> hanshin = tempservice.getHanshinList();
	      // contractNumber가필요함...

	      try {
	         contractno = request.getParameter("contractno");
	         System.out.println(tempservice.findBrandByContractNumber(Integer.parseInt(contractno)));
	      } catch (Exception e) {

	         System.out.println("nullpointer.... line 79 @ headquarter/franchiseform.do");
	      }

	      // System.out.println("controller에서 보내는 contractno String값: ?" + contractno);

	      request.getSession().setAttribute("contractno", contractno); // sessino값에 내 계약번호를저장합니다(먹고 버릴용도)
	      request.setAttribute("tempservice", tempservice);
	      request.setAttribute("memberService", memberService);
	      request.setAttribute("dabang", dabang);
	      request.setAttribute("hanshin", hanshin);
	      return "franchise/franchisemapservice";

	   }

	/////////////////////////////// 지도 서비스이용고객의 세부 컨설팅
	/////////////////////////////// 항목//////////////////////////////////////////////
	@RequestMapping(value = "/franchiseform/Mapservice/submit") 
		public String submitFranchiseMapservice(TempVO vo, HttpServletRequest request) throws UnsupportedEncodingException {
		//System.out.println(Arrays.deepToString(selectmenu) + " 들어왔습니다");
		//String selectmenuVal = "";
		//for (int i = 0; i < selectmenu.length; i++) {
		//selectmenuVal += selectmenu[i] + "_";
		//}
		//vo.setSelectmenu(selectmenuVal); //(O)
		
		//if (extraAddress != null) {
		//vo.setAddress(vo.getAddress() + " " + extraAddress);
		//}//(x)
		//   int contractnoT = Integer.parseInt(mycontractno.trim());
		//   vo.setContractno(contractnoT);
		
		vo.setPostcode("mapserviceUser");
		System.out.println("넘어온 값들 : " + vo.toString());
		
		
		/**
		 * 위도 경도로 치환할수 있는 카카오 api가필요함
		 */
		String strAddr = "";
		if(vo.getDetailaddress()==null) {
			System.out.println("상세주소가 없는경우...");
			strAddr = vo.getAddress();
		}else {
			System.out.println("상세주소가있습니다....");
			strAddr=  vo.getAddress() + " " + vo.getDetailaddress();
		}
		
		String myaddress = KakaoGeoApi1.addrToCoord(URLEncoder.encode(strAddr, "UTF-8"));
		System.out.println("카카오 맵에 찍을 주소는 ? " + myaddress);
		String [] latlng = KakaoGeoApi1.getRegionAddress(myaddress);
		vo.setLatitude(latlng[1]);
		vo.setLongitude(latlng[0]);
		
		System.out.println(latlng[1]);
		System.out.println(latlng[0]);

		
		
		
		
		// service.updateConsult(vo);
		tempservice.updateConsult(vo); //(X)(status 를 바꿔주는건아님..)
		
		request.setAttribute("franchiseSignup", "franchiseSignup");//(x)
		
		request.getSession().removeAttribute("contractno"); // 여기서 버립니다(x)
		
		return "index";
	}
/////카카오맵 위치서비스 이용하는 페이지로 이동..///////////////////////
   @RequestMapping(value = { "/kakaomap/service/user", "/kakaomap/service", "/kakaomap/service/" })
   public ModelAndView gotoMapservice(TempVO vo, String[] selectmenu, HttpServletRequest request, String id, String mylocation, String contractno) {
      //String id = request.getParameter("id");
      //String location = request.getParameter("mylocation"); // 창업문의한사람이 창업희망적은곳 ex) 신촌
      //String contractno = request.getParameter("contractno");
      List<MapServiceVO> locationList = mapservice.selectlocationList();
      ModelAndView mav = new ModelAndView();
      mav.addObject("aaId", id);
      mav.addObject("aalocation", mylocation + "건물");// 신촌 + 건물
      mav.addObject("mymycontractno", contractno);
      mav.addObject("locationlist", locationList);
      mav.setViewName("franchise/mapserviceuser");
      
      System.out.println(Arrays.deepToString(selectmenu) + " 들어왔습니다");
      String selectmenuVal = "";
      for (int i = 0; i < selectmenu.length; i++) {
         selectmenuVal += selectmenu[i] + "_";
      }
      vo.setSelectmenu(selectmenuVal);
      
      System.out.println("251번째줄 ..."+vo.toString());
      request.getSession().setAttribute("myTempStatus", vo);

      System.out.println("id: " + id + " , location: " + mylocation + " ,contractno: " + contractno); // 잘뜨는데 ㅅㅂ...

      return mav;
   }
	
	@RequestMapping(value = "/franchiseApproved.do")
	public String submitFranchiseForm(HttpServletRequest request, PageObject pageObject) throws UnsupportedEncodingException {
		// memberService=====> franchise등급으로 회원가입시키기
		// url 받아오기............가맹키

		String contractno = "";

		UUID uuid = UUID.randomUUID();
		
		String random = uuid.toString().substring(0, 13);
		
		
		//LaunchBusinessVO vo = null;
		
		TempVO vo = null;

		try {
			contractno = request.getParameter("contractno").trim();
			vo = tempservice.findmyBusiness(Integer.parseInt(contractno));
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		//System.out.println("내 가맹정보: " + vo.toString());
//////////////////*선택한 메뉴들에 대해서 inventory 세팅을해줄예정...*/////////////////////////////////////////////////////////////////////////////////
		
		String menu = vo.getSelectmenu();
		
		String [] selectmenu = menu.split("_");
		
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
		
		List<ProductVO> mymenuchoice =null; //사장님이 선택한 전체메뉴(디저트메뉴들을 못받아옴...)
	
		if(("빽다방").equals(vo.getBrand())) {
			mymenuchoice = productservice.getMenuList(menulist, templist);
		}else if("한신포차".equals(vo.getBrand())) {
			mymenuchoice = productservice.getMenuListHanshin(menulist, templist);
		}
		
		System.out.println("내가 선택한 메뉴는? " + mymenuchoice.toString() + " \t 메뉴의 개수 : " + mymenuchoice.size());	
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////		
///////////////////////////////////////////////////////////////////////////////////////
		String franchiseAccount = "";

		List<TempVO> franchiseList = tempservice.getFranchiseList(pageObject);
		//List<HeadquarterVO> franchiseList = hqservice.getFranchiseList(pageObject);

		TempVO hq = new TempVO();
		hq.setContractno(vo.getContractno());
		hq.setAddress(vo.getAddress());
		hq.setBrand(vo.getBrand());
		hq.setConsent(vo.getConsent());
		String time = new SimpleDateFormat("HH:mm").format(new Date());
		
		hq.setDetailaddress(vo.getDetailaddress());
		hq.setEmail(vo.getEmail());
		hq.setFranchisekey(random);
		hq.setLocation(vo.getLocation());
		hq.setMembershipfee(vo.getMembershipfee());
		hq.setMembershipmaintenance(vo.getMembershipmaintenance());
		hq.setName(vo.getName());
		hq.setPhone(vo.getPhone());
		hq.setStatus("approved");
		String regist_date = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
		hq.setDate(regist_date);
		hq.setMember_index(vo.getMember_index());
		hq.setPostcode(vo.getPostcode());
		hq.setSelectmenu(vo.getSelectmenu());
		hq.setStartup_field(vo.getStartup_field());
		if(vo.getBrand().equals("빽다방")) {
			hq.setUrl(LocalHost.strCommonDomain + "product/dabang/gotoPaikDabang.do");
		}else if(vo.getBrand().equals("한신포차")) {
			hq.setUrl(LocalHost.strCommonDomain + "product/hanshin/gotoHanshin.do");
		}
		
		System.out.println(hq.toString());
		
		
		System.out.println(franchiseList.toString());
		
		int cnt2 = 0;
		for(int i = 0; i < franchiseList.size();i++) {
			TempVO hqobj = franchiseList.get(i);
			System.out.println(hqobj.getContractno() + ", ");
			if(hq.getContractno()==hqobj.getContractno()) {
				if(hqobj.getFranchisekey()==null || hqobj.getFranchisekey().equals("")) {
					++cnt2;
				}
				System.out.println("이미중복임...");
			}else {
				++cnt2;
			}
		}
		
	//	System.out.println("cnt2: " + cnt2);
		
	
		
		
		
		
	
		
		List<MemberVO> memberlist = memberService.selectAll();
		System.out.println(memberlist.toString());
		
		MemberVO member = new MemberVO();
		
		if(vo.getBrand().equals("빽다방")) {
			franchiseAccount = "dabang" + vo.getContractno();
		}else if(vo.getBrand().equals("한신포차")) {
			franchiseAccount = "hanshin" + vo.getContractno();
		}
		
		//System.out.println("승인받은 가맹점 계정 : " + franchiseAccount);
		member.setId(franchiseAccount); // 프랜차이즈 id: 빽다방01(브랜드 + 계약번호)

		String encryptedPw = UserSha256.encrypt("theone" + vo.getContractno());
		member.setPassword(encryptedPw); // theone01 (theone + 계약번호)

		member.setAddress(vo.getAddress());
		member.setBrand(vo.getBrand());
		member.setDetailaddress(vo.getDetailaddress());
		member.setEmail(vo.getEmail());
		if (member.getBrand().equals("빽다방")) {
			member.setFilename("빽다방.png");
		}else if(member.getBrand().equals("한신포차")) {
			member.setFilename("한신포차.png");
		}
		member.setName(vo.getName());
		member.setPhone(vo.getPhone());
		member.setPostcode(vo.getPostcode());
		member.setTier("franchise");
		
		if(member.getBrand().equals("빽다방")) {
			member.setUrl(LocalHost.strCommonDomain + "product/dabang/gotoPaikDabang.do");
		}else if(member.getBrand().equals("한신포차")) {
			member.setUrl(LocalHost.strCommonDomain + "product/hanshin/gotoHanshin.do");
		}
		
		member.setFranchisekey(random); //franchisekey 생성
		member.setSelectmenu(vo.getSelectmenu());
		System.out.println("member는? " + member.toString());
		
		

		int cnt = 0;
		for(int i = 0; i < memberlist.size();i++) {
			MemberVO mem = memberlist.get(i);
			if(mem.getId().equals(member.getId())) {
				System.out.println("중복!!!!");
			}else {
				cnt++;
			}
		}
		System.out.println("cnt: " + memberlist.size() + ", = " + cnt);
//		if(cnt == memberlist.size()) {
//			System.out.println("중복없음!");
//			memberService.signupfranchise(member);
//		}
		
		
		
		
		if(cnt2 == franchiseList.size() && cnt == memberlist.size()) {
			System.out.println("중복없음!");
			//hqservice.insertFranchise(hq);
			tempservice.updateFranchise(hq);
			memberService.signupfranchise(member);
			
			
			IncomeVO income = new IncomeVO(); //가맹비 결제===>
	        income.setFranchise(hq.getFranchisekey());
	        income.setProfit(hq.getMembershipfee()); //가맹비
	        if("yes".equals(hq.getMapservice())){
	        	income.setProfit(hq.getMembershipfee() + 500000);
	        }
	        incomeservice.insertIncome(income);
			
			for(int i = 0; i < mymenuchoice.size();i++) {
				System.out.print("inventory 목록에 추가합니다.. 328번째줄!        ");
				InventoryVO inventory = new InventoryVO();
				inventory.setAvailable(0);
				inventory.setCount(100);
				inventory.setFk_pid(mymenuchoice.get(i).getIdx());
				inventory.setIuid(hq.getFranchisekey());
				inventoryservice.insertInventory(inventory);
			}
		}
		
		
		
		
		
		
		
		
		
		
		
//////////////////////////////////////////////////////////////////////////////////
		
		
		request.setAttribute("password", "theone"+vo.getContractno());
		request.setAttribute("franchisemember", member);
		request.setAttribute("hq", hq);
		request.setAttribute("approved","approved");
		
		
	
		for(int m = 0; m < franchiseList.size(); m++) {
			TempVO one = franchiseList.get(m);
			if(menu.equals(one.getSelectmenu() )) {
				return "franchise/franchiseapproved";
			}
		}
		
		///////////////////////////////////////////////////////////////////////////
	
	//////////////////////////////////////////////////////////////////////////////
		return "franchise/franchiseapproved";
	}
	
	@RequestMapping(value = "/gotostores.do")
	public String gotomystore(HttpServletRequest request, PageObject pageObject, Model model) {
		
		List<TempVO> storelist = tempservice.getApprovedpeople();
		
	//	model.addAttribute("list", service.list(pageobject));
		// 하단 부분의 페이지네이션 처리를 위해서 pageObject가 꼭 필요합니다.
		// 2페이지 이상이 되면 표시한다.
		//model.addAttribute("pageObject", pageObject);
		
		
		request.setAttribute("storelist", storelist);
		return "customerTier/gotomystore";
	}
	
	@RequestMapping(value = "/selectorder/from/franchise")
	public ModelAndView selectorderList(HttpServletRequest request, PageObject pageObject) {
		
		
		ModelAndView mav = new ModelAndView();
		
		List<RequestOrderVO> orderlist = null;
		
		try {
			
			int limit = 10; // 한페이지에 몇개의 게시글을 담을수있나
			int page = 1;//default 페이지
			try {
				
					page = Integer.parseInt(request.getParameter("page").trim());//NumberFormatException
					System.out.println("넘어온 page수: " + page);
				
			}catch(Exception e) {
				page = 1;
			}
			//limit 10 offset 0 
			//
			
			int offset = (page-1)*10; //몇번째 글부터 보여줄까요?
			
			int countPage = 10;// 한화면에 몇페이지까지 보여줄지 적는거.
			
			int startPage = ((page - 1) / 10) * 10 + 1; //시작페이지 (1)
			
			int endPage = startPage + countPage -1;//끝페이지  
			
			
			
			System.out.println("들어갈 limit : " + limit + " , " + offset);
			orderlist = orderservice.getOrderList(limit, offset);
			System.out.println(page + "페이지 입니다: " + orderlist.toString());
			
			int totalcnt = orderlist.size();
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
			
			if(endPage ==startPage) {
				endPage++;
				totalPage = endPage;
			}
			System.out.println("ENDPAGE: " + endPage);
			mav.setViewName("admin/orderstatus");
			mav.addObject("orderlist", orderlist);
			
			request.setAttribute("memberservice",memberService);
			request.setAttribute("service",orderservice);
			request.setAttribute("page", page);
			request.setAttribute("startPage", startPage);
			request.setAttribute("endPage", endPage);
			request.setAttribute("totalPage", totalPage);
			request.setAttribute("productservice", productservice);
			
			return mav;
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	
		
		return null;
	}
	
	@RequestMapping(value = "/franchiseOrder.do")
	public String checkDeliverClear(HttpServletRequest request, HttpSession session, String franchisekey) {
		
		String contractno = "";
	     
		//MemberVO member = (MemberVO)session.getAttribute("loginMember");
		
	      try {
	         contractno = request.getParameter("contractno").trim();
	      }catch(Exception e) {
	         System.out.println("contractno 못받아옴...");
	      }
	      TempVO mycurrentBusiness = tempservice.findmyBusiness(Integer.parseInt(contractno));
	      
	      List<RequestOrderVO> requestorderlist= orderservice.getOrderList(mycurrentBusiness.getFranchisekey());      

	      
	      List<FranchisePdtApprovalVO> approvedList = productapproveservice.selectDummyList(franchisekey);
	      System.out.println("컨트롤러에서의 approvedList" + approvedList.toString());
	      
	      
	      request.setAttribute("mycurrentBusiness", mycurrentBusiness );
	      request.setAttribute("approvedList", approvedList);
	      request.setAttribute("approveService",productapproveservice);
	   //   request.setAttribute("reqCountTT",reqCount);
	   //   request.setAttribute("priceTT",price);
	   //   request.setAttribute("pidTT", pid);
	      request.setAttribute("requestorderlist",requestorderlist);
	      request.setAttribute("productservice",productservice);
	      request.setAttribute("orderservice", orderservice);
	   
	      
	      return "franchise/franchiseOrderApproval";		
	}
	
	
	@RequestMapping(value = "/temp")
	public String tempIndex(HttpServletRequest request, HttpSession session) {
		
		String quantity = request.getParameter("quantity");
		String pid = request.getParameter("pid");
		String price =request.getParameter("price");
		String franchise = request.getParameter("franchisekey");
		String random = request.getParameter("random"); //random nullpointer
		String contractno = request.getParameter("contractno");
		String req_orderid = request.getParameter("req_orderid");
		
		int orderid = 0;
		
		ArrayList<Integer> ll = new ArrayList<Integer>();
		
		
		
		try {
			orderid = Integer.parseInt(req_orderid.trim());
			ll.add(orderid);
			session.setAttribute("orderIntegers", ll);
		}catch(Exception e) {
			System.out.println("NumberFormat!");
		}
		
		return "index";
		
	}
	
	@RequestMapping(value = "/addmenu")
	public String addMenu(ProductVO vo, HttpServletRequest request, HttpSession session) {
		//System.out.println(vo.toString());
		
		
		return "admin/addMenu";
		
	}
	
	@PostMapping(value = "/addmenuSub")
	public String addMenuSub(ProductVO vo, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws UnsupportedEncodingException {
		System.out.println(vo.toString());
		request.setCharacterEncoding("UTF-8");
		response.setHeader("Content-Type", "text/html;charset=utf-8");
		
		String brand = URLDecoder.decode(vo.getBrand(), "UTF-8");
		String detailExplain = URLDecoder.decode(vo.getDetailExplain(), "UTF-8");
		String image = URLDecoder.decode(vo.getImage(), "UTF-8");
		String menu = URLDecoder.decode(vo.getMenu(),"UTF-8");
		String temp = URLDecoder.decode(vo.getTemp(), "UTF-8");
		String type = URLDecoder.decode(vo.getType(),"UTF-8");
		
		vo.setBrand(brand);
		vo.setDetailExplain(detailExplain);
		vo.setImage(image);
		vo.setMenu(menu);
		vo.setType(type);
	if(brand.equals("빽다방")) {
		vo.setTemp(temp);
	}else {
		vo.setTemp(null);
	}
		
		
		System.out.println(vo.toString());
		
		
		productservice.insertProduct(vo);
		//addProduct해주면끝
		
		request.setAttribute("register", "상품이 등록되었습니다!");
		return "index";
		
	}
	
	
//////////////////////////////////chart.js////////////////////////////////////////////
	@RequestMapping(value = "/theonechart.do")
	public String theonechart(Model model) {
	    model.addAttribute("theoneprice", surveyservice.theoneinfo());
	    model.addAttribute("paiksprice", surveyservice.piakssales());
	    model.addAttribute("hanshinprice", surveyservice.hanshinsales());
		return "admin/theonechart";
		
	}
	
	@RequestMapping(value = "/searchdate.do")
	public String searchdate(String fromdate, String todate, Model model) {
		ArrayList<OrderVO> list = (ArrayList<OrderVO>)surveyservice.piakssales();
			for(int i=0;i<list.size();i++) {
				String time = list.get(i).getTime();
				time = time.substring(0, 10);
				time = time.replaceAll("-", "");
				list.get(i).setTime(time);
			}
		fromdate = fromdate.replaceAll("-", "");
		todate = todate.replaceAll("-", "");
		int from = Integer.parseInt(fromdate);
		int to = Integer.parseInt(todate);
		
		ArrayList<OrderVO> list1 =new ArrayList<OrderVO>();
		for(int i=0;i<list.size();i++) {
			if(from<=Integer.parseInt(list.get(i).getTime())&& to>=Integer.parseInt(list.get(i).getTime())) {
				list1.add(list.get(i));
			}
		}
		model.addAttribute("theoneprice", surveyservice.theoneinfo());
		model.addAttribute("paiksprice", list1);
		
		return "admin/theonechart";		
	}

	@RequestMapping(value = "/theonescore.do")
	public String theonescore(Model model) {
		model.addAttribute("paikslist", surveyservice.paikaverage());
		model.addAttribute("frankey", surveyservice.frankey());
		return "admin/theonescore";		
	}
	
	
	@RequestMapping(value = "/locationsearch.do")
	public String locationsearch(Model model, @RequestParam("location") String location) {
		ArrayList<TempVO> list = (ArrayList<TempVO>)surveyservice.frankey();
		String key = null;
		for(int i=0;i<list.size();i++) {
			if(location.equals(list.get(i).getLocation())) {
				key=list.get(i).getFranchisekey();
			}
		}
		if(key!=null) {
			model.addAttribute("survey",surveyservice.franinfo(key));
			model.addAttribute("data", "data");
		}else {
			model.addAttribute("data", "nodata");
		}
		return "admin/locationchart";		
	}
	
	/*언제 어디서나 채팅아이콘 붙박이로 박힌거 들어가는경로*/
	@RequestMapping(value="/chatpage")
	public String chat() {
		return "chatpage";
	}
	
	@RequestMapping(value="/person")
	public String person(Model model) {
		
		model.addAttribute("personList", crawlingService.personList());
		
		return "person";
	}
	
	
	@RequestMapping(value = "/calendar.do", method = RequestMethod.GET)
		public String calendar(String userid) {
			if(userid.equals("admin")) {
			return "headquarters/admincalendar";		
			}else {
				return "headquarters/calendar";					
			}
		}

}
