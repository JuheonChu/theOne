package com.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.dao.CrawlingDAO;
import com.project.vo.CrawlingVO;

@Service
public class CrawlingServiceImpl implements CrawlingService{
	
	@Autowired
	private CrawlingDAO dao;
	
	public CrawlingServiceImpl() {}
	
	public CrawlingServiceImpl(CrawlingDAO dao) {
		this.dao = dao;
	}

	@Override
	public List<CrawlingVO> personList() {
		return dao.personList();
	}
	
	
}
