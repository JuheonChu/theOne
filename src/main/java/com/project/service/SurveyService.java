package com.project.service;

import java.util.List;

import com.project.vo.IncomeVO;
import com.project.vo.OrderVO;
import com.project.vo.SurveyVO;
import com.project.vo.TempVO;

public interface SurveyService {
	public void Survey(SurveyVO vo);
	
	public int francount(String fkey);
	
	public List<SurveyVO> franinfo(String fkey);
	
	public void fchangeinfo(SurveyVO vo);
	
	public List<SurveyVO> paikaverage(); 
	
	public List<SurveyVO> hanshinaverage();

	public String selectlocation(String fkey);

	public List<OrderVO> fransalesinfo(String franchisekey);

	public List<OrderVO> piakssales();
	
	public List<OrderVO> hanshinsales();
	
	public List<IncomeVO> theoneinfo();
	
	public List<TempVO> frankey();
}
