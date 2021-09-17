package com.project.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.vo.OrderVO;
import com.project.vo.ProductVO;

import net.webjjang.util.PageObject;

@Repository
public class OrderDAOImpl implements OrderDAO {
	
	@Autowired
	SqlSession sqlSession;

	@Override
	public void addBasket(OrderVO orderVO) {
		
		sqlSession.insert("com.project.mapper.OrderMapper.addBasket", orderVO);
	}

	@Override
	public List<OrderVO> getBasket(String id) {
		Map<String, String> map = new HashMap<String ,String>();
		map.put("id", id);
		
		return sqlSession.selectList("com.project.mapper.OrderMapper.getBasket", map);
	}

	@Override
	public void DeleteBasket(int oid) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("oid", oid);
		
		sqlSession.delete("com.project.mapper.OrderMapper.deleteBasket", map);
	}

	@Override
	public void Buy(String id) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("id", id);
		
		sqlSession.update("com.project.mapper.OrderMapper.buy", map);
	}

	@Override
	public void nullBuy(OrderVO orderVO) {
		sqlSession.insert("com.project.mapper.OrderMapper.nullBuy", orderVO);
	}

	@Override
	public List<Integer> getPidList(String id) {
		return sqlSession.selectList("com.project.mapper.OrderMapper.selectPidList", id);
	}

	@Override
	public List<Integer> getCountList(String id) {
		return sqlSession.selectList("com.project.mapper.OrderMapper.selectCountList", id);
	}

	@Override
	public void updateInventoryCount(String iuid, int pid) {
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("iuid", iuid); //franchisekey
		map.put("fk_pid", pid);//product idx
		sqlSession.update("com.project.mapper.OrderMapper.updateQuantity",map);
		
	}
	
	@Override
	   public List<OrderVO> getBuyBasket(String id) {
	      // TODO Auto-generated method stub
	      return sqlSession.selectList("com.project.mapper.OrderMapper.getBuyBasket", id);
	   }

}
