package com.project.vo;

import java.io.Serializable;
import java.sql.Date;
import java.util.Arrays;

import org.springframework.web.multipart.MultipartFile;


public class BoardVO implements Serializable{
	private int bno;
	private String title;
	private String content;
	private String writer;
	private Date date;
	private int hitcount;
	private int ref;
	private int step;
	private int level;
	private MultipartFile [] multiparts; // 
	private String file;
	
	public BoardVO() {}
	
	
	public BoardVO(int bno, String title, String content, String writer, Date date, int hitcount, int ref, int step,
			int level, MultipartFile[] multiparts, String file) {
		super();
		this.bno = bno;
		this.title = title;
		this.content = content;
		this.writer = writer;
		this.date = date;
		this.hitcount = hitcount;
		this.ref = ref;
		this.step = step;
		this.level = level;
		this.multiparts = multiparts;
		this.file = file;
	}
	
	public MultipartFile[] getMultiparts() {
		return multiparts;
	}




	public void setMultiparts(MultipartFile[] multiparts) {
		this.multiparts = multiparts;
	}



	public String getFile() {
		return file;
	}



	public void setFile(String file) {
		this.file = file;
	}





	@Override
	public String toString() {
		return "BoardVO [bno=" + bno + ", title=" + title + ", content=" + content + ", writer=" + writer + ", date="
				+ date + ", hitcount=" + hitcount + ", ref=" + ref + ", step=" + step + ", level=" + level
				+ ", multiparts=" + Arrays.toString(multiparts) + ", file=" + file+ "]";
	}






	public int getBno() {
		return bno;
	}

	public void setBno(int bno) {
		this.bno = bno;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public int getHitcount() {
		return hitcount;
	}

	public void setHitcount(int hitcount) {
		this.hitcount = hitcount;
	}

	public int getRef() {
		return ref;
	}

	public void setRef(int ref) {
		this.ref = ref;
	}

	public int getStep() {
		return step;
	}

	public void setStep(int step) {
		this.step = step;
	}

	public int getLevel() {
		return level;
	}

	public void setLevel(int level) {
		this.level = level;
	}


}
