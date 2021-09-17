package com.project.service;

import java.util.List;


import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.dao.BoardDAO;
import com.project.vo.BoardVO;

@Service
public class BoardServiceImpl implements BoardService{
	
	@Autowired
	private BoardDAO dao;
	
	public BoardServiceImpl() {}
	
	public BoardServiceImpl(BoardDAO dao) {
		this.dao = dao;
	}
	
	public void writeAction(BoardVO vo) {
		
		dao.write(vo);
	}

	@Override
	public List<BoardVO> selectList(){
		if(dao.selectList()==null || dao.selectList().equals("")) {
			System.out.println("가배열 null이에요");
		}
		else { 
			List<BoardVO> list = dao.selectList();
			
			return list;
		}
		List<BoardVO> list = dao.selectList();
		System.out.println(list);
		return null;
	}

	@Override
	public List<BoardVO> selectAll2(int size, int offset) {
		return dao.selectAll2(size, offset);
	}

	@Override
	public void deleteBoardAction(int bno) {
		dao.deleteBoard(bno);
		
	}

	@Override
	public void updateBoardActionWOFile(BoardVO vo) {
		dao.updateBoardWOFile(vo);
		
	}
	
	@Override
	public void updateBoardActionWithFile(BoardVO vo) {
		dao.updateBoardWithFile(vo);
		
	}

	@Override
	public void increaseViewCountAction(int bno) {
		dao.increaseViewCount(bno);	
	}

	@Override
	public BoardVO readAction(int bno) {
		return dao.read(bno);
		
	}

	@Override
	public int getBno(BoardVO vo) {
		return dao.getMaxBno(vo);
	}

	@Override
	public void addComment(BoardVO vo) {
		dao.addComment(vo);
		
	}

	@Override
	public String getImgName(String writer, int bno) {
		return dao.getImgFileByWriter(writer, bno);
	}
}
