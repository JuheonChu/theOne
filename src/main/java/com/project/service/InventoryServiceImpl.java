package com.project.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.dao.InventoryDAO;
import com.project.vo.InventoryVO;
import com.project.vo.ProductVO;

@Service
public class InventoryServiceImpl implements InventoryService {

	@Autowired
	InventoryDAO dao;
	
	@Override
	public void insertInventory(InventoryVO vo) {
		dao.insertInventory(vo);

	}

	@Override
	public void updateInventory(InventoryVO vo) {
		dao.updateInventory(vo);
		
	}

	@Override
	public void sellProduct(List<Integer> count, List<Integer> pid, String iuid) {
		//List<Integer> countList = new ArrayList<Integer>();
		//List<Integer> pidList = new ArrayList<Integer>();
		for(int i = 0; i < count.size(); i++) {
			dao.sellProduct(count.get(i), pid.get(i), iuid);
		}
		
	}

	@Override
	public void nullSellProduct(int count, int pid, String iuid) {
		dao.sellProduct(count, pid, iuid);
	}
	
	
	@Override
	   public int getSoldOutInt(int idx, String franchisekey) {
	      return dao.getSoldOutInt(idx, franchisekey);
	   }

	/*
	 * List<ProductVO> list = new ArrayList<ProductVO>();
	 * 
	 * for (int i = 0; i < menu.size(); i++) { ProductVO Product =
	 * dao.getProductObject(menu.get(i), temp.get(i)); list.add(Product); }
	 * 
	 * pageObject.setTotalRow(dao.getRow(pageObject));
	 */
}
