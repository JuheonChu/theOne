package com.project.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class MemberVO {
	private int idx;
	private String id;
	private String password;
	private String email;

	private String phone;
	
	private String postcode;
	private String address;
	private String detailaddress;
	private String name;

	private String brand;
	private String tier;
	private String filename;
	private String url;
	
	private String franchisekey;
	private String selectmenu;
	
	private String rest;
	private String rest_id;
	


	private MultipartFile multipart; // 빤딱이 하나설정
	
	
	
	
}
