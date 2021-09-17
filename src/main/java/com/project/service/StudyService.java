package com.project.service;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.project.vo.StudyVO;

import net.webjjang.util.PageObject;

public interface StudyService {

	// 1. list
		public List<StudyVO> list(PageObject pageObject);
	// 2. write
		public void Vwrite(StudyVO vo);
	// 3.updatelist
		public List<StudyVO> Updatelist(String menu);
	// 4. update
		public void Vupdate(StudyVO vo, String menu);
	// 5. delete
		public void Vdelete(String menu);
	//6.더원교육리스트구하기
		public List<StudyVO> flist(PageObject pageObject);	
	// 7.상세보기
		public List<StudyVO> flist(String menu);
	// 8.다운로드 
		public void fdownload(String filename, HttpServletRequest request, HttpServletResponse response) throws IOException;
		
	
}
