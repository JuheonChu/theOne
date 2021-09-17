package com.project.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.vo.ProductVO;
import com.project.vo.RequestOrderVO;
import com.project.vo.TempVO;

import net.webjjang.util.PageObject;

@Repository
public class RequestOrderDAOImpl implements RequestOrderDAO {
	@Autowired
	private SqlSession sqlSession;

	@Override
	public void insertRequest(RequestOrderVO vo) {
		sqlSession.insert("com.project.mapper.requestorderMapper.insertRequestOrder", vo);
		
	}

	@Override
	public List<RequestOrderVO> selectorderList(int limit, int offset) {
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("limit", limit);
		map.put("offset", offset);
		
		
		return sqlSession.selectList("com.project.mapper.requestorderMapper.selectOrders", map);
	}
	
	

	@Override
	public int getRow(PageObject pageObject) {
		return sqlSession.selectOne("com.project.mapper.requestorderMapper.getRow");
	}

	@Override
	public ProductVO selectProductByPid(int pid) {
		return sqlSession.selectOne("com.project.mapper.requestorderMapper.selectproductBypid", pid);
	}

	@Override
	public TempVO selecttempByrid(String rid) {
		
	//	int count = 0;
		
		
		List<TempVO> list =  sqlSession.selectList("com.project.mapper.requestorderMapper.selecttempByrid", rid);
		String []  key = new String[list.size()];
		for(int i = 0; i < list.size();i++) {
			TempVO temp = list.get(i);
			return temp;
		}
		
		
		return null;
	}

	@Override
	public void updateStatus(RequestOrderVO vo) {
		sqlSession.update("com.project.mapper.requestorderMapper.updatestatus", vo);
		
	}

	@Override
	public List<RequestOrderVO> selectorderList(String franchisekey) {
		return sqlSession.selectList("com.project.mapper.requestorderMapper.selectOrdersFranchisekey", franchisekey);
	}

	@Override
	public int selectpidbyorderid(int orderid) {
		return sqlSession.selectOne("com.project.mapper.requestorderMapper.selectpidbyorerid", orderid);
	}


}
