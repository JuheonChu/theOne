package com.project.dao;

import java.util.List;

import com.project.vo.ProductVO;
import com.project.vo.RequestOrderVO;
import com.project.vo.TempVO;

import net.webjjang.util.PageObject;

public interface RequestOrderDAO {
	public void insertRequest(RequestOrderVO vo);
	
	public List<RequestOrderVO> selectorderList(int limit, int offset);
	
	public int getRow(PageObject pageObject);
	
	public ProductVO selectProductByPid(int pid);
	
	public TempVO selecttempByrid(String rid);
	
	public void updateStatus(RequestOrderVO vo);
	
	public List<RequestOrderVO> selectorderList(String franchisekey);
	
	public int selectpidbyorderid(int orderid);
}
