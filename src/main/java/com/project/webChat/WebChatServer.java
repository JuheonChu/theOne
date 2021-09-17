package com.project.webChat;

import java.io.IOException;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.http.HttpServlet;
import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import com.project.vo.ChatClient;

@SuppressWarnings("serial")
@ServerEndpoint("/WebChatServer")
public class WebChatServer extends HttpServlet {
	private static Map<Session,ChatClient> users = Collections.synchronizedMap(new HashMap<Session, ChatClient>());
	
	@OnMessage
	public void onMsg(String message, Session session) throws IOException{
		String userName = users.get(session).getName();
		System.out.println(userName + " : " + message);
		
		synchronized (users) {
			Iterator<Session> it = users.keySet().iterator();
			while(it.hasNext()){
				Session currentSession = it.next();
				if(!currentSession.equals(session)){
					currentSession.getBasicRemote().sendText(userName + " : " + message);
				}
			}
		}
	}
	
	@OnOpen
	public void onOpen(Session session){
		ChatClient client = new ChatClient();
		String userName = "admin";
		
		if(users.size() > 1) {
			users.remove(session);
		}
		
		else if(users.size() != 0 && users.size() >= 1) {
			userName = "user";
			
			client.setName(userName);
			users.put(session, client);
			sendNotice(userName + "님이 입장하셨습니다. 현재 사용자 " + users.size() + "명");
		}
		
		else {
			System.out.println(session);
			client.setName(userName);
			
			System.out.println(session + " connect");
			
			users.put(session, client);
			sendNotice(client.getName() + "님이 입장하셨습니다. 현재 사용자 " + users.size() + "명");
		}
	}
	
	public void sendNotice(String message){
		String userName = "server";
		System.out.println(userName + " : " + message);
		
		synchronized (users) {
			Iterator<Session> it = users.keySet().iterator();
			while(it.hasNext()){
				Session currentSession = it.next();
				try {
					currentSession.getBasicRemote().sendText(userName + " : " + message);
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}

	@OnClose
	public void onClose(Session session) {
		String userName = users.get(session).getName();
		users.remove(session);
		sendNotice(userName + "님이 퇴장하셨습니다. 현재 사용자 " + users.size() + "명");
	}
	
	

}