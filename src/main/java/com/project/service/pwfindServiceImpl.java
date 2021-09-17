package com.project.service;

import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailException;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.stereotype.Service;

import com.project.dao.MemberDAO;
import com.project.vo.IdfindVO;

@Service
public class pwfindServiceImpl implements pwfindService {

	@Autowired 
	private JavaMailSenderImpl mailSender;
	
	@Autowired 
	private MemberDAO memberdao;
	
	@Override
	public void SendEmail(IdfindVO idvo) {
		if(mailSender==null) {
       	 System.out.println("mailSender가 NULL값");
        }
        MimeMessage msg = mailSender.createMimeMessage();  
       try {
       	msg.setSubject(idvo.getSubject());
	        msg.setText(idvo.getContent());
	        msg.setRecipients(MimeMessage.RecipientType.TO , InternetAddress.parse(idvo.getReciver()));       
       }catch(MessagingException e) {
       	System.out.println("MessagingException");
       	e.printStackTrace();
       }
       try {
       	mailSender.send(msg);
       }catch(MailException e) {
       	System.out.println("MailException");
       	e.printStackTrace();
       }   

	}

	@Override
	public void update(String id, String pw) {
		memberdao.randompw(id, pw);
	}

}
