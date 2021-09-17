package com.project.interceptor;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class AuthInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// 리턴값: true --> 진행(handler가 handle하게 끔 내비둔다)
		// false --> 핸들러가 핸들하지않음.
		System.out.println("(인터셉터 실행)");

		// session이 만들어져있는경우, 안만들어져있는경우
		// session없을때 session만들지말라는 의미 : false param(getSession) null 값
		HttpSession session = request.getSession(false);

		// session.getAttribute("login_id");
		// null check
		if (session != null) {
			if (session.getAttribute("userid") != null) {
				return true; // 로그인O 상태이므로 handler 실행을 진행합니다.
			}
		}
		// 로그인 action들어가는상황에서도
		// 아래코드없으면 실행이제대로안됨.
		if (request.getParameter("id") != null) {
			// page2(=LoginAction)으로 진입하는타이밍
			return true; // 로그인 진행되는 상태이므로 ----> 핸들러 실행을 진행합니다.
		}
		System.out.println("인터셉터에 의해 경로재설정 : /");
		response.sendRedirect(request.getContextPath() + "/"); // 로그인 form으로 다시보냅니다.

		return false; // 핸들러 실행되기 전에 중단(핸들러 실행x)
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {

		BufferedWriter bw = new BufferedWriter(new FileWriter("log_test_web5.txt", true));// 프로젝트 JavaTest가있는곳에
																							// log_test.txt
		// 파일 디렉토리를 생성.
		PrintWriter pw = new PrintWriter(bw, true);
		// post handler 로그인 아이디가누구누구다

		long currentTime = System.currentTimeMillis();

		// long time = System.currentTimeMillis();

		SimpleDateFormat dayTime = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");

		String str = dayTime.format(new Date(currentTime));

		String id = (String) request.getSession().getAttribute("userid");// 로그인한놈

		// 로그인못한놈
		String loginFailId = (String) request.getSession().getAttribute("loginFailId");

		boolean login = (id != null) ? true : false;

		if (login) {
			System.out.println("로그인 성공한 아이디: ");
			pw.println("로그인을 시도한 시간: " + str + " log_test_web4.txt 요청 - " + id);
			pw.write("로그인을 시도한 시간: " + str + " log_test_web4.txt 요청 - " + id);
		}else {
			System.out.println("로그인 실패한아이디 ");
			pw.println("로그인을 시도한 시간: " + str + " log_test_web4.txt 요청 - " + loginFailId);// 로그인 실패시 어떤 아이디로 요청이들어왔다.
		}

		bw.close();
		
		pw.close();

	}

}
