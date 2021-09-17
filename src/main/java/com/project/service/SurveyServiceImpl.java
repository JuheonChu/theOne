package com.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.dao.SurveyDAO;
import com.project.vo.IncomeVO;
import com.project.vo.OrderVO;
import com.project.vo.SurveyVO;
import com.project.vo.TempVO;

@Service
public class SurveyServiceImpl implements SurveyService {

	@Autowired
	private SurveyDAO sdao;
	
	@Override
	public void Survey(SurveyVO vo) {
		sdao.Survey(vo);
	}

	@Override
	public int francount(String franchisekey) {
		return sdao.francount(franchisekey);
	}

	@Override
	public List<SurveyVO> franinfo(String franchisekey) {
		return sdao.franinfo(franchisekey);
	}

	@Override
	public void fchangeinfo(SurveyVO vo) {
		sdao.fchangeinfo(vo);
	}

	@Override
	public List<SurveyVO> paikaverage() {
		return sdao.paikaverage();
	}
	
	@Override
	public List<SurveyVO> hanshinaverage() {
		return sdao.hanshinaverage();
	}

	@Override
	public String selectlocation(String fkey) {
		return sdao.selectlocation(fkey);
	}

	@Override
	public List<OrderVO> fransalesinfo(String franchisekey) {
		return sdao.fransalesinfo(franchisekey);
	}
	@Override
	public List<OrderVO> piakssales() {
		return sdao.piakssales();
	}

	@Override
	public List<IncomeVO> theoneinfo() {
		return sdao.theoneinfo();
	}
	
	@Override
	public List<TempVO> frankey() {
		return sdao.frankey();
	}

	@Override
	public List<OrderVO> hanshinsales() {
		return sdao.hanshinsales();
	}

	

}
