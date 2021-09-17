package com.project.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.project.dao.ProductDAO;
import com.project.vo.ProductVO;

import lombok.AllArgsConstructor;
import net.webjjang.util.PageObject;

@Service
@Qualifier("productServiceImpl")
@AllArgsConstructor
public class ProductServiceImpl implements ProductService {

	@Autowired
	private ProductDAO dao;
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<ProductVO> coffeeList() {

		return dao.coffeeList();
	}

	@Override
	public List<ProductVO> beverageList() {
		return dao.beverageList();
	}

	@Override
	public List<ProductVO> dessertList() {
		return dao.dessertList();
	}

	@Override
	public List<ProductVO> drinkList() {
		return dao.drinkList();
	}

	@Override
	public List<String> coffeemenulist(String menu) {
		return dao.coffeemenulist(menu);
	}

	@Override
	public List<String> beveragemenulist(String menu) {
		return dao.beveragemenulist(menu);
	}

	@Override
	public List<String> dessertmenuList(String menu) {
		return dao.dessertmenuList(menu);
	}

	@Override
	public List<String> drinkMenuList(String menu) {
		return dao.drinkMenuList(menu);
	}

	@Override
	public List<ProductVO> coffee(List<String> obj) {
		return dao.coffee(obj);
	}

	@Override
	public List<ProductVO> beverage(List<String> obj) {

		return dao.beverage(obj);
	}

	@Override
	public List<ProductVO> dessert(List<String> obj) {
		return dao.dessert(obj);
	}

	@Override
	public List<ProductVO> drink(List<String> obj) {
		return dao.drink(obj);
	}

	@Override
	public List<ProductVO> getProductList() {
		return dao.getProduct();
	}

	@Override
	public String getType(String menu, String temp) {
		return dao.getType(menu, temp);
	}

	@Override
	public List<ProductVO> getMenuList(List<String> menu, List<String> temp, PageObject pageObject) {
		List<ProductVO> list = new ArrayList<ProductVO>();

		for (int i = 0; i < menu.size(); i++) {
			ProductVO Product = dao.getProductObject(menu.get(i), temp.get(i));
			list.add(Product);
		}
		
		pageObject.setTotalRow(dao.getRow(pageObject));
		
		return list;
	}
	
	@Override
	public List<ProductVO> getHanshinMenuList(List<String> menu) {
		List<ProductVO> list = new ArrayList<ProductVO>();

		for (int i = 0; i < menu.size(); i++) {
			ProductVO Product = dao.getHanshinProductObject(menu.get(i));
			list.add(Product);
		}
		
		return list;
	}

	@Override
	public List<ProductVO> getPageList(PageObject pageObject) {
		pageObject.setTotalRow(dao.getRow(pageObject));
		return dao.getProductSelectedList(pageObject);
	}

	@Override
	public List<Integer> selectProductIdxByMenuTemp(String menu, String temp) {
		return dao.selectProductIdxByMenuTemp(menu, temp);
	}

	@Override
	public List<ProductVO> getMenuList(List<String> menu, List<String> temp) {
		List<ProductVO> list = new ArrayList<ProductVO>();

		for (int i = 0; i < menu.size(); i++) {
			ProductVO Product = dao.getProductObject(menu.get(i), temp.get(i));
			list.add(Product);
		}
		
		//pageObject.setTotalRow(dao.getRow(pageObject));
		
		return list;
	}

	@Override
	public ProductVO selectPdt(int idx) {
		return dao.getProduct(idx);
	}

	@Override
	public void insertProduct(ProductVO product) {
		dao.insertProduct(product);
		
	}
	
	@Override
	public ProductVO getItemDetail(int idx) {
		
		return dao.getItemDetail(idx);
	}
	
	@Override
	public List<ProductVO> getMenuListHanshin(List<String> menu, List<String> temp) {
		List<ProductVO> list = new ArrayList<ProductVO>();

		for (int i = 0; i < menu.size(); i++) {
			ProductVO Product = dao.getProductObjectHanshin(menu.get(i), temp.get(i));
			list.add(Product);
		}
		
		//pageObject.setTotalRow(dao.getRow(pageObject));
		
		return list;
	}

	// 한신포차
	
	@Override
	public List<ProductVO> hanshinMenu(ProductVO vo) {
		return dao.selectMenu(vo);
	}

	@Override
	public List<ProductVO> getBestMenu(List<Integer> pidList) {
		List<ProductVO>bestmenu = new ArrayList<ProductVO>();
	
		for(int i = 0 ; i < pidList.size();i++) {
			
			if(pidList.get(i) != 0) {
				ProductVO product = dao.getProduct(pidList.get(i));
				bestmenu.add(product);
			}
			
		}
		return bestmenu;
	}

}
