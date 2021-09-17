package com.project.service;

import java.util.List;

import com.project.vo.InventoryVO;

public interface InventoryService {

	public void insertInventory(InventoryVO vo);
	
	public void updateInventory(InventoryVO vo);
	
	public void sellProduct(List<Integer> count, List<Integer> pidList, String iuid);
	
	public void nullSellProduct(int count, int pid, String iuid);
	
	public int getSoldOutInt(int idx, String franchisekey);
	
}
