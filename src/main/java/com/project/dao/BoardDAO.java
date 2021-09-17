package com.project.dao;

import java.util.List;

import com.project.vo.BoardVO;

public interface BoardDAO {
	
	public void write(BoardVO vo);
	
	//List<BoardVO> selectList();//게시글 보기

	public List<BoardVO> selectList();
	
	public List<BoardVO> selectAll2(int size, int offset);
	
	public void deleteBoard(int bno);
	
	public void updateBoardWOFile(BoardVO vo);
	
	public void updateBoardWithFile(BoardVO vo);
	
	public void increaseViewCount(int bno);
	
	public BoardVO read(int bno);

	int getMaxBno(BoardVO vo);
	
	int getParentBoardRef(BoardVO vo);
	
	public void addComment(BoardVO vo);
	
	public String getImgFileByWriter(String writer, int bno);
	
	
}
