package com.project.service;


import java.util.List;

import com.project.vo.OrderVO;

public interface OrderService {
	
	public void addBasket(OrderVO orderVO);
	
	public List<OrderVO> getBasket(String id);
	
	public void DeleteBasket(int oid);
	
	public void Buy(String id);
	
	public void nullBuy(OrderVO orderVO);
	
	public List<Integer> getPidList(String id);
	
	public List<Integer> getCountList(String id);
	
	public void updateInventory(String iuid, int pid);
	
	public List<OrderVO> getBuyBasket(String id);
}
