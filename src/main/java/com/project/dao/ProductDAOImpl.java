package com.project.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.vo.ProductVO;

import net.webjjang.util.PageObject;

@Repository
public class ProductDAOImpl implements ProductDAO {
	
	@Autowired
	SqlSession sqlSession;

	@Override
	public List<ProductVO> coffeeList() {
		return sqlSession.selectList("com.project.mapper.ProductMapper.coffeeList");
	}

	@Override
	public List<ProductVO> beverageList() {
		return sqlSession.selectList("com.project.mapper.ProductMapper.beverageList");
	}

	@Override
	public List<ProductVO> dessertList() {
		return sqlSession.selectList("com.project.mapper.ProductMapper.dessertList");
	}

	@Override
	public List<ProductVO> drinkList() {
		return sqlSession.selectList("com.project.mapper.ProductMapper.drinkList");
	}

	@Override
	public List<String> coffeemenulist(String menu) {
		return sqlSession.selectList("com.project.mapper.ProductMapper.coffeemenulist", menu);
	}

	@Override
	public List<String> beveragemenulist(String menu) {
		return sqlSession.selectList("com.project.mapper.ProductMapper.beveragemenulist", menu);
	}

	@Override
	public List<String> dessertmenuList(String menu) {
		// TODO Auto-generated method stub
		return  sqlSession.selectList("com.project.mapper.ProductMapper.dessertmenulist", menu);
	}

	@Override
	public List<String> drinkMenuList(String menu) {
		return  sqlSession.selectList("com.project.mapper.ProductMapper.drinkmenulist", menu);
	}

	@Override
	public List<ProductVO> coffee(List<String> obj) {
		return sqlSession.selectList("com.project.mapper.ProductMapper.coffee", obj);
	}

	@Override
	public List<ProductVO> beverage(List<String> obj) {
		return sqlSession.selectList("com.project.mapper.ProductMapper.beverage", obj);
	}

	@Override
	public List<ProductVO> dessert(List<String> obj) {
		return sqlSession.selectList("com.project.mapper.ProductMapper.dessert", obj);
	}

	@Override
	public List<ProductVO> drink(List<String> obj) {
		return sqlSession.selectList("com.project.mapper.ProductMapper.drink", obj);
	}

	@Override
	public List<ProductVO> getProduct() {
		return sqlSession.selectList("com.project.mapper.ProductMapper.selectProductlist");
	}

	@Override
	public String getType(String menu, String temp) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("menu", menu);
		map.put("temp", temp);
		return sqlSession.selectOne("com.project.mapper.ProductMapper.selectType", map);
	}

	@Override
	public ProductVO getProductObject(String menu, String temp) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("menu", menu);
		map.put("temp", temp);
		return sqlSession.selectOne("com.project.mapper.ProductMapper.getObjectbyMenuandTemp",map);
	}
	
	@Override
	public List<ProductVO> getProductSelectedList(PageObject pageObject) {
		HashMap<String,Object>map = new HashMap<String,Object>();
		map.put("startRow", pageObject.getStartRow());
		map.put("endRow", pageObject.getEndRow());
		map.put("key", pageObject.getKey());
		map.put("word", pageObject.getWord());
		
		return sqlSession.selectList("com.project.mapper.ProductMapper.selectPdtList", map);
	}
	
	@Override
	public int getRow(PageObject pageObject) {
		
		return sqlSession.selectOne("com.project.mapper.ProductMapper.getRow");
	}

	@Override
	public List<Integer> selectProductIdxByMenuTemp(String menu, String temp) {
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("menu", menu);
		map.put("temp", temp);
		
		return sqlSession.selectList("com.project.mapper.ProductMapper.selectProductIdx", map);
	}

	@Override
	public ProductVO getProduct(int idx) {
		return sqlSession.selectOne("com.project.mapper.ProductMapper.selectPdt", idx);
	}

	@Override
	public void insertProduct(ProductVO product) {
		sqlSession.insert("com.project.mapper.ProductMapper.insertProduct", product);
		
	}
	
	@Override
	public ProductVO getItemDetail(int idx) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("idx", idx);
		
		return sqlSession.selectOne("com.project.mapper.ProductMapper.getItemDetail", map);
	}
	
	@Override
	public ProductVO getProductObjectHanshin(String menu, String temp) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("menu", menu);
		map.put("temp", temp);
		return sqlSession.selectOne("com.project.mapper.ProductMapper.getObjectbyMenuandTempHanshin",map);
	}

	@Override
	public List<ProductVO> selectMenu(ProductVO vo) {
		return sqlSession.selectList("com.project.mapper.ProductMapper.hanshinMenu", vo);
	}

	@Override
	public ProductVO getHanshinProductObject(String menu) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("menu", menu);
		
		return sqlSession.selectOne("com.project.mapper.ProductMapper.getHanshinObjectbyMenuandTemp", map);
	}

}
