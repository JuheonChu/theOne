package com.project.service;

import java.util.List;

import com.project.vo.ProductVO;
import com.project.vo.RequestOrderVO;
import com.project.vo.TempVO;

public interface RequestOrderService {

	public void insertOrder(RequestOrderVO vo);
	
	//public void moneyTransfer(int quantityOrder, int inventoryQty, int quantity);
	public List<RequestOrderVO> getOrderList(int limit, int offset);
	
	public ProductVO getProductByPid(int pid);
	
	public TempVO getTempByRid(String rid);
	
	public void updateStatus(RequestOrderVO vo);
	
	public List<RequestOrderVO> getOrderList(String franchisekey);
	
	public int selectpidbyorderid(int orderid);
}
