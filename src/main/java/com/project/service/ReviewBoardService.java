package com.project.service;

import java.util.List;

import com.project.vo.ReviewBoardVO;

import net.webjjang.util.PageObject;

public interface ReviewBoardService {
	
	// 1. list
	public List<ReviewBoardVO> list(PageObject pageObject);
	
	// 2. view
	public ReviewBoardVO view(int no, int inc);
	
	// 3. write
	public void write(ReviewBoardVO vo);
	
	// 4. update
	public void update(ReviewBoardVO vo);
	
	// 5. delete
	public void delete(int no);
	
	// 6. comment
	public void addComment(ReviewBoardVO vo);
}
