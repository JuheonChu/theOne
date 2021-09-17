package com.project.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.text.ParseException;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.concurrent.ExecutionException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import org.springframework.web.bind.annotation.ResponseBody;import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.JsonNode;
import com.github.scribejava.core.model.OAuth2AccessToken;
import com.project.auth.KakaoRestAPI;
import com.project.auth.NaverLoginBO;
import com.project.service.MemberService;
import com.project.service.MessageService;
import com.project.service.OrderService;
import com.project.service.TempService;
import com.project.service.UserSha256;
import com.project.service.pwfindServiceImpl;
import com.project.util.RandomPw;
import com.project.vo.IdfindVO;
import com.project.vo.MemberVO;
import com.project.vo.Message;

@Controller
@RequestMapping(value = "/member", method = RequestMethod.GET)
public class MemberController {
   @Autowired
   MemberService service;

   @Autowired
   MessageService messageService;
   
   @Autowired
   TempService tempservice;
   
   @Autowired
   OrderService orderService;
   
   @Autowired
   pwfindServiceImpl emailSender;
	
   //@Autowired
  // IdfindVO email; //임시비밀번호

   /* NaverLoginBO */
   private NaverLoginBO naverLoginBO;
   private String apiResult = null;

   @Autowired
   private void setNaverLoginBO(NaverLoginBO naverLoginBO) {
      this.naverLoginBO = naverLoginBO;
   }

   @RequestMapping(value = "/login.do", method = RequestMethod.GET)
   public String home(HttpSession session, Model model) {
      /* 네이버아이디로 인증 URL을 생성하기 위하여 naverLoginBO클래스의 getAuthorizationUrl메소드 호출 */
      String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
      // https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=sE***************&
      // redirect_uri=http%3A%2F%2F211.63.89.90%3A8090%2Flogin_project%2Fcallback&state=e68c269c-5ba9-4c31-85da-54c16c658125
      System.out.println("네이버:" + naverAuthUrl);
      // 네이버
      model.addAttribute("url", naverAuthUrl);
      return "login";
   }

   @RequestMapping(value = "/loginFail.do", method = RequestMethod.GET) // 인터셉터
   public String loginHome(Locale locale, Model model) {
      model.addAttribute("loginFail", "loginFail");
      return "login";
   }

   @RequestMapping(value = "/loginAction.do", method = RequestMethod.POST)
   public String loginAction(@ModelAttribute("vo") MemberVO vo, HttpSession session, String id,
         HttpServletRequest request) throws UnsupportedEncodingException {
	   
	   
      // 아이디 일치
      request.setCharacterEncoding("utf-8");
     String tempId = URLDecoder.decode(vo.getId(), "utf-8");
      
      String encryptedPassword = UserSha256.encrypt(vo.getPassword());
      vo.setPassword(encryptedPassword); // 암호화된 비밀번호로 비밀번호 체크 (오류)

      
    //  System.out.println("에러터지기 바로직전...83번째줄 mEmbercontroller");
      
      if (service.checkId(tempId)) {
         System.out.println("로그인 하려고 하는 객체 : " + vo.toString());
         MemberVO login = service.viewMember(vo); // NullPointerException

         // String encryptedpw
         // vo.setpw()

         if (service.checkPw(tempId, vo.getPassword())) {
            session.setAttribute("loginCheck", true);// login여부 체크
            session.setAttribute("userid", tempId);
            session.setAttribute("loginMember", login);
            session.setMaxInactiveInterval(0);


            // System.out.println("로그인 성공");
            // System.out.println("로그인 성공한 회원 : " + login.toString());
            return "index";
         } else {
            System.out.println("비밀번호 틀림");
            return "redirect:./loginFail.do";
         }

      } else {
         System.out.println("일치하는 아이디 없음");
         return "redirect:./loginFail.do";
      }
   }

   @RequestMapping(value = "/logout.do", method = RequestMethod.GET)
   public String home(HttpSession session) {
      session.removeAttribute("userid");
      session.removeAttribute("loginMember");
      session.removeAttribute("loginCheck");
      return "login";
   }

   @RequestMapping(value = "/signup.do", method = RequestMethod.GET)
   public String signup(Locale locale, Model model) {
      
      model.addAttribute("service",service);
      
      return "signup";
   }

