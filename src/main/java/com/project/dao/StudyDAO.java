package com.project.dao;

import java.util.List;

import com.project.vo.StudyVO;

import net.webjjang.util.PageObject;

public interface StudyDAO {

	//1. list - 전체 데이터 구하기(페이지 처리)
	public List<StudyVO> list(PageObject pageObject);
	public int getRow(PageObject pageObject); // count(*)
	
	//2. write
	public void Vwrite(StudyVO vo);
	
	//3.updatelist
	public List<StudyVO> Updatelist(String menu);
	
	//4.update
	public void Vupdate(StudyVO vo, String menu);

	//5.delete
	public void Vdelete(String menu);
	
	//6.더원교육리스트구하기
	public List<StudyVO> flist(PageObject pageObject);
	
	//7.상세보기
	public List<StudyVO> fcontent(String menu);
	
}