package com.project.vo;

import lombok.Data;

@Data
public class ReviewBoardVO {
	private int no;
	private String title;
	private String content;
	private String writer;
	private String writeDate;
	private int hit;
	private int available;
	private String fileName;
	private int ref;
	private int indent;
	private int step;
	
}