   @RequestMapping(value = "/signupAction.do", method = RequestMethod.POST)
   public String signup(MemberVO membervo, Model model, HttpSession session) throws Exception {

//      request.setAttribute("id", service.idOverlapCheck(membervo.getId()));
      System.out.println("암호화할 비밀번호 : " + membervo.getPassword());

      // Sha256 암호화
      String encryptedPassword = UserSha256.encrypt(membervo.getPassword());
      membervo.setPassword(encryptedPassword); // 암호화된 비밀번호로 바꿔준다.
      
      if(service.getNamesCount(membervo.getName()) >= 2) {
         return "redirect:./signup.do?message=nameduplication";
      }
      
      // application객체 ---> session객체.getServletContext()
      String filePath = session.getServletContext().getRealPath("/resources/images/memberEmoji/");
      MultipartFile multipart = membervo.getMultipart();

      String filename = "(파일없음)";
      if (!multipart.isEmpty()) {
         filename = multipart.getOriginalFilename();
         File file = new File(filePath, filename);
         if (!file.exists()) {
            file.mkdirs();
         }
         multipart.transferTo(file);
      }
      membervo.setFilename(filename);

      model.addAttribute("member", membervo);
      model.addAttribute("signupcomplete", "signupcomplete");

      if (membervo.getFilename() == null) {
         service.signupWOFile(membervo);
      } else {
         service.signup(membervo);
      }

      return "login";
   }

/*   @RequestMapping(value = "/mypage.do", method = RequestMethod.GET)
   public String myPage(String userId, Model model) {
	   model.addAttribute("memberinfo", service.selectMember(userId)); 
      return "customerTier/mypage";
   }*/
   
   @RequestMapping(value = "/mypage.do", method = RequestMethod.GET)
   public String myPage(String userId, Model model) {
      model.addAttribute("memberinfo", service.selectMember(userId)); 
      model.addAttribute("buyBasket", orderService.getBuyBasket(userId));
      
      return "customerTier/mypage";
   }
   
   @RequestMapping(value = "/myinfo", method = RequestMethod.GET)
   public String myinfo(String userId, Model model) {
      model.addAttribute("memberinfo", service.selectMember(userId)); 
      
      return "customerTier/myinfo";
   }

   @RequestMapping(value = "/message", method = RequestMethod.GET)
   public String myMail() {
      return "customerTier/message";
   }

   @RequestMapping(value = "/sendMessage.do", method = RequestMethod.POST)
   public String sendMessage() {
      return "customerTier/message";
   }

   @RequestMapping(value = "/alarm.do", method = RequestMethod.GET)
   public String myPageAlarm(HttpServletRequest request) {
      List<Message> messageInboxList = messageService.getmyInbox((String) request.getSession().getAttribute("userid"));
      @SuppressWarnings("unused")
      List<Message> messageOutboxList = messageService .getmyOutbox((String) request.getSession().getAttribute("userid"));

      request.setAttribute("tempbusinessservice",tempservice);
      request.setAttribute("myInbox", messageInboxList);
      request.setAttribute("myOutbox", messageInboxList);
      return "customerTier/alarm";
   }

   @RequestMapping(value = "/kakaoLogin", method = RequestMethod.POST)
   public String kakaologin(@RequestParam("code") String code, HttpSession session, MemberVO vo, Model model) throws Exception {

      KakaoRestAPI kakao = new KakaoRestAPI();

      @SuppressWarnings("static-access")
      JsonNode jsonToken = kakao.getAccessToken(code);
      String access_token = jsonToken.get("access_token").toString();
      @SuppressWarnings("static-access")
      JsonNode userInfo = kakao.getKakaoUserInfo(access_token);
      String id = userInfo.get("id").toString();
      String nickName = userInfo.get("properties").get("nickname").toString();
      String img = userInfo.get("properties").get("profile_image").toString();
      String email = userInfo.get("kakao_account").get("email").toString();
      
      vo.setId(email.substring(1, email.length()-1));
      vo.setPassword("theone2020");
      vo.setEmail(email.substring(1, email.length()-1));
      vo.setName(nickName.substring(1, nickName.length()-1));
      vo.setFilename(img.substring(1, img.length()-1));
      vo.setTier("customer");
      vo.setRest("kakao");
      vo.setRest_id(id);
      
      System.out.println(vo);
      
      List<MemberVO> list = service.selectAll();
      
      for (int i=0; i<list.size(); i++) {
         try {
            if (!(list.get(i).getRest_id().equals(id))) {
               service.signup(vo);
               break;
            }
         } catch (Exception e) {
           System.out.println("이미 회원가입 되어있는 회원입니다.");
         }
      }
      session.setAttribute("loginMember", vo);
      model.addAttribute("loginMember", vo);
      
      return "index";
   }

