package com.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.dao.FranchisePdtApprovalDAO;
import com.project.vo.FranchisePdtApprovalVO;
import com.project.vo.RequestOrderVO;

@Service
public class FranchisePdtApprovalServiceImpl implements FranchisePdtApprovalService{

	@Autowired
	private FranchisePdtApprovalDAO dao;
	
	public FranchisePdtApprovalServiceImpl() {
		
	}
	
	public FranchisePdtApprovalServiceImpl(FranchisePdtApprovalDAO dao) {
		this.dao = dao;
	}

	@Override
	public void insertDummy(FranchisePdtApprovalVO vo) {
		dao.insertDummyData(vo);
		
	}

	@Override
	public List<FranchisePdtApprovalVO> selectDummyList(String franchisekey) {
		return dao.selectDummyList(franchisekey);
	}

	@Override
	public FranchisePdtApprovalVO selectDummyFromDummyId(int dummyId) {
		return dao.selectDummyFromID(dummyId);
	}

	@Override
	public FranchisePdtApprovalVO selectDummyFromRandom(String random) {
		return dao.selectDummyFROMRandom(random);
	}
	
	@Override
    public int selectPidJoinOnApproval(int approveId) {
		return dao.selectPidJoinOnApproval(approveId);
    }

   @Override
   public RequestOrderVO selectObjectJoinOnApproval(int approveId) {
       return dao.selectThatApproval(approveId);
   }
}
