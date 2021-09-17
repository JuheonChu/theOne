package com.project.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;

import com.project.service.FranchisePdtApprovalService;
import com.project.service.MessageService;
import com.project.service.TempService;
import com.project.vo.FranchisePdtApprovalVO;
import com.project.vo.Message;
import com.project.vo.TempVO;

@Controller
public class StompController {
	@Autowired
	MessageService service;
	
	@Autowired
	TempService tempservice;
	
	@Autowired
	FranchisePdtApprovalService dummyservice;
	
	@MessageMapping("/1")
	public String t() {
		return "home";
	}
	
	@MessageMapping("/TTTX")
	@SendTo("/topic/messagedsd")
	public String ttt(String message) throws Exception{//객체단위로 문자주고받아도됨.
		//클라이언트에서 JSON으로쏘면 param == Object]
		System.out.println("TTT>>>> Topic한테 publishing해줄 메시지: " + message );
		return message;
	}
	
	
	@MessageMapping("/stompTest") //end point 지정.
	@SendTo("/topic/message")
	public Message send(Message message){//객체단위로 문자주고받아도됨.
		
		System.out.println("contractno 넘어왔습니까?");
		String time = new SimpleDateFormat("HH:mm").format(new Date());
		message.setRegist_date(time);
	
		System.out.println("들어온 메시지 : " + message.toString());	
	
		service.addMessage(message);
		return message;
	}
	
	@MessageMapping("/stompTest/finalApproval") //end point 지정.
	@SendTo("/topic/message")
	public Message approve(Message message){//객체단위로 문자주고받아도됨.
		System.out.println("메시지가 들어옴.................");
		String time = new SimpleDateFormat("HH:mm").format(new Date());
		message.setRegist_date(time);
		System.out.println("최종승인에 들어온 메시지 : " + message.toString());
		
		Message message3 = new Message();
		message3.setContractno(message.getContractno());
		message3.setFromId(message.getFromId());
		message3.setIdx(message.getIdx());
		message3.setMessagecontent(message.getMessagecontent());
		message3.setReceiver(message.getReceiver());
		message3.setRegist_date(message.getRegist_date());
		message3.setTopic(message.getTopic());
		
		Message message2 = message;
		message2.setTopic("일반");
		message2.setMessagecontent("상담문의");
		
		
		//필수---> 일반
		service.updateTopic(message2);
		
		service.addMessage(message3);
		return new Message();
	}
	
	@MessageMapping("/stompTest/approveResources") //end point 지정.
	@SendTo("/topic/message")
	public Message approveResources(Message message, String  obj, @RequestBody Map<String,Object> map){//객체단위로 문자주고받아도됨.
		System.out.println("메시지가 들어옴.................");
		String time = new SimpleDateFormat("HH:mm").format(new Date());
		message.setRegist_date(time);
		System.out.println("최종승인에 들어온 메시지 : " + message.toString());
		
		Message message3 = new Message();
		message3.setContractno(message.getContractno());
		message3.setFromId(message.getFromId());
		message3.setIdx(message.getIdx());
		message3.setMessagecontent(message.getMessagecontent());
		message3.setReceiver(message.getReceiver());
		message3.setRegist_date(message.getRegist_date());
		message3.setTopic(message.getTopic());
		
		TempVO mytemp = tempservice.findmyBusiness(message.getContractno()); //여기부터해야됨.....
		
		FranchisePdtApprovalVO dummy = new FranchisePdtApprovalVO();
		
		int pid = Integer.parseInt((String)map.get("pid").toString().trim());
		int reqCount = Integer.parseInt((String)map.get("reqCount").toString().trim());
		int profit = Integer.parseInt((String)map.get("profit").toString().trim());
		
		//dummy.setDummyId("");
		//dummy.setFranchisekey(mytemp.getFranchisekey());
		//dummy.setPid(pid);
		///dummy.setProfit(profit);
	///	dummy.setReq_count(reqCount);
	///	dummy.setContractno(message.getContractno());
		
		//dummyservice.insertDummy(dummy);
		
		//dummy.getDummyId()
		
		service.addMessage(message3);
		
		return new Message();
	}
	
	

}
