package com.project.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.vo.ReviewBoardVO;

import lombok.extern.log4j.Log4j;
import net.webjjang.util.PageObject;

@Repository
@Log4j
public class ReviewBoardDAOImpl implements ReviewBoardDAO {

	@Autowired
	public SqlSession sqlSession;
	
	@Override
	public List<ReviewBoardVO> list(PageObject pageObject) {
		HashMap<String,Object>map = new HashMap<String,Object>();
		map.put("startRow", pageObject.getStartRow());
		map.put("endRow", pageObject.getEndRow());
		map.put("key", pageObject.getKey());
		map.put("word", pageObject.getWord());
		
		log.info(map);
		return sqlSession.selectList("com.project.mapper.ReviewBoardMapper.list", map);
		
	}

	@Override
	public int getRow(PageObject pageObject) {
		
		return sqlSession.selectOne("com.project.mapper.ReviewBoardMapper.getRow");
	}

	@Override
	public ReviewBoardVO view(int no) {
		
		return sqlSession.selectOne("com.project.mapper.ReviewBoardMapper.view", no);
	}

	@Override
	public void increase(int no) {
		sqlSession.update("com.project.mapper.ReviewBoardMapper.increase", no);
	}

	@Override
	public void write(ReviewBoardVO vo) {
		sqlSession.insert("com.project.mapper.ReviewBoardMapper.write", vo);
	}

	@Override
	public void update(ReviewBoardVO vo) {
		sqlSession.update("com.project.mapper.ReviewBoardMapper.update", vo);
	}

	@Override
	public void delete(int no) {
		sqlSession.update("com.project.mapper.ReviewBoardMapper.delete", no);
	}

	@Override
	public void addComment(ReviewBoardVO vo) {
		
		sqlSession.update("com.project.mapper.ReviewBoardMapper.updateStep", vo);
		log.info(sqlSession);
		sqlSession.insert("com.project.mapper.ReviewBoardMapper.addComment", vo);
		log.info(sqlSession);
	}
}
