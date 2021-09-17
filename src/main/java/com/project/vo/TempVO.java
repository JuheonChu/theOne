package com.project.vo;

import lombok.Data;

@Data
public class TempVO {
	private int contractno;
	private String startup_field;
	private String brand;
	private String location;
	private String name;
	private String phone;
	private String email;
	private String consent;
	private int membershipfee;
	private int membershipmaintenance;
	private String selectmenu;
	private String address;
	private String detailaddress;
	private String postcode;
	private String latitude;
	private String longitude;
	private String franchisekey;
	private String date;
	private String url; //그사람의 가맹주소 url
	private String status;
	private String mapservice;
	private int mapservicefee;
	
	private int member_index; //외래키 참조용
}
