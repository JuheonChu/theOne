package com.project.dao;

import java.util.List;

import com.project.vo.InventoryVO;

public interface InventoryDAO {
	public void insertInventory(InventoryVO vo);
	
	public void updateInventory(InventoryVO vo);
	
	public void sellProduct(int count, int pid, String iuid);
	
	public int getSoldOutInt(int idx, String franchisekey);
}
