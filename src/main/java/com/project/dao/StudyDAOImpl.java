package com.project.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.vo.StudyVO;

import lombok.extern.log4j.Log4j;
import net.webjjang.util.PageObject;

@Repository
@Log4j
public class StudyDAOImpl implements StudyDAO {
	
	@Autowired
	public SqlSession sqlSession;

	@Override
	public List<StudyVO> list(PageObject pageObject) {
		HashMap<String,Object>map = new HashMap<String,Object>();
		map.put("startRow", pageObject.getStartRow());
		map.put("endRow", pageObject.getEndRow());
		map.put("key", pageObject.getKey());
		map.put("word", pageObject.getWord());
		
		log.info(map);
		return sqlSession.selectList("com.project.mapper.StudyMapper.list", map);
	}

	@Override
	public int getRow(PageObject pageObject) {
		return sqlSession.selectOne("com.project.mapper.StudyMapper.getRow");
	}

	@Override
	public void Vwrite(StudyVO vo) {
		HashMap<String,Object>map = new HashMap<String,Object>();
		map.put("category", 2);
		map.put("title",vo.getTitle());
		map.put("content", vo.getContent());
		map.put("url", vo.getUrl());
		sqlSession.insert("com.project.mapper.StudyMapper.Vwrite", map);
	}

	@Override
	public List<StudyVO> Updatelist(String menu) {
		return sqlSession.selectList("com.project.mapper.StudyMapper.UpdateList",menu);
	}

	@Override
	public void Vupdate(StudyVO vo, String menu) {
		HashMap<String,Object>map = new HashMap<String,Object>();
		map.put("menu", menu);
		map.put("title",vo.getTitle());
		map.put("content", vo.getContent());
		map.put("url", vo.getUrl());
		sqlSession.update("com.project.mapper.StudyMapper.Vupdate", map);
	}

	@Override
	public void Vdelete(String menu) {
		sqlSession.delete("com.project.mapper.StudyMapper.Vdelete", menu);
	}

	@Override
	public List<StudyVO> fcontent(String menu) {
		return sqlSession.selectList("com.project.mapper.StudyMapper.fcontent", menu);
	}

	@Override
	public List<StudyVO> flist(PageObject pageObject) {
		HashMap<String,Object>map = new HashMap<String,Object>();
		map.put("startRow", pageObject.getStartRow());
		map.put("endRow", pageObject.getEndRow());
		map.put("key", pageObject.getKey());
		map.put("word", pageObject.getWord());
		
		log.info(map);
		return sqlSession.selectList("com.project.mapper.StudyMapper.flist", map);
	}

}
