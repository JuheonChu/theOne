package com.project.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.vo.InventoryVO;

@Repository
public class InventoryDAOImpl implements InventoryDAO{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insertInventory(InventoryVO vo) {
		sqlSession.insert("com.project.mapper.inventoryMapper.insertInventory", vo);
		
	}
	
	@Override
	public void updateInventory(InventoryVO vo) {
		sqlSession.update("com.project.mapper.inventoryMapper.updateInventory", vo);
	}

	@Override
	public void sellProduct(int count, int pid, String iuid) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("count", count);
		map.put("pid", pid);
		map.put("iuid", iuid);
		
		sqlSession.update("com.project.mapper.inventoryMapper.sellProduct", map);
	}
	
	@Override
	   public int getSoldOutInt(int idx, String franchisekey) {
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("fk_pid", idx);
		map.put("iuid", franchisekey);
	    return sqlSession.selectOne("com.project.mapper.inventoryMapper.getSoldOutInt",map);
	   }

	
}
