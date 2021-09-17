package com.project.service;

import java.util.List;

import com.project.vo.Message;

public interface MessageService {

	public void addMessage(Message message);

	public void deleteMessage(Message message);

	public List<Message> getmyInbox(String receiver);

	public List<Message> getmyOutbox(String fromId);

	public void updateTopic(Message message);

	public Message selectMessage();

	public int countMessages(String receiver);

	public int mustreadMessages(String receiver);
}
