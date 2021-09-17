package com.project.vo;

import lombok.Data;

@Data
public class OrderVO {
	private int oid;
	private String franchisekey;
	private String id;
	private String name;
	private String address;
	private String detailaddress;
	private String phone;
	private String brand;
	private String type;
	private String menu;
	private String temp;
	private int price;
	private int count;
	private int sumPrice;
	private String image;
	private int available;
	private String time;
	
	private int pid;
}
