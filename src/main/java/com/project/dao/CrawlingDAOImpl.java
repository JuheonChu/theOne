package com.project.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.vo.BoardVO;
import com.project.vo.CrawlingVO;

@Repository
public class CrawlingDAOImpl implements CrawlingDAO{

	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<CrawlingVO> personList() {
		return sqlSession.selectList("com.project.mapper.CrawlingMapper.personList");
	}
}
