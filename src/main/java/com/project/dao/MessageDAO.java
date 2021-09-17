package com.project.dao;

import java.util.List;

import com.project.vo.Message;

public interface MessageDAO {

	public void addMessage(Message message);

	public void deleteMessage(Message message);

	public List<Message> getmyInbox(String receiver);

	public List<Message> getmyOutbox(String fromId);

	public Message selectMessage();

	public void updateTopic(Message message);

	public int countMessages(String receiver);

	public int mustreadMessages(String receiver);
}
