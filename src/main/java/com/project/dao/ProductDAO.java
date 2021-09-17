package com.project.dao;

import java.util.List;

import com.project.vo.ProductVO;

import net.webjjang.util.PageObject;

public interface ProductDAO {
	
	public List<ProductVO> coffeeList();
	
	public List<ProductVO> beverageList();
	
	public List<ProductVO> dessertList();
	
	public List<ProductVO> drinkList();
	
	public List<String> coffeemenulist(String menu); //가맹주가 선택한 장사메뉴들중에서 커피타입을 뽑는거임...
	
	public List<String> beveragemenulist(String menu);
	
	public List<String> dessertmenuList(String menu);
	
	public List<String> drinkMenuList(String menu);
	///////////////////////////////////////////////////////////////////
	public List<ProductVO> coffee(List<String>obj);
	
	public List<ProductVO> beverage(List<String>obj);
	
	public List<ProductVO> dessert(List<String>obj);
	
	public List<ProductVO> drink(List<String>obj);
	
	public List<ProductVO> getProduct();
	
	public String getType(String menu, String temp);
	
	public ProductVO getProductObject(String menu, String temp);
	
	public List<Integer> selectProductIdxByMenuTemp(String menu, String temp);
	
	public List<ProductVO> getProductSelectedList(PageObject pageObject);
	
	public int getRow(PageObject pageObject); // count(*)
	
	public ProductVO getProduct(int idx);
	
	public void insertProduct(ProductVO product);
	
	public ProductVO getItemDetail(int idx);

	public ProductVO getProductObjectHanshin(String menu, String temp);
	
	//한신포차
	public ProductVO getHanshinProductObject(String menu);
	
	public List<ProductVO> selectMenu(ProductVO vo);
}
