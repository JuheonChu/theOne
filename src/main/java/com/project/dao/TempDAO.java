package com.project.dao;

import java.util.List;

import com.project.vo.TempVO;
import com.project.vo.ProductVO;

public interface TempDAO {
	
	public void signupForBusinessLauncher(TempVO vo);
	
	public List<TempVO> getFranchiseWaitingList();
	
	public List<ProductVO> getDabangList();
	
	public List<ProductVO> getHanshinList();
	
	public String findBrandByContractNumber(int contractNo);
	
	public TempVO findmyBusiness(int contractno);
	
	public TempVO findmyBusiness(String franchisekey);
	
	//public LaunchBusinessVO findmyBusiness(int contractno);
	
	public void updateConsult(TempVO vo);
	
	public void updateStatus(int contractno);
	
	public List<TempVO> getApprovedpeople();
	
	public void updateFranchise(TempVO vo);
	
	public int findcontractno(int member_index);

//	void signupForBusinessLauncher(TempVO vo);
}
