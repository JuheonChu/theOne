package com.jh.controller;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.project.dao.MemberDAO;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})

public class MemberDAOTest {
	@Autowired
	private MemberDAO dao;
	
	//@Test
	/*public void testInsertMember() throws Exception{
		for(int i = 0; i < 100; i++) {
			BoardVO vo = new BoardVO("Test저자"+i, "Test제목"+i, "테스트내용"+i+"하이");
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
	public void testdeleteMember() throws Exception{
		for(int i = 1; i <= 10; i++) {
			
		}
	}
	
}
