package com.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.project.dao.ReviewBoardDAO;
import com.project.vo.ReviewBoardVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import net.webjjang.util.PageObject;

@Service
@Log4j
@Qualifier("reviewBoardServiceImpl")
@AllArgsConstructor // 생성자를 이용한 모든 속성을 자동 DI 시킨다.
public class ReviewBoardServiceImpl implements ReviewBoardService {

	// @AllArgsConstructor를 이용해서 자동 DI 된다.
	private ReviewBoardDAO reviewBoardDAO;
	
	@Override
	public List<ReviewBoardVO> list(PageObject pageObject) {
		log.info("service.list()...");
		
		// getRow() 메서드를 이용해서 전체 데이터를 셋팅하면 계산이 되어진다.
		pageObject.setTotalRow(reviewBoardDAO.getRow(pageObject));
		
		return reviewBoardDAO.list(pageObject);
	}

	@Override
	public ReviewBoardVO view(int no, int inc) {
		
		if(inc==1) reviewBoardDAO.increase(no);
		
		log.info(no);
		log.info(inc);
		
		return reviewBoardDAO.view(no);
	}

	@Override
	public void write(ReviewBoardVO vo) {
		reviewBoardDAO.write(vo);
	}

	@Override
	public void update(ReviewBoardVO vo) {
		reviewBoardDAO.update(vo);
	}

	@Override
	public void delete(int no) {
		reviewBoardDAO.delete(no);
	}

	@Override
	public void addComment(ReviewBoardVO vo) {
		reviewBoardDAO.addComment(vo);
	}

}
