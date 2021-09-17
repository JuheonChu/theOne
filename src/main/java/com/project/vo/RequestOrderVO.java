package com.project.vo;

import lombok.Data;

@Data
public class RequestOrderVO {
	private int req_orderid;
	private String rid; //최종승인된 가맹점 franchisekey 를참조하는 fk
	private int pid;// 몇번 상품 참조하는지 product 테이블 참조하는 fk
	private int reqCount;
	private String status;
	private int available; //누구한테 어떻게보여줄지 
	private String time;
}
