package com.project.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.vo.IncomeVO;
import com.project.vo.OrderVO;
import com.project.vo.SurveyVO;
import com.project.vo.TempVO;

@Repository

public class SurveyDAOImpl implements SurveyDAO {

	@Autowired
	private SqlSession sqlSession;

	
	@Override
	public void Survey(SurveyVO vo) {
		HashMap<String,Object> map = new HashMap<String,Object>();
		map.put("fkey", vo.getFkey());
		System.out.println("다오프랜키"+vo.getFkey());
		map.put("franchisekey", vo.getFranchisekey());
		map.put("flavor", vo.getFlavor());
		map.put("delivery", vo.getDelivery());
		map.put("service", vo.getService());
		map.put("etc", vo.getEtc());
		sqlSession.insert("com.project.mapper.SurveyMapper.surveywrite", map);
	}


	@Override
	public int francount(String franchisekey) {
		return sqlSession.selectOne("com.project.mapper.SurveyMapper.francount", franchisekey);
	}


	@Override
	public List<SurveyVO> franinfo(String franchisekey) {
		return sqlSession.selectList("com.project.mapper.SurveyMapper.franinfo", franchisekey);
	}


	@Override
	public void fchangeinfo(SurveyVO vo) {
		HashMap<String,Object> map = new HashMap<String,Object>();
		map.put("franchisekey", vo.getFranchisekey());
		map.put("ordercount", vo.getOrdercount());		
		map.put("flavor", vo.getFlavor());
		map.put("delivery", vo.getDelivery());
		map.put("service", vo.getService());
		map.put("etc", vo.getEtc());
		sqlSession.update("com.project.mapper.SurveyMapper.franupdate", map);
	}


	@Override
	public List<SurveyVO> paikaverage() {
		return sqlSession.selectList("com.project.mapper.SurveyMapper.paikaverage");
	}


	@Override
	public String selectlocation(String franchisekey) {
		return sqlSession.selectOne("com.project.mapper.SurveyMapper.selectlocation", franchisekey);
	}


	@Override
	public List<OrderVO> fransalesinfo(String franchisekey) {
		return sqlSession.selectList("com.project.mapper.SurveyMapper.fransalesinfo", franchisekey);
	}


	@Override
	public List<OrderVO> piakssales() {
		return sqlSession.selectList("com.project.mapper.SurveyMapper.piakssales");
	}


	@Override
	public List<IncomeVO> theoneinfo() {
		return sqlSession.selectList("com.project.mapper.SurveyMapper.theoneinfo");
	}
	
	@Override
	public List<TempVO> frankey() {
		return sqlSession.selectList("com.project.mapper.SurveyMapper.frankey");
	}


	@Override
	public List<OrderVO> hanshinsales() {
		return sqlSession.selectList("com.project.mapper.SurveyMapper.hanshinsales");
	}


	@Override
	public List<SurveyVO> hanshinaverage() {
		return sqlSession.selectList("com.project.mapper.SurveyMapper.hanshinaverage");
	}

}
