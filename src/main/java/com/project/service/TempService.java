package com.project.service;

import java.util.List;


import com.project.vo.ProductVO;
import com.project.vo.TempVO;

import net.webjjang.util.PageObject;

public interface TempService {
	public void signuplaunchForm(TempVO vo);
	
	public List<TempVO> getWaitingList();
	
	public List<ProductVO> getDabangList();
	
	public List<ProductVO> getHanshinList();
	
	public String findBrandByContractNumber(int contractno);
	
	public TempVO findmyBusiness(int contractno);
	
	public TempVO findmyBusiness(String franchisekey);
	
	public void updateConsult(TempVO vo);
	
	public void updateStatus(int contractno);
	
	public List<TempVO> getApprovedpeople();
	
	public List<TempVO> getFranchiseList(PageObject pageObject);
	
	public void updateFranchise(TempVO vo);
}


