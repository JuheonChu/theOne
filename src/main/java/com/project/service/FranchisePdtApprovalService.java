package com.project.service;

import java.util.List;

import com.project.vo.FranchisePdtApprovalVO;
import com.project.vo.RequestOrderVO;

public interface FranchisePdtApprovalService {

	public void insertDummy(FranchisePdtApprovalVO vo);
	
	public List<FranchisePdtApprovalVO> selectDummyList(String franchisekey);
	
	public FranchisePdtApprovalVO selectDummyFromDummyId(int dummyId);
	
	public FranchisePdtApprovalVO selectDummyFromRandom(String random);

	public int selectPidJoinOnApproval(int approveId);
	   
    public RequestOrderVO selectObjectJoinOnApproval(int approveId);
}
