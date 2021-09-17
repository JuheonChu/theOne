package com.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.dao.TempDAO;
import com.project.vo.ProductVO;
import com.project.vo.TempVO;

import net.webjjang.util.PageObject;

@Service
public class TempServiceImpl implements TempService {

	@Autowired
	private TempDAO dao;

	@Override
	public void signuplaunchForm(TempVO vo) {
		dao.signupForBusinessLauncher(vo);

	}

	@Override
	public List<TempVO> getWaitingList() {
		return dao.getFranchiseWaitingList();
	}

	@Override
	public List<ProductVO> getDabangList() {
		return dao.getDabangList();
	}

	@Override
	public List<ProductVO> getHanshinList() {
		return dao.getHanshinList();
	}

	@Override
	public String findBrandByContractNumber(int contractno) {
		return dao.findBrandByContractNumber(contractno);
	}

	@Override
	public TempVO findmyBusiness(int contractno) {
		return dao.findmyBusiness(contractno);
	}

	@Override
	public void updateConsult(TempVO vo) {
		dao.updateConsult(vo);

	}

	@Override
	public void updateStatus(int contractno) {
		dao.updateStatus(contractno);

	}

	@Override
	public List<TempVO> getApprovedpeople() {
		return dao.getApprovedpeople();
	}

	

	@Override
	public void updateFranchise(TempVO vo) {
		dao.updateFranchise(vo);

	}

	@Override
	public List<TempVO> getFranchiseList(PageObject pageObject) {
		return dao.getFranchiseWaitingList();
	}

	@Override
	public TempVO findmyBusiness(String franchisekey) {
		return dao.findmyBusiness(franchisekey);
	}

}
