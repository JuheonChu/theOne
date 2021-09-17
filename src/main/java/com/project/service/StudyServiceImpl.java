package com.project.service;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.project.dao.StudyDAO;
import com.project.vo.StudyVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import net.webjjang.util.PageObject;

@Service
@Log4j
@Qualifier("studyServiceImpl")
@AllArgsConstructor // 생성자를 이용한 모든 속성을 자동 DI 시킨다.

public class StudyServiceImpl implements StudyService {
	
	// @AllArgsConstructor를 이용해서 자동 DI 된다.
	private StudyDAO StudyDAO;

	@Override
	public List<StudyVO> list(PageObject pageObject) {
		log.info("service.list()...");
		
		// getRow() 메서드를 이용해서 전체 데이터를 셋팅하면 계산이 되어진다.
		pageObject.setTotalRow(StudyDAO.getRow(pageObject));
		
		return StudyDAO.list(pageObject);
	}

	@Override
	public void Vwrite(StudyVO vo) {
		StudyDAO.Vwrite(vo);
	}

	@Override
	public List<StudyVO> Updatelist(String menu) {
		return StudyDAO.Updatelist(menu);
	 
	}

	@Override
	public void Vupdate(StudyVO vo, String menu) {
		StudyDAO.Vupdate(vo, menu);
	}

	@Override
	public void Vdelete(String menu) {
		StudyDAO.Vdelete(menu);
	}

	@Override
	public List<StudyVO> flist(String menu) {
		 return  StudyDAO.fcontent(menu);	
	}

	@Override
	public List<StudyVO> flist(PageObject pageObject) {
		log.info("service.list()...");
		
		// getRow() 메서드를 이용해서 전체 데이터를 셋팅하면 계산이 되어진다.
		pageObject.setTotalRow(StudyDAO.getRow(pageObject));
		
		return StudyDAO.flist(pageObject);
	}

	@Override
	public void fdownload(String filename, HttpServletRequest request, HttpServletResponse response) throws IOException {
		String fileName = filename;
		String realFolder= request.getServletContext().getRealPath("/resources/data");
		System.out.println("경로 : "+realFolder);
		File file = new File(realFolder, fileName);
		try {
			fileName="attachment;fileName="+new String(URLEncoder.encode(fileName,"UTF-8")).replaceAll("\\+", " ");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		response.setHeader("Content-Dispositon",fileName);
		response.setHeader("Content-Length",String.valueOf(file.length()));

		BufferedInputStream bis = new BufferedInputStream(new FileInputStream(file));
		BufferedOutputStream bos = new BufferedOutputStream(response.getOutputStream());

		byte [] b = new byte[(int)file.length()];
		bis.read(b, 0, b.length);
		bos.write(b);
		bis.close();
		bos.close();
		
	}
}



