package com.project.dao;

import java.util.List;

import com.project.vo.FranchisePdtApprovalVO;
import com.project.vo.RequestOrderVO;

public interface FranchisePdtApprovalDAO {

	public void insertDummyData(FranchisePdtApprovalVO vo);
	
	public List<FranchisePdtApprovalVO> selectDummyList(String franchisekey);
	
	public FranchisePdtApprovalVO selectDummyFromID(int dummyId);
	
	public FranchisePdtApprovalVO selectDummyFROMRandom(String random);

	public int selectPidJoinOnApproval(int approveId);
	   
	public RequestOrderVO selectThatApproval(int approveId);
}
