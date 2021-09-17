package com.project.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.vo.Message;

@Repository
public class MessageDAOImpl implements MessageDAO {

	@Autowired
	private SqlSession sqlSession;

	@Override
	public void addMessage(Message message) {
		sqlSession.insert("com.project.messageMapper.addMessage", message);

	}

	@Override
	public Message selectMessage() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void deleteMessage(Message message) {
		// TODO Auto-generated method stub

	}

	@Override
	public List<Message> getmyInbox(String receiver) {
		return sqlSession.selectList("com.project.messageMapper.myInbox", receiver);
	}

	@Override
	public List<Message> getmyOutbox(String fromId) {
		return sqlSession.selectList("com.project.messageMapper.myOutbox", fromId);
	}

	@Override
	public void updateTopic(Message message) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("messagecontent", message.getMessagecontent());
		map.put("receiver", message.getReceiver());
		sqlSession.update("com.project.messageMapper.updateTopic", message);

	}

	@Override
	public int countMessages(String receiver) {
		return sqlSession.selectOne("com.project.messageMapper.countMessages", receiver);
	}

	@Override
	public int mustreadMessages(String receiver) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("receiver", receiver);

		return sqlSession.selectOne("com.project.messageMapper.mustread", map);
	}

}