   // 네이버 로그인 성공시 callback호출 메소드
   @RequestMapping(value = "/naverLogin", method = { RequestMethod.GET, RequestMethod.POST })
   public String callback(Model model, @RequestParam String code, @RequestParam String state, 
         HttpSession session, MemberVO vo)
         throws IOException, ParseException, InterruptedException, ExecutionException,
         org.json.simple.parser.ParseException {

      OAuth2AccessToken oauthToken;
      oauthToken = naverLoginBO.getAccessToken(session, code, state);
      // 1. 로그인 사용자 정보를 읽어온다.
      apiResult = naverLoginBO.getUserProfile(oauthToken); // String형식의 json데이터
      /**
       * apiResult json 구조 {"resultcode":"00", "message":"success",
       * "response":{"id":"33666449","nickname":"shinn****","age":"20-29","gender":"M","email":"sh@naver.com","name":"\uc2e0\ubc94\ud638"}}
       **/
      // 2. String형식인 apiResult를 json형태로 바꿈
      JSONParser parser = new JSONParser();
      Object obj = parser.parse(apiResult);
      JSONObject jsonObj = (JSONObject) obj;
      // 3. 데이터 파싱
      // Top레벨 단계 _response 파싱
      JSONObject response_obj = (JSONObject) jsonObj.get("response");
      // response의 nickname값 파싱
      String nickname = (String) response_obj.get("nickname");
      String id = (String) response_obj.get("id");
      String email = (String) response_obj.get("email");
      String name = (String) response_obj.get("name");
      System.out.println(nickname + "\n" + id + "\n" + email + "\n" + name);
      // 4.파싱 닉네임 세션으로 저장
      session.setAttribute("userid", name); // 세션 생성
      
      vo.setId(email);
      vo.setPassword("theone2020");
      vo.setEmail(email);
      vo.setName(name);
      vo.setRest("naver");
      vo.setTier("customer");
      vo.setRest_id(id);
      System.out.println(vo);
      
      List<MemberVO> list = service.selectAll();
      
      for (int i=0; i<list.size(); i++) {
         try {
            if (!(list.get(i).getRest_id().equals(id))) {
               service.signupWOFile(vo);
            }
         } catch (Exception e) {
           System.out.println("이미 회원가입 되어있는 회원입니다.");
         }
      }
      
      session.setAttribute("loginMember", vo);
      model.addAttribute("loginMember", vo);

      return "index";
   }
   
   
   @RequestMapping(value = "/pwfind", method = RequestMethod.GET)
   public String pwfind() {
      return "pwfind";
   }
   
   @RequestMapping("/sendpw.do")
   public ModelAndView sendEmailAction (@RequestParam Map<String, Object> paramMap, ModelMap model){
      IdfindVO email = new IdfindVO();
	   ModelAndView mav;
       String id=(String) paramMap.get("id");
       String e_mail=(String) paramMap.get("email");
       String pw= RandomPw.randompw();
       System.out.println("random 세팅된 비밀번호는 ? " + pw);
       String pw1=UserSha256.encrypt(pw);
       emailSender.update(id, pw1);
       email.setReciver(e_mail);
       email.setSubject(id+"님 비밀번호 찾기 메일입니다.");
       email.setContent("비밀번호는 "+pw+" 입니다."); //null pointer 
       
       
       emailSender.SendEmail(email);
       mav= new ModelAndView("redirect:/member/login.do");
       System.out.println("전송완료");
       return mav;
    }
   
   @RequestMapping(value = "/idfind", method = RequestMethod.GET)
   public String idfind() {
	   return "idfind";
   }
   
   @RequestMapping("/findid.do")
   public String findid(@RequestParam Map<String, Object> paramMap,ModelMap model) {
	   String name=(String) paramMap.get("name");
	   String email=(String) paramMap.get("email");
	   String phone=(String) paramMap.get("phone");
	   model.addAttribute("list", service.findid(name, email, phone)); 
	   return "findresult";
   }
   
   
   @RequestMapping(value = "/changeAction.do", method = RequestMethod.POST)
   public String changeAction(MemberVO membervo, Model model, HttpSession session) throws Exception {
	   MemberVO orgininfo = service.selectMember(membervo.getId());
//      request.setAttribute("id", service.idOverlapCheck(membervo.getId()));
	   System.out.println("암호화할 비밀번호 : " + membervo.getPassword());
	   
	   // Sha256 암호화
	   String pw =UserSha256.encrypt("********");
	   String encryptedPassword = UserSha256.encrypt(membervo.getPassword());
	   if(pw.equals(encryptedPassword)) {
	   membervo.setPassword(orgininfo.getPassword()); // 암호화된 비밀번호로 바꿔준다.
	   }else {
		   membervo.setPassword(encryptedPassword);
	   }
	   
	   // application객체 ---> session객체.getServletContext()
	   String filePath = session.getServletContext().getRealPath("/resources/images/memberEmoji/");
	   MultipartFile multipart = membervo.getMultipart();
	   
	   String filename = "(파일없음)";
	   if (!multipart.isEmpty()) {
		   filename = multipart.getOriginalFilename();
		   File file = new File(filePath, filename);
		   if (!file.exists()) {
			   file.mkdirs();
		   }
		   multipart.transferTo(file);
	   }
	   membervo.setFilename(filename);
	   
	   model.addAttribute("memberinfo", membervo);
	   
	   service.infoupdate(membervo);
	   
	   model.addAttribute("success", "success");
	   return "customerTier/mypage";
	   
   }
   
   @ResponseBody
   @PostMapping(value="/idCheck")
   public int idCheck(String id) {
      int result = service.idCheck(id);
      
      return result;
   }
}