package com.jh.controller;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.project.dao.BoardDAO;
import com.project.vo.BoardVO;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})

public class BoardDAOTest {
	@Autowired
	private BoardDAO dao;
	
	/*@Test
	public void testInsertMember() throws Exception{
		for(int i = 0; i < 100; i++) {
			BoardVO vo = new BoardVO();
			vo.setTitle("테스트제목"+i);
			vo.setContent("테스트내용"+i);
			vo.setWriter("Alcantara");
			dao.write(vo);
		}
		
	}*/
/*	@Test
	public void testselectList(){
		List<BoardVO> blist=  dao.selectList();
		
		for(int i = 0; i < blist.size();i++) {
			System.out.println(blist.get(i).getTitle());
		}
	}*/
	
	@Test
	public void testgettingList() throws Exception{
		//String filename = dao.getImgFileByWriter("Alcantara");
		//System.out.println("file명: " + filename);
		List<BoardVO>boardList = dao.selectAll2(10, 0);
		
		System.out.println(boardList);
	}
	
}
