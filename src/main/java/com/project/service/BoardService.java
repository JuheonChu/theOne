package com.project.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import com.project.vo.BoardVO;

public interface BoardService {
	public void writeAction(BoardVO vo);
	
	//List<BoardVO> selectAll();

	public List<BoardVO> selectList();
	
	public List<BoardVO> selectAll2(int size, int offset);
	
	public void deleteBoardAction(int bno);
	
	/*게시판 수정*/
	public void updateBoardActionWOFile(BoardVO vo);
	
	/*게시판 수정*/
	public void updateBoardActionWithFile(BoardVO vo);
	
	/*조회수증가*/
	public void increaseViewCountAction(int bno);
	
	/*게시판 상세보기*/
	public BoardVO readAction(int bno);
	
	public int getBno(BoardVO vo);
	
	public void addComment(BoardVO vo);
	
	public String getImgName(String writer, int bno);
}
