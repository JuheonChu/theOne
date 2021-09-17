package com.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.dao.RequestOrderDAO;
import com.project.vo.ProductVO;
import com.project.vo.RequestOrderVO;
import com.project.vo.TempVO;

import net.webjjang.util.PageObject;

@Service
public class RequestOrderServiceImpl implements RequestOrderService{
	
	@Autowired
	private RequestOrderDAO dao;

	@Override
	public void insertOrder(RequestOrderVO vo) {
		dao.insertRequest(vo);
		
	}

	@Override
	public List<RequestOrderVO> getOrderList(int limit, int offset) {
		return dao.selectorderList(limit, offset); 
	}

	@Override
	public ProductVO getProductByPid(int pid) {
		return dao.selectProductByPid(pid);
	}

	@Override
	public TempVO getTempByRid(String rid) {
		return dao.selecttempByrid(rid);
	}

	@Override
	public void updateStatus(RequestOrderVO vo) {
		dao.updateStatus(vo);
		
	}

	@Override
	public List<RequestOrderVO> getOrderList(String franchisekey) {
		return dao.selectorderList(franchisekey);
	}

	@Override
	public int selectpidbyorderid(int orderid) {
		return dao.selectpidbyorderid(orderid);
	}
	
	////@Transactional
	//@Override
	/*public void moneyTransfer(int orderQty, int inventoryQty, int quantity) throws Exception{
		//@Transactional Annotation을붙인 메서드는 throw Exception 해줘야함
		int result1 = dao.insertRequest(from);//몇개의 컬럼이 영향받았습니까...
		
		int result2 = dao.moneyIn(to, money);//몇개의 컬럼이 영향이받았나
		
		if(result1 == 0 || result2 == 0) {
			throw new RuntimeException(); 
		}*/

	//}

}
