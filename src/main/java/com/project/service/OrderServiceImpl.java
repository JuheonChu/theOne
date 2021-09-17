package com.project.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.project.dao.OrderDAO;
import com.project.vo.OrderVO;
import com.project.vo.ProductVO;

import lombok.AllArgsConstructor;
import net.webjjang.util.PageObject;

@Service
@Qualifier("productServiceImpl")
@AllArgsConstructor
public class OrderServiceImpl implements OrderService {

	@Autowired
	private OrderDAO dao;
	
	@Override
	public void addBasket(OrderVO orderVO) {
		
		dao.addBasket(orderVO);
	}

	@Override
	public List<OrderVO> getBasket(String id) {
		return dao.getBasket(id);
	}

	@Override
	public void DeleteBasket(int oid) {
		dao.DeleteBasket(oid);
	}

	@Override
	public void Buy(String id) {
		dao.Buy(id);
	}

	@Override
	public void nullBuy(OrderVO orderVO) {
		dao.nullBuy(orderVO);
	}

	@Override
	public List<Integer> getPidList(String id) {
		return dao.getPidList(id);
	}

	@Override
	public List<Integer> getCountList(String id) {
		// TODO Auto-generated method stub
		return dao.getCountList(id);
	}

	@Override
	public void updateInventory(String iuid, int pid) {
		dao.updateInventoryCount(iuid, pid);
		
	}
	
	@Override
	   public List<OrderVO> getBuyBasket(String id) {
	      return dao.getBuyBasket(id);
	   }

}
