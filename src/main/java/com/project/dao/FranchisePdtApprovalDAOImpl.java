package com.project.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.vo.FranchisePdtApprovalVO;
import com.project.vo.RequestOrderVO;
@Repository
public class FranchisePdtApprovalDAOImpl implements FranchisePdtApprovalDAO {
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public void insertDummyData(FranchisePdtApprovalVO vo) {
		sqlSession.insert("com.project.mapper.DummyMapper.insertDummy", vo);
	}

	@Override
	public List<FranchisePdtApprovalVO> selectDummyList(String franchisekey) {
		return sqlSession.selectList("com.project.mapper.DummyMapper.selectdummylist", franchisekey);
	}

	@Override
	public FranchisePdtApprovalVO selectDummyFromID(int dummyId) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("dummyId", dummyId);
		return sqlSession.selectOne("com.project.mapper.DummyMapper.selectdummyFromDummyId", map);
	}

	@Override
	public FranchisePdtApprovalVO selectDummyFROMRandom(String random) {
		return sqlSession.selectOne("com.project.mapper.DummyMapper.selectdummyFromDummyRandom", random);
	}
	
   @Override
   public int selectPidJoinOnApproval(int approveId) {
      return sqlSession.selectOne("com.project.mapper.DummyMapper.selectPidJoinOnApproval", approveId);
   }

   @Override
   public RequestOrderVO selectThatApproval(int approveId) {
      return sqlSession.selectOne("com.project.mapper.DummyMapper.selectObjectJoinOnApproval", approveId);
   }

}
