package com.project.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.dao.IncomeDAO;
import com.project.vo.IncomeVO;

@Service
public class IncomeServiceImpl implements IncomeService {

	@Autowired
	private IncomeDAO dao;
	
	@Override
	public void insertIncome(IncomeVO vo) {
		dao.insertIncome(vo);
		
	}

}
