package com.project.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.vo.IncomeVO;

@Repository
public class IncomeDAOImpl implements IncomeDAO {
	@Autowired
	private SqlSession sqlSession;

	@Override
	public void insertIncome(IncomeVO vo) {
		sqlSession.insert("com.project.mapper.incomeMapper.insertIncome",vo);

	}
	
	

}
