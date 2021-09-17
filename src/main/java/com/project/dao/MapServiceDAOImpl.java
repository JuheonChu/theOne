package com.project.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.vo.MapServiceVO;

@Repository
public class MapServiceDAOImpl implements MapServiceDAO {

	@Autowired
	private SqlSession sqlSession;
	@Override
	public List<MapServiceVO> getMarkerInfoList() {
		return sqlSession.selectList("com.project.mapper.mapserviceMapper.selectlocationList"); 
	}

}
