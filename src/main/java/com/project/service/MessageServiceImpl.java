package com.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.dao.BoardDAO;
import com.project.dao.MessageDAO;
import com.project.vo.Message;

@Service
public class MessageServiceImpl implements MessageService {

	@Autowired
	private MessageDAO dao;

	public MessageServiceImpl() {
	}

	public MessageServiceImpl(MessageDAO dao) {
		this.dao = dao;
	}

	@Override
	public void addMessage(Message message) {
		dao.addMessage(message);

	}

	@Override
	public void deleteMessage(Message message) {
		// TODO Auto-generated method stub

	}

	@Override
	public List<Message> getmyInbox(String receiver) {
		return dao.getmyInbox(receiver);
	}

	@Override
	public List<Message> getmyOutbox(String fromId) {
		return dao.getmyOutbox(fromId);
	}

	@Override
	public Message selectMessage() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void updateTopic(Message message) {
		dao.updateTopic(message);
	}

	@Override
	public int countMessages(String receiver) {
		return dao.countMessages(receiver);
	}

	@Override
	public int mustreadMessages(String receiver) {

		return dao.mustreadMessages(receiver);
	}

}
