package com.project.dao;

import java.util.List;

import com.project.vo.ReviewBoardVO;

import net.webjjang.util.PageObject;

public interface ReviewBoardDAO {
	
	//1. list - 전체 데이터 구하기(페이지 처리)
	public List<ReviewBoardVO> list(PageObject pageObject);
	public int getRow(PageObject pageObject); // count(*)
	
	//2. view - 조회수 1증가
	public ReviewBoardVO view(int no);
	public void increase(int no);
	
	//3. write
	public void write(ReviewBoardVO vo);
	
	//4. update
	public void update(ReviewBoardVO vo);
	
	//5. delete
	public void delete(int no);
	
	//6. comment
	
	public void addComment(ReviewBoardVO vo);
}
