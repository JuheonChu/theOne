package com.project.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.vo.ProductVO;
import com.project.vo.TempVO;

@Repository
public class TempDAOImpl implements TempDAO{
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public void signupForBusinessLauncher(TempVO vo) {
		sqlSession.insert("com.project.tempMapper.temporary.signupMember", vo);
	}

	@Override
	public List<TempVO> getFranchiseWaitingList() {
		return sqlSession.selectList("com.project.tempMapper.temporary.selectwaitingpeople");
	}

	@Override
	public List<ProductVO> getDabangList() {
		return sqlSession.selectList("com.project.tempMapper.temporary.selectdabang");
	}

	@Override
	public List<ProductVO> getHanshinList() {
		return sqlSession.selectList("com.project.tempMapper.temporary.selecthanshin");
	}

	@Override
	public String findBrandByContractNumber(int contractno) {
		return sqlSession.selectOne("com.project.tempMapper.temporary.findBrand",contractno);
	}

	@Override
	public TempVO findmyBusiness(int contractno) {
		return sqlSession.selectOne("com.project.tempMapper.temporary.findMyBusinessInfo", contractno);
	}

	@Override
	public void updateConsult(TempVO vo) {
		sqlSession.update("com.project.tempMapper.temporary.updateConsult", vo);
		
	}

	@Override
	public void updateStatus(int contractno) {
		sqlSession.update("com.project.tempMapper.temporary.updateStatus", contractno);
		
	}

	@Override
	public List<TempVO> getApprovedpeople() {
		return sqlSession.selectList("com.project.tempMapper.temporary.approvedpeople", "approved");
	}

	@Override
	public void updateFranchise(TempVO vo) {
		Map <String, Object> map = new HashMap<String,Object>();
		//map.put("contractno", contractno);
		sqlSession.update("com.project.tempMapper.temporary.updateFranchise",vo);
		
	}

	@Override
	public int findcontractno(int member_index) {
		return sqlSession.selectOne("", member_index);
	}

	@Override
	public TempVO findmyBusiness(String franchisekey) {
		return sqlSession.selectOne("com.project.tempMapper.temporary.findMyBusinessInfoByFranchisekey",franchisekey);
	}
	

	
}
