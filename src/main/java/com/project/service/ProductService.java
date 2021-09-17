package com.project.service;

import java.util.List;

import com.project.vo.ProductVO;

import net.webjjang.util.PageObject;

public interface ProductService {
	public List<ProductVO> coffeeList();
	
	public List<ProductVO> beverageList();
	
	public List<ProductVO> dessertList();
	
	public List<ProductVO> drinkList();
	
	public List<String> coffeemenulist(String menu); //가맹주가 선택한 장사메뉴들중에서 커피타입을 뽑는거임...
	
	public List<String> beveragemenulist(String menu);
	
	public List<String> dessertmenuList(String menu);
	
	public List<String> drinkMenuList(String menu);
////////////////////////////////////////////////////////////////////////////////////////////////////////	
	public List<ProductVO> coffee(List<String>obj);
	
	public List<ProductVO> beverage(List<String>obj);
	
	public List<ProductVO> dessert(List<String>obj);
	
	public List<ProductVO> drink(List<String>obj);
	
	public List<ProductVO> getProductList();
	
	public String getType(String menu, String temp);
	
	public List<ProductVO> getMenuList(List<String>menu, List<String>temp, PageObject pageObject);
	
	public List<ProductVO> getMenuList(List<String>menu, List<String>temp);
	
	public List<ProductVO> getMenuListHanshin(List<String>menu, List<String>temp);
	
	
	public List<ProductVO> getPageList(PageObject pageObject);
	
	public List<Integer> selectProductIdxByMenuTemp(String menu, String temp);
	
	public ProductVO selectPdt(int idx);
	
	public void insertProduct(ProductVO product);
	
	public ProductVO getItemDetail(int idx);
	
	// 한신포차
	public List<ProductVO> getHanshinMenuList(List<String> menu);
	
	public List<ProductVO> hanshinMenu(ProductVO vo);
	
	public List<ProductVO> getBestMenu(List<Integer>pidList);
}
